Return-Path: <linux-kernel+bounces-760008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE0B1E58F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6D31AA44B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92426E17F;
	Fri,  8 Aug 2025 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nE1oFDjz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9C25A353
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644920; cv=none; b=Oj2KjLe2iJT0/NSOg1YB3H5ocVEFqMcbj4pQ2AetamzmVQEEuUBDmK2u0aSs0M8z4+nsjrVVm+m6QazdqFn5cJwiFK3RaLuax4UTuyqRo4MpxYAaFDTwexmg53h2zXazODQGQIAlLG0QhaS6vpUpUYubEk4iquIADWv3Pe5YAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644920; c=relaxed/simple;
	bh=+LRvJeJfjFFMg5w+plJD0jeehIK7GSgpPpZ2/CDxvLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUXLyf8zd9uQiPeSVlXxqN08gkBzLlAe45vcE64wkXWi0IUtn9ze8cv0rgoj6Rbz6FhRIxMfI/3N7c48pITA+BsCwO14UJ/TlRZ3EbW714gmtMPs5V/A7MEf+BUW1R5y1FmkMgJ/GB5g9HeycFgz/Yn9d3p71aSZXvDdWMsArWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nE1oFDjz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787X2xg008443
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 09:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zLqDCDW47C/rBLkuL0CDYXX3PXQC6B7lLgRqBiiYRmE=; b=nE1oFDjzKsd9bkN/
	BVedQP/mKeYD+w6+XSyAWpH0OIaq+aqnQa8ok1LmdnGXCE0ttNeXC+wmapu0wLvd
	m0mPm8HtdFAndd49h/hl1Lz/UEoEnESg1QuAtW3SPXNcConYgEh5libkcNFIjdwE
	7qCjl19kI/T/sdUh1vTlpTLv3XkOP4jfcoVlFhqUG2mk/41j5elyqrSUwoCU6W2F
	/XVIEdnQf17MsFEyiWNDuS2BV9tB8dYCCIHAJ/GCSz0kWRO76XwlREniSY5K5ccL
	BkU/NP3p/mubqwaF+x/IL0i+u8pHWkYfon7075034Jgsb5JDn2Mf4eeDAB/MYgwu
	5VdJdg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u26h1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:21:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3214259ce67so2666674a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644917; x=1755249717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLqDCDW47C/rBLkuL0CDYXX3PXQC6B7lLgRqBiiYRmE=;
        b=t3ghM0t3zqcFBvmi8ijlumXTGUyTOYvT6dUd43U663Ku9HDUlWuzfq7a+uwuRu7XEr
         vtmRepXTyqUd4UblHyr3jy3pZfI/w0rXOkSgULk0whvsnlD9I3Yv2fufCyO8TKsrUpi9
         8iuwej6xlg+Y7OIfAjbFxDjtlRCLCaM4SQf4zM4XRmQSlUCnqOfdXfrQzHmmPF+2Ucvs
         DuadCJzzFifIm2TcVecY+s6HxkyMexhHmYshxO8JXhapFA52bov+oYgEwwi7wR67+GGw
         ZPkyNRKk59b0ysxi3NSyMrUYHSepADj0yfGxWtbV1uPIOs916UeqKpoM9bVrBe3Reuv7
         YjBg==
X-Forwarded-Encrypted: i=1; AJvYcCVySxrH7yfEkiaDDgb+/WA2LMO7mGCydCg/DIMTCMmZSifh+lIseO26/JNlEsGdXiciNV9sJBk0woJglMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuWvExrLZmNvq4nZkCN/oGKi8v/l6IgF/gA2jojVtnw614wS/
	6C0y43A2LNpzde1+zAPdjt8Zb1bwq7PFSWhHr4MIFily/lfLoaez2aFEPdE0dLU9PuxS5hfDo8o
	+WJ6u4c4XPC1BriDuZSD23VBkA06+R88FSMZOyyMXo0xqXG+Jg6cN8iS9RjmRDuOcPBw=
X-Gm-Gg: ASbGncvvZmEQJzC7Pu7KEEYmDCXF4VzXc0dsKpU0uWgcoTdonb2x5GoRwTnHeACzKpP
	Pc3MYZLfubxP0AOVGqrEbZGuaQEWemkF03a+kTu88pz0LnZIU55WmXJ0hkt4z8/af8ralVJEA/0
	xnO/ypUfOK2y7fNuTlcGkQj5yKRyNcbUTK3sxjS7lAwoszm7X1Er3I/Zc80OpTXF+VOg7Agd6bJ
	2Zfc84i7A4Am+7ZBoc1f5UZKu8BTkldLh87AOfFASLquEi2aE/+5qAC1CqaN3nKS+R8I9OPQkwz
	OB6fiEiFVeZVqJMEMy6cM/jiipEDAzTwrpEFYvENJdbzuakQJzp9ji/OQKrB9opeb54=
X-Received: by 2002:a17:90b:55cb:b0:31f:ca:63cd with SMTP id 98e67ed59e1d1-321839e9a33mr3492809a91.2.1754644917290;
        Fri, 08 Aug 2025 02:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4uXTfQa1MeL3UI0IGJQ6NZ1M0GNenD3TaPrzwHHNOEp7HbRnfFH/NMIAJMm8cm52lQHbQIQ==
X-Received: by 2002:a17:90b:55cb:b0:31f:ca:63cd with SMTP id 98e67ed59e1d1-321839e9a33mr3492757a91.2.1754644916703;
        Fri, 08 Aug 2025 02:21:56 -0700 (PDT)
Received: from [10.218.30.152] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm24531355a91.6.2025.08.08.02.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:21:56 -0700 (PDT)
Message-ID: <7c1bd3d6-159f-4269-a22a-34290f1be0cf@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 14:51:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <d0871d6d-7593-4cbc-b5dd-2ec358bda27a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iu54yLGlY-FBlVwTxvK7s9RfZNa20aMB
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=6895c1b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=wbLa1xrU48ZvrQgpvw4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iu54yLGlY-FBlVwTxvK7s9RfZNa20aMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX1vbdhQ9c/B53
 p0j/1Cdd12hjWMV+0n1K6AEW1gyKWncocykcIgB7AMnB+bN5dsw6q5cwVzwuA+Uq/f7xvBEbUs5
 K5SWc6oZn9/37/aMI9V1e+dr00R1olqGh/RY05OOdZamkUpiofNbYt0cv/gcMpvI+29xm0XJ32p
 LVa/46edkFc1OwYw4v76XWWJYXU7PeaANzeMrULsUgqjw7xlk5ImkkR/2luG/CWf/n3CWkN9f0r
 Bl5nG06KfeSHwC54Sfgp1q6eoGSlhxXIY17hEnRWfx6Z9/HEhrwSqAROk3C/MkUnpZvTKxtb1JA
 PqgmWIikm5GAGm34Pxp27uEtJWcdRW+VIcoynw3d9fId9K5T0dLA6/4Iu+lYA4Fbec4VwUTQJWB
 yfZn2IGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090



On 8/7/2025 10:32 PM, Konrad Dybcio wrote:
> On 8/6/25 11:39 AM, Taniya Das wrote:
>>
>>
>> On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
>>> On 8/6/25 11:27 AM, Taniya Das wrote:
>>>>
>>>>
>>>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>>>>> boot. This happens due to the floor_ops tries to update the rcg
>>>>>> configuration even if the clock is not enabled.
>>>>>
>>>>> This has been working for other platforms (I see Milos, SAR2130P,
>>>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>>>>> seem to use non-shared ops). What's the difference? Should we switch all
>>>>> platforms? Is it related to the hypervisor?
>>>>>
>>>>
>>>> If a set rate is called on a clock before clock enable, the
>>>
>>> Is this something we should just fix up the drivers not to do?
>>>
>>
>> I do not think CCF has any such limitation where the clock should be
>> enabled and then a clock rate should be invoked. We should handle it
>> gracefully and that is what we have now when the caching capabilities
>> were added in the code. This has been already in our downstream drivers.
> 
> Should we do CFG caching on *all* RCGs to avoid having to scratch our
> heads over which ops to use with each clock individually?
> 

Yes, Konrad, that’s definitely the cleanest approach. If you're okay
with it, we can proceed with the current change first and then follow up
with a broader cleanup of the rcg2 ops. As part of that, we can also
transition the relevant SDCC clock targets to use floor_ops. This way,
we can avoid the rcg configuration failure logs in the boot sequence on
QCS615.

>>
>> We can add the fix to do a check 'clk_hw_is_enabled(hw)' in the normal
>> rcg2_ops/rcg2_floor/ceil_ops as well, then we can use them.
> 
> FWIW this is not the first time this issue has popped up..
> 
> I don't remember the details other than what I sent in the thread
> 
> https://lore.kernel.org/linux-arm-msm/20240427-topic-8450sdc2-v1-1-631cbb59e0e5@linaro.org/
> 

Yes, but as I mentioned the new ops looks much cleaner, so wanted to
take this approach.

> Konrad
>>
>> AFAIK the eMMC framework has this code and this is not limited to drivers.
>>
> 

-- 
Thanks,
Taniya Das


