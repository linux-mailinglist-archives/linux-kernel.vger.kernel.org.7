Return-Path: <linux-kernel+bounces-837911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F6BAE08D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03941943896
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15EC23373D;
	Tue, 30 Sep 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="RRchhdrb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="hAWpF2UG"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E18C148;
	Tue, 30 Sep 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249407; cv=pass; b=h6ed+GwJaV7CmUgDlKZJfHeIzl18JeA9zhmkjlSynZiFM2tM+SoCt4sKdEamKOT2fsShHwugxUj2BfGYKOW/mbGy76OVkcffY6PZBgd6T222JScrVdeMXG6t582Hpgu0HD7kvAZtiwxr54PYxz/Q8BimxUeFUbR86eg6wsH93gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249407; c=relaxed/simple;
	bh=I62I7ZfNAjmIPLH8x51UBsQZOuRPyR/8dl839yblo4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rftnYjvt+n/gwVPBbB318oui5j+NYY1yIHYgZHmZ+kCzH7prvhULiU50u3lTWdgI/jBL+jV3fWdwRIgQmWuZL3GOS7o4V3t9+0UI9+866KLWwput2IsWW3PCsUg0w0lMloL0d45oB3ksZOCY/65bM+a9LRK1H4rgFANpTDie82Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=RRchhdrb; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=hAWpF2UG; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com; s=arckey; t=1759249405;
	 b=U+eP1955chlYgfdlELwZMlCjVa13cEXmdMEzpCQlRMFyBLx3XKtN18000KoGSetqQFHpnOtqjC
	  lhLO9cubuDWzC3Qq2Dyj2TzFjlcliBXVPP5qYUTSQWZuP487d/84eY2Y61zOdwHWz4USsrfKD7
	  AQwOtc/ZtJp9KTGhaNBECVLvXJGyFUsdJca5Szr10UO2rI25kQ0cY2rHCWYlD2GTAIFlmXEnYJ
	  SAujr/LMuWxnAYtc1ztY4oKnlkxF6HaXzEk67gVzoyDipyyCsiZd2J+EUWCp4QjfwjDpGHc+Nn
	  0cW3goq2/o7CPYSZQ524TgRGSTL4WGbX6XOpcnOL2cA6Ug==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com; s=arckey; t=1759249405;
	bh=I62I7ZfNAjmIPLH8x51UBsQZOuRPyR/8dl839yblo4E=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=vfZt1S8+4LvAqhFiuGDcx6w09fKbFNS2N9Y0/9lchuCivcMlcoraFt5T5pz8jxX63hdPLlekCj
	  aYpBiMSmI0k9ZOcgyRsJ2npE30iYbei0EmF++RXig+gcUGnpcGXZcb6dv5SY1gkghu+JnxIi7X
	  osybXcpSQbXpUNwhsHKIC6pmhMhYcxUvrglVcsX9NeE6RQVJ8qkyDL4T/CdrzOPwi2c89yRbgT
	  12/3GcXg/pO38i3mb2lphisMXRqxpJGRRDat6TWEG35WP+oWPqWdM1FAuoZ7CTG0Eqg0Sl7bL7
	  IOhebiYxoVuhIrIBBB9/DAqLr0A44mIUY2cdaSp5ywThmA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=n434Hm8ln1nWaXBs+DzEmDdmRKI/SJS8E4N+yWXgZS8=; b=RRchhdrbYWciE+8LIZRDGM5riM
	NkctIuAThXy3nbkwkfViaqp/bYfI9zc2XSPa/t7xnJBTfXj1RMlIS0F6n9cmwVUwZ4EUO9inyn9CI
	3fzd/amlX74dectj7LYPXOILdVqpoOh7vc/BZNUtGgcAnI+rOZ5sKZ/Hw4jBYM43wN1A=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v3cs2-00000001fqT-0Vfm;
	Tue, 30 Sep 2025 16:06:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=n434Hm8ln1nWaXBs+DzEmDdmRKI/SJS8E4N+yWXgZS8=; b=hAWpF2UGQ/8xJD+9lrtmvaJuVz
	s8uMWaObbk50TQtwx17quTgJzHzhem1ADs4fl4lKhp8XWYZVIv8xBmSm0B9acRISbOD+UeNvQcAfS
	FrROVhCUnQ9/3Kdk0Wbra/ZyqhKUYfBeKIcOj/mgohS1+E7bMhK7vQubr1OlGKfQ1uq0=;
Received: from [87.16.13.60] (port=59897 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v3cru-000000003zM-2Z24;
	Tue, 30 Sep 2025 16:06:22 +0000
From: Francesco Valla <francesco@valla.it>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: property: fw_devlink: Add support for "mmc-pwrseq"
Date: Tue, 30 Sep 2025 18:06:22 +0200
Message-ID: <28451714.1r3eYUQgxm@fedora.fritz.box>
In-Reply-To: <20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it>
References: <20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: caf09a4f2e8164c07b2048b9db9aecdf
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v3cs2-00000001fqT-0Vfm-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c8p5.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

First time using the b4-based flow, so I _obviously_ messed it up.
Nevertheless, the (v1) patch still stands.

Apologies for the confusion.

Francesco

On Tuesday, 30 September 2025 at 17:58:17 Francesco Valla <francesco@valla.it> wrote:
> Add support for parsing MMC power sequencing (pwrseq) binding so that
> fw_devlink can enforce the dependency.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20250930-mmc_pwrseq-v1-1-7fd2764f5ac1@valla.it
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index c1feb631e3831d7d5ec23c606af31731bfc2f8b8..fcf10c4f02dcf879e1f25e4fa97b25152d58bacb 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1377,6 +1377,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
>  DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
>  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> +DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>  
> @@ -1524,6 +1525,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_msi_parent, },
>  	{ .parse_prop = parse_pses, },
>  	{ .parse_prop = parse_power_supplies, },
> +	{ .parse_prop = parse_mmc_pwrseq, },
>  	{ .parse_prop = parse_gpio_compat, },
>  	{ .parse_prop = parse_interrupts, },
>  	{ .parse_prop = parse_interrupt_map, },
> 
> ---
> base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
> change-id: 20250930-mmc_pwrseq-247089ac9583
> 
> Best regards,
> 





