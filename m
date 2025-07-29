Return-Path: <linux-kernel+bounces-749449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5CB14E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EED17B736
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758081991C9;
	Tue, 29 Jul 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k67GQX+y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666619994F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796417; cv=none; b=r1dri8PVjB1LFDeFtkOYMhazQxiWyYQoTejNIADoWCjWCDccCogTkRkLm705i74ZR+/UTJ4iBqGUvUCNpZwQilaA/QS4fFkwFaRohq3F/O09dcyZMHP64tAUqai9v3lBg805FNTPTIagPKqCa5gxKX9zu328960yDDccrq+uuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796417; c=relaxed/simple;
	bh=JuUR2v0lz8uvI1VxvsVABNkZZwcyePThry1CF7Ju3ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cw6QatjKC+DEOGDi5XUD3fmI7O/Dz/qCYcSCF7p/IyH0O3kvm9W4nb8+Olz4TXatGnds4rtOQQHvUAUfUtWATeue8IEKQpY7EZse3tWfx0J8Rc8v+6CPGg9y51oi/4al8i5No0xNrr9mJrOSAUNSJ6mfs6PAZhSu2Kj6PUQL7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k67GQX+y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9FftR028520
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=HLQ2yUgG0gFIFURD76i4Mqz/jV+uThgccL9ep7CGuxI=; b=k6
	7GQX+yLg6ftc4AUhslhPJ/bzpJSeGBK4cIhSIKmHQGil9vtARXhgDZPJGxMXmuGC
	sMY4lnFuSjZYQ+aiYIUjngUi9JtW7pYQWU02fvjE6jEoDzl5cg81WjIsX7iNK5Zv
	WLvHBSRBgiEIhzdZk+hVclfIs4vcwqsYwZq95ij0m4/+BnURhjslpGP/ym5ykHNi
	Y35ut2bmqB+JCIZP2lYWPTPCC44T0r9PSrmhDvScS/8IUaLGxhNCjbdnlgNtK7lr
	3CIvauZabbUGs1vauPChnIkCdlOr+FKV5XbuFw6ZuPZWph6pVFTt9B51PkRxXLYO
	WgneYO33PsSnS3ixK1jw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2g661-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:40:14 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-41b398d3704so6741971b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796413; x=1754401213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLQ2yUgG0gFIFURD76i4Mqz/jV+uThgccL9ep7CGuxI=;
        b=FhBKKDBE2ghw6sR8oq7pLrjg8enhid4HYEOQWMmmvaOaAQjbCr8/3NVCeP6Znr7aLa
         OcJwvgCrZg/zMJ1pGLRXaJTPcMeBqm+n76UlBb8x98+AHmIWlnJZiF2dxXRmCHJ5AXTx
         87xgDRC1sJNKtcXDoqkY0foxrcn7S58+YqUtWmBCtDFFLlowpswPB9ZtswoHgqdOErcz
         Px7Vw+l25q2P3oAcQevUfkdtT3UiU4o31FT0hAD5XXdilixxwDi4bzXUzYHF64oJlMdq
         3pUHBbu6F6bdMhkqxoc6alk5ooHQ3j0T9V+bz/jAaUCzadxc3VZEY6FzMqSDZRm3AgrG
         d3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxQm6HE04Kt/LD8Nll39gkKyj1gXGcQ3hQyj2igK53tHZb4COLI3T5oju9a7V+HM8v1o1MDo51Awk6gYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfrW+zyVtEvfo/0f3IayVlDTBIiUGN/lctcsQL+TZ8kQNCqpBi
	fIit79SpA8oKPl2un/YWfkrFxzEX8xrGr3FLTQiHnxjkvYZ4Bd/KvGuQshUpfatriwumeSZcB+q
	Oxj0pgPHkhK/iIyfFSxgFh4toXc9D2VHX/nIuknHubLZl4DiQuovE5pfmJ5gt7dVV3hJbTvLxTr
	i8umcrUfoNoHL93S7jefRxoUYUZU8y/77RZhhtfHNbiQ==
X-Gm-Gg: ASbGncuh+9dS5pDjhfvT8v7HyCp5hxqvcqSXlnD6H15u0neL9Y/xSFJyEdV7rf92Bah
	Lp1LpjpP9HXligZsJNM2jPZpiqF/f8w8PZkImj37RejlhU0rTzrttyDTPYNS2gu/iHHb1cxTBVJ
	1ExQTR57NIi07b6boswSpHP3VhSHgT2A7W1Z0MfmDpwQs1mCNc5zPG
X-Received: by 2002:a05:6808:6801:b0:404:dad4:f971 with SMTP id 5614622812f47-42bb972a2e3mr9290690b6e.33.1753796412965;
        Tue, 29 Jul 2025 06:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqf4clMcdqT5vWJ+nvIVIeCHsaCdP9DQ2Xz98Wpurg/ABYUj+EgAD19sV+SQb892Lv/ifuAOnr9etFXbN2drw=
X-Received: by 2002:a05:6808:6801:b0:404:dad4:f971 with SMTP id
 5614622812f47-42bb972a2e3mr9290665b6e.33.1753796412292; Tue, 29 Jul 2025
 06:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
 <20250728203412.22573-2-robin.clark@oss.qualcomm.com> <CACu1E7F=Y2oKfiWtD0VYfmLkL24e7JrZYMt8dmoGW7zrq7bd2g@mail.gmail.com>
 <CACSVV02W28L0MS32J0n1PTpEsaq_6RxEPgb_6y6G=6TryGEPQw@mail.gmail.com>
In-Reply-To: <CACSVV02W28L0MS32J0n1PTpEsaq_6RxEPgb_6y6G=6TryGEPQw@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 06:40:01 -0700
X-Gm-Features: Ac12FXx6wa3mBL8aH-OOfMIc4b5Q0MeA9kQw7eyuD2mIfr3Ns8qFmq3Be1tUb5g
Message-ID: <CACSVV02DLSM2dHUj4MiPpogF3pgjk4ex5=9_P2AKdGmtx4bd=g@mail.gmail.com>
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
X-Proofpoint-GUID: tgHMSu7ub1rkklPVKpHocvMUoAXdOsCp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNCBTYWx0ZWRfX8ekZ4kHxuFbB
 TI0/BTb9RsQv/9mh+iryfOsP5H2Tie7UpW4NbTkN6GkwC/Gj8EzysHWVzrVhIHzM0lSx6/Iu2CB
 bwbseR4m61LSA+KuD01lW1SsnmUZbe9d/mSakeWPT1xNydB46JWEe2wtGXdFxEe4DVHpZTt2LYH
 xg+OvKJfD2MDbWfgWbMHo7s3I0Z1LX0i5T8o6mK5kUMqww9JRZl/+f2+uHUOrsMX7KIp1Y9pHXU
 /M0/fO5UNdl/FucYS1PbhukpZFsex0+ahYOAtg60ksQK9evGucWFwTA8g41y57iGIGxrPaUdM4b
 TQgOmErWnGqqffptJiGALN8L/d7N6JPHmwnRUkHbRPCU1mLtwc51bSWHZrxXdYqHyLpXm/ryg3n
 voiVT3fn/TKJjG0+dTa8wLeG/sBzQxTgBlagtQM586NwEH4Yp3QQp7GD3x7I0q4GO93SWEOC
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6888cf3e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=0I_rIkXGDByXq9DAmH4A:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: tgHMSu7ub1rkklPVKpHocvMUoAXdOsCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290104

On Mon, Jul 28, 2025 at 3:15=E2=80=AFPM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Mon, Jul 28, 2025 at 2:04=E2=80=AFPM Connor Abbott <cwabbott0@gmail.co=
m> wrote:
> >
> > On Mon, Jul 28, 2025 at 4:43=E2=80=AFPM Rob Clark <robin.clark@oss.qual=
comm.com> wrote:
> > >
> > > This is needed to properly interpret some of the sections.
> > >
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gp=
u/drm/msm/adreno/a6xx_gpu_state.c
> > > index faca2a0243ab..e586577e90de 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> > > @@ -1796,6 +1796,7 @@ static void a7xx_show_shader(struct a6xx_gpu_st=
ate_obj *obj,
> > >
> > >         print_name(p, "  - type: ", a7xx_statetype_names[block->state=
type]);
> > >         print_name(p, "    - pipe: ", a7xx_pipe_names[block->pipeid])=
;
> > > +       drm_printf(p, "    - location: %d", block->location);
> >
> > We should probably at least try to keep it proper YAML by indenting
> > everything after another level...
>
> this made me realize I missed a \n... but otherwise I think the indent
> is correct?  Or should location not have a leading '-'?

beyond that, even without the added location field, some random online
yaml checker is telling me that we were already not proper yaml.. so I
guess, :shrug:?

BR,
-R

