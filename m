Return-Path: <linux-kernel+bounces-739410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95279B0C5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF02618972D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62652DCC1A;
	Mon, 21 Jul 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tan0eiZc"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605F2DCBE0;
	Mon, 21 Jul 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107195; cv=none; b=pmQgtHW86pqoNMH8GQuiilIBcASKEada5DrRsgF67JBjmMBeZKhR3hVIFBY8fULF657dbm5c6vEQY9kN9LSSJ1/d9xPh/sm2qVdz22H9bGmD0lIolvYO1CemwN6VTLAu/NDrejYUSwGstijI1EWODRmoVw9aRdQpWYqprEjFLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107195; c=relaxed/simple;
	bh=8RFdCQOm4vZFdehj3bUDpcy+jvON4CmFDASZMU7AMWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eomNdBUFdXFZvUkHcSkRx7CzdNn0m5tRi1y/TR82T7snqc2zM9ogY5lXJpI1srtGWczcj3XNPux3kcd6VPkfndMiUuGsHniLCzDWZVIP+jJ3MP6nyXjvxWhXkHnYQLtpL2Ix9GeoEa8Or91dsTRrRBCD0sQ1Akq2ThrvJww2PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tan0eiZc; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56LED2k1822189;
	Mon, 21 Jul 2025 09:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753107182;
	bh=Nh59/lkpsvmg1ZVKHRMN4ZHHZVoi4kbwnBYZr5gHbjk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Tan0eiZcqW0I4uKlbNIWRM0tM9SYQhScxKr03owyfIXsdfK6Eg2wbd4rpAVZT3mHK
	 LJFMV0SATt60zWidBxtGSs2JPgwg0KciWceCgh6iOwIzZ87vjLxNE+WDLN9Skg4Qmg
	 2P62ufFNwCpBx3CIv/H0Mbrx9LFEnvVcwgVgdwh0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56LED2ux1417486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 21 Jul 2025 09:13:02 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 09:13:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 09:13:02 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56LECvBl3955460;
	Mon, 21 Jul 2025 09:12:58 -0500
Message-ID: <86bbb4c1-18a9-4917-8554-97d540b72b5a@ti.com>
Date: Mon, 21 Jul 2025 19:42:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-j721s2-main: Add interrupts
 property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Yemike Abhilash Chandra
	<y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
 <20250714092708.3944641-2-y-abhilashchandra@ti.com>
 <72545187-4605-40bb-9c68-54670c2e5332@ti.com>
 <92627ace-1fc8-45a7-a25e-76f410427f0c@kernel.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <92627ace-1fc8-45a7-a25e-76f410427f0c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/21/2025 7:39 PM, Krzysztof Kozlowski wrote:
> On 21/07/2025 16:07, Kumar, Udit wrote:
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> index 62f45377a2c9..6f32a2b0c40c 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> @@ -1248,6 +1248,9 @@ ti_csi2rx0: ticsi2rx@4500000 {
>>>    		cdns_csi2rx0: csi-bridge@4504000 {
>>>    			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>>    			reg = <0x00 0x04504000 0x00 0x1000>;
>>> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>> Just cosmetic thing, if you are doing v2 then consider 152 first ,
>> followed by 153.
>
> No, you cannot just randomly change numbers or the order.
>
To be precise both , interrupt-names and interrupts,

if this make sense to change.


> Best regards,
> Krzysztof

