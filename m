Return-Path: <linux-kernel+bounces-724871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8EAFF7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225D01BC6B98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE328314A;
	Thu, 10 Jul 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LpizOoYb"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7A4207A;
	Thu, 10 Jul 2025 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120188; cv=none; b=QYLFet0fE7jnbBOcQS7bMcF47wLrXtb9fEFDQ/YhNjY5YfHklExZ2orPytrlCpLvhDY+2T2vZ55Aq17tS44KWnujdl8mLgvWMl6Cm2Y3nBuFUgprPTBDDMZcsXvU8Nua/3vJ+M899zUl7FD8TdsFo3okaO8GWfM7nb6nuxP89pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120188; c=relaxed/simple;
	bh=k/aNzRV6XVIyuamBb3izj0Q56Ho3FvZ515QS67OAA2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B4ij4709f6qdMEm55HgA+iiceSkYXtxUoXQZwkGefNGGDuXxtcxCakHhuR/O5Oxl9sSwaeFf31CKvtng6NBaAkmdD2Is248St++Sc/5+XRNWhw6nBAOc2bFltheg2Xutr6qchwbOOLEijhTE8QBZ1oCSkn9n3F4QYnFk6SDXjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LpizOoYb; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56A42xTx1390678;
	Wed, 9 Jul 2025 23:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752120179;
	bh=syXPu5InInWJTrJB4xJD5Dhlu4FirwQK/41pDLqMUNg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LpizOoYbWndo+NrFkg6FHUQtiyiTBBUTESsx8YYoUNNwlfQP20f3djyiSOsHAihCc
	 YH0EqIXikpStj8/Y7LT42Hm+NV77k8ZnftiU/XeDLukyB2QAEH9UGGoXA8suRm7Bec
	 3hIQRapOkjf2/bM/WUcCju9Bo/K/rB8Cqhyl8nDU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56A42xRx3127345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 23:02:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 23:02:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 23:02:59 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56A42tbS976034;
	Wed, 9 Jul 2025 23:02:56 -0500
Message-ID: <4d531a8b-1d32-4618-a984-6f4435f6a676@ti.com>
Date: Thu, 10 Jul 2025 09:32:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: add boot phase tags
To: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250709-62a-uboot-cleanup-v1-1-70f8e6cde719@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250709-62a-uboot-cleanup-v1-1-70f8e6cde719@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

[...]

On 10/07/25 05:38, Bryan Brattlof wrote:
>  &main_gpio1 {
> @@ -693,6 +703,7 @@ &main_uart0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_uart0_pins_default>;
> +	bootph-all;
>  };
>  
>  /* Main UART1 is used for TIFS firmware logs */
> @@ -737,12 +748,21 @@ &cpsw3g {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_rgmii1_pins_default>;
> +
> +	ethernet-ports {
> +		bootph-all;


This is redundant as child node cpsw_port1 has the flag below?

> +	};
> +};
> +
> +&phy_gmii_sel {
> +	bootph-all;
>  };
>  
>  &cpsw_port1 {
>  	status = "okay";
>  	phy-mode = "rgmii-rxid";
>  	phy-handle = <&cpsw3g_phy0>;
> +	bootph-all;
>  };
>  

-- 
Regards
Vignesh
https://ti.com/opensource


