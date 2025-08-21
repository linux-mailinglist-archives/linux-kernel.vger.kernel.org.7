Return-Path: <linux-kernel+bounces-778707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD9B2E923
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD0560552
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40FB4964E;
	Thu, 21 Aug 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKtAf7/Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F233F9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734624; cv=none; b=aIuTQ4yHPnLrA07j5h3ImgSpRi88zahv3CeOGOc3qI338ZWCcp/rePZ/msuzIMch0uK2BU4RoU4RW9dccc1C3wKMajw4r5Ml5iBhg9sVboI/+jEEQX10+GUWdShAaCRvdM3ihQl18r1cUGvW742hVCLcuCcDGkCX8tmfyzQzhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734624; c=relaxed/simple;
	bh=L7jicr/vUQ/SdKhFs3w4T/4Eeo2TtvbmnXDhd41S5NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqwcRxU3TlM5VYqCjisQ4+Hcflu8Ojzl0JfIB4ANt0U/UgpBmV7RsqBeo9LCX2uFrVJ/OvzibnAjiMTHBrpDRdEoNCzc+jv97Qw97w7EM73SIR6026NJrp1u3LQ3B01A5SctCAOskgkd008ZDmGrymLUKWRU2osDCjPPh+V0Z0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKtAf7/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJheQ5013030
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=FFz/Isl0YBTZIELVPhKyp63nqpT4wVZoqPWNikeSJv4=; b=pK
	tAf7/Z7r89jxx5f8WPZpxZUIuWILu3MqK7VYJGNs7G0NNCgXqQkrU3C0fEGyA4Ea
	Ll62dCScbyL1/PWnkA/Cpyv5jLTuE/lLROhKKWmZhuoJADuFFFEwwCNUuYS90eT2
	lQD1QotCR7fUme9aTqFMTmj5R8fcuwR+4NyeDWO+3CrcK4TMvlmodJWZkm7XZHAv
	RiwUmMNiqtQFvI4m+vuneghAjHVpN3muEyPjcUMzquNUWa7LJAuKzvrsmVrFzmdE
	xnFllTQuvhupx/M8Tizabzbjo7ruD1Z2KcYIFRnyoK/DOO7JE/CjieQOYj61F5lq
	5Whi5ZJuyPWb9c4vz+9A==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293brj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:03:41 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-310cdd5eb73so4996310fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734621; x=1756339421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFz/Isl0YBTZIELVPhKyp63nqpT4wVZoqPWNikeSJv4=;
        b=Rn20DS7KJW0Ip6K2sFWonrFBcToBaY7pstj3SMqyuVeCr8R/6lCpN1Gyx2cdZz0L5x
         mcBH3vkdUtuvhlipDti1dGELKzGPMafPOAV4Vp4QZLslBO6BU3JJxn39vSbVoSHcEPDd
         Oe55le9a2aR1XmK1mY37GLyp+mErQu12sW2pOX9FubWkn32mLtu96IVlD7FzWj4ZuxnQ
         OuxWqxqkqHBhQK76gn/VMnwc1axt8zQ3fjT5Rv/i7iT1EEISI2pI88ljDyV22TPOnVOJ
         7F76A8bQ+60T+fNC7AJwglQ3D5grkq2cfAfjmuX1Z1438q1Pny9qtlIRKJWr5AKvAqyR
         tkQg==
X-Forwarded-Encrypted: i=1; AJvYcCVCY8LlSynICSp4lmPUOf/zZ8x9OnVNY4nxHp/swrbP4LMnLDr9N8IeHd3D+bkD40OeofpNo6vUeALxkDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeaLDIBoweDzkjmJW+sKDlZsg3Ht4nlGv41as7KbD0DsZljp1
	nmlI++ucZxH/fXWjBS0mWLh1mLByNoiIZfqzCRdobl25ihehX4PNF6Drg4slTf4azkn7ciMX++U
	6NVOd4rhIxjdcdMW7nEAz3AFlSbaPGdavui5zSkn7etPAx3u4sevrF364xL/09gEV669gFXDIIH
	iyWgum+mMSm+xFpcpKPwHDYVE289qo7rDk7SxWEGQ9lw==
X-Gm-Gg: ASbGncv1JJRikwppN+JuB/7peZJHfrwF/MKOVu2kyC48N1vuDOQHe5gFKbGmAeTuw4O
	3APlTDnCnh+J/5OSK4Qp7TyuaI3U2BGH/+3LtUe5GAgAb/K85Jvze+8IdS+lupKKYFYj+OzHpJp
	SsQyn13fGe1yfIJyIk2K+Yr2csacE3X6g25NJ5E4roiPHWZXcYbTZM
X-Received: by 2002:a05:6808:678a:b0:434:3f2:4ced with SMTP id 5614622812f47-4377da2fe43mr216599b6e.4.1755734620666;
        Wed, 20 Aug 2025 17:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFSJ01JmB5nH7s2jC28lHanXTkjXIv0AL06dlkx8JNDu+IEAdBFlvrkibRFWkr3533uzVKs9eT4fg3FrChlLM=
X-Received: by 2002:a05:6808:678a:b0:434:3f2:4ced with SMTP id
 5614622812f47-4377da2fe43mr216585b6e.4.1755734620267; Wed, 20 Aug 2025
 17:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
 <20250819232905.207547-4-robin.clark@oss.qualcomm.com> <CACu1E7GgGZc7zF5YQxppMj=dG_emNhh1Ld7PbNT_oM_S436xQQ@mail.gmail.com>
In-Reply-To: <CACu1E7GgGZc7zF5YQxppMj=dG_emNhh1Ld7PbNT_oM_S436xQQ@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 17:03:29 -0700
X-Gm-Features: Ac12FXyIFq6wuiY3CuetpoQBkAY935h4F0qDT-3ZIVa9CNYwhouE8aElbGjqKFc
Message-ID: <CACSVV00-v=eyo8=-YwC6c-Yh2S__-sQ1LacLJaa7phP-6c9UXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm: Fix 32b size truncation
To: Connor Abbott <cwabbott0@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a6625d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pT8ohEelVIQVr6aGgwYA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: lsxNpUkqO7ztFcShGMhk22RpUAn4-cSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzHQ91v/TjIn3
 X0Dnh/KXBIN6yeYQ5XOr7FsIjeDkdZ8yaEumrrUOIVV41n16K5UUzQTpxTL2VA3yQDKsTBlo1C9
 hRiQFtqmkYlt7iJvlkCjdWbrhoV+NqVbDotDJW8jIvil4v0figA0SlIznD0jInDXp1lcTld/Tv7
 pcFQp/GTCg4T5Q77q+rmxJYyobmDMKG7KkuSXXiCQ4mlEFLjIyG+1dfpP7qmpmEJ71xvuEz2oPk
 nZaDrwM7FmmqjFxeerJMZy6RTMc8GW1iq/SpzQ14wQTZm0Guu0bP/7HC9e3RWLzgIaU+GMh6CBH
 ZOh+4xXCTfmRckmyzrgMIQ2kR3euvRjmGB6sA0xqAO2HXT2X7QjVPnsN3KVdh3zwY9xotw9CMkW
 Njk3wNdZDIEf33R4q3BvWYGipSw2ug==
X-Proofpoint-GUID: lsxNpUkqO7ztFcShGMhk22RpUAn4-cSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

On Wed, Aug 20, 2025 at 6:51=E2=80=AFAM Connor Abbott <cwabbott0@gmail.com>=
 wrote:
>
> On Tue, Aug 19, 2025 at 7:29=E2=80=AFPM Rob Clark <robin.clark@oss.qualco=
mm.com> wrote:
> >
> > Somehow we never noticed this when arm64 became a thing, many years ago=
.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem.c | 17 ++++++++---------
> >  drivers/gpu/drm/msm/msm_gem.h |  6 +++---
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_ge=
m.c
> > index 958bac4e2768..9a935650e5e3 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > @@ -1142,7 +1142,7 @@ static int msm_gem_object_mmap(struct drm_gem_obj=
ect *obj, struct vm_area_struct
> >
> >  /* convenience method to construct a GEM buffer object, and userspace =
handle */
> >  int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
> > -               uint32_t size, uint32_t flags, uint32_t *handle,
> > +               size_t size, uint32_t flags, uint32_t *handle,
> >                 char *name)
> >  {
> >         struct drm_gem_object *obj;
> > @@ -1208,9 +1208,8 @@ static const struct drm_gem_object_funcs msm_gem_=
object_funcs =3D {
> >         .vm_ops =3D &vm_ops,
> >  };
> >
> > -static int msm_gem_new_impl(struct drm_device *dev,
> > -               uint32_t size, uint32_t flags,
> > -               struct drm_gem_object **obj)
> > +static int msm_gem_new_impl(struct drm_device *dev, uint32_t flags,
> > +                           struct drm_gem_object **obj)
> >  {
> >         struct msm_drm_private *priv =3D dev->dev_private;
> >         struct msm_gem_object *msm_obj;
> > @@ -1244,7 +1243,7 @@ static int msm_gem_new_impl(struct drm_device *de=
v,
> >         return 0;
> >  }
> >
> > -struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t si=
ze, uint32_t flags)
> > +struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size=
, uint32_t flags)
> >  {
> >         struct msm_drm_private *priv =3D dev->dev_private;
> >         struct msm_gem_object *msm_obj;
> > @@ -1259,7 +1258,7 @@ struct drm_gem_object *msm_gem_new(struct drm_dev=
ice *dev, uint32_t size, uint32
> >         if (size =3D=3D 0)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       ret =3D msm_gem_new_impl(dev, size, flags, &obj);
> > +       ret =3D msm_gem_new_impl(dev, flags, &obj);
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> > @@ -1299,12 +1298,12 @@ struct drm_gem_object *msm_gem_import(struct dr=
m_device *dev,
> >         struct msm_drm_private *priv =3D dev->dev_private;
> >         struct msm_gem_object *msm_obj;
> >         struct drm_gem_object *obj;
> > -       uint32_t size;
> > +       size_t size;
> >         int ret, npages;
>
> npages should also be size_t.

hmm, true.. a bit more of a theoretical overflow on existing devices,
but v2 will fix that

> >
> >         size =3D PAGE_ALIGN(dmabuf->size);
> >
> > -       ret =3D msm_gem_new_impl(dev, size, MSM_BO_WC, &obj);
> > +       ret =3D msm_gem_new_impl(dev, MSM_BO_WC, &obj);
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> > @@ -1347,7 +1346,7 @@ struct drm_gem_object *msm_gem_import(struct drm_=
device *dev,
> >         return ERR_PTR(ret);
> >  }
> >
> > -void *msm_gem_kernel_new(struct drm_device *dev, uint32_t size, uint32=
_t flags,
> > +void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t=
 flags,
> >                          struct drm_gpuvm *vm, struct drm_gem_object **=
bo,
> >                          uint64_t *iova)
> >  {
> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_ge=
m.h
> > index 751c3b4965bc..a4cf31853c50 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > @@ -297,10 +297,10 @@ bool msm_gem_active(struct drm_gem_object *obj);
> >  int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t =
*timeout);
> >  int msm_gem_cpu_fini(struct drm_gem_object *obj);
> >  int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
> > -               uint32_t size, uint32_t flags, uint32_t *handle, char *=
name);
> > +               size_t size, uint32_t flags, uint32_t *handle, char *na=
me);
> >  struct drm_gem_object *msm_gem_new(struct drm_device *dev,
> > -               uint32_t size, uint32_t flags);
> > -void *msm_gem_kernel_new(struct drm_device *dev, uint32_t size, uint32=
_t flags,
> > +               size_t size, uint32_t flags);
> > +void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t=
 flags,
> >                          struct drm_gpuvm *vm, struct drm_gem_object **=
bo,
> >                          uint64_t *iova);
> >  void msm_gem_kernel_put(struct drm_gem_object *bo, struct drm_gpuvm *v=
m);
> > --
> > 2.50.1
> >

