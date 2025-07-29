Return-Path: <linux-kernel+bounces-749764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30BB1529B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EA1547A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47D239E66;
	Tue, 29 Jul 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2TITawp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB5239E7A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813205; cv=none; b=SgUyOB8EVlchcDm9ComM4/WegU7vy82wUSJUQdoElKl78m+JtikjYz8DxwMNoSVDt/+IAbqZBDILb3Q3Vv9uHNuH7+CLqAjhdcnbjjBwiNZyQG2312GfbOs7BVgEnAI0SbYdFV6JsQm09sHMQRKK2JdfPP8hvUTRSzqUUVolMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813205; c=relaxed/simple;
	bh=VDE+uz8ZRjuzdabyq1FdVvOSD94+IkhP09IItTR59+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM5u7odXA1j6eZwT3nIrs80//UiOPqDHVmf87sYKxdHwxMZlpPB5s7Xr2IE8oAN8iFoCGSKeB02B2W9/QVFV06u2iJHXv69IJQ5k6cYpDVCgBU9Ru85dZhy0mMHp/Ousgxru8r/L6UFIYjU3E7y1IO9w5b834Sl7Qt5uTdbNFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2TITawp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9djwR006594
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lcsta1yjIbei4fuovlusUPalhkFx/bRo2Mx3CVdJirA=; b=Q2TITawp04pzzAhu
	xgbOv/S3s9a9GWetJyEZIkSGmrKEpvOPuMlD7Izf4baGmdaurpXRt9l+ANFsEoWu
	w73V3gK+5KM5/kVy9RKGiziNE18pFPqGNZWLvJsTjQcopKW5Tj/kb6/8OXuBN5CB
	L7NUd+ZIKA8UdLD5hblJYL170pAh0Uow/7/7cveYRpNmfzURSX2MvJaL1VE98tys
	v/8jgbJ7/PaJq0mPYXyYPx7SmFX+mlgm3Xl/WcOZiJbSJD8FySltSjB/Y+gE8jjC
	84SlWIWs7NzpLOUN5rCISI1Dt0XWXK128LqYaozH+l8WFR/OPo34NSIP0nz2WtPF
	AHn/Lg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr9ams-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:20:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2400cbd4241so29698105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813201; x=1754418001;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcsta1yjIbei4fuovlusUPalhkFx/bRo2Mx3CVdJirA=;
        b=BWsRYxQMwZRp+Um46sqrJ34UwtNrYzK450/k645FDe66D65th+MaySy3XwC4Wy/EdD
         Kl6JbMQzjbUzW71v13QaihTvymXuB6aJq46EPQVMQaZw3JJQMu5aZWm2hQTBiKmNWDEC
         gNLXCTDEsfZVVeovqtED3DfTKoNdQpjoKKcClQ4ESWB/Hct8/sUwQQ/epccnLqjMIPvM
         FcWY0je0nYslmLiMyHFfHlQ+CbPFcFdGJwtgiqExRyj1HAfuEHUS4yN2aHMRJkxqlj/9
         6CsiMA66bE+ezMOAp5Cj4MfQJQdY/6zN0cbKNQW2zt/NnBcOPhHgeM/0idr+ru8bcDyA
         TjIg==
X-Forwarded-Encrypted: i=1; AJvYcCXM0WdicBpsDLy7gGU2MPIfhFfWe0lRIm7F/mvimQGp8RZzVvjR/cqeD9E2qavESBt6YEQ0fOn8/R0x6hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzklAhj+SYl9ji31QTfzhPrMqsMCYzzCGvUpHmPpyQPV7UUDdQ
	2OLnYpayQ+GN5N8kH2j1v7MoidUjg982IUIogV8/eV2IHgxxpfHMjKEarWu4noi5mWaAJaP84TT
	p4Mzx6VU7hYqzNKMcPi0M52/DG8yW6ISSy/Z/F7GkrFx1GpBfUbQrDbrmW5mjTrOAyfdS5Etlzb
	w=
X-Gm-Gg: ASbGncvLNduoXtK6tIEI2xG/0skaxfZOHFCYwXexCXxW1U5Xt9nDKr8u4xpmDY8JPqh
	oh2/kSG9C0iK94eOaBtD7UJJPfA82wf4Z1MQnTtwh6xVFelPGINRC3AuoVViacn0AeFrzBzthBg
	cvH5vywn6QXVCUKkP/LxK6Wjb3KRwDULThHmo7UipgyoyGrC3lglaxeXKnqHZMXOUUyg/CIxHU9
	OZ8aeM0kwHGRao7r4ABTi/eb6PQI1HCDfg3YErReIzwQnTXxBXtDKvD9Y5UF+IDkgGceIqkmRDr
	ARHCm9uCLSQAZND2QEsryfsw0uJQrwwEoFCBXdQT6zstqne0CAX8vrA0aGmTdKMS
X-Received: by 2002:a17:902:d4cc:b0:240:6406:c471 with SMTP id d9443c01a7336-24096a4f7e5mr4814345ad.10.1753813200870;
        Tue, 29 Jul 2025 11:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa6BasIaRExFV/BwNT4qsayfxOvO5gmjUpfnYyJ28K3IONSoxFXWJUahLqssfmGes+zOsqug==
X-Received: by 2002:a17:902:d4cc:b0:240:6406:c471 with SMTP id d9443c01a7336-24096a4f7e5mr4814125ad.10.1753813200416;
        Tue, 29 Jul 2025 11:20:00 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.231.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff1dbec8esm68679145ad.194.2025.07.29.11.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 11:20:00 -0700 (PDT)
Message-ID: <c44eb0a7-3656-412e-8b21-fdc52866c0a4@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 23:49:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] drm/msm/a6xx: Enable IFPC on Adreno X1-85
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
 <cfbad162-e629-45c9-8436-74bb6fc416f2@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cfbad162-e629-45c9-8436-74bb6fc416f2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE0MCBTYWx0ZWRfX+FcY8UQl5rIy
 tG144ekoTdzTbBsuXqv89sMYI/2yOpOB4pbu8QfZkWFWVUcwEgjE3WjWEzcKm4x29Zr1fQCvP4V
 UQn/oL48+ZyfuRfx6ASYcTCUhHU2yZ2hcGr/7Eol/RtgCba92Lmz/JEtMAeF+CYBmZlk4mN2V+6
 5xUcChrDxc5OfMkkTWjEX/8VL6ODM0DMb2z11Yb+rOSLM91lJLdbJ0FAtNKQ2yA6hR+jAMS5vE2
 s5gxKkpTFiHz2WQKTd77niulOh7CRnVE4jabKzAZ2aOwuwejnKmwytsUA/1lKNAcOcexAa5j98s
 +uihVHYDnOQbLWlWqy9BL5bYsQ9QtdGdaMWl/5Qml6+Odwe0calrzH0ozkqaTW2YEBILIVnppd7
 KFyxhm6eLPdSrcN2xq9K+fewPFeZalEY2tCnNK3Cj6LuN2gky8/qTKmYvmWr2LnLPlpp7oIz
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688910d2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9XpMM9ZEX5jLuhR58p3+Fw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=oxwwQDlBbdW4oIJT5RMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6UJDYCQ3wVxkhHn505wHUxdSeCAn--Oy
X-Proofpoint-ORIG-GUID: 6UJDYCQ3wVxkhHn505wHUxdSeCAn--Oy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=960 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290140

On 7/29/2025 7:36 PM, neil.armstrong@linaro.org wrote:
> On 20/07/2025 14:16, Akhil P Oommen wrote:
>> Add the IFPC restore register list and enable IFPC support on Adreno
>> X1-85 gpu.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 67 +++++++++++++++++++++
>> +++++++++-
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 15 +++++--
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>>   3 files changed, 78 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/
>> drm/msm/adreno/a6xx_catalog.c
>> index
>> 70f7ad806c34076352d84f32d62c2833422b6e5e..07fcabed472c3b9ca47faf1a8b3f7cf580801981 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1343,6 +1343,69 @@ static const uint32_t a7xx_pwrup_reglist_regs[]
>> = {
>>   
> 
> <snip>
> 
>> +
>>   static const struct adreno_info a7xx_gpus[] = {
>>       {
>>           .chip_ids = ADRENO_CHIP_IDS(0x07000200),
>> @@ -1432,12 +1495,13 @@ static const struct adreno_info a7xx_gpus[] = {
>>           .inactive_period = DRM_MSM_INACTIVE_PERIOD,
>>           .quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>>                 ADRENO_QUIRK_HAS_HW_APRIV |
>> -              ADRENO_QUIRK_PREEMPTION,
>> +              ADRENO_QUIRK_PREEMPTION | ADRENO_QUIRK_IFPC,
>>           .init = a6xx_gpu_init,
>>           .a6xx = &(const struct a6xx_info) {
>>               .hwcg = a740_hwcg,
>>               .protect = &a730_protect,
>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>> +            .ifpc_reglist = &a750_ifpc_reglist,
>>               .gmu_chipid = 0x7050001,
>>               .gmu_cgc_mode = 0x00020202,
>>           },
>> @@ -1459,6 +1523,7 @@ static const struct adreno_info a7xx_gpus[] = {
>>           .a6xx = &(const struct a6xx_info) {
>>               .protect = &a730_protect,
>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>> +            .ifpc_reglist = &a750_ifpc_reglist,
> 
> So far it's stable on a750 so I think can safely add ADRENO_QUIRK_IFPC
> here aswell.

Thanks for testing. I will enable it for a750 in the next revision.

-Akhil

> 
> Neil
> 
> <snip>
> 


