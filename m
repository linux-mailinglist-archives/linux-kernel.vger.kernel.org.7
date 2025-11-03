Return-Path: <linux-kernel+bounces-883628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86354C2DEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BF2A4E83FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2390431D752;
	Mon,  3 Nov 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvOa1bXL"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC292BEC22
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198619; cv=none; b=SgFSZflRIo3H0QROJEg/wnxDOn+1GcoucqDTBSijX3Vbr+OLicj7jJXGL9lKulFRhM4ccpBlV3lXiF5HLd6Mv6pZ9UizhOA5p2jLI0d075sEIjXfuvApGXUvHzU5TibPrPpivJwubgadYslKtIlIGkrmYOHXrcYuFQVNcAk3jHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198619; c=relaxed/simple;
	bh=9mDHUSKMMJMS9yPRmY9DB1qxL7asARISOvShkHP+kBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFqqBfmug/nlHPJS5vUh1meWhoNboAS0ROdkhSe29tq7Ux4KvQcHMnX8djYHqVB0iuKQHWaxvxjiIOYfriv4VD7MPqQi9UCphHhopAuIa/1Cg051EG/Rs0Tb5WohEx2Qrsp8qW9Lrz1ToDLO+vFZ+vzSHqC2tgwwmc34hFc2Tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvOa1bXL; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63f5c80eebdso4823173d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198616; x=1762803416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xr4wS3gH5/GLWmTnD8t6gy4vyAyRRYeKXhP3ABNl1JM=;
        b=PvOa1bXLr/yQN0nGXACEIuXjlSpa2xX3anIL6lNkloeJnLjoeT4isD8RqLAnZTkQX5
         N9kn6UrlXqGPLeZm6MaW4sNu1nKzk40On2ljlgkQnYcdmWCXOPMZx2nD1kHaGjrYbpRa
         BRHhqOOcP5z1s3nXmVGRIhrL5jmroaTR7JKohbG1DNJ7qbQyhsbrdMUpi1nLV/xQ8BTd
         tRcHPvi7vUFZGjhRMiO6aojLJrTZvANyccmZwZ2uSjl3NkKUroN6goB4CX2Osv4Cat8R
         +idSDnHSIcG+0wUUqG3xvYXHI7zvDUmLBvUSKRtX/hItST3KO5RcwfsxkbCEb9f1uvPd
         VCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198616; x=1762803416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr4wS3gH5/GLWmTnD8t6gy4vyAyRRYeKXhP3ABNl1JM=;
        b=a30wzJW6W2Vz/uS4/PHjUiKZLyl8F/rJETYnVxfEFkKZE5FkiIjycKxEoZsOqjuvUs
         jawXlTvaSMDKbIkqGkjyLpXYihKU8XqL1ZhT15GvYbxR+XYsmG1gl0rL7vkLhQAvAORT
         CSxAsnOMjJuG4VbsweE8G3L6FKzD534ac/bKGzAkT+HTMgfn1LV37TW4L7xdkEM6PfpC
         siP1zwcVTIEB+WzChzD0Jul1bBsJ6DDoPMKd1iqsLa34FlTc/5+ynnnBrqaC/TAiJR+B
         0JnIl4bpPrkN4OXPgeJHls7PNS5WcmSJ7LncKiwuJzIlRY0wER+FvsgnVMOr3N2FvbsL
         WQaA==
X-Forwarded-Encrypted: i=1; AJvYcCWxaIbRiRZ51/egZggSQ+abkAdUnE2IUT7buFqeV1RnDSBG1vlCZ6QA4aR09uQnsWbHKI5usXwwxvLhRqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91qWGY9m1bKeQJCqkKwnoGNxPHoMS2IY21tb4LPXrRqtdrUPe
	8/xwpusLpUkQBuh5b15eQ3acLuKCmxQ5lRWYY7eh8qYibdXDqa7iOYxj
X-Gm-Gg: ASbGncvMRY9eCbMk49UD0OQeB2kHsMXt5u4kjc0bMnUZKixwWo01/X0IoQG5FC1IK2/
	rsLsfWxy/6tR8XipsTG118xfz90zrDB78tIfKugRyVED7sFHA1+Ku6SsJJnPHRhI+6gbwsT2c/5
	p8p7EVhVd5ZEtML9fEVhS7mxL0dRRmjU0DCRBgmQr/0rmGqtNlA6LctoSzDe1p1NYejbiX3g/SG
	Ct7DKv3WhDH6nBuxkuUI6JoJt8LpMdgIhzxwGsCRja5IPR+87VbhJjn828ogAvjcisgwtSQ05ZX
	ncCcPik1k2glmQEKzt9cM80WVU9Wj/cPRdIl6pfwXcw73ik/HSjfvPwOp2TLCRZ2FjmOzSQHQ1m
	g3NDul/v+usntqlKE82UQzdsvZdrwQ60QG7qm+1ApvnAvGiyYigp0Qm7o/EYfYiHfNvm5u9qVW+
	3d0UwbJB7JgmJShbW891a0h9AGcdmerqnp9ACKWoVnLYtnlZhh7Jw2zA==
X-Google-Smtp-Source: AGHT+IFcIZTRHjiifLDGv3J39jp+BHxEnNRKJN3s0Nxj1tnwf8PGtiDPI6g2tpQd7+GIqX6vtPg4JA==
X-Received: by 2002:a05:690e:4199:b0:63f:b9d1:b153 with SMTP id 956f58d0204a3-63fb9d1bf74mr2407418d50.40.1762198616161;
        Mon, 03 Nov 2025 11:36:56 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f96a50f2esm3272617d50.15.2025.11.03.11.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:36:55 -0800 (PST)
Date: Mon, 3 Nov 2025 14:36:54 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Message-ID: <aQkEVqbhoVMUc-Km@yury>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury>
 <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>

On Mon, Nov 03, 2025 at 10:42:13PM +0900, Alexandre Courbot wrote:
> Hi Yury,
> 
> On Mon Nov 3, 2025 at 11:17 AM JST, Yury Norov wrote:
> > On Fri, Oct 31, 2025 at 10:39:57PM +0900, Alexandre Courbot wrote:
> >> Add the `BitInt` type, which is an integer on which the number of bits
> >> allowed to be used is restricted, capping its maximal value below that
> >> of primitive type is wraps.
> >> 
> >> This is useful to e.g. enforce guarantees when working with bit fields.
> >> 
> >> Alongside this type, provide many `From` and `TryFrom` implementations
> >> are to reduce friction when using with regular integer types. Proxy
> >> implementations of common integer traits are also provided.
> >> 
> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >> ---
> >>  rust/kernel/lib.rs        |   1 +
> >>  rust/kernel/num.rs        |  75 ++++
> >>  rust/kernel/num/bitint.rs | 896 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 972 insertions(+)
> >  
> > ...
> >
> >> +/// Evaluates to `true` if `$value` can be represented using at most `$num_bits` on `$type`.
> >> +///
> >> +/// Can be used in const context.
> >> +macro_rules! fits_within {
> >> +    ($value:expr, $type:ty, $num_bits:expr) => {{
> >> +        // Any attempt to create a `BitInt` with more bits used for representation than its backing
> >> +        // type (i.e. create an invalid `BitInt`) must be aborted at build time.
> >> +        build_assert!(
> >> +            <$type>::BITS >= $num_bits,
> >> +            "Number of bits requested for representation is larger than backing type."
> >> +        );
> >> +
> >> +        let shift: u32 = <$type>::BITS - $num_bits;
> >> +        let v = $value;
> >> +
> >> +        // The value fits within `NUM_BITS` if shifting it left by the number of unused bits, then
> >> +        // right by the same number, doesn't change the value.
> >> +        //
> >> +        // This method has the benefit of working with both unsigned and signed integers.
> >> +        (v << shift) >> shift == v
> >
> > In C it doesn't work:
> >
> >         int c = 0x7fffffff;
> >         printf("%x\t%x\n", c, (c << 1) >> 1); // 7fffffff	ffffffff
> >
> > Neither in rust:   
> >
> >         let c: i32 = 0x7fffffff;
> >         println!("{} {}", c, (c << 1) >> 1);  // 2147483647 -1
> >
> > Or I misunderstand something?
> 
> For a short while I though this was indeed not working, to my despair as
> this looked like an elegant solution.

No it does not. One suggested by Alice is better because it's more
straightforward.
 
> But then I considered why we are doing that shift by 1 in the first
> place: that would be because we are intent on using only 31 of the 32
> bits of the `0x7fffffff` value, in order to encode a signed number.
> 
> And the positive `0x7fffffff` value cannot be encoded as a signed
> integer of 31 bits, as after ignoring the MSB the next bit (which would
> be the sign bit) is `1`. So the post-shift value differs from the
> original one, and the creation of a `BitInt<i32, 31>` for that value
> fails, which is working as intended.
> 
> If OTOH we did the same operation for a `BitInt<u32, 31>`, the
> non-signed nature of the value would make the shift-and-back operation
> produce the same value as the initial one - allowing the creation of the
> `BitInt`, which again is correct because `0x7fffffff` can be
> represented as an unsigned value using 31 bits.
> 
> I have tested both cases successfully - so this way of validating still
> looks correct to me.

I read this carefully more than once, but still can't understand. So
I gave your macro a try:

  macro_rules! fits_within {
      ($value:expr, $BITS:expr, $num_bits:expr) => {{
          let shift: u32 = $BITS - $num_bits;
          let v = $value;
  
          (v << shift) >> shift == v
      }};
  }
  
  fn main() {
      let a: i32 = -1;
      let b: i32 = 0x7fffffff;
  
      println!("{}", fits_within!(a, 32, 31)); // true
      println!("{}", fits_within!(b, 32, 31)); // false
  }

This is exactly opposite to what I naively expect: 32-bit '-1'
shouldn't fit into 31-bit storage, but 31-bit 0x7fffffff should.

And said aloud, my naive expectation is: fits_withing() must
return true iff typecasting from one type to another followed
by typecasting back to the original type would not change the
value.

Nevermind. Let's consider a more practical example: I read some
12-bit ADC with a C function:

        int read_my_adc();

It gives me either some 12-bit value, or errno, like -EAGAIN. Let's
assume my ADC is differential, and bit 11 encodes sign of the output.
Now, I want to put it into a 12-bit variable. So:
        
        let val = read_my_adc(); // -EAGAIN
        fits_within!(val, i32, 12);

returns true. This is surely not what one would expect.

This is one more example:

        let a: i64 = -1i64;
        println!("{}", fits_within!(a, 32, 31));

Here you exceed even the 'backing storage', but still return OK.

> >> +    }};
> >> +}
> >> +
> >> +/// Trait for primitive integer types that can be used to back a [`BitInt`].
> >> +///
> >> +/// This is mostly used to lock all the operations we need for [`BitInt`] in a single trait.
> >> +pub trait Boundable
> >> +where
> >> +    Self: Integer
> >> +        + Sized
> >> +        + Copy
> >> +        + core::ops::Shl<u32, Output = Self>
> >> +        + core::ops::Shr<u32, Output = Self>
> >> +        + core::cmp::PartialEq,
> >> +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
> >> +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
> >> +{
> >> +    /// Returns `true` if `value` can be represented with at most `NUM_BITS` on `T`.
> >> +    fn fits_within(value: Self, num_bits: u32) -> bool {
> >> +        fits_within!(value, Self, num_bits)
> >> +    }
> >> +}
> >> +
> >> +/// Inplement `Boundable` for all integers types.
> >> +impl<T> Boundable for T
> >> +where
> >> +    T: Integer
> >> +        + Sized
> >> +        + Copy
> >> +        + core::ops::Shl<u32, Output = Self>
> >> +        + core::ops::Shr<u32, Output = Self>
> >> +        + core::cmp::PartialEq,
> >> +    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
> >> +    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
> >> +{
> >> +}
> >> +
> >> +/// Integer type for which only the bits `0..NUM_BITS` are valid.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// Stored values are represented with at most `NUM_BITS` bits.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// ```
> >> +/// use kernel::num::BitInt;
> >> +///
> >> +/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever be set.
> >> +/// // The value `15` is statically validated to fit within the specified number of bits.
> >> +/// let v = BitInt::<u8, 4>::new::<15>();
> >
> > What for do you make user to declare the storage explicitly? From
> > end-user perspective, declaring 4-bit variable must imply the most
> > suitable storage... C version of the same doesn't allow user to select
> > the storage as well:
> >
> >         _BitInt(4) x = 8;
> >
> > I can't think out any useful usecase for this... I believe that the
> > optimal storage must be chosen by implementation. And it may even be
> > different for different arches.
> 
> Alice provided a good justification in her reply, but let me elaborate a
> bit more.

This is what Alice said:

  It's more complex to not specify the backing storage explicitly, but I
  also think it would be nice to be able to avoid it.

I agree with her. But I don't see any justification here for the
proposed approach.

TBH, I think it's not too complicated to realize that the best
backing storage for an N-bit value is 2^(ceil(log(N)))-bit type,
unless arch specifics comes in play.

I also think that you can bake first version based on 64-bit backing
storage, regardless of number of bits, so tailoring BitInt() would
be a future improvement.

> C allows itself to implicitly cast values when performing operations.
> For instance:
> 
>     signed char a = -128;
>     unsigned int b = 120;
>     unsigned short c = b + a;
> 
>     printf("%d\n", c);
> 
> This absolutely not confusing program is perfectly valid and prints
> `65528`.
> 
> For the equivalent code in Rust:
> 
>     let a = -128i8;
>     let b = 120u32;
>     let c: u16 = b + a;
> 
> I don't even bother printing the result because these 3 lines alone
> produce 3 build errors. Rust doesn't let you perform operations on
> primitive integers that are not exactly the same type.
> 
> So that's the first reason for explicitly passing a type: so you can
> perform the operations you want with your `BitInt` without jumping
> through cast hoops. This is particularly important to use it with
> bitfields, which is the primary goal.

OK, that's really a Rust innovation. So, if we follow the rule, I have
two and a half considerations:

1. It also means that BitInt(u8, 4) and BitInt(u8, 5) should be the
different types, and you shouldn't be able to do arithmetics with them
even if the backing types match. Can you confirm that?

2. Later in your patch you allow this:

  let v = BitInt::<u32, 4>::new::<15>();
  assert_eq!(v * 10, 150);

This one is really misleading. You allow me to multiply 4-bit number
by 10, which looks really C-like, and produce an extended result, just
like C does. But from what you say here, and Miguel in another email,
it breaks the spirit of Rust types safety.

2a. Here you allow to do:

  let v = BitInt::<i32, 4>::new::<15>();
  let n = -EINVAL;
  assert_eq!(v + n, -7);

And this is not OK. To follow Rust way, you need to convert n to
BitInt(4), and then it would work as expected - making sure it's
impossible and throwing an overflow.

> Another reason is that even if you don't care about the size of the
> storage, you should care about its signedness, which is part of the
> type.

Just invent BitUint or unsigned BitInt, or teach the macro to
understand BitInt(i12) notation.

> I played a bit with C's `_Bitint`, and managed to produce this
> wonder:
> 
>     _BitInt(8) v = -1;
>     printf("%d\n", v);
> 
> This programs prints `255`, even though I used the signed "%d"
> formatter? Maybe that's because I should make my `_BitInt` explicitly
> signed?
> 
>     signed _BitInt(8) v = -1;
>     printf("%d\n", v);
> 
> Nope. Still `255`. Go figure. ¯\_(ツ)_/¯

Clang throws Wformat on this; and it is printf() issue, not the
_BitInt()s math bug.

> You cannot do that with our implementation. You either specify
> 
>     let v = BitInt::<i8, 8>::new::<-1>();
> 
> and get a proper, signed `-1` value that prints properly, or do
> 
>     let v = BitInt::<u8, 8>::new::<-1>();
> 
> and get the build error you should get. No ambiguity, no surprises.
> 
> >
> >> +/// assert_eq!(v.get(), 15);
> >> +///
> >> +/// let v = BitInt::<i8, 4>::new::<-8>();
> >> +/// assert_eq!(v.get(), -8);
> >> +///
> >> +/// // This doesn't build: a `u8` is smaller than the requested 9 bits.
> >> +/// // let _ = BitInt::<u8, 9>::new::<10>();
> >> +///
> >> +/// // This also doesn't build: the requested value doesn't fit within the requested bits.
> >> +/// // let _ = BitInt::<i8, 4>::new::<8>();
> >> +///
> >> +/// // Values can also be validated at runtime. This succeeds because `15` can be represented
> >> +/// // with 4 bits.
> >> +/// assert!(BitInt::<u8, 4>::try_new(15).is_some());
> >> +/// // This fails because `16` cannot be represented with 4 bits.
> >> +/// assert!(BitInt::<u8, 4>::try_new(16).is_none());
> >
> > Nice! Maybe .is_overflow() instead of .is_none(), so that user will
> > know that the variable contains truncated value. Just like C does.
> >
> > Can you please print the exact error that user will get on compile-
> > and runtime? How big is the cost of runtime test for overflow? If it
> > is indeed nonzero, can you consider making the runtime part
> > configurable?
> 
> `is_none()` comes from the `Option` type, so we cannot change its name
> and it's the idiomatic way to do anyway.

I understand. I suggested to implement this .is_overflow(), and have
.is_none() reserved for cases like assigning floating values to
unsigned type.

> The runtime cost for overflow is the double-shift and comparison with
> the initial value.

Are you sure that everyone is OK to pay this runtime cost, especially
after passing debug phase?

> >> +/// // Non-constant expressions can also be validated at build-time thanks to compiler
> >> +/// // optimizations. This should be used as a last resort though.
> >> +/// let v = BitInt::<u8, 4>::from_expr(15);
> >
> > Not sure I understand that. Can you confirm my understanding?
> >
> > 1. For compile-time initialization I use BitInt::<i8, 4>::new::<8>();
> > 2. For compile- or runtime initialization: BitInt::<i8, 4>::from_expr(val);
> > 3. For runtime-only initialization: BitInt::<i8, 4>::try_new(val);
> >
> > In this scheme #3 looks excessive...
> 
> This example was not very good. The v2 features a better one:
> 
>     let v = BitInt::<u32, 4>::from_expr(some_number() & 0xf);
> 
> Here assume that `some_number()` returns a random value. You cannot use
> the static `new` constructor, as the exact value is not statically
> known, so the alternative would be to use `try_new` and check for an
> overflow error you know cannot happen because the value is masked with
> `0xf` and thus will fit the 4 bits.
> 
> `from_expr` allows you to create this `BitInt` infallibly, by relying on
> the compiler being smart enough to infer from the mask operation that
> the value will indeed satify the constraints of the `BitInt`, and throws
> a linker error if it couldn't. If the program builds, there is no need
> for error checking and no runtime validation.

So from_expr() only allows statically true expressions, like this one

        some_number() & 0xf < 16.

And try_new() allows true runtime fallible ones.

Looks like OK... But this ::new<8>() syntax really looks overloaded.

> >> +/// // Common operations are supported against the backing type.
> >> +/// assert_eq!(v + 5, 20);
> >> +/// assert_eq!(v / 3, 5);
> >
> > No, v + 5 == 20 for a different reason. There's nothing about 'backing
> > storage' here.
> >
> > v + 5 should be 20 because addition implies typecasting to the wider
> > type. In this case, 20 is numeral, or int, and BitInt(4) + int == int.
> >
> > I tried C23, and it works exactly like that:
> >
> >     unsigned _BitInt(4) x = 15;
> >
> >     printf("%d\n", x + 5);                              // 20
> >     printf("%d\n", x / 3);                              // 5
> >     printf("%d\n", x + (unsigned _BitInt(4))5);         // 4
> >     x += 5;
> >     printf("%d\n", x);                                  // 4
> >
> > Rust _must_ do the same thing to at least be arithmetically
> > compatible to the big brother. 
> 
> Rust doesn't do implicit casts. I do agree that "backing storage" is not
> the best choice of words though.

In fact, in "assert_eq!(v + 5, 20)" the '5' is implicitly typecasted
to the backing storage type.

In other words, Rust doesn't prohibit typecasting. It just typecasts
to the most restricted type, instead than most relaxed one.

> > It makes me more confident that this 'backing storage' concept
> > brings nothing but confusion.
> >
> >> +/// // The backing type can be changed while preserving the number of bits used for representation.
> >> +/// assert_eq!(v.cast::<u32>(), BitInt::<u32, 4>::new::<15>());
> >> +///
> >> +/// // We can safely extend the number of bits...
> >> +/// assert_eq!(v.extend::<5>(), BitInt::<u8, 5>::new::<15>());
> >> +/// // ... but reducing the number of bits fails here as the value doesn't fit anymore.
> >> +/// assert_eq!(v.try_shrink::<3>(), None);
> >
> > Not sure what for you need this. If I need to 'extend', I just assign
> > the value to a variable:
> >
> >         BitInt(3) a = 3;
> >         BitInt(10) b;
> >         int c;
> >
> >         b = a + 123;    // extend
> >         c = b;          // another extend
> >
> > How would this 'extend' and 'shrink' work with arrays of BitInts?
> 
> I think this discussion would be more productive if we don't rely on
> examples in a language that is irrelevant for the current patch. :)

The language I rely on is called 'pseudo language', and it is perfectly
OK as soon as it helps me to describe my intention. If you want me to
start thinking in Rust, please make it more friendly. The following is
really a nightmare:

        let a = BitInt::<u8, 3>::new::<3>();
        let b = BitInt::<u16, 10>::new::<123>() + BitInt::<u16, 10>::try_from(a);

        let c = BitInt::<u32, 32>::try_from(a) + BitInt::<u32, 32>::try_from(b);

> Rust does not allow overloading the `=` operator, so these implicit
> conversions from one type to another cannot be performed. Having
> dedicated methods is an idiomatic way to do this according to my
> experience - an alternative would be to have `From` implementations, but
> doing this elegantly would require one language feature (generic const
> expressions) that is still not stable.
> 
> >
> >> +/// // Conversion into primitive types is dependent on the number of useful bits, not the backing
> >> +/// // type.
> >> +/// //
> >> +/// // Event though its backing type is `u32`, this `BitInt` only uses 8 bits and thus can safely
> >> +/// // be converted to a `u8`.
> >> +/// assert_eq!(u8::from(BitInt::<u32, 8>::new::<128>()), 128u8);
> >
> > 'Backing type' is useless here too.
> >
> >> +/// // The same applies to signed values.
> >> +/// asserkkt_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);
> >> +///
> >> +/// // This however is not allowed, as 10 bits won't fit into a `u8` (regardless of the actually
> >> +/// // contained value).
> >> +/// // let _ = u8::from(BitInt::<u32, 10>::new::<10>());
> >
> > If I explicitly typecast from a wider type, please just let me do
> > that. In the above examples you show that .is_some() and .is_none()
> > can help user to check for overflow if needed.
> >
> > Otherwise, user will hack your protection by just converting
> > BitInt(8) to u32, and then to BitInt(10).
> 
> Doing so would require validating that the value in the `u32` can fit
> within the 10-bit `BitInt` one way or the other, so the protection
> cannot be bypassed that way.

That's what I meant. You allow one way to initialize data, but
disallow another equivalent and more straightforward way.
 
> After comparing this implementation with C's `_BitInt`, I have also come
> to a more fundamental divergence between the two.
> 
> The C `_BitInt` is used to express numbers with an arbitrary number of
> bits - which could be less than a primitive type, but also *more* - for
> instance a `_BitInt(4094)` is a valid thing!
>
> Which is really cool, but also not something we need or want in the
> kernel. Our purposes here is strictly to limit the width of existing
> primitive types to provide extra guarantees about the code. And even if
> we wanted to mimic the C `_BitInt`, we simply couldn't without compiler
> support as literal values larger than a primitive type cannot even be
> expressed.
> 
> So although I liked the `BitInt` name, that makes it quite a bit
> misleading for our type as users could think that they will have an
> equivalent to the C namesake, while the purpose and use is different.

Great idea by the way. For the next iteration, can you please start with
a Documentation patch that discusses all that things.

What is the purpose and use of rust BitInts?
What is the difference with C, other than 64-bit limitation?

In my understanding, BitInt is purposed to be the fundamental type.
OK, you say we can't override the '=', and have to use the new() and 
from() for initialization. But with that in mind, in every other
aspect BitInt(u32) should behave like u32, and BitInt(i12) should be i12.

C is really close to it. 

Thanks,
Yury

> The original `BoundedInt` name was a more accurate fit IMHO, but I hope
> we can find something shorter.


