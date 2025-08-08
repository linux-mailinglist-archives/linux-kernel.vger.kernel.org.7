Return-Path: <linux-kernel+bounces-760049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C61B1E5FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C9858322E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B24270ED4;
	Fri,  8 Aug 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Enr9R5U2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C825DB07
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646877; cv=none; b=tCzQpRhg6UgmAG72WzBHjujf6huuGxDHtyn2X/eIo+QK5+Lf/t1yrnI3W5I41ZAtVigmUYvP8nYdhSKdeqh8/+77D/7yESECJqO29nVtCptr5sgczCPJmaYwAimDEVGDb0f//fNp2rJ/AVRUxI2iWNSet7taLOgs2aGrM0A+qXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646877; c=relaxed/simple;
	bh=IZewFj/uk0R0C1cmRQpY3xYNslex4bPpK5Xu4ZFWs0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xkazpd6FX/nSB32wvBnQP2gLHK16RVi0c1ds4d8qZZjKYt47w3jHjxbSMXTqt6rRZ2zfU8Nh2B2a3OBiMvsl2mvK9G14twAVU4tBjh34xZJjEgnhrNBC9SK0dct9JPcqB7UZCx8X4JAn35hfDmIDE1v+XDKoo1AXsszFjtHAsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Enr9R5U2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57893Lnj019525
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 09:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrNxZb2huOQDxcBDq9vEBgeyKvEis3Dpfn3A/mVFAjo=; b=Enr9R5U2jRHG/1qY
	xAwRbjDa/z93bN5wnZuSo9+Q5AetTe/yAjx1+te4u6hunpJ571wpZ+l6y7ddlm1V
	R6ADxwPfgeA2tkVCa1r219C3D8YjrOV9nmcRAcM7ZYTROBbeEo5pLlBwEQIL8zmN
	0NdM7WVOdLfXnLz1SilT59rTLCu2XtBhtsXk9EE36X7hlrTnhelZt9hE3gKKe4g8
	sfnYAET2bhPs7t0dahEqafyhROtHuM8kUVuJbDTzIV5+1nfLhNaCcNlVEaOK24bi
	5mQQpC1IqGcLH7R/C8MjPpC2BTap5UyuC1PM6ESTA4L31S9aDQgYI5mLp/FwieFT
	hCCjDw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8hmsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:54:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b423dcff27aso3479711a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754646874; x=1755251674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrNxZb2huOQDxcBDq9vEBgeyKvEis3Dpfn3A/mVFAjo=;
        b=QX/sbwi3nBJEld0g/P3LMdWEYXmpP0wTyukh9/dxUr68gIjTmS7KRPSs50T3LEgbSX
         ubozuiDvBP5K09x+yFIBAZkQtfInTg8V0S36otD+gUYM26L4zpyflRgZ/UwNpu/oUcUg
         Ve3dEodsZI/Sv2Wjv9YTI9lXpV9Z7RJ8dW1Nkq7EuvM4wQXmJdOuqBHavJzRcqmLlodt
         qzb7nbBsURg86Q9E0qBdCU1OME4xb803SUAZqAxu+4GPkvilMrupCbTDP+YbdIdXv1KY
         1UBe0dw9+8kf3AIafWhlrysv/G73+kCaYmMkkzRjo66o4MpEOjoXNfOeoqiXXtZ6nM5K
         j3lg==
X-Forwarded-Encrypted: i=1; AJvYcCU2+rylZ74tMuw0j87ptMOS1KR2ffQaH7vjXXmIWb6etaiku3NpuTR3xA9QMEz+rwbk8vo0E90ejbCNeT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkZUML/yzgLYq5NNaNPClCZ10htr/JSwVUYccl9FZXqBkkZN7
	k5HkP8Hnc7R1F/6E1IpfkOvARsC3x25IKSSHhdg09no6MGaPBSGmCysd78FDFGrYRzEkEhXpX3B
	jHXXERTBuV2dW8aTtE7li++bS6E8HcS/673dVbmqu4hyHzO2CHSYIZuG+oSmOC56dyIE=
X-Gm-Gg: ASbGnctHwXbK7RjkdZhB41JPbF3JrYqkX4p9xG9YSBMtUGNber0wuP3u6o3E0+0w6a7
	mEqv+P7BeuUH4B43AUzJF0Vw0DLffP4Dj0QF2VMH88jGxH4v4IJKJRDK91eu1FqCKBXdVddanhT
	oYMijJi5EUBoyG+S030gE2BZulUtvdABfQ/im3rLuboVtYIyuF9G38V8/faC/19im+5A9oKLnSg
	WXZsw/b2wvpG8yjy3tJ708Lo4GhjGdwdx6pXW2gWNJfrYZf+UwUP+/kKKowatDR78iYwPpwADST
	XRcmmW0NOpmEJw8zAbHhLc5RPD2ZOEsPWxDRf3IJsant6XnLHOpTYoionuM1zuaqpl2y
X-Received: by 2002:a05:6a20:6a25:b0:238:351a:6442 with SMTP id adf61e73a8af0-2405522ee22mr3230469637.45.1754646873875;
        Fri, 08 Aug 2025 02:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMdPYl8Hb5De2uaasmqy64rhr2pYi2WZQYfw282Gwlr2/RoFYRSAeOW9+wrqhGxbXy2C32XQ==
X-Received: by 2002:a05:6a20:6a25:b0:238:351a:6442 with SMTP id adf61e73a8af0-2405522ee22mr3230442637.45.1754646873431;
        Fri, 08 Aug 2025 02:54:33 -0700 (PDT)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6fesm19918035b3a.26.2025.08.08.02.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:54:33 -0700 (PDT)
Message-ID: <d8c5a4f1-a867-46b6-8519-81c0eba37501@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 15:24:27 +0530
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
 <b2f219d6-d441-45d0-a168-b2cdbc01b852@oss.qualcomm.com>
 <3fc425fd-39fa-4efc-bc98-da86a88bfb1a@oss.qualcomm.com>
 <c2f39786-5780-4124-9e41-6971428aa267@oss.qualcomm.com>
 <9e3b4706-c61a-4d69-be84-a5b6fc90eb35@oss.qualcomm.com>
 <462b4010-fd79-4682-b9d2-31ffdd53b75a@oss.qualcomm.com>
 <ffbd9302-75f1-4148-881a-767fa413c825@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <ffbd9302-75f1-4148-881a-767fa413c825@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BhO7t-tINdZZCoGlOr93PaT_3IUTIUHT
X-Proofpoint-ORIG-GUID: BhO7t-tINdZZCoGlOr93PaT_3IUTIUHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX/i+dIs6/7eBj
 EsyKWvqd/aQvvzsMcvnMKfF1AZ6KyViJWqgD7bHY78biFNFiILggugcVaoYrYqPHem8rP4pLNFq
 /a5noFbeaw2TtEOsypG8R/renkGAoN58d0AQk1BEkMZitZ31tZtKYScUzguVSGpjWD6pma2HZO4
 lcoMEo8yyI3C5QBtbX0g3NExy6LYrmh2k1paRTerPYv7nJ/Z9xqRH2OLvXLnySuiTTg3+c8Udox
 rRiAGXW3YFzWjYhtYV+oIkYmcSJW9ahGtHMyJy9XuYanyWFSLR2+0irgbfqk2KANUQ/iW281tZE
 yy+OGhdy6cbJ5vCb6zdb3QIxr9ew0W5HarpBXEKOM9bpd0yDc3FFplWSAsf2E8B+vVMLp1GYAvs
 WtVoHtYp
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6895c95a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=zhkC1EFh2bCrlkiyJb0A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/7/2025 6:37 PM, Konrad Dybcio wrote:
> On 8/6/25 12:21 PM, Taniya Das wrote:
>>
>>
>> On 8/6/2025 3:34 PM, Konrad Dybcio wrote:
>>> On 8/4/25 4:21 PM, Taniya Das wrote:
>>>>
>>>>
>>>> On 8/4/2025 6:40 PM, Konrad Dybcio wrote:
>>>>> On 8/4/25 11:00 AM, Taniya Das wrote:
>>>>>>
>>>>>>
>>>>>> On 8/1/2025 5:24 PM, Konrad Dybcio wrote:
>>>>>>> On 8/1/25 7:31 AM, Abel Vesa wrote:
>>>>>>>> On 25-08-01 10:02:15, Taniya Das wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 7/30/2025 4:55 PM, Abel Vesa wrote:
>>>>>>>>>> On 25-07-29 11:12:37, Taniya Das wrote:
>>>>>>>>>>> Add a clock driver for the TCSR clock controller found on Glymur, which
>>>>>>>>>>> provides refclks for PCIE, USB, and UFS.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  drivers/clk/qcom/Kconfig         |   8 ++
>>>>>>>>>>>  drivers/clk/qcom/Makefile        |   1 +
>>>>>>>>>>>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>  3 files changed, 266 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +static struct clk_branch tcsr_edp_clkref_en = {
>>>>>>>>>>> +	.halt_reg = 0x1c,
>>>>>>>>>>> +	.halt_check = BRANCH_HALT_DELAY,
>>>>>>>>>>> +	.clkr = {
>>>>>>>>>>> +		.enable_reg = 0x1c,
>>>>>>>>>>> +		.enable_mask = BIT(0),
>>>>>>>>>>> +		.hw.init = &(const struct clk_init_data) {
>>>>>>>>>>> +			.name = "tcsr_edp_clkref_en",
>>>>>>>>>>> +			.ops = &clk_branch2_ops,
>>>>>>>>>>
>>>>>>>>>> As discussed off-list, these clocks need to have the bi_tcxo as parent.
>>>>>>>>>>
>>>>>>>>>> Otherwise, as far as the CCF is concerned these clocks will have rate 0,
>>>>>>>>>> which is obviously not the case.
>>>>>>>>>>
>>>>>>>>>> Bringing this here since there is a disconnect between X Elite and
>>>>>>>>>> Glymur w.r.t this now.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The ref clocks are not required to be have a parent of bi_tcxo as these
>>>>>>>>> ideally can be left enabled(as a subsystem requirement) even if HLOS
>>>>>>>>> (APSS) goes to suspend. With the bi_tcxo parent the ARC vote from
>>>>>>>>> HLOS/APSS will not allow APSS to collapse.
>>>>>>>>
>>>>>>>> Is there a scenario where the APSS is collapsed and still the ref clock
>>>>>>>> needs to stay enabled ? Sorry, this doesn't make sense to me.
>>>>>>>
>>>>>>> MDSS is capable of displaying things from a buffer when the CPU is off,
>>>>>>> AFAICU
>>>>>>>
>>>>>>> We can do CXO_AO instead to have it auto-collapse if it's just Linux
>>>>>>> requesting it to stay on, I think.
>>>>>>>
>>>>>>
>>>>>> Thanks Konrad for adding the display use case.
>>>>>> Abel, we earlier also had some PCIe, USB use cases where we had to leave
>>>>>> the ref clocks ON and APSS could collapse.
>>>>>
>>>>> XO votes will prevent CX collapse, not APSS collapse. CX also powers
>>>>> USB and PCIe so that only makes sense.
>>>>>
>>>>> I think it's fair to just stick XO as the parent of every refclock
>>>>> today and think about the what-ifs (such as the mdss case I mentioned
>>>>> above) later - especially since we have no infra to take full advantage
>>>>> of it today (non-APSS RSCs etc.)
>>>>>
>>>>
>>>> When ref clock have been part of GCC, then also they didn't have any xo
>>>> as the parent, similar design we kept when it was moved to TCSR as well.
>>>
>>> Perhaps we've been running on luck (i.e. XO votes being cast through
>>> another device / clock as a second order effect) all this time.. I'd
>>> happily move towards formal correctness.
>>>
>>
>> I would like to stay with no XO linkage to TCSR. Any driver has specific
>> XO requirement should vote for the rpmhcc XO or XO_AO.
> 
> Every driver has an XO requirement, as we happen not to have any
> other crystals onboard.. The clock plan says that these refclks
> are direct children of XO too
> 

The refclocks are just not the direct XO, there could be other source as
well. But I am okay to add the XO parent if it helps the use case on X
Elite and then following use cases on Glymur. I will add the XO parent
in the next patchset.

-- 
Thanks,
Taniya Das


