Return-Path: <linux-kernel+bounces-782888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A6B3266E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 04:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2BAAC49CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBE1FE47B;
	Sat, 23 Aug 2025 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5lWmfyS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA92111BF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755915583; cv=none; b=ZMtQLlEImO7TwvdP+z8O7qClg1pEtj7wcItxlvgzrZcDETyRbdXFVYpcKsHQbmpi1Dls4xTrr/DGyZuzxcdUJubSvBhvROX8TqEZ7OzGJtgLQi9+zDVdTdUCV4xaD+Qd5waaWXZOE15HKTiwPRgFVbSQ1KOSdsiyJOrW+6Kun9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755915583; c=relaxed/simple;
	bh=AKqLjIt4HEsbtovOs/eWeAXjLqrmL/RfqrYBUPlAiBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDJQbRz2SMG4gxDl/eh+db2NBeiT8NfNpE1RG7FKNNk8USBNGctne1u1JL+nwD6i3Ibosoo3wfUVUemCAMRM8tZ/FeBgTNwcjpSFx+KYvdgmpO7llS+Ej2+gvYwtTa3KfeFngFAsP512NlSsNyxkPk/pWEEZX/FXqASih3sjQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5lWmfyS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57N0JuYb014377
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=fcIfjfnVfGNbHcd7e8hiRw7YOvUEvWgkg1GUjTN07ho=; b=P5
	lWmfySx1GV6fNi12kQgJKZek+U9c3P52JpmDmOY48Ocz+Vsu2kk43xm5qHDzm6CK
	yzpFFVQbQkSqzadLg7vsn26qrGWAmaRnA9wbcWq+yx+6LGYYBn5XLFsN2HOJGeJM
	QpvtkJkx7wAjATs+0OyjmsV1JsRviokDqwro2d5hbRBee/DJYRSpJfN9+ToL4TuG
	5Zb86q87sydGk0B4G5xYo9VI8vREHkwkJMDx3mGPqlPBVHjhjETLHaykLs/CorAy
	5zLtcdSs3YHjW9OEg056dwQjq+Ehc6fYDgUDyJTCWGNowXAi1WT3gDJeqzQ0puZG
	7ag9UfSIIQSM3UdVSUdQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q30m85gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:19:40 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-435de8351b9so3164291b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755915579; x=1756520379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcIfjfnVfGNbHcd7e8hiRw7YOvUEvWgkg1GUjTN07ho=;
        b=cxJK1X90CoNcXXam1QYi3cztfScbjNPExIsjcIi2PgHkdf9Q4kzbtYkCvpSWVdCKKX
         FdpiYUDFKUc7l7szcqF+bLuf+K8yiEhEDS0DU2RP3VRR2A4uyHW7RPJijY+TIEfq+vo5
         Fr6mpsbQTZuahXR+atFgTewKxs0pcCHsfYSsk0GkFh5sxAHfQPUI+3mEZxXbBFxiM+Fs
         +XXyfrQAYZOim72pi1RXfmTil7NULSSGSGbSfS/l0sv0IArLNBeFwsULsLgBkF0uaka4
         I3+qQPS1Nz1++Ti40wm2O4Lin4H/eiu4T/KUMXIHQ9y77BXlrpI0m67fK0f3g4zu26yC
         ZjUA==
X-Forwarded-Encrypted: i=1; AJvYcCUc3lSEN6501OfcDO0Frq16hl+OP/RIBAgPf+iHeItdNa0jfFfmAar6vWnjV5TL8ub0HOy7d/foqV4ei3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEu1z7ugwefLDVbfh6TuY+G3hAtFtKSl7ysHuxsAyax0zT+giG
	34ILlgXWqnrFfhy747gVx62V40TqjAVs5BG/G+O2Nwi7LcCigLDMPzg53ZWItjHsQTfMVK95eMD
	kzyEqG8Ed2Oi3WcTTFxaafAKTrgH++k24hPLdi7rAYyrXxgPRb4r5F7Bq10XkAETDytpPPGT6yg
	Xa4Sdl2JeMkHsK37SBHWkjzyuPqNuNjL0RurEmapr2hA==
X-Gm-Gg: ASbGncuwpq3/dRhKF6gCjHypp9BPPNgpwuzH27JqVBo4SCY0r73ZdbZW+gTwF5Slo00
	+dqI866+t4dUyeT0iftG+qKppb6pK4MUVzO8v/i/YLYsYfxSDOtkDydwHNvXnUcbeX9aTSvW2nN
	WGLpH4ew1FMrlp2c/gxgZn99soAbmxPhVfvkyRLmUFSbA8Vugv2xz1
X-Received: by 2002:a05:6808:f0b:b0:435:72ab:27f2 with SMTP id 5614622812f47-437851b7dd3mr2277971b6e.13.1755915579432;
        Fri, 22 Aug 2025 19:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5CjI/gv/KExsc+EMaEtCGFyVs0a7HKS9AHni4JNlhHKAlhjpKP3Uf4Wk/pxR2j928N9m53mdEp8t9ikFUYhI=
X-Received: by 2002:a05:6808:f0b:b0:435:72ab:27f2 with SMTP id
 5614622812f47-437851b7dd3mr2277953b6e.13.1755915579018; Fri, 22 Aug 2025
 19:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823020919.9947-1-alex@ironrobin.net>
In-Reply-To: <20250823020919.9947-1-alex@ironrobin.net>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 19:19:28 -0700
X-Gm-Features: Ac12FXzn5zBeb4qQ_eAhMiXm-81g1Hev67bQG7OISckEeYi_q2b9VPOFynHwe34
Message-ID: <CACSVV017Hv11uCmFzTgzZ524qGxQtdEyL93DBS9nnoH5ZPrddA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix race in Adreno header generation
To: Alex Robinson <alex@ironrobin.net>
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: QSUjJ99PuV3RBD_NEzWPw-jhkj4vflRT
X-Authority-Analysis: v=2.4 cv=K6IiHzWI c=1 sm=1 tr=0 ts=68a9253c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=e5mUnYsNAAAA:8 a=foaXouvCAAAA:8 a=wDp8g09hmpcQW3DN4l0A:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=Vxmtnl_E_bksehYqCbjh:22 a=lBkOZJTZZNyIbKe29SIT:22
X-Proofpoint-ORIG-GUID: QSUjJ99PuV3RBD_NEzWPw-jhkj4vflRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAwMCBTYWx0ZWRfX9cHSFY8XmwKo
 ay8CfB4AM1Kh+SRgOECeYG6+9eFdqOow9jf4WkWqF2nAf85QEnys5UXrXkqwaGTqj0kzyAeEcmB
 99cXR4B6SSfkhk2ynPlf9f+snDE9n0cOoSDQFEsdUuken0iPTnJ6Gkg8ImjnIfaW1nfzIRGoh9E
 925/4bRPFkUedluufxoorxA58zWOZgnm0UygZfmHBFPSayHbDVZEM0l70U8E2RYiI0DUd4oAc0Z
 Qd0JdMTh0YoIsQ/O5MLAZEc/u09sGNK2eYRs1Z+srvDzv11uhFXvXlxCEti3coQS46XpxYn/T9Z
 OguORQ8THJLadCEkXlJRbSVYZtzG3FTrvpylMn+liFETktgjrUGQtIoUCRrKNx5hPevE3J5PyUN
 pPmKsNxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230000

On Fri, Aug 22, 2025 at 7:09=E2=80=AFPM Alex Robinson <alex@ironrobin.net> =
wrote:
>
> Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
> before adreno_common.xml.h is generated in trees that generate Adreno
> headers at build time. Make msm-y depend on the generated headers,
> removing the race.
>
> Signed-off-by: Alex Robinson <alex@ironrobin.net>

looks like the issue is introduced by:
https://patchwork.freedesktop.org/patch/664829/?series=3D151864&rev=3D1

BR,
-R

> ---
>  drivers/gpu/drm/msm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 0c0dfb25f01b..1a918d44ac48 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -221,6 +221,7 @@ DISPLAY_HEADERS =3D \
>         generated/sfpb.xml.h
>
>  $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
> +$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
>  $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEA=
DERS))
>
>  targets +=3D $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
> --
> 2.50.1
>
>

