Return-Path: <linux-kernel+bounces-783070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71EB3290C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC749A26AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039801ADC7E;
	Sat, 23 Aug 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJZIvXYC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0D143C61
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958600; cv=none; b=fQ6KODcCHo9Av7/KKw2dU7bRcXnN1f7xkwUOzV8fdM1Upcz9ZIPoZlKoUoC5cKBQeAi/Q73iRv/xonyzckxXi9U3uvHS49QDBBJG9smXgRH6aunmo1fpZ0fgqi6FqURzpbf3FuijcP7sW8wTES7w8fT0F5ob1q6pEgWtQ9h70gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958600; c=relaxed/simple;
	bh=Atwhe2gdv8aHQur/RkhiNK9hSbUPHXW7FLc82xCY0gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/mt+Igp7v41+45f69NeabymLjUIVgQPhUy60mxa828xxAxioc+U0Nzsh+RJjEKxOIg/xmHeaQga1Xf3v2QyzaSx48hG+LjX8ROCnJGCrQlepC/1YHb7h/ms389JHDVnSKigbKWl4ztiCVOX/DtzUXmRYWtoCAi4rhffj0iKwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QJZIvXYC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57NDbwFD003227
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=tHzxtlQVpVC5JdCMc8tuGtFWq2Ma7Zo03QGkzubuu/k=; b=QJ
	ZIvXYC9caKCMuFvHsPznNdXgrlUedgIWff8OAzNC8Mzr1/qQDLxMyksoHorQKthX
	wlCutlJw1i8TlLQw5opH4ZFTMIYN8WLn+l+Ao6DZNDKxuj4UPBrT6/kGmfLS42h5
	JDHXmzS21lI7Gw1xEoYHEY0hF1pFIgX6PtBMmNDaKfg1bSZTmNUmOLOKU3rxlw/Z
	fmNo1RWb5anVLNXdyCQEQSHs2C6AaJRhKougHbuGpzMDuDN3lNMKfI47JaO+ipFM
	xEXTK/oAKUhT1Dp859imWZ3c65HpGKUR7QcquORDD+MAssKoqMjhnrBEYNGRaNT6
	Ui8qAQTukisojZ+XFBOQ==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xf8xck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:16:36 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-61bd6d7c149so1386335eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755958596; x=1756563396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHzxtlQVpVC5JdCMc8tuGtFWq2Ma7Zo03QGkzubuu/k=;
        b=Xlz+EMHrgo6BxdWsi3Lpma9duIoAcMSYXv+ljeMRkmzwCwiQUwuSYeCIBsR77zdNNN
         LnfJVBb3S9BcPRumsb+i+0MO7ZPrd13socweGWJIx3LpNCbAt6Ufnkar0vCiZmnCunVo
         eU0Eq/oQhb5XJaHZzf50/ojp9NfM3roeM9IywV6Ih/Ob989o8v+9qc2bbVfOJ2I9KVdG
         GoSqZ7n1j4TIaPulKPU1Bre03UEGB8F6anmw8TVLwUtNdGYRT+gnlfFZ+SbQ7TRErbjl
         hlzntXKHdqWCQTA4hbyRiQWc0rApNoxbtNk0i/t6uDy9U/51EQ5uMzW71Uqpe7LZ80hh
         RWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvUC+Ek2CoDXhQDunQOtcsMOhHezvKvECRtHEFtGWM6b/FXEPc6/YGf3hLwV0MlX9JId8am1VofGUBXUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxIfw9mvqPJBdPm9vHJQSfn+MkBM+Kg7GoPvFZF/KvJft0p0Q
	wLU4tHKcGCXRwdN63EjJDYJYekM5NzzSpynYbj84xXYCKhe0ykiot9WtLRd2GPbWqE2Ht61vuTP
	H07VeVjgO0WquzedW5S/b+LaUhrWlXcdSJenftLIqOQxGHXqohXe3sNjV4hcASf59REmNhTxc79
	WYnuQGE/aQv4CMhCg2a0mb+kx2Pd5/dsCkt7pnorj7Dw==
X-Gm-Gg: ASbGncvSF/iVSc9vk8g/N6Pn9KN990kaon2DfFOIrS3y3AJL6gr0d+s9z02/HmxY6Zq
	mhqn6zD7flzPGEQbk2oZNel5DSehl1uv49I0a5zMS4hWLNDdhEIncSIyTjXPqgZvKCVGiYsU/Nf
	ePEuC4wbpG92dUe8li6GRbZNUJ9Gu34q5ls8e+oI88B8YP1LwPEkYe
X-Received: by 2002:a05:6808:1816:b0:437:75ea:6c73 with SMTP id 5614622812f47-4377db3d1bamr4164402b6e.22.1755958595957;
        Sat, 23 Aug 2025 07:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz45QXys2oJtBIlZEp22ZSDXi2Xy8ce0RKvLyzN43wVE0rZMnjq6sHqDOzozGaYpqLEzp3LKatNVdSmB3HMgQ=
X-Received: by 2002:a05:6808:1816:b0:437:75ea:6c73 with SMTP id
 5614622812f47-4377db3d1bamr4164390b6e.22.1755958595550; Sat, 23 Aug 2025
 07:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823020919.9947-1-alex@ironrobin.net> <6sdzghcc4uynvmk6r4axpwgqlmgxqzi457ttedqlrql7f7lt47@glsrzu46a63x>
In-Reply-To: <6sdzghcc4uynvmk6r4axpwgqlmgxqzi457ttedqlrql7f7lt47@glsrzu46a63x>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 23 Aug 2025 07:16:24 -0700
X-Gm-Features: Ac12FXxJo_V8NE2Itbp6c9Xk0uvP-h0DrvgmNQ_gM5X36Csd4Q3N56neCim3asw
Message-ID: <CACSVV01R=FPAErpfJJvESKig+Z8=amEkpf6QFnkXHhTjFsPf5g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix race in Adreno header generation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alex Robinson <alex@ironrobin.net>, lumag@kernel.org,
        abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9oTVgI4RrZMN
 vsMAnUCs4AdUkJ65ZbaS20EPxPf9EYsGKw4/Q7lA11VjZzbH5Q3MFsOaRtHE+lZA4dXsMXgLHug
 V9hhSBgF1jBrVFetzQtl5OqGjZa5nobA6ftnjaLaCwIsq4+4YY+bEqAWzQS62PXCjP4FrUF9hMU
 D33Lf6V5v7LB0Z9Vpv+aVnKsqwTyzrI8FBLh1usGtEBbWWbbF1E+gJPGPrDs9VO4UwF5jlmdJOK
 pHCdwyZTLsTlpEAmEyPwTnZb0ObvRBtVbFHOd0W3AM4ikWsQMOYYjZO8LxGYBtF7yD7l/+QNK5c
 h0ftUx1VOEL5YvicrK/sU8mzC0d8oee1IAis+PJON1555Bs4kb9S4XvTgPUHhCSCjHrme7gl00o
 I1upN1ud
X-Proofpoint-GUID: krMnUZykI0Hngz0oqK8Xu_grhqqTLwtb
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68a9cd44 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=foaXouvCAAAA:8 a=4hXh_QXROP5yvhQfHEYA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22 a=lBkOZJTZZNyIbKe29SIT:22
X-Proofpoint-ORIG-GUID: krMnUZykI0Hngz0oqK8Xu_grhqqTLwtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Sat, Aug 23, 2025 at 6:49=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, Aug 23, 2025 at 02:09:39AM +0000, Alex Robinson wrote:
> > Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
> > before adreno_common.xml.h is generated in trees that generate Adreno
> > headers at build time. Make msm-y depend on the generated headers,
> > removing the race.
> >
> > Signed-off-by: Alex Robinson <alex@ironrobin.net>
> > ---
> >  drivers/gpu/drm/msm/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefil=
e
> > index 0c0dfb25f01b..1a918d44ac48 100644
> > --- a/drivers/gpu/drm/msm/Makefile
> > +++ b/drivers/gpu/drm/msm/Makefile
> > @@ -221,6 +221,7 @@ DISPLAY_HEADERS =3D \
> >       generated/sfpb.xml.h
> >
> >  $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS=
))
> > +$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
>
> I'd say, no. The idea was that msm-y should not depend on
> ADRENO_HEADERS. If there is any dependency, please move it to adreno-y.

probably we should s/adreno/gpu/ and move all the msm_gpu*.* there..

In the mean time, I think we were going to drop this patch from the IFPC se=
ries

BR,
-R

> >  $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_H=
EADERS))
> >
> >  targets +=3D $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
> > --
> > 2.50.1
> >
> >
>
> --
> With best wishes
> Dmitry

