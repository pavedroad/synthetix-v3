// SPDX-License-Identifier: MIT
pragma solidity >=0.8.11 <0.9.0;

import "../interfaces/IERC20.sol";

library ERC20Helper {
    error FailedTransfer(address from, address to, uint256 value);

    function safeTransfer(address token, address to, uint256 value) internal {
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(IERC20.transfer.selector, to, value)
        );
        if (!success || (data.length != 0 && !abi.decode(data, (bool)))) {
            revert FailedTransfer(address(this), to, value);
        }
    }

    function safeTransferFrom(address token, address from, address to, uint256 value) internal {
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(IERC20.transferFrom.selector, from, to, value)
        );
        if (!success || (data.length != 0 && !abi.decode(data, (bool)))) {
            revert FailedTransfer(from, to, value);
        }
    }

    function balanceOf(address token, address wallet) internal view returns (uint256) {
        return IERC20(token).balanceOf(wallet);
    }
}
