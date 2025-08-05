Return-Path: <linux-kernel+bounces-756626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137AB1B6F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B47B17DC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBCF277C98;
	Tue,  5 Aug 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8hVdAa9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9572561C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405983; cv=none; b=rCnlssbaGAF5FcjaL5g3CkIwY+Ln949hLt2P/2YfbeStJfFyOe+X+qg0cybyTx0xgQOq+/ycIbPq3OXn5yzbRsykwqcDSBOrsNI28yB+MJW9tCp83dpPVmxs40TVC3wC0Bioeg6eYOrY+OSlfE/3Nne3XWI7N4ITyEw6kNGaRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405983; c=relaxed/simple;
	bh=Pqpsb/yXPZJX6a6smsikIW3wjqsIsbIqICPjhHLioKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pP7MyL5wgjD17JuC24qpDRMrg4ocQZCyI83apITvWSlGx4yLeh3VWyib38T3+ILWemNwES/nAhrZMrgD7q5q2uDhFl7Fx0XA+cW61rnAPapQGm3APMAu5wdhbY3V1HsprJevR2eyJyCUG8+vm32tGXtLAuTRF3rD87ldqGm4hIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8hVdAa9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575AL9o9011625
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 14:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=5VP7v53va29cpzA7nUn1M5nUaw4K/K2gvLeC0gIRIqI=; b=I8
	hVdAa9vHymGy1m3iqE1rs/uXu0OxpGYo0/rAmvtRC4Q/PiSAZwvxA/qCJisjakNh
	e2DEkDS1CHYTABLl0zmGtlUxrpHB7v/ghPhYbiMGGXngaMUaw06Mo8SmOZ9rkrQf
	gFKl9fjcURWaeAcDWUyl5L0qS1IfxKZrmiEqDOmpZqeHw29W+DSqlFtjrLMJJWfS
	MoVALtRJcU55xSvftDaGkMbH3/vArzFMwvUiS9OcT9pzkW1I+lWW0FPh4qTPF3YA
	O8AScuGwREufjFmwMp4xLNnyXM8neUrewBTadujJJS5br7Ag5OeSzmeFosh0ksZe
	Owsr3HGl8OC29rOEmY6g==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48b8ag229e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 14:59:39 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4139102c7f9so4488756b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754405979; x=1755010779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VP7v53va29cpzA7nUn1M5nUaw4K/K2gvLeC0gIRIqI=;
        b=UBk5woAe+9OQyxefhAitcLpJ7qxJio8feP09vBK9mxXC9POXXaM4NPsbKny10lrHD/
         wF/XllEdLYrMQPEyIN3pBCZLTcHIgpn5kSjC+tOuiUmS4OnabeHEgwmrIkMsxlaYJD/i
         P0p6U1algnpzX7vNzBr6yn0i2OQcBzg9z9ngw4rtDp5aivtJIVVLx+DCCMZ4qZkuQ5ne
         DQAIQQgIfCSS3cXmZhS6pyf0+XodmjE4j+2Ksk4dg9PQIo6HlIF9fdPRO7omiSnvOAZV
         AM3ay/CYyvw+T0j01DkTmN8hTI7/ea0M7HIMYLDEZW8gz/pDk/MGbKsBtZor8Ax8S5eJ
         0Z9w==
X-Forwarded-Encrypted: i=1; AJvYcCXldum5+JnKYleFEOCFY93QgTq5HcwLnZZygHgAGvzwY0J5tfanKfTiSYUPOFj4ojwS5Py21B5/BRrvpKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Knj34Xzgclg/3UOuv4XaU8CLYSg+BBx7o65B7tqmIgsRGkYP
	ltMbOFfupVQtAN+VeNndesay71LsA5kDCBFlN49RyToKkQtnXGVOvKvrrLNDDgto4iIyjOj/vUo
	kAMIiWVETxCxQZ0MvIoJml8VPEjzXY7wIECcZjQqChOh8y1VOh3qj4z0COnPMUJaE9QmljpfEAn
	GRJuIOcrov+UjCoOOpJlN3dMqyIT3cFwH3C1L6GsEwOg==
X-Gm-Gg: ASbGncuIkVEGWAfJJ6VxGKIZvwv6e39s9TMgTgrKenuEMgQrte7AxgD2Gc/eU/w7HrZ
	mKu2/nmHYvETppHY+UUTuyNs5XIIFQf7Z03Tai096DaUpEPuY95w1x4O4zKcAuv90MhMmG359lN
	SgOWwGFiVdXtT/LQRpIDL3/y8eDV55HiGb6A6zR+Es19VAwIt61oE6
X-Received: by 2002:a05:6808:124a:b0:401:e721:8b48 with SMTP id 5614622812f47-433f020d6f7mr7919647b6e.8.1754405978873;
        Tue, 05 Aug 2025 07:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+6ybutU9RtNNd8gKO1lElM7QyIOMCpne6QzqtryagfoJGG3ah1wcU/O0jC53ssU8ygi7M+t21QA06+nZ7Szo=
X-Received: by 2002:a05:6808:124a:b0:401:e721:8b48 with SMTP id
 5614622812f47-433f020d6f7mr7919636b6e.8.1754405978390; Tue, 05 Aug 2025
 07:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804214317.658704-1-robin.clark@oss.qualcomm.com>
 <20250804214317.658704-2-robin.clark@oss.qualcomm.com> <DBUE2QU2CH9N.3C32KHT9LHMMB@kernel.org>
 <CACSVV0270Zk4ApR_pGZ+sKgoi14kvfOo_NvzVq3-QALE0mpFsQ@mail.gmail.com> <DBUKRNHY14ZN.95GVIGMY7RAN@kernel.org>
In-Reply-To: <DBUKRNHY14ZN.95GVIGMY7RAN@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 07:59:27 -0700
X-Gm-Features: Ac12FXyia9P5tgbRPxVXrZTiL6VK4xUgl9aLrubrFFRerh-QJyYy5THAuzSUSx8
Message-ID: <CACSVV01zZ=o55YY=GHTKaJY1HorRUu73KA+5Puz2MonqH7JwuQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] drm/gpuvm: Send in-place re-maps to the driver
 as remap
To: Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zSHzZoWKcVNec8jEPex8BADbMg-L3nkk
X-Proofpoint-GUID: zSHzZoWKcVNec8jEPex8BADbMg-L3nkk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwOCBTYWx0ZWRfX0X3nqMwzP93F
 JbHCbzzPBQbA+79dKrzL7SNdYLIolHJEJQesQddIfRdcp5Yx3YzO3b8ny2GuHLHcVKdZFEHb1xv
 yA9eB7PdEajAsivo4oWyOZZzS+bgCCk6cEc4U/XEuUEQCIbyVBVSFHG3VcCEpBrk7u+SmHbqe7C
 cC37rgsi/Jo6LxOwrL0wmUk+XIQ+nyLmE8JsCr1cJH3I49SvGMU0Qy1NimBkEHPHxUIDdmgZXk8
 tRQYEY4iYikuvElirCf7Ydlv7yjN2oWWBSKCWWMt4rhLBWCqXZz9MjYjUxFhpR+4z6j87rRLoKK
 rVZpFZN9w+wOG9k7SetR+rpfS2/aHNS1fy1QehJupfczm7BhFdkI8n/2UoaQ9RnaN/nFqew0NzT
 nmmoqVf/kAcfm6vMDKEq2zoWxeockrLoqcZrqbctS9MLTL/aSg3RYpWcj0tJvGPs3ksLIr/C
X-Authority-Analysis: v=2.4 cv=aJvwqa9m c=1 sm=1 tr=0 ts=68921c5c cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=VwQbUJbxAAAA:8 a=gugPwdCod9cupdveROQA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050108

On Tue, Aug 5, 2025 at 7:48=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Tue Aug 5, 2025 at 4:32 PM CEST, Rob Clark wrote:
> > On Tue, Aug 5, 2025 at 2:33=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >> On Mon Aug 4, 2025 at 11:43 PM CEST, Rob Clark wrote:
> >> > diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm=
.c
> >> > index bbc7fecb6f4a..e21782a97fbe 100644
> >> > --- a/drivers/gpu/drm/drm_gpuvm.c
> >> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> >> > @@ -2125,6 +2125,27 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
> >> >                                offset =3D=3D req_offset;
> >> >
> >> >                       if (end =3D=3D req_end) {
> >> > +                             if (merge) {
> >> > +                                     /*
> >> > +                                      * This is an exact remap of t=
he existing
> >> > +                                      * VA (potentially flags chang=
e)?  Pass
> >> > +                                      * this to the driver as a rem=
ap so it can
> >> > +                                      * do an in-place update:
> >> > +                                      */
> >> > +                                     struct drm_gpuva_op_map n =3D =
{
> >> > +                                             .va.addr =3D va->va.ad=
dr,
> >> > +                                             .va.range =3D va->va.r=
ange,
> >> > +                                             .gem.obj =3D va->gem.o=
bj,
> >> > +                                             .gem.offset =3D va->ge=
m.offset,
> >> > +                                     };
> >> > +                                     struct drm_gpuva_op_unmap u =
=3D {
> >> > +                                             .va =3D va,
> >> > +                                             .keep =3D true,
> >> > +                                     };
> >> > +
> >> > +                                     return op_remap_cb(ops, priv, =
NULL, &n, &u);
> >> > +                             }
> >>
> >> I don't see why this is necessary, a struct drm_gpuva_op_unmap carries=
 the
> >> struct drm_gpuva to unmap. You can easily compare this to the original=
 request
> >> you gave to GPUVM, i.e. req_addr, req_range, req_obj, req_offset, etc.
> >>
> >> Which is what you have to do for any other unmap operation that has ke=
ep =3D=3D true
> >> anyways, e.g. if D is the exact same as A, B and C.
> >>
> >>         Cur
> >>         ---
> >>         1                       N
> >>         |---A---|---B---|---C---|
> >>
> >>         Req
> >>         ---
> >>         1                       N
> >>         |-----------D-----------|
> >
> > Ugg, this means carrying around more state between the unmap and map
> > callbacks, vs. just handing all the data to the driver in a single
> > callback.  For the keep=3D=3Dtrue case, nouveau just seems to skip the
> > unmap.. I guess in your case the map operation is tolerant of
> > overwriting existing mappings so this works out, which isn't the case
> > with io_pgtable.
>
> There is no "your case" as far as I'm concerned. Please don't think that =
I don't
> care about solving a problem, just because it's not relevant for any of t=
he
> drivers or subsystems I maintain. :)

Sorry, I didn't mean to imply that.. I was just trying to point out a
constraint that you might not be aware of :-)

> > I guess I could handle the specific case of an exact in-place remap in
> > the driver to handle this specific case.  But the example you give
> > with multiple mappings would be harder to cope with.
> >
> > I still feel there is some room for improvement in gpuvm to make this
> > easier for drivers.  Maybe what I proposed isn't the best general
> > solution, but somehow giving the drivers info about both the unmaps
> > and maps in the same callback would make things easier (and the remap
> > callback is _almost_ that).
>
> I generally agree with that, my concern is more about this specific patch=
.
>
> There are patches on the list that replace all the req_* arguments of
> __drm_gpuvm_sm_map() with a new struct drm_gpuvm_map_req.
>
> Maybe the unmap callbacks could simply provide a pointer to this object?

I think that would help.. I'd probably want some additional
information about overlapping 'keep' unmaps in the map callback as
well, or at least the range of the 'keep' unmaps so the map callback
knows that part of the new va is already mapped. But this seems
doable.

BR,
-R

> > BR,
> > -R
> >
> >>
> >> In this case you get three unmap ops with keep =3D=3D true, which you =
can compare to
> >> your request to figure out that you can keep the corresponding PTEs.
> >>
> >> Besides that it changes the semantics that the documentation mentions =
and that
> >> drivers are allowed to rely on, i.e. a struct drm_gpuva_op_remap repre=
sents
> >> an actual change and any call to __drm_gpuvm_sm_map() results in an ar=
bitrary
> >> number of unmap ops, a maximum of two remap ops and exactly one map op=
eration.
> >>
> >> >                               ret =3D op_unmap_cb(ops, priv, va, mer=
ge);
> >> >                               if (ret)
> >> >                                       return ret;
>

