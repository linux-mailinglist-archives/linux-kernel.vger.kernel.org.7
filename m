Return-Path: <linux-kernel+bounces-720954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A442AFC283
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C4F1890D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FB2206BF;
	Tue,  8 Jul 2025 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lifOEFt9"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E67881E;
	Tue,  8 Jul 2025 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955228; cv=none; b=PyKCFsB7rW6N2fwDNhb0iGuTsctYWX5k0CPut5sLOIDgRFpVSi5swXPR4+l8BKpry+doVxpp0e64ZdfuWBBrvdX5INerJIt1ZcfGb1rtncVv+1dwQeXu0N2FN2ffGadIXvRTyRZCC/U1std4r/zS32HsK6y234Nbkb3LDWUJE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955228; c=relaxed/simple;
	bh=TtbDK2OMPvc6mmhNGPBeuIix3bFDVRRTrd1GoSMJ8vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=utp8v7JG1gw8fnG/ubcr2hGYDZjpi4pvSQ3xvgdg0mME22Uzu6c9DxnaYzBuvx5SJah577rTQpkRetONdtbx2Naod/e1ZlptGLdo+R/zE+69zyzyRb8ARxgDd21FYx4Jll07NKvzDCaxGNinow6S7r7jEKONQ330kk37zhAggWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lifOEFt9; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5686DZDh1090527;
	Tue, 8 Jul 2025 01:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751955215;
	bh=LfHUeqDfWnKWwXtB5Zh5xbo0CjWjzLx/Q2XExY/TzxQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lifOEFt9v+3d9NXX6pjwF38h+hWCUcGTmpu4E9gFxfmLKN3wfFz++JB2RkTEuEQDB
	 l1ymGaao4UXgZ8d082FFASxbGs1aXSWkcp4kAgmZWyUDRSOctjuHAv4B2lkEYyKGyR
	 /LOLJZUeHNhrIjHfoIs6vbFXZLK6NVtfk2yUWMoU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5686DZig1177969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 01:13:35 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 01:13:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 01:13:35 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5686DTES1560977;
	Tue, 8 Jul 2025 01:13:30 -0500
Message-ID: <109cbcc5-18d2-4712-a14a-827f44207ed7@ti.com>
Date: Tue, 8 Jul 2025 11:43:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] arm64: dts: ti: Add pinctrl entries for AM62D2
 family of SoCs
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>, <andrew@lunn.ch>
References: <20250704100954.2231853-1-p-bhagat@ti.com>
 <20250704100954.2231853-4-p-bhagat@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250704100954.2231853-4-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 04/07/25 15:39, Paresh Bhagat wrote:
> Update k3-pinctrl file to include pin definitions for AM62D2 family of
> SoCs.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>   arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index cac7cccc1112..0cf57179c974 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -63,6 +63,9 @@
>   #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>   #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>   
> +#define AM62DX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> +#define AM62DX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> +
>   #define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>   #define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>   

