Return-Path: <linux-kernel+bounces-882125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C8C29B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 01:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A049C3AFCA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 00:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223C18FDDE;
	Mon,  3 Nov 2025 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaDKXJjg"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E48488
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762129130; cv=none; b=SMG89Si8X63qZlag6cTWmcGToXlQX0Q3MedC8hoEGOtqpjwIyNFE8WouVf8m3CUa3C2fgdF/X8KnP25krulF+b+lRC7qY0vDBb5ykemNfOFLucdv5yzTLMbwd6f8WIyjHSn6IUtKQqiXbMOKglP6Kqvld3XV8HO2kpYPP48vpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762129130; c=relaxed/simple;
	bh=UhdjQQP93B6vmu1KrkGTVUK12Zh3nn6hyDInXpAyet4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEMbOchkGRv05ZbT6I22FOI22F8TGwVTw0u41JUXBNeiqjNZH/8KeDuDbPejKATgdZCIgG8Ay7a7NODRmQd0+qGdNIhBze97uvwy8jtEKG8AXq1JJWe+dKLWb29RFFQ8yWSjWUqGlA5/IkUmT6wcJeO/iaybFOwv6WyTCisr7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaDKXJjg; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-433217b58d9so4724475ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762129127; x=1762733927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lbukBbCI6fFMOGWwEkWiHxAZwAf/KbN3KB3I9KpMMx8=;
        b=ZaDKXJjguIVcCgX9HrhTMnV3zSTzHh4UhPQpFgVEy4ReIy3EQtVj7hjLttOk7g2ZDZ
         cn9KNwB7uorN1ktgjYZ8O5p29lXgRk2Ty3Q6ypFyuQ5zFhcVgB/q0cGekT/znLwcbFf+
         Xnk4VOQd0R4d8dozWKgVc2UYAc7NnnBoL4I2zTAb3U1uOiyNoq+Rv7LSzR+rsXEFLzpU
         GDleHsP6XtSIoE0x+H4r5/LD2d9J9gKJJTUNVUoSTKap5JAC75k6iUn1St7WKlCTqcMj
         N9mUUXSYfjLo93Ivzmw2N31Dpdq6yxHHFOuHSi6BKeF/me1HfLbZkKcIxVcYzlyIZChi
         D7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762129127; x=1762733927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbukBbCI6fFMOGWwEkWiHxAZwAf/KbN3KB3I9KpMMx8=;
        b=xQLRrZXzzFiLC1WnLBtVaLwyX1iZ+CiOYhWRwvVI/vnanquvugbdWWSyfhBPO42JN4
         s2QVeENg5EB6XQGeGuaM33krQvqLmFagfXu7Ern+u+t6VqhjlBqPQMtrF4/dHvTVs/Y9
         hp7JOa56D70PDNmjT7UGUN/oMjrcPHCuI7/jp/GEjc2ip0S/I6XnqayPNvbvujVLNv3C
         ZfOO1ff0vFK7g3TS0S4N13FH1K/KpiqAosacDEAJDKutn+qJWBommeGSIuzmn+rAyRnI
         pYcny2snpUuSIYIM9oN0JQwnGyZIEuOG1B00ZwQpfHz18i5mz6v9XXyG86+d2n1AgV3s
         vB4A==
X-Forwarded-Encrypted: i=1; AJvYcCUciis+KVzkvbMgK3hkDF5IBuB100E2cy6Wg0yHLQxm4PjJNhCHPO/jInGyEJC/xLl6XwZoLLdhtiXQ3lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLeYyx7I9csGhh6TOFRpPBhs2vUEwCHPlvFwwhZIYW7dPODHn
	6INbRl8JN0MtujYATesknfsZCHX9iDSGPs7kxMcOO7Ym1T+CB9G+0uaBJNkJd4TOAoLwp+J3XE3
	07hWckPsfn6r+bMLC8JYB3Z5Oge2HCmQ=
X-Gm-Gg: ASbGncuCW635rrHzCTN9vmy3CSnn7V5gn/XjGg3uCG4E3bi0TzTloCzLSy/Q6MFfeCo
	PeFaYmTi3L+NB/F4+mm0z1lcsbENdDpDi92xb5x/t86eypNjO/DCOA4VQv9zbxd1d7n0HHP0GF6
	8WL7MufJMDJfuiyA3IoeknjA7QyZuVlIL0HIekPl/AyWuTBzLgHWc3vSfRbnRBz/8zR6urTiSTq
	lzV6KWfCxl1+F8C/HjCtHo4Ktgd6UKS+LrTdYPJRYLiO4qTkIfi8apRWNan2/e6bdaQLqjXFJWD
	OHg=
X-Google-Smtp-Source: AGHT+IEinxxKyGpY13CBZYEiEZRj5ZtrHLcrvHXjjmmISTFYSNVaHSlve6zbB1g6ISy0GNLADF79gcMJCySg/fAhlK4=
X-Received: by 2002:a05:6e02:221e:b0:433:2d0f:e95d with SMTP id
 e9e14a558f8ab-4332d0ff57fmr29075505ab.27.1762129127059; Sun, 02 Nov 2025
 16:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com> <CANiq72nbERSOWKRUTJ96YYKCDeAoHLBuiVP+XkDUKg7JYkoyiA@mail.gmail.com>
 <CA+tqQ4KG98XcWh3rkAxEOiACSUtPf7KM0Wqh9Af=POgVDHJzzw@mail.gmail.com>
 <CANiq72kE89ukxpf3L0_jFOdv51TDtjjj3r=1mjJzdGWJwmAbaQ@mail.gmail.com>
 <CA+tqQ4J7_z7_NmUNojJttF1e8GRR8Ua9w0Rap1t-U4gYPhQ1Yg@mail.gmail.com> <DDHU4LL4GGIY.16OJMIL7ZK58P@nvidia.com>
In-Reply-To: <DDHU4LL4GGIY.16OJMIL7ZK58P@nvidia.com>
From: Jesung Yang <y.j3ms.n@gmail.com>
Date: Mon, 3 Nov 2025 09:18:35 +0900
X-Gm-Features: AWmQ_bmjwfOG0Fsadhki6hbGrYasLvIYy1-mvKZIH8xEYEub_dTdviKWOD4hlxE
Message-ID: <CA+tqQ4+NY2zFJrr2omGqQcVG1N4cJBgYNO8qH=TFi5UG_vLfTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 14, 2025 at 3:35 PM Alexandre Courbot <acourbot@nvidia.com> wrote:
[...]
> This might not be too difficult to shoehorn as there is an
> `is_in_bounds!` macro (which we can turn into a const method if that's
> more suitable) that your proc macro could leverage, but I can't help but
> thing that maybe there is a better, more general solution than
> special-casing this?
>
> [1] https://lore.kernel.org/rust-for-linux/20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com/

I've tried your `BitInt` series, and I think I can generalize (at
least the overflow check) even without the help of `fits_within!`.
Since I can retrieve the number of valid bits and the signedness of a
given integer type (including `BitInt`) while parsing the helper
attributes, I can use that information to check whether casting from
a value of type T to type U would overflow. Here's a sketch using
declarative macro syntax to demonstrate the idea:

```
// I'll write a function that returns equivalent `TokenStream`, which
// is suitable for procedural macros.
macro_rules! check_overflow {
    ($val:expr, $src_ty:ty, $dst_ty:ty, $dst_nbits:expr) => {{
        let val: $src_ty = $val;

        // For every integer type (including `BitInt`), its minimum
        // value always fits in `i128`.
        let dst_min =
            (<$dst_ty>::MIN >> (<$dst_ty>::BITS - ($dst_nbits))) as i128;
        // For every integer type (including `BitInt`), its maximum
        // value always fits in `u128`.
        let dst_max =
            (<$dst_ty>::MAX >> (<$dst_ty>::BITS - ($dst_nbits))) as u128;

        #[allow(unused_comparisons)]
        let is_src_signed = <$src_ty>::MIN < 0;
        #[allow(unused_comparisons)]
        let is_dst_signed = dst_min < 0;

        let fits = if is_src_signed && is_dst_signed {
            // Casting from a signed value to `i128` does not
            // overflow since `i128` is the largest signed
            // primitive integer type.
            (val as i128) >= dst_min && val <= dst_max
        } else if !is_src_signed && !is_dst_signed {
            // Casting from an unsigned value to `u128` does not
            // overflow since `u128` is the largest unsigned
            // primitive integer type.
            (val as u128) <= dst_max
        } else if is_src_signed && !is_dst_signed {
            // Casting from a signed value greater than 0 to `u128`
            // does not overflow since since `u128::MAX` is
            // greater than `i128::MAX`.
            val >= 0 && (val as u128) <= dst_max
        } else {
            // Casting from an unsigned value to `u128` does not
            // overflow since `u128` is the largest unsigned
            // primitive integer type.
            (val as u128) <= dst_max
        };

        !fits
    }};
    // Yes, we can also support `bool`!
    ($val:expr, $src_ty:ty, bool) => {{
        let val: $src_ty = $val;

        let fits = val == 0 || val == 1;

        !fits
    }};
}

// For a `#[repr(i32)]` enum with `#[try_from(BitInt<u8, 4>)]` and
// `#[into(BitInt<u8, 4>)]`:
check_overflow!(Enum::A as i32, i32, u8, 4);

// For a `#[repr(i32)]` enum with `#[try_from(u8)]` and `#[into(u8)]`:
check_overflow!(Enum::A as i32, i32, u8, u8::BITS);

// For a `#[repr(i32)]` enum with `#[try_from(bool)]` and
// `#[into(bool)]`:
check_overflow!(Enum::A as i32, i32, bool);
```

It is somewhat similar to `fits_within!`, but it also cares signedness
differences between source and destination types.

It might help if `BitInt` exposed `MIN` and `MAX` associated constants
in terms of its backing type:

```
macro_rules! impl_max_min {
    ($($type:ty),+) => {
        $(
        impl<const NUM_BITS: u32> BitInt<$type, NUM_BITS> {
            pub const MIN: $type =
                <$type>::MIN >> (<$type>::BITS - NUM_BITS);
            pub const MAX: $type =
                <$type>::MAX >> (<$type>::BITS - NUM_BITS);
        }
        )+
    };
}
impl_max_min!(u8, u16, u32, u64, i8, i16, i32, i64);
```

... but for consistency with existing primitive integer types, these
constants would ideally be of type `BitInt` instead of the backing
type, which unfortunately limits their usefulness in implementing
`check_overflow!`.

As a final side note: as you're already aware, breaking changes to
`BitInt` will also affect the `TryFrom` and `Into` derive macros, since
these macros depend on certain public APIs provided by `BitInt`. The
same applies to any future custom types that require support from these
macros. That said, I'll do my best to minimize the dependency wherever
possible.

Best Regards,
Jesung

