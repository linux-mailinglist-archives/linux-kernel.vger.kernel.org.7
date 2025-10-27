Return-Path: <linux-kernel+bounces-870840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F08C0BD01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 851194E2D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949D229A9FA;
	Mon, 27 Oct 2025 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="msWLSVsg"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865B1E2614;
	Mon, 27 Oct 2025 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542562; cv=none; b=YWO9X6t39UzBfX9kMUF6VEAA8/qv12zD29AEJdigUfqSlT75U0OetDskFspj6QeibKiEgUSyPB2ZkBJFvI9MJAmbMWtbF0gSvFWyVc/zRwPYj/fd83zxiAiaevC/UJ7AVePUpFVrFDhG5VHnOyQ1GV4QGU2XxDcvIpwIOPNzyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542562; c=relaxed/simple;
	bh=W2NGqZ0doVQUiakdeswYNRHnP2b8KtxSAe/Y84nb/+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CeA71Egd0zYKY5W/DTY9G2st+t+8HlzZ4Lx3s5iCPCq0VVPmEMqleqOOZToueQ78fElzqnQOqcS0pE2Zu5tPjCtsKhhg208rD6rUFepY1Uk36O+wCTc+53xqLO0PFsVsK9eH+AZoOmEy18sRyHJMKBoWrGXBSRzIndIdPfCiz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=msWLSVsg; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59R5MQJK2336730;
	Mon, 27 Oct 2025 00:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761542546;
	bh=eZCgf91re28Z+mhjsd1SA4AChxcvuQ2WJ2scn/0nNvA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=msWLSVsguS78kMda4jHNh4RgYidjmXRTC2lkc28TpXVU/WGp9UTi+jiv/JIYTMXqF
	 dWLEo8dWeVkQGtxeXdc2bcbgEyYdnEtbNXO7BuGLIxP94sf+zF6CKH1Aqu3Ih6LNIv
	 XpQcx4WF3MGYSirSCNfL8i29hrA5d9uj8NlMOnpU=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59R5MQTr1437619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 00:22:26 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 00:22:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 00:22:26 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59R5MNH9114936;
	Mon, 27 Oct 2025 00:22:23 -0500
Message-ID: <1d0e3bd6-eabb-4083-aa20-faae7fd79cff@ti.com>
Date: Mon, 27 Oct 2025 10:50:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62-wakeup: Enable
 cpsw_mac_syscon in U-Boot
To: Daniel Schultz <d.schultz@phytec.de>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <upstream@lists.phytec.de>
References: <20250923130901.4110013-1-d.schultz@phytec.de>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250923130901.4110013-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Daniel,

On 23/09/25 18:39, Daniel Schultz wrote:
> Add the "bootph-all" property to cpsw_mac_syscon.
> 
> This fuse region contains the internal MAC address. Without this
> syscon node enabled, this interface will get a random MAC during
> network boot. This is problematic because the AM62x network
> boot is using BOOTP protocol for some binaries and this protocol
> does not support dynamic lease expiration. Therefore, the DHCP
> server can run out of free IP addresses.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index 6549b7efa656..41ac17e809be 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -30,6 +30,7 @@ opp_efuse_table: syscon@18 {
>  		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>  			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>  			reg = <0x200 0x8>;
> +			bootph-all;

Please restrict this to boards that actually support network boot by
moving to dts or SoM specific dtsi? Same applies to 2/2

>  		};
>  
>  		usb0_phy_ctrl: syscon@4008 {

-- 
Regards
Vignesh
https://ti.com/opensource


