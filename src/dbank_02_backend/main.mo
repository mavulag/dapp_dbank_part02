// actor {
//   public query func greet(name : Text) : async Text {
//     return "Hello, " # name # "!";
//   };
// };

// actor {
//   public query func greet(name : Text) : async Text {
//     return "Hello, " # name # "!";
//   };
// };

// 1st Create class which will hold canister

// 2nd import print module to use it
import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  // Orthogonal Persistance
  stable var currentValue: Float = 300;
  // currentValue := 100;

  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  let id = 43935151587239489374;

  Debug.print("Hello");
  Debug.print(debug_show(currentValue));
  Debug.print(debug_show(id));

// Private function - accessible only within this DBank actor
// Add "public" keyword to make it accessible outside DBank actor
// topUp(value: datatype)
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  // topUp();

  // Allow users to withdraw an amount from currentValue
  // Decrease the currentValue by the amount
  public func withDraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero.");
    }
  };

  // Query vs Update Methods
  public query func checkBalance(): async Float {
    return currentValue;
  };

  // topUp();
  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }
}