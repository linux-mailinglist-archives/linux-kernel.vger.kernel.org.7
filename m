Return-Path: <linux-kernel+bounces-782806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36EB32597
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70A7AC578A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCF5C96;
	Sat, 23 Aug 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJmKgGTl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5A1367
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908058; cv=none; b=qfFyyXe8M17bY8dlHrYTDeLajgK4Vqa6XqkteTcCfJD83MqY0kla3DQDS35HMLZAwGKzYDy0MBjpdw/t2T2riOeImlrV+DqLC/kLiu5tc+cvMu4eObc8M5KasUKjsagT2W7mz7XX4JMmNTQPiyM7a+zE2PQZvksW0zIzuEMtGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908058; c=relaxed/simple;
	bh=BHLd4Q6QXpl1+7vDSWYb1rrLmx7bHBIAjbkFLYC2iWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3rgnaNszZcmo7EsYyjwT2GkxNqh0yLjpCheLj+xek09hL9OfPTHwC+fdSVoptUJieflrAGzGXUgDooKXqm0ndMO976dp2wlkBC9i6HoW+mz+pnndkGTt9sFAc0p7BlCo9q6cmnE89dMh+lzUKRUhRVNcizsOjTjxKrfp65cGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJmKgGTl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHUngH006050
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=5q/OdSmF/cMGGczwyYiaDZdGQXvSJ/FPohyvehhsUvQ=; b=WJ
	mKgGTl0DyGDzKUz5B5rtc+cKqAltAtR7Z9CZMSv3Ac6c0utmSULuY1LnCePoCBv2
	8D9lBJlZNrwpvXyuczo2Xfft8gfahQ4bCq0YcGivFGcpH24raqH2xUovjEqQR7uG
	MCT8UPoOYBmbv5h/RgUveI62wkB3AfNgb9eIf1IHdDqBk7zvsDLhYlC5EHAMo4W7
	gZzCS8X0vXtcps/eP3olKjbOWb/i/XIxN4Yn8HWB+O2iXb1s7aWans/LrZH1hHdb
	KsiU7OoJrs2gt9otCm6VX5w2t12PFSKwSjBjHH4n7uX5sfDbpVVa+YAJpcAHTnaL
	fDqWLPNmXmfi/9bYXdDw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw0yru08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:14:14 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-435de7e1ea5so1437054b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908053; x=1756512853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5q/OdSmF/cMGGczwyYiaDZdGQXvSJ/FPohyvehhsUvQ=;
        b=MpqZHMvnVo7WPKgWxRReMmJd2VA5TbpF1DR+htBZ1O7gY6Ivks1R22ixNmvI/9hi9r
         G8NrOzakc4kix4nd0kGOuHHuW2lSO8dkTTnLksnkXLVVHY30DgVkmRSx9NVzKhoTh7UU
         EnpmpUi/c8VvtjLQ8ZrUzfHkOtQBj9zmGje2i9sMGWKIRHyq4cAqfRFVLVtsCLq8DcRm
         0DW+iS1aNrXsLrMHeIe5QVRi3kroQCx99/dcbrgrzwWzkARZH2ncyVIJbAN+QlJMBlqz
         /i+y3Pssf39FnWx+2GLKaXoNfG9hj3SsU3znPIKASlodDVSj16uaBiLxjDN5iHx+XOSQ
         L4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVPlpTA3P7LYLnrFvhIp7aPjtpCvWpvIy3cd53Yy6MURpnFxgrKuogrMamFY2Xa5cO+klfeR5gRNhp4K4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6zAB4NtT/se3mIX7Atx5ueyyxj5ShpUY+j15S/C1PPy6c4jM
	EPlS7D5Dc1KGHpdFJs/42qYTd2hlzuryXt0jzqc98sopICouyIw4hf4ic7V/Qwc+HTuRJLjlrPg
	vocrL5VPToatgNksPFBVcxyPEA5nYrEn5iXiQAov60qZX9o2vv7vmgEN8kcyeYS8flqUW/TjMH8
	qjbkHHNNjPfToBLgud5oay+2iDEnPOF6DcRei7/G2+ug==
X-Gm-Gg: ASbGncvEjxWslCu8bgwmBsY7FoVyxB8Abk9q+q9Xi0SpjcESNwZ09On/Emt0kCc2IM9
	go71hfGAYu8YLcRMx13fh6afcLoLLQpdU8+NlQxPaQAk8oR2hT0WVMesGAdEL93ccxlIWBUnYSY
	FUgm7Mf/ChHayMvpiRWJdz7bLVHuUrCql6AzMoFSvD3Hm8TZkgx2em
X-Received: by 2002:a05:6808:508b:b0:435:7445:9b54 with SMTP id 5614622812f47-43785272d3fmr1994384b6e.7.1755908053581;
        Fri, 22 Aug 2025 17:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4t+fq/ZGjil0DXAYYaSwcVpbr7d7MsOBcm0bO6kgAjPfM2vJH/vRb8WNpsTKBsxfQRwH/66jLfygmardG6Mw=
X-Received: by 2002:a05:6808:508b:b0:435:7445:9b54 with SMTP id
 5614622812f47-43785272d3fmr1994379b6e.7.1755908053191; Fri, 22 Aug 2025
 17:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
In-Reply-To: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 17:14:02 -0700
X-Gm-Features: Ac12FXyYHTzWHjyweR5vLi67evbQhmIDPXKLXYX2aATF5P7xijHggxde4nM5TrA
Message-ID: <CACSVV005RPPoB=o8-Arvteaqbpr9n_ey7LMp7c6WOg16euxh5w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix msm_gem_vma_new() allocations for managed GPUVMs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danct12 <danct12@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 98akbZPkiJoavHee7dk9hNCBp6SA2tSb
X-Proofpoint-ORIG-GUID: 98akbZPkiJoavHee7dk9hNCBp6SA2tSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfXx1VCyOPICR7L
 R3cDDbI5SWNkKUtzuMihD/ewSPe4EBHWGhcAqEXDAJBTtqT9H8N2c6FiV/uP1LVsF2LMwlfE8eK
 vNmpGfmBS7ky7jjkqo+tbTqRlZWuFX9kdUW3GA6H47Suhyp/npThuT6x5o6kJDY5jHJe4cev/ts
 cf05AcN72drlXRlAS6vIZgRaYV/zaiYLzUtGKL9+pWtUz0n50GHu2/0UEHjxQqHBnudEcoVcGQb
 S2PhOi3jZssGV5vw3Vz5CV4PX4l4ICmn96wuSyFfPJaj9BcM6bR3YdzpFj2f8mdOhtLi531u60U
 LDlYfGOgj5b56amFzVFIG8WxWD2h+8KF2oE1jF2ulNuqela2Gn+S5WrEZdS6C+XRpAUpPqRHm7L
 FxiQdoB7
X-Authority-Analysis: v=2.4 cv=TpzmhCXh c=1 sm=1 tr=0 ts=68a907d6 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=LpNgXrTXAAAA:8 a=lOIBcmm3ity2mgyilJcA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508220160

On Fri, Aug 22, 2025 at 5:12=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Since commit 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()") MSM
> driver fails to init, failing with "[drm:msm_gpu_init] *ERROR* could not
> allocate memptrs: -22" errors. The mentioned commit reworked the
> function, but didn't take into account that op_map is initialized at the
> top of the function, while ranges might change if GPUVM is managed by
> the kernel.
>
> Move op_mode initialization after finalizing all addresses and right
> before the drm_gpuva_init_from_op() call.
>
> Reported-by: Danct12 <danct12@disroot.org>
> Fixes: 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()")
> Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 3f440bc1f7106f3b0091f037611d0b433e5e2c18..6df6b7c0984da57fe64de41fa=
54f7dea0a324c74 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -368,12 +368,6 @@ struct drm_gpuva *
>  msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
>                 u64 offset, u64 range_start, u64 range_end)
>  {
> -       struct drm_gpuva_op_map op_map =3D {
> -               .va.addr =3D range_start,
> -               .va.range =3D range_end - range_start,
> -               .gem.obj =3D obj,
> -               .gem.offset =3D offset,
> -       };
>         struct msm_gem_vm *vm =3D to_msm_vm(gpuvm);
>         struct drm_gpuvm_bo *vm_bo;
>         struct msm_gem_vma *vma;
> @@ -402,6 +396,13 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_=
gem_object *obj,
>         if (obj)
>                 GEM_WARN_ON((range_end - range_start) > obj->size);
>
> +       struct drm_gpuva_op_map op_map =3D {
> +               .va.addr =3D range_start,
> +               .va.range =3D range_end - range_start,
> +               .gem.obj =3D obj,
> +               .gem.offset =3D offset,
> +       };

Thanks,

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> +
>         drm_gpuva_init_from_op(&vma->base, &op_map);
>         vma->mapped =3D false;
>
>
> ---
> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> change-id: 20250823-msm-fix-gpuvm-init-520d87ebcf26
>
> Best regards,
> --
> With best wishes
> Dmitry
>

