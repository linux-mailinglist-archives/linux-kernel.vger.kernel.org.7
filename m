Return-Path: <linux-kernel+bounces-882941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA4C2BF38
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA948188AC75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759330C617;
	Mon,  3 Nov 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsJUpml1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QgSmptG3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1F30F53F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175138; cv=none; b=k6UtpdnDHXGZ2kFjf7NCXm4IjUMd/q6qE8bcHb/IHS8VmjpkN9hKEbjq8Gfw9I/CSY4tWhQJu2ioTDzYgmfRff6HIO9sgiVcs9TA+Mab63pjJpt+FdFqyC1Zk8FtTYQfwDE8tIOPTFQnvCb8tDEQE3g6N8XcBXJZYeVEDH/ufKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175138; c=relaxed/simple;
	bh=yHCkviYB7M5xI4hGCFFCPDT9TfosWOcdZS/ol351SPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL2bwm3FWYsdNbhEaMvNZifgZrGIVX+ljpIGVNfjxmfVVgZUAZyITKaEbxoqJsm14hkUFf1UMu5IiHu7Dx1MeR0JCCqA5GXWDk1t9FGEV3WmP/tvBUWSUEcT1b5hTw0koFI0EKBMjWIVbljtUpdfvZT7lFq9fYJUDKI+0mkLBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsJUpml1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QgSmptG3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B5sc92906415
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GeXclhcYrkoMtS5yu7RA7XBghe72qg0x45eGAc3ksmM=; b=jsJUpml1jtH4azie
	Z1Lo8kXi+F8tazgddFUeS61mFy3TqIyFQdaZe8g6Xig0TKR2l9dgbPbTliY3j952
	DOcFeSAZ+dW5gZwigeN1RIqPMWxzc9DoyBhBbFQ415LzEFp49UyaXqxAYMP0a+p+
	ftBoAyzq/kMbZR6yh67vp+9F0E4lFb/gXX/IkS9HlUgLw2HU4UmfugVvKdeZI+mG
	Rn/1dBlIcYDpiNpjwdjhxPN4k3TDqJ9WkegaoKwFm19q3WypD3aMkvGZ+3m14VME
	b0chFpUrccU6bOm2o2OH2L6Cv4zFxGem5hBG2r0aR49Ky3SLxoTZgD4uWoE6hoYn
	KdT+8g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u7kr96q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:05:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804372387fso10887696d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762175132; x=1762779932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeXclhcYrkoMtS5yu7RA7XBghe72qg0x45eGAc3ksmM=;
        b=QgSmptG3qjqzIyYIhw3MA/C6ijsIz/WVO8TeQ65tuhMbGdEuE6TUVDg6HckgEGI7Oo
         vmHKT0tjnltRe+QdStrdD8b3q+881SjVGqe6MdCubJptTGOSgrUfglUsXZNsCAPYEckn
         Q+SgidXLIxgHCsaqvSFoT4qIYnmJN6Uw8jWL/kn0RXesaBpkjCYFSA4anP2mHvko5APz
         m0dImIyx7FSYKmpS5Wb8Zyf6nH7PdkO9WqqzDiMd+ivZNtg2YANKystB2ard/08FhhL/
         MlHO5IhogfVyIM65MI9jO4Vnf36BCJ0GlhmMbfREnbEOEfBGzi+lkUrHlaEscazpy9+p
         23EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175132; x=1762779932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeXclhcYrkoMtS5yu7RA7XBghe72qg0x45eGAc3ksmM=;
        b=KErba+FlR0pVlzdU41r1RBekjWykx4eki/4I8tusIpiFESzR1gDmhjG6U7Rprmtm+X
         W+qIwhNnTfMrNHs+rj4tTX7WOjvDiR8RhTWe7miqfYDpGFeuql0r8UxtrYmbaWjzN6Hd
         vYtVXGeP9W0+2LlG+kvQAsR+imgq3vfQlsznBEBRZid9mI5N4zS+bY0BGV7kr98HjIK6
         /sTQO0kaRl48cmC24rnWEp4OOBq19oag1RPh/BrN0O1UtzHexXVlqO8K63jx/DHXPeP5
         KhzPrb0l7bBOyXpGzPdvS0ijwh8XYI9Ljs5OoJ7bRyyHjOJ4eCsqHpu7iJKFcYnPRtRV
         81qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLEVVg8S6aIPtf6+I4CojuMwYEq8+tcocXc16BMKxUoD5a3qPKuZxMgjnoGe7RVBpOMRW7pUQGh0h900o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwc1k/Y+Ote+pl3Ntdb9iB2FatXP/rQrBt3WyWhG+GW5pmLXW
	9F463wWigiacVmarPk9e3nkYxPBV7aPlUnZz1MVnLhY6E10ml95cpKfnxOiGy8TyxNLrohO1ONH
	aBDPIvjFRDOHdDKRazQfrgeu6K3shOWkgXSyKj9cBqDMONynpn83rjwpHgl36CpH+7bU=
X-Gm-Gg: ASbGncv6LuTwTt6B/vxVBErebgSd57+BStbzO5RZLmiw1fOZN21Uo2OXt1+7NzsCL7A
	vpEkAXNvtfx1R/iKefKIYcyoIOCu2/pdDh0y9gneuEDgiOaFBOPg4iZJyo+infMo4xh1WtTakq4
	VtZ2u1ibaA6cVhlLyl5/ItCTLcMdtOX0QIg9EPaKgEWuquSUon1aNG5PhlvuIiUmr/WVTw3SjZx
	lP6zVsfHNDNYfUWjZuZxFsnpR94ci8kdr6R2dnvqJUQa1xqm1RPMzc1iNdvgH70dZ7PsFxfUafd
	fWs6LBMKru4+eLKapuGvuphwIcf9d5/B0H0jZL8rN9wS5IPK/hg9AZ/NWDwWYcYK4XSRa812an9
	cVq1IeC+RCmWG+GYi5M/0sq2DT9Qtem0LaA4RXsOjXYQ3N5GCqKxjBwvP
X-Received: by 2002:ac8:6997:0:b0:4ed:4369:f3c5 with SMTP id d75a77b69052e-4ed436a0077mr52918701cf.12.1762175132321;
        Mon, 03 Nov 2025 05:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdZpqjlsH4evhdYWg1SpJwV80jysQWoUG6T2/da6gxZov34vLvmoCKJT9nSGjcekLTkdVJEg==
X-Received: by 2002:ac8:6997:0:b0:4ed:4369:f3c5 with SMTP id d75a77b69052e-4ed436a0077mr52918001cf.12.1762175131517;
        Mon, 03 Nov 2025 05:05:31 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b34a7c8sm9460589a12.5.2025.11.03.05.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:05:30 -0800 (PST)
Message-ID: <542654a4-c7c9-4af5-9361-084fb88af862@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 14:05:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spmi: spmi-pmic-arb: add support for PMIC arbiter
 v8
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, jingyi.wang@oss.qualcomm.com
References: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
 <20251024-pmic_arb_v8-v3-3-cad8d6a2cbc0@oss.qualcomm.com>
 <35ae8415-9308-4cbc-b14e-c3cdc0a2318a@oss.qualcomm.com>
 <28e2020c-8622-4bc3-aa5f-516a7d2abdb1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <28e2020c-8622-4bc3-aa5f-516a7d2abdb1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExOCBTYWx0ZWRfXx/zcJ0B1nnhi
 ZQdDpnu8zIyzCYV5lfsTgcG5okZw62fUkALk1XsgTxs9o0O1MB40334hLWY+Sfmy/Casci/OhLd
 anP435EXJR5xcqcdGodWF/S8qTSomr+YSC45zMZGT9liAfW82EccmAE5vP/HG3N5AB2LBQkBONf
 huThBJa8RUYLMTZKYccwbZOyOO04e37fujH8UIrtToAc4VwKSpHcURFRfaJ0tL4VzkDdZnNQMzj
 MFFjFGfPBFZ/Ka+aw8YeUGpUEmuglofqtNVQE3UqGsEhu9gba3r0Q4qaMJIb5d10wv1q2/onfwC
 KU/jbiYvk148SxELSaMC4IV8z3CjZ/H7PlIPbrSOrxTnd/3Av1Ri1dtv6Ld9qI8ltmyuKPk8/yr
 LmS1fgG22U1G8CJg0ukZ9EgTUIAAqA==
X-Proofpoint-ORIG-GUID: B08rtPH6u0H4wfbTr25tZCkneTO9bcUc
X-Proofpoint-GUID: B08rtPH6u0H4wfbTr25tZCkneTO9bcUc
X-Authority-Analysis: v=2.4 cv=Q9HfIo2a c=1 sm=1 tr=0 ts=6908a89d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bSyc8OR0nW6-KXhRdkcA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030118

On 11/1/25 3:22 AM, Jishnu Prakash wrote:
> Hi Konrad,
> 
> On 10/27/2025 5:47 PM, Konrad Dybcio wrote:
>> On 10/24/25 11:33 AM, Jishnu Prakash wrote:
>>> From: David Collins <david.collins@oss.qualcomm.com>
>>>
>>> PMIC arbiter v8 supports up to 4 SPMI buses and up to 8192 PMIC
>>> peripherals.  Its register map differs from v7 as several fields
>>> increased in size. Add support for PMIC arbiter version 8.
>>>
>>> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
>>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>> ---

[...]

>>> +static int pmic_arb_get_bus_resources_v8(struct platform_device *pdev,
>>> +					 struct device_node *node,
>>> +					 struct spmi_pmic_arb_bus *bus)
>>> +{
>>> +	int index;
>>> +
>>> +	index = of_property_match_string(node, "reg-names", "chnl_owner");
>>> +	if (index < 0) {
>>> +		dev_err(&pdev->dev, "chnl_owner reg region missing\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	bus->apid_owner = devm_of_iomap(&pdev->dev, node, index, NULL);
>>> +
>>> +	return PTR_ERR_OR_ZERO(bus->apid_owner);
>>
>> Is this any different chan using devm_platform_ioremap_resource_byname()
>> like you did above?
> 
> devm_platform_ioremap_resource_byname() would work for mapping resources
> directly under the main device node, like"chnl_map" , but in this case, the
> resource "chnl_owner" is under a child node of the the main node, so we
> need to use devm_of_iomap() here.

Oh, you're right

[...]

>>> +	apidd = &bus->apid_data[bus->base_apid];
>>> +	apid_max = bus->base_apid + bus->apid_count;
>>> +	for (i = bus->base_apid; i < apid_max; i++, apidd++) {
>>> +		offset = pmic_arb->ver_ops->apid_map_offset(i);
>>> +		regval = readl_relaxed(pmic_arb->apid_map + offset);
>>> +		if (!regval)
>>> +			continue;
>>> +		ppid = regval & PMIC_ARB_V8_PPID_MASK;
>>> +		is_irq_ee = PMIC_ARB_V8_CHAN_IS_IRQ_OWNER(regval);
>>
>> [...]
>>
>>
>> If you parametrize the masks, the diff against pmic_arb_read_apid_map_v5
>> is 3 lines of code instead
> 
> Are you suggesting we should try to have a common helper function for v5/v7
> and v8, which does the bulk of these actions and can be given different
> input arguments to distinguish the versions?
> 
> There is at least one more difference which I don't think we can easily
> accommodate with parameters:
> 
> In pmic_arb_read_apid_map_v5(), we have:
> regval = readl_relaxed(pmic_arb->core + offset);
> 
> In pmic_arb_read_apid_map_v8(), we have:
> regval = readl_relaxed(pmic_arb->apid_map + offset);

You can make the function accept this region base as a parameter, rename
it to something like _pmic_arb_ppid_to_apid_v5()..

> But in any case, we would have to add `if` checks to distinguish arbiter
> versions to use a helper function. This itself might not be a good idea as it
> would break the abstraction already implemented in the probe, by having
> PMIC version checking happen only in the probe, to select the correct set
> of ver_ops functions for a particular version.

..and then create a much thinner pmic_arb_ppid_to_apid_v5/v8() wrappers
that will call _pmic_arb_ppid_to_apid_v5()

>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int pmic_arb_init_apid_v8(struct spmi_pmic_arb_bus *bus, int index)
>>> +{
>>> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>>> +	int ret, i;
>>> +
>>> +	if (index < 0 || index >= PMIC_ARB_MAX_BUSES_V8) {
>>> +		dev_err(&bus->spmic->dev, "Unsupported bus index %d detected\n",
>>> +			index);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	bus->base_apid = 0;
>>> +	bus->apid_count = 0;
>>> +	for (i = 0; i <= index; i++) {
>>> +		bus->base_apid += bus->apid_count;
>>> +		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES + i * 4) &
>>> +						PMIC_ARB_FEATURES_V8_PERIPH_MASK;
>>
>> You can almost replace pmic_arb_init_apid_v7 with this impl
> 
> They are not exactly the same - v7 arbiter supports at most 2 buses,
> so pmic_arb_init_apid_v7 needs to restrict the max value of index to 2.
> 
> Here too, using a common helper function would require us to add more
> `if` checks for the version, which leads to the same kind of issue as above.

Add pmic_arb_ver_ops.max_buses, set it to 1/2/1234 as needed. I really
don't want you to add a copy of an existing function with a single
comparison argument changed

>> [...]
>>
>>> +static void __iomem *
>>> +pmic_arb_apid_owner_v8(struct spmi_pmic_arb_bus *bus, u16 n)
>>> +{
>>> +	return bus->apid_owner + 0x4 * (n - bus->base_apid);
>>> +}
>>
>> This is identical to pmic_arb_apid_owner_v7
> 
> This is not exactly right, pmic_arb_apid_owner_v7 uses bus->cnfg
> and pmic_arb_apid_owner_v8 uses bus->apid_owner at the same place.
> They are both already single line functions, would it really help
> to try to simplify them further?

Sorry, I misread and thought they were *actually the same*, scratch
that

Konrad

