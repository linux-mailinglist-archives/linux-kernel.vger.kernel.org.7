Return-Path: <linux-kernel+bounces-838593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E334BAFA99
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046B34A3BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020402848BB;
	Wed,  1 Oct 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2JbSdkq"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBF284665
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307816; cv=none; b=jpyIlXokukp5i/5UGpM2yYAvalTXOLgFgWb1Ka/UGxvM321Ks6L/CKGFOWM51Z2Geab/q7V36tSlBz5is9k8DwpZw+OyayJuxpq29Bp4S+l3QZ1leKscflV1iRccZBvDCOVQc9WXqF8VoL5Rvw0KsAG/rv6xwaFq8XTrG8xB1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307816; c=relaxed/simple;
	bh=gzIdYM+jt7Tm5Uc0vWk+e7hcdztHdOIk7pXCG5DPn00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL0d0uuSjE0w9k3tkgRwNRwpaBvYJHlwqltqG4iELRe6uBBFr8SYVYRLIACU1WrJ4CZQ/O3ALD+Dwa9l8dBMG3IsnxUMsPurmQPFsg5t2WjrpjKOmkC88/+nt5R0V+s/DDd2tI5nsB0c3NPQOS/0DIcUjNZuv3QOeuas7I1nVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2JbSdkq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-373a56498b9so8836151fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759307813; x=1759912613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzIdYM+jt7Tm5Uc0vWk+e7hcdztHdOIk7pXCG5DPn00=;
        b=y2JbSdkqXAxPLb82GvTI/Xyw8K79t4O8sinKKsLGUgqsg/Y9Q1d6cx0rdBgSvyxNW1
         4KUb382KzJwnGy0g8zCLZGv3xhxQMwaOiYJeB1zCBkYcHluGNz1lixRzaogjK4YgBRab
         QeJZL3vZawXKgflzGQFyCBq76JcTqjpvYiT6eOJe6X24vocdzM61rRoCMD2P8o4eYCbh
         ZxLoaAoqSAtLB9gurHNPFNHahBgKULjl/SdTij57T3Ri0s4yP9WNn1Faihls5ScaUL0+
         FImiA0xjK0vPmPsj3V0LhDHbAODSqY5vM1nI7/D2iNpjfqSAgD/XD/YSWmKFfh1gTCyO
         XQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307813; x=1759912613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzIdYM+jt7Tm5Uc0vWk+e7hcdztHdOIk7pXCG5DPn00=;
        b=PfZd9lwVgy9MUYXp7MEcjxsawHeJCusVMhcnWCZ2f4nWoby31J51zH0CGZTJ3xZfJO
         xASgZ6EkhbSJ1Qh3AeQg2C+UmY4jGoKFaJu38ii2kk5sLP74i/V+KIQjZizxemkjMQF5
         cHW854rt7Uv9cvtPpd8ndiADRfbM8QfQu2kiuPOn+HJErQDZT+02iweay+8ZFSMBBidy
         2ePt7ifGepaKIJN4npu/srpXFVRE++ojYVle6PYpIsHVuAP/jusjhlHDMuOnTiUwGnNl
         /nFijg/CmtbNGXcrEOSdXqwSu0r/5xPlOhL1nbagB+YukcOQasG9gxOvHPge5+ad6iUV
         XMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9MJ/C4eSbVSwaNC9AlFPdTNSsCWXb5sdjmwvscFmTDg0jGslRCZD9oLmCgEoAmYoNWjUoIPAjrqU0ul0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNPXbUIAUkWKzuIcNw5uVQC10AQMYa4BmzfqPOEY9GQbRWmBh
	U5K7aCIBOoOWsnFvewkixj/ZEP40syKvVbm6C8eYWGAs2HN3J9OEBJlQ49Yoh4Y8vgDUYHUYnV5
	NytIlSK7dc0LiOsfeATUQIjdx1G/yQCxB080rH+QudA==
X-Gm-Gg: ASbGncvqLzS4cHtnBGrjt5TDrV20DGuUmSz5Hnt/crQTtxQF31WSn02upY9arB5AVxQ
	Sjyh1CjbA16J/1W1dToy9KKjF6EAIzUVe2/OKHuWVVWO+CrT4yZIv5gkYUM70Mr0U/nBBup4CRK
	Z+941IN5+wTfB/Lr7eb0hKMykoocugPJLjEn/2MYqV/pPB1QL8eBoeiED3igS7FB3fVYDPRIO7o
	LE/OKv3jitPqIpRc6wvUmhpgAmnqZuaJLMvftz9Tg==
X-Google-Smtp-Source: AGHT+IGR364l0fZkqCbX1kIjKIvYDxXIcwBHw+lqJUfFGXSzirJ8uNvUMS79/HggJOLuN/qEVcxWH5dtrV9+RyqdghU=
X-Received: by 2002:a05:651c:210c:b0:357:ccfc:64ac with SMTP id
 38308e7fff4ca-372fa205204mr25896051fa.4.1759307812626; Wed, 01 Oct 2025
 01:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
 <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com> <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com>
In-Reply-To: <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 10:36:40 +0200
X-Gm-Features: AS18NWDoMdvnOzF6_wDEnr52XVC2ihE3QCB2mnLOoQUz_n36xv-rRAEh7yvMfRw
Message-ID: <CACRpkdbo88o1g_VCp0+C9hfi1VQkP99x2Mnkw_DTctBEtVAa_g@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Lee Jones <lee@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
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

On Thu, Sep 25, 2025 at 9:52=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> This is a link to the discussion with Andy as per Linus Torvalds'
> recent request to use the Link: tag to point to actually useful
> information rather than just the patch's origin. Linus Walleij doesn't
> use b4 so the origin link you'd normally expect to be added
> automatically is not there at all. That's probably what caused the
> confusion.

What? I use b4 for everything, I don't know what gave you
that impression....

I have however removed the automated Link: tags generated from magic
gitconfig hooks as requested by Torvalds in v6.17-rc5:
https://lwn.net/Articles/1037069/

This is also mentioned in my pin control pull request from yesterday.

Yours,
Linus Walleij

