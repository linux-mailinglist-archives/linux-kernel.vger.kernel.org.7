Return-Path: <linux-kernel+bounces-756489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4DB1B50A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3646222E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD286188580;
	Tue,  5 Aug 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z7OPCWI1"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CD274FF0;
	Tue,  5 Aug 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400906; cv=none; b=QxDVwNPxZIoQVoIptAB/YeFSBa21qPgc9AaR6tUgeidcUnVHvUvJUG+mLhYFyVyAXv+Rz3BC0RSCb9N/ixq/4GuGMrfXuQbJiW7hH0pGLMRgQYvlskZFscpOyTI17DdUeJajNZy7oOZfAlxteuyBvHJLIbpuSXG+jFse+h4mim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400906; c=relaxed/simple;
	bh=9pLc3dkIGSk6R/8cCh52WAo8L/RTrQWG+3jmS5Hdrsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DujZ1TiiKS/e76Timv1QiAZmzCjGxuXwj44CtxhZp199ITylyiT1qVZ51lem08pduWNF7fWzQSCsn+22RJijmr+helwUugWhi+LYFDNASGKIDn8FIyjlKmJuJPf3Q1BPYpPWawhrWQwwZknhYDt2od2/Ii/won/Y+6U5M1ZqAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z7OPCWI1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575DYuhe4087700;
	Tue, 5 Aug 2025 08:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754400896;
	bh=w/auADTZf57vdDvNnTOht1gIs0Ij1FRUC+wCoKdxz3w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Z7OPCWI1pmjwLwolY5Lx0NUNULPI+7gmZQE/Kb2MrMxdaYtgMtttpDeGwjo5RmFBR
	 1jp1slPfZBSH0LoRuy/chTgT8xUEus3IZPdtdfzqg+uFUG8BPTzKETVHOjCLgdF3Q5
	 fQb8uN/HfDlyXDrEuYCi9UkzjftnI3cK2fCOU7d0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575DYuvj3615752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 08:34:56 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 08:34:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 08:34:56 -0500
Received: from [10.249.34.164] ([10.249.34.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575DYtLF2186580;
	Tue, 5 Aug 2025 08:34:55 -0500
Message-ID: <b52fd6d4-b907-44dd-bd9b-e15c3321ad79@ti.com>
Date: Tue, 5 Aug 2025 08:34:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
To: Krzysztof Kozlowski <krzk@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Devarsh
 Thakkar <devarsht@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Darren Etheridge
	<detheridge@ti.com>
References: <20250804180106.2393256-1-b-brnich@ti.com>
 <b5ba5a22-dc0a-423b-963f-5db6c7e04665@kernel.org>
Content-Language: en-US
From: Brandon Brnich <b-brnich@ti.com>
In-Reply-To: <b5ba5a22-dc0a-423b-963f-5db6c7e04665@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

Thanks for the review.

On 8/5/2025 1:02 AM, Krzysztof Kozlowski wrote:
> On 04/08/2025 20:01, Brandon Brnich wrote:
>> This adds node for E5010 JPEG Encoder which is a stateful JPEG Encoder
>> present in J722s SoC, supporting baseline encoding of semiplanar based
>> YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
>> supported from 64x64 to 8kx8k.
>>
>> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
>> ---
>>
>> Changes in v2:
>>    - remove invalid clock-names attribute
>>
>>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>> index 5cfa7bf36641..fb24c14614b4 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>> @@ -385,6 +385,16 @@ c7x_1: dsp@7e200000 {
>>   		ti,sci-proc-ids = <0x31 0xff>;
>>   		status = "disabled";
>>   	};
>> +
>> +	e5010: e5010@fd20000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

I got this name from the already present node in the am62a device 
tree[0]. Should I replace both of these with more generic name such as 
jpegenc?

> 
> 
>> +		compatible = "img,e5010-jpeg-enc";
> 
> Wrong compatible. This is TI, not IMG.

Devarsh has pointed out the same, I will update compatible that matches 
TI version in v3.

Best,
Brandon

[0]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi#n1149

> 
> 
> Best regards,
> Krzysztof


