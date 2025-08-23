Return-Path: <linux-kernel+bounces-783068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B24B32905
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C011A251FF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C232580EE;
	Sat, 23 Aug 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSsFUZZc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406B19D8AC
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958464; cv=none; b=to5OwOF+4+ESdUyV6FJIk2MWprPR59uzbzHXOzIx+vQnWNPGwzhXL2XEXIFnmwIE2nmDFeTYzQLLrD9TFkjIlYzB/VZxYJvvWcw/X+NgW05vTSlEQZ6hXly5tQQskjTOh5febvQsvNAah2fSfCyyp+JCs7Z9dUsJDNEinjEJimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958464; c=relaxed/simple;
	bh=XB2DbYs4i4X+VPKmoYXjjnlyY0gzkDk0GEZGuCnLt6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuViPKd+VperrkgWNp49NzjiI4JhxwlGXY5yJurbVf/P8NgvKJspajpoZdUb+W/SwjYBKLEQYcDvl7wBp5tO0g7BOJFGFNlCaxTYXR8ZuWcHaIOAuFtRs3Ekh8WDfJHwdjMCoyO4WWRRCxKtEvzy2Aq5RNmpQ2XUXdyhZpCOVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSsFUZZc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57NDbrkU004392
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hq+jica18d7wO8Y/ug5Lom/zPuKSHhUnRgrzqyuE1Rw=; b=eS
	sFUZZcCBTKkhSfcVh+qxTkj6/ccHad0WQS7Gexb1Tuylfp7hKYpzKKx90SZI2704
	17AjcJT29nIFjb6nDhVYra5c5npb0IMPngfPgN/85MWaXUDc1rHAcHz3GziDyuP7
	rkIKkRbV1zbgqcQ6ClaVrLYZbg7eb6e6zqc/574TZBbVxwAyvY7q76ZAPS+PZgh0
	kMNQK84DmDRIy04iEenOeIbU+XIJkEUQuDl0Ed99RkDXQ2P4cBmuflhAlbgPcGpe
	2sz0Ap1ih/jT9kaPeKf+YYQsRVRrwGBR0FgOnVblH6Lp6U/4bmriBl/JYc3fze+g
	qdv+aV44zQlcx5re9tGQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5uc0xbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:14:21 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-435de5ad4dbso1079729b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755958459; x=1756563259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hq+jica18d7wO8Y/ug5Lom/zPuKSHhUnRgrzqyuE1Rw=;
        b=PBh005pcktOCGGaDihnFInr+CYdr8+qOa/dWZGc99zwzmaES9SknmLDCRjRtWP/TPK
         sfCCuruG4qAZM0ZaaaKVEQTlFKDYlpozbxb7crjMIG6+b7oCouMCC9iPE2tlwiiqkbOh
         YwGsMAkFj5UcSKwDsyJYNI6W0AV+n/Qu18VPUWFNqCkyrD6fqj4ZsDO7zkXddcgz9V30
         wdMOf+wp08j+AAL0uZF5BsboDVxF1//6OushPivsMRkQIOdeA7orEN8eGWUpUP1WvB4z
         49O8NBPl8mND9X9cfXGhOS5CdgB0X4Z8WYcJbB1D1PVI+p5rB81vdtREW4avORfiqRO1
         SUPA==
X-Forwarded-Encrypted: i=1; AJvYcCUuX+FaZIpDt83293HrIy4csAtuUcKRsXErA/yxHBplbxr6X/PQudOC/jOjqicOwAsX3UV2ms9jlTRiLRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vrRu9SKavzU0gUp7jxYSNl4NMkwsqClwWUpm/es4kyB+C0h2
	HNZ6Tfyvag3ig9aXubwy2p93b7eazFotzNsjeW0EfbgA5WOLbIVDCisu7a34V6J9eu4wLqEvoMt
	vizL82LsZMI6qkgssJ8mnBljoig7sFEgf0EMN3XhC9i/WSZ35+jpxC30SP9zMMY3bqV9XcGlG81
	Xx7u+ELZDsRLxFkCFmD1HRH6HN7R59ZyxrKe38y1TREQ==
X-Gm-Gg: ASbGncu0oP6T+nyAVf5Vi4L1bOz+eV28SK0jKQ/PFjXq8cPaZNZALGYEFHcSUrnYqq1
	hMnhrlAmCCOWGF4ay5BaiYmqkXQg8Gjlmyyn4kjE0u4zG2UFQHNu7NQs9szhgMqhQqli3d4BEHl
	gbyoQjNR9ROP2HUB0oNB7CfwJe9tNxDa7DuCGVtzP5/ZDQeZPbhMox
X-Received: by 2002:a05:6808:bd3:b0:435:902b:ed82 with SMTP id 5614622812f47-437851c6f62mr3443146b6e.15.1755958458931;
        Sat, 23 Aug 2025 07:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaa0KNWcAiEqgNPw4u0S8UVbV1rBVNv2UYsT3Lse+1st1+/U5kXNW33XfG/8rpFHvtI2/bQLrM72oS057vff8=
X-Received: by 2002:a05:6808:bd3:b0:435:902b:ed82 with SMTP id
 5614622812f47-437851c6f62mr3443122b6e.15.1755958458496; Sat, 23 Aug 2025
 07:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
 <CACSVV005RPPoB=o8-Arvteaqbpr9n_ey7LMp7c6WOg16euxh5w@mail.gmail.com> <qpde4x3tcultagjpflm6u4xulm5b3xs6ek54kek3sriyrneefk@tgygc5zeoxfk>
In-Reply-To: <qpde4x3tcultagjpflm6u4xulm5b3xs6ek54kek3sriyrneefk@tgygc5zeoxfk>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 23 Aug 2025 07:14:07 -0700
X-Gm-Features: Ac12FXyq0kZZJI5O-DfBShZ4wpACZxqRul7R9cVVMfZTUO4D81g_hv8uQdEnXFk
Message-ID: <CACSVV01uwUZn5JcT4of6GCJT23+vzcnSR1G6_6_1WGA7iJNegQ@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX6LPH7BtW/Yg4
 uLdbZDgOV74feYEWz+WKjN/IzsEe5xzCGuPsXk1lwPrCJjxxKZ9L9bkopwvHKQ4GdZi9pIDowxL
 TLs/kYZSaioUcihTzzAO8PxD7RBOinuVrSEbI8LYzZjRo94hVPp4F6mSJvKxT/acyov1Xqr7jpF
 1g6Q8nMfV1LWlHIAutWDwabFQZoIn4+R5lG8keMMBMPTKqPfkJI0/mDre9TrNdaDUUpdk4SYX4z
 1HlYEH7Fg6te6XlwZeFWRbh6fZb+JPwfajzqW0tCA+wyiuyya+H52kJv8YK6eebnt+G3QniJS6B
 3H6Sl8vicKnILsX93kGGH+7OxuxFlnAU7IV0Rx+JNQU3afRgkqsTqk1NFVHrpW1b77Mg6Iuk5nG
 uMInjEvP
X-Proofpoint-ORIG-GUID: -PHrNSlPr6gTzmJUt1gb66w0gwYpX3e-
X-Authority-Analysis: v=2.4 cv=I85lRMgg c=1 sm=1 tr=0 ts=68a9ccbd cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=LpNgXrTXAAAA:8 a=nYsNrKCB0-J-WGV1dNcA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-GUID: -PHrNSlPr6gTzmJUt1gb66w0gwYpX3e-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230032

On Sat, Aug 23, 2025 at 6:50=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, Aug 22, 2025 at 05:14:02PM -0700, Rob Clark wrote:
> > On Fri, Aug 22, 2025 at 5:12=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > Since commit 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()") MSM
> > > driver fails to init, failing with "[drm:msm_gpu_init] *ERROR* could =
not
> > > allocate memptrs: -22" errors. The mentioned commit reworked the
> > > function, but didn't take into account that op_map is initialized at =
the
> > > top of the function, while ranges might change if GPUVM is managed by
> > > the kernel.
> > >
> > > Move op_mode initialization after finalizing all addresses and right
> > > before the drm_gpuva_init_from_op() call.
> > >
> > > Reported-by: Danct12 <danct12@disroot.org>
> > > Fixes: 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()")
> > > Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_gem_vma.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> >
> > Thanks,
> >
> > Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
>
> I'll also need Acked-by to merge through drm-misc-next, where the
> offending commit is.
>

Acked-by: Rob Clark <rob.clark@oss.qualcomm.com>

>
> --
> With best wishes
> Dmitry

