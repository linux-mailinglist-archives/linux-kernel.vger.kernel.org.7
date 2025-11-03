Return-Path: <linux-kernel+bounces-882688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A179DC2B215
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E33803493EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E842FFF91;
	Mon,  3 Nov 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLA0TliQ"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574992FF65C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166871; cv=none; b=c/njFktkRyWthBk1j1XCRTuidtZ9Cy4Sc6mRz19Mp6oQEZr5Sbt4Hs+mG4AAXIngPEfrVUyCKiv+vnWng9amFvWMX6QWAri3IXYRLpT56UBrNaAQQbytHwqvLUteHQcyzUOs545ocbAjMyuyA4jKFzPv7yjcPFcy1rvFNKG+KUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166871; c=relaxed/simple;
	bh=9c+oPZlJsay1uaRjjL3T5AGIXm1u91dqAksS0VNm3Zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HSBtA/XftkAKmXlUvqT+orWPVKls0IcUvJgl6YANZOxYh5xCmxMARwsiKLWtufn076PCNMgQuSPCF+DOOyqD3ewqykW6a7TvxS1OHgn+t4RbGc9oGGbWt8xhJBdmSN0qoCRv/aZoayu50O4N3k1Z2fDJ+aY9xh7Cc8IBy/G+J3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLA0TliQ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b6d4f19c13cso324263366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762166868; x=1762771668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1EkF5jDkOGtj6JOhPNM+1v1f/L+L2n1OYVANJ7xlzY=;
        b=CLA0TliQEREFPTs01rrDEAsxTNUmbvoGaZ3tRVza45wwzfCzW/R59vguL5+eOUIXl1
         MUqP72fAApGMEs3Ixc8pWw9doKEshr85sd4PmrwHvl6BDbQKVg3tbDl3xqsYENnFzwyn
         mhzXi+jx3buPz56B/3r9kW0GFeAVRQe25yEyVGUlUQi32BEgIkyxnCAlA438EAln0Iqp
         qp/pXu/xl1XkmbzdG+4SifFOdUqrhA7eLEiBRwd4MHLsl/8eWWX3QPPpsLl/FQXi+Kjq
         n9oYjU6p5nQ2I421+F44YVL3os6F9MRjHB77f/tCR/e4ssPxNDYyp6qpElXV06GYcen+
         +F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166868; x=1762771668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1EkF5jDkOGtj6JOhPNM+1v1f/L+L2n1OYVANJ7xlzY=;
        b=jz+XcFKUyDCUFLoZC9OGklPnYJOt+cORhnKr52h0nnUaltx57MCjL6CD2dpV/heD03
         qaoflsrmzHp6idz/QCg4F/1bGZvZXUgXh+M+yg/j+7Y/F9fqStWDkbe2I/CHr8u7jBaP
         qd4XZtf71iJ5YjX54XAalW6OSZs/F8E++nsIhQK2clragCyupgnDRPNKhioJUonvQFJ/
         AJgvXdoBinhVeqVJcA3eq0xg3EPth4o+zL999AQH8C4rUbUWgWsKYFYHUAox8Twtdues
         CwbfReSmCi+XdHTTc/x0xlF42PGcQcF9wMDtww6nK/DN71ECqAmBrthQYhBjLU4kqW3h
         NIXA==
X-Forwarded-Encrypted: i=1; AJvYcCXjUv45HAY3EtTAjIrDsUA6sRK3K6I8rOesmIyAeOMu7Bhyq1JMfc+BXjC3HRbJTI1mDIPjbAN47mGGuYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywel9L58kutUq9o6WKsbn8bk2at/MGf/V887RDfHHic/JB62gpv
	QdQ6zGA8d7dwQhX+gJmuB75kS8xLuKGrw+3L1YRjqRZt9ZPLOLmCC1Wlcv1NwXspjngU6Jiyta6
	w40fdD0BZOQYzy+h0LQ==
X-Google-Smtp-Source: AGHT+IGw5Xo6uurjkeOhIrCdOOT+WavsSIzDYf/umeCGWLXYZudvAp0F3CcerHODyKrUF6WHmW1jRbBfrRhHjH4=
X-Received: from ejcrt5.prod.google.com ([2002:a17:907:8945:b0:b71:a2e3:37b4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:370f:b0:b70:b94c:7f4b with SMTP id a640c23a62f3a-b70b94c7fdfmr271394466b.41.1762166867699;
 Mon, 03 Nov 2025 02:47:47 -0800 (PST)
Date: Mon, 3 Nov 2025 10:47:46 +0000
In-Reply-To: <aQgQv6F0Ao4DH6U0@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com> <aQgQv6F0Ao4DH6U0@yury>
Message-ID: <aQiIUj2WfihMxF7M@google.com>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Nov 02, 2025 at 09:17:35PM -0500, Yury Norov wrote:
> On Fri, Oct 31, 2025 at 10:39:57PM +0900, Alexandre Courbot wrote:
> > Add the `BitInt` type, which is an integer on which the number of bits
> > allowed to be used is restricted, capping its maximal value below that
> > of primitive type is wraps.
> > 
> > This is useful to e.g. enforce guarantees when working with bit fields.
> > 
> > Alongside this type, provide many `From` and `TryFrom` implementations
> > are to reduce friction when using with regular integer types. Proxy
> > implementations of common integer traits are also provided.
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> >  rust/kernel/lib.rs        |   1 +
> >  rust/kernel/num.rs        |  75 ++++
> >  rust/kernel/num/bitint.rs | 896 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 972 insertions(+)
>  
> ...
> 
> > +/// Evaluates to `true` if `$value` can be represented using at most `$num_bits` on `$type`.
> > +///
> > +/// Can be used in const context.
> > +macro_rules! fits_within {
> > +    ($value:expr, $type:ty, $num_bits:expr) => {{
> > +        // Any attempt to create a `BitInt` with more bits used for representation than its backing
> > +        // type (i.e. create an invalid `BitInt`) must be aborted at build time.
> > +        build_assert!(
> > +            <$type>::BITS >= $num_bits,
> > +            "Number of bits requested for representation is larger than backing type."
> > +        );
> > +
> > +        let shift: u32 = <$type>::BITS - $num_bits;
> > +        let v = $value;
> > +
> > +        // The value fits within `NUM_BITS` if shifting it left by the number of unused bits, then
> > +        // right by the same number, doesn't change the value.
> > +        //
> > +        // This method has the benefit of working with both unsigned and signed integers.
> > +        (v << shift) >> shift == v
> 
> In C it doesn't work:
> 
>         int c = 0x7fffffff;
>         printf("%x\t%x\n", c, (c << 1) >> 1); // 7fffffff	ffffffff
> 
> Neither in rust:   
> 
>         let c: i32 = 0x7fffffff;
>         println!("{} {}", c, (c << 1) >> 1);  // 2147483647 -1
> 
> Or I misunderstand something?

I think we should probably just define a BitInt::MIN and BitInt::MAX
constant and have this code check MIN <= v && v <= MAX.

> > +    }};
> > +}
> > +
> > +/// Trait for primitive integer types that can be used to back a [`BitInt`].
> > +///
> > +/// This is mostly used to lock all the operations we need for [`BitInt`] in a single trait.
> > +pub trait Boundable
> > +where
> > +    Self: Integer
> > +        + Sized
> > +        + Copy
> > +        + core::ops::Shl<u32, Output = Self>
> > +        + core::ops::Shr<u32, Output = Self>
> > +        + core::cmp::PartialEq,
> > +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
> > +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
> > +{
> > +    /// Returns `true` if `value` can be represented with at most `NUM_BITS` on `T`.
> > +    fn fits_within(value: Self, num_bits: u32) -> bool {
> > +        fits_within!(value, Self, num_bits)
> > +    }
> > +}
> > +
> > +/// Inplement `Boundable` for all integers types.
> > +impl<T> Boundable for T
> > +where
> > +    T: Integer
> > +        + Sized
> > +        + Copy
> > +        + core::ops::Shl<u32, Output = Self>
> > +        + core::ops::Shr<u32, Output = Self>
> > +        + core::cmp::PartialEq,
> > +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
> > +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
> > +{
> > +}
> > +
> > +/// Integer type for which only the bits `0..NUM_BITS` are valid.
> > +///
> > +/// # Invariants
> > +///
> > +/// Stored values are represented with at most `NUM_BITS` bits.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::num::BitInt;
> > +///
> > +/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever be set.
> > +/// // The value `15` is statically validated to fit within the specified number of bits.
> > +/// let v = BitInt::<u8, 4>::new::<15>();
> 
> What for do you make user to declare the storage explicitly? From
> end-user perspective, declaring 4-bit variable must imply the most
> suitable storage... C version of the same doesn't allow user to select
> the storage as well:
> 
>         _BitInt(4) x = 8;
> 
> I can't think out any useful usecase for this... I believe that the
> optimal storage must be chosen by implementation. And it may even be
> different for different arches.

It's more complex to not specify the backing storage explicitly, but I
also think it would be nice to be able to avoid it.

> > +/// assert_eq!(v.get(), 15);
> > +///
> > +/// let v = BitInt::<i8, 4>::new::<-8>();
> > +/// assert_eq!(v.get(), -8);
> > +///
> > +/// // This doesn't build: a `u8` is smaller than the requested 9 bits.
> > +/// // let _ = BitInt::<u8, 9>::new::<10>();
> > +///
> > +/// // This also doesn't build: the requested value doesn't fit within the requested bits.
> > +/// // let _ = BitInt::<i8, 4>::new::<8>();
> > +///
> > +/// // Values can also be validated at runtime. This succeeds because `15` can be represented
> > +/// // with 4 bits.
> > +/// assert!(BitInt::<u8, 4>::try_new(15).is_some());
> > +/// // This fails because `16` cannot be represented with 4 bits.
> > +/// assert!(BitInt::<u8, 4>::try_new(16).is_none());
> 
> Nice! Maybe .is_overflow() instead of .is_none(), so that user will
> know that the variable contains truncated value. Just like C does.
> 
> Can you please print the exact error that user will get on compile-
> and runtime? How big is the cost of runtime test for overflow? If it
> is indeed nonzero, can you consider making the runtime part
> configurable?

This uses the stdlib type Option<_> that either contains a value
(Some(_)) or does not None, and .is_none() is a stdlib provided type so
we cannot configure its name.

> > +/// // Non-constant expressions can also be validated at build-time thanks to compiler
> > +/// // optimizations. This should be used as a last resort though.
> > +/// let v = BitInt::<u8, 4>::from_expr(15);
> 
> Not sure I understand that. Can you confirm my understanding?
> 
> 1. For compile-time initialization I use BitInt::<i8, 4>::new::<8>();
> 2. For compile- or runtime initialization: BitInt::<i8, 4>::from_expr(val);
> 3. For runtime-only initialization: BitInt::<i8, 4>::try_new(val);
> 
> In this scheme #3 looks excessive...

I'm not sure we should have `from_expr` at all. What it does is emit an
if condition checking whether the value is in-bounds containing a call
to a function that does not exist, so that if the optimizer prove the
range check at compile-time, then there is a linker error.

What is the use-case for from_expr?

> > +/// // Common operations are supported against the backing type.
> > +/// assert_eq!(v + 5, 20);
> > +/// assert_eq!(v / 3, 5);
> 
> No, v + 5 == 20 for a different reason. There's nothing about 'backing
> storage' here.
> 
> v + 5 should be 20 because addition implies typecasting to the wider
> type. In this case, 20 is numeral, or int, and BitInt(4) + int == int.
> 
> I tried C23, and it works exactly like that:
> 
>     unsigned _BitInt(4) x = 15;
> 
>     printf("%d\n", x + 5);                              // 20
>     printf("%d\n", x / 3);                              // 5
>     printf("%d\n", x + (unsigned _BitInt(4))5);         // 4
>     x += 5;
>     printf("%d\n", x);                                  // 4
> 
> Rust _must_ do the same thing to at least be arithmetically
> compatible to the big brother. 
> 
> It makes me more confident that this 'backing storage' concept
> brings nothing but confusion.

Rust has no such thing as automatic type casting between different
integer types at all. All that happened here is that BitInt has an
implementation of BitInt<T> + T and defined the output type to be T. As
far as I can tell, that's the only implementation of addition defined
for BitInt.

> > +/// // The backing type can be changed while preserving the number of bits used for representation.
> > +/// assert_eq!(v.cast::<u32>(), BitInt::<u32, 4>::new::<15>());
> > +///
> > +/// // We can safely extend the number of bits...
> > +/// assert_eq!(v.extend::<5>(), BitInt::<u8, 5>::new::<15>());
> > +/// // ... but reducing the number of bits fails here as the value doesn't fit anymore.
> > +/// assert_eq!(v.try_shrink::<3>(), None);
> 
> Not sure what for you need this. If I need to 'extend', I just assign
> the value to a variable:
> 
>         BitInt(3) a = 3;
>         BitInt(10) b;
>         int c;
> 
>         b = a + 123;    // extend
>         c = b;          // another extend

Rust has no such things as automatic type casting between different
integer types. Explicit casts are always required - also with normal
integer types.

> How would this 'extend' and 'shrink' work with arrays of BitInts?

We would need a separate method for the array case.

> > +/// // The same applies to signed values.
> > +/// asserkkt_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);
> > +///
> > +/// // This however is not allowed, as 10 bits won't fit into a `u8` (regardless of the actually
> > +/// // contained value).
> > +/// // let _ = u8::from(BitInt::<u32, 10>::new::<10>());
> 
> If I explicitly typecast from a wider type, please just let me do
> that. In the above examples you show that .is_some() and .is_none()
> can help user to check for overflow if needed.
> 
> Otherwise, user will hack your protection by just converting
> BitInt(8) to u32, and then to BitInt(10).

It is Rust convention that u8::from(..) must only compile if the
conversion is lossless. If you want to check overflow instead, you use
the different conversion method that exists for that purpose.

Alice

