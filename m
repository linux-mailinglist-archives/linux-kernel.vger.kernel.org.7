Return-Path: <linux-kernel+bounces-839562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D772FBB1E85
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F62D7B14AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F6D27F010;
	Wed,  1 Oct 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZxrmdRFG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A21FCFEF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356205; cv=none; b=q3+6JwuRnGsZL1teddqeoBZ3pfSeRqHJ5HF7LPy+zaEbBJxRrYKcCar06ePiogdKG/JzTxw7WX8P+j4jYmIOd1//xC2lSqQDir4oZd9k3nc6VaaBeUO+k+cGzfIUeMSAD/J577nabF4ANIZhjiY+oe4Gc1Od1T6qONyNb29iIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356205; c=relaxed/simple;
	bh=Wk3bDUu2YaivOtdBdtxYhxbK12TT0/NrgvBoRljOs9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz/x0Yv720+sZ1lDWEjqsSqGe0otJ5c4ohXhMLoqts59ISMMo+sRtYQ9Obpi66g/tVQ4BltnBqAEHFZCE/T/JtH5SSDNoi2pLFyGnnImhG6+TGVMQ9WomzUFDvUpegO0Ci+OLbQ8wDdb10QqDYh1LzapXVNUy0UE65kRM8NovC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZxrmdRFG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Icigk010910
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xujcu6su7xsGlY8taylppAEs36Y3vIRtnieSXdVrg20=; b=ZxrmdRFGxgETCxR2
	KDET9JmODW6PupEOkcuQFKC0hHOo2JvLm5agcGHLLk9DJzxXD7EjI+NocnNB8Trv
	y2qTIXBY7hG+59YyTrpGUWIZ97AwGd1ndFdNiuLQc5sBSRB05yBjZlwemER/JW6f
	eKFSogMw5WY2GSPp91KaR2+EI6k/Itmu4+hUHsMPWrHu9GXR77eRwkdwoALRFDg2
	O6CKJBmMaHUX2nwQdo/33wBAE6Bad6XdNG34oiemZSXvzxneXS8kxAR7dAO5ch5h
	lo8R6+6G/NGLPzpge9CdK4ExhZFhnZhJjhI6Reyfyh/UccS2gA8LhXhfOMqR+op1
	AjMrUQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hnqd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:03:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so1103082a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356203; x=1759961003;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xujcu6su7xsGlY8taylppAEs36Y3vIRtnieSXdVrg20=;
        b=IEJc7MMnCCtpgIeT/rRq4zA+JMaZ9LGoP8p1M/UCvdKe8DePbPNq+OkHaBob0H7YNi
         YteRqRa9rIv0CpKnF3vp3B02+CeXovr2alfwd7q8vlPoWvUQLfFD5uTDxZstitJdKuRn
         eqkUZN2wbcQjRmRs/ZBL7w8R/VFLlp7WJ20cSwHLCbvgk5d/BPX4hqmI/YMbuI+pRpTo
         LBuFJEW7FSW3XxaJPOQc/ag7TxD6vmwDDNE8a7Imfw+CsYEiLMUoj4xa2tD8WiGCM/sl
         z5bQrofmSNEXH/eDxdE0EcOO7JUQv4/CfVhpuS8KdEHWez/sG8IDOTIISYt7LVTaVZFd
         nBoA==
X-Forwarded-Encrypted: i=1; AJvYcCVjYmr2dzKlr82OzndrjRVpNu+jF+3A5a4tDt3bFo0mCjemArUwDDMmy5igqpnAfaCbdkFpXgDQ72nRzXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+R7V3xU05Uz5q3KP/4vf7eC5+ZHYOGAKBX0uZj8J75ZLeVtd
	eKKcnOMBlxxMqPKFtbuNROPYTmwMd2H6sBkhALq41Y/Er3eKRWOkuPi4x/Yfj0+GbzpDQLj55OA
	NrtmYeEoeT52Df18wXdBvQTGFiE1/WqiMx77p0Sh1Dh00Lxownw8J5lTOzjj+bRvexYc=
X-Gm-Gg: ASbGnctpDihp1J2sWuV6cTpjk3xnb5qivYQ8SspNjh3n6xIP7RPaQXQmkND9pSiuwsy
	G4D+19Vs3qstNUihudulUUWe90w/iBWXLEWDN7I7c9RU0XdOBsj0r5m/Jsx0fg5X/Oru7Qf5JT3
	ACnJN+UG6mPy9XiN+jqa+ldUPSjbLNN1q2uKTrVKTKOSJDn7N5JdqgH4+fMXGBB/ZNraMYI7/Zi
	XW+aboLi6+Eit7saTsYaaTvgj26rJlAL6a+QM8cW+WxIubax/qpADFxQBM5etGqWbYIElhTI+Ws
	WA2DB8KRMqPN4l21SdTQcMFoDP6UWD8V6qDqkPazX8YcN4aCXZ97jqqSsZRpTgYIHhc=
X-Received: by 2002:a05:6300:614e:b0:243:78a:82cc with SMTP id adf61e73a8af0-32a2529463emr1184481637.25.1759356202561;
        Wed, 01 Oct 2025 15:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgxO0FMEt6NCjTbWEVMsMIoIPsAqpPcSGWTogRJlJI3yNWhMaCOEagO+8drQ4c5arKTyjNnA==
X-Received: by 2002:a05:6300:614e:b0:243:78a:82cc with SMTP id adf61e73a8af0-32a2529463emr1184444637.25.1759356201994;
        Wed, 01 Oct 2025 15:03:21 -0700 (PDT)
Received: from [192.168.1.9] ([117.244.71.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ced7sm659664b3a.15.2025.10.01.15.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 15:03:21 -0700 (PDT)
Message-ID: <79b54a9a-2f05-4a2e-b9f6-6fe46e2c25cf@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 03:33:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 15/17] drm/msm/adreno: Do CX GBIF config before GMU start
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
 <ae2ooybajk6mcjggeztumubht6auw5qlhmsdrblikc5ruoxtmm@oj5kvpxithva>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ae2ooybajk6mcjggeztumubht6auw5qlhmsdrblikc5ruoxtmm@oj5kvpxithva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXzvHE5FJOry9g
 vM6UFSZGUfXr1rSFdjjQY655tv+7hNaz8dD2p83FAi0/L8vI6TxwfLYEMMUD72lCRxGim+nvXHx
 xZQ/8ywxSwfOwKOSkONGQJGvFoz7lrXHOzXvgyOW03Vn3N9TB5E8KKNarjIc7fFZEej+3TeSnKs
 ro085sL1aB5SCRejV8oDPxOOP/rpUnbP8XLCmHzUbHjcdbVI47D/qKWxmoqD2kR471ZWt5T5ccQ
 6I2by6kyDfh/2IkwrQVv4WzXA/BMJ5QDiXxYUdPYnSAUfcHgICLxsFeA6S8/LByRFgO+Otu8S9H
 kKGlg/mL/YWpCAG7tbPx2YI0es1RXsPrZtXsBgCWUfIyUG1g9eiJrg4vmhqmO0v6p7x6Qft9lc7
 c5xKjr1X42CPm1MzxfFPOC1IH0rpxQ==
X-Proofpoint-GUID: SQQK3KoCNobI31mL8TfK2sl6Li9x1bVi
X-Proofpoint-ORIG-GUID: SQQK3KoCNobI31mL8TfK2sl6Li9x1bVi
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dda52b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=2kejHg7nZSoTgEpwAwsXNQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=AweIZ1vEVvbksj7JdV4A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041



On 9/30/2025 1:19 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 30, 2025 at 11:18:20AM +0530, Akhil P Oommen wrote:
>> GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
>> configurations before GMU wakes up. Also, move these registers to
>> the catalog.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> Fixes tag?

Seems this is not an issue for existing GPUs. So, technically not a 
bugfix. I will update the commit text mentioning this.

-Akhil

> 
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 23 +++++++++++++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 12 ++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 ++++++++++-------
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>   drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 10 +++-------
>>   5 files changed, 49 insertions(+), 14 deletions(-)
>>
> 


