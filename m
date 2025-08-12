Return-Path: <linux-kernel+bounces-764162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDDBB21EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF168698D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7272D6E69;
	Tue, 12 Aug 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cOKTe4tL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870E2D4809
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982250; cv=none; b=F0ny7a+Oj/Rfe8oln4I61g6XPhiREPivgZCUDf3qPhyQbzwtqIJhQwFT8przDtbq7+cogWQZfZDnrfr+x456lcpYTwiJZCIMKvRXwwPl/G/YlSL0R47gtaJeA29/vmckYAKQl8cdcFQiljCaNDy68ExRdTWQvKN8C2UlmCcWFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982250; c=relaxed/simple;
	bh=SeQ62bmZfam91Oav+2opoIAo/S3/fQamah6X6vhlZQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eInvSsktJDZKpZAiJUQYHdZznZH1x+OqA1G8QAhfIYuDITH8pOjR6esahn7BxVcbjUhV209rKv37zms2PqLwCcp70wdGoD164UzHegoqdwzvRdn8FcKT+KCP8iTpO6vE35+eXYZk9QNjeavKxon7I81pC/ojG8a8E8xgc04SXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cOKTe4tL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5XUK5029204
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mV/eefy0c2LWvZ2MBX9aTUa7zNPhALNcsIQu9WG7amw=; b=cOKTe4tLh4hgEZgN
	NiFndJLjrITvDbwaOLCSJ5JW9Q+Dp0pQI29IEcPli0z1XNcoaJb9Zbchk28bgzOV
	9v+Q1fbm6BOrIkk1TCnOT/wovin01acpLFM5ldjkgnnmdVD3jXibZW6eLU0jVyQy
	UPPIu8zyvxPh9Su6u+hPa3mXRpiTZNwxZgIQH7mmBAyJQzXAk6mVfI+qaDPe1gIF
	BzvYSH8ykAXqJwES7eEafRrS7WMGyc35JGgwUim+7gV+Ud+fiptt0mJgOERvcYtD
	T48n1tYzFJtxfcv4EGpKiihMO6ORxNvlrTQFBwP+tVhGt8GzLUoL4MZJWKQhils3
	cZdCig==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sqavf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:04:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fe984fe57so80830855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754982247; x=1755587047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV/eefy0c2LWvZ2MBX9aTUa7zNPhALNcsIQu9WG7amw=;
        b=E+rSatIbOGIDyzQFN8q5oAxqC51/8vACybqlvfIxmX0YiuRx64GtugSvuGWCHazux8
         d3juQcA0OX3628CaHGbIS/gk2oW2P+/hvKCRK9mFMC0w8InFhbnhpkIrkSQcdGhi1rQG
         Il9DKwDK8tqdIwgL8VSmysI2fNKdhFeW2u+nco5IkFYJ7RrTvofOmaRgwlR45N0z6fUB
         bV5D0THdh7e4YFnt8NJMbgD5bV0lwcm8ydfwNfhf7/80qtlXTn106U+y/qQJD5IPgJAA
         fVfCs5+M5+ibOdlDYDcTQyqnMyLlItnwftDcDBPHh0KbWxROtiPczr6Is2kiv2xKRhAl
         gL5A==
X-Forwarded-Encrypted: i=1; AJvYcCV49QXgcPxXGOMZWmakrQeto94XRSHsfzg5EooQiKKzgP23nk3xcFxRox1GX97NgMgtA3i6TF9b/280WOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk46jF+57NTI5ERJRgXZaoVT52wInG9mltL8xk4IsJjIRCe22I
	G9kc8kjrqKskCqs6zLFHIlqCXzhb/Glo4whenPIXCoZVg8jTNNMbInPXG7+E4UwysjIwP8QxnCB
	jFhtmvl/ObvQjkycsnUIzh/75eVsegfSaFSRDixdPQYFiAzYx1ClQg1UX5W6gRPoI27g=
X-Gm-Gg: ASbGnct/swJyNRZNsw0NG3jWARvRINZlrN7aAccUallZJ0mjGoFNELZqiyS4QawbE7I
	BAYj/SnTq89xc9wXHh/bZyc3BhBrYxHj7ViPOQml+5ogHf0/BkM3xVoqic0SYYuyKeA175yRS9a
	rQkQ8jLjcf9eLdJhnU0sUHSaoJTGoA568P/AmJbENGGLshkfGwt9s3yDPfDyJBkJspN19D4HuKO
	MKcyN+8IRq/8lRyAU/aW0AojltEyxikiZ+ljaNbQWu7yNHLWp8sKncNoeTm5/Uszy8SvZTpDmeo
	MT1yzHcjz2CSlRrkFw9gc2A8Ly8kR7aR9cNhdZ0WUPbyf3Ozm+Z0GaDJTDcfXHHoTWC/
X-Received: by 2002:a17:902:ecc1:b0:23e:22dc:665c with SMTP id d9443c01a7336-242c21ff9ffmr231135615ad.33.1754982247354;
        Tue, 12 Aug 2025 00:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/1UIN7L4sGlkN3jDrUIwqP0FYBWbFECG0kM5UiwqQaO9PrVZPlbyIJ4bCydXasYvkxNGSQ==
X-Received: by 2002:a17:902:ecc1:b0:23e:22dc:665c with SMTP id d9443c01a7336-242c21ff9ffmr231135295ad.33.1754982246875;
        Tue, 12 Aug 2025 00:04:06 -0700 (PDT)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242b0934d33sm127719215ad.46.2025.08.12.00.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 00:04:06 -0700 (PDT)
Message-ID: <adcdeaf8-a3ba-46c2-af7d-e37bbc5341dd@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:34:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-qcs615: Fix gcc_sdcc2_apps_clk_src
To: Bjorn Andersson <andersson@kernel.org>
Cc: Richa Bharti <Richa.Bharti@siemens.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        srikanth.krishnakar@siemens.com, cedric.hombourger@siemens.com
References: <20250729094943.863392-1-Richa.Bharti@siemens.com>
 <81a1bd2c-ad4b-4042-9116-c1604e4f0d98@oss.qualcomm.com>
 <e54l6omqbop5tlithm7cseldtbcz47sde6fo6wcoxvbordoa6w@l63sxertlypq>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <e54l6omqbop5tlithm7cseldtbcz47sde6fo6wcoxvbordoa6w@l63sxertlypq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689ae768 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=a_U1oVfrAAAA:8 a=bt-eykdaRR2Tth2JHncA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Bwz54oBT7V9V3xUITWzptns_G9ByM3ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXx8r4qxGo18fp
 lOn22+xz8Jq6ihLdcbttBHbMZLu429i/Qc3EbpbX5A4fjrgX//OdHz6n2FMT9RDgL2+8flBnR8d
 pFaHyeSUSZHEiEjQFkI8o0F1hxJiMo0ix9vGg5YJvVaLFt/vb+nOyjEcWhpng0leQoyRSTRmQGo
 TNlo5BJao9bSW9KaEyWy3Ehd4lKZBADKcSh2P6Z2H4+cueOrgBqQmgwFua1mgrp+NFUh+wGv2dw
 Lz5Fgu4n8NaYI8VOHhFgs8KEAoenHkvAZQKqB0zZqmuofjWWkiruWq1SSSR1TKA9VSr2D0dXBDh
 w4CaUbTY3gjRSynTFyjnaKzej7RrjHX+/xbE4TlYg3wnaFW8nUJxVrp/tvd8n2C+mFnKL6UYrYq
 35Cg8bA7
X-Proofpoint-GUID: Bwz54oBT7V9V3xUITWzptns_G9ByM3ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015



On 8/12/2025 9:20 AM, Bjorn Andersson wrote:
> On Tue, Jul 29, 2025 at 04:08:21PM +0530, Taniya Das wrote:
>>
>>
>> On 7/29/2025 3:19 PM, Richa Bharti wrote:
>>> On QCS615, we see the same issue as reported on SM8250 and SM6350:
>>> "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during boot.
>>> This is due to GPLL7 not being enabled by default as a parent clock.
>>>
>>> Setting `.flags = CLK_OPS_PARENT_ENABLE` ensures that the parent (GPLL7)
>>> gets prepared and enabled when switching to it, fixing the warning.
>>>
>>> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
>>> Signed-off-by: Richa Bharti <Richa.Bharti@siemens.com>
> 
> Thank you Richa for your patch!
> 
>>> ---
>>> This change is similar to upstream commits:
>>> - SM8250: 783cb693828c ("clk: qcom: gcc-sm8250: Fix
>>>   gcc_sdcc2_apps_clk_src")
>>> - SM6350: df04d166d1f3 ("clk: qcom: gcc-sm6350: Fix
>>>   gcc_sdcc2_apps_clk_src")
>>> ---
>>>  drivers/clk/qcom/gcc-qcs615.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
>>> index 9695446bc2a3..b281f0dfe165 100644
>>> --- a/drivers/clk/qcom/gcc-qcs615.c
>>> +++ b/drivers/clk/qcom/gcc-qcs615.c
>>> @@ -830,6 +830,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>>>  		.name = "gcc_sdcc2_apps_clk_src",
>>>  		.parent_data = gcc_parent_data_8,
>>>  		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
>>> +		.flags = CLK_OPS_PARENT_ENABLE,
>>
>> This is not the correct way to fix it just because SM8250 and SM6350
>> uses this ops.
>>
>> We are testing the right fix internally and will be posting.
>>
> 
> Please use such opportunities to educate us, rather than just tell us to
> blindly wait for something (at least share your thoughts/hypothesis).
> 

Sure, Bjorn.

https://patchwork.kernel.org/project/linux-clk/patch/20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com/

The RCG configuration goes to a bad state because the current floor_ops
tries to update the rcg configuration even if the clock is not enabled.

The correct fix is to ensure we do that when the clock is actually
enabled which is brought it by the shared_floor_ops.

Please let me know if you still have any queries.

> Regards,
> Bjorn
> 
>>>  		.ops = &clk_rcg2_floor_ops,
>>>  	},
>>>  };
>>
>> -- 
>> Thanks,
>> Taniya Das
>>

-- 
Thanks,
Taniya Das


