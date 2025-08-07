Return-Path: <linux-kernel+bounces-759109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6192AB1D88F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DE77AF544
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C8259C93;
	Thu,  7 Aug 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CU9Aji/S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9F2E36EC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572075; cv=none; b=t2JNF0a/0ZX7YpgBij1krSbvsCyhliKg40haRjp4vl1kqcCxIYM+7REfyFDDSNRFDWW50xP6MRQl3CAino8P0r8jjVYGA2hLlhykt7vNhxYhWPJGG6wtRN3PB0b0zDLm30Iawe9pq52kaxFyPvC3koDkuAd818fLuvjrgCw8uNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572075; c=relaxed/simple;
	bh=vC1L5uHVJJ5u5AqxaDxekBHje77miJh9Ju0KRoMlzjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3gUAKMjcbCqmkfhT97eYuE/HY9lmO8v5ABd4YZSGk5eJMTQ0kDxtvneo1bkTSFGzkID3RLoa11WH3qB0t46mvGPMYwaBX0dBeFOA8f5hIuTi/V+ajLybCmuLsjKaS2glWrl/yIJjLTrpSSdKNzjggPAvC5DMEVqS/X24OAOtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CU9Aji/S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DjJM025440
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 13:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eK9XSXOchQCfWi8EBFJeSJTCKKXnDgji8hN/xsZotU0=; b=CU9Aji/S/yZbPrjO
	cHAmqlqJ1KF0VzHdMTEIjWaofLXxPJJ8fZK5FFf40wdYCt/W01Es+dmPPvZgOM4k
	muuiM1JT+oUo107dyedCJ5vrenv67Ugxjyqwa5Kw7C7+yAj/p8SnWqwOkQ4+BdJL
	7ZToOwl6BYbbuaEA2isxFFd4NLIcnbTe3gCQkpi6tfJZDghiUdodWwYBO1/oLOik
	FvZBeRu0QwwBgNlln3jiKIOhsBF/6I8syh+CMbld344tzclxP3khJEDVjSB5Y2If
	mp9zzjXaZtTQUeNGH2FemQ8h4o/2cBCfv2VU73T0Z1JYCZkCJIJN8KVsPkTWBXOh
	Byg2UQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1ea71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:07:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b067cb154eso2392761cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572072; x=1755176872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eK9XSXOchQCfWi8EBFJeSJTCKKXnDgji8hN/xsZotU0=;
        b=kmo08aNYghk4WEddf0mRSYZomHiTpuhI+ZcovJ00UuNdKw0jmZ0gT0AggBNvYYfIU/
         Vu0f/SPYNvDSNgO9+DEztdbCdILYLhduXiR8m4Qnk1wBIuqRVnvv4Xlmk48+SoU8nmTC
         MtZt5mxdbURSosMkp7Syg8DjH/nT7p6sZU94BgkFTv8E6vEsmIFEV6p6kxZUmZBCO4VU
         mY5IKf3KJeOcEs0/FSXb8myvGXQpVKU1g/S0y5PgtG4N+nEeG/c/LU8saDzx28auRy1p
         Pk6yBTXjqy1VwuptUXAM/4XIwKJvrEQ1j5mFUaKNgoNbYaX6nEpIvK/Egm0h1wIb4b9J
         i1VA==
X-Forwarded-Encrypted: i=1; AJvYcCUS0dbK+46mDwB6XS4IToJNb//hHA/837QAcpsZhRlwwYaqgz3CgC1CYc+ANXeE3e64/sr4WuLcshz+tEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDaeW+1izjMWJpM1APPv/Cx3IrM/a95CIg3b4unfc0+l6A8Gt
	8Vd4QjAJIc3BOCV18ROR3CzMD5npwujHenrywLhYYU3NVE28zmIArXCEyAeaWcJLkqcoNPPX4X5
	UMUseu5viYT73K6z0nzUH0Yi42CXC9bnp149u1OCDLc7ikulk9xN76Pp0/jC0PmZgxiM=
X-Gm-Gg: ASbGncuD2feQAMAPvakxLyEhdL+l9IWOFo6XrpshQKtt2Xx59p73YTjD2lTWppubRtI
	Ezm0z8PAjGsyKaAOAim63DkXFxkaWen+EcA2EEkCYdP8v9yB8FdYBakPu2QE9gX+bvfGEGRGUOm
	eF2IPjP1LheNPpb4e0j2Ng6JH1REZutuBoOnGYQwRLf1WxCf5wVjjazeU13FzgN1AL45UYSjAVV
	bUQlKqOC4NCCB+6e7vIOgjUNH3bYseOSRb2m5uZqmhaOdDqL5+DarC+vyQl4MsEdZHzv2p74lgG
	wA/Y6s5XLFsYuH2+8VNmTq5BaTxvU5OjgxWgOgvAD0DM/NZcWX2jK9sUwBWq8Qgm1GySzZ/xJaF
	/bzjj0iVIycwtEEjJ/w==
X-Received: by 2002:ac8:5e4f:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b09147d336mr39191631cf.7.1754572071658;
        Thu, 07 Aug 2025 06:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAEVtX/FaNdkuqT6pyYcuVANHG3E3H7uatYjqkdIYJFTr1QtjKQ9o+lK4E/zBtcVM8O+8/+A==
X-Received: by 2002:ac8:5e4f:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b09147d336mr39191281cf.7.1754572071039;
        Thu, 07 Aug 2025 06:07:51 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82bbsm1310874666b.81.2025.08.07.06.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:07:50 -0700 (PDT)
Message-ID: <ffbd9302-75f1-4148-881a-767fa413c825@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 15:07:47 +0200
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
 <3fc425fd-39fa-4efc-bc98-da86a88bfb1a@oss.qualcomm.com>
 <c2f39786-5780-4124-9e41-6971428aa267@oss.qualcomm.com>
 <9e3b4706-c61a-4d69-be84-a5b6fc90eb35@oss.qualcomm.com>
 <462b4010-fd79-4682-b9d2-31ffdd53b75a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <462b4010-fd79-4682-b9d2-31ffdd53b75a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX8CbhykK5nZBY
 OLoYmv3T8TLiwP/HJyMwVt6j7LRz7qMNHyfaeIIGYLJ6qafg6pwdQRROndIXA9Pb1DSjCbeuA+8
 wqBhsrw27dLwj9P7l+B7GBzTyimhytRwDSoVpDy6E5aMZyCjPNI+hChvrYN0DXtF8hjjtk3RY/W
 Tp18vGeYxn2c8BTP32gL10TBB/uCRAY0+40EugOPicibgkGoEOsha6JJEQosdfBAqPq19zrDewg
 UGROybY3S8F/jGUbd/zAcJNpY6U+o8/irPmSi/u+I3B8N1AVm08NIexLtfDkI0r4Lqbtq462fIm
 mgP6zXHm/AmyWLAHL3GlgA/LMPO9wkfxUolEV4ZS4hTCTIu2VWQTZELj0Gw5Co5mD9QVrYHlRYR
 FmsyVfPs
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6894a528 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=PLusG5baLZIICTn4gS8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: T1wpG78NI8pk8tQiATX-SG_b2Wug7cJv
X-Proofpoint-GUID: T1wpG78NI8pk8tQiATX-SG_b2Wug7cJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 12:21 PM, Taniya Das wrote:
> 
> 
> On 8/6/2025 3:34 PM, Konrad Dybcio wrote:
>> On 8/4/25 4:21 PM, Taniya Das wrote:
>>>
>>>
>>> On 8/4/2025 6:40 PM, Konrad Dybcio wrote:
>>>> On 8/4/25 11:00 AM, Taniya Das wrote:
>>>>>
>>>>>
>>>>> On 8/1/2025 5:24 PM, Konrad Dybcio wrote:
>>>>>> On 8/1/25 7:31 AM, Abel Vesa wrote:
>>>>>>> On 25-08-01 10:02:15, Taniya Das wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/30/2025 4:55 PM, Abel Vesa wrote:
>>>>>>>>> On 25-07-29 11:12:37, Taniya Das wrote:
>>>>>>>>>> Add a clock driver for the TCSR clock controller found on Glymur, which
>>>>>>>>>> provides refclks for PCIE, USB, and UFS.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/clk/qcom/Kconfig         |   8 ++
>>>>>>>>>>  drivers/clk/qcom/Makefile        |   1 +
>>>>>>>>>>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>  3 files changed, 266 insertions(+)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +static struct clk_branch tcsr_edp_clkref_en = {
>>>>>>>>>> +	.halt_reg = 0x1c,
>>>>>>>>>> +	.halt_check = BRANCH_HALT_DELAY,
>>>>>>>>>> +	.clkr = {
>>>>>>>>>> +		.enable_reg = 0x1c,
>>>>>>>>>> +		.enable_mask = BIT(0),
>>>>>>>>>> +		.hw.init = &(const struct clk_init_data) {
>>>>>>>>>> +			.name = "tcsr_edp_clkref_en",
>>>>>>>>>> +			.ops = &clk_branch2_ops,
>>>>>>>>>
>>>>>>>>> As discussed off-list, these clocks need to have the bi_tcxo as parent.
>>>>>>>>>
>>>>>>>>> Otherwise, as far as the CCF is concerned these clocks will have rate 0,
>>>>>>>>> which is obviously not the case.
>>>>>>>>>
>>>>>>>>> Bringing this here since there is a disconnect between X Elite and
>>>>>>>>> Glymur w.r.t this now.
>>>>>>>>
>>>>>>>>
>>>>>>>> The ref clocks are not required to be have a parent of bi_tcxo as these
>>>>>>>> ideally can be left enabled(as a subsystem requirement) even if HLOS
>>>>>>>> (APSS) goes to suspend. With the bi_tcxo parent the ARC vote from
>>>>>>>> HLOS/APSS will not allow APSS to collapse.
>>>>>>>
>>>>>>> Is there a scenario where the APSS is collapsed and still the ref clock
>>>>>>> needs to stay enabled ? Sorry, this doesn't make sense to me.
>>>>>>
>>>>>> MDSS is capable of displaying things from a buffer when the CPU is off,
>>>>>> AFAICU
>>>>>>
>>>>>> We can do CXO_AO instead to have it auto-collapse if it's just Linux
>>>>>> requesting it to stay on, I think.
>>>>>>
>>>>>
>>>>> Thanks Konrad for adding the display use case.
>>>>> Abel, we earlier also had some PCIe, USB use cases where we had to leave
>>>>> the ref clocks ON and APSS could collapse.
>>>>
>>>> XO votes will prevent CX collapse, not APSS collapse. CX also powers
>>>> USB and PCIe so that only makes sense.
>>>>
>>>> I think it's fair to just stick XO as the parent of every refclock
>>>> today and think about the what-ifs (such as the mdss case I mentioned
>>>> above) later - especially since we have no infra to take full advantage
>>>> of it today (non-APSS RSCs etc.)
>>>>
>>>
>>> When ref clock have been part of GCC, then also they didn't have any xo
>>> as the parent, similar design we kept when it was moved to TCSR as well.
>>
>> Perhaps we've been running on luck (i.e. XO votes being cast through
>> another device / clock as a second order effect) all this time.. I'd
>> happily move towards formal correctness.
>>
> 
> I would like to stay with no XO linkage to TCSR. Any driver has specific
> XO requirement should vote for the rpmhcc XO or XO_AO.

Every driver has an XO requirement, as we happen not to have any
other crystals onboard.. The clock plan says that these refclks
are direct children of XO too

Konrad

