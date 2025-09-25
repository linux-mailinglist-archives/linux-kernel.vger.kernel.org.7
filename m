Return-Path: <linux-kernel+bounces-831929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F879B9DEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042212E5673
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5A258EC1;
	Thu, 25 Sep 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lfJKPzOq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C219AD70
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786731; cv=none; b=A4hyRXJJHLZNoBMp0gtpYCVU96y/Mlv9G7PsMpNJLIcGpu5X3YJ61My5L/O1Z8DxzcUkDuvRSQXLfgjskbvL9qL2apRn8QVuypFcAdqpdsl3E6QfxX7ZqqFSWKY4X43BA0M3obpv2rPX2ske5oViaH9pIwbFl4x6UaGjDk4A4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786731; c=relaxed/simple;
	bh=Umxh39nHGfkgypJPyOPbacKoWCRJ+9b9PmAXkmDpko4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODBe67xUmCwrca4qHNDWRi/6Nu5msApqYTN7+cIsGgtGpL17iI44rJrCX1N6gEN2zNHoYR7G9lo/iIXyZ1Me5nbWNjw/9YXx4eThH5THMpJyTvrG3OnTm5JKHj9HY3AzDtwDN+KqgC2BGKngNC13t4WiQSaMTa5l9nHQcbzbEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lfJKPzOq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so708311e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758786728; x=1759391528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pmdbPSS1+PFGOQZXgEhCWxoqVsYqlqHhZMSV2rIROA=;
        b=lfJKPzOqCUrq+Uat6EBSiSVoDSB+T7Nkll7waVBeAYahSvGf5OqRAGuZQcW+PDrQ5e
         Jg3q0tF2rk4jDvEt09axr4jid7+IHz5fhZkvhDXHMRl85v8EvwuivylLfWOBlxnjZ2d9
         ZT5npTLCbNIwgeW6h+W/yvJLX2JYqEz+60/XVNdAVHyZvak7YVQ4Coj281u4ZYMPb0JJ
         1kJF8hWZvHWY9ZvbFQ4mUuHAXU0Mo/sc+flLiYSZOc93na95aq7VDGx8UoKXylmNAVE+
         gzpxR7gxwYbjgXKq7z8DI4PeaKvrvqQO6mXfLyZNaHkcx1gLiWverqjcOmERMAYTVGov
         kidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786728; x=1759391528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pmdbPSS1+PFGOQZXgEhCWxoqVsYqlqHhZMSV2rIROA=;
        b=QxPKdLu3ohfC6CIefpcw+tmSpuXk9olAVXW+yb72HcvHgqsrhaKdLoUbJEZZTUFLPq
         +WSdMnL6TDi7tRxTCnDRZ1sNuU9qjrCmlDYVmvaJgbaCZKmAiy5NqFd0PCX1o+k0yY7q
         oXh0LO/k3fy+GQ1WANHR4cNQurLyW4PYvyTCjpkohvyIRy5waAYTTXGZJynJCMmeKycB
         cG+ulrsfBP5ZQJMc3LDCQvQ5dm4giLh6bOXvayAtci02iI8Pf08dzwhgvdaeTIyfu0bK
         xK0udb+ArcN7aylOId34uEeit6ZJoLsMJlb/16F2+vhqj0q43kQ+r2NQK7fNaGVSdTiK
         Pdig==
X-Forwarded-Encrypted: i=1; AJvYcCU1gTe4ilUiv3Gde8TYtTk5wkaoGMl5sRrk07Zo9VGf28Ny5+Dr2frQEx0lysSTYNkCa6e+zZyPjBxyS54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1hTQF4NfTSNjDwUueu30anVasc+Cq9otSUYnuvB9138TIFa5
	PwPIvCZ5ou+wpdI73n/Tm2MA+d9WLtDfvUouU95HWHC96vmDtNNB3u4V1D3ZiSAJVhaI3s5+OgD
	D7AHGOInTTzRqsHKh1fRnLNZp7kpdSJJ9wGzNQ5buyg==
X-Gm-Gg: ASbGnculcMfRMfEehQ3IbkU4kYK7xcP+MQmJTwRxZ+0r0CfoakIx2PtalrdsocqnHKa
	/8ze3bgz8QGBRImUqyl8q56Csm0mxGgTC8PgSOKvQYFmK+2FKBY7SUc61IVniBuDNmFo11sClrW
	5PKg5dFQTSAqqzLV/oeyQoIbUD4JcZknJfuqU8btCdes7tAU2V28mzsf/Z8e53Hp3DKC44ruEV1
	ib+yrC6t8K+Oi4f+RhHVc1KZNKIZzlxwkz3Yw==
X-Google-Smtp-Source: AGHT+IFjDFQMappKZZFROu+v6o3bME1MjtTxrIbJ3f6pWVz6MpCD55Lk6Fra5LzFmOtZoqCjtC5vbl0PRHtSU8AsH3Q=
X-Received: by 2002:a05:6512:3a8f:b0:57e:4245:114e with SMTP id
 2adb3069b0e04-582d14effcfmr700774e87.24.1758786728179; Thu, 25 Sep 2025
 00:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org> <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Sep 2025 09:51:56 +0200
X-Gm-Features: AS18NWCh67p36-1DiEra54BRYeOZGMgpqlB-NSoS3MdBtkk6GMB-z9-7UGdMnvw
Message-ID: <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matt.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, 
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Yang Shen <shenyang39@huawei.com>, Imre Kaloz <kaloz@openwrt.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 9:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Bartosz,
>
> On Thu, 11 Sept 2025 at 12:02, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The (typeof(foo)) construct is unusual in the kernel, use a more typica=
l
> > syntax by explicitly spelling out the type.
>
> Thanks for your patch, which is now commit da3a88e9656c17a3 ("pinctrl:
> use more common syntax for compound literals") in pinctrl/for-next
>
> > Link: https://lore.kernel.org/all/20250909-gpio-mmio-gpio-conv-part4-v1=
-13-9f723dc3524a@linaro.org/
>
> Looks like you (slightly) missed your target. The correct link is:
>
>     Link: https://lore.kernel.org/aMAP9hAWars0T83r@smile.fi.intel.com
>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

Hi Geert,

This is a link to the discussion with Andy as per Linus Torvalds'
recent request to use the Link: tag to point to actually useful
information rather than just the patch's origin. Linus Walleij doesn't
use b4 so the origin link you'd normally expect to be added
automatically is not there at all. That's probably what caused the
confusion.

Bartosz

