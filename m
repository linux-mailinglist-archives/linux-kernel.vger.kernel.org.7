Return-Path: <linux-kernel+bounces-750288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11FB15994
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418D818A261D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F682882A7;
	Wed, 30 Jul 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="JhU0m5Lm"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C5287518
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860571; cv=none; b=Zmn1lfvBhCBVmQdKagsTONSm/SfOtxteyl0bCJWoEusx/nk3tdNS+v4FhCi5m5KTymGRL+54lVFV7SEz0VnD1L9oa/sQQMHkerIfmZgZ56TzfmOJmXQ0FdBIXxKH+uLpY/SnEdh0oOHGf3bEeprBsKiMYD2r5jh2N7fpqr51UjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860571; c=relaxed/simple;
	bh=FqJ/O1UbZAXmNa+fmKfqPN5k81phRkofhogPxnTCOus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgBWsFT9cpSIl/cxHJJooPnbHPHrK26oOA26FuXj/OiI6OOLSLqbHeF1+uX+PEV1x4VJQj1U0xUcZ9b7IeABtvp+A3boVBC0rMaEISNDIUQFMbUdw7h6eEti8BHWI++g8gKymKECYa3uhH5Psn00OnVsDE8A9FmeVM8aNZT5Fbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=JhU0m5Lm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso131014666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1753860568; x=1754465368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfSyL1J/1nGbrIfH2f1hr6gi59w/PAjg9s3k0fTksYk=;
        b=JhU0m5LmFU8wvEpdvDonv+USd26Jvuvm7Tfv/vkrJ/j/dCtSzsnL7F4eKJyp5kWaEs
         iLStAg5WMwGCqGIlkWH7VT+pNKMcc72I2GuUuBft+roASdMPlMVPGaQis/uJ7La5tg+Z
         JHwcktspK38lk2sJi2JKVYDGUfXyWr99dyITSHcFj1jN3+/JpCC+a+fW65+fSZ+VHqyZ
         w3fYeBZ4YAUU8gmYPqU870BfsWRfhvsxMtubOMXYvPDPZmHYxQDOckQL+Flce8Wxx+MO
         azSSUlBPfLpWeJ9yFtjyGkrVp2EJ2dJaQvcKO06ZLKHLHEXgcR4e8TnEuW0Api9xkELK
         1ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753860568; x=1754465368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfSyL1J/1nGbrIfH2f1hr6gi59w/PAjg9s3k0fTksYk=;
        b=fcvvQaUDflc2uCZWM3zXZynB+fB3D+oEC5OSfWXH1p8T475dC/qaYqNB/d5A+3hVSU
         O1ouG2hFuEVZBsgd+c/df+CdNqp7HUxYvIplvOQYyKREGYD14XLsSQJ+o0tTKImM/5XT
         jn4U192h5MSR6FZrQov7oYGZGLCI8I1zFitww/OeG7ufPDcxgSsCeUz8JQ6Ci/DVbEYy
         q9TxCGjEQzoZM3AGU8d9ICb0K9L644TUjaU4KOZ7xf8QgIm2hrnejCS7re/2RkEmehRJ
         YywdF7R2dSq/NpZ2QLTWbojhPrYngACJdrRZtwFmD/TjaXwRyHcX2L3cfTyppxFBcDeP
         eImg==
X-Forwarded-Encrypted: i=1; AJvYcCVQZDL0+FYEriaUQOHr2IuGL1zwPa2Ybb5c4PitFXb0sgyOWvB7iT7eWsgCnBRqhk59NOA1kPP8LgwaChc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRbA7naSm2lfui+Z3AsTsqSFDftCOdAhJPNQPVtYsnE8i4lQP
	JTkZ5Ziw3gJ8OaIL7CPoipdVThWI/NR15DXjKpOfnWYvYzPR29ad+SRGAW6ggRbjjcM=
X-Gm-Gg: ASbGncvWkqZ2LWTqutLwwJBOkFb94XmubbMqOQMC7pXSBJtrUsBz+owBtwsk795yyI9
	O3I/tc8k2Y4CqhwNVb9wpuy+qYuG5TK3aBjnoYY497SyHgjt4K8O48gCcw142BGFrPQ7Go0UUFc
	PmzLhTo/+pBmiIrMoBVZ10Zb7Dn94fQELWiBYTM/RRUcF73qwCNZStnwK8ivIB68vhwutB2GAwp
	Q/MpB4ixU1Ql6DKF0rKLAUNGKFcPRkmB6AmAMxK4kR50qI0yDXB4ontAtBeIwHAMMMWYxHCVi9A
	2ng/JaeUrvnTDyHGHEMiHw1RrMdIbGNAKbmnw5sSfjkV9UDazDqU9omLG/Y74gkw4qJODYyx7lJ
	5HkcZFRh6/CMPNyvgMM12Ik33VDbOIsiP4+XqCKGB6T/31MkIA5O2RE2MPHJalQ==
X-Google-Smtp-Source: AGHT+IFArK5yJ0y1FvOGBm8xzNPjYC+xuZmYpGZnVw+SljX1j9nVPSGdupVHpYG06Yu+78RjXTjllg==
X-Received: by 2002:a17:907:9406:b0:ae3:ee3a:56ee with SMTP id a640c23a62f3a-af8fcea9917mr340301266b.3.1753860567359;
        Wed, 30 Jul 2025 00:29:27 -0700 (PDT)
Received: from ?IPV6:2a01:6400:11a:26:d163:a794:aa16:5e2d? ([2a01:6400:11a:26:d163:a794:aa16:5e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a610e2sm699912466b.68.2025.07.30.00.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:29:26 -0700 (PDT)
Message-ID: <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
Date: Wed, 30 Jul 2025 09:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: clk: use the type-state pattern
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 7/29/25 11:38 PM, Daniel Almeida wrote:
> +    mod private {
> +        pub trait Sealed {}
> +
> +        impl Sealed for super::Unprepared {}
> +        impl Sealed for super::Prepared {}
> +        impl Sealed for super::Enabled {}
> +    }

I just noticed we have plenty of Sealed traits scattered across rust/ 
folder. Do you think we would benefit from unifying it to a single 
location to prevent duplication?

> +
> +    /// A trait representing the different states that a [`Clk`] can be in.
> +    pub trait ClkState: private::Sealed {
> +        /// Whether the clock should be disabled when dropped.
> +        const DISABLE_ON_DROP: bool;
> +
> +        /// Whether the clock should be unprepared when dropped.
> +        const UNPREPARE_ON_DROP: bool;
> +    }
> +
> +    /// A state where the [`Clk`] is not prepared and not enabled.
> +    pub struct Unprepared;
> +
> +    /// A state where the [`Clk`] is prepared but not enabled.
> +    pub struct Prepared;
> +
> +    /// A state where the [`Clk`] is both prepared and enabled.
> +    pub struct Enabled;

I would put a private member into the structs so the user of this API 
cannot construct it themself without using your abstractions.

	pub struct Unprepared(());
	pub struct Prepared(());
	pub struct Enabled(());

> +
> +    impl ClkState for Unprepared {
> +        const DISABLE_ON_DROP: bool = false;
> +        const UNPREPARE_ON_DROP: bool = false;
> +    }
> +
> +    impl ClkState for Prepared {
> +        const DISABLE_ON_DROP: bool = false;
> +        const UNPREPARE_ON_DROP: bool = true;
> +    }
> +
> +    impl ClkState for Enabled {
> +        const DISABLE_ON_DROP: bool = true;
> +        const UNPREPARE_ON_DROP: bool = true;
> +    }
> +
> +    /// An error that can occur when trying to convert a [`Clk`] between states.
> +    pub struct Error<State: ClkState> {

Nit: IMO we mostly use the `where` variant instead of the colon.

	pub struct Error<State>
	where State: ClkState

But does it make sense to put the bounds on the structs? Shouldn't be 
enough but but the bounds on the impl block?

> +        /// The error that occurred.
> +        pub error: kernel::error::Error,
> +
> +        /// The [`Clk`] that caused the error, so that the operation may be
> +        /// retried.
> +        pub clk: Clk<State>,
> +    }
>   

Thanks!
Daniel

