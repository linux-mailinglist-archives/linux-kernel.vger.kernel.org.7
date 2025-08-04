Return-Path: <linux-kernel+bounces-754891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A6B19E17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EC11796B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429D242938;
	Mon,  4 Aug 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KI+qPv7l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90A23ABBB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298030; cv=none; b=TipRmV0o6141rDgRoHeGG4GiGjhib3RGhOp5WGjRYOKGg1CIjqOCebmbwRh/qP49sefZyQaHEBqlTj40FQ+0v6bRcVQptI81J2/PzLQgNDn5EHLFHsy2tpBMob6QSqMHFodsU3nObjuRh5F5frLPjh0lTJbBfCECf99leb5AblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298030; c=relaxed/simple;
	bh=KCH1pCdiGwOBI5qtyR9u3CbnJsjZm2nAIh6QkzgzEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX9/8JjrqsSIczCXIyWILl3QaQr+KYGy7uh+OZCLHRmvW+sBI/YsnS3Sp1TVT/Hp6O4NETFSlLooaczuTP7Cf5QKOx+r5KEAxVaqiC0vQMnX5YBFWRL5dR10t3sCnAvyZAv8n0o1pAJESMdK0hoqfmOjNMinTZ338k5laruziNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KI+qPv7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748THLt029904
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 09:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLD6PUFRLMN+HbgpajUIIfX4iIztYiU2uFQ6pIPAkPo=; b=KI+qPv7ljAiWwRSm
	o+cTfcCfWGnY/0Y7m3Jfv2DmhiCiaDPeiJGy1xoHbXe2I3sC5W4LOuioQeqLGD7U
	qQrgnp+DSuOLR26mT4Cdj4Tj2Gkd/34BeEjQnYHQE7C8yb/MXz6ljYKuiVW6dz/i
	pi0GBqIClcvpgCBHTsvQ/1XgECoogSsx8i/9iD+lTGzojO5lKrj0+WZEmubfTO4B
	0i80RAGj6dzOuWyF8OPwe26bXlVxQ5dOwU/bfnGtiymAOpvgkaVu441P7QnHHe3z
	Z9C5zmZ4Ud69/2Qjea+n8RarwaDlQGbFEnVtxbe2+f91iE+3DJ9BcNxdk+p4HiSo
	brRGXQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc465g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:00:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76c0039e0f6so1078939b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298008; x=1754902808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLD6PUFRLMN+HbgpajUIIfX4iIztYiU2uFQ6pIPAkPo=;
        b=ipS+iQ6Tmu1Se+dNYh1TboKqtWtld+JJ9CP5L7jfbnnHS9Ap8sYRYvkphxIf3forCL
         5/xArQmt5GpRWya9KtmEc3wV+SMBYxCQWRZgpe0FGSlHNeVBJNYUWWcrjJTXRSa+1NzU
         dUxA6JOn5juinee43ARGAwI+9l9wHYsWpqlXpf146h4xN2HGXknl36kLmOMHpNGykq0W
         oijzAJETeLfZLbGL92UbfYxr33TvOmxaByd6GBziq4eWQkWz9cV/lOfFK0iGfeUl9H4C
         wYu0KqpHn7qmgOc80+Sxf7ddYrvOgziJ27nGbsrJ6eu541mDyKbLKs+RrEMw04rW3e+H
         axcA==
X-Forwarded-Encrypted: i=1; AJvYcCWBu2EuZTMrg5mGF5hhZEyer/HRWudIhJG8J4IOhL1Vq9QCSuGYyADbjyVLuGLyRegTydo1zbV/UiJ14Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Z/atsROictwgWY6EbjhazcKbsncfEyK2F+h3Y3svJUab8dEd
	qJpy1sr71NcYCwE6ZY3LmtWfhiVocRsdjzk9wwEMLG/Qz5Pw6MUfwGnEPuOMKxdU/OomQgl284e
	fKXBJfKrZdI/d1gqOvVBezSiwKIYukYKllufuFJhR98dxhUXS6I1QYOV9PfQW8xn1Zdk=
X-Gm-Gg: ASbGncspE78uobVZzdfuofz4DdLFMaX5uVMEBfA+kc4uKCiGhRncl/P6BFehHMAqi1e
	sFtIvSubhgVSFEt7sucWpMWf2Z6GinS3P/dkwQi+FSs5LCLJizmrb7ExOfSiUpwBsaLjlZ/loLN
	D4ut+mKgLlKOWFm8rUgdgmw0JoFsfhOhAVWVuJWILvwJb7ChqLF9KVCI4xwEFKc3N6VJjYBURU4
	0RzEzE8G1I2CW2Pd3/mlR5epKVxOA4K9g+0bf8m5CykebtyEgjGCJXwnNGmqhf/JhfueLCGM4kL
	afEi9+ou9xhFWF4Xrjjfhuvp+LsNrYazH3MGPD02qXojbvHKNnEntrM32X1lObuQqlo=
X-Received: by 2002:a05:6a20:558f:b0:23f:f712:411c with SMTP id adf61e73a8af0-23ff71244dcmr6640460637.36.1754298007814;
        Mon, 04 Aug 2025 02:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdxtGwnA/c48xKrIO/+id4y5Pj73li5eoGe6GJBL7RnkEfq1PIi9CDpV3qk/9Rh+1G6mWGHw==
X-Received: by 2002:a05:6a20:558f:b0:23f:f712:411c with SMTP id adf61e73a8af0-23ff71244dcmr6640428637.36.1754298007371;
        Mon, 04 Aug 2025 02:00:07 -0700 (PDT)
Received: from [10.218.30.152] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c0a952525sm1455674b3a.79.2025.08.04.02.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:00:06 -0700 (PDT)
Message-ID: <b2f219d6-d441-45d0-a168-b2cdbc01b852@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:30:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] clk: qcom: Add TCSR clock driver for Glymur
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
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
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <d2c17575-f188-4154-bb63-e0b1b89d8100@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A3GYeEMcSxRoWj8wWSun4424iAOx3DKS
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=689076aa cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=xkFCAPjOK7Wg2B_RzJ4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: A3GYeEMcSxRoWj8wWSun4424iAOx3DKS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0OCBTYWx0ZWRfX62oWQLUUUdHb
 9ztydurjUofvWD+cDbo4IXNUp6JfWOxCs07FK1XvVITYAa8JUUkj0nmSAv81z2i7kSdgWqOQxwx
 omgiBXM/0KyWcWoLCZP9E9vsWu8fXsaCEy70YbrsYUYxlnRZJ5AGafAxqUgVMgBhYUx2w2GGk9o
 aWkTYFY+L1nhw5yKxr02f5Kla9AhUcaSP8F4dwfhWvnzXAO7134zQJqtAFAAVA3AXZtHu2FMfOP
 qvytqoqaCuS4Uwns2c3LRhw24+QD2txns/kwpfJ6L/HmzMAwI3VJJGtIQaH2VDUct8L9hKM2on4
 Nwy4F1u7eTa073T1/0RhupWWtux5+kZFM9mn5utrCxwKDcJ7uucJErMwt7FOsP73MPcOAW2w1iy
 S66yOXpie0a+iDGaR7kQioSLGhd7gK34h1cB5/uD8fLZAWGrw1zBij9YfE3nsHNx6pwOu+cI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040048



On 8/1/2025 5:24 PM, Konrad Dybcio wrote:
> On 8/1/25 7:31 AM, Abel Vesa wrote:
>> On 25-08-01 10:02:15, Taniya Das wrote:
>>>
>>>
>>> On 7/30/2025 4:55 PM, Abel Vesa wrote:
>>>> On 25-07-29 11:12:37, Taniya Das wrote:
>>>>> Add a clock driver for the TCSR clock controller found on Glymur, which
>>>>> provides refclks for PCIE, USB, and UFS.
>>>>>
>>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/clk/qcom/Kconfig         |   8 ++
>>>>>  drivers/clk/qcom/Makefile        |   1 +
>>>>>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 266 insertions(+)
>>>>>
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>> +static struct clk_branch tcsr_edp_clkref_en = {
>>>>> +	.halt_reg = 0x1c,
>>>>> +	.halt_check = BRANCH_HALT_DELAY,
>>>>> +	.clkr = {
>>>>> +		.enable_reg = 0x1c,
>>>>> +		.enable_mask = BIT(0),
>>>>> +		.hw.init = &(const struct clk_init_data) {
>>>>> +			.name = "tcsr_edp_clkref_en",
>>>>> +			.ops = &clk_branch2_ops,
>>>>
>>>> As discussed off-list, these clocks need to have the bi_tcxo as parent.
>>>>
>>>> Otherwise, as far as the CCF is concerned these clocks will have rate 0,
>>>> which is obviously not the case.
>>>>
>>>> Bringing this here since there is a disconnect between X Elite and
>>>> Glymur w.r.t this now.
>>>
>>>
>>> The ref clocks are not required to be have a parent of bi_tcxo as these
>>> ideally can be left enabled(as a subsystem requirement) even if HLOS
>>> (APSS) goes to suspend. With the bi_tcxo parent the ARC vote from
>>> HLOS/APSS will not allow APSS to collapse.
>>
>> Is there a scenario where the APSS is collapsed and still the ref clock
>> needs to stay enabled ? Sorry, this doesn't make sense to me.
> 
> MDSS is capable of displaying things from a buffer when the CPU is off,
> AFAICU
> 
> We can do CXO_AO instead to have it auto-collapse if it's just Linux
> requesting it to stay on, I think.
> 

Thanks Konrad for adding the display use case.
Abel, we earlier also had some PCIe, USB use cases where we had to leave
the ref clocks ON and APSS could collapse.


-- 
Thanks,
Taniya Das


