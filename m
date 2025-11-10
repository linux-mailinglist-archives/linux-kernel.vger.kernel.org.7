Return-Path: <linux-kernel+bounces-893232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7EC46DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1DAA4EB6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3023112DB;
	Mon, 10 Nov 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Burq4hu4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776F31076A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780989; cv=none; b=lj5Bod2NnyDcKV0RSNiN0wAQ97tqa8Bkd4AzuwFc0a3AZlm8DSWhlgyFhkQEwKDwIxPHWcMdo2+fA5/++70ebw50ECriqYodKHdY/1k+po6GC9+Evant6YnQ1xnGngfcZ/b6y7q7uEc5ehn6bj0VJ5hPZYurzWAyI3MHZT+kiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780989; c=relaxed/simple;
	bh=C3acuH7QCQn6p/xm12ErSwRFYfxoFjG9C3ZXOi4OU58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH3qSEAXUNk6BpDMcuvX87YC6moNRoYHvH56jmbbboUDErpBcITbbK5A5r5b4icvMsInIxMlXe6U2G1zYXMjKJMzMZEvHVgK9EFX1qtu6fjqUGtB66jL6a+NURJENjrPDgkhpjQfWNt2sJOfqaR0GF/7Ey0CjeMofw7KTPAv3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Burq4hu4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f5278e5cso3691205ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762780987; x=1763385787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3acuH7QCQn6p/xm12ErSwRFYfxoFjG9C3ZXOi4OU58=;
        b=Burq4hu4SRCBWq8IvkWShcKVmRVrUTLWS7G9dZOSs2N/qYDza1aDQqyf03HNvmGacX
         Sxnkm3AHK/y3AJlQsp9K9x7l0K9IYHDPfOIxZ4MVx7MAeBknIpXWlOoRDPO3soEdB3L1
         Q116CAnfikEAhQDMoh+oaOngx/ylvAjIa2depsQOaWxLllXoH3qbHDVFbelkeKXMipVL
         mUTFT155DQzvatbbU2jndpqmroGdOvyLfMXZ/6UDbcmkmi6QosoBrgx1upouDCM78V6U
         sJUjml6KJvwAn/YiQXbtUIL3sX6pRMmbLwF+fUljKRjJDnmzXxrDfB1j4+NRjQAFUl9/
         +v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780987; x=1763385787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3acuH7QCQn6p/xm12ErSwRFYfxoFjG9C3ZXOi4OU58=;
        b=nT2dclfSiNE1lEhBx8FRvUMakeWJq7RGp82WwSsuXhLlyWB3ig849NLjkzjNvx/fmL
         aWIk5eOWJ+arQ487BvfMW052Kr6pilsIdAzRcUkYpmaz2dVeIcIr05ElLxKz1flEO3VA
         tnLDvN50r/IgiGqs2el5KzO7Q27y572ljF9kw5Deta57u3TKG6mQa+jDJ1E+vP4fvCd4
         oYZII0GJt1Rf66pbdA845A37MDHOwUZZJ1HYsfGx+SeS6S8BkQLjj7SKSgZbgku4H+sf
         t+P9VNapvlG4tXMvyHzzive2JUcwQHZgUrq5ryOpfqSTYHi0YmyxM1TrmFFQTiXsH5sP
         xjJw==
X-Forwarded-Encrypted: i=1; AJvYcCUqdvbkL8VaPBrahZp/pjeSCYepC9HmjkK47SfO3xCr7pFdTxDvBD9uZgedHZJzi/BRbtvSg7oe6B7iXhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ldUaT3wi6ddQ5Mj8Ma/hJEQvXNohI3Byqs24ObCBgb1SIa68
	me8HnpxAVAZVy5R76d3PntZ8VXJghMIAtvRXAS5KX7FkWZPo2XBa/pVahdvrSEPuXKuHtqbg5to
	Au/z1K66VWl0Qyu8VjllaUyn6dbOr4Ao=
X-Gm-Gg: ASbGncsWK1o2Gx1gfxFnVy4B5erG7z0aPEt86LfSCtuT0+/ZxzKICL+oGn90u3Hfn2N
	R2bMk6fpuLlwt23MJnn6WJI4oPopAQsHEisy//1sAOdJREJjq8P5rlFgSpKmxd5jqDX5iVr3ivl
	bg3uAIEs2E1gL6ldGdg1E+s1KV6BmM7S/dzFvMtBcohnC8YVFCxDe0aYBHWTGXq2tngkaI3MfWD
	fRLYu+GOJFMLjBp/pBhemDtzICUpEDQHGJAb6QmWQT02jo7N/IoPwJLH7Y9bDBUH0daTtFy2jJx
	maWt6sYwmWVDZ5YQFY5+XAzXbiyTnZQehbEn6pn+MyEiEcNnhhE1+pPIhciokIZxjPX/rQXjtlg
	M1ek=
X-Google-Smtp-Source: AGHT+IHgHDi3q6OyQUJsolTQIPR9Fj/+81SVNx0MCb8IGd9foxsR78ymwzqgxKrlTwxxt2S941IeTNAE2DlJ0icIPNk=
X-Received: by 2002:a17:902:e809:b0:297:f2a0:fad6 with SMTP id
 d9443c01a7336-297f2a0fc40mr54637915ad.9.1762780986630; Mon, 10 Nov 2025
 05:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-14-ojeda@kernel.org>
 <aRHQA6FEoxACerIQ@google.com> <20251110131326.309545df@eugeo>
In-Reply-To: <20251110131326.309545df@eugeo>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 14:22:53 +0100
X-Gm-Features: AWmQ_blPKQ1VNfZu1Ux9YpaOP8DxeSL_ehdyoNT5qQqWUnszwlBjdrKVMppjRig
Message-ID: <CANiq72nkjWbtEktSU_TrEfY2Agy7FK0-OLBWPLqTvp_p-CkBUg@mail.gmail.com>
Subject: Re: [PATCH 13/18] rust: quote: enable support in kbuild
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:13=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This is to be able to skip over edition flags for `quote` when building
> the rusttestlib?

Yes, it is needed to support skipping the flags, which isn't needed
until this patch.

It can be done earlier separately since it doesn't hurt -- a simpler
option is just to mention it here in the log.

Cheers,
Miguel

