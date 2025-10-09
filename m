Return-Path: <linux-kernel+bounces-847101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89564BC9DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0954F2712
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC6220F2C;
	Thu,  9 Oct 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOMlOhtG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5415B971
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024992; cv=none; b=odxR7Wmk+yfcSQ6X8gnq+xgY+G2fvZtjnYMOUforP1sR5F6VngRMtd+qn5qlm4aVKz0t/dsiZzjlpFmUx+5ZvhSmu6yUOJ3PKSaWdhXuwsBmPBpc1M6l26+BzmjloWuV7Y5/V8xn0Fnb5YQdHcli2tpp0QvoM/ErlUnmDzODL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024992; c=relaxed/simple;
	bh=mlCAB0eKwxYNcDGzeoqO8BJSAOKhfByyKqoFzB/0Z2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX7eu2mDA2EWrcwoI3aGB8cYfhP9xGngRYXrJkU2ck2OG/zLdrlRVgk/Vl4eaUkP+zDV+uUpcDmcRtpNNig2wODIMD1GkOjBgAPDvkyDv/hXFGQtFqBysDRXKvzqKysmi1vVQyoCBFcH7lcobkYf4oGsI3tsV162PrTQBAZM7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOMlOhtG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EjSUB029234
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 15:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uSIEO9FcEVLvrDKCwD8f9+MHa+xIch9jA7I3Optg5D4=; b=KOMlOhtGSNijXzLC
	l+ejUhQg62Ov7TD5PhOw5FcLgZXpUwBl3PtcsvM/ERzeixfiODOJ0oSKKCyFEdHB
	0zMQnVhLHoCx7T1SJwZiWZoqWxeAhqcV8L2dYoXlwvgIX91briU2oJF3fBhQ6pM+
	Bp34GVQq5j3vjhc0+2MB7/0Mtg7KAtD9X62O+MP3QtwWW6x7t2H9tw28Lq4LJgl7
	jOzxzjQDFGqeOjDZyc8/yrTzYzu14qyEmUh3fevh8j4y3q5p651344je0rR5lCJT
	EUjn9g4S2oKdKtmsxN3I/9iFwk+/5UEG2mhz8PgItwafvwSawV7DK+o7B8CC7Vlx
	BAk9yA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nkey9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:49:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso4383611cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024988; x=1760629788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSIEO9FcEVLvrDKCwD8f9+MHa+xIch9jA7I3Optg5D4=;
        b=tnxFKfx/lahPxfFl+/8zKhYQAQDHrUE006BjUwYstgE8HKnGnRaQab4KYqWuKm4b9+
         7RYNXccsOX44TIntIPnZpud1q7/LeAmuqmhkFhmwyqDG9ebZL9asopVaIJvv0JnahOPU
         uYGEu/+e/SdBrbeY/Hw71jWyG5IEoBRbLrDB07r4MoqEiEd7pvNPLRJNuZ6d+Eisk7BB
         ua+tNYa0lD6jkWiXjOE8A3OgmyAJMbPSsrGtYY65jfZ5TfvDxzumrCAcH2quq9O0Fq6T
         boIm6pMVFmtf7KwMWerpjQH1djoyPXjokL9cHF7Wnb3vHkiDzWtSvxNNQfmyhtwlZz+9
         PD9w==
X-Forwarded-Encrypted: i=1; AJvYcCW3TEa5kjqXWRonVBIHKU1sM/seFbaWD0lcoDqXFPQMbV/7ehNdnAt0Ab7vnMkxNGemgVN04FCmoVv2JBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKOPTNTeifok+XdS9NiQdqLUQM74FYtmc/ldqUH7U36vwiqfU
	eQAbNf5X+lAx/ZtJDv8/3/g6I01EcydGEHkkndnkMjjS5r7qCLDHhaQ5pxIAe4EeX5o6ArbJ4lm
	5GJpjw8lx4cz+ysuKGeWYDdWV1gRj4O9oUWdj7W4I9HNeRtgJjeOgpPyzvUKkrp7ww2Y=
X-Gm-Gg: ASbGncvBoDHlkeEoWHy1ri9vh9F3EkzBxZZXe1Ilnl/YKFkrUopibpJvwsDPczw4EY/
	TPOB07QySFe5BOmAU31rSgr/YosAasPbBhceg6ex/cCC0isJ4eOXcYumIihD9Or6SsUPtrl/ApO
	nvyrZTA77lJWzrqK1y47vd6WPXsGQz3znbwsW5yOulIZT/bAf7W+A7Jw2LmymJovTTfh0U6b3Rg
	xZDADmpDySxX7kPgdZzESYqkEciALa0kYT/fQDW5RzDB9sgZfoHpy8FMFOYV+66X9rVoAOxeMej
	Fx0EHBTJyKndqJBC5o6ySl57wuBc4tQn1I5Ee/dZqn97h3gFhCUFP9ghbcYTN+cyc9GWQNIfuSG
	O6XP3f8YWqBd+6Mqp0M40Yfi9wcQ=
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr73884951cf.7.1760024988243;
        Thu, 09 Oct 2025 08:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHczPeydFcGNZDFNQ0JbS8P9KYbdiPFB5sssNB27pTfXWIBZDfWM5PA9UPMHckJKQxeckZRPA==
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr73884681cf.7.1760024987729;
        Thu, 09 Oct 2025 08:49:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c124a8sm2371766b.51.2025.10.09.08.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 08:49:47 -0700 (PDT)
Message-ID: <0a0afe32-7814-4901-bfbb-6694cd846257@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 17:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] media: iris: enable support for SC7280 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-8-def050ba5e1f@oss.qualcomm.com>
 <3f1979d4-1438-4c9d-99db-d97a09c5c35b@oss.qualcomm.com>
 <gdui5coiazt5ynuz6c6mr5slau33vuewr55vx53m5zzyi537at@cs7dbgirijuw>
 <1118c126-4332-4f9b-afb8-d3da4fa7fa87@oss.qualcomm.com>
 <um6d7e2su4erqet5fxyaxpyulfrzqvadq4izxgmxu3tol3i7jk@godpxwsqeqzs>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <um6d7e2su4erqet5fxyaxpyulfrzqvadq4izxgmxu3tol3i7jk@godpxwsqeqzs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6vfryI7BD+/R
 /yQDV9MPDckIi2Zo9EW6os7q3OJCiX1BbxxyxIg20bTq03ECruGY+uEWez+liTkqD+GXI42EaXq
 3bZa8fhtFr34UZTT7Bx8qTaAz3o0mOvcJTCiy8O45/YK5Gg9B3eVY1T788Ed7Q391P0YcaaiV8w
 HopaKYeXkH2fPHIWk7s2ZdTs5E5KI9pKU0OXuGj3bJNnwszk6WGiHoOw3WW/paFOa9tvX9xGB7/
 kuhHJ1QVBULUjXxFpojDqNjZcCqm1Sb+wufy9dhXtEwUKgDPa2n7j45Re/XSPjQv0Ia5gmCvdNn
 vOGLBA0S8bN2BpXMY9tjpzuT4djjpxomNXrtvUxz/2q3vpJwafG4/6fOvR/MwQLKVDBRa97g1+P
 GGWt/QLRCUjxdyUxf0jKheiwKyQ/sw==
X-Proofpoint-ORIG-GUID: fEPlS1a90zXYXu3vztja6My5Qu95wvhe
X-Proofpoint-GUID: fEPlS1a90zXYXu3vztja6My5Qu95wvhe
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e7d99d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=LpQP-O61AAAA:8 a=lTMcXo_5zusfKqBCz9IA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 5:00 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 09, 2025 at 11:19:31AM +0200, Konrad Dybcio wrote:
>> On 10/8/25 9:25 PM, Dmitry Baryshkov wrote:
>>> On Wed, Oct 08, 2025 at 10:26:02AM +0200, Konrad Dybcio wrote:
>>>> On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
>>>>> As a part of migrating code from the old Venus driver to the new Iris
>>>>> one, add support for the SC7280 platform. It is very similar to SM8250,
>>>>> but it (currently) uses no reset controls (there is an optional
>>>>> GCC-generated reset, it will be added later) and no AON registers
>>>>> region. The Venus driver names this platform "IRIS2_1", so the ops in
>>>>
>>>> Which we've learnt in the past is "IRIS2, 1-pipe"
>>>
>>> Well, I'm open for better suggestions. iris_vpu2_no_aon_ops?
>>
>> [...]
>>
>>>>> +	writel(CTL_AXI_CLK_HALT | CTL_CLK_HALT,
>>>>> +	       core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
>>>>> +	writel(RESET_HIGH, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
>>>>> +	writel(0x0, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
>>>>> +	writel(0x0, core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
>>>>> +
>>>>> +disable_power:
>>>>> +	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);
>>>>
>>>> ..for this line
>>>
>>> Not only. You missed the absense of AON_WRAPPER_MVP_NOC_LPI_CONTROL /
>>> AON_WRAPPER_MVP_NOC_LPI_STATUS. Which in theory can become a flag in
>>> iris_platform_data.
>>>
>>>>
>>>> but this could be added to that one instead, since both clk APIs and the
>>>> Iris wrappers around it are happy to consume a null pointer (funnily
>>>> enough this one returns !void and is never checked)
>>>>
>>>> similar story for other func additions
>>>
>>> In fact, initially I had them merged, but then I couldn't find an
>>> elegant way to handle AON regs. I can squash them back, if that's the
>>> consensus. Any idea regarding AON regs?
>>
>> Digging in techpack/video, I found:
>>
>> commit c543f70aca8d40c593b8ad342d42e913a422c552
>> Author: Priyanka Gujjula <pgujjula@codeaurora.org>
>> Date:   Fri Feb 14 13:38:31 2020 +0530
>>
>>     msm: vidc: Skip AON register programming for lagoon
>>     
>>     AON register programming is used to set NOC to low
>>     power mode during IRIS2 power off sequence. However
>>     AON register memory map is not applicable and hence
>>     skipping AON register programming for lagoon.
>>     
>>     Change-Id: Ib63248d118ed9fecfa5fa87925e8f69625dc1ba8
>>     Signed-off-by: Priyanka Gujjula <pgujjula@codeaurora.org>
>>
>>
>> lagoon being a downstream codename of the aforementioned sm6350
>>
>> Meaning yeah it's bus topology.. so I think an if-statement within
>> a common flow would be what we want here..
>>
>> perhaps
>>
>> if (core->iris_platform_data->num_vpp_pipe == 1)
>>
>> just like venus and downstream do for the most part, and kick the
>> can down the road.. In an unlikely event someone decides to implement
>> IRIS2_1 on a brand new SoC, we can delay our worries..
> 
> But this function is being used for VPU3 devices too, if I'm not
> mistaken. So it becomes a bit ugly... Also I'm not sure if this is
> really related to a num of VPP pipes or the CVP.

Oh.. hm.. maybe we can add a .aon_shutdown op? I'm not sure how
to proceed either

Konrad

