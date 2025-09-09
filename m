Return-Path: <linux-kernel+bounces-808591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83363B501FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B24B1C2706D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95931B115;
	Tue,  9 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHFhHq4p"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A825B31C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433529; cv=none; b=M7FqVh6p3auC/gK5jZ3t1oUN77lXAJ0sf3305MiXRoquC6RkQikpmb1ryPq2/Uc1iFF8anwl69ZZ4BVWuFk4AXVTX6mlkxsUQedM5JYZXiQPdrL+2a36DmnDbOevWJCPKohpJYlrFYwOiL2ez/4GBKgFnoNRcLWhgwemBRT023w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433529; c=relaxed/simple;
	bh=Ywa5e3QKAxppPj0ZJQB1lJk35L2VQYUtB1VycDBddEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSWkkDCcREYXBG1VDCxLa4jIRn3ZLc9vG8ZwEueMaK1QqPsZdOY1u8ufNDh1TPPtwqsdtBAFyZXjW/I1vwzIYccIIZUYURCvWKcD5/l/dbvCNthRj+BqXlWONhZwG4Yx6rLZh+Z8v3e5tnB/13iBsUFY3oIbpmEtYLNzRIUkjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHFhHq4p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b132bd90dso11894435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757433527; x=1758038327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywa5e3QKAxppPj0ZJQB1lJk35L2VQYUtB1VycDBddEY=;
        b=NHFhHq4p/1PTcgIFCUZ9h4eyjGodkEdBiyhdPyFt7MYTkmjX2wxxCGAYerFzbbzn3g
         3w/q65HltO7eQ+4xlBzKwzD6IxPPVpT8WsXvTttSRD6KlovEZi7LWUp0o2cKu+dSCUi5
         WOi5nZd7QdAqbwp8PpNErZ5Y3+udzdILSMYUoB1ynYnIF12IVGMvUj932OCm0O23ynEz
         Q2HMpBquphrCpDhpxqJhZUYpBY8MHEGVNcl5WjMgvTcBDHMo/XV9ubfezQss2KZL26+F
         /sm8HqOf1scciWS12hUc5c0sk5fPozeLUdvpmiq908MF4VV577XWZ9xN/RvnH1JzA7+E
         Mqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433527; x=1758038327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywa5e3QKAxppPj0ZJQB1lJk35L2VQYUtB1VycDBddEY=;
        b=RTE7uzCQFR9gt4CrtX0RaHaWyZWcMsMRfxlqrDPK6JferSVKix2rpXDb4UFs6D+AHl
         ttLju4+GMlm+ygvHU18UCa4vEMa53g7OG/FIy9movw6KjIt3HR5UjYOIXJt7oiiC68jq
         oz8QeOSr4p9V6qBGOcrzUW5fweloNzaypP0lObKq4nxzmmyznOUVdYSbx3TusS4yW01L
         fWEO4hrka/+cp8MofuoQyp+uMStpPlk47l2Uvsf4qybe0DnfQon42wgcN7j7YxHimMgP
         cTvS/7mfiLgk6YG/+D5HZWPrs/gEPsLDNUAv90SoCs1bB7ec/rRdkRf3ucPHtSi/WKt7
         WhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWkehVuV45/jfI/6Qpazv5kdzBvqnTwpcWwcfNZ4NhkZUr0Xqb1+Je/4dYWVtrQMsYwTSLoB1TNbOPSnEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTCzIzP+tnFYUre1gNZn1BocQdrw/xgQYt3fAcjytegkxyS//
	KBrrrPJPbGgZY3hjN5nnzXSW013Y/nJSM50I+SoN0xFaRIL/b1KZJ3cZWDf1qRPP5i7O7FBQCsK
	1sAlqKjhdX6oE6FjiZopLORTnv0Yw2RM=
X-Gm-Gg: ASbGnctEHmjYJA76iOp89hZCgR2iftfC70kRsIHh/9zBj2Ak/FCXaQ8a5+uHtd4J1TG
	i3BIz2SpUBMU3342QI+wCzzM32Bt3jeRSz3xJ6O0KDZOonB1tQpNIkQ7DYCmFFugYePnVA6F4NY
	X+siNnfPkQKMv4m2m71DbHcpEwp0OetGMceNkDiLFiMDPFYhDJUDS5Vx5JIXBMpELConyA7ULPy
	8Z0B9dZgyX179vpam3blh53AW2vQCGMwVlYV+G54p8uECx6RKzBpTVt1Cprtbx/vkoWpiIBfB2V
	H1vCOrzVA2QwBUNxM5ktSnbZB5fm6o4uo94V
X-Google-Smtp-Source: AGHT+IFEfAbF+X/nrPdCmpZeK+s5ayjkd2PeOK4cHoU2eNsecudp4YXtf+CtcP9mBEE2IlTu2Vx0QQj5HxBgRGrXEq8=
X-Received: by 2002:a17:902:ce83:b0:24c:b881:201 with SMTP id
 d9443c01a7336-251757ba959mr89842825ad.9.1757433526859; Tue, 09 Sep 2025
 08:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local> <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
In-Reply-To: <aMBJ805QjQcPdRol@tardis-2.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 17:58:34 +0200
X-Gm-Features: AS18NWAJd--xLy4mvtktQI3bs4M9a5-KsXscoI4pdd3jCzX71L3QYG-T6-naM9o
Message-ID: <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and devm_enable_optional
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> Well, then the question is why we want to compiler regulator.rs if
> CONFIG_REGULATOR=3Dn? Shouldn't we do:
>
> #[cfg(CONFIG_REGULATOR)]
> pub mod regulator
>
> in rust/kernel/lib.rs?

It depends on what the C API does -- if the C API is supposed to
"always work" (even if it is no-op or if it returns errors) even when
disabled (so that callers are easier), then we likely need to
replicate that on our side.

We had a similar discussion for DebugFS.

Cheers,
Miguel

