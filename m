Return-Path: <linux-kernel+bounces-728032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E7B022C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2909F1C285FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91052F0C75;
	Fri, 11 Jul 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0hYY/nr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9364219A91
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255648; cv=none; b=ROAxlQNG1dWF4KQjSOglPCUmop7ix56DTNXB7UvzqYd/s/s/QlYWvvywATOkgXOrZsyeiT27gpFOG94h60yMG+fjQS4oPwPwvYQ7+APSSXWd/M++2GGJ+90sbyd6+NI8cQTQE8FMh0mJFlbrbQCdcBykmlRG19ECqSDiHCf45nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255648; c=relaxed/simple;
	bh=+eOaamIjPQ1aU1OkMYDqbWxTf7TfeGAIEmt8eke5fUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3qXkEhZQBT3frhO4rZQ6bwVNPHGnBqGbbGJF8B9GiQ0FVg4mt7dAZ4u0WaThA3lHYH5QalW9qFIEAIfMbtUi1sTy25VT4p62aS2jGF6CXEyaRXvJUN5jdWySwuGcBK6fgz6EULeFkF6kT5bM4U9qIrHPf9C2t4VND6K9fmNMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0hYY/nr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAQtCJ031370
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bSezsz2wXgTichUOuspk0FPIeAlYJ0bxEsO1UFLnzmo=; b=Z0hYY/nrrlBJik1F
	7yVA9QtxJ/aLHlPP3bPTJNmgQW8BOtB00MfHuN+TPuQ25N6Xnxdg3IIMvQVUIdye
	8uYP/8m/HLTjESmX7YB5xmzsKbXegTBa6ZUTYPE9mZMjbGDu6zehHid3jjkpfaeU
	ING/wn9fJk2qWAPky4kOim61wZN/5CGU/hJ6nmaZsYdwzEpy6/guCmzDQ5C9KwmK
	FT98QK5OWkFLdIuXrn7Amezke6MP7jozasPWMiZk5Shh2/fNCcZ6w2dEd3FKLVT5
	42f/m3JjCzgarYVIdTxvlF0KjTGT4yxcKhxrd85NIZ1HL5ToHqPTbFsJZfl2TKUD
	O7llpA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbeses0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:40:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e1d70d67so23499705ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255644; x=1752860444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSezsz2wXgTichUOuspk0FPIeAlYJ0bxEsO1UFLnzmo=;
        b=Ww0Ary4CUPf4L9dLV4NVAU6SSYGjA3FnyMflKTH+qJp5lAJddtc/s3raIOdZU0379v
         YGGRcHuEL5CROE/7qDdrUbx4fpglaVxUWougWjy6zifsh2dbGiuT56ABPJ4Ra8hpR6t5
         uX25DgZLUCWjpCT8lJhcrcih1iJufqvwmgzxDYFePgbHfDXYYjl9jyqHlVYAeMAbK8wG
         PtJh1aCjzJgK3K5tBBUscteyqkbnLaTPhwT0LOQOw2q5Yq4MXEHjQo8z8ZWrlhNl9v0p
         LLB88oCACDiP7HtYtDnF/CcAGizJV2THk2D+aNhtHiK7utskGB0ZHKA8MaimRgRPHaMO
         vK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+Lvi6vXpncX4cOilh/SPJvnFXLqVPFUV5OoBfgtxp1dj9Qc+oU0Y/XIi/33ZwfRa1Mz2GQhm+ySfPOCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGhv1wkUPJahn35/IiJF8iSBXKdhsfceNulxJoRgY5sndm/zE
	M8op9a2YXaEXnyL1GLZF1eGw45UBfYFe4j9p0TU8zSPsopSvBGHC7MGO8N6pQIQ4RVfCpIJpGlV
	EL7NQZe0l3k/LLPhSQ0UygEcWifSjYeT2jiNSWkfKLS2k3Y9EKLafkxyPKlPgDqhzc4K5mwOlv4
	8=
X-Gm-Gg: ASbGncsidRvrG66X9j0nkAfrnXLaPQVOHn9JHj2pV9qXlplirt2oxlz/cIxw/rGkUOc
	+RfAAAHamG/FxNFX7B98zpdlA7qsBB4fFvA7JkMP6tcePtycl9+ngvsmb2DRXYQ8qV1keM7jdfo
	RZOE5d2QUVa9+Cqa+Kfi8pC7rgoQMZbAwe/BUKpGHEh9LucL1lJtCNLXyz0VmpmDcESQZJ9ssZF
	JHpGIoVhNCfi/e/0PRjgC3XPfc2INYMma7Z82IrIfPCa8wuqGbpIezRglMgQxZhpizL0O5KfZQn
	PR0IjGJCLDC6viWR4GMi+RtpgLnQUW/r2St1EHv7Ov3MoL/l8PF62nsjtp/L485zo83nMgUBA6S
	BoK/16V+UUC/ghoik09aAZA==
X-Received: by 2002:a17:903:1a0b:b0:23d:ed96:e2b6 with SMTP id d9443c01a7336-23dee2a09c6mr60377105ad.44.1752255643667;
        Fri, 11 Jul 2025 10:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdn8HQaoW/XQ9oZfpcgpjf8lK7LzxLVyZK79thkB/L5CABuXts7BBynHCZ1AX8U9kj0TvvpQ==
X-Received: by 2002:a17:903:1a0b:b0:23d:ed96:e2b6 with SMTP id d9443c01a7336-23dee2a09c6mr60376615ad.44.1752255643074;
        Fri, 11 Jul 2025 10:40:43 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad295sm50602615ad.81.2025.07.11.10.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:40:42 -0700 (PDT)
Message-ID: <fdc5c2a6-1df8-41b6-b0c4-5557f8e5d720@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 10:40:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix build with KMS disabled
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20250709140838.144599-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250709140838.144599-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzMCBTYWx0ZWRfX1FnB2z1bajvh
 zx4NfJOk8XBUeLiJks9kSHM2Lm+J+Vk8mg9xP6MgjW5RI9IzIUq95VnpVDJ+prZ8eXB4H4BLKU/
 fKx99uD+3ImP8sdFtIMLy8OpGKg+wpV9prU97WgOcx3nny3eJ8Njp7I1CPgluuZqpSRu4rX6oVe
 LWr2ip7elg7UW2bQ1eNvxFt0lfoye0IOn8SJ2hCxYlmGVoFh1MnJWWw3QwqUOxpMtDQ5ZkjXUVn
 a/4KNJjolkjOGLkeZl4FfXeA5alXQcqKfxK7P7mCiROrv/QzXLh2O/pJjr1ObwnesUrUDgSbJoG
 tAx2f+9R1EBrCUtXPlfzXMoZ0tH/DTCj28xFByM1K75U4Jblrc9XRLuMxpxer3sX54brrm4I1Zq
 N2x/AgmUKLfxpb/wgttqpjkLv4DgpXI5wXAeydtU13n42gejCbOZb8mdyUkPCvo+Vg3ahfr2
X-Proofpoint-GUID: ojHLKspvWcof_mZEaUmS23GI7LlsuiEZ
X-Proofpoint-ORIG-GUID: ojHLKspvWcof_mZEaUmS23GI7LlsuiEZ
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=68714c9d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Mfb-Jb5ACYakjZQR0UMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110130



On 7/9/2025 7:08 AM, Rob Clark wrote:
> When commit 98290b0a7d60 ("drm/msm: make it possible to disable
> KMS-related code.") was rebased on top of commit 3bebfd53af0f ("drm/msm:
> Defer VMA unmap for fb unpins"), the additional use of msm_kms was
> overlooked, resulting in a build break when KMS is disabled.  Add some
> additional ifdef to fix that.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 98290b0a7d60 ("drm/msm: make it possible to disable KMS-related code.")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/msm_gem.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 33d3354c6102..c853ab3a2cda 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -96,7 +96,6 @@ void msm_gem_vma_get(struct drm_gem_object *obj)
>   void msm_gem_vma_put(struct drm_gem_object *obj)
>   {
>   	struct msm_drm_private *priv = obj->dev->dev_private;
> -	struct drm_exec exec;
>   
>   	if (atomic_dec_return(&to_msm_bo(obj)->vma_ref))
>   		return;
> @@ -104,9 +103,13 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
>   	if (!priv->kms)
>   		return;
>   
> +#ifdef CONFIG_DRM_MSM_KMS
> +	struct drm_exec exec;
> +
>   	msm_gem_lock_vm_and_obj(&exec, obj, priv->kms->vm);
>   	put_iova_spaces(obj, priv->kms->vm, true, "vma_put");
>   	drm_exec_fini(&exec);     /* drop locks */
> +#endif
>   }
>   
>   /*
> @@ -664,9 +667,13 @@ int msm_gem_set_iova(struct drm_gem_object *obj,
>   
>   static bool is_kms_vm(struct drm_gpuvm *vm)
>   {
> +#ifdef CONFIG_DRM_MSM_KMS
>   	struct msm_drm_private *priv = vm->drm->dev_private;
>   
>   	return priv->kms && (priv->kms->vm == vm);
> +#else
> +	return false;
> +#endif
>   }
>   
>   /*


