Return-Path: <linux-kernel+bounces-813813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E518B54B02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00B23A8D11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638D30101F;
	Fri, 12 Sep 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5pbYMVy"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E42FF656
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676610; cv=none; b=CoLJB2hoHktvS5MLxjIj5LgWtJfaJpSESZGd5jG9S4xVCEgOrGuBiufsetUWGUjUHeJhqrrxUoDoCwr+9JF+xgSg7goeCLPNaXy5f2NfTcBAphUs4DmPFK9dxZ8E2ICIa1qSpiOdJhTkIvWjPgWmQ2Ps3ACLtEg2joAYw1E+ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676610; c=relaxed/simple;
	bh=0Pm0fkGkWoYqjXuzhKvNU5xsbdAFRjgObqKHLzR80II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLj3whAtm9/pRx6RBPq5Os7RJEKeBG1g0Jye+w1jykkn2jW5i/uZHmcmtxo2havgooKGMF51iZKqve40XGJdyZyAy0CKh7rrmnH/BxLPFJSxTr/D1N9a0V1E+XiBRTjIDpmEPnIYs2mX4BhpjY2kJu3U17LeY5vtpb1hhTozERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M5pbYMVy; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-337f6cdaf2cso13119201fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757676605; x=1758281405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ba/lf2/V1l+GnTj8KKghQ3UjKo/P9CKd/RACGRLyBQo=;
        b=M5pbYMVy0QZe3U5fgphKObHXl4FEegACWrCRkEKE4rUmOmjfziFaonMEOtwVJvvLFD
         UArUiGM+leyN3nls7EJZDX4g68QRRCQvaqymtZVHVCfUMLO3PqrvTm8XX+oc4oVqmJSt
         5iyxbMdwK1lK99CD6Y0MeNpbOkbTKsQ2ARXhSS+Wi+g4FjRvcLG6HRGCc5V/OYb3EjP6
         w8bUWAk6RKjZ3M/e/46d/9+e1NnuuIe9wt1Maz0rdRY/rVeRJxiGXTTqeugfwuuOaz/o
         ef3tuQgNADpDgmvNKqJMXXXhajaSnEq9HcVherF5qow8CW17A6iaZ6ioxhdr9TLd3hxU
         85tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676605; x=1758281405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba/lf2/V1l+GnTj8KKghQ3UjKo/P9CKd/RACGRLyBQo=;
        b=gn63W+NjlYmI9w3/3Lq7RGEX/LPrHez+cXltMm1kFV9OBtt3y3UiMLZAVJqhQngG+l
         3PS/8iwMO6Pm9c68MEJjK/8Q55vuVTmNAjGuf9TrVbST/AmeTJw5/nMTjbMpEK1rAzgq
         F1XuUcN3uKggPY89AL6RkcMglah2NPtpFj5XeVGsSGK7Z16Q/bkkeRM/G80bxI3ZXejn
         QBS6JlyMHvJELFmyNCw41Nm6sbOeE28Ka0iHLOCY30qShD0dtxsyKF0D/VTN8OUN7HLE
         a5A7GfUyeDYMkFvg75xygzs6/Z9f7KK9ep15fZp7I+pMFD+o5PXDpqq2klVf2p0RO9+2
         kVCw==
X-Forwarded-Encrypted: i=1; AJvYcCVJScn2LxD0ITJAdguc4k7Z+2aPMBn3bX/RsSMdVi1Av3lxo1VOmFp5Q8Tb8TivbvinIO4NrCz3jjVs7r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTM2QOWiqaNyIwOWOQjlitwRnVZOElYyRKBrTEypdxHU6J0pw8
	kVtR2WWpBgMjO6gfEiyu9SYw9fF1P1u3s2sxg2OWzz/DCpZtiz0HRX4pl7ARAcU5PPeOOJdOi3V
	dtjmPloGBbA==
X-Gm-Gg: ASbGncsApFceLrR6HRNexh0gaeJxeKvwG4LhiJsC73GnJxrSo3w0XfAVKZFeVsJnY1o
	T9G6kAvJK/PO+pNJ2/76++S48YDCDMqOzTxqElZD+6cOHnzQKlWtKQbEkSrj3ixEbU2BJWvT0Oe
	/DtPap6hO/CSYu7Kd7uSCZQ/JKKqNFHTDc8l3a235nJH9hfjaSBDfO7ZVsc2wQJPy3CqAuNWRgD
	hXdWXJBvHVwWWSr/oqYJr+3ilNs7FVfA5w9sojykNdVXVXw7o/94juJFyBzzCoIgKfsDYisA8Ev
	2Yyv5HaVLLbEA9dKsSK5cmqreHLdCmMP0iFZk+WPFdEPfrmXbYrD3akGIWv0RwWlu3kTW1W9a+f
	2Piyu0KpERq4/GCPR+a3Y9oRQf2HhUbEuTABsHQ5+8gAfyLPfJeTW/Lk=
X-Google-Smtp-Source: AGHT+IG7xrx6zvuY8X0aSFVq93lkYc31MyNpm2Z01J+LnnCkpwj4t9QRjRFVTrJ6sFrZzBRbJEwCUA==
X-Received: by 2002:a05:6512:32cb:b0:568:c51:e7cb with SMTP id 2adb3069b0e04-57051b65d1dmr1015643e87.52.1757676605476;
        Fri, 12 Sep 2025 04:30:05 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm1117114e87.25.2025.09.12.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:30:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:30:03 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yixun Lan <dlan@gentoo.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add dependency to
 ROCKCHIP_PM_DOMAINS
Message-ID: <aMQEO7tmvSY5thC-@nuoska>
References: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
 <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
 <1813054.X513TT2pbd@diego>
 <acbc46c8-30df-47bb-9d3d-91ba477f6029@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbc46c8-30df-47bb-9d3d-91ba477f6029@app.fastmail.com>

Hi,

On Fri, Sep 12, 2025 at 10:47:29AM +0200, Arnd Bergmann wrote:
> On Thu, Sep 11, 2025, at 18:05, Heiko Stübner wrote:
> >
> > Am Donnerstag, 11. September 2025, 17:03:14 Mitteleuropäische 
> > Sommerzeit schrieb Ulf Hansson:
> >> On Thu, 11 Sept 2025 at 16:43, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> >> > @@ -866,7 +866,7 @@ config MMC_DW_PCI
> >> >
> >> >  config MMC_DW_ROCKCHIP
> >> >         tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
> >> > -       depends on MMC_DW && ARCH_ROCKCHIP
> >> > +       depends on MMC_DW && ARCH_ROCKCHIP && ROCKCHIP_PM_DOMAINS
> 
> The hard dependencies are usually only for compile-time requirements.
> 
> Ideally this should go the other way and use
> 
>       depends on (ARCH_ROCKCHIP || COMPILE_TEST)
> 
> after you check that this actually builds on x86 with COMPILE_TEST
> enabled, as there may be other compile-time dependencies.

Ok so a lot of mmc driver set this correctly but few don't:

 * MMC_PXA
 * MMC_OMAP
 * MMC_ATMELMCI
 * MMC_MXC
 * MMC_MXS
 * MMC_DW_ROCKCHIP
 * MMC_WMT

Maybe there are good reasons why these are not part of COMPILE_TEST.
I can try adding MMC_DW_ROCKCHIP. Did not yet find out how to start
the COMPILE_TEST build. Hints welcome. Which top level Makefile
target or script to run?

> >> Rather than "depends on", I think a "select" is better to be added
> >> from the platform's Kconfig. Probably drivers/soc/rockchip/Kconfig is
> >> where to put this.
> >> 
> >> Assuming that ROCKCHIP_PM_DOMAINS is a critical piece for most
> >> Rockchip platforms to work.
> >
> > I'd think
> > - arch/arm64/Kconfig.platforms
> > - arch/arm/mach-rockchip/Kconfig
> > would be the correct positions.
> >
> > And as Ulf suggested, this should be a "select"
> 
> I think in this case a 'default ARCH_ROCKCHIP' in the
> ROCKCHIP_PM_DOMAINS definition is sufficient to have it
> normally enabled, and still allows someone to try turning
> it into a loadable module later, which would be a requirement
> e.g. for Android GKI.

Ok I can test this out. kernel.org defconfigs have ROCKCHIP_PM_DOMAINS
enabled so they don't see any issues but when users/distros configure
kernels, then ROCKCHIP_PM_DOMAINS is needed for MMC_DW_ROCKCHIP to work.
To me a warning is sufficient from kernel config tooling since yocto
side tooling picks this up but enabling by default is even better.
These runtime dependencies hard to track down. Kernel modules would
be sufficient if support was there since in my case there is always
an initrd with udev and modules.

Cheers,

-Mikko

