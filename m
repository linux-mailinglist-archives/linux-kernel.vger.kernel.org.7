Return-Path: <linux-kernel+bounces-743244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE508B0FC60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3DF582084
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B42727E0;
	Wed, 23 Jul 2025 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yufwob0b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD175258CD9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307847; cv=none; b=Ib3bfi2W2huDvIpA81wCRaDoForEW7p+YGVdQuhq+ngv8UodtoF++rxKwzB2Rqx8BogvYdVN+NhkYZD0YuCVCTRe5fPP/Gs8l5SyAiNSY6opCPenRp8y4znPPqDo78aEXwNqQge/xwe3whmc5E4uZSwHR1fgUCRH0P6J6p/vvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307847; c=relaxed/simple;
	bh=x8ZNaM3qWNjsTBLjr7nmR5rJvVV45h8js/ATC7FIzac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHRHk4zzAUUKGCRneqlsA+Vp3NRqekMWo5YGIDrfI79C9JYVEr9SJn4es4ri73rhlnOxOAsLFoa/49WE1jnWMBRPiV6YNgvBFurFbXiu8YHZcA2EHZxqcmlwzf52W2o5egj3OsC3yA11381IAegBPINOXZQjDNbUJpAcsinrK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yufwob0b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGxAdd011406
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJ+IYU0/ojEVW5G9zuKC8BY7swUqGdFQH23X2V5IKK8=; b=Yufwob0bDJ0w5GdB
	hm0F8+3TFob3MdtZgWS6cMYBLdvKv5Fts8AocKCXK4LgymsH5kvtHT2UWTEOq67E
	yXFdvBoS9yVC0zuLi62tjyaV7g3wDxrJ5e7zlQAwU7IFcgmSEzeOy2C/sqVa5MVO
	+Y1Mevz1D3P1UF+lBgOR5XcF/Gjdrys1rq0pYVRYw1F0l6012olMXSZVAb0tXE1+
	81FwbRcLFkN0HSVha2rqEerBXhWcZQVHdtvx6UjlPeYjZh7KOTjpDjUFPF+bbyR7
	TUX26bcaBskO/1xcRzdedmyaOQ6jQOc/C18YYQSaB93j0l8oXcnj754E6FRBDdg1
	2+DzaQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hvnhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:57:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74b537e8d05so288619b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307843; x=1753912643;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ+IYU0/ojEVW5G9zuKC8BY7swUqGdFQH23X2V5IKK8=;
        b=ro2lWYLt68dNidId9TKtICcCkYvREfXBT0drnPValcoY1MtMLDPVYvYPeFGhMvfKop
         KzDD8rbE8zWg9iZq4S+Qs5kaTEtuW0NFN7hk8XzmSvZMi7A2YIwMlL+d0UzXLO+BPH53
         LbYfKrMKD27xodUwTDMaFwZ/PCK+SlfmRBwWQJTSSbhrgCaPHx4aeohjMXFkxGIrse77
         h+zoAPl1+qo1/KJBPKiB0TwD6l/C1lWZin0W8SFV1DzfS4elsbtaERX5KMdzk4HyUpOs
         vI2/Ij4jZ3RSnPPXef+bGvTLLr7EJuP3niNQvdtzCpAYvcnsugEKY2b/0fKhosSDR+w/
         e4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr9VelXLxTSg9C5kBJDXlvzpijW7HPHPpKBzYw58y3DXStJJG+KbdDI5IJJv6XnFRN1HxPhd4FKu4y3e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53BOKZ2AH9XHyIa0K1s0hhLlcKu+bj4Eo3CKZ3Di2BpPjeooH
	b0v/KMQk1EpwgQYxvmy2Xj2VuGfPQRl/mqztI23Jjw+ClcBeBSE4BLx/EYzyvdQCNTLz8wAbu7e
	Oy0Ng9Gof1y7D/CNG4rlMJoOGt4AWyxbe7E7HEQAi8RQKS9vdx27bSZ0MP0QPlxOhRCM=
X-Gm-Gg: ASbGnctCdeLMfNxm+ZSxWtN3M/ZR8158wq9st6WNdwyMZ6taIWpSdyal3UD+7i+8y4F
	doWhmhQUwmkbG5p5mFqZTSUW0MgRHrrlegJv/ONd3Fbzi/RWn724OwcHz5RFlCI7YvQ8ZZi/q9F
	j9Gjg6ciL85tzJA0jwJ3mPiNY7LbXpQreNE7OB9SmTDfwBDkFJEPZOIojiLU2CZXNVHvk3bWnOk
	ZSTGvZzC4LFwI1J7m+eiOi2kK4bcPztIZe0HnIDUOknK/WZUv/HzfUo5c+jMW8m4e6VN7LNvDzE
	brmxJIf82zC/1gij6/h+MOWYu9bMMXDOUt7xGaJdfH5Gc8GVDT7P4+DjEpIIKg==
X-Received: by 2002:a05:6a00:1914:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76035ff3a9dmr6809750b3a.23.1753307843091;
        Wed, 23 Jul 2025 14:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWT5EGhznLq4VFRgdd229b0EV7FZUBLIcTF0ozLJKJ43/pxYlu8O0H+tTREYzCfpQFAEhI7A==
X-Received: by 2002:a05:6a00:1914:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76035ff3a9dmr6809712b3a.23.1753307842602;
        Wed, 23 Jul 2025 14:57:22 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b04b3517sm124546b3a.84.2025.07.23.14.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 14:57:22 -0700 (PDT)
Message-ID: <bd0d5470-04e3-4545-be5d-a71b9d3fb5a0@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 03:27:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] drm/msm/a6xx: Enable IFPC on Adreno X1-85
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <85073de3-3933-439d-9912-1f0ff145df97@oss.qualcomm.com>
 <50d6a7dd-46a4-4281-968d-d7df041f21ae@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <50d6a7dd-46a4-4281-968d-d7df041f21ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=68815ac4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=pSIa2sKh8ADkebnh61Ypzg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=LD9g5RzjIN7if3dsUIgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE4NyBTYWx0ZWRfXykMPlPl+71Ea
 /r/5SN/uvI6PU1k6EKqoDXpWpn35uZ8q4DRQLEF/kECjcrW3uVGAZE6cILL+dd+n/PobRKmhynT
 Um9PYtbUNUcZal5x14aFvkev/KUa0/8dpDUGamJGGZPnrjpQP4Kiib+5dkvUG3ZqJqIFqFJ4Ius
 EbwNYXD5d7conpd3okuGQmYRJF2Zo6c6gtyAKGkdMYverkxe4hh4fdsDe/noZPIaC9A+ioZe/ns
 JZIVGiA6zWVUmfLKZGr1vGNY1x3BrVxobWqKnTDRf2OyDPkQUF1Agrt0UFKnhOb/aS+9JpZIMfc
 Ot1zOZIkMo3fuO8ar+t7lfq0t7uBK9BHZk+YIRn1wMmKxlwMklBSIq457St0kqPn2o8wplgh+Es
 zmZoiTveuTV3vT2IHugoxxEVGr+1OAB17C81UnZMkbz2EM0OZX4ca8k8Ii3l8/LSfeSDLMKh
X-Proofpoint-GUID: xe8p_tYMySQmGzwzNBZmKAs1GRJCECRh
X-Proofpoint-ORIG-GUID: xe8p_tYMySQmGzwzNBZmKAs1GRJCECRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=750 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230187

On 7/23/2025 4:03 PM, Konrad Dybcio wrote:
> On 7/22/25 11:37 PM, Akhil P Oommen wrote:
>> On 7/22/2025 7:25 PM, Dmitry Baryshkov wrote:
>>> On Sun, Jul 20, 2025 at 05:46:17PM +0530, Akhil P Oommen wrote:
>>>> Add the IFPC restore register list and enable IFPC support on Adreno
>>>> X1-85 gpu.
>>>
>>> Nit: GPU
>>>
>>> I can't stop but notice that KGSL enables IFPC for a bigger set of
>>> SKUs, starting from a630v2 and a615. Is there a plan to get IFPC
>>> supported on those platforms?
>>
>> Sorry, no access to those hardwares. But I can certainly help if someone
>> wants to do that. :)
> 
> Let's get the groundwork merged first ;) 
> 
> Nowadays you can reasonably assume we have access to at least one board,
> no matter which SoC

We just need to add a proper ifpc restore register list for most
chipsets. But the legacy gmu firmware (a630 derivatives) might have some
quirks.

-Akhil.


> 
> Konrad


