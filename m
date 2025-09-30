Return-Path: <linux-kernel+bounces-837329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC6BAC0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B26C7A11A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3442F3C27;
	Tue, 30 Sep 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKXn4H+9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356432F3C1D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220883; cv=none; b=oFumDmWe2CjCNczVFvETe6Ar4CV5LFV/1kbb02BphqYUe3CygCXgsxlosGsZnzPKhWZ4rjHB7Xffxg6bfbJcKgin9c/9dASkHKDjGv553xTLE5jqWrUsf37W6eNe/hdJ2rk1CAZAEqr/6Xp5D5b3xtPbxyERXOtC1bo5L01gFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220883; c=relaxed/simple;
	bh=rPh3kRVZ4h/rrupdBcJxTF42eQ6u5qVrD5lU2D2cpQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq5mF1Ha1Dn1tTrKGqHXQkkoh/K44aik7mSZwXLdmzJm8VqSIzBSfE1voiPR8tRZqpriIMuMSkAo+TVVVtu0IeBTcwoq+V12r/yZ7qIM19QWzE0RS2oF22zkun5ed16MerlKWGFL8YXfehh/xq6lEPRUcvKz4lsGo6FeTRGcG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKXn4H+9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4He0G024597
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=te/ZoQVF9PRW/Vcak1agQLB+rzLOMt6hZjDiPBIvFPo=; b=GK
	Xn4H+96BGGnzBwd5vTeveqmwm2+ROJlE+usawWAKSsuwebQBlbNMkoDT5ysh/2l4
	j4KztS+NSFkvSI/GoyRcLqKba4lJme06Y1FICjT5MBx7/+CrgdoW3XwpYr7YSidn
	I1nUCog2rCBgFD1rZhjDpcPxcQD2IxHtkg2mzlCbWP9bOWLCXVCAOuXyWTqmjZaX
	DPprIu4mKijgTo3ND894o5PR3Tyf4tq0Vecl3JsrqWd4G76MwlswbzRViTdcWOJ1
	WTG4IvyGi6P7WZE25Hoxm8TqpJsgvKYuw9hR69Nv47O0kBo1PxgimsBuP7cCARq7
	nqi4JQnq21omtIlpzbEQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n0mw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:27:58 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-43d3063f5c9so1052464b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220877; x=1759825677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te/ZoQVF9PRW/Vcak1agQLB+rzLOMt6hZjDiPBIvFPo=;
        b=r0DUbS5YB9XcDFuy45nVq0ZVoiHmO7R1mzD+AFDLoFFlUfze7SjjjTgcNbm+S+Alsk
         1a2mvrzPhf7eJIFUmvTskVQNgs5Z4PqUAcT9HLeanUKEeZ2ZlG24itP8AsTrbgLCYXgU
         71fASPRTUywHcZAuSWRgGYUa0KIR8VXX9/NlZTN585zwBSK9gqn0lQt/Y/TFmTES2Z9T
         cNg04QXBrtZvb79HVFzdDDvJFBKFq9ih3hwBCrzgdI+4s5uSn/vIe46BHaa0wp8nGCRL
         Oaep8dOA0ETUYvWyq5ebUBUZMtimdmav2VCLJLRQMRjBPtxTtnZPewFzfS0mZ8pDvVwM
         420A==
X-Forwarded-Encrypted: i=1; AJvYcCXjiPxp2vVKTMsmMpHWQcFMnKD1g4YSAXd7gGKb5aXzlRv3y/cKy6Xtxqs25wSNg9yKcZRqCl9M1SAW1Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oVeeMd+z+cqzbpLqytwufxkspBQEnTR8eFyA6NjOx+MiVh0h
	4CtI2VCnrmM5gi/tNiIbUucu92vqrcX4xWKLWv1IlQLy/Fcqdl5gA6qvG2aOcx/se3JQs6rQva9
	pDy2GqN77gBwANMxrhrD9z+cckw9ZEtTAgDnLPiNzBb/bycey9VkF/j90WfQusHOnY2Y2YHz+bg
	NPAwnelyZHm+PxkCyDaEqizxPfiWSOmNC1MKoMhRM/ng==
X-Gm-Gg: ASbGncuC4WhoUgOgNgxe3DjVJtAjs2zjMgLvShUdKgbTKpOXFUUADy+8zZ7403jtft0
	y5kDvVRfjmWk9PvwMZmqSajmnybXjMtYjJ36c70nVLBMl6DyswB3suUxf4Rm0XGfaFnTQ8guOYZ
	0MhoTz6v6TcWYIUDxYztgtkQo24tb30JtOKm4uzQ5qxK/Hy1Vxs6UkVJg=
X-Received: by 2002:a05:6808:4fde:b0:43d:25a2:e28c with SMTP id 5614622812f47-43f4cf464f3mr7573978b6e.49.1759220877216;
        Tue, 30 Sep 2025 01:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH814E7mWrVlAtwKKyT7opGmi1FUZDDSJRR4sEXqt85rC60tExf6mnWRjS+3W0gCgMI5Vtl3QqcYmH2Ktkkf/U=
X-Received: by 2002:a05:6808:4fde:b0:43d:25a2:e28c with SMTP id
 5614622812f47-43f4cf464f3mr7573965b6e.49.1759220876731; Tue, 30 Sep 2025
 01:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com> <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 01:27:45 -0700
X-Gm-Features: AS18NWCqmbEpRBm5ANsrhcq-Z8jcjiekBnhyIkewW9_rwgY5GXXogY_b-bdPSxU
Message-ID: <CACSVV01UygpiUj0m_Ppd_LSxvW0MFunz+Lfhg20XHR7vyOBx7w@mail.gmail.com>
Subject: Re: [PATCH 13/17] drm/msm/adreno: Support AQE engine
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: RBXbQnpQphqUI0QjOC9vBAqXVF39XWtb
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68db948e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=fhJ7XYdx2Z3gjWMZPJIA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: RBXbQnpQphqUI0QjOC9vBAqXVF39XWtb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX/Uid3N45MF9k
 8OVMtXSlO29tgwUoDN+r9j40AVinQdYnMOz3If3JZE4ZMFo7e+C5yLiqGeixCinY9DoXi+dpAcW
 125X7f2/e8IJyH/wf4qtIEMwvai8rEr3iG8uqjrL2eS/OMqKKjpDUz7gxynLwChFNKpKQfLaofz
 NNRQpjjvvTIPomdlkcbP1VFTi7vQRil7pLZL0KwfoZMZfdOZCMkCEL1M/gL4wqpZ329htDtPRKj
 M8ll+YbFEz5mUrb9zR5GAeAR04MzzADKUHs0HQPeSFGo/CzzKx8lSeuXfKrlZnLGpVQ/B48H/NC
 kZ1HmON6tb6Di4DRFjQt1oQHCH/ozlWZC07mU0GPUQTDg4h6ZEBTT2QSuPj4E4Ez31dpc+zZl1g
 M1TnWFkOSfNHG8O+dTrMLNgdPva4gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On Mon, Sep 29, 2025 at 10:51=E2=80=AFPM Akhil P Oommen
<akhilpo@oss.qualcomm.com> wrote:
>
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  4 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 4aeeaceb1fb30a9d68ac636c14249e3853ef73ac..07ac5be9d0bccf4d2345eb76b=
08851a94187e861 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1093,6 +1093,30 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>                 }
>         }
>
> +       if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
> +               a6xx_gpu->aqe_bo =3D adreno_fw_create_bo(gpu,
> +                       adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iov=
a);
> +
> +               if (IS_ERR(a6xx_gpu->aqe_bo)) {
> +                       int ret =3D PTR_ERR(a6xx_gpu->aqe_bo);
> +
> +                       a6xx_gpu->aqe_bo =3D NULL;
> +                       DRM_DEV_ERROR(&gpu->pdev->dev,
> +                               "Could not allocate AQE ucode: %d\n", ret=
);
> +
> +                       return ret;
> +               }
> +
> +               msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
> +               if (!a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->aqe_bo)=
) {

a6xx_ucode_check_version() doesn't do anything for aqe fw (but also
a6xx_ucode_check_version() should probably bail early for a8xx at this
point?)

OTOH if over time we keep growing the version checks, we might need to
re-think how a6xx_ucode_check_version() works.  But that is not a now
problem.

BR,
-R

> +                       msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
> +                       drm_gem_object_put(a6xx_gpu->aqe_bo);
> +
> +                       a6xx_gpu->aqe_bo =3D NULL;
> +                       return -EPERM;
> +               }
> +       }
> +
>         /*
>          * Expanded APRIV and targets that support WHERE_AM_I both need a
>          * privileged buffer to store the RPTR shadow
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 18300b12bf2a8bcd5601797df0fcc7afa8943863..a6ef8381abe5dd3eb202a645b=
b87a3bc352df047 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -58,6 +58,8 @@ struct a6xx_gpu {
>
>         struct drm_gem_object *sqe_bo;
>         uint64_t sqe_iova;
> +       struct drm_gem_object *aqe_bo;
> +       uint64_t aqe_iova;
>
>         struct msm_ringbuffer *cur_ring;
>         struct msm_ringbuffer *next_ring;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a8xx_gpu.c
> index 6a64b1f96d730a46301545c52a83d62dddc6c2ff..9a09ce37687aba2f720637ec3=
845a25d72d2fff7 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -599,6 +599,9 @@ static int hw_init(struct msm_gpu *gpu)
>                 goto out;
>
>         gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
> +       if (a6xx_gpu->aqe_iova)
> +               gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->=
aqe_iova);
> +
>         /* Set the ringbuffer address */
>         gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
>         gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 6a2157f31122ba0c2f2a7005c98e3e4f1ada6acc..3de3a2cda7a1b9e6d4c32075a=
faadc6604e74b15 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -27,6 +27,7 @@ enum {
>         ADRENO_FW_PFP =3D 1,
>         ADRENO_FW_GMU =3D 1, /* a6xx */
>         ADRENO_FW_GPMU =3D 2,
> +       ADRENO_FW_AQE =3D 3,
>         ADRENO_FW_MAX,
>  };
>
>
> --
> 2.51.0
>

