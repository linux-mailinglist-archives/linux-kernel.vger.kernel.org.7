Return-Path: <linux-kernel+bounces-741419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFEB0E3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BE0566DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF002836BE;
	Tue, 22 Jul 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUxoL7Yr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037A27F18B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211145; cv=none; b=u0a5kG7WG8/MWvVHJUccnZ7ypWjLg610JZT4mz1tOJHdX2o0VsOewI3/WUzl0foBUJgekR+ob/kUCrM1QYLiEmcrObKkK0FdR16/Jc46J4/PYMy4vtuupV2zaz3cKvjf7AXykq/Mv0+4u/TyUsLR+N7TnakO/OTlrXy1XgTNxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211145; c=relaxed/simple;
	bh=xZlxAmn3kRUUxhK5EyFi4gKntDMk5ctn9fLRRBn2z/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3BNTrmE19CNJRNk+OLAP1EWIFZqMa5BuLEd/kf4B3xGUeR702E6Rr0SDpeC/NFb2KnuMsABvbvVlnqFIDZKD8wsdhLv3th1YGCmkTh9AUt9DJCta/kX8FcZy+p2Jw5zz8emZCAvIdsewcUgenU4hlWaGRQMH5PC4qWvjv+H80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUxoL7Yr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MAFSWN016289
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P2+6l4qAfd3G8OT0Vp0C7LdE
	m1O9SDlPysbdkSzFPqg=; b=MUxoL7Yr83E+66mLMhAAylNYCqeVBssfMOlrmT4S
	aAbjRbfxz0+QE7G2I3hT8WVzhyN9cIyCDNOlDGs8qUjrVHsHNB5+SznDuCxI/NmL
	D8YY8gq4AZtUpYzHJTaGtePF+jv6xZ5d1syLl53KWwgNcji7lUHHw0idozwBbuOX
	I2SoEvbhgHHIBUnySrmJzzSWEpJPfGR4pgOFRK+PXzvnsfBHHEt01U9VozkdoRe3
	uF6uGBnVid5pHvfGaUDSgZ3NBB8N801sBD5eyPE67oHK3FL230RT//0e1GJt0tAs
	GYh4r5vWb5o+UmzGzOC6eRLhVpeXtmYOph5AAFLw4kvXuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s2pkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:05:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c790dc38b4so34723085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211142; x=1753815942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2+6l4qAfd3G8OT0Vp0C7LdEm1O9SDlPysbdkSzFPqg=;
        b=THbgXSTgJwbKiSQkUYwbb5kgQS8k7EiV6u8TNeGQiDFdc+G0cYQ9tpF5yd9abae0QN
         c1tBiogcsJElo8/eC6DqcqH2AbR6QyO/X6+YLNjaqjuMn74uaTNIsqMs+jVIji6PX3BG
         z7kaLC0+a98aNdV4vtotSLEPFv3J44D9W3HJepREfYmTlOjHIbss8HNjszUlP7QBr9Nu
         AkGagprbeKW93Lt3csTHHD0nh1143uPoTQU9rsGGAKWqJKJvHWY3ztU2CqAB+9t6V9Cj
         Z7z7mTjarUldyG4ZCLEfwA/05vC/SdixJa2rDe461Z36j6i3beo8YP+AT3bFqpw46apT
         LgBg==
X-Forwarded-Encrypted: i=1; AJvYcCUwReQfcpja2cP777YBzzUosYliZIS+f4/I0vD6++q9TX/kW6f5re74eRxqstqaH1SLpt685JbpClwuF5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MADAPI+K1tyMlmFE86MEQYbVkG9yMVmPuyosadEWRJWs757P
	3jnqJdZxkKAkwmICSu6YMDdhxDmUewgVfTs36zzSxU+zmzKNyImWCRzjblzpEcBCpGiJclsYMLa
	GIbsYnlMhWKR39UYkNMpti7Mqe9BvCO+fPAc9Qt53IUIXyMOT06gI/F06L0HHI9OokQA=
X-Gm-Gg: ASbGncu0ecuiJXNUcAoLvmTh5UO8xcY6AN29EamAsLBMyt2qlHXbzT+ZhFAP4Q4zUfK
	ay4T79u7ernlHOdoYP4ggrvIWREWz0sA0Lx5Z0xBlydHEg7YBsw1iBV8KrX3dYoi5fqynXJ8M4U
	uPhisynNuZHxIQ4Lvp5fXMIPDqt5D1XG0WrsDX4mh3oLsiUwxLvsOOIfoCtbEopqfN2zMUcMuep
	/ui/muG+8lhizwHBT0+SjA+GuPLShH+y3qT5OKclnXhmKyLkGWjtFZOT5CLeiYzdykOGq+LV8fm
	5OxHiwILEAGOL5eZhgBWr/sN/pPiaSWJgN073YHwkwRTcB1mNy5GSaV5oFm3JoB9l06V+xrO8W2
	XJkAUJA+BEvTprR6GwWoH4go1bI6OoDOoubE5aNJV0b1JKBNlT6Km
X-Received: by 2002:a05:620a:7004:b0:7e1:aeab:41b6 with SMTP id af79cd13be357-7e62123d2admr639044985a.18.1753211141800;
        Tue, 22 Jul 2025 12:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnWw82SLv09ir9ZtrixO/tE940fX1DelTTNbNTu76eCwjlOF98H3Zx1i+G/fDCf6mx0HVYLg==
X-Received: by 2002:a05:620a:7004:b0:7e1:aeab:41b6 with SMTP id af79cd13be357-7e62123d2admr639040285a.18.1753211141325;
        Tue, 22 Jul 2025 12:05:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aba0f7sm2051200e87.83.2025.07.22.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:05:40 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:05:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: dianders@chromium.org, tejasvipin76@gmail.com,
        diogo.ivo@tecnico.ulisboa.pt, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v6 3/4] drm: Remove unused MIPI write seq and chatty
 functions
Message-ID: <46h32rtuyamdvg36wegmi5fonfg6o6gau2ek377mhumscd4k57@3mw47znxnj7p>
References: <20250722015313.561966-1-me@brighamcampbell.com>
 <20250722015313.561966-4-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722015313.561966-4-me@brighamcampbell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE2MyBTYWx0ZWRfX5WMjk+C2Xu5w
 PXjjy2Hi+lKmS5rC0F+/ShlSRJ8IYhIotqgqLOlKla2nNVqeZlVJOB3TY8gA7pd1Fj3mpYPgE+B
 Gw3o9I/f1o/hD9ay2QAogP1290yz/Hq+cNZ3/XFEPiIF2xL0W3w/bxBe5dAdhqionFXM9n4xLOu
 NxPZvV5rzurpSFj3MkQK92HkuEiDv8xMzkMUvVAoNv797R5XcA9xWhqdOAzhF2TRyWCaCPxdYle
 KAOdiSQQddvnFabVN9HicmxLCfpf32D4zQMcdEXioMceH/BCxhORtqYhVM/bHKWYTfZpdO/vPI0
 tfNNkNsL2rS2ZQzSfphqhq90m5/DAzz5HcimBoLOXhDmaoFCLTvlX0JiV/rg6hF49eOOJRMRYUm
 52cRD3PCVdkfmRtgjp20Mn6VnKnmN/dXPHv5yniTSE4WenVIWFq6eP2MbbmS72ZyHUhmthCH
X-Proofpoint-ORIG-GUID: -HVjffnO5A4WRIx_G9qsJuIDifMn8PE2
X-Proofpoint-GUID: -HVjffnO5A4WRIx_G9qsJuIDifMn8PE2
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687fe106 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=cm27Pg_UAAAA:8 a=wukD7SXyAAAA:8 a=EUspDBNiAAAA:8
 a=BQFrTPDZmi-2fyfDvBEA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=n7THaJik3DRP1sDdJiGm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=596 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220163

On Mon, Jul 21, 2025 at 07:53:10PM -0600, Brigham Campbell wrote:
> Remove the deprecated mipi_dsi_generic_write_seq() and
> mipi_dsi_generic_write_chatty() functions now that they are no longer
> used.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 34 +++-------------------------------
>  include/drm/drm_mipi_dsi.h     | 23 -----------------------
>  2 files changed, 3 insertions(+), 54 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

