Return-Path: <linux-kernel+bounces-768103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B37B25CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8566D1B63009
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987542594B4;
	Thu, 14 Aug 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0yL54c7u"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28E255F31
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156018; cv=none; b=ks0QDqtxgfK6KulkcfHnTxYIr/xAKIsV9yRtDX9nSnre2H53oBRDxrPXvNlGKMqpwRvKsG6xwd3sRSrGFwTELKvB0vssSj53T0d2cc2X8dGYWA9lD+B4WWWqR92eUVLCnvSWA6ll9hul0aNbqS18QBQuISFwcXn+u6H6ZOgbL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156018; c=relaxed/simple;
	bh=vs1MFcYsgr4i84q3dtW1Ra43PylyG/Hny4f25xaRtQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4JyCLJ/n9lMqfH+xFLYMJAaUMYuZCgpwx+PzRpPFJ1xudTP1GDhsk+tfdRpozLXVRBaPs5FuUn4reX0lToDL+l0zgUd51lcZ+SdGfZ1rl+nXyRrV1dLlh/3F40eDu80ipLH+TD0cipkVuNzEV+K9ahWLbeP1oi7on855vNGXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0yL54c7u; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f7ebc44dso6370311fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755156014; x=1755760814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs1MFcYsgr4i84q3dtW1Ra43PylyG/Hny4f25xaRtQo=;
        b=0yL54c7uT9hzpzyfLl8S///EdFEdiDE13qqph9wtGFhfp5g9ph7NRnL0kHKDXUjytY
         +roKSzrpu/Fk7K8vIieDx9wdEUe8aW4+tgk+OH0MHERAnNvpaLVAvRRI1TxAl2Unx0q0
         whXjosAYzIQMPKPnWH29ID9FHYYKZjgKOOaZ3h9WMW0PrlnYBj4PsvPKFk3Cxn+obW2E
         ZUU5yIb+ijbRjrmTnhAS2/UYspf1MzX+5DxWv+5Eja8uXG9HHFKsvECkDjvWo0gbv3Vv
         fVRtjdyaS73UIDTRK6La9B4arCZpAxjex1jchogSg2M41c33XNKwVPDSevyeJ//gH3iR
         4nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156014; x=1755760814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs1MFcYsgr4i84q3dtW1Ra43PylyG/Hny4f25xaRtQo=;
        b=HtXa86c7Hvh+dnwsW048fJdOzFzU5FPU7PXPUmbrbDtMApOsUsRcnjdmQ2+mAiKdjf
         Qj+/5cwnjWFhk83AxpesWRMa7O1ILkyUesAWg3qa4n1cMSMN8R2CX9v+d5oaiOqyRMe7
         ckWc0MCn8gs3m8HlBJV39A6QtXIZfC0Oyypx6eSzV5o0rNbFLKji5R1Ma+0kBIGRXciW
         AhaLWJ8HBY0yr95I1T6eow/GVTUbFplKjtLMWakmZlTZiZctnP/1otKitVa2Wohj4bTv
         jyTOvSVVuKsy1l4M7iG3pWcIrTlb9+MK/Y67CG8CmxfFjfx7UrSUNb5Z/FfvgBB1zfB1
         tLUg==
X-Gm-Message-State: AOJu0YwUjaiywzxfLGL+Uaf4YGRX239gnBAdUEJIiTqq1ULtsdmBQt8L
	szelYj9G3tsVD2a/74QQ9rnGjrjkrHV3xVVacUcKs0uCvwXJTkTxz790PF1qa0ijqyWmtlDBHNq
	xNLDLY3A1q5oLgtv8t0bRKOWqZblxD2WZd4BU7gsf3PT/YnnqUFhl
X-Gm-Gg: ASbGncsiSj7HNz1SQL2q2w3rNZV1FfhQOAojawatO5Sy5Mp985borCvmhiTNICZPErm
	whMy6pTFKW0unC808ucWdMiCkZkSqN5YnCwVXwkudHdqLccVWcmRDyxWH5uVBk32q/cRU5dyeAT
	d/RPty7OHsXqXNPwX7cLNxvRYm81Jcq8qE1DaN5ew8QKgsFKcMeM36e7IPRNY95I4++RQiuIc3A
	fZluZJY/g3+EMWbk9jaI2nt+ZMHtxQ0tDEvU9qz7MkIUus8Wg==
X-Google-Smtp-Source: AGHT+IFTBlbhCsC67N1cmh3Rx642cXrDuTiu4TqWoZO5/6AVKV2k5/0U1k8rriHZOcjPel5pdqkogtlQ5ztMZk+8OUs=
X-Received: by 2002:a2e:94cc:0:b0:333:f53f:1bbe with SMTP id
 38308e7fff4ca-333fac83beamr3948621fa.7.1755156014062; Thu, 14 Aug 2025
 00:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com> <20250813161517.4746-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250813161517.4746-4-wsa+renesas@sang-engineering.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Aug 2025 09:20:03 +0200
X-Gm-Features: Ac12FXymdFzWV3g_JZazK_vzgETVMckCMj8Na0v79R7sG6_qTW0BLLb2z8dkgs0
Message-ID: <CAMRc=MepR_e8jkzOyRs6RwP6BTKDW8RAB7-Z2GF0KcAr4VmZ7A@mail.gmail.com>
Subject: Re: [PATCH 03/21] gpio: remove unneeded 'fast_io' parameter in regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:16=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot =
is
> happy, too.

Applied. b4 generates a super long list of recipients even if I only
apply this one patch and I can't send the automatic reply due to
gmail's limits. :(

Bart

