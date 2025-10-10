Return-Path: <linux-kernel+bounces-848083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDBBCC780
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892DD1A65799
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6922ED870;
	Fri, 10 Oct 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv+2ROuZ"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6B277037
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090893; cv=none; b=FuuITksiyfkfDMTURNgCtBHg7VOfhdG+TbIUCq27570IxRa06R2xxAmNDpuCBd8RzhC1/b5borVVJrTLu++EmkzsfDIAqKL9yO+sGI6+UY7kDqfa4ef0OB7BTGjuc8PgItfsEdywpD++8iRX9Owe0Bluf5+I/dQmHDQAjofNkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090893; c=relaxed/simple;
	bh=757Rw+peN+Z+BJ0/8voAoRMaixAMA8al/pwz/vHpLTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpBBZjKhXOQ4CUCAYQYqXN93zY2KGnULsG80of+TDC44sGD6H5NMXoc52L4YMZKR8s9rn3SilaPlFI5G3mt4Ya+4UD64TK8jVxyU7dCwaoMvy6oez/Hh/lTalf8/RM5TYODj4H7AIYsFh4Roz50nZwcNrguuVDpBO+/VDkD0nvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv+2ROuZ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-425911e5661so7250875ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760090891; x=1760695691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuJuRZhLwsG+1iMul2+WUv/TYmYlRZZULI5AyK9zhk=;
        b=gv+2ROuZoZuZIfM+32jfHanl8Umoxdr8Z4l10AxpS6wpSMdSlQvpoa6KNvOaoh/LYh
         NLAGd8YVtr29csVKesy5gAjCixVkL7Th8LfhqES27iPdu5cmadLqLPYNbpLd4oXmS/vt
         3CaULv6/DMh4m31eDsXW9jSm6MFBc8RKMOySPPcC5O69GrqC7LYcFQXqMVn74QMZK0hV
         qe3eHEf/3oxFe1cYtkL+aJ983kQ7dsWDrO7XEtfVOt/diK2b6eiJO85SreSmOzDSgeHd
         ub1fblu6wOrcrloGo4rVwkynCSvq7P74pnsaZoLun+1s3V4PQHqvfMQJwcgM2OfSgiXQ
         CM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090891; x=1760695691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JuJuRZhLwsG+1iMul2+WUv/TYmYlRZZULI5AyK9zhk=;
        b=xNWznpNwTk/+hQ5jZBHpKH+qSvPLmgvzh8IZDdri6aHkn69RDa/sn+AN2vQprLCjkI
         Wd9Q2FqzRmC2hoiu1+u2XgaChWpT7e+y2iBjkEug+ERDWFU8VDFPvr9olZR3okMWOtdt
         Ca+EvwLa4tPn+pSaq15YbXlrMWqjalaSPNenCZTMnNhVfKUwLtbjOiLbz2JzpfZNHMqf
         X+fsLSgxVIPHHr510y/CyrloU5WQHezUTyYbq9nBHZkHKbz3bgS4bupm3/9d7ClGmyix
         +Zl+G61ktGBjQIbGemXJ6jPU1w5dUpT7VUfTptxAwoWrZ6znLtIDLVogOUgbPMtgoX7i
         /hGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDcU/GxHilJgwAXMNWy28QELOuP0F7L80iD/QYALaFLmlCviR+tbgnoCM/MABCJUUVYe1wfm9GXXjVtrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjDv2KSUqMV5RjTUaq39ytVLbre03w7LJusgcPJt6a/L8yb2X
	Ima7MgLUenImPO21WhZ+bR8DWq0uKxE6P7Y5S47Yo3MnPb8oGZOSJuDKs+xJt5GnyAYPq4fY/Hv
	StaczASy/92C5PGghMbZd89h/vQFzZeM=
X-Gm-Gg: ASbGnctnxahYpe2hSzPbJP/p25EXFAU+7Yc98MsR2A53z3lLplrV6NTAg/YSrfYyjwM
	OG2jSlCJ1qlv+ChuWedIgKXs8EgYgV6h+l/tRiInZUSGHNHXV3/xnSpX/ThwcxX2JGyFMfDDj0O
	jyI5uDyNTNyJbPSV+bXyXHWuB7j2c7ggksGM2UyPRM2L81rRarGa/hJa2fRKAiEswq65D1FVBha
	ncbhpG3F2xzTqrVi977O0a86eOGHuTjH6hyrSo1uw==
X-Google-Smtp-Source: AGHT+IGuRdBMYAkwKzsAFlzdYolufmnZhc4gT3Qkanm3b+H0ZT0F+1Fkx1oHfqeGTKvMgS5xq+3CPhlmxRxpaK9+R9M=
X-Received: by 2002:a05:6e02:18c5:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-42f873f432amr105318985ab.27.1760090890836; Fri, 10 Oct 2025
 03:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com> <CANiq72nbERSOWKRUTJ96YYKCDeAoHLBuiVP+XkDUKg7JYkoyiA@mail.gmail.com>
In-Reply-To: <CANiq72nbERSOWKRUTJ96YYKCDeAoHLBuiVP+XkDUKg7JYkoyiA@mail.gmail.com>
From: Jesung Yang <y.j3ms.n@gmail.com>
Date: Fri, 10 Oct 2025 19:07:58 +0900
X-Gm-Features: AS18NWBVMcBD24mf1KqbL440nVAyfGu-ZCbyG3tLNt_guISUTjnPv0xN-eS_TOI
Message-ID: <CA+tqQ4KG98XcWh3rkAxEOiACSUtPf7KM0Wqh9Af=POgVDHJzzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 1, 2025 at 5:13=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
[...]
>   - My biggest concern is the overflow caveat, which is a fairly big
> one if one, especially if one is dealing with runtime values.
>
>     Can we do better? Accessing the discriminant via `as` is available
> in const context, and you already have every variant easily available,
> so can we check that every variant fits in the relevant target types?
>
>     For instance, by creating some item-level const blocks
> (`static_assert!`s) -- dummy example for an unsigned-to-unsigned case:
>
>         const _: () =3D { assert! (E::A as u128 <=3D u8::MAX as u128); };
>         const _: () =3D { assert! (E::B as u128 <=3D u8::MAX as u128); };
>         ...
>
>     and so on. There may be better ways to do it -- I just quickly
> brute forced it that unsigned case with what you already had for
> handling variants:
>
>         variants.iter().map(|variant| {
>             quote! {
>                 const _: () =3D { assert!(#enum_ident::#variant as u128
> <=3D #ty::MAX as u128); };
>             }
>         });
>
>     Maybe this was already discussed elsewhere and there is a reason
> not to do something like this, but it seems to me that we should try
> to avoid that risk.

Thanks, I see your point, and I agree that compile-time checking for
potential overflows is a better and safer approach.

That said, it becomes a bit trickier when dealing with conversions
between signed and unsigned types, particularly when `u128` and `i128`
are involved. For example:

    #[derive(TryFrom, Into)]
    #[try_from(u128)]
    #[into(u128)]
    #[repr(i128)]
    enum MyEnum {
        A =3D 0xffffffffffffffff0, // larger than u64::MAX
        B =3D -1
    }

In this case, since there's no numeric type that can encompass both
`u128` and `i128`, I don't think we can express a compile-time
assertion like the one you suggested. While such edge cases involving
128-bit numeric types are unlikely in practice, the broader challenge
is that, in signed-to-unsigned conversions, I think it's difficult to
detect overflows using only the `repr` type, the target type, and the
discriminant value interpreted as the target type (please correct me if
I've misunderstood something here).

I'm considering an alternative approach: performing these checks while
parsing the macro inputs, to handle all combinations of `repr` and
target types (such as `u128` in the above example) in a unified way. I
believe this makes the behavior easier to reason about and better
covers edge cases like conversions between `i128` and `u128`. For
example:

    const U128_ALLOWED: [&str; 9] =3D
        ["u8", "i8", "u16", "i16", "i32", "u32", "u64", "i64", "u128"];
    const I128_ALLOWED: [&str; 9] =3D
        ["u8", "i8", "u16", "i16", "i32", "u32", "u64", "i64", "i128"];
    ...

    // Use this function after parsing `#[repr(...)]`, `#[into(u128)]`
    // and `#[try_from(...)]`.
    fn check_overflow(
        discriminant_repr: &str,
        helper_inputs: Vec<&str>
    ) -> Vec<&str> {
        let mut violations =3D Vec::new();
        if discriminant_repr =3D=3D "u128" {
            for ty in helper_inputs.iter() {
                if !U128_ALLOWED.contains(&ty) {
                    violations.push(ty);
                }
            }
        } else if discriminant_repr =3D=3D "i128" {
            for ty in helper_inputs.iter() {
                if !I128_ALLOWED.contains(&ty) {
                    violations.push(ty);
                }
            }
        }
        ...
        violations
    }

This is a rough sketch, but it gives a consistent way to reject
obviously invalid combinations early during parsing. I'd appreciate
your thoughts -- does this approach seem reasonable to you as well?

>   - On other news, I will post in the coming days the `syn` patches,
> and my plan is to merge them for next cycle, so when those are out,
> Benno thought you could give them a go (we can still merge this with
> your current approach and then convert, but still, more `syn` users
> and converting the existing macros would be nice :).
>
>     (By the way, the linked patches about converting the existing
> macros to `syn` are an RFC in the sense that they cannot be applied,
> but having `syn` itself is something we already agreed on a long time
> ago.)

Sounds good -- I'd be happy to give `syn` a try. It should simplify
the parsing logic quite a bit, and I believe it'll also make things
easier for reviewers.

>   - Couple nits: typo arise -> arises, and I would do `repr-rust`
> instead of `repr-rs` since that is the anchor in the reference that
> you are linking.

Thanks, I'll fix them in v3.

Best Regards,
Jesung

>
> Thanks a lot!
>
> Cheers,
> Miguel

