/**
 *Submitted for verification at BscScan.com on 2021-11-15
*/

//   ________  ________  ___       __   _______   ________  ___  ________   ___  ___     
//  |\   __  \|\   __  \|\  \     |\  \|\  ___ \ |\   __  \|\  \|\   ___  \|\  \|\  \    
//  \ \  \|\  \ \  \|\  \ \  \    \ \  \ \   __/|\ \  \|\  \ \  \ \  \\ \  \ \  \\\  \   
//   \ \   ____\ \  \\\  \ \  \  __\ \  \ \  \_|/_\ \   _  _\ \  \ \  \\ \  \ \  \\\  \  
//    \ \  \___|\ \  \\\  \ \  \|\__\_\  \ \  \_|\ \ \  \\  \\ \  \ \  \\ \  \ \  \\\  \ 
//     \ \__\    \ \_______\ \____________\ \_______\ \__\\ _\\ \__\ \__\\ \__\ \_______\
//      \|__|     \|_______|\|____________|\|_______|\|__|\|__|\|__|\|__| \|__|\|_______|
                                                                                     
                                                                                     
                                                                                     

// Telegram:   https://tg.powerinu.net
// Discord:    https://discord.powerinu.net
// Twitter:    https://twitter.powerinu.net
// Youtube:    https://youtube.powerinu.net
// Website:    https://powerinu.net

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}


interface IBEP20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


interface IPancakeBEP20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
    
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


interface IPancakeFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}


interface IPancakeRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
    
    
   function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }


    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}


contract Ownable is Context {
    address private _owner;
    address private _previousOwner;
    uint256 private _lockTime;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }   
    
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
        
    }

    function getUnlockTime() public view returns (uint256) {
        return _lockTime;
    }
    
    function getTime() public view returns (uint256) {
        return block.timestamp;
    }

    function lock(uint256 time) public virtual onlyOwner {
        _previousOwner = _owner;
        _owner = address(0);
        _lockTime = block.timestamp + time;
        emit OwnershipTransferred(_owner, address(0));
    }
    
    function unlock() public virtual {
        require(_previousOwner == msg.sender, "You don't have permission to unlock");
        require(block.timestamp > _lockTime , "Contract is locked until time lock");
        emit OwnershipTransferred(_owner, _previousOwner);
        _owner = _previousOwner;
    }
}


contract PowerInu is Context, IBEP20, Ownable {
    using SafeMath for uint256;

    mapping (address => uint256) private _rOwned;
    mapping (address => uint256) private _tOwned;
    mapping (address => mapping (address => uint256)) private _allowances;

    mapping (address => bool) private _isExcludedFromFee;
    mapping (address => bool) isDividendExempt;
    mapping(address => bool) private _liquidityHolders;
    mapping(address => bool) private _isSniper;
    mapping(address => uint256) public dailySpent;
    mapping(address => uint256) public allowedTxAmount;
    mapping(address => uint256) public sellIntervalStart;

    mapping (address => bool) private _isExcluded;
    address[] private _excluded;
   
    uint256 private constant MAX = ~uint256(0);
    uint256 private _tTotal = 1000000 * 10**6 * 10**9;
    uint256 private _rTotal = (MAX - (MAX % _tTotal));
    uint256 private _tFeeTotal;

    string private _name = "PowerInu";
    string private _symbol = "PowerInu";
    uint8 private _decimals = 9;
    
    uint256 public swapAndLiquifycount = 0;
    uint256 public snipersCaught = 0;
    
    uint256 public _reflectionFee = 0; //consists of reflect tax
    uint256 private _previousReflectionFee = _reflectionFee;
    
    uint256 public _liquidityFee = 0; ///consists of buyback + liq + dividends tax 
    uint256 private _previousLiquidityFee = _liquidityFee;
    
    uint256 public div1 = 5;
    uint256 public div2 = 56;
    uint256 public affiliatePercent = 50;

    uint256 public _startTimeForSwap;
    uint256 public _intervalSecondsForSwap = 1 * 30 seconds;

    // Fee per address
    uint256 public _maxWallet = 20000 * 10**6 * 10**9;
    uint256 public _maxTxAmount = 5000 * 10**6 * 10**9;
    uint256 private minimumTokensBeforeSwap = 2500 * 10**6 * 10**9; 
    uint256 public launchedAt = 0;

    IPancakeRouter01 public pancakeRouter;
    address public pancakePair;
    
    bool inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = true;
    bool private sniperProtection = true;
    bool public _hasLiqBeenAdded = false;
    bool public _tradingEnabled = false;

    address public currentLiqPair;
    address payable public buybackAddress = payable(0x763c369562155775Ac6DFb7BC3612706210399C5);
    address payable public marketingAddress = payable(0x5b22393B0Ee91f8510ddB7f687A04cD760546268);
    address payable public lpAddress = payable(0x89c5fa50A5e2f7EBecB4576d5720CD9E3f617560);
    address payable public stakingAddress = payable(0xe78fe4F612e6b5ac11d9192C8ac7cFE20905befa);
    address payable public affilateAddress = payable(0x36aD70c039b6eB8a3ff610e4AE3BEE0d0df48991);
    
    event SwapAndLiquifyEnabledUpdated(bool enabled);
    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );
    
    event SwapTokensForETH(
        uint256 amountIn,
        address[] path
    );
    
    modifier lockTheSwap {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }
    
    constructor () {
        transferOwnership(lpAddress);
        _rOwned[lpAddress] = _rTotal;     
        
        // Pancakeswap Router Mainnet v2
        IPancakeRouter01 _pancakeRouter = IPancakeRouter01(0x10ED43C718714eb63d5aA57B78B54704E256024E);

        pancakePair = IPancakeFactory(_pancakeRouter.factory())
            .createPair(address(this), _pancakeRouter.WETH());
        pancakeRouter = _pancakeRouter;
        
        _isExcludedFromFee[lpAddress] = true;
        _isExcludedFromFee[stakingAddress] = true;
        _isExcludedFromFee[address(0)];
        _isExcludedFromFee[marketingAddress] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[affilateAddress] = true;
        _liquidityHolders[lpAddress] = true;

        _startTimeForSwap = block.timestamp;
        
        emit Transfer(address(0), lpAddress, _tTotal);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tOwned[account];
        return tokenFromReflection(_rOwned[account]);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }
    
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    function isExcludedFromReward(address account) public view returns (bool) {
        return _isExcluded[account];
    }

    function totalFees() public view returns (uint256) {
        return _tFeeTotal;
    }
    
    function minimumTokensBeforeSwapAmount() public view returns (uint256) {
        return minimumTokensBeforeSwap;
    }
    
    function deliver(uint256 tAmount) public {
        address sender = _msgSender();
        require(!_isExcluded[sender], "Excluded addresses cannot call this function");
        (uint256 rAmount,,,,,) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rTotal = _rTotal.sub(rAmount);
        _tFeeTotal = _tFeeTotal.add(tAmount);
    }
  
    function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns(uint256) {
        require(tAmount <= _tTotal, "Amount must be less than supply");
        if (!deductTransferFee) {
            (uint256 rAmount,,,,,) = _getValues(tAmount);
            return rAmount;
        } else {
            (,uint256 rTransferAmount,,,,) = _getValues(tAmount);
            return rTransferAmount;
        }
    }

    function tokenFromReflection(uint256 rAmount) public view returns(uint256) {
        require(rAmount <= _rTotal, "Amount must be less than total reflections");
        uint256 currentRate =  _getRate();
        return rAmount.div(currentRate);
    }

    function excludeFromReward(address account) public onlyOwner() {
        require(!_isExcluded[account], "Account is already excluded");
        if(_rOwned[account] > 0) {
            _tOwned[account] = tokenFromReflection(_rOwned[account]);
        }
        _isExcluded[account] = true;
        _excluded.push(account);
    }

    function includeInReward(address account) external onlyOwner() {
        require(_isExcluded[account], "Account is not excluded");
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_excluded[i] == account) {
                _excluded[i] = _excluded[_excluded.length - 1];
                _tOwned[account] = 0;
                _isExcluded[account] = false;
                _excluded.pop();
                break;
            }
        }
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) private {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        if(!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
            require(_tradingEnabled, 'Trading is currently disabled');
            require(to != address(0), "ERC20: transfer to the zero address");
            if(to != pancakePair){
                require(balanceOf(to).add(amount) <= _maxWallet, "Transfer exceeds max");
            }else{
                if(sellIntervalStart[from] != 0){
                    if(sellIntervalStart[from].add(120) < block.timestamp){
                        allowedTxAmount[from] = _maxTxAmount;
                        sellIntervalStart[from] = block.timestamp;
                    }
                }
                if(allowedTxAmount[from] == 0 && sellIntervalStart[from] == 0){
                    allowedTxAmount[from] = _maxTxAmount;
                    sellIntervalStart[from] = block.timestamp;
                }
                if(amount > allowedTxAmount[from]){
                    revert("MaxTx Limit: Daily Limit Reached");
                }else{
                    if(allowedTxAmount[from].sub(amount) <= 0){
                        allowedTxAmount[from] = 0;
                    }else{
                        allowedTxAmount[from] = allowedTxAmount[from].sub(amount); 
                    }
                }
            }
        }
        
        if(!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
        }
        
        uint256 contractTokenBalance = balanceOf(address(this));

        bool overMinimumSwapTokenBalance = contractTokenBalance >= minimumTokensBeforeSwap;    

        // Handle liquidity and buybacks
        if (!inSwapAndLiquify && swapAndLiquifyEnabled && balanceOf(pancakePair) > 0 && !_isExcludedFromFee[from]) {
            if(to == pancakePair ){ 
                if (overMinimumSwapTokenBalance && _startTimeForSwap + _intervalSecondsForSwap <= block.timestamp) {
                    _startTimeForSwap = block.timestamp;
                    swapAndLiquifycount = swapAndLiquifycount.add(1);
                    swapAndLiquify(minimumTokensBeforeSwap);
                }  
            }
        }

        bool takeFee = true;
        
        // If any account belongs to _isExcludedFromFee account then remove the fee
        if(_isExcludedFromFee[from] || _isExcludedFromFee[to]){
            takeFee = false;
        }
        
        _tokenTransfer(from,to,amount,takeFee);
            
    }

    function swapAndLiquify(uint256 contractTokenBalance) internal lockTheSwap {
        // split the contract balance into halves
        uint256 whole = contractTokenBalance.div(div1);
        uint256 half = whole.div(2);
        uint256 otherHalf = whole.sub(half);
        uint256 remains = contractTokenBalance.sub(whole);
        
        // capture the contract's current BNB balance.
        // this is so that we can capture exactly the amount of BNB that the
        // swap creates, and not make the liquidity event include any BNB that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for BNB
        swapTokensForEth(half);

        // how much BNB did we just swap into?
        uint256 newBalance = address(this).balance.sub(initialBalance);

        // add liquidity
        addLiquidity(otherHalf, newBalance);

        initialBalance = address(this).balance;
        
        // swap tokens for BNB
        swapTokensForEth(remains);
        
        uint256 transferredBalance = address(this).balance.sub(initialBalance);
        uint256 marketingBalance = transferredBalance.mul(div2).div(100);
        uint256 overallBalance = transferredBalance.sub(marketingBalance);
        uint256 buyBackBalance = overallBalance.mul(affiliatePercent).div(100);
        uint256 affiliateBalance = overallBalance.sub(buyBackBalance);
        
        // Send Token to Wallet address
        transferToAddressETH(buybackAddress, buyBackBalance);
        transferToAddressETH(affilateAddress, affiliateBalance);
        transferToAddressETH(marketingAddress, marketingBalance);

        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // Generate the pancake pair path of token -> WETH
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = pancakeRouter.WETH();

        _approve(address(this), address(pancakeRouter), tokenAmount);

        // Make the swap
        pancakeRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // Accept any amount of BNB
            path,
            address(this), // The contract
            block.timestamp
        );
        
        emit SwapTokensForETH(tokenAmount, path);
    }
    
    function addLiquidity(uint256 tokenAmount, uint256 bnbAmount) private {
        // Approve token transfer to cover all possible scenarios
        _approve(address(this), address(pancakeRouter), tokenAmount);

        // Add the liquidity
        pancakeRouter.addLiquidityETH{value: bnbAmount}(
            address(this),
            tokenAmount,
            0, // Slippage is unavoidable
            0, // Slippage is unavoidable
            lpAddress,
            block.timestamp
        );
    }

    function _tokenTransfer(address sender, address recipient, uint256 amount,bool takeFee) private {
        if(sniperProtection) {
          // if sender is a sniper address, reject the sell.
          if(isSniper(sender)) {
            revert('Sniper rejected.');
          }
    
          // check if this is the liquidity adding tx to startup.
          if(!_hasLiqBeenAdded) {
            _checkLiquidityAdd(sender, recipient);
          } else {
            if(
              launchedAt > 0
                && sender == pancakePair
                && !_liquidityHolders[sender]
                && !_liquidityHolders[recipient]
            ) {
              if(block.number - launchedAt < 1) {
                _isSniper[recipient] = true;
                snipersCaught++;
              }
            }
          }
        }
        if(!takeFee)
            removeAllFee();
        
        if (_isExcluded[sender] && !_isExcluded[recipient]) {
            _transferFromExcluded(sender, recipient, amount);
        } else if (!_isExcluded[sender] && _isExcluded[recipient]) {
            _transferToExcluded(sender, recipient, amount);
        } else if (_isExcluded[sender] && _isExcluded[recipient]) {
            _transferBothExcluded(sender, recipient, amount);
        } else {
            _transferStandard(sender, recipient, amount);
        }
        
        if(!takeFee)
            restoreAllFee();
    }

    function _transferStandard(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferToExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
	    _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);           
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
    	_tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);   
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
    	_tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);        
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _reflectFee(uint256 rFee, uint256 tFee) private {
        _rTotal = _rTotal.sub(rFee);
        _tFeeTotal = _tFeeTotal.add(tFee);
    }

    function _getValues(uint256 tAmount) private view returns (uint256, uint256, uint256, uint256, uint256, uint256) {
        (uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getTValues(tAmount);
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee) = _getRValues(tAmount, tFee, tLiquidity, _getRate());
        return (rAmount, rTransferAmount, rFee, tTransferAmount, tFee, tLiquidity);
    }

    function _getTValues(uint256 tAmount) private view returns (uint256, uint256, uint256) {
        uint256 tFee = calculateReflectionFee(tAmount);
        uint256 tLiquidity = calculateLiquidityFee(tAmount);
        uint256 tTransferAmount = tAmount.sub(tFee).sub(tLiquidity);
        return (tTransferAmount, tFee, tLiquidity);
    }

    function _getRValues(uint256 tAmount, uint256 tFee, uint256 tLiquidity, uint256 currentRate) private pure returns (uint256, uint256, uint256) {
        uint256 rAmount = tAmount.mul(currentRate);
        uint256 rFee = tFee.mul(currentRate);
        uint256 rLiquidity = tLiquidity.mul(currentRate);
        uint256 rTransferAmount = rAmount.sub(rFee).sub(rLiquidity);
        return (rAmount, rTransferAmount, rFee);
    }

    function _getRate() private view returns(uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply.div(tSupply);
    }

    function _getCurrentSupply() private view returns(uint256, uint256) {
        uint256 rSupply = _rTotal;
        uint256 tSupply = _tTotal;      
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_rOwned[_excluded[i]] > rSupply || _tOwned[_excluded[i]] > tSupply) return (_rTotal, _tTotal);
            rSupply = rSupply.sub(_rOwned[_excluded[i]]);
            tSupply = tSupply.sub(_tOwned[_excluded[i]]);
        }
        if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);
        return (rSupply, tSupply);
    }
    
    function _takeLiquidity(uint256 tLiquidity) private {
        uint256 currentRate =  _getRate();
        uint256 rLiquidity = tLiquidity.mul(currentRate);
        _rOwned[address(this)] = _rOwned[address(this)].add(rLiquidity);
        if(_isExcluded[address(this)])
            _tOwned[address(this)] = _tOwned[address(this)].add(tLiquidity);
        }
    
    function calculateReflectionFee(uint256 _amount) private view returns (uint256) {
        return _amount.mul(_reflectionFee).div(
            10**2
        );
    }
    
    function calculateLiquidityFee(uint256 _amount) private view returns (uint256) {
        if(launchedAt.add(3) >= block.number){
            return _amount.mul(_liquidityFee.mul(7)).div(
                10**2
            );
        } else {
            return _amount.mul(_liquidityFee).div(
                10**2
            );
        }
    
    }
    
    function manualSwapandLiquify(uint256 _balance) external onlyOwner {
        swapAndLiquify(_balance);
    }
    
    function setLaunchLiqPair (address _pair) public onlyOwner {
        pancakePair = _pair;
    }
    
    function isSniper(address account) public view returns(bool) {
        return _isSniper[account];
    }
    
    function removeAllFee() private {
        if(_reflectionFee == 0 && _liquidityFee == 0) return;
        
        _previousReflectionFee = _reflectionFee;
        _previousLiquidityFee = _liquidityFee;
        
        _reflectionFee = 0;
        _liquidityFee = 0;
    }
    
    function restoreAllFee() private {
        _reflectionFee = _previousReflectionFee;
        _liquidityFee = _previousLiquidityFee;
    }

    function isExcludedFromFee(address account) public view returns(bool) {
        return _isExcludedFromFee[account];
    }
    
    function excludeFromFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = true;
    }
    
    function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
    }

    function getSwapMinutes() public view returns(uint256) {
        return _intervalSecondsForSwap.div(60);
    }

    function setSwapMinutes(uint256 newMinutes) external onlyOwner {
        _intervalSecondsForSwap = newMinutes * 1 minutes;
    }
    
    function setReflectionFeePercent(uint256 reflectionFee) external onlyOwner() {
        require(reflectionFee < 30, "tax too high");
        _reflectionFee = reflectionFee;
    }
        
    function setLiquidityFeePercent(uint256 liquidityFee) external onlyOwner {
        require(liquidityFee < 30, "tax too high");
        _liquidityFee = liquidityFee;
    }
    
    function setDivs(uint256 _div1, uint256 _div2) external onlyOwner {
        div1 = _div1;
        div2 = _div2;
    }
    
    function setAffiliatePercent(uint256 _affiliatePercent) external onlyOwner {
        affiliatePercent = _affiliatePercent;
    }
    
    function getAffiliatePercent() public view returns(uint256) {
        return affiliatePercent;
    }
    
    function addressChange(address payable _lpAddress, address payable _stakingAddress, address payable _marketingAddress, address payable _buybackAddress, address payable _affiliateAddress) external onlyOwner{
        require(_marketingAddress != address(0),"cant set dev address 0");
        require(_buybackAddress != address(0),"cant set buyback address 0");
        lpAddress = _lpAddress;
        stakingAddress = _stakingAddress;
        marketingAddress = _marketingAddress;
        buybackAddress = _buybackAddress;
        affilateAddress = _affiliateAddress;
    }
    
    function _checkLiquidityAdd(address from, address to) private {
        // if liquidity is added by the _liquidityholders set trading enables to true and start the anti sniper timer
        require(!_hasLiqBeenAdded, 'Liquidity already added and marked.');
    
        if(_liquidityHolders[from] && to == pancakePair) {
          _hasLiqBeenAdded = true;
          _tradingEnabled = true;
          launchedAt = block.number;
        }
    }
    
    function removeSniper(address account) external onlyOwner { 
        require(_isSniper[account], 'Account is not a recorded sniper.');
        _isSniper[account] = false;
    }


    function changeWhaleSettings(uint256 maxTxAmount, uint256 maxWallet) external onlyOwner {
        require(maxTxAmount > totalSupply().div(1000), "max tx too low");
        require(maxWallet > totalSupply().div(1000), "max wallet too low");
        _maxWallet = maxWallet;
        _maxTxAmount = maxTxAmount;
    }
    
    function setMinimumTokensBeforeSwap(uint256 _minimumTokensBeforeSwap) external onlyOwner {
        minimumTokensBeforeSwap = _minimumTokensBeforeSwap;
    }  
    
    function setSwapAndLiquifyEnabled(bool _enabled) public onlyOwner {
        swapAndLiquifyEnabled = _enabled;
        emit SwapAndLiquifyEnabledUpdated(_enabled);
    }
    
    
    function transferToAddressETH(address payable recipient, uint256 amount) private {
        recipient.transfer(amount);
    }
    
    function buyBack() public payable {
        address[] memory path = new address[](2);
        path[0] = pancakeRouter.WETH();
        path[1] = address(this);
        pancakeRouter.swapExactETHForTokensSupportingFeeOnTransferTokens{value : msg.value}(0,path,stakingAddress,block.timestamp.add(10));
    }
       
    
    function launched() internal view returns (bool) {
        return launchedAt != 0;
    }

    function preSaleBefore() external onlyOwner {
        setSwapAndLiquifyEnabled(false);
        _reflectionFee = 0;
        _liquidityFee = 0;
        _maxTxAmount = 1000000 * 10**6 * 10**9;
    }
    
    function preSaleAfter() external onlyOwner {
        setSwapAndLiquifyEnabled(true);
        launchedAt = block.number;
        _hasLiqBeenAdded = true;
        _tradingEnabled = true;
        _reflectionFee = 0;
        _liquidityFee = 11;
        _maxTxAmount = 2500 * 10**6 * 10**9;
    }

    function multisend( address[] memory dests, uint256[] memory values) public onlyOwner returns (uint256) {
        uint256 i = 0;
        while (i < dests.length) {
           transfer(dests[i], values[i]);
           i += 1;
        }
        return(i);
    }

    function changeRouterVersion(address _router) public onlyOwner returns(address _pair) {
        IPancakeRouter01 _pancakeRouter = IPancakeRouter01(_router);
        
        _pair = IPancakeFactory(_pancakeRouter.factory()).getPair(address(this), _pancakeRouter.WETH());
        if(_pair == address(0)){
            // Pair doesn't exist
            _pair = IPancakeFactory(_pancakeRouter.factory())
            .createPair(address(this), _pancakeRouter.WETH());
        }
        pancakePair = _pair;

        // Set the router of the contract variables
        pancakeRouter = _pancakeRouter;
    }
    
     // To recieve BNB from pancakeV2Router when swapping
    receive() external payable {}

    function transferForeignToken(address _token, address _to) public onlyOwner returns(bool _sent){
        uint256 _contractBalance = IBEP20(_token).balanceOf(address(this));
        _sent = IBEP20(_token).transfer(_to, _contractBalance);
    }
    
    function Sweep() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }
}