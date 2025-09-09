Return-Path: <linux-kernel+bounces-808749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B0B50441
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377B23B0E58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B863375B1;
	Tue,  9 Sep 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ98/15n"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F832A815
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438193; cv=none; b=c5nkvPL7QidsutmZrTjxhlQU4Nn3qJ0TrzO8+Hrma5Grg6m5dq0zaFHNZsGKOvLiXAHBaWbFUCEuHuAyru1DzL/6wBltmeBcw423GU9t7er+Fup+tS/EMGdmyuMzwDOK7GsItviyV/GjQ7s2bYtJW8uoYXMiO2bvtTUOeAT4Wn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438193; c=relaxed/simple;
	bh=R1Ch3C0oxQlRO22Xw5yMNpS2T6gGdLKY4TKwxEE6ycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtUyObAaJ0B23GH5cgYSLi9A8zbSlBFcJ2LXqnaFXBfx4fmfBBItdWoJnh6tuIuecYGpNZT4gdqeloxNe4rXTun6pxJ8XnvrBHHVvHUYvBLxZr2ZMmQ6anvIxCjQ9e2WhiRbLi3gTHS1AqJzgEEqr57vZDL9yklhGSIH+L98rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ98/15n; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24602f6d8b6so11824285ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438191; x=1758042991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Ch3C0oxQlRO22Xw5yMNpS2T6gGdLKY4TKwxEE6ycA=;
        b=GJ98/15nDhkNVPjiMm8vuasCIykhfLoG7zTfnm1CCYXYOU12uRi+luM+OsNOCFOd1i
         tylCaXe8MWrGXvTC+Jaqz2PRsv+Dy6eZa+bG5EggqcwyvFBOtzt4RqZoSR7wf53XNyjU
         Q1atvg26i9OySZDiOyUWlL70GMsOTG9DcIO93sXYYqr6tOLCz9zU44L7byqCka7rUW1p
         93euC8OWbTfNojd9wk94xtIMyKaijXl7ds4L098yrOEh1SZEJHWbzrTpmbJ2+aFVpDtX
         Vg5y3Wts3UTwjRqC/iUkedJb8gdrlV8IdspgaXm6njJoxJcQJEVR9+QJ8F4AerB+Dp9p
         oOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438191; x=1758042991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Ch3C0oxQlRO22Xw5yMNpS2T6gGdLKY4TKwxEE6ycA=;
        b=JpKaruB60+vxHsct26f/d/fHfDlApo2k5mgHwSEdI6Gq26y7cbHPpqqO/uyfYwKyEe
         HkzFjqsblj/3MaGm5XpcqI+ty2JCxJL5AMyR/fteYgHVAsThGqlgCIQ9XASsR0x+ZKAn
         kJqVuoHMngDpddepWAJv/htCBvv2FPq/nO8L+zC7z5mJmekyh1sV0D9YEQFBOjxnCSZg
         ZfiT5p9c6iyUg561Jy33/GI7mSDs/ujmGr7keVWC5hSn2YFgQZdtWT1CZM3gH5GVdWLk
         gcCi0+MtxhoQNC4drmkda35No8uStZ4nrjexoHQXpxl4zFmZytV/Jhy0kRKR66URMqHv
         CrCw==
X-Forwarded-Encrypted: i=1; AJvYcCX4+4kjBQg42gYOwXajmjvOAi2KpMUvSrEoQV0prukSk3UNsRsGaWru8dRWAHZBs8qmuLIdRPC0MnNFv2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqEL51FT9LjJ5meX1B9CcGm/w3xhSjVwae7A197aaYciNo3cX
	b0uFrzSkRxxWjerSTEiaoTEIusCWAdLdbM5uYQAbBwurGrqKoCP4wolzEjQYoJPtr4ib9icFuUq
	YeBBigzUCDL5RuYKP8n3/+Qr47MJ5Kwo=
X-Gm-Gg: ASbGncvbkJaotlUEznlJx6ta5ZSmP10bxyFwxXxC9+VDBksRdKPVkCIBEirWASzT1Mu
	Q+awTMLy37BkxYHfuZBW92QppRDLi0DFmd7iKirvEXgsf/ImJqqVOTqNVRV3Cf9rZened3MS5Nr
	7a5ARSSJ+ZOYFh/7S5swDJbhlXVcp7UU6msD0qBu/fQnCYqZh/7Jxr/c8lyQlewzhdBhkOqkNWt
	gKlNFdQErm1hlm5be4qZHX3e9BSh2QY/PLuqxwHCk+WTK8YRHtXWPelsoeVYgtj59YXSHjwbuZi
	Q+Sh9sDIZNglwxO4a55IcJwWSw==
X-Google-Smtp-Source: AGHT+IGO94y51rM0C0I/EAdShkTaG+X6lgtWd0vdyU2lORl3sjxr1UXkjo9G/VQ5f9+lWmKV9PlSamp5i7EomS2lRWI=
X-Received: by 2002:a17:903:1cc:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-251771d5b61mr95844105ad.11.1757438191527; Tue, 09 Sep 2025
 10:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local> <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local> <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>
 <aMBVgrVqX2w31GhV@tardis-2.local> <3bed2164-8f68-42ed-9ab9-6fda05687535@sirena.org.uk>
In-Reply-To: <3bed2164-8f68-42ed-9ab9-6fda05687535@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 19:16:17 +0200
X-Gm-Features: AS18NWC95uheqMj0QgDVvrdAmeJKZFXIKvboMRQH-DI_w3wLatZKkT7OTw0xQ3E
Message-ID: <CANiq72n-_GnPOaU4JD4P-oV3J1MKevPto1FDax-ihLP69g0v4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and devm_enable_optional
To: Mark Brown <broonie@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:11=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> The C stubs are all inlined so should have zero impact on the resulting
> binary (as are all equivalent stubs generally).

I think Boqun may be referring to the Rust <-> C step.

Cheers,
Miguel

