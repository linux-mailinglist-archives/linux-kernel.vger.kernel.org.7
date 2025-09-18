Return-Path: <linux-kernel+bounces-822311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309FCB83833
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EB146184A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0102F3C39;
	Thu, 18 Sep 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eH0li/nG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920682F362C;
	Thu, 18 Sep 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183906; cv=none; b=pOtSPczZU8VPACAnQPJr27vUHKZAZiA780uUgeLfYazlc+m6+kLzTJiNN0yugOhBCpXkZzq0ApQClEBjY7DbBPQAP4h8kmh2EMoLhu2K0sydyuBP5qTE57RFA9KC7VL87LYj7kgduuFxwOCT1d5/iQL6ZGtFXtQmcvgTTS8S95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183906; c=relaxed/simple;
	bh=wBQH4x39aG6mB8iHL9yRMDxDggYzTR5vRD+YFwTuBbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvF1c2kN97yQ0257SlFmlesVrNyw3JluHY1pL/zBIc2JiGESSsz2bb7maiyE5TuUOd6dhKNbkdIp3OeafMZ0DsoBteO+VAukDNSeMCrPVOSYFxi1ssfayfNK8U4Ya+aBIbKoRMHtDyrQKizK9zy4QqOqZd0Vey12GT1GKCDQqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eH0li/nG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758183904; x=1789719904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wBQH4x39aG6mB8iHL9yRMDxDggYzTR5vRD+YFwTuBbk=;
  b=eH0li/nGYDlmOzRcbfJpAno30/VHwrz0rh8WDFx7n9GpBG5PEg7SPDqv
   P1Z2T4hWQrO8pIlTg0qZXJcgmXqPmkebb5VnqVnvwsjfVuWeOKdvgQb6H
   YDxgx2tQs2h5gLPX36G7I0T97PaNhgMTP0dDFByapTTaeFxnl+o7Hzc/L
   lcryL0GvA0WROVd0QbUb248mlEgdGlTkaq9GbS9HCSCLymr4udX5IW5Ac
   Iegm11XWbpXOygboDTrwWfSVhpGM539L6dcVDjl9aMloq6L3zKv6Tqa2Q
   cTeT1M87aEKOPkvtcWRkNnRqwe7v84/QuSe6FiDNorqrUk5wLAdB2lv0B
   w==;
X-CSE-ConnectionGUID: lOySgYw7Rg+a7f7PqeqBrQ==
X-CSE-MsgGUID: fTczQzg1QX2hq+qTsBjoMw==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="52529240"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 01:25:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 01:24:38 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 18 Sep 2025 01:24:36 -0700
Date: Thu, 18 Sep 2025 08:24:36 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <p.zabel@pengutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <lars.povlsen@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <luka.perkov@sartura.hr>,
	<benjamin.ryzman@canonical.com>
Subject: Re: [PATCH 2/2] reset: sparx5: add LAN969x support
Message-ID: <20250918082436.3nfs7lo7hv5jdqhd@DEN-DL-M70577>
References: <20250917111323.60781-1-robert.marko@sartura.hr>
 <20250917111323.60781-2-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917111323.60781-2-robert.marko@sartura.hr>

Hi Robert,

> LAN969x uses the same reset configuration as LAN966x so lets add support
> for it as well.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/reset/Kconfig                  | 2 +-
>  drivers/reset/reset-microchip-sparx5.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 78b7078478d4..35cb84d1de4e 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -170,7 +170,7 @@ config RESET_LPC18XX
> 
>  config RESET_MCHP_SPARX5
>         tristate "Microchip Sparx5 reset driver"
> -       depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
> +       depends on ARCH_SPARX5 || ARCH_LAN969X ||SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST

Missing space at ||SOC_LAN966.

>         default y if SPARX5_SWITCH
>         select MFD_SYSCON
>         help
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> index 6d3e75b33260..28ad8f1298a0 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -198,6 +198,9 @@ static const struct of_device_id mchp_sparx5_reset_of_match[] = {
>         }, {
>                 .compatible = "microchip,lan966x-switch-reset",
>                 .data = &reset_props_lan966x,
> +       }, {
> +               .compatible = "microchip,lan969x-switch-reset",
> +               .data = &reset_props_lan966x,
>         },
>         { }
>  };
> --
> 2.51.0
> 

When upstreaming support for the other SoC peripherals [1] [2], I got some
push-back on the use of wildcards in the compatible string. Instead, we used a
fallback, which is the accepted ways of expressing the individual SKU's.

This boils down to: using the lan9691-switch-reset compatible string, and
documenting each individual SKU in the bindings, with a fallback to lan9691.
The linked patches should give you and idea.

[1] https://lore.kernel.org/linux-gpio/20240917-lan969x-pinctrl-v2-1-ea02cbc56831@microchip.com/
[2] https://lore.kernel.org/linux-clk/20240916-lan969x-clock-v1-1-0e150336074d@microchip.com/

/Daniel

