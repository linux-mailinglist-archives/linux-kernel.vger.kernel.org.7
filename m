Return-Path: <linux-kernel+bounces-800279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF8FB435BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BD9170226
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61912C1581;
	Thu,  4 Sep 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vENxZqKg"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0362C11EC;
	Thu,  4 Sep 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974539; cv=none; b=MsvF+A1M4am8UXxbw476UrexRlK8an/kTExfHObIrAtpShIZtMuG/KJ0TB2CeI1s71zIwXPM8rn/GW8Q246YdRQgwTqF8RniLu0luy0WD8SxzMfWEMNjfXqSOB5/55oKNuYdlb7AZ5TO5+HZRtMLUSi2DyjvRb0hdHz9LaKYbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974539; c=relaxed/simple;
	bh=z3BNbKDwcOVK64VBAwHU8sX4fAOFlc58Pe8ZNs3iej8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULAE+HVFW6ErjfacAzMDQt/lFfHjRZ0fNYmttQJA0cmGqPs4VMYx3ISPi0s/2SIziSMBRsIv0+sIFoReF7jW9qDxVeUfL4/PBrjXy9rRySc6prUXiXyJNdDPtdbeIiefVjVKRyFRkajbZN1mmdY8oSkXTJT4WfneQ18WkeQJb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vENxZqKg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5848So0d3034383;
	Thu, 4 Sep 2025 03:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756974530;
	bh=M5d16o/K/PDCx6Sj/QbZw1TA3sOMpy5ZnNHJchVHOXQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vENxZqKgMjh3XHHlrKcJDb58zgbybx48s8gxJ/nPs3RmeiTg9PuGD211LWHmOj2lu
	 bYWlR70iQAw448BM/OeWMKE9kh6cEl2GpsHW4bAMolkp0JLedLrehePB/5YhNI/llG
	 t3m07DHEJweZKoc2hPFWtDIBkskf5/EshV7YulII=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5848SoZa3678746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 03:28:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 03:28:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 03:28:49 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5848Smgl2680474;
	Thu, 4 Sep 2025 03:28:49 -0500
Date: Thu, 4 Sep 2025 13:58:48 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: k3-am62x-sk-common: Remove the
 unused cfg in USB1_DRVVBUS
Message-ID: <20250904082848.xyu5oll527t4kcwk@lcpd911>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-3-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902071917.1616729-3-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 02, 2025 at 12:49:16 +0530, Akashdeep Kaur wrote:
> After the SoC has entered the DeepSleep low power mode, USB1 can be
> used to wakeup the SoC based on USB events triggered by USB devices.
> This requires that the pin corresponding to the Type-A connector
> remains pulled up even after the SoC has entered the DeepSleep low power
> mode.
> For that, either DeepSleep pullup configuration can be selected or the pin
> can have the same configuration that it had when SoC was in active mode.
> But, in order for DeepSleep configuration to take effect, the DeepSleep
> control bit has to be enabled.
> Remove the unnecessary DeepSleep state configuration from USB1_DRVBUS pin,
> as the DeepSleep control bit is not set and the active configuration is
> sufficient to keep the pin pulled up. This simplifies the setup and removes
> redundant configuration.

Okay this makes sense...
It would be a fair question for someone to ask what these bits really do and
that can lead to confusion,
The other flags were there but were not really doing anything so best to
remove them to avoid any confusion altogether. 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> This reverts commit 527f884d2d94981016e181dcbd4c4b5bf597c0ad.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 13e1d36123d5..d3bed23134ca 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -249,7 +249,7 @@ AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19/V15) RGMII1_TX_CTL */
>  
>  	main_usb1_pins_default: main-usb1-default-pins {
>  		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x0258, PIN_OUTPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (F18/E16) USB1_DRVVBUS */
> +			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
>  		>;
>  	};
>  
> -- 
> 2.34.1
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

