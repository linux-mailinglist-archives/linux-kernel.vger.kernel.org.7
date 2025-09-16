Return-Path: <linux-kernel+bounces-819673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CBB5A468
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AA44872CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B1323F41;
	Tue, 16 Sep 2025 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oYooj2CA"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE71F4174;
	Tue, 16 Sep 2025 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059916; cv=none; b=XAhGEVCBIEvKFgEMJpxYZ/NpItifviu7c+Dg8TVIOzey7V8dDSxHBsRv43himskdZXIg8owlwW9kSE37QODIUWevtyEuTvIJoWcGtRGGTviCEBBmqviQuSymczzUy94asU4skqT0iqie6qYV4ZCabSh+fQ9oEeoyByBRzP9lpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059916; c=relaxed/simple;
	bh=p/sllpw7FUw3A5qT9X0lUWthNksKlG2vDd/iyZDgZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=MwQJlHAXCUw5YPQK5rgKlDP5jWPUclK7QuoHJOV0s1puhCEh4AQ3W80usqjZPNx23D5piAzx/0WQJu/SWNTR68ykywav6xQVcmLLC5E4GdZDl1PoFCuinRkj1nxM1dqdATD4VJbFiN8sP0qH1LAOHxAqTK1g9D3y4Usso2wXPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oYooj2CA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GLwPTp103866;
	Tue, 16 Sep 2025 16:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758059906;
	bh=UJkGfDcwDqP60o/V3NViblQLFb9Y4GSuV/HkoATCsEg=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=oYooj2CAhGlg3wuLBOoaypdro2mgHKDAhTmAlZjjvU4IV4u/6gaCctGYKSqv0ywbn
	 D/7uRLxFF7OT+eo1O2HJVVlJeQ+f34Z9biJwtfOhLHbczaWEl1GTy9dSi0gLCP6gmr
	 e11f51mU/w45gAy0oYuLGlcV7iUh7FR2MPLhK9So=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GLwPN91839800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 16:58:25 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 16:58:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 16:58:25 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GLwOGT1970510;
	Tue, 16 Sep 2025 16:58:25 -0500
Message-ID: <3e3de956-e071-461b-ada0-813daa3ef0c0@ti.com>
Date: Tue, 16 Sep 2025 16:58:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>,
        Kevin
 Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
 <20250812-topic-am62-dt-partialio-v6-15-v2-1-25352364a0ac@baylibre.com>
 <18fb75ad-aab8-455c-91a7-f8741289191c@ti.com>
Content-Language: en-US
In-Reply-To: <18fb75ad-aab8-455c-91a7-f8741289191c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/27/25 14:14, Kendall Willis wrote:
> On 8/12/25 04:15, Markus Schneider-Pargmann wrote:
>> WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
>> in that case.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-pinctrl.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/ 
>> dts/ti/k3-pinctrl.h
>> index 
>> c0f09be8d3f94a70812b66c3f91626aac35f4026..d3b0ecdf1a4a4de25ee6121ec9e62d1c7df26eb9 100644
>> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> @@ -19,6 +19,7 @@
>>   #define DS_OUT_VAL_SHIFT    (26)
>>   #define DS_PULLUD_EN_SHIFT    (27)
>>   #define DS_PULLTYPE_SEL_SHIFT    (28)
>> +#define WKUP_EN_SHIFT        (29)
>>   /* Schmitt trigger configuration */
>>   #define ST_DISABLE        (0 << ST_EN_SHIFT)
>> @@ -65,6 +66,7 @@
>>   #define PIN_DS_PULLUD_DISABLE        (1 << DS_PULLUD_EN_SHIFT)
>>   #define PIN_DS_PULL_DOWN        (0 << DS_PULLTYPE_SEL_SHIFT)
>>   #define PIN_DS_PULL_UP            (1 << DS_PULLTYPE_SEL_SHIFT)
>> +#define WKUP_EN                (1 << WKUP_EN_SHIFT)
>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)
>>
> 
> Reviewed-by: Kendall Willis <k-willis@ti.com>

FYI: A series by Akash [1] has been picked in linux-next. It includes 
the WKUP_EN macro but defined differently as PIN_WKUP_EN. The series 
needs to be rebased to account for that macro.

[1] https://lore.kernel.org/all/20250909044108.2541534-1-a-kaur@ti.com/

Best,
Kendall Willis

