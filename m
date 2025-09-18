Return-Path: <linux-kernel+bounces-822268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D4B836A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E2617F92E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90A2BE65C;
	Thu, 18 Sep 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m3utoBFF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EE2EE272
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182578; cv=none; b=NM4YNebOZ76ta2WtsveC7E7ESmIg7dwpDPRSG+1+VM4cgR0FwGjUB6tEZz7Q9IqiBp96lrLZXp4mnslFxmB/Qs+YcFMkb9mzStAMY6Oe4uMfwJmae2VXUQetFedhRPcTpbvTt0nzCOtrXNrUW7p3/XVK30lhRJKBN35IBHHg16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182578; c=relaxed/simple;
	bh=Z4Vq6gtJA/IDkABlkmE0x7/PpI+mZr69AlJCAs03HF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWdAt1cMvNAdKOKu4lMltqNzq9g3hv60yboZeBNNrdyIJeJsmSenJRog+76z132JGum4TtufBxTfpDadM2LPL52JiK7q7hk2g3eFGhuAI65kGEkAQsbyg3sJhvc39y1GclMrhKmS+H5mz3ms1LKNyU2/J12+M6v9R6iwQLUJ57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m3utoBFF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758182577; x=1789718577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4Vq6gtJA/IDkABlkmE0x7/PpI+mZr69AlJCAs03HF8=;
  b=m3utoBFFlvENVbZbvQQHCP/UsirkSnLNf4+1gmIYQS24V+BJMJJNGoIv
   DZG882n6d3zXusY/1YLWFzucypBD1goaxXoxJdFiONTHXleVMo6hYETRC
   y4YEzCwLNtjxmd/uCU7Ai1s3BXdkJ5rN5JivN6+bNZvDnAycyl+UHX2UB
   UIkIa/l9wosDTRDahP9fHd98HCHlQ10V4OejsiNMwsCujwK/zTQE4u2VO
   AZ1bg8g0+p172N9GOsaohl4/pZl3GteN+j9aVaMubqnm/3y7GH5Vuisdz
   5sNCxELYfwBzxbw1oOuNRhwVfWqdXkOHUZvVtw7jTLzWtmIi35sYedRVX
   Q==;
X-CSE-ConnectionGUID: LeNTzai7Q7SZ/VPQJt5hlQ==
X-CSE-MsgGUID: 3pRz+qyRSEuYSMA4aRGrdA==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="47198788"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 01:02:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 01:02:28 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 18 Sep 2025 01:02:27 -0700
Date: Thu, 18 Sep 2025 08:02:26 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
	<luka.perkov@sartura.hr>, <benjamin.ryzman@canonical.com>
Subject: Re: [PATCH] phy: sparx5-serdes: make it selectable for ARCH_LAN969X
Message-ID: <20250918080226.mrgoywxcaaszbdlq@DEN-DL-M70577>
References: <20250917105541.54033-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917105541.54033-1-robert.marko@sartura.hr>

> LAN969x uses the SparX-5 SERDES driver, so make it selectable for
> ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/phy/microchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
> index 2f0045e874ac..2e6d1224711e 100644
> --- a/drivers/phy/microchip/Kconfig
> +++ b/drivers/phy/microchip/Kconfig
> @@ -6,7 +6,7 @@
>  config PHY_SPARX5_SERDES
>         tristate "Microchip Sparx5 SerDes PHY driver"
>         select GENERIC_PHY
> -       depends on ARCH_SPARX5 || COMPILE_TEST
> +       depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
>         depends on OF
>         depends on HAS_IOMEM
>         help
> --
> 2.51.0
>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com> 

