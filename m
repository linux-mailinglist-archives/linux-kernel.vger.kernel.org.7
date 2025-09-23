Return-Path: <linux-kernel+bounces-829757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62817B97BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245612E0C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44B30F549;
	Tue, 23 Sep 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZLE7mrC"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2E2DD5F6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758667322; cv=none; b=X3Slask0sESAsfhwn1qLVmbvoHHbiUxktsxCyCLhdmySAcFd97gj9yl4h/qLD1627SeNNG3y5imr8fsQEiDZO0YJJ+PBE3J7pKnAG0OGGxUifholoOYwLTpKrygwxp+8/dkjKFTjpQF9N+1wwY5x219cRw4fx+wjbgN6E1ecK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758667322; c=relaxed/simple;
	bh=6SWHpC7XT0boWgdfna8gc+pG3x0qlvgKa0qIbsC+iC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXd10aX1N6rJr79SQw7jPiOTA3dZS4mKN5qcNweBLIgyhePnQ5TDqnrMm5iEvRckebd+kd9zQlnFruEi8IenOBiWryrRWjvB9BvjQHMK6h4seacA8U2xZ98GEeOnsFyFPd9dZ8CLRSrA0Mp5pxY265ppTIUte3D8vFUD3YJKh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZLE7mrC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-578ecc56235so1420527e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758667318; x=1759272118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SWHpC7XT0boWgdfna8gc+pG3x0qlvgKa0qIbsC+iC4=;
        b=xZLE7mrCYYRk50mOsKeJMVdlzC9EjUH7yp+MsQSd3p1ilHA4L1G9Zq+axJC+4nSoel
         AbdHn3ZgeNcF6vx7VNan+SwkgaAorcMRsZs5pcOYRrHIiocMCwwtJY86ZeMUIsE86ugc
         27IgtAR7KFSGcIm0jFcPwdZttx6XuTYwME8hnPwmlbVW7cBfCc7QJKjoq/DngNqmbjdy
         wf9mhswgbShUZO59M8wMIKjWuNXeDI2y3KlAOJUlsAHGtlUPq+7IVbduUo7PYQ8SrEGT
         8qdDGjcLESKKhtkE/vqsLOZ1CXuI0EAjzhkSePGJg2P+oSdQ53BvTjYRRDk61Fon4K6K
         FI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758667318; x=1759272118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SWHpC7XT0boWgdfna8gc+pG3x0qlvgKa0qIbsC+iC4=;
        b=G5GCJgnQEl0aQ8jrp4EBIGy0aBdrqCtAZk6NW3jUvsxGgFB2YmMHzRjFxjHuYij606
         IGEm3X9itB18qEXnudSalvTsHkv8ojYsCb9Aadu/T0ryEu8flGmjQ++xXMFtBugm2MNx
         X1zxoFsKNxKY6EGVE/EFqBOMsltCzB3xJZis+EIhBvoL8Pfk2C6cd53QzeXg/bcdXM8f
         LXxMQiUekmlyF4f8MHtwr2GiOK8yQrJeEDctAlYKNntgomS76XNsncIoE0Eb7ZCHcCXv
         lCDj5B+RdKo3Rrbm87SbyGz3wI1s5iXZ3rcQ/vexGJ8vDqHckERZvRvLhB6bElcRgqV9
         oBVg==
X-Forwarded-Encrypted: i=1; AJvYcCUcbpxK3qm7zKHs1/DAj6TdBdBpa9X4rIoL6RZI4rMUTNVW6E+PJ5odSqXBADIc9hsudXJ+2DF3poJlzvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKemK2JXPuMyU1wSFGDeOc3RKPZ7FI8rlY67VP04yr1PFKe9GC
	SxoyEYXM/mqyhr6Tc/vYnXRirv2haLEehpoNkBi/wYPD8UV54pUhttxdd+oKrFvqHEiPlcMgRYR
	s8KAU2DBJf/7GC7XHf66MNBcC32HuuYDtpdsZMFA35w==
X-Gm-Gg: ASbGnctZNF+qKMYkrf9j3xK6KutGpZ/McKwQyxPGEqxWH989hVjMYCtVjQZfJMiB5LA
	5CZQEGYUX1y5/57VhGXFR2bnxeXh7h6LC1c646vPsUEGe1UqT/OlYwe5pXHi29gM7kSZVMRHN3F
	JkXackIpUM7oC1teeSzmsRU3Sv6TWc0ncV0743RoAm0FLtbwDy3fYsdlW2sRhjFG8wUeX2Tecor
	KRJmt4=
X-Google-Smtp-Source: AGHT+IG99GeGJ6EJmRFtaCX57MxbFFNDKEJDSpjz4IOp4Xv1ApJ9GNzknCU6gn3AgKwY56E7tlVN9VixGw0iGQWzSiA=
X-Received: by 2002:a05:6512:4007:b0:57a:7be2:21e4 with SMTP id
 2adb3069b0e04-5807051c520mr1245993e87.9.1758667317970; Tue, 23 Sep 2025
 15:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
In-Reply-To: <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 Sep 2025 00:41:46 +0200
X-Gm-Features: AS18NWA87kQOtTQ-6Uw89hDflE_WXMd3ykrYMsrH2sWDsx3-k27OaCZ6EKQ1YIY
Message-ID: <CACRpkdY8AN5vRQEt=3QzdFdPkvx0FLiv7QmwZ=eqZBSn9sUtng@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
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

On Wed, Sep 10, 2025 at 9:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The (typeof(foo)) construct is unusual in the kernel, use a more typical
> syntax by explicitly spelling out the type.
>
> Link: https://lore.kernel.org/all/20250909-gpio-mmio-gpio-conv-part4-v1-1=
3-9f723dc3524a@linaro.org/
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied.

Yours,
Linus Walleij

