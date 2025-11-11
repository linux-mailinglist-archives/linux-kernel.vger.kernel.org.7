Return-Path: <linux-kernel+bounces-896138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F66C4FBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC64E5814
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AA432AAB4;
	Tue, 11 Nov 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnZrN9oF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D164293C42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894015; cv=none; b=jF1ryOlADvAkAsszRHeT7Ou1tWdCidvpGVz9wldyZ2Zl0w+agAw35h+vyuWRC1IA9GbSNvBSkCdHuSB/VLW2WB3NAAorqcZPWk7fkPGgHmvLe1Ao6xmxSiqT3ymYNQk7ywVJbsL0vQ01ubk8ijvjh9IGn9r2hAjQ6x3EHs+CGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894015; c=relaxed/simple;
	bh=UnmrJNFh5uwNsZAyJRqYSz9Eybog28Whpwhvzqd3qCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZbG+pOgRhVMX2u1psV46RKcbaE/d9N+dvS3w+D6RjOO13xtDFXCxYvII0qLxzsCaUicdF64NhfU67rABveeEIPOyR8cE//g0VUk8rVz3bodNnthgW7kPF7x1ieN73ULGq9qYF6QXTepOTqwg5Cn7yBZWy0dpRtmNsvK1iTFmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnZrN9oF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e2736308so117845ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894011; x=1763498811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnmrJNFh5uwNsZAyJRqYSz9Eybog28Whpwhvzqd3qCQ=;
        b=fnZrN9oFQtmJMlwzZYrO8tKGRyObtSxHJ4RoGdwBMwdfMi064QPG0RIzo/BoInbZfT
         qFn4DIcBsUT4Ln3+jpmZbZGVfR+UvoNyVSGek4tkPdQOcPhSEKMhxi9obC++q+9Pkuo3
         RX13NXgIgY6WUY5h1TwzMYbCbKaek+PPtCJand1CcEVK+BOngZybpa82GGJL5MGbuYeP
         O7KzruND1elIJs3KJroFKnyxEn5bZHVZLWXFKnE3GlHqRyAf5fPGIwFFcrKaZKjZj0nA
         cCvFzNsXZo3WJGd5C1Ysgdobmu9s0vKQmZRkX2xVKbNeYK1kh6kjdxQld5MsKfWKrBOX
         gBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894011; x=1763498811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnmrJNFh5uwNsZAyJRqYSz9Eybog28Whpwhvzqd3qCQ=;
        b=oTvbMWvQNHwnlbEiU0iJEpV2tDxG7LxGDbgOepKbs6Ke6W/XdogWXwl9hMJ3Si8DCj
         KvSrW8Nscam50QshyTODx5Cc6wUNTri0PUSKHU726G8/Rln2M8AFigBJKFY7P38+0/OS
         GfyUedBDif/uUKHcVKmUjOSqkKTTa0/ZaxOtcPL4iarFt+quU2PgtGBwoSlV3dzch4z6
         iDWB448xPRFN/gKQexBRGYsCrudMyZv1Xa/pYWJKwFeF9Jg9znmduw7h8qwlYVktprRM
         2RK8FixRmFN6oEWmv2wDGa+oXfVDw/k57/CmJMaj5+fa8qkA7pgwRE+UgRcMTLZ+Dh5p
         D7/g==
X-Forwarded-Encrypted: i=1; AJvYcCXNrzf2h8+8TnAGvORoVGn20uVWOAgTe/K0Lrk7UoNmVPKjwAdQZeRMJEspNF2Ulrs2MURw20w2KtxOoWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKihLPWe1msKPhrxhCVvKTUVhP5WD2smk692/ep7C1PEVlIaq
	r8zxHSl5xPXyltWBvYfFUe4kSNmwqZb7nc0jnFpQKIAdZZwP8BlqDjl8bA8d5v+g/jFJBLYfkam
	XaV7Vowd6E4ojyS9fWUucxpb3SeEb6SA=
X-Gm-Gg: ASbGncvrG1wC491XQNi5puSh1h9Vf6EdQ6eugvfFYvhN0XOCgbaDT4CcIao/GBa9dY0
	+ArCUzR4RO4rJf8QLouQ6tFH24V2KBDZYtjnqr5zS4cdl3HiWpcM772Hs40FdvGGFO8lZCAaozQ
	lIca9z1LoZbXTczPCR10OgET5gl0zL7xEqUAyBoKgcD7Tzv9eNsCsIi2b7Fm7g61pgkTXggcEwT
	T1K3zvaUCCn7GSfogZDbV4skZztLA/3vf0lDLbT3xPOXoneitz8iEV6kH+2+Ne8Hj3Znjstb0GJ
	0/cTnvlblKFeN1bemtJULbiHXgez3wr9/Qa+Oip0OPDJazavFPf34imWM1AFTFlAFUshLZ/PsWO
	Y3xlX1mawJG4Drg==
X-Google-Smtp-Source: AGHT+IHN94JtmIxHN9rzLf3rPXm6Pv6p3OVtQxAw7lqD/kLIt+UFSlitVjA3+blOuHUQSodn0SFbjWMtxcUyzXogkrc=
X-Received: by 2002:a17:902:ea10:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-2984ec953e3mr4844665ad.0.1762894011055; Tue, 11 Nov 2025
 12:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com> <DE5PQ3927GMS.31N4JGGZK3M1N@nvidia.com>
In-Reply-To: <DE5PQ3927GMS.31N4JGGZK3M1N@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 21:46:39 +0100
X-Gm-Features: AWmQ_bnepqni23BVP3fPyeHHA_HCKx7foH7uXjpDqrNPb0vXM57eeTTzvo-sJS0
Message-ID: <CANiq72nYgvsTLvaXkGDN6ZReHipZVSgg1BzCgjC05h+dmsFe3g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] rust: add Bounded integer type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 9:12=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Hi Rust core team,
>
> With -rc6 approaching, may I enquire on the appetite to merge this for
> 6.19? This is the last hard dependency for moving the bitfield/register
> macros out of Nova, so we need it if we want to tackle this for the next
> cycle.
>
> Please let me know if there is more I can do to bring this to shape! :)

Let's get some testing in linux-next :)

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

