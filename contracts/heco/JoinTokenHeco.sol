// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "../library/SafeMath.sol";
import "../owner/AdminRole.sol";


contract JoinToken is ERC20Burnable, AdminRole {
    using SafeMath for uint256;

    uint256 public mintTotal;
    uint256 public burnTotal;

    constructor() ERC20("JOIN Token", "JOIN")
    {
        _mint(msg.sender, 1 * 10**18);
        mintTotal = 1 * 10**18;
    }

    function mint(address recipient_, uint256 amount_)
    public
    onlyAdmin
    returns (bool)
    {
        uint256 balanceBefore = balanceOf(recipient_);
        _mint(recipient_, amount_);
        uint256 balanceAfter = balanceOf(recipient_);

        mintTotal = mintTotal.add(amount_);

        return balanceAfter > balanceBefore;
    }

    function burn(uint256 amount) public override onlyAdmin {
        super.burn(amount);
        burnTotal = burnTotal.add(amount);
    }

    function burnFrom(address account, uint256 amount)
    public
    override
    onlyAdmin
    {
        super.burnFrom(account, amount);
        burnTotal = burnTotal.add(amount);
    }
}
