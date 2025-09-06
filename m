Return-Path: <linux-kernel+bounces-804500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87FB477FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7340E1C236FF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634E82D7DC5;
	Sat,  6 Sep 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yo/uxGES"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52B2D7387
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197173; cv=none; b=ecwVEAZxoSYiSEbxstjtPdZOA3sKVXjlswDEhpoAp3uxnVwNm6XuIzmBWrgNCLAc9oOeNNW4Wz2KuG23wgyoTJhmfvkMxmb3HM9o9oQsAFwFpFkW2lbR7TESrVMG9hw4gryZ5RUvRUjK8iQyu//ZCL+EGzCnK5nYqcrXaoLsARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197173; c=relaxed/simple;
	bh=d8G8EKPq8WdswmM10nBeHdygc+0s94TMpc7uomUfZgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcEeSstZZwdM0BZ590mkMuIrOSkpqlcAn5nuruW5NtPPs1wc5ikjUyccf7i9/w5V8jvkl3Sg77t0kOCJn5bOyleB8XtilNcVWLdvHYTjKfcJDjpNfdOFZ4QC6So+YIfrB6Z0ks9AOPZ8bjM40PqQzBwhHLgmh8cAqiwIsCNOBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yo/uxGES; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586LuIEa022634
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 22:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5iTNyga9h1nIGbJ+xAREn3+C/daXiXE9zIswfnn0wYA=; b=Yo/uxGESeImF94iQ
	MJ0AaS80UC9ARIVRahj8xzTFIhT3VM9tEJNchCLkcxe8dzKzoQ4IzCmBGdF/15h1
	Yh983JtSf8S6TUn2oInNvX2Pm4u/UEQkqXNNzk3PFLRxlBLjmMJydAqtk58rCT3P
	O48CVPzkTwOJ4/Zb2T9xfRKhisC8ELPw8ksWJgA92GayzbqBpzTUMVANksAm2Sef
	ECF2cpQc35JUD87kiEZVL9Tny/D98FO19S3zKesCj4YYxon21vuF9lb40rdL5asW
	1oi+jx1BA0iVf5y+XlvoorWDrfhrdmtJEjaNfz5/lNyq9P9vFX+G5fI9p+9RxDQr
	qpYxGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j1avn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 22:19:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8153161a93eso156267985a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 15:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757197170; x=1757801970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iTNyga9h1nIGbJ+xAREn3+C/daXiXE9zIswfnn0wYA=;
        b=AEGw024ng0s8kYlglZXZA5tOcdAFn9B0yQQR6ParkKTni7rtblwVjxWvICWmeQ+fYT
         uITlTusO4QRzxetlmij/mUrd+fAy/HnXv/h6sw7BAHw3KxyjbH8BSXsqfITrxV0GlJe7
         /47NsUNhnHg9y2bpJyx9+9WJ/EERtyHjdbuVajVgziLSvdYe6meZwY7Zjb41eig7eLwr
         6UZKRQUjNFshs/SlQ6X4X/wJ2fTp9X+N6Fppe0KIbW65R7zALzREZKeKJWEBegefQQJK
         eNA/Ngt6bqmi6ZvXRMbLgPoEkXkMBuo1TNR1ulpZAMJqm1Gdf96Ifg9/ZA0MYWubt2pY
         oNCA==
X-Forwarded-Encrypted: i=1; AJvYcCX4uME62C0rP8vVmK04uaIOfAZwoODjZX4kBxc3mQ3eXoEjwOLRZXKjgzVgebk2FLZdvAr9r8FgEjWb+cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX4S3Onuf/homfhG1bKMJVCv7pCbGfYQqQCeWL+fuB1rL4CJH
	KjRmdYH6c4Qx7TszwLYUwotXh0sB0EGRQjzS5YBiyQxoiEf9+N4sMr20CI5JzLh0d9A4gjmL9+y
	Fcx57TrJvKyBhUmBGr7iogkuhj/lVomhLbsQwR3Np+VDmfAAA7fBiTlre8zG8yPpEEGs=
X-Gm-Gg: ASbGncsDTHR7kVhd+ei0kpbyKezpkXWuud3ZiTiKROP0ngOedtGkuAXp7IjGm0s/ixb
	JxDCWJRX0KuMo9IMqQQkNk59s/jkm+XCA8keSL38+7Z1wbCW9B7BiVdqFeUu6BDxsGMnIn3I0xA
	7HYAQFVRaSCKlVDsiG9PL+QF2601aVIde2G1nwc6RkeSdeMbkfoYuJvgru0oLampDHa2ZMy7194
	VHBzXEndBxmeiPkIH0IJvxfv8XqmRtUo5Ja0UK8U+fOY1B2wtRwRxqZUWxPcZ6g2PTYxWrgZFpJ
	nA8S4R6LLRK/sFxx4EGzPorCJlzIrA4rc73xjye1l1SrXzQ8kpppu8GpFh8jk486/tZAbT42n0x
	8NVLJFKK8uSiyMky0uHGvKafjAUxX/n+aAzOsb6DAb1WaOXeX7xC3
X-Received: by 2002:a05:620a:6988:b0:807:c011:4d94 with SMTP id af79cd13be357-813be24a04fmr343691085a.15.1757197169534;
        Sat, 06 Sep 2025 15:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtIPAPZzeSP+iBvuIpURlnL4Cr1e3bYG5mSfoFLuROPx9ErQs+pxUZIjoMp2JZ7T334zdmQg==
X-Received: by 2002:a05:620a:6988:b0:807:c011:4d94 with SMTP id af79cd13be357-813be24a04fmr343688685a.15.1757197169036;
        Sat, 06 Sep 2025 15:19:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032d73sm27537421fa.44.2025.09.06.15.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 15:19:26 -0700 (PDT)
Date: Sun, 7 Sep 2025 01:19:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
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
Subject: Re: [PATCH] drm/msm: Sync GPU registers from mesa
Message-ID: <dnnkrq64cwkoazl3e7om22u4ein4mvn52otm2kyd6hcfuk4keu@rga7l6rbvvsq>
References: <20250906170542.481588-1-robin.clark@oss.qualcomm.com>
 <wbuvnhcxh4flicbgipuql2otwv7oqkol2pmdyvschpudshejy4@euajhp2sgnyq>
 <CACSVV035P-xBFd7=MjCSKoyfp79_ztEoBEEaDc9HYPtZgVQAbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV035P-xBFd7=MjCSKoyfp79_ztEoBEEaDc9HYPtZgVQAbw@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX/QugN/ZHiZ75
 PgSlJ1Ra86KIVqt0EUZd4s7P2vhPYsdhVMUBrMyh4KMuRwoxnPKBzHQXZtOul1bMFN518li2Zdi
 UphuMRc8MbwbGmhdeDSynJ6WBfxw7rFBCLx1jlW/uYijapREU//4QFaRl3z33UDgEbMJfxdL3GC
 R7ydFv4uKST7txCJwLrrw+G3ONi6p7rbXmw0ELmDa0PmmEOIEsDZ2pVmS7IWw4xnUxl0MXfbkPA
 mwXGMWYKwOPqPBHc6E1F76ndijIIhBUJDI0M+/rSbd4uKfWdcakEp8csH6XrsdTJfZfysbef0Ku
 CNmbyyxPF/rNcjuQCZXtnHhUeVP9crexztuxq3rYBs1dxhlbaLZ+uaPD8HNphRKt5jJQ/qLa0gN
 Hp25Te5m
X-Proofpoint-ORIG-GUID: 29fwLAu7SyH5FddPNXSK54VFpgS0oinU
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bcb372 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=V2sgnzSHAAAA:8 a=5cO3dDSpYDoClHOC_owA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: 29fwLAu7SyH5FddPNXSK54VFpgS0oinU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Sat, Sep 06, 2025 at 03:05:25PM -0700, Rob Clark wrote:
> On Sat, Sep 6, 2025 at 11:55 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sat, Sep 06, 2025 at 10:05:40AM -0700, Rob Clark wrote:
> > > In particular, to pull in a SP_READ_SEL_LOCATION bitfield size fix to
> > > fix a7xx GPU snapshot.
> > >
> > > Sync from mesa commit 76fece61c6ff ("freedreno/registers: Add A7XX_CX_DBGC")
> > >
> > > Cc: Karmjit Mahil <karmjit.mahil@igalia.com>
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  10 +-
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  19 +-
> > >  drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |   5 +-
> > >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 718 ++++++++++--------
> > >  .../msm/registers/adreno/a6xx_descriptors.xml |  40 -
> > >  .../drm/msm/registers/adreno/a6xx_enums.xml   |  50 +-
> > >  .../drm/msm/registers/adreno/adreno_pm4.xml   | 179 ++---
> > >  7 files changed, 524 insertions(+), 497 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > index 2e2090f52e26..3f5c4bcf32cc 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > @@ -247,8 +247,8 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
> > >        * Needed for preemption
> > >        */
> > >       OUT_PKT7(ring, CP_MEM_WRITE, 5);
> > > -     OUT_RING(ring, CP_MEM_WRITE_0_ADDR_LO(lower_32_bits(memptr)));
> > > -     OUT_RING(ring, CP_MEM_WRITE_1_ADDR_HI(upper_32_bits(memptr)));
> > > +     OUT_RING(ring, lower_32_bits(memptr));
> > > +     OUT_RING(ring, upper_32_bits(memptr));
> >
> > Could you please comment, why are we droping all these accessors?
> 
> We redefined these addresses as reg64 so there is no longer HI/LO
> regs.. which works better for the c++ builders in userspace but means
> these accessors no longer are generated.

This should probably go to the commit message.

> 
> I suppose we could perhaps make gen_header.py generate legacy hi/lo
> regs from the reg64 for the "legacy" C builders..

> 
> BR,
> -R
> 
> >
> > >       OUT_RING(ring, lower_32_bits(ttbr));
> > >       OUT_RING(ring, upper_32_bits(ttbr));
> > >       OUT_RING(ring, ctx->seqno);
> > > @@ -278,9 +278,8 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
> > >                */
> > >               OUT_PKT7(ring, CP_WAIT_REG_MEM, 6);
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ));
> > > -             OUT_RING(ring, CP_WAIT_REG_MEM_1_POLL_ADDR_LO(
> > > -                             REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS));
> > > -             OUT_RING(ring, CP_WAIT_REG_MEM_2_POLL_ADDR_HI(0));
> > > +             OUT_RING(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS);
> > > +             OUT_RING(ring, 0);
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_3_REF(0x1));
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_4_MASK(0x1));
> > >               OUT_RING(ring, CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0));
> > > @@ -1320,14 +1319,14 @@ static int hw_init(struct msm_gpu *gpu)
> > >
> > >       /* Set weights for bicubic filtering */
> > >       if (adreno_is_a650_family(adreno_gpu) || adreno_is_x185(adreno_gpu)) {
> > > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
> > > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
> > > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(0), 0);
> > > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
> > >                       0x3fe05ff4);
> > > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_2,
> > > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
> > >                       0x3fa0ebee);
> > > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_3,
> > > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
> > >                       0x3f5193ed);
> > > -             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_4,
> > > +             gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
> > >                       0x3f0243f0);
> > >       }
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

