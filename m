Return-Path: <linux-kernel+bounces-799964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F468B431B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295661C23881
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11F5242D60;
	Thu,  4 Sep 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EmkR/F3c"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FF23B627;
	Thu,  4 Sep 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964638; cv=none; b=YqXOYtEe9Rh0o1aQprMSlLSGQUlBimyPnpAJoN5DdrQZy/9c5Ej5hb2+B9QsDV1UU27iBEDwByskv1OOu1Ud9tOzGoZXnt/Q1JjBhX4Tpj7w9XQmUA0a8P9XtZCum51TzDM3LZbR8pRFU6j402L/jTLGFGZMCGkydV5gr/Epd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964638; c=relaxed/simple;
	bh=ZUj/WoAq115Q2cD8ESZPsGtWQFjGhFZrLxiNY/MDBcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=izKCl1IzbqSnX46qm1XM4yuXgKxje9l2axjVd4hwqCra6QD0lNXHU5Vxit9QpiqmWcWKlVl9xvdgKe6eBIowhfuNtfyynGTgj4+4KRI19KCpLHmFIfKHEA02fG9atOpZ3KBO2/XNFBCZTgK9Mu12N6rQlwJSegMl9HHGuhOpCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EmkR/F3c; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5845hkqw2940972;
	Thu, 4 Sep 2025 00:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756964626;
	bh=47DEz/6ha8fZiHE5oM7w1+bkW2dkQmrKXzDB+j6xPJw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=EmkR/F3c23o5OuA4YkYjGrSEbr5bzGuG0pyFGnXHqwi1/IaMyE4ZyEhZ8wP8rKrsE
	 6GeUeAuE2a1po7BQIJ08OsnD4xRUIKTlikh7l9YGpRqbZb+7T2RpConxu+M/+e2+ze
	 vsJKsUJ5iDfj0wonZTmxNvLw3b3zqKie41nCSLEM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5845hkwR641637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 00:43:46 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 00:43:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 00:43:46 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5845hfOS2766310;
	Thu, 4 Sep 2025 00:43:42 -0500
Message-ID: <49db8bea-80a0-4f09-9b39-20fd7493b5da@ti.com>
Date: Thu, 4 Sep 2025 11:13:40 +0530
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
        <aradhya.bhatia@linux.dev>, <u-kumar1@ti.com>, <s-jain1@ti.com>
References: <20250904050940.2913567-1-h-shenoy@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250904050940.2913567-1-h-shenoy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 04/09/25 10:39, Harikrishna Shenoy wrote:
> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
> TRM Table 2-1 MAIN Domain Memory Map.
> Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
> 
> Fixes: 92c996f4ceab ("arm64: dts: ti: k3-j721e-*: add DP & DP PHY")
> 

Remove this blank line. With this,

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>

Regards
Devarsh

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
>   		reg-names = "mhdptx", "j721e-intg";
>   
>   		clocks = <&k3_clks 151 36>;


