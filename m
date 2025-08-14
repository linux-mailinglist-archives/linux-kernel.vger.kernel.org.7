Return-Path: <linux-kernel+bounces-768588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769AB262E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AAD3B0D35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5A2F39BE;
	Thu, 14 Aug 2025 10:32:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE92F0C4A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167567; cv=none; b=tZGSQCVvJQmG+0yy/JK5cIt4wRgLJ7QNuJXyUpncLKUVKqnz1LXbAIC5c2Il4DzKmgV4Zx3vrIdI9cNZYVkN5nWcg3JZYoUqoKQnkysAfj9k2Cz9ckWkHfgXs+2d3vKs3lP64iHsoupJX3mWvaBTAaWLjJRJ37pN7INldH2yvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167567; c=relaxed/simple;
	bh=QimykCrwB6ZAsWvsWPV6V2st17u9CiEZrkUa85W44qE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FHOUTtQXzLlkWg+mFnx4DNxHUwJI6Xk7ZfVSdT7D/22wPHe8rd/hmZ6Ys9NDHn9Z7trcExK7A0PoZha0ols+l2MVLUeXGvpHbXanRhYSqWSsFUOQNF/iT4lM3Z7UexsPQxH3Gv/JaCmIQX6RPWqdhrUTyELydvvAdLBJpII9+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVGA-0007By-LC; Thu, 14 Aug 2025 12:32:38 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVGA-000Er8-1T;
	Thu, 14 Aug 2025 12:32:38 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVG5-000GML-16;
	Thu, 14 Aug 2025 12:32:33 +0200
Message-ID: <1c6b0262f0043e65592501d88221ec2a69e9d641.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/2] reset: eswin: Add eic7700 reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Date: Thu, 14 Aug 2025 12:32:33 +0200
In-Reply-To: <20250725093436.779-1-dongxuyang@eswincomputing.com>
References: <20250725093249.669-1-dongxuyang@eswincomputing.com>
	 <20250725093436.779-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2025-07-25 at 17:34 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> Add support for reset controller in eic7700 series chips.
> Provide functionality for asserting and deasserting resets
> on the chip.
>=20
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  drivers/reset/Kconfig         |  10 +
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-eic7700.c | 432 ++++++++++++++++++++++++++++++++++
>  3 files changed, 443 insertions(+)
>  create mode 100644 drivers/reset/reset-eic7700.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d85be5899da6..82f829f4c9f0 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,16 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>  	  BCM7216.
>=20
> +config RESET_EIC7700
> +	bool "Reset controller driver for ESWIN SoCs"
> +	depends on ARCH_ESWIN || COMPILE_TEST

Undeclared dependency on [1].

[1] https://lore.kernel.org/all/20250616112316.3833343-3-pinkesh.vaghela@ei=
nfochips.com/

regards
Philipp

