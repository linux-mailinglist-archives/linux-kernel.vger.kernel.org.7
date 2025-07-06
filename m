Return-Path: <linux-kernel+bounces-713100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA3AF1358
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD57AC618
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41256223715;
	Wed,  2 Jul 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="TE/+6YQJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B3229B13
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454458; cv=none; b=UQIgVc5jiYOLKuXTsk/QNBgmKzmLl+T+GkpjEL6RCmj2iYoe718zxAoUIlqjbI6YTi9f2t93E32uptF6jRZpONhn/tgYGPWqXgJ0t7rx0sXpX0pHseXo7sv3R+TDcLabWPfdrjK/6ESC9Tq+trA2dP2aztxMfTcssIx5wyYjMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454458; c=relaxed/simple;
	bh=FcDWilOaDWcVuzP7mVz9zoKRX0Rnc7UAViC1O23BGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsFcLT0UgsGMSLW6zGEn3WnciMNNuyKwtI1F2gyhXuR03mltB6qiPAe8DkSGTVdXQNy1Gua4xNQxwS058nbif5fqulfL8ti7nmATP5MMzx+Vq1wnhRV1OGqX59IIU9pUvjDYvvZM/dealhgWJ3srUEeNMljpfCTBAFGmGTV9eGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=TE/+6YQJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so6031815a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751454455; x=1752059255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPV93Zxqd5A5yWh1+OQ3kXQBktcCdNYnO7HGfnoF97w=;
        b=TE/+6YQJkkVhWbLqOJTGUEwxumYYTd2YCaBEDnC0z1GqaUKBjKQrUCEDYQWHj2fdqd
         JkWVg60p3kgxDoVk2X9bpJSf0TU92JPjT3n+oUuisHxEt7x5dm7DuR5uyDR+3/mjXwH0
         yP07bjEIZ7IN/9HlMbcsXJf3WaLOSAIg06Zx1wgEieqVVvtrZ3T6s0tMs2Jn3NjuyZMk
         b6t0PS9kP69uY8Ff2vaTkHoNOBrU+GhwKXbrdH0L3Qt06R274X5rdg43GMoaXr4oG0Ni
         mTWJ2OtRu7oAhWLxwWvB9CQ0TekDyXYrKiXMUyVHy1EJUWlnY/j51lyxN6Vxk6ZhKMiW
         NqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751454455; x=1752059255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPV93Zxqd5A5yWh1+OQ3kXQBktcCdNYnO7HGfnoF97w=;
        b=T1ODdBp47b0pw3/AuSto10NEVmLIsxqT21Q/HLWjeT8RS5NMzpDOLskm9ys4AJflUp
         f1ZNmyQgpOCCb9sCpCit5C5m2VdLcNxyvTWRoF15Xm0Ebl47M/oYYgVndMVRUPCtbUFP
         FLNsJhqtr16ZUhqMoDqQ04ZukkUGbyCGK/HAFtexNWuccNBEu1E8UcxcD7Dxid9H06Jh
         5/MrrHF7a16H4jPqKBfuddq682Ik7HVZLI6c4YqatfWE5Hrs0GHtH4SkcWJT6+qdABHn
         xwEQ9sZ4BTeFkhXmxzmqmxMWMb68R9qH92KrHK0I76OJb9cFnyhaRIqK6DTITlvkrq+Z
         CbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWpiX3Eoum40jgrR5WQZdKMV3WBkoxnDrKyR4qHvYFeSbV1PNaCJR++cLnqkHqrzB8qH3vYT3RX1H53DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69eOAibw1cetxEJXcrSj5fpxI+aFrc4kF+ZI7VNNT2GsPXvT2
	uKFSY1ICxvxz3KzDVTCBaofBogz7Ew/i/o3+pIh2qS1wAD3zcBcciyY3xjUliEY5/briv1SGuWE
	imq3eOV8VAGDt731oa4eEg6vf6x71xXGIJ/hDjWi+wg==
X-Gm-Gg: ASbGncv0FHq9+B6r80EyzyePkQmjUfZWTKynH2dqVfgt4NI1sEj6Hd7O8UZvL4YTp3m
	6MxhjmdRRHkmGkLGQqAolV7XNj4bvLvh74hXD6Amn0pUridxlgVOGuO3WBRYOBqH5hl6jqcySOb
	qY8rnRVkjFWHSn5CRFhzppWs8YCWxGD2fFPgUmhCR2/Vq2
X-Google-Smtp-Source: AGHT+IHeGpjjGYCSscOTPbZ6xb8rb5MXGznl/2SBz7yoEFM7auQsCbFTVHuUlPyoGrfnlhoMTudLPILywpv+/3CBf3c=
X-Received: by 2002:a17:906:c358:b0:ade:470b:d5ac with SMTP id
 a640c23a62f3a-ae3c2c7d588mr194441366b.56.1751454454694; Wed, 02 Jul 2025
 04:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
 <3ba837f8-70bb-4b9e-a9f9-0e71b9e073c4@app.fastmail.com> <CA+HBbNFd5hCKqUZY25Sws-o-0QALLue-JROyze_9biyuZZv4mg@mail.gmail.com>
 <3e522dcc-3b68-4137-bd3a-dcc2c889dbd3@app.fastmail.com>
In-Reply-To: <3e522dcc-3b68-4137-bd3a-dcc2c889dbd3@app.fastmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 2 Jul 2025 13:07:23 +0200
X-Gm-Features: Ac12FXxa3OU2rP7QnwGpqKyk1qKa-0zp1Qh_CY94xN7qIB9S3-V2AaGGog_Qezo
Message-ID: <CA+HBbNF6zfy=D=+34HXBPdzsfHo6aDbhcJa7Tf7YitYedK1a6A@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: lan969x: Add support for Microchip LAN969x SoC
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, ore@pengutronix.de, luka.perkov@sartura.hr, 
	Daniel Machon <daniel.machon@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 3:54=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Jun 30, 2025, at 15:21, Robert Marko wrote:
> > On Mon, Jun 16, 2025 at 8:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Fri, Jun 13, 2025, at 13:39, Robert Marko wrote:
> >>
> >> If the drivers on ARCH_LAN969X are largely shared with those on
> >> ARCH_AT91, should they perhaps depend on a common symbol?
> >>
> >> That could be either the existing ARCH_AT91 as we do with LAN966,
> >> or perhaps ARCH_MICROCHIP, which is already used for riscv/polarfire.
> >
> > Hi Arnd, I thought about this, but I am not sure whether its worth it
> > since we need LAN969x arch anyway for other drivers that currently
> > depend on LAN966x or SparX-5 but will be extended for LAN969x (I have
> > this already queued locally but need this to land first).
>
> I think in that case we would want one symbol for all of the above.
> We have a couple of cases where there multiple SoC product families
> get handled by a shared config symbol to make life easier for the
> kernel:
>
> - ARCH_IMX contains multiple chip families that are now owned
>   by NXP but that have a complex history with acquisitions and
>   product families that mix-and-match IP blocks, similar to
>   Microchip
>
> - ARCH_EXYNOS contains chips from Samsung, Google, Tesla and Axis
>   that all share a lot of components because they are all based on
>   Samsung designs
>
> - ARCH_BCM contains several chip families that all started out
>   in Broadcom but actually share very few common components.
>
> On the other hand, we have TI with its davinci, omap, omap2
> keystone2 and k3 platforms, or Marvell with orion, mvebu,
> pxa, mmp, octeon, octeontx, thunderx and thunderx2 platforms
> that overlap to varying degrees but use separate Kconfig symbols.
>
> Since you already have an ARCH_MICROCHIP used by one of the
> microchip platforms, the simplest approach seems to me to
> include at91, lan969x, lan966x and sparx-5 under that as well.
> You could just select that symbol from each of the four
> and then change any driver that is used by more than one of
> these families to use 'depends on ARCH_MICROCHIP' instead of
> listing them individually.

Ok, I get the idea, I will rework the series to pivot to ARCH_MICROCHIP.

Regards,
Robert

>
> I assume the mips based PIC32 and VCOREIII (ocelot/jaguar)
> are distant enough that they wouldn't share any drivers with
> the other families any more, but they could be put into that
> as well if that helps.
>
>      Arnd



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

