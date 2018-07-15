## -*- texinfo -*-
## @deftypefn {Function File} {} collatzgraph (@var{a})
## The function foo subtracts @var{x} from @var{y}, then adds the
## remaining arguments to the result. If @var{y} is not supplied,
## then the number 19 is used by default.
##
## @example
## @group
## foo (1, [3, 5], 3, 9)
##      @result{} [ 14, 16 ]
## @end group
## @end example
##
## @seealso{foo1, foo2}
## @end deftypefn

## Author: Author Name

function collatzgraph (m)

dom = 1:1:m;

rng = [];
for i = 1:2:m
    rng(1,i) = 1.5*i + .5;
endfor

for i = 2:2:m
    rng(1,i) = .5*i;
endfor


plot(dom,rng)
    


endfunction
