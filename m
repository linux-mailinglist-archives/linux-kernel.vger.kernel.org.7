Return-Path: <linux-kernel+bounces-755199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7EB1A2E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320AD3A6E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A135624BCE8;
	Mon,  4 Aug 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFwRxWZd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97124DCE5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313030; cv=none; b=oCrh6gcBRQdMDNm0+HVsymI4pZG9TsJ8RL59WvZKfgB+J/gdDcF4ztZThyKqwvfNGhefAfKJehCd25NXGqXSdhDkRDfJJxR++Ww/Vv+g77N8fChPPGSHrf420GXtkN4+R8HT1cVNynbkbmSx5p/IUfA3e2nq8R591G1taip96aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313030; c=relaxed/simple;
	bh=g4saUMZ8p0UcOOQ4YnmTFnzzsYZPhiQkelMsnLx7VXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzmrdQ8Wq5L78WRONJ1B2LM8hMFhALGRaya8y/gFJXgTS9alq8p80lD66bg/6wdBRf4SVC1OSOjFoqx+vtk3qpd0cdXrKQI7CYnIqjWvH7ZY/qkFy/OQcHLPQAvtD7SlF0tqrW6wqU9+mOYQSBw0ljOftvdT56tARARU2OOyTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFwRxWZd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748j3lT006900
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 13:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GfKUc+kuP7eqftOjhghizxUFjZFF9bECTjX+GkLBpnY=; b=jFwRxWZdgN4UZjcZ
	PJZ9G8Sm79X60V+8bqk8SEWhcVoN53Nqsgflpxzu0EiBTv2kKkJUCaphtBqhC08W
	6Yr8si1jJbF2wXFRDz+MhBO2zsC0WaJDnxcIH8NddRLphtDosInuAg10zDsH1T24
	BwAI4JkWfsJtZINQEpPvNcxl0lfi7U8urKEbVYy3wPYA4ps6LtGNV++H9OmxAhFp
	P9EP3fWBtM8BarYMUrP/P8ix1sdhkAMBPPNb9pOMXUWRuQzA44jbvZhUQCGVTHA+
	DSXa4EM5GNEGJ8ttcEPsHnIhsO4SZ5lzU+f6X41q77LZz4Xx1cymGxMVLxMSmvWF
	H8hsMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke360a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 13:10:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e69157a1d8so3166385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313027; x=1754917827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfKUc+kuP7eqftOjhghizxUFjZFF9bECTjX+GkLBpnY=;
        b=wBj60eCWZFGsnZa3YcPNONSHErStiHWEh/ZTrzCuGe4knnlcEPlqE4QCs/SnqBJurG
         8uDDIIrGkhOukr9EL3jfc3d4ut/HrbghJkNt9w9SlW+72OPH7la9wxgXMvya0/g/g9Mk
         UhKBNbBNInHIHBjFP8bbGzsFtK/7sqNc4VDgTo29UBfrwsCG+feYhAWXh3+uQuemvbpf
         9rWJ00ZFyQsMkmpfEHHiMfQAqm6+xYuXlg1zjBk3UigNjiB3Y6S1E8xjQJ5pfCubE44H
         gI/lM/w9whj5O6HD2e5T5S58KiuuffWCAVh9hKcCTpM6VUfz4TkKXDdnfKI7YNUMBCfS
         p4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1p0aWZ8vuHyrbJgIh4SOzzMhBGPmVx2Kb78X4+cXceJFDZMMX7GF8exqo0MKXdsO0n0tg5vTxwB6N6gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Z2iXGR4NmfgidDLdpXw6XdQRejK+1G0gjfyO0Zuhx+ys2Nks
	xIRyIumQHJOO1zWjQiVf9chj4yKKqcaiH4g90Lln9U4WLLId9TOQYoGytqYmBcIg5+lYdLgZYie
	nDM6kAzjKnMCxRBN/WRgsm0Q5uFsSC4Gy5ZYXWHYAO0XxsMq79dE9rcyEqasV6VpQLwM=
X-Gm-Gg: ASbGncu1YHhjJmPNhX18i6clWCaqFNaEB6c8dTphkZn9tZqe5UmilhM8JYreKViQv1Z
	MzkVXpQQ5m+hr5F+hXVmPR6fgscmiK/wnQ+UsJpWNz3RTtq7JZ5RHjlWMjRkK8YApxXSuyoox3L
	TmQVMQx9wqDrsYovea5njriL9D4ZhQcxb6z3DYRm5MdngORcvFnX8O37Yvv91eZamm3+9qYAnPz
	en2IkonIPJ7KHKmDqHvCOTqOZd6DPRolgvLtXV1V1ArXQ4eVa2bmhkz5Toi/w8jveOWR8u4ZTwe
	/0t3MluW3yZ+1VFBY2/tUVy+HlqANnJrGPdezfHsV2HhBmA1h+FGBS4kudywTHkg+mIPPs5Dxee
	4wUKhUnMe9mWKeDeoPQ==
X-Received: by 2002:a05:620a:6087:b0:7e6:9e1a:19 with SMTP id af79cd13be357-7e69e1a0785mr475268385a.13.1754313026938;
        Mon, 04 Aug 2025 06:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH0ytOVSdlAoLjeaH62iZuMwjpguPye2kaId2yZqDicHLd8WaJRKDyo9XqLATfNFU70nUW4A==
X-Received: by 2002:a05:620a:6087:b0:7e6:9e1a:19 with SMTP id af79cd13be357-7e69e1a0785mr475264985a.13.1754313026415;
        Mon, 04 Aug 2025 06:10:26 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763e4sm734216366b.1.2025.08.04.06.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:10:25 -0700 (PDT)
Message-ID: <3fc425fd-39fa-4efc-bc98-da86a88bfb1a@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 15:10:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] clk: qcom: Add TCSR clock driver for Glymur
To: Taniya Das <taniya.das@oss.qualcomm.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>
 <aIoBFeo00PPZncCs@linaro.org>
 <784545d0-2173-4a8b-9d5d-bee11226351e@oss.qualcomm.com>
 <aIxRKHKdBHDefDs2@linaro.org>
 <d2c17575-f188-4154-bb63-e0b1b89d8100@oss.qualcomm.com>
 <b2f219d6-d441-45d0-a168-b2cdbc01b852@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b2f219d6-d441-45d0-a168-b2cdbc01b852@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cd2RWdGKfq_yCkl5db7X9WMiM1bd5jbz
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=6890b144 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=yCfBC-ZsDARYeWh2US8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MiBTYWx0ZWRfXykjOMQ1cp4T3
 luyGzi+pPIAmIgH1oVwE/Ctcwvrt4jKARbX5h3elR2XGr2lAOIw6OacM3uRB/0xi0cnAVRiteU2
 6mpGWkcNwgPz6EKb/V/yWpje4EenSse9ZIZUn1utk/vJDz8O+pEtIDDpl0fncKl6RHsDS1a3XTb
 EyoXlO2sV84S62ht5n8ElWYLB3hzMj1PYGY7J+YEM+1xc1fTFlRrGsnzsonuHwt+0SwZvUSTZa4
 mwwv4gUsuOJq67LCndfcJRWIiS5/bulcY5eyF+yo9nGDP8XblTymq8lnBDBoOz0ToVE3wxlcirt
 eh4xVNgal0jTJImkQ1EmDPQt6rzvbRhjzYJHlpaS7mfwlbjGxoG6VmmTsEGc8ekkcTwBBFXnVbG
 LObq8eA41tVc0PxxsPjB9pTqKYZfeylhZH0UpRfcpCKQFuPd176FwQEOD3bkwPq12PdycOyw
X-Proofpoint-GUID: cd2RWdGKfq_yCkl5db7X9WMiM1bd5jbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040072

On 8/4/25 11:00 AM, Taniya Das wrote:
> 
> 
> On 8/1/2025 5:24 PM, Konrad Dybcio wrote:
>> On 8/1/25 7:31 AM, Abel Vesa wrote:
>>> On 25-08-01 10:02:15, Taniya Das wrote:
>>>>
>>>>
>>>> On 7/30/2025 4:55 PM, Abel Vesa wrote:
>>>>> On 25-07-29 11:12:37, Taniya Das wrote:
>>>>>> Add a clock driver for the TCSR clock controller found on Glymur, which
>>>>>> provides refclks for PCIE, USB, and UFS.
>>>>>>
>>>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/clk/qcom/Kconfig         |   8 ++
>>>>>>  drivers/clk/qcom/Makefile        |   1 +
>>>>>>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>>>>>>  3 files changed, 266 insertions(+)
>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>> +
>>>>>> +static struct clk_branch tcsr_edp_clkref_en = {
>>>>>> +	.halt_reg = 0x1c,
>>>>>> +	.halt_check = BRANCH_HALT_DELAY,
>>>>>> +	.clkr = {
>>>>>> +		.enable_reg = 0x1c,
>>>>>> +		.enable_mask = BIT(0),
>>>>>> +		.hw.init = &(const struct clk_init_data) {
>>>>>> +			.name = "tcsr_edp_clkref_en",
>>>>>> +			.ops = &clk_branch2_ops,
>>>>>
>>>>> As discussed off-list, these clocks need to have the bi_tcxo as parent.
>>>>>
>>>>> Otherwise, as far as the CCF is concerned these clocks will have rate 0,
>>>>> which is obviously not the case.
>>>>>
>>>>> Bringing this here since there is a disconnect between X Elite and
>>>>> Glymur w.r.t this now.
>>>>
>>>>
>>>> The ref clocks are not required to be have a parent of bi_tcxo as these
>>>> ideally can be left enabled(as a subsystem requirement) even if HLOS
>>>> (APSS) goes to suspend. With the bi_tcxo parent the ARC vote from
>>>> HLOS/APSS will not allow APSS to collapse.
>>>
>>> Is there a scenario where the APSS is collapsed and still the ref clock
>>> needs to stay enabled ? Sorry, this doesn't make sense to me.
>>
>> MDSS is capable of displaying things from a buffer when the CPU is off,
>> AFAICU
>>
>> We can do CXO_AO instead to have it auto-collapse if it's just Linux
>> requesting it to stay on, I think.
>>
> 
> Thanks Konrad for adding the display use case.
> Abel, we earlier also had some PCIe, USB use cases where we had to leave
> the ref clocks ON and APSS could collapse.

XO votes will prevent CX collapse, not APSS collapse. CX also powers
USB and PCIe so that only makes sense.

I think it's fair to just stick XO as the parent of every refclock
today and think about the what-ifs (such as the mdss case I mentioned
above) later - especially since we have no infra to take full advantage
of it today (non-APSS RSCs etc.)

Konrad

