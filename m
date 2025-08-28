Return-Path: <linux-kernel+bounces-790548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C4BB3AA18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CA1169943
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945572765EB;
	Thu, 28 Aug 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogQ7rHo1"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E421579F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406023; cv=none; b=h1zkQxyc3c+RQsoIQDBAJuknq7VCYtpKjPCRR4ZaMbRGvh4i4Ga29Gp0cTv1bG3z+AQRqmFt5yRbUBq2yg64zoyg3bsKQd27Ct5loar2Nzc1nFkUBzhcsQ8kctF3ky9NhWfQBxtQ2jJgCmRmrad5FN4oxX5r03u5smRgfNCtLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406023; c=relaxed/simple;
	bh=Ug7kHWgRNLIoSkrQx+bdDx9etZY66BZYRS/MMV25bdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHadT/THjav/6+h8zDL1VOd190aXoN49Zr8VKKwe4zqRSw4ZwREHHG91Xae+Eb5G8QYjIQey7XQ9DHWbmAbf2Fvq1NYwI7tAseP4J30ZdBfVSILnixCtLGKOjcmB2RpmRgb0F7dyit3mHUQArE9VRIU7dJtk/yNDiAKGHjuPmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogQ7rHo1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f39a5e85dso1418575e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756406018; x=1757010818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug7kHWgRNLIoSkrQx+bdDx9etZY66BZYRS/MMV25bdk=;
        b=ogQ7rHo1xUsh1MRii+DSgw79BIwRz1F5WcxON3n/wkvNlKijTpVC/UnPIEcbgpIt8C
         fj0seneEGr1pIaqZLwOkBfUCQTczUwNMhxErC4NlbMt7Pcn9g6oQclglzaQ71N8qSOWA
         BAYqezz4iM5ppEPnXfJGdpOGswdlzmYUZNyY4Kxz4L1Su8h4kXpPVk4zOIn57Vdqr8SX
         6JSslz3pscHIbA7Ox04Jdi3mRCfN7cx0cdky+GlQHGQ0TI53gc3vY0uOWWtye2+KPZmm
         VGrjDeTLP+mSoXmbzo++ENz/c/+VGtwvLKK2hEOJuU0hxDmkKZsVm/Vd8tO4IpopCT3C
         hxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406018; x=1757010818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug7kHWgRNLIoSkrQx+bdDx9etZY66BZYRS/MMV25bdk=;
        b=Lehg+MSWCz7+84AQN2NciR6bwvu5By2CK86Rpq/AgvtBC92xuIwAyXcPtkh7Mqd2NP
         2TCToXZB5Stkw948SX8kYlyPMw2qrtIS30fu/VVJa9ZUTTQY8HYLxOG/cLm/sLbU//Nx
         eISsyTXI0nbf856UiOdL+0we1xb6tnrLRdTnbEnVAordixORwvOIS3uld/FLhweXxBEf
         Gu13UrP0vw4FgmYHDt8LBrEnbEZJbOeehU9+7xrcVi+fySm1y9wAicVn5ZH6gXmLj1Fo
         DC2279VkE9tXqCldoiArgZj4CL3Ne6g8Bv567sAbmzuWHgC3KIwo32T4RmhcF6oLoD1L
         B3ww==
X-Forwarded-Encrypted: i=1; AJvYcCVJt1NM63+3LzyAUhRbJTRAo+xV6aTqSnhfZHNmvf39C/fPsUAyt4C9m1XGuns+jdcS4sTaIViNWHEqKUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtKKZLw3GaXIeDkvWYjrq6YXLgaKoWo+RIny7QHgR4Z7Wao41
	vUgxmAD+2r+lK4ckSl9aO8ijxhkAAv3AyEFXwsGOpposJ9ylujU3NmJhSgmuuLMiR+UpiObexMC
	NrsYqv6uPoj0/Kma8xhqF2ktnkylOTj1s05/2swMcOA==
X-Gm-Gg: ASbGncsR790/EZncG03wu5SFl2iXQIl+x38WLGea9zeTA3t+QhKPS/41HyZyr6n3nJh
	Hp0rSlY+up6osrPUhlItwAtWleWtEvZWpXimhf5K4JLOG940WeB81l7Hofpc9D7063U1HIqTTF5
	r0E/i2UA6aXHymU8/08pv2lgH4+yq6PGLc8C8KLN0k8lqcBfTDYVokiwdKkAt2KDZp1IXIdw9Y2
	Q5Ti9I=
X-Google-Smtp-Source: AGHT+IGb4FhQgeb6pylU+foopmFlzVZy35WsHuHgEvOZCfi3ebP7rSk+t1LD48Shfg9PDb2NUWM5svtDXgFS2btqXyA=
X-Received: by 2002:a05:6512:6cd:b0:55f:4e8a:19a4 with SMTP id
 2adb3069b0e04-55f4e8a1b35mr3937880e87.23.1756406018199; Thu, 28 Aug 2025
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826075812.82305-2-fourier.thomas@gmail.com>
In-Reply-To: <20250826075812.82305-2-fourier.thomas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 20:33:27 +0200
X-Gm-Features: Ac12FXzCysAJtxk2vG2apRImmPlR_dR4-9QzpsS002mZ0t6e2m5C_RfHnYJm73c
Message-ID: <CACRpkdaVHTh7MJfngQ=qhe_ZfZxr7b025G=tAwsCvBfpXVYZEw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mvsdio: Fix dma_unmap_sg() nents value
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:59=E2=80=AFAM Thomas Fourier <fourier.thomas@gmai=
l.com> wrote:

> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
>
> Fixes: 236caa7cc351 ("mmc: SDIO driver for Marvell SoCs")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

