Return-Path: <linux-kernel+bounces-743122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EEB0FADA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E366188EFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8B221DB7;
	Wed, 23 Jul 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ej0NzkNI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90B21A42F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297914; cv=none; b=oxnyBPANLYQi/Y4Pdle2hU7kpRDpiCd2QjrR4IfYRO+BVyeYW0TfQXvkSdPGBW9z4vhSjPDWHNPVDLNy8b51TzWXp4uHsZvWgA2UYGnulAGvNU4/U5kzn8xinHPx3k20Tz1UtPtoT+z+EPGIZet5jg1lkdnrRlC27Q1ZGw0f/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297914; c=relaxed/simple;
	bh=rjMF4SS+OV0lz6i4T4F6UW1KEe904m37qQLEFlE8G88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riO2Q3Naqd28c5Jo4EXsTxJxvHZ8Y5MyMuhZJG5mqMLdLiIQ3TzveOMyXFHtmf2EoVlnFuGOrrDpLmLc+8+jXlxUPsMh5tXh8S8QovNWusbsdMjxDqLHAjvLg+Skt2q3b0bC+eSe435ySkk7gJUpuhpdVblyXnR1LIGy124dWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ej0NzkNI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH9Epb020004
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V9jA6Mn1SUrOwM4UhmLUB7hjDyvroazQdXjiBfsPsCw=; b=Ej0NzkNILdycTX5T
	esuaRP1GVX4zJvOHh8fOZB/+MpZnGQecrdbCk8vy/8otih5K7GO/k0FKrWARUsTj
	bwKdoLFdhLYDnntf/gqU/InnPDXFshmXQG5tMb/uOK/gygRBFZ08xctthVgijDcu
	oPnjpRtyg935NMbiUlFSgcmQ4use9cVUtD+SYC8npC3IjlR5D9EIDRrCssMR4elf
	V4ZXt9nWXPEqdO+YlPN/zGVdz30g6U3iUGjvqwMayeainleHSlvhHnz/KxLBu5CX
	wDJLCt+oNAel0kyA4NQIe1oPzsusSZrmhIw1dpjyp1jD4BOyMxgYp+Aqm38ZfIlG
	wC31cw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3es4ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:11:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23689228a7fso2263605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297911; x=1753902711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9jA6Mn1SUrOwM4UhmLUB7hjDyvroazQdXjiBfsPsCw=;
        b=Jve9gdeeryZshQ4x6bFdvg711pT4u9P273ixLYAskYR79/Hql4aFoda0ZjlUYVN4Du
         Gb1tjKJhC4ZiUGuDB0pHc0F8qLrSqIWNjIu4ikK58IRGpj1gAY7QdXwVZ4p1OyZ++5Lf
         VbuvYbgNcsFH4sOTbtGBN+lCdL9HS4GevDZ4i0UJgMe6iBLnj2cAb0rMA+cnySMlosXq
         C9+4r5xzc4pK6Ho2RJauCDUgBddvi03zxzv7ULfyf23t4tpuaQg6VWFbxfWQQSuPhTHe
         FK6Op4DVPIH5YYF74qv44yx6J9t6ZlekQFYqF2on0r/DdwmhOVpMj2vnrSdrZhpoPbbh
         15nw==
X-Forwarded-Encrypted: i=1; AJvYcCXuzq479HEi1MiyhAGPWf/pk3fmtvo1P6PHm8G439ILqLXPg0l9KYZpmtGmgDLDis4UqLkdiRPnnCNEBeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTV8KIO3RpNUMOg7pzSiI0RqVqny851GVAo6ZzpudHH0Kc7gyV
	rv9lcNH2xB2DI64QT46r2B0pS9bE3WMFRC5mlPRaRGaZfy2GdqymT7/HYZL21Rqqg3rvWkVFzBm
	51uDvMbXQWtpdpVgmbe2Xpt1lLoEa0Qrh+2y/Ah3Ip8/zmFUx+kjZheZ+azx/8lgIfgQ=
X-Gm-Gg: ASbGncuPeomZ+Hf4hcgOLz3vnX5+R2Um5UoCB3dVSCrMo764gfhy9/1uw/ryvdrqP4v
	UifG5imLMsNZm9jWY8p5kHlhc0InvPqkMbawpKoUMlgBC6s7q1NrUQ8mrbxZeW5yCN2dTcoXvsw
	MTyFuJPqizBKalgqIRCywgZ6h5uuJF/nYlWFL00Pq1t5vdjY5o5fiHSUC14tXjfA1cvmykbaDAD
	yO6UCTS6+JjjqvZgRDkIfByA7WfaW0EONVtxiKS+ve3RfZl1vCFkHftK1YOBsOqLu0TfcJtMoWp
	fKXlFE/2sppKm1R1o3eEAkdFBOKL9CuF1Qog8YYqN+EPpY04g0PiXNX8bmS+cn0Y
X-Received: by 2002:a17:902:e885:b0:238:120:134a with SMTP id d9443c01a7336-23f9814034bmr71876825ad.22.1753297910879;
        Wed, 23 Jul 2025 12:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE6DGeXECpuu6lms2ga/Vg8TctuO58RgApUp7nY5NpQJNo+xZQMgkHkcbiQe/1P/POntb0nw==
X-Received: by 2002:a17:902:e885:b0:238:120:134a with SMTP id d9443c01a7336-23f9814034bmr71876565ad.22.1753297910432;
        Wed, 23 Jul 2025 12:11:50 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e4918sm102288265ad.41.2025.07.23.12.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 12:11:50 -0700 (PDT)
Message-ID: <135cbad8-6c33-4a0c-babd-31477d9be4b0@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 00:41:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] drm/msm: a6xx: Fix gx_is_on check for a7x family
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
 <84a33e15-edaf-4951-8411-24b17ee5f4f5@oss.qualcomm.com>
 <62391e11-2f26-4e30-9c8d-b47d4985b41b@oss.qualcomm.com>
 <jeg4dw6wpxpfaio5kd5vcbqswq5nlclor7tbbh7er7zlwgdgxr@ksrw7waxj3mp>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <jeg4dw6wpxpfaio5kd5vcbqswq5nlclor7tbbh7er7zlwgdgxr@ksrw7waxj3mp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lVFS4zN8nRFfHMUU_G5_2w-vyvQsbHed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MiBTYWx0ZWRfX7YJgM/ZKeTgB
 Wis+PQ7bdpQO82QyGdWXAQxLCx/0uapZyynTbgInhlJwqKPjKNQURuxKxmPEVaIZkngExSMht9n
 ulbs6830Gd8bOeM9IIbGT3fBUWZJ9KanSP5FqGg9QSP7SPXq6RI7GSS9JqRKyvHpdwn4Tbz3n9r
 AUFABKBojx8pS3rXWwCx/ynAC3EzdMbzkEoQv5X5aC4rgzhKgnDTwPjb6KKrE8ZVn2l9AOlxQz6
 FXgC/vJ5F7keipQBMqnXzwT2juOD914vUmuKDU1WSxDI5De7iIhhD77TywON3EZn40GC5AuLXya
 VJGkiZYMU92WfLRamFtCzsMItdPOmsJ+9sZdx6tOnIrdc6zsfafz+UkuIzjCeTuHWRWmkSLpwNb
 iucWMDOc1iwqtiqB/JOQ13lG4wGd7y8BdAhoaUq9d/4LT2qTzX5xbWF/OFrrifht+acbEjfq
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=688133f7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=R4_TJjaFeOAkSM8ik1MA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: lVFS4zN8nRFfHMUU_G5_2w-vyvQsbHed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230162

On 7/23/2025 4:40 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 23, 2025 at 01:22:20AM +0530, Akhil P Oommen wrote:
>> On 7/22/2025 8:03 PM, Konrad Dybcio wrote:
>>> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>>>> Bitfield definition for REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS register is
>>>> different in A7XX family. Check the correct bits to see if GX is
>>>> collapsed on A7XX series.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>
>>> This seems to have been introduced all the way back in the initial
>>> a7xx submission downstream, so I'll assume this concerns all SKUs
>>> and this is a relevant fixes tag:
>>>
>>> Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Dmitry/Konrad,
>>
>> We don't have to backport this change because the existing code reads a
>> couple of unused bits which are '0's and that is okay when IFPC is not
>> supported. So there is no practical benefit in cherry-picking this
>> change to older kernel versions.
> 
> Fixes tag is not about backporting. It is to point out that there was an
> issue in the original commit which is fixed by a new one.

Ack. Will add the tag. Thanks.

-Akhil
> 
>>
>> -Akhil.
>>
>>>
>>> Konrad
>>
> 


