Return-Path: <linux-kernel+bounces-871653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671D9C0DFA6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF76234CF61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE042C1587;
	Mon, 27 Oct 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsJIKiYD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E029BDA5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571235; cv=none; b=hBB7P/J+eX3yLMdP8u67k/vDTusEEkGpJRQuXLH4TlG4ArSoJodqDDgiixoRZwqRq44CWnQseEFKnQ5G51kMADSe1LYNkkZ1LLXNASDxs1bZH/knVRSH+dChl/s+JJbrshlVU8DD7tCJQl2kpPRn/yM/X6TnGYWFKtOg27sOV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571235; c=relaxed/simple;
	bh=HBEaI4YkpxM0ymZUHGuwzJMLz0hxOEJOQRaeskAgUJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTIw9rp/1UHaF1nO/sEe8CzLB/Aor5Yr7Dp1CZEV7HKMlrmHdY7bsw789/aKXXWxpBd9Dz1xEwz86b15tAfchjy8B+Y0Hm/T1UPDErL2Gm4Qer2Tx1idN/SLc31oTD50dOLOgN7SnJQl3lUMXqEwRFHW1OPqXZgkcdAvcbNepxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsJIKiYD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R84ef82232087
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSYlZ3f9vesYlsVsHAw5CyHtqlY6CNOY4YSlAreQ86A=; b=AsJIKiYDX7kcD3co
	6PZLgnIqmYG/LL/pHgMcBHT11BIh91Z7LYbNNQVvHu1xWRSw9gAunsQTONhVfDwI
	ITR3u+nNFYJQFCLvkVCrb6paN8FYonx2DUFv1g1Czkct8v0KAiO8XONyMF7fnsbz
	bgM59tHq1ZtXmxOjyBs3HZtPCLMOQVtASfBQpiLu0/cXQvd82j97EleYA1WIkqOh
	YEH2ZAgVbLmTReh+l2cfNS6e+V98JwfuPaYXrMPluj3X+l7XbY+3jfWLI5qq8LEY
	fS7a8JfwR/0Ap/7UuEI/O97HALdCarFl/ym+Vd8dUHAzbHbrI64IzCIQNIxGGg2Y
	/aFgKg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wn8v82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:20:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56b12ea56so6803001cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571232; x=1762176032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSYlZ3f9vesYlsVsHAw5CyHtqlY6CNOY4YSlAreQ86A=;
        b=ioqyWIGsrCMfa6VmSwmHk751BSWMg+ZisVWkihGeYkkKuxmk1Jo4doemHi7BaBEBsv
         /vb0RjyAwUdFbSIMdqwByMaXffa92I7ivKAszy8MoQbUIGZQTpqjZzYx/qel+zl4NlFz
         uEpSmvVG7PWOJY632hSbIbIHWHtf7lQlwdpUSsTE+bHo9dtzyF8SR+bfsrPMsWEbpO3x
         +QJHiE++O0LFRWwPduNBQdvJ1HUAHUFkCvfObs8wLQ0G+BloyXBgWCiml3cGXnf5ifpp
         3W1CPctGBZVWUwIPnOh41LEZXTr4SVHfeav0MiSuD/YY5mRMVNixbw/BhDO9Ik2WcJp5
         ZBtg==
X-Forwarded-Encrypted: i=1; AJvYcCU7NYzp4wdq50fiOZ+Tie/zvp7gKJJzppNLvDQ+8MsQksMRMEe6O3VSr4FdSOh8zh+UEjY8U/miEs4CvqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMI4FPfchY2j7PcxHky7IuNTNuZwEaCDKwnxy7NWYOlfY8YeY1
	aHGj3HAdz6kITnL5WwG8LBQhNfnUMQ8+BJGTBUDfv2+pYaPXmXfmLgsOQZstzHZZK6tFYLbw06D
	wuYPmntKPHvTkD2x0GlnIDyCzv6ZrZRDcOU3EjuhfNRV3epne9MsJhJEBxi9N4dNigYg=
X-Gm-Gg: ASbGncsoAMSbJOs8b55u3AREd/SqwvPHu/XcsieK41WfyOFbgWcWscNVDO28PXJ4RKi
	WFy5FNPU+wAQKHZUz+3Wl6r1B8Gf69uE//i4oM3xpP+/Lk9AP6ureVZ3CV3BVU+LGwNCkX26kxO
	ozsV9t+2J79CL4izRl9+nx+QHLi1rJSHima2C5ArKH73LFTehhGzXQAc/P1gjPj/N4ED9uy/wAu
	EszG9AUAKCyvJ5RhGrEFsgw8WBXws5D8ZRhUOkIQqYk3XIfvTrplXBHYzE5J2VM1V8ZGJBuWE8f
	fjhfskuEyqi6taF3xbmXDlK6DeFBp9DPFvWPQKOl1nr9NJ/IorNXSBHjgBzKtsZWKlbE6E2twWL
	paFnfh74Rr5+ZAo/yE3kPAwiyH8OA+vBV1bZkEcS4kECiGoC6ZptU0Dbf
X-Received: by 2002:a05:622a:5c8:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4ea1177c842mr202134901cf.8.1761571232033;
        Mon, 27 Oct 2025 06:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdz/wQ0BK9pQjwusme3Hz0+MCw4EcI0EDUElKxUQ9hHLgGZIHDtysKRoKXFj8XSgwXP6Dm/A==
X-Received: by 2002:a05:622a:5c8:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4ea1177c842mr202133331cf.8.1761571229943;
        Mon, 27 Oct 2025 06:20:29 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef95d5bsm6279668a12.16.2025.10.27.06.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:20:29 -0700 (PDT)
Message-ID: <0291d0f2-483f-48d8-8c75-f1bbcd1ab18f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
 <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=68ff71a0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NCk8XzW7qX7BC1ZPH1kA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: XYz439z4RLfMKeKldXoP8TSw6YnBL6Y3
X-Proofpoint-ORIG-GUID: XYz439z4RLfMKeKldXoP8TSw6YnBL6Y3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNCBTYWx0ZWRfX5UDKGnv4btxF
 TqTw46/HPmwAZmxrZyIgsfZLY9EykR9h61+b8PVZp/rnNSrscFhkqvyCOhpA1a7i4M6KKRDF32S
 mz8itp2K7tNPzl186u9PdWowdNN4bXj27bzox2bR80DHKfZ82cwN0Zrqflo0MwxegDYNBI+OcFt
 eDd2rJ77habffILsE+V+wtEHljF8mW8Au1fVaVSj5V6blnyB2KeCpzHFEfsD13Q2TMWcOhWtap1
 yEd7bBLG0ju1TDrzG29gEsT3Y2lpWFPIZSFeDQt7qmHw3FgxzezQq9yrWqxQ0iWUvdDYAVT7nl3
 i67m74sTDxTqOUJpWwao/iSUvdvJoi8r58B62+9FrtKj/Bxr4SIsgrIaC5QV/CHGeQbA1yaSld/
 vzZD4r+un1EWc5MkdjMF13g+jl32qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270124

On 10/27/25 2:14 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 24, 2025 at 11:27:53AM +0800, yuanjiey wrote:
>> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
>>> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
>>>> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>>
>>>>> Add DSI PHY support for the Kaanapali platform.
>>>>>
>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>> ---
>>>
>>> [...]
>>>
>>>>> +	.io_start = { 0x9ac1000, 0xae97000 },
>>>>
>>>> These two addresses are very strange. Would you care to explain? Other
>>>> than that there is no difference from SM8750 entry.
>>>
>>> They're correct.
>>> Although they correspond to DSI_0 and DSI_2..
>>>
>>> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
>>> new features. Please provide some more context and how that impacts
>>> the hw description.
>>
>> Thanks for your reminder.
>>
>> Correct here:
>> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
>>
>> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
>> just some register address change.
> 
> Addition of DSI2 is a meaningful change, which needs to be handled both
> in the core and in the DSI / DSI PHY drivers.

DSI2 was introduced in 8750 already, but it was done without any
fanfare..

I see a diagram that shows an XBAR with inputs from DSI0 and DSI2,
and an output to DSI0_PHY (same thing on kaanapali - meaning this
patch is potentially wrong and should ref DSI1_PHY instead?)

Konrad

