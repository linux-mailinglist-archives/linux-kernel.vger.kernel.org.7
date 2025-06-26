Return-Path: <linux-kernel+bounces-704541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4AAE9EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C3B1C43FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539FD28F93F;
	Thu, 26 Jun 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B2URa0mm"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AC28C016
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944322; cv=none; b=NIDlDBR8dsS0NwEdKYBeLDUVVju3fPbHj2Xzh7bUn3/UVQHceLv+Bt9OImqBuDnLY0g8Bx0Tj07YlcVeyTcoERhv/4MS2GponGQTvpfIBmw6FAh6Kb78+/WjOz1/xENQWjZbcHOeki+Cqn5rC6DPjJR6rHuUQq7135/ITM9erNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944322; c=relaxed/simple;
	bh=enT5vO2ALcAa/LZ/Y3Lm+uixPZpZ0NB8EkbAOpe//TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN5LQAy+R6QUGKz9o8u7le73mWojp4BWzNyh+4xvAG8ykWpWaRZLra8C1WWa/scLoTWIieu9ffT3Unzvnch7CtJS41dx4uL37qA38zNdnTThqtVn+LisGqRmZrUMrVKPci3R0b2T1ElsvDC4XN47WWOGexvFTlpPJFArlAiNfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B2URa0mm; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso1150503e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750944318; x=1751549118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLwSjoUY7m1Ln7Qu4AWMnTKuJMVdB5FurphkXRXpBRw=;
        b=B2URa0mmUHhnUjza7rK4696DHHQRqzZPsZe5TYKZKfgX+wCd+wRPV2jMDwS/ZdKSLd
         GG29e4E2LuL+S6ctn/2NS4m/6ZIE2g0iPL6B8QpKy3nOO5WwKcDTr8e1HuUw2uq42BYs
         VwDUidPE0YGep05ZnMAO/6qTkLMKYq6p4E1qlVkEwyO4CkhyfQSXd88NMQDxTBba7RWJ
         D5CmwT6dZt+QP4retuQYMnXxS26f5thUFxNkgLK4Odj+9rxPKwiziZ0xMnrF9a75+8aH
         7x2ei/oncy3TeryRSUA3mkUn6WU37Lr9LqHWN9rimDXlFPf9y4NV9WSUoJgn5+gYBKG5
         ic5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944318; x=1751549118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLwSjoUY7m1Ln7Qu4AWMnTKuJMVdB5FurphkXRXpBRw=;
        b=RO8PXD6AOtYBnut41ATcP42pcYiB1Gxjjej84nAXss6tYVNu50PWmn4Z4Ada8zVlYq
         q3S+U697uV0WM7IGcWje2LNZ6D75PE1cm2v/zQEGgg0jZJFRWmmN5Y7T/oKTfzH1Js8o
         Fx4l5kmxLdorHmR4//7M5wL7xiHiW7C5VGH3JSnLEejZrQTcmC+uItnybwhofRavYXg2
         wBmbi0+v0KAfOeiiHhmsfTMl/5gFNvauuqL3zrgpGVjUk9RCgVuiTj/Df23KffxrU66D
         eOjwMsXk5YK3ZOplRdxA+6GtXUgM8t6o3kNuHZzoAzEzSo6VZMaGrfa3OYY4K68/YzEE
         kCPA==
X-Forwarded-Encrypted: i=1; AJvYcCXHa5B0t4wmP1276BN5D+LeAZ8HRAEDtYossqmdsiNknfp7BhnAqQ8szXOmtcqPUCGrP0c0b1byHFmXfwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNGu9q7ssRCXblfQ7FA2aOpyv2jmwTxOHYO4MAelBUsHEo25i
	fbhD6tMWQWPWC+l2aZhnoOl7WtryAwSfSssYSadb1i+JPBUh5KXOwfID5uTm1waXITKS9NW8GSE
	L+DzO49vOmreZrNxHGAFluPfmgWj70ym14Kd3dXAzSw==
X-Gm-Gg: ASbGncuzfp7fpEEpikjR15+Isftgo91vvw/EEk80stTIA6Uei4s2XdX/2RiJ+kxFUuv
	akD0rBCS+31mHr1rNM+llMfAJm1Dl7SyP6xA7sq9CPSRcgue3Zf03KYk+P+1roh7rVBnY3EQ57R
	MY+OMalT8DOxYUqZN39uNojlTd5xGv1tuSuaqm6mFscSJQnmzsXPOhgvxx5HfEJ0fKpDGHOIi5F
	Q==
X-Google-Smtp-Source: AGHT+IFZCHpg6dN8jQOP4LGMeE8N6TdaxL+CR37n8aEWMLkZ46xkrupRdz8U89iquKgLZ75BaGxTbVJfXxSWy4Rbayg=
X-Received: by 2002:a05:6512:691:b0:553:aed7:9807 with SMTP id
 2adb3069b0e04-554fdcc531fmr2571744e87.9.1750944317960; Thu, 26 Jun 2025
 06:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-gpio-mmio-pdata-v1-0-a58c72eb556a@linaro.org>
 <20250624-gpio-mmio-pdata-v1-3-a58c72eb556a@linaro.org> <20250626132257.GE10134@google.com>
In-Reply-To: <20250626132257.GE10134@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 26 Jun 2025 15:25:06 +0200
X-Gm-Features: Ac12FXw9b1Ua2nskF_gKsApdHRnQVgOC-Rscq226tK5vt_NGX_5zRRRras-l-hs
Message-ID: <CAMRc=MdBipydUjEKXDufMAWNZjMA18RKj0XcNofrn1oR7bXTZA@mail.gmail.com>
Subject: Re: [PATCH RFT 3/6] mfd: vexpress-sysreg: set-up software nodes for gpio-mmio
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-samsung-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 3:23=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 24 Jun 2025, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Replace struct bgpio_pdata - that we plan to remove - with software
> > nodes containing properties encoding the same values thatr can now be
>
> Spelling.
>
> > parsed by gpio-mmio.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/mfd/vexpress-sysreg.c | 46 ++++++++++++++++++++++++++---------=
--------
> >  1 file changed, 28 insertions(+), 18 deletions(-)
>
> Can this go in on its own, or does it have depend{encies,ants}?

It will break the MFD GPIO sub-driver without patch 1/6 from this
series. It would be best if you could Ack it and I can set up an
immutable branch for v6.17 if you need it.

Bartosz

