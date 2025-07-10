Return-Path: <linux-kernel+bounces-725514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D36B00028
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72EEDB41B94
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6D28DB45;
	Thu, 10 Jul 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LdlKtGkd"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E523DEAD;
	Thu, 10 Jul 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145639; cv=none; b=Gtdr8tW2RIFiaZCUtNzy/APn5kAJLaW2IrfDHio8dFJDad/b/DFSK3dykzkyszefa4+dOY62X9dFcv0ovQ2qs7XsRsofdW8Hx83QCuUUAo62kZeOSeM4TvL2RRY2Ku5Yd6pPBXQDPPBn3FH4Zvr+BRDjjqP+RQUdNXGCDyrs5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145639; c=relaxed/simple;
	bh=r6B/XVLZcf7RylzWNGBO2ESniGh9W1OISbM2kiqHX/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/8RpU+K9rYjNUdxJ0J/bp7fHeZ2E+uWqyvZdnqVKGU+XQj8xify44/V9Li1sAhyf6D6tS1WIRBhMxuWHy1QRlPddTV6S7Y1s4jrt/vtVKqUA1OtvJDEo3eLrj1DCYR5uev5X9ez5h33lbt6plgPSx5/ranLHBuZb2j9tW7ogzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LdlKtGkd; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56AB75jO1487548;
	Thu, 10 Jul 2025 06:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752145625;
	bh=Uabhp1OFgeoc1G7fSq5ppr9KBFz81UoMCS0Yf9xgX3I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LdlKtGkdZBQzNhp553vr8DtO7DF04BD9gHnlF2o6wbMi9fZXPUTfAmDg9C2mQ81VX
	 E0mbxa/N23YWYqc9PGGjb7LOCeoByE/8aRu0w1Wif8Ka9ASWZIUGJWuBqUOrOoYxiV
	 wOfVEoWj+hBx8ckm7j4mKN0YOO71eLZcqPszXeeU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56AB75Kx1163561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 06:07:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 06:07:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 06:07:05 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56AB75eb1530947;
	Thu, 10 Jul 2025 06:07:05 -0500
Date: Thu, 10 Jul 2025 06:07:05 -0500
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: add boot phase tags
Message-ID: <20250710110705.ah65r5nathlpqzhz@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250709-62a-uboot-cleanup-v1-1-70f8e6cde719@ti.com>
 <4d531a8b-1d32-4618-a984-6f4435f6a676@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4d531a8b-1d32-4618-a984-6f4435f6a676@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On July 10, 2025 thus sayeth Vignesh Raghavendra:
> [...]
> 
> On 10/07/25 05:38, Bryan Brattlof wrote:
> >  &main_gpio1 {
> > @@ -693,6 +703,7 @@ &main_uart0 {
> >  	status = "okay";
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_uart0_pins_default>;
> > +	bootph-all;
> >  };
> >  
> >  /* Main UART1 is used for TIFS firmware logs */
> > @@ -737,12 +748,21 @@ &cpsw3g {
> >  	status = "okay";
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&main_rgmii1_pins_default>;
> > +
> > +	ethernet-ports {
> > +		bootph-all;
> 
> 
> This is redundant as child node cpsw_port1 has the flag below?
> 

Ah yeah you're right. I'll fix this up.

~Bryan

