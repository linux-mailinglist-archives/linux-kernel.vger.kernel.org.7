Return-Path: <linux-kernel+bounces-767276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379CDB25231
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF16288463B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AABB1F582E;
	Wed, 13 Aug 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZHLL5AQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34143B665
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106831; cv=none; b=K+bfodN4ibjmAD1uuHTTatJ4KGRJ44WnBIVS4InsM4i9WFDC2Icw0dkUg8ZT+PDmMdKt/kR9E9GBxgquM8eItYjgxcW6myiHfNx5JOiwL+4L9/174xeWqKngW9+0CEZwWXMgTth6rXzO1QJ460hmvQZGImyyOQzZDhNpnNYoraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106831; c=relaxed/simple;
	bh=wOSj2Ah2UgduIpbrNuIewezDqNh/Xvc0kQlIW+94XPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWpxwM9b2BZSfEXe1C+rM70klwCajJd6W717cP1vAblW56JpGJhZ6u1sLAQGsB/uFcmjQqMObCyL8o0fV74haUbg61j3XK6O+EUJ0BsVhFkr3NSmQTeT23JSNHq0VRdUIFBwwcqcxWQLEHgna6ZPU/MxUTSeqgi9fnzsMSOQHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZHLL5AQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLg6d012543
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SGOnx8wASardlLmh6F+MJ3xLLydD3abWl/e37ujFDdw=; b=WZHLL5AQnirT0KJQ
	1IJe83vJhzUs/s44Jt9JxckEh+IY5kC5OixiGT+CLmR1z37ANq7EwwVaiUeN+4S7
	0aCWLW4gZJkrqSdxLm1dQp7XYaWcSEvEw+vjMzimZHhiZeW2P/ZV7inhrnFo7dKI
	G7vZgD+2LFYLvqtx0kcx5FVmksOKvN03zMDNFXecKKnLlikeQci8YdlkLyDi4SVF
	ib7JdMiyEGZpH4tssw7jZ5qP6Vb3eb8xB2wkzCiaktGdyjDzAbdr1AV3Apocvv96
	MRGcpOT7wjh8Aa24mo9X3wRXSdfRqUP6ue3UUQ71yiuF2Gd39D60epy5GvpZYZjT
	zGbLKw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxauqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:40:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c8804dso3351141cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755106828; x=1755711628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGOnx8wASardlLmh6F+MJ3xLLydD3abWl/e37ujFDdw=;
        b=CG24qg63c6wNQByQ4XbskmZMW9FnFdLGFu+UGjbtzcLVbXf/FFEr8HA1CDSJcXAw1c
         6HoLcA2lqxVlrI+9ws0qvSmjwlJuU0tLN4PTB4gCOg4md3nFzNme31jaABaa/Ip7BInu
         rcUwdhQY0PoyrHiqwTxfVKV8HGZRvyr6GTmyqGJ/oTUIH1SBJkOGCA3T5nqJ/KY5i2kj
         VlvLgwKvIdetQAG74/y9o/WLBA3OGFNVrvQmRqTpA9S68Ouw3l0kqe87P3ATVcZwkcwX
         Hh/PElC45maoFT2cuILffUjeljdI85KOWQZCeKm4t4k45lIBsvX9+GPW2chq3/fmoAOa
         TGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXeACWjKLNepwuPu51WNw34VzdYLh0X6bGY9/D8XYcoPoGYYSAmqEBSCzyUAGJYx/OCfmAhyMNWn1AV30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwEPhwiQlTzNLLpSAnAwlz9dveEuyJTRHUI5TFV+DMtXkoc1P
	usaQmYUVCNKolM7U/mFUGxWyap533W7xGkC0hl4EPrIT0HwKLI3ii8AdfPNze/xv4ahajqXedfM
	hOAGl55bqyCQmHC4xi49JOi8HW6Gn6UUaaNrnMn360o6Ca34jRe4hWTPFru/QEfnUfgQ=
X-Gm-Gg: ASbGncvZWF6snJou0kBj1S9LquqiAp+YBr6lTku8mcCjSLpWWb8NQ5PlgyW7+SMppKF
	i/F0VtwtXagcrLJd/5oVenRdnkp65TZtxAjBduW6di+8AHLpNJmFRcn0aiv9RKEjdixGRWA/5Oi
	ZttGKyRwBWeVuSd8WAzcp87Ektre7qXClN2wm+dZAGLd5czYTMDDR8W+XSpDQx2fqkQDwb9PAmi
	q+j22ysXshzlFFhrD7v0zMqLXWznUUNUqdi2BCGXEHxvSVZ8bemcrL14GFDcMuC5VIV2MhtX/SR
	zwG/PDqlrxWhFAt/fW9EMoNKQdZP9uiGkI+QKHJIt8eOPGeGn/Ie+ZWm9LZdnx2BkeAt/M9qmAg
	TZwyy2lM91jCvlxZ8Ot5CJ7Y/TW0+tbNYV/KFet2H7nzO6Ijfgsa5
X-Received: by 2002:a05:622a:1826:b0:4b0:80c7:ba32 with SMTP id d75a77b69052e-4b10aa6b551mr698491cf.38.1755106827989;
        Wed, 13 Aug 2025 10:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGSYwB2jPhXDGF7QnvYQoWrDeEZN5VgRz2fGxMg00AQDFPHwe889FhEH4ieuMEs9en12IG6Q==
X-Received: by 2002:a05:622a:1826:b0:4b0:80c7:ba32 with SMTP id d75a77b69052e-4b10aa6b551mr697831cf.38.1755106827256;
        Wed, 13 Aug 2025 10:40:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bd63sm5375446e87.20.2025.08.13.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:40:26 -0700 (PDT)
Date: Wed, 13 Aug 2025 20:40:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        tglx@linutronix.de, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add a null ptr check for
 dpu_encoder_needs_modeset
Message-ID: <2rtdf7azwluus757f3azwjacoiqussnoxfqqxtr3p3l4l7rkrt@dbk5pfdglugu>
References: <20250722211740.3697191-1-chenyuan0y@gmail.com>
 <ciawdvjevycjjuowmykfux2v25lvr66kzey4jklq7t5cjzqalj@qfcva77k2bvr>
 <CALGdzurR2XPoai8qshTX6hzgF-zLQ-FrsWxu5NGjrkjNzWaHaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALGdzurR2XPoai8qshTX6hzgF-zLQ-FrsWxu5NGjrkjNzWaHaQ@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXx0Vqa3Y662O4
 v9ATtzw9DGtfl7vGh637NREG+IusQ4MOCkrQZihdhHN+5OStl1Cr2kDZdacYpdd8kkCisy2baWl
 W/etdoty7GtIxculftB+h9nNhAtN4FURXAPtNqOEr1z+Qnw4K7NTCall78u/fxwgvulxn8GbD2Y
 2RamKo3vQXMP/7U4rRZIZvJLi16By2xOYDRUV/TCJbi6EhjmCz6GPVi0U9w2fq4TRnPnw+6PbZc
 36X2kzGg334RfzYxfOvYmfhquMt6verYEDrh483CrdU9oY66HjYKWlxjdRUwQeKCHZlGgcyIi9B
 JrQspyLGcZfUK+IjNBNORgbLtwH4RTNU5Jrkd+mWsgLC66cqH2VtuOqLJzLA0kEimwGaRw1pCS7
 +782UEz2
X-Proofpoint-GUID: Jc_UzEcWdbqvrLDRRJpu_YJoYOr8We1l
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689cce0d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=jpGDCbsBDmrldJ3tXloA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Jc_UzEcWdbqvrLDRRJpu_YJoYOr8We1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On Wed, Jul 23, 2025 at 12:43:06PM -0700, Chenyuan Yang wrote:
> On Wed, Jul 23, 2025 at 12:05 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Jul 22, 2025 at 04:17:40PM -0500, Chenyuan Yang wrote:
> > > The drm_atomic_get_new_connector_state() can return NULL if the
> > > connector is not part of the atomic state. Add a check to prevent
> > > a NULL pointer dereference.
> > >
> > > This follows the same pattern used in dpu_encoder_update_topology()
> > > within the same file, which checks for NULL before using conn_state.
> > >
> > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > Fixes: 1ce69c265a53 ("drm/msm/dpu: move resource allocation to CRTC")
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > index c0ed110a7d30..4bddb9504796 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > @@ -729,6 +729,8 @@ bool dpu_encoder_needs_modeset(struct drm_encoder *drm_enc, struct drm_atomic_st
> > >               return false;
> > >
> > >       conn_state = drm_atomic_get_new_connector_state(state, connector);
> > > +     if (!conn_state)
> > > +             return false;
> >
> > Did this happen in a real case or is it just
> > yet-another-static-analysys?
> 
> This is a static-analysis detected bug.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> > >
> > >       /**
> > >        * These checks are duplicated from dpu_encoder_update_topology() since
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

