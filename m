Return-Path: <linux-kernel+bounces-881368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62264C2816A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2163C40107A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3CC25A350;
	Sat,  1 Nov 2025 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTuw/mL8"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0A2147FB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011388; cv=none; b=BrueqROiTa4b1nJwdi390L3yzMrBs1cKKJBkDuMAzxV5vrIxH18Ke2y3ERoUAl3BMVoDN6mhBf4riXm+kroSumsdxen2RiyAB1Wx8hoSypqqafI3dVyH20et4WtrTTqpN/PBpU2+ZnxM/P1CfGgiFbvtePyS+sUv75F1L8Ldk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011388; c=relaxed/simple;
	bh=bdxPdHZEuhQ1dkWTiW1iF9wThJEn+irBUmR5Dc6YpDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvN7yrmz3cq2FDcmA0E/2Of0kWIO+gukxg3trr8WiHaVzJ7jOfbWwP/4GZDMBlO4udrxwATpHioqm5JlJhx7nQ3Siyc7Ff5XwYIBML71/3dAulqTDJxO1M8BVEe0n9ac/+ZPW9UqoBTcaFaunooIPwVviGCNXulKZDTWdQCD4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTuw/mL8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b8f70154354so480440a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762011386; x=1762616186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfjJn/f7oQqzZoFQTxcwXAUfHD/4AwfoEc5HZKyEpqA=;
        b=GTuw/mL8H4YRyM8i15Qcv3m8RrOMcwBNytiDg6uIpMqBoR46U72MHQ90reQbtYzOZS
         74gb0RLYzBS6C2miI3ntTvSyOe2016MoEsvDkERZP6ufAms3euZgTUQuxFxJRMQb15kW
         l5a0e8upgxHxF/ngGrLX2iA5d3BNj7tGtj7Ni5pkppyXIvIIhGM1Bi03O4r/sPcCPDPR
         bBLYZWsl+7nY4zaI9bU0ZsOzaBNh6lb0JEJYbZTAqmtHTMqjO33tenacj3eHAnCZ5f9y
         0Qq5PH1QvB/ZZUs8fDFC1jsuxc1C1KE+YqGarp+/ZjijdXazBW0MONUlgUJtxbRRAyVA
         E0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011386; x=1762616186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfjJn/f7oQqzZoFQTxcwXAUfHD/4AwfoEc5HZKyEpqA=;
        b=I+Q+7lVfXgWzFbHgh5kDQwnqd4enPnkFw80ERSYA3qsxuSY9+S/I+2z0oZ34Ivulcx
         UuDfp4FpWxnDpXDy4ZR0Zte/KJwBO+NgipOnh8p8mGpn/R9hb4zfLZbyi/rdeWO5E58M
         s1N3HkWq+TdKiwnfVN8AjGGnSSpD9HY3UC508+g3GGFf2eGneJI/+fS+Ff8cIVrT6Znh
         2TSiDMxQHkjCX45cefgn0lKFRd4E0Qbw3Bx4aaIv6vdXZFiDwRH15GkAm6iKEpZ2IYYy
         x81cfLPU+XRpoZ6wvq2YbpFwzhLYLwRf+jmXF4GbJSprKSyMuvRU51dsNYC6v8Dv4ZOs
         /65g==
X-Forwarded-Encrypted: i=1; AJvYcCVthn0TlWY57Md8YVo9iaX4UB3qAkaCOO+SqFUPUjs5VaahM3mpXQFZK4ruzr7vVZK5FqBU/FXZzXb9Drs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zCI4Yn9MRgg6g3UwXJewHLxIIBpNgfN88iYAnFcs7fq9Qc3p
	uYeSCvHg0QCHarkTpzRkpWkgYIp3SYWRGZc839+8yPs74ZTQENpF8JHA5b7w44UHfHZSDf1yzOa
	i7O7HJGJ3lGQfLivqZQpW/1XpGU9nw9w=
X-Gm-Gg: ASbGncveHgRycOD1GgJrPuFxhJsC3QDPB4Vy0WfSE+De+Ob+jiCi6OoknlllcZ95x1G
	KTovedf2PrhCllLuHh7GLPmrXPeQowtYtWHvpVKHwa/SsOaWQbL0W9Cos6YPkHj8P/pxFFnY4bQ
	GbufWyE9Tf3gWcntSmj1hrtT1LTT74GpDNAFS7YdxMxq8amyEI29Me5zhXi1ANBmyYQpi/ZX2LN
	YXfbw4GAyt7Om4z8O2YtPzVC6OJOp3wnbb1CqQg+IAGrqPnlkvGV/4yQvWpSDbkT+T0KaasrfNr
	4K0zsCVJJ3qOUpPAcqlOUTZRBD4HquL1G5tSWwhFZviEfoGYklzcPQ80CU4PxD5N91/b/wyVBlW
	nC6gOI9wNEJ0dvQ==
X-Google-Smtp-Source: AGHT+IFPkL9moEs1IDaYMib+cnXVWvLGHDmNr26zj8ffw14If7Hx8/KbyBNWa9R59glcpNMaDzsQ03S+R0Vk6uJtUK8=
X-Received: by 2002:a17:902:dac9:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-2951a4d86bcmr59790335ad.7.1762011386406; Sat, 01 Nov 2025
 08:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-b4-as-flattened-v1-1-860f2ebeedfd@nvidia.com>
In-Reply-To: <20251101-b4-as-flattened-v1-1-860f2ebeedfd@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 1 Nov 2025 16:36:13 +0100
X-Gm-Features: AWmQ_bmv363FKeQLbteYinlQkLkfy3udKcWiF4asqch5Ak2oOTQbYYj6c7b_nbg
Message-ID: <CANiq72n6KLjA5XQmAhy=SRTnWY8sCCmp9ETnB-dTSVZ84-mjzw@mail.gmail.com>
Subject: Re: [PATCH RESEND] rust: enable slice_flatten feature and abstract it
 through an extension trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 2:32=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Hopefully it captures Miguel's suggestion [2] accurately, but please let
> me know if I missed something.

Yeah, this is what I meant and looks great -- thanks!

If you need to use it this cycle in another branch:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I will pick it up.

> +config RUSTC_HAS_SLICE_AS_FLATTENED

I guess you used this one since they renamed it and since we don't use
the `alloc` method. It is fine, both options are confusing in
different ways, but sometimes the feature name is the only one that
can be used (since it may enable several methods etc.), so I wonder if
we should try to use that consistently.

> +/// In Rust 1.80, the previously unstable `slice::flatten` family of met=
hods
> +/// have been stabilized and renamed from `flatten` to `as_flattened`.
> +///
> +/// This creates an issue for as long as the MSRV is < 1.80, as the same=
 functionality is provided
> +/// by different methods depending on the compiler version.
> +///
> +/// This extension trait solves this by abstracting `as_flatten` and cal=
ling the correct  method
> +/// depending on the Rust version.
> +///
> +/// This trait can be removed once the MSRV passes 1.80.

These paragraphs sound like implementations details -- I would
probably leave that to the commit message or normal comments instead
(we should notice we need to remove these thanks to the line in
`Kconfig` already).

Nit: two spaces above.

> +    /// Takes an `&[[T; N]]` and flattens it to a `&[T]`.

Nit: I don't know how one is supposed to pronounce these, but I guess
it is "a" in the first one, like the second one (the upstream docs
also do that).

By the way, it crossed my mind that we may want to use `#[doc(alias =3D
"...")` here to guide search, but I guess not many developers are
using local/older versions and this will go away soon anyway.

Cheers,
Miguel

