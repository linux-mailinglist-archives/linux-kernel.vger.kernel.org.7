Return-Path: <linux-kernel+bounces-796341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD07FB3FF24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E6E164663
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611C730E831;
	Tue,  2 Sep 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ktw+Xa6Q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E730103B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814248; cv=none; b=eHkyUgOtg64CgzLDDiBg0mREZcaiPHEbPwqeXlsHlydClWy9GI4ij+QiCrKfnY490VHTY89Z9xq4kLX4GPB7xr3Yi/jdQ4qJY2DdHh2KFIaSei0lOSgmz11vU4SeqZ5GHn25Mf0dpmCZV/+XBvzaHVNxoFZiGUbZ4SckBKD2XbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814248; c=relaxed/simple;
	bh=kkPqc1cvhELv0tJYEVHD2ZdMWGPrOMkmdqrhZS4yPg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSOP7QiD2GrHcEXkNwsoaOoHAd2eZUojByO70+VbR3sxgMwc88ODYkX3fdAasixoNH3wUZ1QQTuFPSrTvhAr6rNf3fn0zxD0xz2SHhJPNnujiYCenC18mXcxPZsC7N2Rk2UaDvt02KD5KnUdtN/rKA+WEyTgAIj2yNcG2tcROLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ktw+Xa6Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f76454f69so2175825e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814245; x=1757419045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp4Abv/fzY5toSq5c8kjCytYfJxDDQ+v7rc26B0Blgs=;
        b=Ktw+Xa6QWfwXZkenNWDpRsP3Zc7Tqm9416Tlt9m4HIjOPAnzCaj6Jw29SUcvb9mQaO
         Frb2mrUkA1bFxsOOWkbbDIMoZ6Z4PIuezinM1sD2qLIWyyl/98HofL0KWTaO7T5/ZXXz
         yGt0S83oUBaZMMGJKRBIpGtf/yrsR+DaOkVjxyjUWFQPMDqcUVBERlVsWi+fIUSQ/S+1
         6YFMO5iUn1PZvv/Cg60CCup3plzeY+nk2LyXv0FS2/3NpJRE6OrRd773NaceR6zUqmpi
         bhENwdj8O21rXNMHDUWfuTGTz5VUn+x8mmRITJuvWu6tqU6eXK2zUGCZ6X4x5CQL1QKC
         ntoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814245; x=1757419045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp4Abv/fzY5toSq5c8kjCytYfJxDDQ+v7rc26B0Blgs=;
        b=FiYYaxhzRYr+/MViaPhDsFa0SJhC4cHZN4Gr9fmL4N6CX3A1158iupdakVvRKKZ5Ur
         KyqiWJMJDaQTV2W3flheJuMFuq7q40OUmIhDUpG97Xxx1sKmniBCaGVI8X+s0dE80Bbr
         piXJKXLse4Q6ixz+XWA5WCliscSdhKzO7X7tWHfVQqM3+u9/yGF2tVoyCt7ZFvGpngir
         9eeNvO9bGSI8hjmfM52qjsy4n72TKSCNU5q8D9+ETe4G1Y/hKQPvi/Y7a8BughbCtoq0
         C2/b9XfqYBkukqpX3jKYtttCfYaliHJdPov99BaT2OeOcxnnak0uhtBPwXpUab9Z7AYQ
         muqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVGfPUqaAxaiRzJCiVE2jcnGnQV7l+132QuGba+ExvUltPnODGtuTv4u/7nELnrTjuCL288BqDZmA36P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHQn81wXmeNzlvP5HQBfhfPPtU8HZNEIVMb91oqjyd3eO8MRf
	FM4JrCi7ZhfFA9I31W7iiNTqcliW6h092m4AXFhjvG9NcIOKal3ZTcn8mXxD16brw3d4EYyL+86
	Yr5ie0pyEnYdVvkJ64/BA5au3tn37KsBJ6eDaSFQVQg==
X-Gm-Gg: ASbGncs8TZwzs1w3lM3inH+vB08uR7scvCSZ9J8MklBFEpiEx2X5E+5PDVpHMVuC+Ew
	8WUYBkJN3BMctaoKgaWiXjCNsDDDF5cMO7p6S0GPprGZ9QIZG9VzAjFyy2rabiMs3eywqRgoSmh
	tUbB9yy8f6MU6c+RuYsFZWES/+mnnOJ+nwAMfAAP7tbLuUwSDbKicsUkdwJ4qnOvSSmuTutwo3Z
	ncBhfUS0+UaTGrErRJ0QZvjer5gQCV/qKbAoXM0kIN6CxhHng==
X-Google-Smtp-Source: AGHT+IErcjW0+LGFGJcHQchCQeR1Yt+GA9XuQLP2Vn98G+VTiZcJCdrpPfkwDR775dV3lM7lVH5sLJhNO5IY+DD19Bk=
X-Received: by 2002:a05:6512:3b8b:b0:55f:554c:b1fb with SMTP id
 2adb3069b0e04-55f70912819mr3298424e87.29.1756814244976; Tue, 02 Sep 2025
 04:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org> <175680785548.2247963.242433624241359060.b4-ty@kernel.org>
In-Reply-To: <175680785548.2247963.242433624241359060.b4-ty@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Sep 2025 13:57:14 +0200
X-Gm-Features: Ac12FXztQMclI5iZSDKTIUNQ7QH1_dUHxuo2PxWIXoNlkSSmA9MCP00AzVcpvI0
Message-ID: <CAMRc=MeWnrSPrLOq7yH71wpw4vP6RJiLnuLCpwXogZn0yugFgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:10=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 11 Aug 2025 15:36:15 +0200, Bartosz Golaszewski wrote:
> > This converts the vexpress-sysreg MFD driver to using the new generic
> > GPIO interface but first fixes an issue with an unchecked return value
> > of devm_gpiochio_add_data().
> >
> > Lee: Please, create an immutable branch containing these commits after
> > you pick them up, as I'd like to merge it into the GPIO tree and remove
> > the legacy interface in this cycle.
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_d=
ata()
>       commit: 14b2b50be20bd15236bc7d4c614ecb5d9410c3ec
> [2/2] mfd: vexpress-sysreg: use new generic GPIO chip API
>       commit: 8080e2c6138e4c615c1e6bc1378ec042b6f9cd36
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>

Thanks, you haven't pushed out the changes yet so maybe you're already
on it but please don't forget to set up an immutable branch for
merging back of these changes into the GPIO tree.

Bartosz

