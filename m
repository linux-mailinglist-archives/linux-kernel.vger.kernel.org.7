Return-Path: <linux-kernel+bounces-752561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E39B17737
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE617DC01
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1A256C60;
	Thu, 31 Jul 2025 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bItUczJe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F121D3F8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993925; cv=none; b=PP1SqlLI27vujmY0mW28to+d5En8bDYJZeD/PXG2DJQs3N0hyztEPy3nh2q6vyLTv0DYzkGtDI6xxkTnPPfn9WtkWW06BjdgKc8idFtd13Iv7aHPUuD1cXWXLcOxV4HjM3zbXt7UmKOlT+TBlr9wmz4sTOhFYOzyfMK1AYLMgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993925; c=relaxed/simple;
	bh=/p4qhSCcmRo6GxrOJG85my5wlygky270ZnqP1HAOZtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL2+XLRYxdmMPn4GCwx/ujtqoJb0BtmIrO59VLn7SqJSUwZHYD8tWNqzeqwV89v4u1Fiej00GwqHmU9nReq9n+FIXa4oLvGeWdCMpFQnz9YXpeaQ0EI5qQ77GtvR4xzbbKV1BaBQXVZJar+1LTDxPNgmtvnuYp6Ia4a+/2mUbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bItUczJe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf6DM009141
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=95j11hbpABfVkWXAtbUrfq5oYNt/9RLXdyb6uZduDVU=; b=bI
	tUczJeCkAQYvmh2+CUG6hR+kEzUQgFzWdtxpccVFSteLEausfVNDS5ZSKCx57Juy
	HVR3KsEw8v4ONwLSXFo9oaxnw31rRQ4y3bZQK2WTG22wCY7jaw5X4dZ5WW0U7MMU
	IeMz6WKXysiTTjjKA5mslzwBOomWRjwaInq2HpIdk0DUeRtijUwuUbVkqy2x4XF6
	UVZR11p1uvgjKay4sIz3gXIpBzceuwGEZN0IJNCCUePFDtVlD20pXhG8bXUc0TpR
	+kkpHNgfHAI/kZCSPMX7tlk2pINjOXtCkteSXk9qTESDjQM0CbZ5eVkSTnI9djZZ
	t6uxz1cYvZRy7ibispdA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep6pq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:32:03 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-427850a77a2so257451b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753993922; x=1754598722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95j11hbpABfVkWXAtbUrfq5oYNt/9RLXdyb6uZduDVU=;
        b=YuHkNoNRDrA7MEvFmE96HfyQ7CcpTjSo2BLC1RCzv788ioeym2C9h/IMpJEvWUeq0k
         bujt3WPdeU8CjZlct0n1nr2uv+/F5Z90Sg8GbpxHDDaBvkMcuHr3HkSp+gi7rJzQhhq8
         JnwKqWJ3MfOL3WtBS37HV5N+NEOromGFwqRxD7F+wr+4sAKakFBxf0RnFFKb9L8L5hhM
         hOgQOxpxHACe/Bd1DIb2e+pcPxoLPCyrHRu1HiqqsvBkC6V2J3LB8i+Ajhd7a/WuSjD5
         /4XEeVXNMjjPcQVYYo+iX6sELoy7JsqC7jHafkf0R+XRFZ1Ke1/8RmIyQWsqd0OjdM3A
         3gtg==
X-Forwarded-Encrypted: i=1; AJvYcCV7gW7vokSudwSBpTf6QwCNlq3layeBCTNa82vagPCT5IttihIhwcuVbC4popUYPFdOV2jdR1PKgJcmOWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmxsKbbO91mtN09ZEIQE9sHBfdSzD8qUTx0krbjf/tsbahd+O
	T66lIVXmyKUFwWqSTQbTuN5uxPXj2owhPLewxJ+ruACpf03EPZWzvosI3prWLcBoUgOz0/IuOXx
	W7ycyS+nKztmeHzMjQjWaMCKa8INOi9urrPFtMt30X/dOuyxHmvzYol3uYOIfj1WbcBdZ8ABeiQ
	zwCzBPoiOfkM/2HzPzjjDI1n10FQLCru6xYuE6L99CVg==
X-Gm-Gg: ASbGncuMZaUryRQ4l1EJj/P6fAtReuiv0M+xqBnOjSCn7Z1+zMcbvf37m1ebmS4HMrf
	EKSIuHqCTeMqWaGSExgEyTvHNqlrDoi6JUSiQEBj4wepbDRYyNGPrxtxslOCwMXiAG5S06jWnt+
	f7fCvzzLz5RHQHzURPpYpIzLqdn9hsS2Y707TOZkqTMN2HHDDZMhg5
X-Received: by 2002:a05:6808:d48:b0:40c:f698:c132 with SMTP id 5614622812f47-43199c82e9bmr5343032b6e.11.1753993921795;
        Thu, 31 Jul 2025 13:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB1z2a8DRYITGDp5oVp8wvyaSOT3GViM176ZVbHA0f+yokdIDGj8gjhCgpQ3jKYYoQb+mKpRMhxR6uPxgxVkQ=
X-Received: by 2002:a05:6808:d48:b0:40c:f698:c132 with SMTP id
 5614622812f47-43199c82e9bmr5343020b6e.11.1753993921409; Thu, 31 Jul 2025
 13:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
 <20250728203412.22573-2-robin.clark@oss.qualcomm.com> <CACu1E7F=Y2oKfiWtD0VYfmLkL24e7JrZYMt8dmoGW7zrq7bd2g@mail.gmail.com>
 <CACSVV02W28L0MS32J0n1PTpEsaq_6RxEPgb_6y6G=6TryGEPQw@mail.gmail.com>
 <CACSVV02DLSM2dHUj4MiPpogF3pgjk4ex5=9_P2AKdGmtx4bd=g@mail.gmail.com> <CACu1E7E6QaWgjFy13qP4BS_5mdhJ2vFVsnm9WtnJE3_t7rymPQ@mail.gmail.com>
In-Reply-To: <CACu1E7E6QaWgjFy13qP4BS_5mdhJ2vFVsnm9WtnJE3_t7rymPQ@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 13:31:49 -0700
X-Gm-Features: Ac12FXxbyEjKFrDZgWUpR8ETQOQajKnWdha82A9YYrUt8UGqoYorcn4PYFKocMw
Message-ID: <CACSVV02qk59riW4_UAZjd=NTsSLF7qsQW6hkYEz7JcttBJDWTw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/msm: Add missing "location"s to devcoredump
To: Connor Abbott <cwabbott0@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: NJTMwl0NAbG1CMgK57oMvIiBVMVZ6Zeg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE0NyBTYWx0ZWRfX0PJHNTDobUBD
 gRawEoAhW77EkY2YbzI0rCAIG2cBAGAKvwinozREReXD17YyF2lRRlqX/eeW3vNSSlQAPTGjjWn
 TjQFdT2XNmu3gsB+ZF/K40j38bHmeF2EIqyYbZj4TtXe3tsrmOilqPNmBTwkyyQAAk0O/tKkgMx
 BtwL+AmphLOEhlHYXYZ5l2DWhE3UjweQ8nNf5u76X6pVajumuzOxwRXAproGmAA2hA8ezpio1zW
 vM6BiWTtXjoRNaMyt7cUw/78JEhbxc/Hw48+1AyHB1H/LX849UMwAm3BOiNqQ3tUqv9fIHzOkQ/
 FBvaGVc64zVtDDZaA1lBxPeYpII/NsV/O+HUfUS6PFoucwdr54NH1d6Uz8krlaKWjS9zHbCqQfh
 6BKbsQBKOvi839W6Y9P1n2K9NKNfP1qkqrPO5RG/p8diC9naXLwfxdQ3cNUjCOfa03OoOY2X
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688bd2c3 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=3X2iVFLOVPrzddhlX30A:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: NJTMwl0NAbG1CMgK57oMvIiBVMVZ6Zeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310147

On Thu, Jul 31, 2025 at 12:16=E2=80=AFPM Connor Abbott <cwabbott0@gmail.com=
> wrote:
>
> On Tue, Jul 29, 2025 at 9:40=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm=
.com> wrote:
> >
> > On Mon, Jul 28, 2025 at 3:15=E2=80=AFPM Rob Clark <rob.clark@oss.qualco=
mm.com> wrote:
> > >
> > > On Mon, Jul 28, 2025 at 2:04=E2=80=AFPM Connor Abbott <cwabbott0@gmai=
l.com> wrote:
> > > >
> > > > On Mon, Jul 28, 2025 at 4:43=E2=80=AFPM Rob Clark <robin.clark@oss.=
qualcomm.com> wrote:
> > > > >
> > > > > This is needed to properly interpret some of the sections.
> > > > >
> > > > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/driver=
s/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > > > > index faca2a0243ab..e586577e90de 100644
> > > > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > > > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > > > > @@ -1796,6 +1796,7 @@ static void a7xx_show_shader(struct a6xx_gp=
u_state_obj *obj,
> > > > >
> > > > >         print_name(p, "  - type: ", a7xx_statetype_names[block->s=
tatetype]);
> > > > >         print_name(p, "    - pipe: ", a7xx_pipe_names[block->pipe=
id]);
> > > > > +       drm_printf(p, "    - location: %d", block->location);
> > > >
> > > > We should probably at least try to keep it proper YAML by indenting
> > > > everything after another level...
> > >
> > > this made me realize I missed a \n... but otherwise I think the inden=
t
> > > is correct?  Or should location not have a leading '-'?
> >
> > beyond that, even without the added location field, some random online
> > yaml checker is telling me that we were already not proper yaml.. so I
> > guess, :shrug:?
> >
> > BR,
> > -R
>
> Before this change, it looked like this:
>
>   - pipe: A7XX_PIPE_BR
>     - cluster-name: A7XX_CLUSTER_SP_PS
>       - context: 3
>         - { offset: 0x02a718, value: 0x00000003 }
>         ...
>
> Notice that each nested thing (pipe -> cluster -> context) has an
> additional level of indentation. Now, it looks like this:
>
>   - pipe: A7XX_PIPE_BR
>     - cluster-name: A7XX_CLUSTER_SP_PS
>       - context: 3
>       - location: 4
>         - { offset: 0x02a718, value: 0x00000003 }
>         ...
>
> So it looks a bit weird with the context and location not being
> nested. Also, I think the correct nesting HW-wise is cluster ->
> location -> context, rather than context-> location, so the location
> should be first. But ultimately it's up to you.

In terms of nesting, type, pipe, and location are all at the same
level, and then for that tuple there is SPs nested under that, and
then USPTPs nested under the SPs.  Although I guess we already had
pipe nested under type..

BR,
-R

