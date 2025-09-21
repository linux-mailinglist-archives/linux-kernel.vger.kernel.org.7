Return-Path: <linux-kernel+bounces-826096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1009B8D871
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BA03BEE45
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B624502C;
	Sun, 21 Sep 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF4G+ZHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD85C96;
	Sun, 21 Sep 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758445445; cv=none; b=ZxMIY+VZU9yfKvaTxgz5cReM9TAW45ADp3JD5QGqlJ2wSw6x1+dskLMwGcD3G/l7TaXmbL6Xu/F7Ooc5VbC4IT7TZZEkJ5EFh2HHu/0pbIBcMWmrO9izhr0QM4S+9k1FIW9eZFkd/XKFY3ZvmJPGubwD93SG9sXaUYeu2cHf3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758445445; c=relaxed/simple;
	bh=NfJ4XAnY8uqCMW44xLDqZuxJXsj+ie41MCGd9lR5AYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=J+KfaJ759HYV20RAz3cmaQjzEAVxDsFj/EC+pMl0xTRDM3G5m0Djv2NEa89rGjVJxqzSFP3pMkcU8FaN/+s9zzKU4yxMoDCG9QybX26HGbtciuc6QnoUGC5o7Z231xrr4USN08RMhu6X6vOnIB3lCmHOErlHVt9ZLjr0qKlO8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF4G+ZHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C163C4CEE7;
	Sun, 21 Sep 2025 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758445444;
	bh=NfJ4XAnY8uqCMW44xLDqZuxJXsj+ie41MCGd9lR5AYU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HF4G+ZHwTkmtBbkE9cFwsW4rQVMpMyEVs9Cm4+56oQ4jsQ6w1qABZI6ExYtJaK4LR
	 GJI37OkmvirxavmdsAUnAcTygSKb+G08ixAnQ3DPz85bxHf9B5sDtBPBZtJepp9rMO
	 26CPXNn/+BMr/r0Odzg3AZAr2CpRRlALdClNoRMWQKPy/6CBHmixCk+1+7DcTitDGf
	 h+DRlwV9JiQoBLj2wOPs+EI838mnf0vFJytKryxCtur/37Kxd5NQCJOOuE3w7BJRmF
	 N6NAsexaf9VBdF7zY9mffHKqhRGNGzTTeZJfrItTw/ZvUG13Y1ayT+oeEG/fFyvJ4k
	 OsvDWkR/uMEdQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 11:03:59 +0200
Message-Id: <DCYCVV212A7X.U2ZDJDY18LQX@kernel.org>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
From: "Benno Lossin" <lossin@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org> <20250921004517.GA2101443@joelbox2>
 <DCYAIOO2W2KT.1CANHTH6GRVO@kernel.org>
In-Reply-To: <DCYAIOO2W2KT.1CANHTH6GRVO@kernel.org>

On Sun Sep 21, 2025 at 9:12 AM CEST, Benno Lossin wrote:
> On Sun Sep 21, 2025 at 2:45 AM CEST, Joel Fernandes wrote:
>> On Sat, Sep 20, 2025 at 10:09:30PM +0200, Benno Lossin wrote:
>>> On Sat Sep 20, 2025 at 6:19 PM CEST, Joel Fernandes wrote:
>>> > When printing just before calling io.write32(), modpost fails due to
>>> > build_assert's missing rust_build_error symbol. The issue is that, th=
e
>>> > printk arguments are passed as reference in bindings code, thus Rust
>>> > cannot trust its value and fails to optimize away the build_assert.
>>> >
>>> > The issue can be reproduced with the following simple snippet:
>>> >   let offset =3D 0;
>>> >   pr_err!("{}", offset);
>>> >   io.write32(base, offset);
>>>=20
>>> I took a long time to understand this and I think I got it now, but
>>> maybe I'm still wrong: passing `offset` to `printk` via a reference
>>> results in the compiler thinking that the value of `offset` might be
>>> changed (even though its a shared reference I assume). For this reason
>>> the `build_assert!` used by `io.write32` cannot be optimized away.
>>
>> Yes, that's correct and that's my understanding. I in fact also dumped t=
he IR
>> and see that the compiler is trying to reload the pointer to the offset.=
 I
>> feel this is a compiler bug, and for immutable variables, the compiler s=
hould
>> not be reloading them even if they are passed to external code? Because =
if
>> external code is modifying immutable variables, that is buggy anyway.
>
> It would be great if you could add all of the extra info that you looked
> at into the commit message here. So all of the code to reproduce the
> issue, the IR you looked at...
>
>>> > Fix it by just using a closure to call printk. Rust captures the
>>> > arguments into the closure's arguments thus breaking the dependency.
>>> > This can be fixed by simply creating a variable alias for each variab=
le
>>> > however the closure is a simple and concise fix.
>>>=20
>>> I don't think this is the fix we want to have.
>>
>> Yeah its ugly, though a small workaround. IMO ideally the fix should be =
in
>> the compiler. I want to send a proposal for this in fact. I looked at th=
e MIR
>> and I believe with my limited understanding, that the MIR should be issu=
ing a
>> copy before making a pointer of the immutable variable if pointers to
>> immutable variables are being passed to external functions.
>
> ... and definitely the MIR.
>
>> If I were to send a proposal to the Rust language to start a discussion
>> leading to a potential RFC stage, would you mind guiding me on doing so?
>
> I agree that this should be fixed in the compiler if we aren't missing
> some attribute on one of our functions.
>
> Note that this probably doesn't require an RFC, since it's not a big
> feature and I imagine that there isn't much controversy about it. We can
> mention this in our sync meeting on Wednesday with the Rust folks & see
> what they have to say about it. After that we probably want to open an
> issue about it, I'll let you know.

I have created a simpler example than using `io.write32` and given lots
of info below, I'll show this to the Rust folks & you can add it to the
commit message if you want :)

Printing and our build assert doesn't work together:

```rust
let x =3D 0;
pr_info!("{}", x);
build_assert!(x =3D=3D 0);
```

Macros expanded:

```rust
let x =3D 0;
match format_args!("{0}", x) {
    args =3D> unsafe {
        ::kernel::print::call_printk(
            &::kernel::print::format_strings::INFO,
            crate::__LOG_PREFIX,
            args,
        );
    },
};
{
    if !(x =3D=3D 0) {
        ::kernel::build_assert::build_error("assertion failed: x =3D=3D 0")=
;
    }
};
```

where `build_error` & `call_printk` are defined as:

```rust
#[inline(never)]
#[cold]
#[export_name =3D "rust_build_error"]
#[track_caller]
pub const fn build_error(msg: &'static str) -> ! {
    panic!("{}", msg);
}

pub unsafe fn call_printk(
    format_string: &[u8; format_strings::LENGTH],
    module_name: &[u8],
    args: fmt::Arguments<'_>,
) {
    unsafe {
        bindings::_printk(
            format_string.as_ptr(),
            module_name.as_ptr(),
            core::ptr::from_ref(&args).cast::<c_void>(),
        );
    }
}
// bindings:
extern "C" {
    pub fn _printk(fmt: *const ffi::c_char, ...) -> ffi::c_int;
}
```

```c
int _printk(const char *fmt, ...);
```

When compiling, we won't have the `rust_build_error` symbol defined, so if =
the
linker sees this, it will fail with a (very unergonomic) error:

```text
ld.lld: error: undefined symbol: rust_build_error
>>> referenced by usercopy_64.c
>>>               vmlinux.o:(print_build_assert_test)
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
make[1]: *** [Makefile:1244: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2
```

The LLVM IR looks like this:

```llvm
  %args1 =3D alloca [16 x i8], align 8
  %args =3D alloca [48 x i8], align 8
  %x =3D alloca [4 x i8], align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %x)
  store i32 0, ptr %x, align 4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %args1)
  store ptr %x, ptr %args1, align 8
  %_4.sroa.4.0..sroa_idx =3D getelementptr inbounds nuw i8, ptr %args1, i64=
 8
  store ptr @_RNvXs5_NtNtNtCs1h9PaebWwla_4core3fmt3num3implNtB9_7Display3fm=
t, ptr %_4.sroa.4.0..sroa_idx, align 8
  store ptr @alloc_eab5d04767146d7d9b93b60d28ef530a, ptr %args, align 8
  %0 =3D getelementptr inbounds nuw i8, ptr %args, i64 8
  store i64 1, ptr %0, align 8
  %1 =3D getelementptr inbounds nuw i8, ptr %args, i64 32
  store ptr null, ptr %1, align 8
  %2 =3D getelementptr inbounds nuw i8, ptr %args, i64 16
  store ptr %args1, ptr %2, align 8
  %3 =3D getelementptr inbounds nuw i8, ptr %args, i64 24
  store i64 1, ptr %3, align 8
; call kernel::print::call_printk
  call void @_RNvNtCsetEQUy9amV6_6kernel5print11call_printk(ptr noalias nou=
ndef nonnull readonly align 1 dereferenceable(10) @_RNvNtNtCsetEQUy9amV6_6k=
ernel5print14format_strings4INFO, ptr noalias noundef nonnull readonly alig=
n 1 @alloc_9e327419e36c421bc1658af3b68806c2, i64 noundef 13, ptr noalias no=
capture noundef nonnull align 8 dereferenceable(48) %args) #8
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %args1)
  %_7 =3D load i32, ptr %x, align 4, !noundef !7
  ;     ^^^^^^^^^^^^^^^^ we load the value of `x` again after calling `call=
_printk`,
  ;                      even though it was a shared reference!
  %4 =3D icmp eq i32 %_7, 0
  br i1 %4, label %bb2, label %bb3, !prof !11

bb2:                                              ; preds =3D %start
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %x)
  ret void

bb3:                                              ; preds =3D %start
  call void @rust_build_error(ptr noalias noundef nonnull readonly align 1 =
@alloc_7f598d51153ed56ec9aa560e64562fc0, i64 noundef 24, ptr noalias nounde=
f nonnull readonly align 8 dereferenceable(24) @alloc_4255a8c4673dfae2bb72b=
50834aecf9e) #9
  unreachable
```

The MIR looks like this:

```text
let mut _0: ();
let _1: i32;
let mut _2: core::fmt::Arguments<'_>;
let mut _4: core::fmt::rt::Argument<'_>;
let _5: &[core::fmt::rt::Argument<'_>; 1];
let _6: ();
let mut _7: i32;
let _8: !;
scope 1 {
    debug x =3D> _1;
    let _3: [core::fmt::rt::Argument<'_>; 1];
    scope 2 {
        debug args =3D> _3;
        scope 9 (inlined core::fmt::rt::<impl Arguments<'_>>::new_v1::<1, 1=
>) {
            let mut _15: &[&str];
            let mut _16: &[core::fmt::rt::Argument<'_>];
        }
    }
    scope 3 {
        debug args =3D> _2;
    }
    scope 4 (inlined core::fmt::rt::Argument::<'_>::new_display::<i32>) {
        let mut _9: core::fmt::rt::ArgumentType<'_>;
        let mut _10: core::ptr::NonNull<()>;
        let mut _11: for<'a, 'b> unsafe fn(core::ptr::NonNull<()>, &'a mut =
core::fmt::Formatter<'b>) -> core::result::Result<(), core::fmt::Error>;
        let _12: for<'a, 'b, 'c> fn(&'a i32, &'b mut core::fmt::Formatter<'=
c>) -> core::result::Result<(), core::fmt::Error>;
        scope 5 {
        }
        scope 6 (inlined NonNull::<i32>::from_ref) {
            let mut _13: *const i32;
        }
        scope 7 (inlined NonNull::<i32>::cast::<()>) {
            let mut _14: *const ();
            scope 8 (inlined NonNull::<i32>::as_ptr) {
            }
        }
    }
}

bb0: {
    StorageLive(_1);
    _1 =3D const 0_i32;
    StorageLive(_3);
    StorageLive(_4);
    StorageLive(_12);
    StorageLive(_13);
    StorageLive(_9);
    StorageLive(_10);
    _13 =3D &raw const _1;
    StorageLive(_14);
    _14 =3D copy _13 as *const () (PtrToPtr);
    _10 =3D NonNull::<()> { pointer: move _14 };
    StorageDead(_14);
    StorageLive(_11);
    _12 =3D <i32 as core::fmt::Display>::fmt as for<'a, 'b, 'c> fn(&'a i32,=
 &'b mut core::fmt::Formatter<'c>) -> core::result::Result<(), core::fmt::E=
rror> (PointerCoercion(ReifyFnPointer, Implicit));
    _11 =3D copy _12 as for<'a, 'b> unsafe fn(core::ptr::NonNull<()>, &'a m=
ut core::fmt::Formatter<'b>) -> core::result::Result<(), core::fmt::Error> =
(Transmute);
    _9 =3D core::fmt::rt::ArgumentType::<'_>::Placeholder { value: move _10=
, formatter: move _11, _lifetime: const PhantomData::<&()> };
    StorageDead(_11);
    StorageDead(_10);
    _4 =3D core::fmt::rt::Argument::<'_> { ty: move _9 };
    StorageDead(_9);
    StorageDead(_13);
    StorageDead(_12);
    _3 =3D [move _4];
    StorageDead(_4);
    _5 =3D &_3;
    StorageLive(_15);
    _15 =3D const print_build_assert_test::promoted[0] as &[&str] (PointerC=
oercion(Unsize, Implicit));
    StorageLive(_16);
    _16 =3D copy _5 as &[core::fmt::rt::Argument<'_>] (PointerCoercion(Unsi=
ze, Implicit));
    _2 =3D Arguments::<'_> { pieces: move _15, fmt: const Option::<&[core::=
fmt::rt::Placeholder]>::None, args: move _16 };
    StorageDead(_16);
    StorageDead(_15);
    _6 =3D call_printk(const <static(DefId(2:3562 ~ kernel[a8a3]::print::fo=
rmat_strings::INFO))>, const __LOG_PREFIX, move _2) -> [return: bb1, unwind=
 unreachable];
}

bb1: {
    StorageDead(_3);
    StorageLive(_7);
    _7 =3D copy _1;
    //   ^^^^^^^^ this is the problematic part, it shouldn't prompt a re-re=
ad of
    //            the location, but rather just know that the value is 0
    switchInt(move _7) -> [0: bb2, otherwise: bb3];
}

bb2: {
    StorageDead(_7);
    StorageDead(_1);
    return;
}

bb3: {
    StorageDead(_7);
    _8 =3D build_error(const "assertion failed: x =3D=3D 0") -> unwind unre=
achable;
}
```

---
Cheers,
Benno

