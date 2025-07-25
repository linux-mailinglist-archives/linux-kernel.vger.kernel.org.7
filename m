Return-Path: <linux-kernel+bounces-745709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF2B11D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA03A581E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE72E6107;
	Fri, 25 Jul 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KwR+EWxB"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE622F75C;
	Fri, 25 Jul 2025 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442179; cv=none; b=OaxjeGLAtjxJgnNP+lSYZAtHSNIoDKTnQ95OlwMn0qfYqe5Ari5B4xSM1QBw75sb9twl6zSAtdZTLbC1RSCbv/ZqJq+1ESvsQbYff7do0ubcZ1V69w2c7JTzPyKAdeqaOUNiO5HHy8kdvglJa6Qr95hjRItCSEMOEjbwagUObsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442179; c=relaxed/simple;
	bh=aKeRYjFVV3Y3g3lwqTRipzDDDGW/1smCBWkWAlL6sWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=le7rRcvWBYbaqCUW5MxqZ0YTSI9e3q3h78pRiDSxaCkt6ZGd/BBodp3CdrWvhDdGqaxDjk+NWozdWRUS+23VsjjGCDxTaMMYJCnFeIgD3h1HAigk6XST+HB2JwqfxljmzFzJTgErw80aUUu+2hxNzan7wvWe9Hlixj0A2TL2+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KwR+EWxB; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAXQj6003648;
	Fri, 25 Jul 2025 13:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bvHvjwd6XOG8gaFWJcVrEpn5/3TbrGK3z3uZ5mkkCQ4=; b=KwR+EWxBDubt5KZK
	KwTbP7hwmwQB918hKeREw1OoQlG78H3x+rh43s42Cjq4rbrZC2aVqeQ3H6cm2UAE
	opBjmNl9Lz/uXptDv6+oPJy5zUhCAoQzU3hMzAvDRyi8BwfSV7K7tPsZAbPaSWaC
	jc23JYGcJppcXjF4an+x9dqZ5eqShkjxIbB4sof2tZiqIgaNjv7PfkOz1afK8d5W
	iRCoF6bzj6SWpGnHhnXe/zpXEmaFMlbf3aOumMNiUjT8XCntqQXgHkuaonTeqOhS
	Rlq0blQ71ejJWutjyN9F5RvgR+qPbxDdXS0kJqCFBXqRgOGIiCNt9+ITfOSLKCOB
	Y/8O1g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w3m2trd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 13:15:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DB8284004B;
	Fri, 25 Jul 2025 13:14:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D0D137A632;
	Fri, 25 Jul 2025 13:13:24 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:13:23 +0200
Message-ID: <a00bb4e2-b0e8-44ef-bf14-5e4f5e60f9d0@foss.st.com>
Date: Fri, 25 Jul 2025 13:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH 09/12] arm64: dts: st: add lvds support on
 stm32mp255
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-9-a59848e62cf9@foss.st.com>
 <85673db7-d311-47cc-be52-291d94e136e4@foss.st.com>
Content-Language: en-US
In-Reply-To: <85673db7-d311-47cc-be52-291d94e136e4@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01

On 7/25/25 13:08, Clement LE GOFFIC wrote:
> Hi Raphael,
> 
> On 7/25/25 12:04, Raphael Gallais-Pou wrote:
>> The LVDS is used on STM32MP2 as a display interface.
>>
>> Add the LVDS node.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>   arch/arm64/boot/dts/st/stm32mp255.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/ 
>> dts/st/stm32mp255.dtsi
>> index 
>> f689b47c5010033120146cf1954d6624c0270045..a4d965f785fa42c4597494010855aec7e1b9fdd1 100644
>> --- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
>> +++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
>> @@ -6,6 +6,18 @@
>>   #include "stm32mp253.dtsi"
>>   &rifsc {
>> +    lvds: lvds@48060000 {
>> +        compatible = "st,stm32mp25-lvds";
> 
> For the compatible you now need one comaptible per SoC.
> It means your compatible should look like : "st,stm32mp251-lvds".
> This way, if on the 253 or 255 there is an issue you are able to easily 
> add match data in the driver with compatible "st,stm32mp253-lvds" or 
> "st,stm32mp255-lvds".
> A prior discussion on this subject has been raised on my V1 of HDP 
> involving Krzysztof and Alexandre :
> https://lore.kernel.org/all/418a80a9-8c08-4dd1- 
> bf49-1bd7378321aa@kernel.org/
Woops, this comment should target the add of the ltdc compatible as I 
see that lvds one already exists and can't be changed.
Though the main idea is here.

> 
>> +        #clock-cells = <0>;
>> +        reg = <0x48060000 0x2000>;
>> +        clocks = <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
>> +        clock-names = "pclk", "ref";
>> +        resets = <&rcc LVDS_R>;
>> +        access-controllers = <&rifsc 84>;
>> +        power-domains = <&CLUSTER_PD>;
>> +        status = "disabled";
>> +    };
>> +
>>       vdec: vdec@480d0000 {
>>           compatible = "st,stm32mp25-vdec";
>>           reg = <0x480d0000 0x3c8>;
>>
> 
> Best regards,
> Clément


