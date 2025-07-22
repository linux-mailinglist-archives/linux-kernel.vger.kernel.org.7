Return-Path: <linux-kernel+bounces-741549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F0CB0E59E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D29A6C788D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12A285C89;
	Tue, 22 Jul 2025 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOt82l1N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFD27A917
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220282; cv=none; b=H6WSg/z/ArZhPOJAV0JAfoHk8NNJ/lqXebcEqHPlgvi1frJT7/5I8fd3mdBO0sFF8LfXcdozFI+FdMW5y0Dgop51xZrXQbcN3oZqwlJVsfmHTN2znQEMG0OaQ4PjOJpnkkmSMz/c+TTVbHDX91wA+3p6JLcTSGT6D1x+f6FaefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220282; c=relaxed/simple;
	bh=6nRVyMzTEbtWqKQXVzYCCUxbPhh305yz2e5jk+pXCPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvOeZ0wuNHW8I2/JpZqbseRyvMVCNIGLAC3S+6ROViuozrPT3p5kgPM9hlD7ZOvnespa6csoHOEmsn0RA3GAzOwLiNHQTDSZxqCQqzj36gjhWPnkFB9C8HWeIObvLZ/r5++zrMGSfMrqBhiPEvsZOj8lX6MG9ZPI6sptHzm6upA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOt82l1N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MKU2OS027101
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LxLJaMV7OXItal3Gz6wp6eY7p9oi9m5tlAOw82q3OnA=; b=kOt82l1NSr5ROuW3
	bSRdVdcSuPIGn/CQpDL7Cx3fTxSls+G/0PFu4oe+S7YnGvMzsnExL4A2JYMuU6j/
	FpvKW74RW5VJNw575g/fa5OHg38/3bjnCLhQ9fZNx7vmPUJkkpOpTQE3zXv6VPnz
	Ox7s1+WZOzueyqBvjnvUEaHWgF9g/i7VCJ1m5lRBeJsmaM6PHvDITBqnvDHWLU2k
	96ZQQQtrTtFQcIRLXh4qeBuRX5n2KAJgv40GtHJ+TaW7+2l+TjEgmdc05mrlSr3/
	eymp38UdfXg+FzSt6ZG3W1mEcedKzdh76t6gRHVvPoENyJ6tI4HvohhnFT8UjhFZ
	IFBzfQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hryrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:37:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74d12fa4619so5258287b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753220279; x=1753825079;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxLJaMV7OXItal3Gz6wp6eY7p9oi9m5tlAOw82q3OnA=;
        b=LcP2iemR+r5xmQggjYhi+NsbIOrXKtbzigNfCMeVJXGerpSBT03M8u0KCmXFgTPA5p
         IFwL5ZZuia1dVNwU28o1163s532pSjeBYdsOn2bzdWyo/rC23bSuutXbuLOYDL9RJzO6
         Ix00p/lD33BrZfsrsnQnLVOaYJcfuWN5lFtjhadoEuW3+H2jqsRW4VaPAfTyHmArzEUZ
         69rE58GDtdSq+abW9F97ui/R6pL9caUYWT3MgErCjmkyp4h4HELQLKjT+QhJApTctUrh
         9TEmCNLofL21+0gCFnyzS3v36pSyGPQ+bGPsDZEo+NLd11qQ6y0vWAm5tAsJpwZkicID
         ZaSA==
X-Forwarded-Encrypted: i=1; AJvYcCVp+zrrF7BOzo0fBa+lzu1czacYQVMyRW3exhQZkcWm3uXpr08tH/z7bKA0qn/TEVeo5ZDljksr4RUauEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkC/2Zbj/qIXY1jSvyMxjCH0CuyDejozwWm7GKBlWFsWMF8tBd
	ijj5Cuc14a6FiQfR9TOC5UDdidUnBTJjjiznd2P9L/aOV/iNw+gZQ4MaUdXSZ+0ORhZCC/6Rzts
	EZfUa90RqVDA1MsEWdK+8koWI7y6bXje+3jzXZSHhlX8yPb3jkFBJ918TzXiygo9hR5U=
X-Gm-Gg: ASbGncsYgyQHe9xCHb62FzePl4YMSORpXv7uGf+YEzZUmAiGyAajjP4yNOOnqetitV/
	7bsoP+DxpAsfqOAY1GLGl9amYE7YerMmJ2ADZ3infJqVXG626+VlL8kAs2TyjZ+fW0p1uttDaCQ
	H/UMbKRlNBGPYQ3oEY1TpSd3jtS107LsbNoyQdilBeTrhsL55y3e9n2K1yDUjO/iS2RWcQdR60j
	0Q9zhmqXB7QnV1+q4q55+SG1h4yIyNLIg+wTfcjlpqqU9JH/WoJJNpaL59IN7IDawMyEWe7XBqO
	0+VHTrSeYMqXM+hAekqKyj6JH4zFcTGSufd4KBJvfec2SY4xeGcEzZzqRBwcs27A
X-Received: by 2002:a05:6a20:3d88:b0:23d:480d:1c8e with SMTP id adf61e73a8af0-23d490f610bmr649760637.27.1753220278611;
        Tue, 22 Jul 2025 14:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUzh0+F2fFC/OFAdVApFhTjPc/PEurlH2lfCsWMfZmPW8kbCHDDIcYhoLoJAcVU+iy17tT6A==
X-Received: by 2002:a05:6a20:3d88:b0:23d:480d:1c8e with SMTP id adf61e73a8af0-23d490f610bmr649724637.27.1753220278164;
        Tue, 22 Jul 2025 14:37:58 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe62d9fsm7733090a12.1.2025.07.22.14.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:37:57 -0700 (PDT)
Message-ID: <85073de3-3933-439d-9912-1f0ff145df97@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 03:07:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] drm/msm/a6xx: Enable IFPC on Adreno X1-85
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
 <37nuk4kevhpwlzbpgm4tyhnmk6vi3a75oosz7l7xbvvn7qwq22@oomdnizhc673>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <37nuk4kevhpwlzbpgm4tyhnmk6vi3a75oosz7l7xbvvn7qwq22@oomdnizhc673>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=688004b7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0HPixKO5BHaGtdwfH9wA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE4NiBTYWx0ZWRfX5gQxINo4aecZ
 fk44rWZl8oO1bYzIWMsr5C6p23ZS6jkS+EEYAbBFkrQhzwQjSJYlpx1HF9RDNjxF/0ljnqcm0W3
 kRaGeKH2lzolqIFDWpX03iSkgKwDLCoLhuICbIYkfnPvu9CYqLp6hu5R3wvYI98y3YnCsqhom8P
 ubN20dXKYXnQtvE84OGdzGvBkOgnLz3tnYPivMM/XnWYkgkxjC4eV1/wM0+jK7DQDQxn+TkUg3+
 DtxxLFOXFXMohFmx9PD4xqwuCcbu55RlExtqfL2cTGQdQaDfccdeN6vbv9QabJpjqvIArrImyGi
 P3Gkz/HCNBOpnR3IrCQ66jIXtG415qp8cl+eiLlPRslIexChSpQnX6LxBWVurAgPaiO/GRTc6xn
 taXcKgfeQ5v9iQXDqRSnJSF+z4ZOSHfj7MBGU8gF5Ozxk+F1XxOvV4pqJH83QcW1IYSBHFdu
X-Proofpoint-GUID: 4U_x26WYCl5DlDNcfBAozrynA_crza_Y
X-Proofpoint-ORIG-GUID: 4U_x26WYCl5DlDNcfBAozrynA_crza_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=659 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220186

On 7/22/2025 7:25 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 20, 2025 at 05:46:17PM +0530, Akhil P Oommen wrote:
>> Add the IFPC restore register list and enable IFPC support on Adreno
>> X1-85 gpu.
> 
> Nit: GPU
> 
> I can't stop but notice that KGSL enables IFPC for a bigger set of
> SKUs, starting from a630v2 and a615. Is there a plan to get IFPC
> supported on those platforms?

Sorry, no access to those hardwares. But I can certainly help if someone
wants to do that. :)

-Akhil.

> 
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 67 ++++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 15 +++++--
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>  3 files changed, 78 insertions(+), 5 deletions(-)
>>
> 


