Return-Path: <linux-kernel+bounces-806776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9702B49BC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2E7ABC26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC02DC333;
	Mon,  8 Sep 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dbZteMeQ"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62874279337;
	Mon,  8 Sep 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366476; cv=none; b=ZyiWd53RePL3P4PKPAEFZW4x9DKYSxDDm761L1W1M3dT1CnsM/t0mKGJT1xgVLQdxlGcpUCQPD7B1S7wHLGYTpCOZ2nZp24EZgdzhS3A5UjDpQJbO9qRBIlSfYK8vtVb8TAQLZEGuYAtISFqnWzpjMbM/us+DfRDr1EAYcbb7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366476; c=relaxed/simple;
	bh=WtWAlKx1murUH42D3/hxKViHrN8vBM86mzkA3jSoqFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FqlkAbisZVju9jEmvKg/OMNQ/st8Yj1O7cN1EsHoZTnSPmpCzLwHArAM2Jp1Pj5RPbY52zyX1dWa3OAkq9F2ONs3l2/XkJhrkhZCnyeUQ1oD5NvPsEIr8Dw1K/OrdpR7xhwTaJk3JlU245uLMz+nDQOgbQjpsBWq/yM6aGwiWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dbZteMeQ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588LL6p5187077;
	Mon, 8 Sep 2025 16:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757366466;
	bh=u1DCsCbvVvlHL3i6YEowOEl+lxD9y4IQf2zVVjbdl4k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dbZteMeQS7PgyjkbQWiDyX0T4wpwCyTRUp2rWhq1y0jWdHaesQyYkDWVeJjd66v5x
	 w5s62NwinNziLv96Tam22Hb3lq9o5vMWbkgktVsdNqXLEOOrbEPE5VEII2mraPZCIw
	 +i8zTmYuHdKszc7PUDAbMzoNNk190ny73xOxH0ro=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588LL5li4052299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 16:21:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 16:21:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 16:21:05 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588LL4XN1230396;
	Mon, 8 Sep 2025 16:21:05 -0500
Message-ID: <5f5d78e2-5aec-4412-b900-3281c391a444@ti.com>
Date: Mon, 8 Sep 2025 16:21:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] arm64: dts: ti: k3-am62p5-sk: Remove the unused
 cfg in USB1_DRVVBUS
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <u-kumar1@ti.com>,
        <sebin.francis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250905051448.2836237-1-a-kaur@ti.com>
 <20250905051448.2836237-2-a-kaur@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250905051448.2836237-2-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/5/25 00:14, Akashdeep Kaur wrote:
> After the SoC has entered the DeepSleep low power mode, USB1 can be used
> to wakeup the SoC based on USB events triggered by USB devices. This
> requires that the pin corresponding to the Type-A connector remains pulled
> up even after the SoC has entered the DeepSleep low power mode.
> For that, either DeepSleep pullup configuration can be selected or the pin
> can have the same configuration that it had when SoC was in active mode.
> But, in order for DeepSleep configuration to take effect, the DeepSleep
> control bit has to be enabled.

The last sentence wording is confusing because it sounds like a 
DeepSleep control bit still needs to be enabled which is not seen in the 
patch. If possible, drop this sentence and do the same for the other 
similar patch in this series.

> Remove the unnecessary DeepSleep state configuration from USB1_DRVBUS pin,
> as the DeepSleep control bit is not set and the active configuration is
> sufficient to keep the pin pulled up. This simplifies the setup and removes
> redundant configuration.
> 
> This reverts commit 115290c112952db27009668aa7ae2f29920704f0.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

Verified USB disconnect, USB connect, and USB remote wakeup on AM62P SKEVM.

Tested-by: Kendall Willis <k-willis@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 899da7896563..e8f0ac2c55e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -360,7 +360,7 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
>   
>   	main_usb1_pins_default: main-usb1-default-pins {
>   		pinctrl-single,pins = <
> -			AM62PX_IOPAD(0x0258, PIN_INPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (G21) USB1_DRVVBUS */
> +			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
>   		>;
>   	};
>   


