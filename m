Return-Path: <linux-kernel+bounces-804493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC71BB477F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45536581B11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F292C0303;
	Sat,  6 Sep 2025 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kW0gRatQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0252D47FA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757196340; cv=none; b=M808SAm8C9AsJdkoCP3IB6p2H3uPxy+qPJwYVAbQ4Gy84JozCPDrOq0LhHHkrtYBK7PUgFp40vzH4zczwqRF59CDu7Pp6kqi/J20aWxBspyFqYCsat9S02/jjsWHVRRA2kn6xMGY2v3S5CLcey3MtYJ0Ay/AJoXTZK18LUbp/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757196340; c=relaxed/simple;
	bh=PizKlYPZi4JEYYg1F4ZfcdShfjqLFu9Vovun26+xGNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOzulJYaoKqbnba1wxzOqQ/nmqtQ1jiwiVJ/ud2fBSzKogSjpRWJcllcf6VXg39bMHzX/ApG+m1oGGBEqSUuPptwGOr50WQ9mapj71jkap3+LUuIydvThqekZz0yVO7Iiy65N2jLaMqOSZhUcxe02B/katJ7UGmHz2vTz8PYfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kW0gRatQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586LCWl3028106
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 22:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=1/PCmJJWhMUmpNwL0kEscnsVt/EoNeL+XScU5aYT66k=; b=kW
	0gRatQAnw+hysDlLi43K0eBvYY5vC5Rtx9pMkoKoWugwHgq3NoesZRyvZIzG3gPb
	4U596JJo8eqsLMQ6yzf+d7Eg+Jx0sSMSdfrp0d1SeLnLyoHI5vKLqtcLJwFHBRXI
	P1d1U2vz/jK3/oPIukQT0mM3eBBhNrubbua/OwqRNV3EH34LvX28PJW96PSK5w1/
	ceIrTlxIxwg8/+Q/ue4wTNkegb5fWxJS5uPrqabrrNgSIAkgUq1s6m7SJ0TRb3jD
	WtzhLFNfzpCpdat/LENZx4iC8LtMpQ7wd06ecZONHnV0HZnWKH/R7fEdzJPQzDzc
	g2nu3t2amHi2zgxUK7cQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws1atc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 22:05:38 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30cce517292so1231732fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 15:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757196337; x=1757801137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/PCmJJWhMUmpNwL0kEscnsVt/EoNeL+XScU5aYT66k=;
        b=k0ZJ4MiTs+G94A+M+7l0QOogrL38L6ljZF1iu5VEDSwuo4LSxVrRaNVs01lEkArtlJ
         4N5MHuUSr3T7HDPVRmCJOkw/pts+CIHRC0wsK6x//49NXXxulK26SZ7HUt4Xa+l6R9jQ
         mBioBzP5VUvtLUBWKyYU2aRbY0YVLHvV01jCo9gpzEDdP18S/SsXr+mez91q573CE9gi
         9zlf5frSlAUKifzt45xB8V07Au1EIWsqeIM19ieGJWTvOtn3e8vMT1tm0CA6FxUMgX5z
         xZt3lN/GT6nLEaNkKSMLbF62ptSOdmNxgpT3QoO7fMQVy8aD4QJfjGVuAgiDKxCKi6Ae
         4NwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJjhFHpXXHq4PrE0+0Vj3RszGYKNbsstqAggQjXrqnc7WznjligPQeZtViP9hLBEIft09zH0z0/OdWBD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDxwTMuvUpqbBrfm/GIT4uZv+iRd5I1MhserrL64lVEWCnNtC
	pI/kLEFeqHf36Ag8KikWvJO9BtCvalHLPwOfLSc92UBAwjsSkb5c9ShyBj/zUre8kKJq0SfF7y7
	p+7jOuj1lCmtLl9Qu4UKMbPDqbR6kd+2kuNnRzSvEYf0j6M85pnqzEvA0KCey/zbWLEYErEA/jX
	sjmB8TDUVCD8iQ3WSlVucqDzTeY6VWnQQg+WvoTDdahw==
X-Gm-Gg: ASbGncv0mzThDsG6FWrlMZECiRF9+QN2Oo7QmcNSGyK7TyuszaPguOTqh+SUnS/fprc
	5j3nHYGKRr+XqFsgggKdbKEOPn6oGCb08va7Q/JK5UXecQYhajxZsDpx9uScU3JXSTkcGlAYKyl
	0e44WcHYrXOebHae/R1FAA2C6GHhy8J0ufTsQ05cfLsLEmnDjKCUSu
X-Received: by 2002:a05:6871:d3c2:b0:321:2772:dc1 with SMTP id 586e51a60fabf-32262a68588mr1237576fac.9.1757196336937;
        Sat, 06 Sep 2025 15:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWMtv3HLa4C5OnUjRIQpatVYtxNuxdgaMlVWrIMD7IQL2Dl+xRzcOBRy47dB0ODF3YQXR3eDuSqaKJhPR5OMA=
X-Received: by 2002:a05:6871:d3c2:b0:321:2772:dc1 with SMTP id
 586e51a60fabf-32262a68588mr1237553fac.9.1757196336218; Sat, 06 Sep 2025
 15:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906170542.481588-1-robin.clark@oss.qualcomm.com> <wbuvnhcxh4flicbgipuql2otwv7oqkol2pmdyvschpudshejy4@euajhp2sgnyq>
In-Reply-To: <wbuvnhcxh4flicbgipuql2otwv7oqkol2pmdyvschpudshejy4@euajhp2sgnyq>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 6 Sep 2025 15:05:25 -0700
X-Gm-Features: Ac12FXzoeNcl08d0t96E15SNDUE2_YRICbqiF8-49-FMLSx8fhvFR-OuUPBSy8w
Message-ID: <CACSVV035P-xBFd7=MjCSKoyfp79_ztEoBEEaDc9HYPtZgVQAbw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Sync GPU registers from mesa
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Karmjit Mahil <karmjit.mahil@igalia.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: MV2RGziXh0BKUiIJN7qwRcpZBgeMKOUu
X-Proofpoint-GUID: MV2RGziXh0BKUiIJN7qwRcpZBgeMKOUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX+d8izmdROiBl
 T9+8GkoZpDeofeN6f9tGwD1bR/jzn2fnzlH4n1jq/aJCGK8OHNxfltzJBdIVA/UTC69JdID37uX
 IKGWLIs8DssGD9txIMO9hTB8H4W9YEnZr6lTIcJz/yy+b9ieSMWa6jIctCUwfkgHMZjLyRsojdr
 5/ts8Tp4Ym0DEAjBaHjSc1I9Qe/N0t3EsdjUR331Ti9hkfkjgYeBKYQ5bBsuk4K27w+5uv2MZi0
 OU4i4vKzKbOqBJAQTKWG9i/GHtyuTePLU0zGpf7NDquOeG58/IuI6YeWKN/toSqI9xZrTPWxJoR
 wyEY323MOJP2mFzUinye8/nLJDu2TzcvqMGnM9QsItmLMKUEivC9CV8qVdC87fiSw8Y4ctJrttW
 FnwjDohG
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68bcb032 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=V2sgnzSHAAAA:8 a=xoiZakKlt4UH7s2WbAAA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Sat, Sep 6, 2025 at 11:55=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, Sep 06, 2025 at 10:05:40AM -0700, Rob Clark wrote:
> > In particular, to pull in a SP_READ_SEL_LOCATION bitfield size fix to
> > fix a7xx GPU snapshot.
> >
> > Sync from mesa commit 76fece61c6ff ("freedreno/registers: Add A7XX_CX_D=
BGC")
> >
> > Cc: Karmjit Mahil <karmjit.mahil@igalia.com>
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  10 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  19 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |   5 +-
> >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 718 ++++++++++--------
> >  .../msm/registers/adreno/a6xx_descriptors.xml |  40 -
> >  .../drm/msm/registers/adreno/a6xx_enums.xml   |  50 +-
> >  .../drm/msm/registers/adreno/adreno_pm4.xml   | 179 ++---
> >  7 files changed, 524 insertions(+), 497 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index 2e2090f52e26..3f5c4bcf32cc 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -247,8 +247,8 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6x=
x_gpu,
> >        * Needed for preemption
> >        */
> >       OUT_PKT7(ring, CP_MEM_WRITE, 5);
> > -     OUT_RING(ring, CP_MEM_WRITE_0_ADDR_LO(lower_32_bits(memptr)));
> > -     OUT_RING(ring, CP_MEM_WRITE_1_ADDR_HI(upper_32_bits(memptr)));
> > +     OUT_RING(ring, lower_32_bits(memptr));
> > +     OUT_RING(ring, upper_32_bits(memptr));
>
> Could you please comment, why are we droping all these accessors?

We redefined these addresses as reg64 so there is no longer HI/LO
regs.. which works better for the c++ builders in userspace but means
these accessors no longer are generated.

I suppose we could perhaps make gen_header.py generate legacy hi/lo
regs from the reg64 for the "legacy" C builders..

BR,
-R

>
> >       OUT_RING(ring, lower_32_bits(ttbr));
> >       OUT_RING(ring, upper_32_bits(ttbr));
> >       OUT_RING(ring, ctx->seqno);
> > @@ -278,9 +278,8 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6x=
x_gpu,
> >                */
> >               OUT_PKT7(ring, CP_WAIT_REG_MEM, 6);
> >               OUT_RING(ring, CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ));
> > -             OUT_RING(ring, CP_WAIT_REG_MEM_1_POLL_ADDR_LO(
> > -                             REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS));
> > -             OUT_RING(ring, CP_WAIT_REG_MEM_2_POLL_ADDR_HI(0));
> > +             OUT_RING(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS);
> > +             OUT_RING(ring, 0);
> >               OUT_RING(ring, CP_WAIT_REG_MEM_3_REF(0x1));
> >               OUT_RING(ring, CP_WAIT_REG_MEM_4_MASK(0x1));
> >               OUT_RING(ring, CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0));
> > @@ -1320,14 +1319,14 @@ static int hw_init(struct msm_gpu *gpu)
> >
> >       /* Set weights for bicubic filtering */
> >       if (adreno_is_a650_family(adreno_gpu) || adreno_is_x185(adreno_gp=
u)) {
> > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
> > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
> > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(0), 0)=
;
> > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
> >                       0x3fe05ff4);
> > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_2,
> > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
> >                       0x3fa0ebee);
> > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_3,
> > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
> >                       0x3f5193ed);
> > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_4,
> > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
> >                       0x3f0243f0);
> >       }
> >
>
> --
> With best wishes
> Dmitry

