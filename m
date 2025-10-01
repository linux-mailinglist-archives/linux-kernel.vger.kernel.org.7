Return-Path: <linux-kernel+bounces-839560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB9BB1E61
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B4419C270C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076326B0BC;
	Wed,  1 Oct 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgHtWHf4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC4238142
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356025; cv=none; b=Y+017lDYZDWs+mu1DbnWOHftC2R6rCxkZwidrnHtRGg+1m6PUSN52845fPuE7rSL2F4ww3xFEWZZdrs4jQ7dc6GF13vXHgLa6xuNQcJPKMAfAGHqZGNsv9Dml851Q29jz3aJGdM11Y2uve8Uamwo9WB3sNqDz0tK8ZwFuozd8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356025; c=relaxed/simple;
	bh=3SL8gHgb2F2B2yMJ3Cg/CJbBBzaA4S3zZaf05zamQ8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF7sCXx9Wu3f0nK1+B6qaTZgWTijra3AI/8YoNEcQvkwG6Dnd4vP0ebXVezNPYH0gLlZTt+vzw9CUYXEcTggEJ5LW56DwK0AF+weax8Ixe5UpezSp36nnXBC9fLvih49GMRil2uyz0rborgzjQfOwId1vAKFhVDlhPAepuoL8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgHtWHf4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbvWw032113
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tahmT1PTe+yL6IlloLfwZS8CDuOsIe0H/cgXQSKTibY=; b=CgHtWHf4QYacRtFJ
	F55IPjX3GrlHxD9+Uk2GBUIWvPe04OJTlGfiOBLVizXpsvXq2htqbPQIxYB8YQLL
	I+01S/mg2sXAa7/wg/4t8NA1nGxdG62QHOoKkse6x6Fc6nEtSHHPlQS7oP9XGNEQ
	spwVW+ry0HYHyHGtE4p2L0xIEesd0dmOmoH1MT6P0CQiriUpb2bo203GkdzY8M+h
	sh3Qxv/guKzd1GbQTBAaAtVwZnZ4aM1aUA/n9MusX7I2H5bskLKK0Bblg2LS9ikR
	6Q/OUmO0yWuWb97dyyT/wmVpFnYercQ1EuTL/FI+7W/GaDtETryK2nr8/q7OlOqG
	Z4+Ulg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5x3s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:00:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78038ed99d9so509660b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356015; x=1759960815;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tahmT1PTe+yL6IlloLfwZS8CDuOsIe0H/cgXQSKTibY=;
        b=STepxXGA1H8FN6hRlbJaZ0d/gM5S7J+GESoTS2t5UWbrmRzXLpj3PtGJbMO+H2OQ3n
         tjXy8g+TX0UFFxXQAworZpecyCXwOOij+t3mzrmYI78V+H2/N5RmZbRh2Hx/Dnd+Xskr
         qXtc4pylOxlT5FVjq/NagCeGZv8jBixiaexBvxCjBie0OqM8RcDJLD/EPZierpudIBBX
         V0t4t3KLXYgymyT//bOoRM+38P4iErXTT5uD3wVDu3p/HQhCrTSkiJT02nmXyFyNpYKm
         faFNd7DU0eU2EChysmnhsMksv6MpmC5rEr9OcjYHMqUzewAUuiM876S1syGPaUNT4NU0
         Dltg==
X-Forwarded-Encrypted: i=1; AJvYcCVVMZDw698J887TaI+aBXl/PmuDBoaEKW7dtT2WZv1S1qJTwCmdVoGLhaaelegc2jc1GBtmR8Cl/KLCJMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfA5E+I8293G2/vci9QorEYOMdvG4iJeBEyaEeetK+iT3wY8F
	hTktXymuOTQ97iiw6qVSJbxW5cv6uERnmSThVaYC6VhTpky1AzqlrjU+gTHhWsbgL39yzLVViyx
	lmkHHfYD+dF8HDRpkU/z9h6+VjDqvRK/HXEcZLxyguPtxUsapnxnH01f1th1ZdMlwUls=
X-Gm-Gg: ASbGncu5fNk1DpCqU5IA9oodcKBWEcKir82FbqLE7EGQy6WbgAPvqjqecxrNMi89Da/
	4cY1NMfALQ1L9pz3ytfl55b/AlCCxNP72Ex2kBHZK+X4bKgNF+bbGCgyky/jHuYu5tkOwojBmo8
	tTvuFsACSmMWkvqaOmY4UG8FCDJWlIncYgwwZQXatZVqsIoL/Mr2JdXH6ejcZHunu7eeGEre+m9
	veExbRPjcSZSMlf8D0Alx+jWCPUmGzSEc6S/ZhgOFth+bpSgiA22G/zxYsVlhN5/cDiuaXGyLnc
	O1IQx5/mgX+i3kkMuIFos0WdqA27XoMQ52djCtH/6DVpm7OEw49/ZaI+XP5FbTmmiUk=
X-Received: by 2002:a05:6a00:98c:b0:781:b23:6b7e with SMTP id d2e1a72fcca58-78af41efa31mr5716883b3a.15.1759356015488;
        Wed, 01 Oct 2025 15:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHifSlan3h5RBjjCLPaJeaE4EOWmKdwWuMjDg/ZbUeJT6bjRGbcINV4nFTXqWDsiHfMn8qoQA==
X-Received: by 2002:a05:6a00:98c:b0:781:b23:6b7e with SMTP id d2e1a72fcca58-78af41efa31mr5716824b3a.15.1759356014792;
        Wed, 01 Oct 2025 15:00:14 -0700 (PDT)
Received: from [192.168.1.9] ([117.244.71.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020938b1sm636738b3a.83.2025.10.01.15.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 15:00:14 -0700 (PDT)
Message-ID: <26e29a80-df70-4ffb-9cc0-8b1ab74873ce@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 03:30:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 13/17] drm/msm/adreno: Support AQE engine
To: rob.clark@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
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
 <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
 <CACSVV01UygpiUj0m_Ppd_LSxvW0MFunz+Lfhg20XHR7vyOBx7w@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV01UygpiUj0m_Ppd_LSxvW0MFunz+Lfhg20XHR7vyOBx7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fVB_8Ax5kGpJ_bK6kfzL0xg2AwtPrfnx
X-Proofpoint-ORIG-GUID: fVB_8Ax5kGpJ_bK6kfzL0xg2AwtPrfnx
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dda476 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=2kejHg7nZSoTgEpwAwsXNQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=neJfBgYAGg7YAZYFY1IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX6wmPrTKAFIwh
 fCk8Tf1APRiNi87JAJTy8QZOyNS10QH+qQNKpnAsY2bupzwjcTfpkSPsRlCMTAlAINOAhw2wih9
 fYgiqM/tE3b2tlSXjsQL9kEtuKRWWs+En+uQBfFInJ7FlZgnLRL6hc313JCTP1lMJ/+jWL4j7eT
 ChRZbV0mLwI1aCDOoPSMVfHGuQNkAoYW3dDkXccEqtc6Hr/I0S7EkWO+kcLGuUVe6GxCPYMhT4x
 Q28uFv11ZWM3wPTELSAMRn8bD10jtU3Nbey+TglI/3q/kF919TcYjRBQymzrhjwVqHjChuAyvxq
 W96iA88iDETMwdFZOiHRB6Ae6YA5ZHz3eff0n053Luhyo66zbWVh6ct/XTZgkMw7RFPt8VChGzP
 EYy2waz9AF3ywh9v0EucvBekOPhflw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018



On 9/30/2025 1:57 PM, Rob Clark wrote:
> On Mon, Sep 29, 2025 at 10:51 PM Akhil P Oommen
> <akhilpo@oss.qualcomm.com> wrote:
>>
>> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
>> in Raytracing related workloads. Add support for loading the AQE firmware
>> and initialize the necessary registers.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 24 ++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>>   drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>>   4 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 4aeeaceb1fb30a9d68ac636c14249e3853ef73ac..07ac5be9d0bccf4d2345eb76b08851a94187e861 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1093,6 +1093,30 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>>                  }
>>          }
>>
>> +       if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
>> +               a6xx_gpu->aqe_bo = adreno_fw_create_bo(gpu,
>> +                       adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iova);
>> +
>> +               if (IS_ERR(a6xx_gpu->aqe_bo)) {
>> +                       int ret = PTR_ERR(a6xx_gpu->aqe_bo);
>> +
>> +                       a6xx_gpu->aqe_bo = NULL;
>> +                       DRM_DEV_ERROR(&gpu->pdev->dev,
>> +                               "Could not allocate AQE ucode: %d\n", ret);
>> +
>> +                       return ret;
>> +               }
>> +
>> +               msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
>> +               if (!a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->aqe_bo)) {
> 
> a6xx_ucode_check_version() doesn't do anything for aqe fw (but also
> a6xx_ucode_check_version() should probably bail early for a8xx at this
> point?)
> 
> OTOH if over time we keep growing the version checks, we might need to
> re-think how a6xx_ucode_check_version() works.  But that is not a now
> problem.

Copy-paste miss. We can remove a6xx_ucode_check_version() until there 
are some security or any other major fixes in AQE firmware.

-Akhil.

> 
> BR,
> -R
> 
>> +                       msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
>> +                       drm_gem_object_put(a6xx_gpu->aqe_bo);
>> +
>> +                       a6xx_gpu->aqe_bo = NULL;
>> +                       return -EPERM;
>> +               }
>> +       }
>> +
>>          /*
>>           * Expanded APRIV and targets that support WHERE_AM_I both need a
>>           * privileged buffer to store the RPTR shadow
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index 18300b12bf2a8bcd5601797df0fcc7afa8943863..a6ef8381abe5dd3eb202a645bb87a3bc352df047 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -58,6 +58,8 @@ struct a6xx_gpu {
>>
>>          struct drm_gem_object *sqe_bo;
>>          uint64_t sqe_iova;
>> +       struct drm_gem_object *aqe_bo;
>> +       uint64_t aqe_iova;
>>
>>          struct msm_ringbuffer *cur_ring;
>>          struct msm_ringbuffer *next_ring;
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index 6a64b1f96d730a46301545c52a83d62dddc6c2ff..9a09ce37687aba2f720637ec3845a25d72d2fff7 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -599,6 +599,9 @@ static int hw_init(struct msm_gpu *gpu)
>>                  goto out;
>>
>>          gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
>> +       if (a6xx_gpu->aqe_iova)
>> +               gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
>> +
>>          /* Set the ringbuffer address */
>>          gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
>>          gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index 6a2157f31122ba0c2f2a7005c98e3e4f1ada6acc..3de3a2cda7a1b9e6d4c32075afaadc6604e74b15 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -27,6 +27,7 @@ enum {
>>          ADRENO_FW_PFP = 1,
>>          ADRENO_FW_GMU = 1, /* a6xx */
>>          ADRENO_FW_GPMU = 2,
>> +       ADRENO_FW_AQE = 3,
>>          ADRENO_FW_MAX,
>>   };
>>
>>
>> --
>> 2.51.0
>>


