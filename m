Return-Path: <linux-kernel+bounces-784727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D766CB34061
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8117B0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE7202F70;
	Mon, 25 Aug 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q5AcVBoa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B21E6DC5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127331; cv=none; b=WAyJDFlZkiZOVcS99vW7Lgi802Wq5aHp9dVZac3qHyYw7FAWvOaqMO5Theo3SjYdiLWN5a2WON8OoIQMPbtNiCbsS+RoANseOUSiPY93i1ViGd8wy5q9Px8VwOK5FuJ91Hrtn6SyOke9JkIjBoa2PonGWHvWXx6gpNrlenMKA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127331; c=relaxed/simple;
	bh=yPhH/IQFNsqEBNzQi3kQnfLSDLzCTqB9rCJ5OwhV0vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqHzH39gBWqZ59QfLJPbgiQOvY8eQeBkxXJp0r/R1uss3bR1M9ozc16rBpS81i6BV63L76buoYl2ZylPTZdt4jmvyBrXfavFsud3oQ1Ifn+i0IpAfc5sgYi5zShcu8b7ascYY9vm6sIeE4MuAUIDzT8wJc1OfiKIbpDECwmXraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q5AcVBoa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8arHq006049
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=mLb5kXtp3JZDVVL6Y5bEFTlZwa6bARViRJ9g/Jqdr/w=; b=Q5
	AcVBoaQmdmull2cK/OetVXsMAs4whnLUM3fHKV7+h52HRj/y+M1Lt3UKKYIJeoDD
	/P8Gtl4hDIh46VOHqlV+5Iqlykj34KATBbU2VJ56xwmRFoMLyQlg6HJuKIPbcX9c
	E1VQssucmWlVUIurCGwxagI/eiaq27zvndo4M0GRc/nRoNCVzEO3sEkn5gEm3VQI
	P0ewY9pQpQ8vN6Hd1ApE9gkQEFsffM6PchmBk2xET9xksYOEeFHFDfQpPwZ3EBSC
	AZ+uI/3EuJqFd3qOSLckI/8B+5UjbKtg4euhR9Ufeqh+fS2yNLE+7LQDuiVuvHA4
	tOFSbMhv83JxHwA5FIWg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thw4bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:08:48 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-745232e75c2so966146a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127327; x=1756732127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLb5kXtp3JZDVVL6Y5bEFTlZwa6bARViRJ9g/Jqdr/w=;
        b=hd0vA+efptFzUiU5kbPwH3HVIlckWgU9LqSnlg6rELM8XNd2+sCj4wF7iZN+gGz+6y
         plvwcB3TFLhO6tdSGUXG2nXGQVdcjaDxddMcGySBZGoY5Z1BOfl+MT+7qLphj69UL/iq
         gzanpuVxRoYxTRL9Pk6Jp47tcMUamn6pz5knbiftDiO4X1rc4l2qbFYWxUaW0LwLNNZ/
         a5dQUStJSyt1Cy1dsAZsOOfEXgDqLJj+/ZP5JubsykPtozNcCTpucAH4SAy2yfQxV4bV
         PwxYdd1c9LP+PbtOTkxRzcda9IzDq1OReiNqSDIKgJ/77eSv8Hy73bQ7T92qKhQn4g+N
         CL5g==
X-Forwarded-Encrypted: i=1; AJvYcCUdOzsAo/qWtAmZyOyopbFJBkHe3bEfJHeJQ4gTW7eIry9iYfvheNu4bd1M0F0hZQUTCftH4nCSZda2uEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxtj+8wAC45aCQLZmlC8GhrOEQEKGndscMbh4Ihi+9XXWmrGoc
	6dfYtRuDbGZtMEwZtXEkV/d25hUc86rnlopcOexobXhvqb8WxKWodBxqo0+q1yR9zpgJYEV1hIm
	PH08SaG+PHrOpFEYdlItur5BYrUTWT9cx2Jzl/T+f5fWFPM6OH8LUJpbijHTNXKu+qcUqy9bEj7
	LPfzkd/6uuSqTONbXRAnPRSP17zX9t2OJNoaLF9I8nqg==
X-Gm-Gg: ASbGncswkrIenqPybm1MgaHJPFzjY9LmVK9kfmoAVEskt2veU7m7xe0dGtkAKtXWZIF
	N/IfexBDfvBKUPYnI1Aq4/NXNs+7MVRfh+j1MeZHcKApcpG2wyfrB+901jKkOZFae5UXVSTD6mV
	7EPtUvTc2Mr4faBFwypY6HXATquxDMgEcex73hTfwlWSN3pXe8N6Xx
X-Received: by 2002:a05:6830:618b:b0:73e:5bdd:a26a with SMTP id 46e09a7af769-7450096feb5mr6755038a34.9.1756127326794;
        Mon, 25 Aug 2025 06:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf1mlBVCjf4vOsM5MnwVwSaIvX8715qihb4fhYBKinuor019PfotnBMd06hPMWBc+xl0MSuBbV6ACZ4S2dee4=
X-Received: by 2002:a05:6830:618b:b0:73e:5bdd:a26a with SMTP id
 46e09a7af769-7450096feb5mr6755016a34.9.1756127326391; Mon, 25 Aug 2025
 06:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com> <20250825090908.269e1119@fedora>
In-Reply-To: <20250825090908.269e1119@fedora>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 06:08:34 -0700
X-Gm-Features: Ac12FXxVMbN4YIAqrvV2kTi7-EqGh6ZKLdVC2PGJCMTcARzTFOGIUb9P7BDgx8Q
Message-ID: <CACSVV02uJCRW8imFz7Q4fDZ3gfwkjQW2TkKYEVKLrfs4bXRFCg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix msm_gem_vma_new() allocations for managed GPUVMs
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Danilo Krummrich <dakr@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danct12 <danct12@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX64PgiQ1PGEoh
 xBCQnIRvAKmRrwxYSiQqhlztzEhe4GIAVmyVOnYJUxQsx4sIFBkdcKLnEYvWpyw1pzIad6Rh1ud
 r3fWlcoS6RwD+ecwYAQnAOSa5q490K0DanFCLaRbwDizGTNkGAzcY6ji6fjYjF6EiT1LN/jdVeq
 NwluJKv7Qxst2YHm+9Ztclx+DfXCOwhZZMpO6KWQNsUD/TQWpbiAfcgQQ/xmaUM730I703Jnrmf
 nAYkub/J3boeIpTVgAlhXITN5LSiadqg/Eg3BxB5ka2rEqWwbhQAVNmVfuw4xJds81TRetlMwja
 M9e29ZEvwOoaBTYt+M6prG359kXhUERMXnoWIOvbiFVZ4goQUtY4qPqX82gVLBPuvOzuG5Tj8Q/
 bK3A/5WX
X-Proofpoint-ORIG-GUID: wbuG_z_B5oLM4hPTZi9zL05LE8Eucdzh
X-Proofpoint-GUID: wbuG_z_B5oLM4hPTZi9zL05LE8Eucdzh
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac6060 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=LpNgXrTXAAAA:8 a=fJUbV6HVZzjmhIKkI0cA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

On Mon, Aug 25, 2025 at 12:09=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Sat, 23 Aug 2025 03:12:00 +0300
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> > Since commit 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()") MSM
> > driver fails to init, failing with "[drm:msm_gpu_init] *ERROR* could no=
t
> > allocate memptrs: -22" errors. The mentioned commit reworked the
> > function, but didn't take into account that op_map is initialized at th=
e
> > top of the function, while ranges might change if GPUVM is managed by
> > the kernel.
> >
> > Move op_mode initialization after finalizing all addresses and right
> > before the drm_gpuva_init_from_op() call.
> >
> > Reported-by: Danct12 <danct12@disroot.org>
> > Fixes: 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()")
> > Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem_vma.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/ms=
m_gem_vma.c
> > index 3f440bc1f7106f3b0091f037611d0b433e5e2c18..6df6b7c0984da57fe64de41=
fa54f7dea0a324c74 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > @@ -368,12 +368,6 @@ struct drm_gpuva *
> >  msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
> >               u64 offset, u64 range_start, u64 range_end)
> >  {
> > -     struct drm_gpuva_op_map op_map =3D {
> > -             .va.addr =3D range_start,
> > -             .va.range =3D range_end - range_start,
> > -             .gem.obj =3D obj,
> > -             .gem.offset =3D offset,
> > -     };
> >       struct msm_gem_vm *vm =3D to_msm_vm(gpuvm);
> >       struct drm_gpuvm_bo *vm_bo;
> >       struct msm_gem_vma *vma;
> > @@ -402,6 +396,13 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct dr=
m_gem_object *obj,
> >       if (obj)
> >               GEM_WARN_ON((range_end - range_start) > obj->size);
> >
> > +     struct drm_gpuva_op_map op_map =3D {
> > +             .va.addr =3D range_start,
> > +             .va.range =3D range_end - range_start,
> > +             .gem.obj =3D obj,
> > +             .gem.offset =3D offset,
> > +     };
>
> OOC, are we now allowed to declare local variables in the middle of a
> code block in kernel code? I must admit that's not something I tried
> doing recently, but I've had gcc warnings in the past because of that.

yes.. I try not to go overboard with it, but this is a case where it
seems like the cleanest solution

BR,
-R

> > +
> >       drm_gpuva_init_from_op(&vma->base, &op_map);
> >       vma->mapped =3D false;
> >
> >
> > ---
> > base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> > change-id: 20250823-msm-fix-gpuvm-init-520d87ebcf26
> >
> > Best regards,
>

