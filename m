Return-Path: <linux-kernel+bounces-846246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55625BC7600
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8DB4E995E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B2255222;
	Thu,  9 Oct 2025 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4m0yetK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698C25393C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984090; cv=none; b=QVXZyLb40YylVdXj1nsNRpdX6iTiUL82FTbkuiaXRb6FToSLGhYs1de2zUJQ3ka1rP+qpA8KbG+FaRQFDFPmejTByhFpdNmKkwWDhA64zqBm6wBXrtwKc3ysPLOKxpub+fc+nPisMyjd+9zlRnFEY2gRjs/sy941xmyDWIpFywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984090; c=relaxed/simple;
	bh=5LKZR964qF1tqqKMQ1XKf61nAvIcgx5jZSFPvsHzIiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usCoO82vddhtylr3CRkYICW/4WDzNP7RkjBZozlNQZMlDvrNCkK6c1+MNjVUytvdAphyiMGDiFudIj3/qoARaJF7y/hMXk8jX6v9A92+C5vi2CaFEqNRG/GAffd7Gj+xWLWn1qTKTTiAygLX7zfTEbuEPghVqbs8JCU7M6RcG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4m0yetK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Lvo028500
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 04:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KjF7T1Tx3ntljZSUzCCrJKlBbOboX1xFchW8ZOMIbbA=; b=g4m0yetKYb6eiVyO
	220gyHV3dapXUYOMD++nkELYEL8UBki4o5lmF+2+/aeo0hJF79LZKkShA5vvicDH
	J3vjCymnVcEsClt8gw5mLByR8AW6EhhdN0nLHEPMWFY/Udqu+gAoANW6JBFDrIXA
	nBTKsRLPdrY6mrkmEBjsBBkFAOjKOV1drS0dhj/7LrIwCDgMjc7nS06hq6mYMCEr
	CukS2jh+TRiTf2zha/Owp7h/D9J1Cmqv14SXKRsW+qMDh3rHhvOHJ1C0Dc3kCYYL
	oroGvS4x1PedinNzxFRYvAtschSVthH28CWvHhBN0ORIaEWWDCTXzl8SyOjakNsq
	CG1Y5Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u1dm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:28:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-792722e4ebeso750925b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759984086; x=1760588886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjF7T1Tx3ntljZSUzCCrJKlBbOboX1xFchW8ZOMIbbA=;
        b=SLhTveObAutmUq1ExJqBRgwQyIZyKj0ZpDx16jR48EtVFzdwRnk3CCnRb68UELYu+w
         4/akYufYiKtQ98HN+2R0ozDF2u8hdEhDIU27COMbkZBzVqsMjgRGXbhMB8ZfLc+OIxNo
         ciqOfCIo2m76WHDMzP2uXWd7eqd/HM10FBmghGtwFVJ0gO+0PP4CaGHciDRJbyBmVUtv
         X5pyUu6yMCZmBga8eeyfRf2N4jsziDEj3BfdcZCHqaUoeZ0Zk0nNHGx2LOJLznN00kYM
         Yr07LnuB9rEn7r0HYcatUhY2wvIHMMb+uxvmdo68b8S3kBu+KWOL6bHjjylztobNsZAg
         kaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmIxWMNGUc7vP8sOCrV7MUw/BC/4AfzmLLb4J+0reb8fKjdmj35YVcWnRfIhS1rpn/HUZ0Q8Js1ohNwtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjD2ynZYH3nE5Dhu/1gTWGm5mP1uf641DrE8AG2AXQvczabBbR
	0Tlu5dDApdImO6FPrfT7ZHX0zgFpL5LGx0PAEmHJ0I2ThJhL9+kt0I88HQ8TgB+HpyWEQhFRcl8
	pC4icJncHwio/jDFRYyj7mJ0wn4nE8dHu93Zuxl4pOKR/hCqw3ul0n8S7LLUN4BZGCw4=
X-Gm-Gg: ASbGncv3qvYP1mt4J3iWH1wYtSMqA8/ar+pU9V4DrilxRneDrjBZNrmJfRtHHNlfjof
	Q++OgUqqyQhTaQJteK/lXalpiKvdfZNgy2Jm5ReBrzGax4FDCvnWR5XAtNC3bMQn/toYGzLd8lA
	+rlka+RCsjdiXjzHBSP6eNntaGMnB8otuB1IsIeYQfDpmdjIBAiGesDBREWHcJNtsvJLKGVk4RU
	8YDEJUpBBaytH3Jj+5azQnUqFR11JIWcm6O59tDZVjIwidtuw8Pcqzs8+RBG2mQDxSwaf32pUc/
	m9gl5oyXTgGU4lX3aE3FPVDvPxrU+XdBQxJLefYytxg5koCtP+SGSe8oe2Fzw7glT08D+nwIpw=
	=
X-Received: by 2002:a05:6a00:180c:b0:781:259b:b5f8 with SMTP id d2e1a72fcca58-79385ce2732mr6935743b3a.13.1759984085878;
        Wed, 08 Oct 2025 21:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp4Mlygenihf4ZZNihEkKshtN0G9bMPBW+kXdOGmofWdq49Xzh9rp9BWkzOt3KG0PX4wIiZw==
X-Received: by 2002:a05:6a00:180c:b0:781:259b:b5f8 with SMTP id d2e1a72fcca58-79385ce2732mr6935708b3a.13.1759984085356;
        Wed, 08 Oct 2025 21:28:05 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794dbc5af5csm1369053b3a.52.2025.10.08.21.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 21:28:04 -0700 (PDT)
Message-ID: <4023c6ba-7ff0-46e0-bb09-a0cd864441ac@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 09:58:00 +0530
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
 <7c1bd3d6-159f-4269-a22a-34290f1be0cf@oss.qualcomm.com>
 <uuhcud25gcbvogpyywmuv2rn6fq4ssns6x2u22a7eqjknf7oes@kvdrw3iqqkbi>
 <8b74581c-9f74-40ef-8fad-7e172dc303d9@oss.qualcomm.com>
 <5ba5fb11-96ed-41bd-ba21-f30476cdd570@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <5ba5fb11-96ed-41bd-ba21-f30476cdd570@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BMW+bVQG c=1 sm=1 tr=0 ts=68e739d7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=V5i6IHx3lcjPL2KBWkwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: bBlhNfvMauF5fuB0Uu4mWlJ5iZz47GLp
X-Proofpoint-ORIG-GUID: bBlhNfvMauF5fuB0Uu4mWlJ5iZz47GLp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4zcjn0xmZS5p
 vCBaPCKsIxAUkSwtYXQ5B/jW+G3OvBpJ715sdpdHK0ZdyP9TSLakbol1XLbIIZpAKuhwf3xJxiA
 rH6NwtmlbvGoiUoQQ9rj0etLLMtAkzaRcLs5sI6jBrhSCo9erU6QwrWJG9pOCUZBP1HJMLPg989
 NIfVREW9KEYqm5kQ6ZQVVi3bvzHA3p3YTt5MlN+YgcBgYTrehoSq8PqAHVF9d2YZJ4rAjNXx5Wz
 d3XsOM7RNfcnWDey7WFqIb2iWsouU3FCGczZkIJmyC09HCa5OAJbi4ECxECRRyJv8oYFsyf/Vql
 R1/wulmx1MenWuNg7vUIpRGO331Wil/ySE68v7eRSLw6togW9VBURq2AqY5nf7YDSHKhzIJtAWf
 9U1mNy0QHHuIbMTYbTqaWI8cOK5Ybg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/8/2025 5:56 PM, Konrad Dybcio wrote:
> On 9/26/25 11:41 AM, Taniya Das wrote:
>>
>>
>> On 8/8/2025 5:48 PM, Dmitry Baryshkov wrote:
>>> On Fri, Aug 08, 2025 at 02:51:50PM +0530, Taniya Das wrote:
>>>>
>>>>
>>>> On 8/7/2025 10:32 PM, Konrad Dybcio wrote:
>>>>> On 8/6/25 11:39 AM, Taniya Das wrote:
>>>>>>
>>>>>>
>>>>>> On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
>>>>>>> On 8/6/25 11:27 AM, Taniya Das wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>>>>>>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>>>>>>>>> boot. This happens due to the floor_ops tries to update the rcg
>>>>>>>>>> configuration even if the clock is not enabled.
>>>>>>>>>
>>>>>>>>> This has been working for other platforms (I see Milos, SAR2130P,
>>>>>>>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>>>>>>>>> seem to use non-shared ops). What's the difference? Should we switch all
>>>>>>>>> platforms? Is it related to the hypervisor?
>>>>>>>>>
>>>>>>>>
>>>>>>>> If a set rate is called on a clock before clock enable, the
>>>>>>>
>>>>>>> Is this something we should just fix up the drivers not to do?
>>>>>>>
>>>>>>
>>>>>> I do not think CCF has any such limitation where the clock should be
>>>>>> enabled and then a clock rate should be invoked. We should handle it
>>>>>> gracefully and that is what we have now when the caching capabilities
>>>>>> were added in the code. This has been already in our downstream drivers.
>>>>>
>>>>> Should we do CFG caching on *all* RCGs to avoid having to scratch our
>>>>> heads over which ops to use with each clock individually?
>>>>>
>>>>
>>>> Yes, Konrad, that’s definitely the cleanest approach. If you're okay
>>>> with it, we can proceed with the current change first and then follow up
>>>> with a broader cleanup of the rcg2 ops. As part of that, we can also
>>>> transition the relevant SDCC clock targets to use floor_ops. This way,
>>>> we can avoid the rcg configuration failure logs in the boot sequence on
>>>> QCS615.
>>>
>>> the rcg2_shared_ops have one main usecase - parking of the clock to the
>>> safe source. If it is not required for the SDCC clock, then it is
>>> incorrect to land this patch.
>>
>> Along with the floor functionality we require parking of the clock to
>> safe source for SDCC clock. I am reusing the shared_floor_ops introduced
>> recently for SAR2130P explicitly for SDCC clocks.
>>
>>>
>>> If you are saying that we should be caching CFG value for all clock
>>> controllers, then we should change instead the clk_rcg2_ops.
>>>
>>
>> That is not required for all clock controllers and which ever clock
>> controller's clock requires it we use rcg2_shared_ops which was updated
>> to park the cfg.
> 
> I think Dmitry just wanted you to confirm that what you're doing in this
> patch is guided by the necessity of safe parking and not only to enable
> rcg caching
> 
> Konrad

Yes, that’s correct. The primary motivation for this patch is to ensure
safe parking, and the RCG caching is a secondary benefit.

-- 
Thanks,
Taniya Das


