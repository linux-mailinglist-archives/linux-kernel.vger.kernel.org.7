Return-Path: <linux-kernel+bounces-799998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE34B43240
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045A11C22B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E7126562D;
	Thu,  4 Sep 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kiD8aiTG"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E02641EE;
	Thu,  4 Sep 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966959; cv=none; b=tc1vyQmx8B7mYVR28O0XzejIbgAB/nSFZbIEll4VvPY7cVHPMeJr9Xnt7lXGM7ZhcSE8w9ACELfhz+OcQHuhoLkm4R98KKJoEbqCHL2m5qf2OZF8+dP+OS6oztznTPK7CW8gbp5NNUHeh1/oHiIfCxgSRXANp6C2t5j73oLkL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966959; c=relaxed/simple;
	bh=aHmJwlDXNz6tA5UhZV9VcDBbC/0S0OzJ66z8KuBlgh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VtkxiO6IXZFrvXlH8a/KKHG+nBG5/Qwoqc4an9nAVy1GuEWXjbbd2GQVP3Zfd1YXlXKiEkm8CJGrpmkhnH+S0betwCaCYxkQH8AIxlOXZBPsxLKw34wa1ePXc7fBKKgmjp8hD7bg1nEm9ozTpl/U4dv9cj3ZtxaRYubJFbv5Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kiD8aiTG; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5846MLJv2948463;
	Thu, 4 Sep 2025 01:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756966942;
	bh=vy9z99FHQxyc73fHbCIe1SuFt/0PdpvUH6nTB0pmP/Y=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=kiD8aiTGGDElFbDTH32HgmYUJAdH0sBZtDHVeFbf4VDALEYIuaAVBO1uDU1jsDjkt
	 L3NCOSRqsIf6uISC9ZxExbEqAO1ZWGARVcl3tDdDhrV2LQuAN1zYSWF3s+cimXY9U6
	 ZBFrAVEG008RiVqk8j62dBd6fi8gUiub9Nw0z7OU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5846MLfr661834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 01:22:21 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 01:22:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 01:22:21 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5846MG4d2521411;
	Thu, 4 Sep 2025 01:22:16 -0500
Message-ID: <35cc8bec-dd7b-48b6-b2e8-c53c82231a58@ti.com>
Date: Thu, 4 Sep 2025 11:52:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm64: dts: ti: k3-j721e-main: Update DSS EDP
 integration configuration register
To: Harikrishna Shenoy <h-shenoy@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <tomi.valkeinen@ti.com>,
        <a-bhatia1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <s-jain1@ti.com>,
        <u-kumar1@ti.com>
References: <20250904050940.2913567-1-h-shenoy@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250904050940.2913567-1-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/4/2025 10:39 AM, Harikrishna Shenoy wrote:
> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
> TRM Table 2-1 MAIN Domain Memory Map.
> Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
>
> Fixes: 92c996f4ceab ("arm64: dts: ti: k3-j721e-*: add DP & DP PHY")
>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index ab3666ff4297..3fa7537d5414 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1863,7 +1863,7 @@ mhdp: dp-bridge@a000000 {
>   		 * the PHY driver.
>   		 */
>   		reg = <0x00 0x0a000000 0x00 0x030a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
> -		      <0x00 0x04f40000 0x00 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
> +		      <0x00 0x04f40000 0x00 0x100>;    /* DSS_EDP0_INTG_CFG_VP */


Thanks for catching this

I think other SOC 
"arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi" needs similar Fix


>   		reg-names = "mhdptx", "j721e-intg";
>   
>   		clocks = <&k3_clks 151 36>;

