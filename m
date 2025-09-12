Return-Path: <linux-kernel+bounces-813819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3EB54B11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099EF1895913
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB82FF642;
	Fri, 12 Sep 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJD+coNo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AB2F28EB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676957; cv=none; b=ASWRhFgI3SxeDHokyyT0f2TKrA9XQDqhWNWk6AAXZ2/0A3bQEWfl+kV4ru8BE9ldYj1XOTzgE+I/DMLOWzcy04g3cSdj/ikobdlbXecJsv6mKFLqchuke75VxnwKsmZDx3sSNDNZcPRIPfxSsFdncaoq+5j++3eSSPQ3ZeiZkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676957; c=relaxed/simple;
	bh=Yl7ujEHEAh73YZHCAHa0wkjKZDX13Pw4McYKnCytuVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRccXeKWyRY3Kt5i3DugvALNr8mRcQlPA++oHE1qT5JWoFSC5C9/cFaogIKLIxZQ+6GTaR0vPnmZ9WYoA1sS12skAV6d7xJkqezl7GJVMl9yLDSCSJEU/vs/lo44QzJEoO80qKj+RP1dqaSwQgdt2xD3v7c+TPQZSi+ExhkUuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJD+coNo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fL9R009110
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=batHstE5cPVe/iEJdpRC0Az2
	jhHV3oaHtrZXg6JQFZQ=; b=PJD+coNoOdQ9nvOu9veDvFESDwp5vvSE/a+2JmjA
	NFwW6N3GKkUOkQL1OMFxBaRkFCfIkGVbqcCUPpiMcHeWqfoVV6SUhPmr6bPjquRS
	/Xvs3PJxmgLtA/Z1LNfMMEHTcFR2xBQiOFj8b/YQcSs+HIYvurkREhSUxj/cSLA6
	/Yw8FsDXi4psf0tCyuhPF+uR3WNty0/tk5bceWbqAJpk2du8uqa9Mxft7WUdXGjj
	rflnjwjm12cLUoo+EmgprEWNBSdafIGNmAyp5ZZwYTAef6MI8icwA/teNk0qbN/w
	gCQM5Fl7RxmalIibM8/kdyUBboc4DSZ/PCM2JlE7Ll8yrQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj13eu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:35:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5fb1f057fso24741891cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676953; x=1758281753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=batHstE5cPVe/iEJdpRC0Az2jhHV3oaHtrZXg6JQFZQ=;
        b=azvCo8bAeuHKYOaOErxzqPChr2A3qHBhTBLwg1W7+Z6r/PgscixfJVTQyT0pI1Ag/t
         3uW7+osA7yPhijOb2OYOQFAqLRb10zL+v2KFnQN7FvDkl3XQZbl33tWCpEEEXxzfZcht
         P4e0sPfxE3Z/tmAbDfhEXnD7gnGpQguvN9DlACp8/uayuPFMneGWrgfANQNLVEIwusiO
         9REteToOG/4/wQbTK7+GrMe3RUeU1uiBBAi6HWDVxZnE2a36pkOAS1Jk9hWO+jbfgnFk
         Q+/5SA7FfPWfDsN5jKNzv6CH7L6TIdPu/8x1E5bx5MwAFN5f9U2wnQkwbAQNH4JjsWhT
         X8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaXWVlP3zM85vW+oGE8Mn28rGfv899eOpfTQbV2XVptya4J4FHF4D04y4rlFj4Re1ZLqDKp6Tg4YVoy+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxJSlFuK/SJZP3UijjXy5sQpQarrVUl7aefywNbNz+JpyaOJf
	rTYsFQQqOCtEUAe+LflLJQTJdm/RZFQGgpnL54tcey/WstivygAaUdQMQeS7DuBiMJ3Bo9xiNYs
	2X7ciqq80yNNpKANG7IcvYirYLG1ioj3ny8NCmEnBIh769Rcj2+DCvSmXDrHf2raOcZQ=
X-Gm-Gg: ASbGncuNv0UIjbukH+UMwo48Ke1SMPKFsCTKRZLgCQLp9+yTQpejE2DrqXxo6HlkREE
	MChtDy5y9fqqpRmfdFOtL0WqIvF8DI8QcJb89ELVoJJ+VAgGFwY/zVOlY47ULjMm597ShvU0IDR
	OmRZtmSkNuu1L6BcGag1fShCfekPapDrpnBHCIs4D6HSvNe3UMwR9Y9HU5zXSluOOyDcy6qyUcB
	xbKHfqlJR+7poV60t0DNnDqzBhogSm6xeZGLodnWgmXECQupQRNoJIkU/Vx2htAD0sjsAJbIGPT
	TlNh2f7hHNuR+uActPGbopFVHdVeCI1l1KR0DiUqW1N3hIHOoP1epSzR4ci3A2O86fSSfHqunkQ
	OZXespxBPMDSY3zdNwNqCzxIdaa/UIX9yOhCJ2dxEe9K7SIVizlYm
X-Received: by 2002:ac8:5f0c:0:b0:4b3:509b:8048 with SMTP id d75a77b69052e-4b77d08930dmr26685551cf.45.1757676952998;
        Fri, 12 Sep 2025 04:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFROb0xZp9Rvgv2adavalmKsqHLfU8/KA8mNM14Xqc42eIicOFb6cnSvUsMAx7DV/IVH8dmwQ==
X-Received: by 2002:ac8:5f0c:0:b0:4b3:509b:8048 with SMTP id d75a77b69052e-4b77d08930dmr26685171cf.45.1757676952396;
        Fri, 12 Sep 2025 04:35:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-570ba3d222bsm499760e87.104.2025.09.12.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:35:51 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:35:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH RESEND v7] drm/vc4: hdmi: switch to generic CEC helpers
Message-ID: <kg7adf363xjpragtvkub3gkstul6ycivr6jz4hld2isxjebdlz@z2cewulo3jwd>
References: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
 <pz5luqbagulactqp7h237apoostl64rcrnvmu53eauvtb6cqly@nsmzsvbfixrr>
 <bmbu6dfhr4i37fxlqo7ltalkzz6bocb5whuv34x437k3crie5j@ndtqjrv64n5j>
 <CAPY8ntD-q6nZcVJmo5OG_6U5cxdOVdwKLJChsQZd_ZFjCRuGZQ@mail.gmail.com>
 <CAPY8ntAspTdWB6nNXrkNpZ9TYUtbkxJc_QB3ZmF5iGC31_U33Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntAspTdWB6nNXrkNpZ9TYUtbkxJc_QB3ZmF5iGC31_U33Q@mail.gmail.com>
X-Proofpoint-ORIG-GUID: WemsyetHPOFejoiKNfivYEyb_j8snLFc
X-Proofpoint-GUID: WemsyetHPOFejoiKNfivYEyb_j8snLFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXyPoP4U4BD3WM
 kOvL1mw6MWL7uyR0PNV9+GlVP+0xwkSNk9oMfvwj/z0YCQqYXNvyT1J2HoLrEcDs/ANMAPKqond
 YSGdlE+VXfj52HiWi8b4UGRMSGbf3Rr0oJG+ajCy1WpOR9sPdrNPUHtUSARIr8U3OoR8SzH0cYw
 JUjRPVQqCT1mwZkLClQjXBs/ue61Qi8Gh6CnZQCmM4y/kVHqta1J4F6WQSUNcUOfnLGDrfDVqfH
 UNrAcaqxHJURYgoJVYJVbx/BdlCnWdc/tpOueDO0A58NVXl0DiKL5f4Cb9xldI6o4QXkQVlYfIR
 sbDdxkzyLAxdXcgvfJdcPHm82bfs3ojsVqY67K7fVx8+ha9oFNnl1VdlTehhlJOaQxi+4e9BY9k
 Mjy9NnEa
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c40599 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RF00TdSWAAAA:8
 a=KKAkSRfTAAAA:8 a=Tw4uHNu3hZ8oP4iaKF8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=_nx8FpPT0le-2JWwMI5O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Thu, Sep 11, 2025 at 06:37:18PM +0100, Dave Stevenson wrote:
> On Wed, 10 Sept 2025 at 15:21, Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Dmitry
> >
> > On Fri, 5 Sept 2025 at 17:51, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Fri, Aug 15, 2025 at 06:11:57PM +0300, Dmitry Baryshkov wrote:
> > > > On Sat, Jul 05, 2025 at 01:05:13PM +0300, Dmitry Baryshkov wrote:
> > > > > Switch VC4 driver to using CEC helpers code, simplifying hotplug and
> > > > > registration / cleanup. The existing vc4_hdmi_cec_release() is kept for
> > > > > now.
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > > ---
> > > > > This is a part of the HDMI CEC rework, posting separately to let it be
> > > > > tested by the maintainers.
> > > > > ---
> > > > > Changes in v7:
> > > > > - Dropped all applied patches, keeping just VC4
> > > > > - Link to v6: https://lore.kernel.org/r/20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com
> > > > >
> > > >
> > > > Can I please get Tested-by for this patch? It has been R-B'ed, but I
> > > > totally don't think it should be applied without testing on the actual
> > > > hardware...
> > >
> > > And another ping to get it tested by...
> >
> > Apologies - I'll find a display or AVR that supports CEC tomorrow to test.
> 
> I've only got a Sony soundbar here that supports CEC, but I can
> control the volume and mute status of that from the Pi, read the
> status back, and monitor mode is reporting power on/off events.
> 
> A colleague is going to give it more of a test via Kodi when he gets a
> chance, but I'm happy to give it a:
> 
> Tested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> Sorry for the delay in doing that testing.

No worries, thank you!

-- 
With best wishes
Dmitry

