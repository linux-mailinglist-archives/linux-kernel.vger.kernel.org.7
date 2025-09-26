Return-Path: <linux-kernel+bounces-833847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19CDBA334A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B417F1C02DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7029DB99;
	Fri, 26 Sep 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KfX8SaGR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561129BDA4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879681; cv=none; b=TuCL2yzWd7aDS1Bglq+1U/5rkSw+YDOFV5BkTtnSeAluCILSwU923+g3DHZgYwhPgYPtGJPpYQQmMLXZhorpN/1i26adlNDx6KRZd0kMGiEzPYzSZ0OK27PNPrDeWuPrJvUsi0qkWM/nGckHKUah5H+eIlVXk2CePStvoT2N9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879681; c=relaxed/simple;
	bh=pgsPj5JFVxG8IVuvZQjPRHJ4A/JS9MuzRCbUekOi+OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDdmg+9RXw+IYkMg8RD05gd0BENuLaXun5dewxiLYd0TLDmJAuZaeo+HTKLI/PWa6RbzpfGBsM+VA6L9it7GSzNxC7zuONWXq4SwHiAu6sC/NNtR6F/aSDTYmfqcHu0pADjd43S79oDznCqeO1RDnKBnHmZAwyXdlwQHFEcbcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KfX8SaGR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vYpe001499
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ka3cnxbDpIJI+JEXC53b6wHr7c67reoYoRjFINA0VTc=; b=KfX8SaGRmrmxpH69
	bmu1D7abRshuLS22O4GSnKn50JRePoLBx6bb4CpmmYdkgkYEyWyiS34fOBoDJKrA
	EbBRtFf7LpFYe8oZ4yJutwXFoKSrcJfoFR9BbLoFsjpXJajFhUxefH1dvpyBi3em
	r5CJ0uCYT+HQjC+ODXJsL4lG3SAmX4OCydXmyf0QzahV0kNERA6b1gKH1IrY9Ooc
	ZD93y9Udz8KgY9UPCLV6DPjE4L/Kab366NJNjY4/tl4jbuvtwTAmqOJ2JWucSg+z
	l8j9CYTEn2blsdyBfY4RnT4yXYalvCrVc/9tImpRbRsDJekTu0YLbli1CVSZ6S9w
	EghL3A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0ttc5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:41:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b554fdd710bso1475571a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879677; x=1759484477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ka3cnxbDpIJI+JEXC53b6wHr7c67reoYoRjFINA0VTc=;
        b=wLODaK8CgRkj4iCMVjyRNOo7XffvwhHBr0MHBNXD4BsYGKokHnVGBPfEyE/vv1hTZm
         PMWXXSdraWw/fyHAHLjGrfWu8HD9hEYO+Xw9TE5LiEyGHmkdp6pjZKJ+Y3taNTN3MMIP
         SHc8BalzVcA2IEjf16iwcTDRO+WwmOSbZ3clj+RFdu/80jpsPbtcsFELpxw85TnYWYLZ
         NVXcnN2+hreZhwHo5TPe44Pu9t6uskENPD67S8uqpeJqfFHi1htjxiUSbQbDZWV6lbMt
         glu2bSIWFCs2Sr8P+5bO/byW2pNaEaXihw8SW4rykq4v9iRvPQ4FwIlvZx81EtK+yIsG
         7gfA==
X-Forwarded-Encrypted: i=1; AJvYcCXopy3fVzK3vLXktgHwno+GqlVxEQ0ZGmzYm+QMzmDLnEpPKgorgckt2nlKbDC079jJXiq+PnoqMVbGB6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuNvi5JhhKsBiqihmTxChlVrRGCUZo83lWHR+TK+4OR29CZzxw
	kj70Av2ruTjOE6aTA2tQDJ7dPutRET8wlxjGbK4Yt6pEHSeczhIPmJtXuKQqlU25fzuPGYOWzRz
	bOW8rFb0Z/WrxU4ow+q3qF0gk2KwMhLOwDUIokaaKiddT0smFuOTpOZBak24Sdcr9VsRan4eWXm
	g=
X-Gm-Gg: ASbGncsbWEwfahWPffWgql37Wy3TI7wmDo/v/8P2EqF0bFuzEbJWrkE0ZAi5OVg8sfI
	F45J/MMn5ukssHsHRuMARcZa6ItOtnG8BR8LyZucbwRNg65fqn5wdLEZSSoPAspZmGPKH3ZaJtE
	oQgxKG248VEK/taHv3Qz9NS2SAOoOKq7wPXCL0KoQiTrWDc8Yj6PY7IclwHyd9AajNWz7KKSJgt
	KTv6wSBGJKpbIFBulHqwinLS+LkEWVx1DuLVt77obSYico6MfvsZxihEblHnzda0B8rR6Y+C0xS
	ZVVd5OVYfd2O6nrMLp2m7xnP5Z5KQlnMQ2GEI+HNoRpHXodwJ8p2m1sBEsJdLZCvof/h
X-Received: by 2002:a05:6a21:6d95:b0:262:d265:a3c with SMTP id adf61e73a8af0-2e7ceeee4a2mr8883836637.32.1758879676972;
        Fri, 26 Sep 2025 02:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuz5klMcIvb3MrZNi4OCbe3f77NecmpBgpEJ6NFqmrwZg1RuNb9Z/s7sKtMM9LiBIcoSu0yw==
X-Received: by 2002:a05:6a21:6d95:b0:262:d265:a3c with SMTP id adf61e73a8af0-2e7ceeee4a2mr8883796637.32.1758879676491;
        Fri, 26 Sep 2025 02:41:16 -0700 (PDT)
Received: from [10.217.216.188] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c559fd56sm4251511a12.38.2025.09.26.02.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:41:16 -0700 (PDT)
Message-ID: <8b74581c-9f74-40ef-8fad-7e172dc303d9@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:11:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
 <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
 <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
 <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
 <db8241b0-1ef3-439e-8d74-a3cb86b610ba@oss.qualcomm.com>
 <d0871d6d-7593-4cbc-b5dd-2ec358bda27a@oss.qualcomm.com>
 <7c1bd3d6-159f-4269-a22a-34290f1be0cf@oss.qualcomm.com>
 <uuhcud25gcbvogpyywmuv2rn6fq4ssns6x2u22a7eqjknf7oes@kvdrw3iqqkbi>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <uuhcud25gcbvogpyywmuv2rn6fq4ssns6x2u22a7eqjknf7oes@kvdrw3iqqkbi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d65fbe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=rUtaezTdWwXcHsiEHkoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LkXXbapwQ0sxYWPk8zKWmK_NnnTUqzVB
X-Proofpoint-ORIG-GUID: LkXXbapwQ0sxYWPk8zKWmK_NnnTUqzVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX5xGQxmlSqwxh
 yU5NUpSyBZxpSsro0VOyoQZTUODtNrKUiHq1SyRW/F0KgVzyly+xT7NedGvrxBzfd0nXk+48I5J
 hbzfQri/r/MR862nBpLO//m19d4fULKN9/DYhPAFPTmdqYiJvtVRlkC3vejUgnk03xSjFPkYUqJ
 /SjWKNBz6UK0hTDWKaJvBdRlFiV9mXMNay2WEBG/WAfiv8AkfJdKQYlOfQ7HaNtVjF14TmCzDgQ
 12UTRBKWJxdnGI2qNLYZjqUWMhko8RD2e9ntWmOvMBoGfv/y1WJ6hn8ochrrCfDxyyMe+iXRBY2
 sB/OKlJx1u8jyrTrLjY4gfocV+klIn1fJol3pJDcArGTUjp3mTpd8yuQk/zlfbzl/+gVSHejSiz
 C/gxXm/I7MpkTWaKiuPWCeQ0EEp9zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 8/8/2025 5:48 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 08, 2025 at 02:51:50PM +0530, Taniya Das wrote:
>>
>>
>> On 8/7/2025 10:32 PM, Konrad Dybcio wrote:
>>> On 8/6/25 11:39 AM, Taniya Das wrote:
>>>>
>>>>
>>>> On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
>>>>> On 8/6/25 11:27 AM, Taniya Das wrote:
>>>>>>
>>>>>>
>>>>>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>>>>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>>>>>>> boot. This happens due to the floor_ops tries to update the rcg
>>>>>>>> configuration even if the clock is not enabled.
>>>>>>>
>>>>>>> This has been working for other platforms (I see Milos, SAR2130P,
>>>>>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>>>>>>> seem to use non-shared ops). What's the difference? Should we switch all
>>>>>>> platforms? Is it related to the hypervisor?
>>>>>>>
>>>>>>
>>>>>> If a set rate is called on a clock before clock enable, the
>>>>>
>>>>> Is this something we should just fix up the drivers not to do?
>>>>>
>>>>
>>>> I do not think CCF has any such limitation where the clock should be
>>>> enabled and then a clock rate should be invoked. We should handle it
>>>> gracefully and that is what we have now when the caching capabilities
>>>> were added in the code. This has been already in our downstream drivers.
>>>
>>> Should we do CFG caching on *all* RCGs to avoid having to scratch our
>>> heads over which ops to use with each clock individually?
>>>
>>
>> Yes, Konrad, that’s definitely the cleanest approach. If you're okay
>> with it, we can proceed with the current change first and then follow up
>> with a broader cleanup of the rcg2 ops. As part of that, we can also
>> transition the relevant SDCC clock targets to use floor_ops. This way,
>> we can avoid the rcg configuration failure logs in the boot sequence on
>> QCS615.
> 
> the rcg2_shared_ops have one main usecase - parking of the clock to the
> safe source. If it is not required for the SDCC clock, then it is
> incorrect to land this patch.

Along with the floor functionality we require parking of the clock to
safe source for SDCC clock. I am reusing the shared_floor_ops introduced
recently for SAR2130P explicitly for SDCC clocks.

> 
> If you are saying that we should be caching CFG value for all clock
> controllers, then we should change instead the clk_rcg2_ops.
> 

That is not required for all clock controllers and which ever clock
controller's clock requires it we use rcg2_shared_ops which was updated
to park the cfg.

>>
>>>>
>>>> We can add the fix to do a check 'clk_hw_is_enabled(hw)' in the normal
>>>> rcg2_ops/rcg2_floor/ceil_ops as well, then we can use them.
>>>
>>> FWIW this is not the first time this issue has popped up..
>>>
>>> I don't remember the details other than what I sent in the thread
>>>
>>> https://lore.kernel.org/linux-arm-msm/20240427-topic-8450sdc2-v1-1-631cbb59e0e5@linaro.org/
>>>
>>
>> Yes, but as I mentioned the new ops looks much cleaner, so wanted to
>> take this approach.
>>
>>> Konrad
>>>>
>>>> AFAIK the eMMC framework has this code and this is not limited to drivers.
>>>>
>>>
>>
>> -- 
>> Thanks,
>> Taniya Das
>>
> 

-- 
Thanks,
Taniya Das


