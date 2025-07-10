Return-Path: <linux-kernel+bounces-725022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10DAFF9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985D35471AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF578286D55;
	Thu, 10 Jul 2025 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KtblvU/f"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14E287271;
	Thu, 10 Jul 2025 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128997; cv=none; b=g2vsjPQx3lNsDImNwSIlK93DOYHC02KiZbs28agITLBRFnA83+gCuwEZE6SjW1v6sYzDufDdq13xCohCSI883oAizJE7k64+zRWJ2rn5bGY0A7+Bxx4AZ8FdyabLzS8nKzoTEL81GCbTy21LQnqHVOMZ9McfRvfvOEu3cfUtEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128997; c=relaxed/simple;
	bh=bjra+rYTxgYoPHsBKl2EMn9nutDtdt8hoHWFG53oE7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fGiH7MzpTSu0whi8ulWLCMuxQ6+DNXdiKxBMLs/O2RrF0JpU/a1l5QSOa9ieZ74fBgV0hM1wdCkySxU+2KAPMOjI0p5F6a1xUaB1yUuBoZUerv9Kb4CSDFbFGZL+j0douoMQbCS23PMN4VnwvenkYjzmyRZg4LMP6j5EP021+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KtblvU/f; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56A6TouM1414345;
	Thu, 10 Jul 2025 01:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752128990;
	bh=6CuW4XhQKZb8IjoxJvFGlJFEMyWtcoqQnz4Is5XWIhk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KtblvU/fpv2GmZUY/zvs0Q+i+9qAEVpjvWl5gOhpwXy1uaLrN706DnjNcQ8/TemM5
	 gTcjYTy7orGwVK4vsHySy0YpfVEeLT9lSjxHhlhEvE8jLi6WgDUXOE/b/y4xVvU77q
	 MR5VPjViM29uDyy4htqbY2zRGnGZfPKBPBkSZ22Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56A6ToM1949606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 01:29:50 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 01:29:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 01:29:50 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56A6TlbN872775;
	Thu, 10 Jul 2025 01:29:47 -0500
Message-ID: <83c5d0b8-add8-4db7-bcde-5b17c796b53a@ti.com>
Date: Thu, 10 Jul 2025 11:59:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: add boot phase tags
To: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
 <20250709-65-boot-phases-v1-1-e1f89d97a931@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250709-65-boot-phases-v1-1-e1f89d97a931@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 10/07/25 04:05, Bryan Brattlof wrote:

[...]

> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 7cf1f646500a16c1d1bac6dfb37fb285218063b3..5bbd817bc51464f6605c5b2dc9cb544a109a695d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -211,6 +211,7 @@ mcu_ringacc: ringacc@2b800000 {
>  			ti,sci = <&dmsc>;
>  			ti,sci-dev-id = <195>;
>  			msi-parent = <&inta_main_udmass>;
> +			bootph-all;
>  		};
>  
>  		mcu_udmap: dma-controller@285c0000 {
> @@ -235,6 +236,7 @@ mcu_udmap: dma-controller@285c0000 {
>  			ti,sci-rm-range-rchan = <0xb>, /* RX_HCHAN */
>  						<0xa>; /* RX_CHAN */
>  			ti,sci-rm-range-rflow = <0x0>; /* GP RFLOW */
> +			bootph-all;
>  		};
>  	};

Should this be board specific property? Does every user of AM65x need
DMA at boot stage?

[...]

> @@ -107,5 +111,6 @@ wkup_vtm0: temperature-sensor@42050000 {
>  		reg = <0x42050000 0x25c>;
>  		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
>  		#thermal-sensor-cells = <1>;
> +		bootph-all;

Same here..

>  	};
>  };

-- 
Regards
Vignesh
https://ti.com/opensource


