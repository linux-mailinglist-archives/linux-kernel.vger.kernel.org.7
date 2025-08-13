Return-Path: <linux-kernel+bounces-766721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F87B24A65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A83B1759
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107D8F58;
	Wed, 13 Aug 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CbJPAx9a"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21374040;
	Wed, 13 Aug 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090940; cv=none; b=HlttxnzkgXNer0gsiTPIex2AtRz2pbzDNo4cfWuVCw+9PYQP7qYBMoVB60RJ9596Uy/tDpL1GyvFiiKu68wzEH/HHCQJqP+GjiZMD5h1NniECoTtZmucA3bF1ufLgl+UbZ2GhBBewvvubl1UxCJRJFRNXRy9omQAClSaYZofN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090940; c=relaxed/simple;
	bh=bV71xf+f9QJOsVohDQLije+nacy+gxH0Wf4/5ROh5JU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+sLfkRcjkbv2kz2WVRVFojl+lODSvXE0OIIEfnP6PG+8AJVpUBgFpVT8mmY90i0wLaO/69yw/2IBTJZrvifoMRqdJ9SdKiR5AKO5Yj4FUnckQW9tkH3ppGGxVdfKOyaYE/vvVI2A0YfqmgLQUlxyYox8rKaD/XYjBEguLzhfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CbJPAx9a; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DDFWtc1705331;
	Wed, 13 Aug 2025 08:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755090932;
	bh=wOw2qc5uTTadm+FwJMr/jc3sueTsMi+eiVewiY1neSo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CbJPAx9ayLZOjdJf6yfzZo0UwzCQHJiQwhBoB8OjZtQ7JyEe55r6YOIVsjjZQcqw2
	 Uf3oZ/cxo1bxKjRgETND4Uqjr41Nc0HsYxVspcI+c+0l4bku5Ybl9NhIZhjNZ0gXvT
	 cjTXAOPlerOZxe9tr0pRXN9f7t6nwTGgthwqrs/c=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DDFWR31097033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 08:15:32 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 08:15:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 08:15:31 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DDFUfV2039114;
	Wed, 13 Aug 2025 08:15:31 -0500
Date: Wed, 13 Aug 2025 18:45:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62x-sk-common: Remove the
 unused config from USB1_DRVVBUS
Message-ID: <20250813131530.apibc4p6t2uo5bkr@lcpd911>
References: <20250731115631.3263798-1-a-kaur@ti.com>
 <20250731115631.3263798-3-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250731115631.3263798-3-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Jul 31, 2025 at 17:26:30 +0530, Akashdeep Kaur wrote:
> After the SoC has entered the Deep Sleep mode, USB1 can be used to wakeup

Just leaving my comments on the commit message here since 1st patch
seems to be pretty much the same commit message.

Let's reword this as --> Deep Sleep low power mode.
Makes it a bit more clear.

> the SoC based on USB events triggered by USB devices. This requires that
> the pin corresponding to the Type-A connector remains pulled up even after
> the SoC has entered the Deep Sleep mode.
> For that, either deep Sleep pullup can be selected or the pin can have the

Nit: Be consistent with either deep sleep, or Deep Sleep, don't mix case.
Also, please can we talk here in terms of exactly which macros we're
talking about? For eg. if deep sleep pullup == PIN_DS_PULLUD_ENABLE, then
please mention that in a bracket or something for people who may not
necessarily be aware of all these terms.


> same configuration that it had when SoC was in active mode.
> In order for deep sleep configuration to take effect, the deep sleep
> control bit has to be enabled.

Please talk with some references, because not everyone will be able to
follow what we mean by deep sleep control bit/ deep sleep configuration.

> Remove the deep sleep state configuration from USB1_DRVBUS pin as it is
> anyways not taking effect (deep sleep control bit is not set).
> 
> This reverts commit 527f884d2d94981016e181dcbd4c4b5bf597c0ad.

And so are you in conclusion saying that this patch is just unnecessary/
useless? The bracket message feels to me that you are saying that if we set
the deep sleep control bit this patch will start working as expected?
Please can you clarify a bit on that end?

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

Sorry for the long review on the commit message, but context feels like
everything when it comes to small patches. Hence trying to make sure
everyone understands what's being done here... :)

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

