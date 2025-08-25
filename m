Return-Path: <linux-kernel+bounces-785338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57368B34946
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C832017AA81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D762FCBFD;
	Mon, 25 Aug 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+3ViXGD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B02D9499
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144101; cv=none; b=KRu7PaOjRojlvMDKiyWQS5rpaac1lr7oecSoLVTgeCstkji6trxfk78+XoqvQneyCSwY/1+uBRWtBo4+zuougKWo9ou+NpQBH/yrfgfwKeK0ekrmqNnc/P9BpmCo0GOkyQMiCSWTN/VIe59viS19tjMFhxJg0vb6+HcxFdImtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144101; c=relaxed/simple;
	bh=cZkid94lGpMI9n8ZkqoYbLWXkIO+cyvpVW41wrAbQT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdBGY/X5DVfQZ0xEbg7+PcEwXAbR5mrvxR3xlkY6n7SkXYXcYIU45Ny47uqosN1Ug1YtVWSfKfIX6msL0sGA8gtc5mgPE8mddmMthGXTAudijv63Qr86hwPKw4cTlkewC+R6aYBoOhM2dz1njkXiZL36w9atZ4TsF8rhjaQbaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+3ViXGD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PDNr6f018862
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=nlZ6l0ssjdjfHTENsYE9UwmL+I0iY355kH62DG2afLo=; b=E+
	3ViXGDxUfU+t+KyzPJy/Za2sSwW3Od5VjEMWqYVPIAWDanl0ZHwSnyScShfKpfva
	APfTV6wqfYR2nyFgt5IOhUMpsoyJerdpWui2zTky+XUGkmkQcv72zvBDMoMfNC74
	6wOVFlQU9KIt4/W5KUoATuGyOoG8HaS1S6d6kwc66OsNMFaLMSpxvbO+k/FM01sv
	+feV78XObMHvQ1sz5WUzZBrsrl1fZHUwwGwLMsMZSCfO+P8YEIR+k89L5UMUzeKW
	5XOev4qTDWkRo7B0Bdwoxl6sExKqIfMBb2s6xAujuu6FNLQy8WgL6WXK+dc2ZP7k
	HTaA5YnI8PDsMCyVz3fQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpp3qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:48:19 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-435de5be117so4907244b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144098; x=1756748898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlZ6l0ssjdjfHTENsYE9UwmL+I0iY355kH62DG2afLo=;
        b=LCKp8RSWm9Qs8lurb+O/9Wq7TX5kvvIIK1VHd5thmEM3uOENlG4MMmRWFPSgH0KGWe
         GH3sOvSRgc33Ygq5Yz6F1h5AvgZn8oCtTRmOAjYXbwDc0oY5RnKlOuiwpd2AT/RTnp+C
         MMmM2SJMYlsgqJcGYrenXi8rtmkofWryRqHuJ7KcSag94PGBGVg8Rkimt4t8q5qLIB4I
         dH2DCx5M+AByjCo1uiHYabwpOkqnv4VHGdFAU+2gzL83GfB17m8G/N6jiwEAV1MJ0FZu
         E5gWK2XKyVyPsjiB+OgzVi187WvHDuwwR4dEM+ti22GRCFtSkLnI9AXapPMi9jRS3GQo
         E7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWP1sBjTQvnOa6KDHwQ0Jl5rcfz2y1Qdl0n7peVjg8j9bMZLRbAeYgZalZ2+MSAcbMlRNb/FgxBuNLW2GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRPBI1u2PsrQJ1hgp6Qy5WB+2EbFosU17DCpjZTYNVO01Ok+p
	qQ97gomBS+U08y5HF6nvyfsY5GuUGYwO2/d1gZb2UVFLeOXsTLEy7lEQAqMXIMnauiQEmzeX0vZ
	CUizftf9dY5W3gbXMWb8d6maE81KXhL6c+eUpd3WOUAsR0pFhS5qcYk7cgY7JgD/Zn1NXwXXC6M
	tsolYocvIYu26RtSHOqTjS70D5TMO4PaL10XQl6UfNsQ==
X-Gm-Gg: ASbGncv5TT5K7RC5J6l49ppX8pJsHcxRCsMMfbMI8xE+Mg7TZi7nJD0d20sIxvdZYC+
	YQYwGSsZCISpeA7TPU3u79LxHin4FXSqU+g+ABCqA7iNN9MNzx0J5LthWRNwBvnxlOPdfmnjEKC
	Prr5gxJFo24o23SaZFnSL0N8hX73ti/OVeMN0p9R3uDpffYF83u060
X-Received: by 2002:a05:6808:13c8:b0:433:e8b7:14b6 with SMTP id 5614622812f47-437bdf0e80cmr282250b6e.7.1756144097910;
        Mon, 25 Aug 2025 10:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHj2ggcpr+YlSukAj2EV64noq+YNIxzuZKThfwMzS9An5ffGJUhIvvJMvQa3taoYcsJrqvCQ0puzQTE/o4Dfs=
X-Received: by 2002:a05:6808:13c8:b0:433:e8b7:14b6 with SMTP id
 5614622812f47-437bdf0e80cmr282235b6e.7.1756144097518; Mon, 25 Aug 2025
 10:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823020919.9947-1-alex@ironrobin.net> <6sdzghcc4uynvmk6r4axpwgqlmgxqzi457ttedqlrql7f7lt47@glsrzu46a63x>
 <CACSVV01R=FPAErpfJJvESKig+Z8=amEkpf6QFnkXHhTjFsPf5g@mail.gmail.com> <5a405510-3eec-4262-9855-483dd589d8dc@oss.qualcomm.com>
In-Reply-To: <5a405510-3eec-4262-9855-483dd589d8dc@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 10:48:06 -0700
X-Gm-Features: Ac12FXx_wnGonddny4hsq7SnyhgxqXzats4o0RqFyvkik5Pg-P2HT-mz1CypEoA
Message-ID: <CACSVV03y1s+EdkNm0nWFL7yuR8y=YuBs-OJaKquOh4izwKc_nA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix race in Adreno header generation
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Alex Robinson <alex@ironrobin.net>, lumag@kernel.org,
        abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68aca1e3 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=foaXouvCAAAA:8 a=4ku08oyGyOPXMIowQNIA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=lBkOZJTZZNyIbKe29SIT:22
X-Proofpoint-GUID: KTkLQ4rir5VXGJlyo1utg1cEAjtZ2K8a
X-Proofpoint-ORIG-GUID: KTkLQ4rir5VXGJlyo1utg1cEAjtZ2K8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4pM9Bps/mEX4
 BcVv8KsyZ6w8tcEEMC5QqUZLiBrU5QPtsmudmUTY5IdMqhw5u3bscPnNm68paw9WhPnvPGLkm+p
 3yp0UUxAIDB3sGMdpH8uMO1XREwRWoZuOL7uZqIWs/q8rDfXgq12sJlUNrC/d5aN5PZWMBUPz8h
 5kRqsFgUaEnsHwTFVQXRHMXSZGWDuXmm//Q7CyeZSLboWVsf8AfcX67sX+EABbL8aHFYojxGIAJ
 YkSyeZiPbWUdyYAnJHbBlB+vsKLl8W+xzAYSKDBn8Bd7VfeOb/RSrQtMXY996LypUU/O3Uv7ivX
 xR8PfPf7ORmCPC9C5W+5+tQj7tFA5DNvvmKMxhFCJE5y2e/Y3n2Uc/Sskt4ez0ZLPEhhisweUUY
 lNY2RiWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 9:23=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 8/23/2025 7:46 PM, Rob Clark wrote:
> > On Sat, Aug 23, 2025 at 6:49=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Sat, Aug 23, 2025 at 02:09:39AM +0000, Alex Robinson wrote:
> >>> Builds can compile msm-y objects (e.g. msm_gpu_devfreq.o)
> >>> before adreno_common.xml.h is generated in trees that generate Adreno
> >>> headers at build time. Make msm-y depend on the generated headers,
> >>> removing the race.
> >>>
> >>> Signed-off-by: Alex Robinson <alex@ironrobin.net>
> >>> ---
> >>>  drivers/gpu/drm/msm/Makefile | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makef=
ile
> >>> index 0c0dfb25f01b..1a918d44ac48 100644
> >>> --- a/drivers/gpu/drm/msm/Makefile
> >>> +++ b/drivers/gpu/drm/msm/Makefile
> >>> @@ -221,6 +221,7 @@ DISPLAY_HEADERS =3D \
> >>>       generated/sfpb.xml.h
> >>>
> >>>  $(addprefix $(obj)/,$(adreno-y)): $(addprefix $(obj)/,$(ADRENO_HEADE=
RS))
> >>> +$(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS)=
)
> >>
> >> I'd say, no. The idea was that msm-y should not depend on
> >> ADRENO_HEADERS. If there is any dependency, please move it to adreno-y=
.
> >
> > probably we should s/adreno/gpu/ and move all the msm_gpu*.* there..
> >
> > In the mean time, I think we were going to drop this patch from the IFP=
C series
>
> Yeah. I will drop that patch.
>
> Btw, was my usage of adreno_gpu symbol in msm_gpu* files incorrect?

I suppose _technically_ it is, but the split btwn msm_gpu and adreno
really only made sense for a2xx, and only if we tried to upstream the
old 2d core, which never happened

BR,
-R

> -Akhil
>
> >
> > BR,
> > -R
> >
> >>>  $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY=
_HEADERS))
> >>>
> >>>  targets +=3D $(ADRENO_HEADERS) $(DISPLAY_HEADERS)
> >>> --
> >>> 2.50.1
> >>>
> >>>
> >>
> >> --
> >> With best wishes
> >> Dmitry
>

