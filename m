Return-Path: <linux-kernel+bounces-730730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC1EB048C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7971668A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0737DA88;
	Mon, 14 Jul 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNLMXFRa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA902F89
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525627; cv=none; b=WchxqHbNtc2TBIwNA/trfqVSjw+CEKKtI2X+tVdh1ndNIiu+FP0aGlU+uwlNoGeJurp8Dn24ZiT49/WO5gGSsk24xuhsr7q5oqkBUtLxapQ/cH7we4uaDT1OLAjIquM8AaT3UhedbmC4eEaLlMhb2xrcdg/fQM6hON1UBBeCJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525627; c=relaxed/simple;
	bh=2uZZTebuOFDjP13YTDGx4SMvfjxX+NyR4RNznioKjMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqUYvlTSJUB4dz0PEqtlyBkYPEX/a5gVDrZ8ehh8tweMQeEFqDH6dyKMq4k+h9fasYOebgPzImdjYlyg5OwLrne6OgZhj3mkzEE34DpBYdkNV1ouzsxypTKD+IaM7YlM1tbWo9eHHNAJnqUzv/LB8LMPNX+a52EfkvciUCddkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNLMXFRa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EHeX8C029781
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25GVmgVH9MDk+jPkcTAhkD6+0FAocGPXkUfqlwWZ3pw=; b=PNLMXFRazHMoAE1Q
	b2zqfe89TduErxSZAi8QZeNZpEPkA1msL7FbI0JgU5jvZqNN66vTqv3+XLjAChxQ
	I8nKIFfF5y/8nvK2A+YvkXeXBeKZ+caUVQNssT8B60IcbWAfGftXCSHNqWju/w7z
	nPeXOnvomxj0f/0YWsA8+rPYbeLP0DGyTQcrHxJyEPaFCTcxXJAfwhvI53rSrC+8
	U3AyJvz8I9R2xjv3iosKAS7YzqD11YEyc7YPRVa9v2AFDwre3UkHdmiNpH8/BwtA
	MBQqoyyIhipyY0BXgIyM8dyqkAi7t36Zn+0qY/f7AjFeXcPyWI0Onuu63Dxx44aQ
	zxDdiA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug37wy5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:40:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23494a515e3so41824915ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525623; x=1753130423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25GVmgVH9MDk+jPkcTAhkD6+0FAocGPXkUfqlwWZ3pw=;
        b=FYzLsm85VHgZQiuS33NExcAIA6b+Y1lPILiVeGxWmu4rQ2Z4eGIhitRr5fRGmg38Mk
         sLtzP8DZoatsA9x9l3P/3TGd8xsQuu6sAu1Rrvyct3FSITOJEInxS+1CnxTVVSqyOKFv
         0RBj/3Yny4oRHnPFS9/+pZMr/s6MCGAKVbYJd7Oz7dkieQKX+CdfbSUW2ePVK6fIghJP
         5FDUtVaF4XGLcBDyMeZx8x1R9WcgCS3gdFkYxdC9P6MTkwsm3rdiuMPA9BYPc8ThZQBf
         JSZBJGzfXr+KspIu1Z1sFq1dAYLCMp8LwN4MJtWjFeCJg0GMLbmG4iEdjtOlLpRE+/8Z
         82aw==
X-Forwarded-Encrypted: i=1; AJvYcCVa0WnGt8hbpAtLUfAIVayN9RTwiTqNok1x3tqEnzRZ+oEASWP54YlzeO5recr6FOZQn6EXjIBnYiJlVc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB19eBm0dxP6qb4+pw2HXcMVozDSeH7JxCJg2ye/IJ/k66Iztq
	qpNWJnfD+6X+7IO/jOb0Da7XtRJWxwciBS/7wJLf1aIfVE4YVI68lyFFbYlb6gK05qooOGhZZqE
	NuK5y7Qzb+L8IUDRPozo7wQ2SmC6B/Oa8E3rbc68tq8DY3ytESgYM7v8REUJwz6FLIOM=
X-Gm-Gg: ASbGncscETyVf/gyjN3G3zldf4V/v+v083RKU3vTRYe7g8xbLhvWzsgqA9rwHeodvGR
	W8AvFiWxzKa7UsC2OhsOguYP/5TRCHeIAZaAYdwSFo7q7G8nZXLLWxz+IqQ67OOLaBUortRWVOl
	efFE9rKM88GRcQ/vWgjszb6eFK273pXBL78r8XctimVKj6IDyaHm5osOTbJ2PU5AKS7zsd1CdwM
	nlCofnYS2dT5wgu74VrBQBhD/8sObhezSah3Ahq+GtFP0Gf25nuuqUzlPzC3jHeiaOC5kZdbLTW
	0LjSmW1yU2+SVq9DQiijMQCJjJlWodnzJCMCKYg/6jOokvS7RYjmeAh8c/2AgWUjzugdrooKKPy
	aRLvtsxSWehHda8xbBKBwCQ==
X-Received: by 2002:a17:903:190d:b0:234:c8f6:1b11 with SMTP id d9443c01a7336-23df09637cemr220506795ad.44.1752525623068;
        Mon, 14 Jul 2025 13:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWNBRWKprVEoGbPc3QI56BgXdYcezaLFCqX5CP+sJ7MbZarEK1v7Av0mTf7ehe9MRj6ZXn0g==
X-Received: by 2002:a17:903:190d:b0:234:c8f6:1b11 with SMTP id d9443c01a7336-23df09637cemr220506455ad.44.1752525622634;
        Mon, 14 Jul 2025 13:40:22 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322db2sm99681325ad.100.2025.07.14.13.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 13:40:22 -0700 (PDT)
Message-ID: <6883f346-452a-44b1-b670-3bd514f57b08@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 13:38:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] drm/msm/dp: replace ST_DISPLAY_OFF with power_on in
 msm_dp_hpd_unplug_handle()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-4-33cbac823f34@oss.qualcomm.com>
 <rmlgjr3fzb7dmnwmthf5bj67wb6fkcksmn3ouchzsvhhgxiv7h@vwcieejcufr7>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <rmlgjr3fzb7dmnwmthf5bj67wb6fkcksmn3ouchzsvhhgxiv7h@vwcieejcufr7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzOSBTYWx0ZWRfX3eG6Mycv4KPQ
 WZHYrxi/no4078Gq0CwM7ffwZp465p50cjPrEwm1tbr+AizRjiQUBB2mOnyPZ4mTTSsbyawCCO8
 e/Kchn5IfqfcQhYCpV+nBVJKvYBDbrZ/0INY2uYQln43zYy4IxeIXgGQMllEGaQCf+lI4iljC61
 FXUoRpPFIIQnbj5QE0Ip0JXHw3T+GIulosH980jyhpfTGOTNmQ3wxZtfeb0l66ONUfeWAUlBzgH
 6fWka/ul5RPNtyrwqS9MENfzRkcNSWCFBtYzkk8bcQ5lG33UC4qbGsr5BMQwe8cxWT86MJfmS+y
 +i01r+Y8ojPnidro2jOfHs/EJqhemUw0hIDpyvChXiVEljo/BBTNgs3zOHGtns11cApHnA2uF64
 dNKjvL+/Un0nVwMQXRRZr3XZ6AAs6t6LHRnZw9x0YUv073Qd7SQoucKNoOeNaVaYEoC79sWV
X-Proofpoint-GUID: LUYnDgUiVn__rXjFOoBxCVwx0YDHjcHJ
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68756b38 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=a_MUTpskHjF2EEzg2GEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LUYnDgUiVn__rXjFOoBxCVwx0YDHjcHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=722 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140139



On 7/14/2025 5:27 AM, Dmitry Baryshkov wrote:
> On Fri, Jul 11, 2025 at 05:58:09PM -0700, Jessica Zhang wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> msm_dp_hpd_unplug_handle() checks if the display was already disabled and
>> if so does not transition to ST_DISCONNECT_PENDING state and goes directly
>> to ST_DISCONNECTED. The same result can be achieved with the !power_on
>> check.
>>
>> Replace ST_DISPLAY_OFF with !power_on to achieve the same outcome.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>> Note: Taken from https://patchwork.freedesktop.org/series/142010/
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Please squash all state-related patches into a single one. It would make
> it easier to review and more logical.

Hi Dmitry,

Ack -- I'd wanted to keep all the patches small, but I can squash 
patches 4-16 into 1 patch if that makes it easier for you.

Thanks,

Jessica Zhang

> 


