# CloudKitExtras

CloudKitExtras is a set of utilities to use alongside 🍎 CloudKit. It provider APIs to interact with the database and protocol to simplify forming CloudKit compatible models.

## Query

`Query` is a `struct` which is designed to help you express your CloudKit queries in a simpler manner. It is equipped with methods to build the query you want. For example:
```swift
let query = Query<Post>()
    .filter(.author, equals: user)
    .filter(.topics, anyIn: topics)
    .sorted(by: .createdAt, ascending: false)
    .debug()
```
will be translated into a `CKQuery` which filters the records to only include posts with given author and only those that have given topics, sorted from newest. The debug makes it so that when executing the Query, its description, alongside the result, will be printed out for you to explore.

## CKDecodable

```swift
public protocol CKDecodable {
    associatedtype Fields: RecordFields
    init(record: CKRecord) throws
}
```
CKDecodable is a protocol defining the neccesities to easily decode `CKRecord`s into your types. 

*When using the `@CKDecodable` or `@CKCodable` macro, both the `Fields` enum and `init(record: CKRecord) throws` are generated automatically.*

## CKEncodable

```swift
public protocol CKEncodable {
    associatedtype Fields: RecordFields
    static var RecordType: String { get }
    func value(for field: Fields) -> CKRecordValueProtocol?
}
```

CKDecodable is a protocol defining the neccesities to easily encode your types to `CKRecord`s. You need to provide the `RecordType`, which is simply a String name of your Record type defined in yout CloudKit dashboard. 

*When using the `@CKEncodable` or `@CKCodable` macro, `Fields` enum and `func value(for field: Fields) -> CKRecordValueProtocol?` are generated automatically.*

## RecordFields
```swift
public protocol RecordFields: CaseIterable, RawRepresentable where RawValue == String {}
```
Simple protocol requiring the type to be CaseIterable and String RawRepresentable. This is used to identified the available fields both when encoding/decoding as well as building Queries and specifying which fields to retrieve.

When using the retrieve APIs with a Query, the Fields enum will be used to specify which fields to retrieve, so that if you have a type which only needs a subset of the record (such as only the name and image resource from a larger profile), the `desiredKeys` field on the `func records(matching:inZoneWith:desiredKeys:resultsLimit)` method will be populated with the fields.

## Examples
We can define a simple Post type:
```swift
struct Post {
    let author: CKRecord.Reference
    let text: String
    let createdAt: Date
}
```
and conform it to CKCodable like this:
```swift
extension Post: CKCodable {
    static let RecordType = "Post" //Here we define the Record type for CloudKit

    init(record: CKRecord) throws {
        self.author = try Self.extract(.author, from: record) // we use the provided extract method on CKDecodable which takes the field and retreives it from the provided CKRecord.
        self.text = try Self.extract(.text, from: record)
        self.createdAt = try Self.extract(.createdAt, from: record)
    }

    func value(for field: Fields) -> CKRecordValueProtocol? {
        // we simply switch over the field and assign the correct value to the record. This method is used internally when encoding types into CKRecord. This method helps with type safety so that we are forced to handle any new field we add to the Fields enum.
        switch field {
        case .author:
            return self.author
        case .text:
            return self.text
        case .createdAt:
            return self.createdAt
        }
    }

    enum Fields: String, RecordFields {
        case author, text, createdAt
    }
}
```
This is not a huge load of code, but can get very repetitive when used. But luckily, all this code depends only on the properties the struct has. Therefore, we can very easily automate the process using macros. We can use one of the `CKCodable`, `CKEncodable` and `CKDecodable` macros to generate everything apart the RecordType String. The RecordType is still left to the author, because it does not always make sense to make the RecordType the same as the name of the Struct and could easily lead to issues. When used with the `CKCodable` macro, the code would be simplified to the following:
```swift
@CKCodable
struct Post {
    static let RecordType = "Post"
    let author: CKRecord.Reference
    let text: String
    let createdAt: Date
}
```

When retrieving data from CloudKit, we can build our `Query`:
```swift
let query = Query<Post>()
    .filter(.author, equals: user)
    .sorted(by: .createdAt, ascending: false)
```

and then use it to query our data:
```swift
let posts = try await CKContainer
    .default()
    .publicCloudDatabase
    .perform(query) 
//the result here is (models: [(id: CKRecord.ID, result: Result<Post, Error>)], cursor: CKQueryOperation.Cursor?)
```
