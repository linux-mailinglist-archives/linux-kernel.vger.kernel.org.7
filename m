Return-Path: <linux-kernel+bounces-759307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C028BB1DBD1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FE1188FB78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844241DF258;
	Thu,  7 Aug 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQisyQxg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CAD270565
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584465; cv=none; b=eXJCXhiF1lu2pbs3glCvkdy+0apjcM6TVhCeALRoOwXdFOPap80Fmww7xjOJPj9uUZNC9Du5Tk6LrYT3cpWwFSQXk/y5HwUYynvktHfPzoFV240ik+vbkqeKBpNCgrsTd8v2rQ0Vee2JpxS4qfKDvMldUPS3vjC9kgEK79QNGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584465; c=relaxed/simple;
	bh=tMLLVGRar0cuCHRh5zAov50PijhI7i7o0O+F5lFtrjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfvnbCoqNVLd+NhqhUpPWHAucY1ThGqLHDGfr5gZOZHD7/vH/+xLNrs1qepPDaRZD23CBHJNg27xncd4srIu387tawcEFbNVhBtGAgDjqnoGvtSJoRzw2x9vEMlcTFAJ5wopxsojw0Oju0r57xy+VayADqRa47I8q1zhtCRVItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQisyQxg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779CvZk019244
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 16:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=20XGyfXXNdGC7HQWVvn1/217ySdGWAG+LZsLEYNzAEc=; b=kQ
	isyQxgZ6iPc3Dqkz5PhDNE/kGLpDsQ1ExaMUJT8FuqRF88ggtnaVwPqFhtVZbLI1
	AVFcjII7mpAI2W74c7NZIgVunInTO6+H4l/3PPcbGd1zdz3+PjlV/nA9UhSC5Mfn
	K66TfR6SpTM4hMitkVKpZfTd5Z+z3qyQRfLDVSwYHmhLTIKrZ8aMHXXHhvzJdYeg
	nkGYgGCGfyMH7LIfj4GlSieIQ55NtSGy/+hdAdMUY/D6O44xp+jJMRhAoe7+4YQU
	r3gOOygXgCN6ziP3huRubTzWKdhWF8AQ9EAiGs34kSrN7CTFbkZ0/WnH7EIJNKzf
	IUEEUB+S4GlObvJ7EJ1Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2xxfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:34:22 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-41b398d3704so1731513b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754584462; x=1755189262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20XGyfXXNdGC7HQWVvn1/217ySdGWAG+LZsLEYNzAEc=;
        b=QRVJfp+C4rOTG4GRSxY0NOAkzCLOGhSb7S5E8wNsok6Lvd3St6mImBNo+SNJOXGkBu
         78GoJIZlvHK6sWge8mp3lUimQN6jhUtxgNwHDlgpnZki3qgAOBgyMJTRVRoGmh2LHGkM
         wb/+BBZfCc4fuKjtZArOmAq6KTTD5dsl3dmtEDN38YMtKrkVT83MOWVF4p1vNT4CZqe9
         sUYsOJ24LemAiqWz0mEVjLIcTiG3SOI7/6eiirYnF7h88POipQk/78c6hinKn5gTf/JX
         LfZVWWRIY0dyqOzzE+/EvVzEh5soq8068qWkdgn6xg9ew2XhXUGhDw9EMFA6q2fjCzbN
         udWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ssv9BBbaKc7/mdif17mjRZXmypfISd0ZU0XsJzoyQNUZw6WYkz+34SiciuQHAt3fogEd3HIps5TVwrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHk0Wv884fPvpKgznC5+D4NdaiBxGOzZMI6tRjjNl4wKssvU0
	S5Dihl9z6+HQrf+bWT2JPC/ekmdmY9YLsPsY5rFZsdQeBz4rkKzIryHz590BdxJVJqnbF+T1PEl
	Z1gYkJB/kBmgiKPaXckCSqq5BHl9CsOL2ivRtRqJe+eQWLYXyFbn9CeGRKHtbd6xm+FVj06JH/B
	GZsog9V4TWnpNXUAaiBodmBeOf1dg9LU/jZQ3BvLRItg==
X-Gm-Gg: ASbGncudCbuNYIePuyeikUS3EVkYRjZhmaPgZnZ9U4Pdc6ARDBo950Ms9ANWEW/aemS
	/yzYOrabW6GPlgPBiuIfK/GXGz4B9NIZ5Ix5LrVn56iEgbQSqxnBvexE9tqrbbCAlHNchbVJzKs
	dONPQsAwgLp9h5NtUDb/chF6d4wBdd3Kkxn1XYo0IZ3yQTe/evLh9u
X-Received: by 2002:a05:6808:4f62:b0:435:51e3:4c32 with SMTP id 5614622812f47-435949944cbmr412531b6e.22.1754584461691;
        Thu, 07 Aug 2025 09:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYDpEiutargwcHztd1uMH+An3wIVt+BWQAJA5PusdGM4Ay+XwJsJLRnHeGzu24XnAc+azltF8a3XWtp0hOuI=
X-Received: by 2002:a05:6808:4f62:b0:435:51e3:4c32 with SMTP id
 5614622812f47-435949944cbmr412515b6e.22.1754584461239; Thu, 07 Aug 2025
 09:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807131058.1013858-1-sashal@kernel.org>
In-Reply-To: <20250807131058.1013858-1-sashal@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 09:34:09 -0700
X-Gm-Features: Ac12FXxMSsMGvIgYDAvLfpHDoBnkFhjLk_774zLTck_kXTKHSm6n5z-AQjQuJmY
Message-ID: <CACSVV03b+tAN4o9kFFaNVJrcO6OgaCSmajL-LpvCd_wDzWPSBQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: Fix objtool warning in submit_lock_objects()
To: Sasha Levin <sashal@kernel.org>
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, antomani103@gmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=6894d58e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=VwQbUJbxAAAA:8 a=J1DvxoY-jygCTqRSKsMA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: Dt7-i4-hcnHGwejHCwbMqcgKgYzNaH73
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX/a/+zK5PnT/Y
 AqINq6J4/jnHWbNhDSL9sGsUg2YfPUbNRK50w8vrze8nEc0/noLkvYwENSA4JG1qr2Lo9mLqt1O
 exOg7X+ZpgrXMwGoCRR6L9UNyF74Y5tWga1Z95+BDBNkQwSBl7vVgo0ktA/BXuaCpE033+1TB73
 gqkDH3t1qLO98KOWVuPA9RpXBQOryaXhG+AjdY3G2acMa3QKtJl+m7Nd7XrlRbnSk86/QtgDPyf
 liYz/F5JCMw5z+obE8bOSoBLvd5EBbFm56zHUKdsn4hgz3EyrkX3HQw0sKut7jPBOZdNlElW2hx
 MNIz+VkFhwAYGuTxGw+YI5vXbWk0+t6mH4MUqfqE6FbVvh7fHUo6LFyQplAVEB+7KwprDkwb5GX
 iZf+/UAi
X-Proofpoint-GUID: Dt7-i4-hcnHGwejHCwbMqcgKgYzNaH73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On Thu, Aug 7, 2025 at 6:11=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> Split the vmbind case into a separate helper function
> submit_lock_objects_vmbind() to fix objtool warning:
>
>   drivers/gpu/drm/msm/msm.o: warning: objtool: submit_lock_objects+0x451:
>   sibling call from callable instruction with modified stack frame
>
> The drm_exec_until_all_locked() macro uses computed gotos internally
> for its retry loop. Having return statements inside this macro, or
> immediately after it in certain code paths, confuses objtool's static
> analysis of stack frames, causing it to incorrectly flag tail call
> optimizations.
>
> Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks, I've pushed this to my staging branch for msm-fixes

BR,
-R

> ---
>
> Changes since v1:
>  - Extract helper submit_lock_objects_vmbind() instead of refactoring
>    single loop
>
>  drivers/gpu/drm/msm/msm_gem_submit.c | 49 +++++++++++++++-------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 5f8e939a5906..1ce90e351b7a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -271,32 +271,37 @@ static int submit_lookup_cmds(struct msm_gem_submit=
 *submit,
>         return ret;
>  }
>
> -/* This is where we make sure all the bo's are reserved and pin'd: */
> -static int submit_lock_objects(struct msm_gem_submit *submit)
> +static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
>  {
> -       unsigned flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT;
> +       unsigned flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_=
DUPLICATES;
>         struct drm_exec *exec =3D &submit->exec;
> -       int ret;
> +       int ret =3D 0;
>
> -       if (msm_context_is_vmbind(submit->queue->ctx)) {
> -               flags |=3D DRM_EXEC_IGNORE_DUPLICATES;
> +       drm_exec_init(&submit->exec, flags, submit->nr_bos);
>
> -               drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +       drm_exec_until_all_locked (&submit->exec) {
> +               ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> +               drm_exec_retry_on_contention(exec);
> +               if (ret)
> +                       break;
>
> -               drm_exec_until_all_locked (&submit->exec) {
> -                       ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1)=
;
> -                       drm_exec_retry_on_contention(exec);
> -                       if (ret)
> -                               return ret;
> +               ret =3D drm_gpuvm_prepare_objects(submit->vm, exec, 1);
> +               drm_exec_retry_on_contention(exec);
> +               if (ret)
> +                       break;
> +       }
>
> -                       ret =3D drm_gpuvm_prepare_objects(submit->vm, exe=
c, 1);
> -                       drm_exec_retry_on_contention(exec);
> -                       if (ret)
> -                               return ret;
> -               }
> +       return ret;
> +}
>
> -               return 0;
> -       }
> +/* This is where we make sure all the bo's are reserved and pin'd: */
> +static int submit_lock_objects(struct msm_gem_submit *submit)
> +{
> +       unsigned flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT;
> +       int ret =3D 0;
> +
> +       if (msm_context_is_vmbind(submit->queue->ctx))
> +               return submit_lock_objects_vmbind(submit);
>
>         drm_exec_init(&submit->exec, flags, submit->nr_bos);
>
> @@ -305,17 +310,17 @@ static int submit_lock_objects(struct msm_gem_submi=
t *submit)
>                                         drm_gpuvm_resv_obj(submit->vm));
>                 drm_exec_retry_on_contention(&submit->exec);
>                 if (ret)
> -                       return ret;
> +                       break;
>                 for (unsigned i =3D 0; i < submit->nr_bos; i++) {
>                         struct drm_gem_object *obj =3D submit->bos[i].obj=
;
>                         ret =3D drm_exec_prepare_obj(&submit->exec, obj, =
1);
>                         drm_exec_retry_on_contention(&submit->exec);
>                         if (ret)
> -                               return ret;
> +                               break;
>                 }
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  static int submit_fence_sync(struct msm_gem_submit *submit)
> --
> 2.39.5
>

