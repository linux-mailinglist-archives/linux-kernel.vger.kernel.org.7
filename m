Return-Path: <linux-kernel+bounces-785184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC56B3472B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AD32A54CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4752E7F39;
	Mon, 25 Aug 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l0IsHYm8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D363274B56
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138996; cv=none; b=qsIAjO+/zib30LxVOMkuAhOLD/x1+QcGaxrEQObYU5CvMS1d1PMOtxh+nwvUHYT0PtfBFZlGJxXZBDbS+VRNSq7Vhhv826aMYNhOai+3WHHoo2GmwuhhYITLffK4MrSZyN0OHkEAtSdiYiajAiH8FtGBRjh9py4xvX9PzhJoE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138996; c=relaxed/simple;
	bh=Ic+Wi+QSgnS5gFlavR/eRxT2p6/NMPQaeO1MV51PFDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0jcjYkrRgLBQHwm7b53u34YXM2mna+RSBEn7PCqUrOVZB5vVOZv8cD6FYmQYsYOvTFPGLcUWlQCY3tgl1kyJWmxA3Au/kCxEna4K0PQUdYds1Os73coA0RFd2wLpH4XDUBJguSnwzuo+quVh/IkLYA61MKn3uwQcH89gyZE/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l0IsHYm8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PG9ahZ006049
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xT06D3RMtfKindU2hH6cWWUxy48f/VTeJ7LJts2PzLo=; b=l0IsHYm8ZLqNxwWE
	19BVYhwsOB2Nedq144wm1aq6qmdQ+p0aqo6p4khH405fJo81CQndAxNXAcAJLT8d
	J1CYwL8IjpN/SmwBjMpBQDD07bYCMeSG/28co0kPOm1Ks+4KyzutoKkBywZfkUsd
	/F30GNa8dbSYsJV5qmGlanc0UyTVMDqaSpJKtBjqMHI2/XFG1gohnlw3+MR6xkFe
	cqVGOc9Vk92JSW7ZTq9GYbV2k9ZVAK0PBMy0xncsqCo7JYFt/yH3DSQdbCXozRxr
	aM1LQw1gpcpAymzttOtRneJdP98+HikrKzte3OcHntAuCG8oGixOaR6olDyIOW59
	GGYEdg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thwrt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:23:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-246088fc25cso50266525ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138994; x=1756743794;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xT06D3RMtfKindU2hH6cWWUxy48f/VTeJ7LJts2PzLo=;
        b=uaTMS84vhawdb/33U176I4rCh6wH5eWNp6Kix6DOB208mW70TTt2xMtqQU31mdUEv+
         qtz36Zp/KD1cpP2OYD0yi6OW2whRAAtnS5mKDxuIlGUrcWaHvULEhbnMi9lOHO7NJ7dh
         O6/Rn+qsiVDdHAvGOltaGluKfBWmJJ0eewpdJLCQ4GrfB1YHtQbXQS7LNJJ2+WpycI5+
         BtAhP6aUVNeKocA4DS3XAE5Nf3/01oyT/uAPtuHPOuOpDIXPYUgxTYS/suO/ANBnfte9
         cvtCuRayeEVntqvs4CTp/gNqv14fJia3HAP4d/dWBjU9wh+hy2U/+cZiIz2ZaotMBTAG
         DjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEeqlXmYuE0oig+M9hmh0djHeqn+2VcGXZlEz/soLOyispDzaKrAH0qML0muFZ8biKk1ZMTs6kpelzi0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6myOAklYxdINdp3czj1kXeqoFWIvKdGaPFBe+rRMqU7BnzQw0
	jepmEIvURBAiB3Bl+UDiXLxeDRjLdKwIIRR62OPU8PYKZWRYCOAy2HYGo10+K/+slyxBL6hPf3w
	VeiMY3D9g10mUS87B+H2prIr9EaihrSq6K68Zn3FBZ+hiJwNBpQ+ewicfYX1VzFvVBPB33iQ+OY
	U=
X-Gm-Gg: ASbGncvU29zgmtYth9AE5RAwLtWW+I+BLlgXO4tEUoLYQB4zGVPKQ18uZwwvH1J1gut
	tWRUwnalLZx20e26+J1K/qvCOeFu7P4hZVyOOFVdymLjJpMtxc+k5L/ADocgNAW8ujLo9g8pf3n
	CqcpGa3rGzqrIiDDnLsQW12DbLrxXSJwtWokV0fFG/873fAD3kc+NDHdTm0W5cpND9NentJWADA
	7by3ZSCbSUzdkXHGj+bE71GSrRUlPDjrTqq8M5XFaMG+91puR9wVe2IZZLRVrR5EDlgs/0JKvxE
	F/4Ujk5L/3U8MGb65zPUXlP6P1KfjD5I21bxhdCtPCw43Pdvd8oirLR1v8t0sw==
X-Received: by 2002:a17:903:2281:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-2462ef4444fmr164017055ad.35.1756138993503;
        Mon, 25 Aug 2025 09:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3DDyXq0HbIVkH89aU17F4O+BE4oPf252DFOqa7KvXWd8OP2tBXEimcEdWPIlxPlDOWeBx5A==
X-Received: by 2002:a17:903:2281:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-2462ef4444fmr164016785ad.35.1756138993054;
        Mon, 25 Aug 2025 09:23:13 -0700 (PDT)
Received: from [10.91.118.43] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885efc8sm72180705ad.90.2025.08.25.09.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:23:12 -0700 (PDT)
Message-ID: <5a405510-3eec-4262-9855-483dd589d8dc@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 21:53:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: fix race in Adreno header generation
To: rob.clark@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alex Robinson <alex@ironrobin.net>, lumag@kernel.org,
        abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250823020919.9947-1-alex@ironrobin.net>
 <6sdzghcc4uynvmk6r4axpwgqlmgxqzi457ttedqlrql7f7lt47@glsrzu46a63x>
 <CACSVV01R=FPAErpfJJvESKig+Z8=amEkpf6QFnkXHhTjFsPf5g@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV01R=FPAErpfJJvESKig+Z8=amEkpf6QFnkXHhTjFsPf5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX0SU1h8yGRO+H
 8jUV8X7mN7EBUpCSEFydQcj0qEfO+cMjZ6u/mgQyzsPXD/jJS30e/nle43Qo397731+ZJAgPk1D
 OASGRLkppyZZli88+K65GkbWQr8d+dZNNFHuR+snK2OMKc52FifiGKAFqIpgnfFSVu5mMYVt7BW
 ek4SDBktvKoiVejTOcoQfYX/msvgJTol1Af/Q+Ax+A4FYBe+hu4PdN8GZ47DkUCn2Y3sJUULnJr
 N5gdzuYztdf2MT966dk43wuWVefgXEUPcOxVU2iT/kCnW26ca7boM/oRypJM+MyK5xkwtXMDP2F
 +RjkPXOTBbk0Vy8eXJenyxIdCgclmBb5/4BLyfCSpTakxCULxMAVsy6IhbMlXQ0FEccNH783jT5
 TBucXfo3
X-Proofpoint-ORIG-GUID: -JtqrFsvb1VPQjMPl5DyVdBtaVtS1eEg
X-Proofpoint-GUID: -JtqrFsvb1VPQjMPl5DyVdBtaVtS1eEg
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac8df2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=foaXouvCAAAA:8
 a=qt1P906IrRIBMUR0lrMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=lBkOZJTZZNyIbKe29SIT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

On 8/23/2025 7:46 PM, Rob Clark wrote:
> On Sat, Aug 23, 2025 at 6:49 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Sat, Aug 23, 2025 at 02:09:39AM +0000, Alex Robinson wrote:
>>> Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
>>> before adreno_common.xml.h is generated in trees that generate Adreno
>>> headers at build time. Make msm-y depend on the generated headers,
>>> removing the race.
>>>
>>> Signed-off-by: Alex Robinson <alex@ironrobin.net>
>>> ---
>>>  drivers/gpu/drm/msm/Makefile | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
>>> index 0c0dfb25f01b..1a918d44ac48 100644
>>> --- a/drivers/gpu/drm/msm/Makefile
>>> +++ b/drivers/gpu/drm/msm/Makefile
>>> @@ -221,6 +221,7 @@ DISPLAY_HEADERS = \
>>>       generated/sfpb.xml.h
>>>
>>>  $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
>>> +$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
>>
>> I'd say, no. The idea was that msm-y should not depend on
>> ADRENO_HEADERS. If there is any dependency, please move it to adreno-y.
> 
> probably we should s/adreno/gpu/ and move all the msm_gpu*.* there..
> 
> In the mean time, I think we were going to drop this patch from the IFPC series

Yeah. I will drop that patch.

Btw, was my usage of adreno_gpu symbol in msm_gpu* files incorrect?

-Akhil

> 
> BR,
> -R
> 
>>>  $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEADERS))
>>>
>>>  targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
>>> --
>>> 2.50.1
>>>
>>>
>>
>> --
>> With best wishes
>> Dmitry


