Return-Path: <linux-kernel+bounces-805037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D8B4834B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658FC163ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9921CC63;
	Mon,  8 Sep 2025 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E0KjteQs"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657A189F5C;
	Mon,  8 Sep 2025 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306291; cv=none; b=QNZAYHVd4MoHEnEc/gyH/SiS1Y4xAOnvbd5/qjlQAEaRrrKOFntEXIwyJ/IlOSDB1iiToH1pv9FyNhKdoDnLMNdaRaMXJCW3o2bpyuHIh+Yuk3t+E/+T1pVqRjVAf/yTlSvLvC861WJZDGcaeqr0bmEthGWZWHoYWjvhWktM6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306291; c=relaxed/simple;
	bh=LbCZXuLhSnv2shoMivOVDzexI13JjEFK5UUnhazfdEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IKiNEx5g+W8hfDPAvaZkKiPAwPBRDYngI3Ukl+zHvddx4RyJ72BiVOlY768LykQbd8Vr8Zv1SynwPUWJZ8pVaDlaPMHmx+UPDLsjVvDkZhn/OCgHxkEiEgKgt5ur39yl0mtyYBAuMc36dNzRthKqUq39fpJroQZfntM+pkrwYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E0KjteQs; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5884bsRg019426;
	Sun, 7 Sep 2025 23:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757306274;
	bh=pfVTIp2A7Sw2rpIN3wM/h4WBz/JckQgyOt9XwAtS6PI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=E0KjteQsW6WXeCswCtS7OQVklLvTUacN9PCAn/HT8jJKQYlK8KhIgPNM4t29bs9Ft
	 O6scojsRAOJjDOvk9LPhaZrfTRu4wRspCJ56lrtPkD6oNgGPOHIf3498DuJN//Lgkl
	 VDVPaWIdip2VlsnQoSRVvfJ/WBvYgC+VDEh/GGsA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5884bsZw2144177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 23:37:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 23:37:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 23:37:53 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5884bmLQ268966;
	Sun, 7 Sep 2025 23:37:49 -0500
Message-ID: <7cf605e3-e1be-43e4-ba14-c1310b4f5869@ti.com>
Date: Mon, 8 Sep 2025 10:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-j742s2-main-common:
 Update DSS EDP integration configuration register
To: Harikrishna Shenoy <h-shenoy@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <m-chawdhry@ti.com>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <aradhya.bhatia@linux.dev>,
        <devarsht@ti.com>, <s-jain1@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
 <20250907182806.1031544-3-h-shenoy@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250907182806.1031544-3-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 07/09/25 23:58, Harikrishna Shenoy wrote:
> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
> TRM Table 2-1 MAIN Domain Memory Map.
> Link:https://www.ti.com/lit/zip/spruj52/SPRUJ52-J84S4 AM69A TRM


Broken link

>
> Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")


Above commit only refactored the changes and carried the bug.
The commit that introduced this bug should be:

603669b16701 arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node

Thanks,
Beleswar

> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index fbbe768e7a30..f0cda14c2530 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -2573,7 +2573,7 @@ port@1 {
>  	mhdp: bridge@a000000 {
>  		compatible = "ti,j721e-mhdp8546";
>  		reg = <0x0 0xa000000 0x0 0x30a00>,
> -		      <0x0 0x4f40000 0x0 0x20>;
> +		      <0x0 0x4f40000 0x0 0x100>;
>  		reg-names = "mhdptx", "j721e-intg";
>  		clocks = <&k3_clks 217 11>;
>  		interrupt-parent = <&gic500>;

