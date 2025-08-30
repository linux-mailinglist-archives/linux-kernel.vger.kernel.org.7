Return-Path: <linux-kernel+bounces-793181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED035B3CFE0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C427189EDC8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BED201266;
	Sat, 30 Aug 2025 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3GnX8W6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B11863E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756592961; cv=none; b=WsAnuHPbgMJNJHdkGQWbELgZzjvwFi3dAzVT7mWrmhiYUMpYH1zvw+96P31v0kpkDL/OZWSxBVcxEtApQBClNNbHcHFGqHkUw+41FkqH/eZpVzAw+f4AcN6Nt49U1JmoDto9hglRYfYPP1aKakdFe7y1QuGaK4rM7e+canc4eUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756592961; c=relaxed/simple;
	bh=yIyAp386I3Prc3FkKEid6JF6HPgnBsg602KONjAF4go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLenR6gOMONUYAfdDXBzFSJlEm+8njJWSPCCBeyewZQZG3BF9cuggKe01HwXLPjv/AuZTq3VABOgQIkZYlehB6Q/QbEhhADojKtcaOeRuXpFDfHJwb7PqAlOYiSRTV6jmusPMKljTO+nMWGYOV80rf365bE84+/In9vcv4EHXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3GnX8W6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57UMRaP1006138
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 22:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GNi6qlMhUO/dlDLKPCpe1Eoh
	MUP/BhLmz8wF/QSm9/A=; b=i3GnX8W6MzF7/jJqLQfusJdMEK+lmRXnmxPfHHY1
	JPvU271NEVX0/v6y7ODjamnq+H35oviI2R0naUJNBJpMjQ372GejEdRgYAaVwriD
	UuP6g6EZHnfjp6jRkib7fwem4DSzBXnuwGFWs8Bx/dKken7qgT+Q47BDBEnHD/fW
	AOjVS77HhoxWByxt9zCkSoPxghyGfIfk80XXJk/y483CHjFMaGP4kjQ/AcYT6ciI
	i0qD3LFPO0B/sa8mnRCx5iomQnAJyXkhrVP00urFpwzbtyFGPxJgQ03tWBSnsQAX
	T1fqATL+5HD27JlCxMLfLyKmM7EZNQWozZhMbvA9sqGkOQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp1e9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 22:29:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f55eb56so59987746d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 15:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756592958; x=1757197758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNi6qlMhUO/dlDLKPCpe1EohMUP/BhLmz8wF/QSm9/A=;
        b=PUkit3uipqhkLUCHCoB9KIj9yyGH491XAtrtJzL67lPHoDqHaE5JPl3IvlW446a9nb
         mFtXPzFlfJxJfROGjNfkXoWKdNOs0FGH8+iDZuVTwtVMDqjp0ZGh8EAviperOtNYmcQL
         cO3gEqHFkksN23hEwTmtHxaGpHw5JyCX6nPn3PNerp28wyrek+TPHZBK9hRzu6lE/RlG
         oHYHlA8ABkvaRW+mCOsrbpOX6ESgUjhnxBIiiLcTzZxtdY/T3Ej07ewOQWn4mCiq1z3K
         HqMLsq/CN+JAOfpkSKz6JoCceqbVpql9PVZ7cdlPG1YcRvutvmtwKcxPpMDrZQw9NPkv
         ASzg==
X-Forwarded-Encrypted: i=1; AJvYcCU0aNsoSuZk1q43dj9JSSkJDrEb607pN4A3MxR7+1a4x+P082SzlcxOWm28aVCrjL7tKsiidzG7u6zHerI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8z5i3lh5CfPXkHYrTv/YtnpVBHhoIyWTm55uLoK466K5cykRA
	O48yu4ptBIs+ROSoU+mSryJa64jt7yoPfEhlj5tw6jMpVavBeEEtbheXgDIA5IrXCPL9+xKMPZo
	evzBhhC6ZbiewRDw8NCXKm8eSIwKE3Ao5CYaxalGhGdKENJRsbsGbHB7xoJB1CRQ5SUs=
X-Gm-Gg: ASbGncsnalH2gHxcB88Na6g2GFdtbyZYfYhkyvt0T+MprPbgf5F0P3zAAhVXXdYpOY4
	U1szGvirHU3uMD6/wLhdUMPXOX0l3Q1IvkCaIaxg0WJ8Bh11EUbLN+36F+2uhJ6XgBLaqa344ff
	uOIPEf8qdOLD+prQeeIFoN1bdCLR/nGIWobUvm9i84tv+AyiGBKvs9feEqJRlCt1aPn6YHpey9F
	1mLg+PyNmhHcQxNnkBr2LiplnIrRZ8WBC+RsaDR94Ywc/Nd8/Z3JmadjLC7zGcqXW9bCCONbRo4
	R4GG00vcKwFvOR1NkOFqcNtO6XtCSe6oCirnauQ1GC2a/ZvqBpVGgQpKdtJcffTJSseUHvcmef3
	t72NtI6YU8zsW9X8cSNx1SRYexRlN79Y6BvAnr3xv5qNmpTBEgb1V
X-Received: by 2002:a05:6214:21cb:b0:70d:c6b9:c256 with SMTP id 6a1803df08f44-70fac94115cmr30677616d6.58.1756592957748;
        Sat, 30 Aug 2025 15:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaqdCzqqQwp+xBjOwKvWSPX4p3qiZ0ZzV9L7+TYukjcGa33kntlWRwDlkYGow/owafc/jjnw==
X-Received: by 2002:a05:6214:21cb:b0:70d:c6b9:c256 with SMTP id 6a1803df08f44-70fac94115cmr30677306d6.58.1756592956994;
        Sat, 30 Aug 2025 15:29:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336d0e3f3absm4929391fa.37.2025.08.30.15.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 15:29:15 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:29:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Liu Ying <victor.liu@nxp.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per
 driver capabilities
Message-ID: <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
 <CAPj87rNDtfEYV88Ue0bFXJwQop-zy++Ty7uQ9XfrQ2TbAijeRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rNDtfEYV88Ue0bFXJwQop-zy++Ty7uQ9XfrQ2TbAijeRg@mail.gmail.com>
X-Proofpoint-GUID: hdQ2OjrnBcQD0eo0y9g9G_s9zPkCOkm1
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b37b3e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=eLVs-IFDZWC_gK9YM6cA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: hdQ2OjrnBcQD0eo0y9g9G_s9zPkCOkm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX3jaFFYo8qKSA
 4n1LbeIh+XOVAwS1VCazgaKW9deu61gJulCbb6NC0HfJ/eKkdfzktOGsseV96lSKFAS9momp6Oh
 /qNjZAsXDacJaXY4Jtg2ZgRgZdYL+NbQgOBDW+eggyf7mv/Km7+MWGxU2UQKokW68bEdUoWkYHX
 TonKW9cMbfMkVeHM2h9qiY5Awfu/UUQe9h/oU7giCsQegGlp/wgbu2QLGkLH1NsI4TEqnapJJCw
 ZJSfUi/W5Y6HudU+ABcdCv2lWJ1wqQi1cIhwKB3HnqzZV0viR/aPNzOkvO+PVTnieISkxWaGtCD
 7Az7hYWvqKG+g0IYbtY8ZVcyh/A1l+PbjXV8guS8XY29r2qZko/x+dSB8W3mE1D/BZsrsgoKVtK
 593gU6f6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-30_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel Stone wrote:
> Hi Dmitry,
> 
> On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > It's not uncommon for the particular device to support only a subset of
> > HDMI InfoFrames. It's not a big problem for the kernel, since we adopted
> > a model of ignoring the unsupported Infoframes, but it's a bigger
> > problem for the userspace: we end up having files in debugfs which do
> > mot match what is being sent on the wire.
> >
> > Sort that out, making sure that all interfaces are consistent.
> 
> Thanks for the series, it's a really good cleanup.
> 
> I know that dw-hdmi-qp can support _any_ infoframe, by manually
> packing it into the two GHDMI banks. So the supported set there is
> 'all of the currently well-known ones, plus any two others, but only
> two and not more'. I wonder if that has any effect on the interface
> you were thinking about for userspace?

I was mostly concerned with the existing debugfs interface (as it is
also used e.g. for edid-decode, etc).

It seems "everything + 2 spare" is more or less common (ADV7511, MSM
HDMI also have those. I don't have at hand the proper datasheet for
LT9611 (non-UXC one), but I think its InfoFrames are also more or less
generic).  Maybe we should change debugfs integration to register the
file when the frame is being enabled and removing it when it gets unset.

Then in the long run we can add 'slots' and allocate some of the frames
to the slots. E.g. ADV7511 would get 'software AVI', 'software SPD',
'auto AUDIO' + 2 generic slots (and MPEG InfoFrame which can probably be
salvaged as another generic one)). MSM HDMI would get 'software AVI',
'software AUDIO' + 2 generic slots (+MPEG + obsucre HDMI which I don't
want to use). Then the framework might be able to prioritize whether to
use generic slots for important data (as DRM HDR, HDMI) or less important
(SPD).

-- 
With best wishes
Dmitry

