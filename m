Return-Path: <linux-kernel+bounces-810486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21975B51B51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FA51894ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F1242D90;
	Wed, 10 Sep 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5Fq26fY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CF24DCFD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517394; cv=none; b=eOyY7TeIdUsfxXUQjZq7XokiWg0bK5PBQeu8b90wK9UT87Ei5gLhzVHPCUiKKMH/6JBxg35ddAtatS8UwNiBt/XHkTno9v0U7Rvo3BAA3YWXGnD8QsCrZqw25h7iYZTIkXQPf/GjDvvQbG+T2NGnJaww1B2MavvlM7bF2CuzpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517394; c=relaxed/simple;
	bh=CMr+Yyb64ouHjg8enQXwO9zPKrjmmn+0fLcun1xcNsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6hLt0Bp3dQyivaKrK7pMDQJbN1SG+tJ5a3mxQosFBz77zsYh84AxTzZJj1Xp9175kmYuxezrR+yY/fiQ+5LjekU/5tIrykuXZ6pmXnbFo2kkjs/Sg+7b9R88BXKFfnXH8s5J7PEFAIlrJCSoRNuXI71SE6hII+F0e9PF050s4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p5Fq26fY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgT6c004003
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kKm0FaL1IsnsJ1lRYNU+N3Fz
	JdUYvVMh5dXRjU0QCk8=; b=p5Fq26fYWFQBv4jsqwoICAN3BPzWKiJ1nDETM99M
	qYaJAlGyDaaHmKO1z93fcVW5AWkmOt1ObtdBYRcfscs2Dt3fBbzvs/SnkRo7Ifc7
	7qQs49X1iUmV7tciI/bLswt8v/1P0apmUMCxq2pWlPemmfz0K+EN1BqxZmDlcNZl
	bLdSmNTQrd3J1EQJDwspX2Q9ESFL4yeilX8M+0j6cs5FnriK3LpIIxOF/IS2qvFW
	h2XMguo7EqCiriV+JKtDR6nQZ029MA6bgpufcFu2wyf6OrdEfBOOq63E4qNt7jkc
	OXyLqkyUxTB3D9koO2CbE2l2L4cEK+a9ar/TSU1vg9bq9Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwscdct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:16:30 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5449f6cacd1so10144619e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517389; x=1758122189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKm0FaL1IsnsJ1lRYNU+N3FzJdUYvVMh5dXRjU0QCk8=;
        b=hRiFBz62yf/mizURmJVTHufPlmmzFQYGmg+4AQSIMLRw8Yf8rMk9bW3Aa68eazk6wX
         aRkL22ACl4M+RvYDPlxy8SETPl5qOww3Qu4BkTQMLZtvutcE7PRHtuZwzjdgTCKqJnrw
         o2wTVWO4FdKX3rm1ccnDLkZhbw5Nefj2FOA6JKJF+OLHZ4OOUFBmo/gkKBoBfgCMzYlu
         bvB1xMe1VkzZOOmTO352F4JvULLP/zM/tICyM2Lc5JKFcVg/4TaqKo4a4OZYQx4ALZNX
         jpBZGutUkVdAnWOBeuyrG+AxKphbELMeQfHCsH34b7FP8H9meHY4BiROHp5mPOdmpOoL
         wT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXegj8kHWdRzLVRiKBEozJPl9q6ZYTDlyRl0yMBqWSutUCjnFsAwmlNOn8Me5vr9SoF4PbXLWBURZ/e/Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3b6CeFn61dp2+VEodiOV16x3nqaRKvFxspFKDP8tCR28GkH+
	s39KtWF2G5EgPQpfyXLAKWV6VWzHWdUPSSeUmWo5D5nDL7W2TNwDgbHrOrXStgMl9YnYERuIEzS
	jdRms6yGu1SVhIujhso7RDtr6oOgnRzt/vJXAGYL4Z0GigWE3WRIbPNQY7y5x06c+tuI=
X-Gm-Gg: ASbGncsrh4Z2WlBMX7ArQxxaH4wNPV17RRL1TthCjGIeVsZ/fUCs3+RF+kHbh0aiYtX
	kRRhvfNXP3kW3NDyC0ISxit4rK7eay5MdhwcJMZJH/4ymyPJe0z9EmqZNseY1cAhSAcWAlBTb3L
	s1ztHhQ/6R77xJsgADTM0trciipgN+J9hQUnBnAlJA3m+XvA45xuUREgQZwceQ7nnXRgxuvrxHX
	vZJzd7vX61CD3YDrBnBKTq+3/zsLGmFHfFwuo1HAY/ZuQw9lyUvD2M/KVPc/H1JNZBHb/GzBvHh
	O3rxSh5aJsKu0FiGVqvlphhroXUgB1zYlLW08EWiAU0WBKul1XLgF/+3+LpvIjL/3bbKCE+RMvn
	DXYmJy0zGN/fFfQmOVjVMlKu8OVZy1moCII/keOpRSTFGRNRVo5jW
X-Received: by 2002:a05:6122:2a42:b0:543:6ff8:d6d7 with SMTP id 71dfb90a1353d-5472a0088bfmr5155440e0c.1.1757517388963;
        Wed, 10 Sep 2025 08:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV+Ok0B9ImEfUJn+5MDsBCd0a1EnbrepGzoV/kCIfMR/JnpVKik3JbAUvvY8M2wWHlz+5tjQ==
X-Received: by 2002:a05:6122:2a42:b0:543:6ff8:d6d7 with SMTP id 71dfb90a1353d-5472a0088bfmr5155361e0c.1.1757517388194;
        Wed, 10 Sep 2025 08:16:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c4246c2sm1301330e87.17.2025.09.10.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:16:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:16:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v4 01/10] drm/connector: let drivers declare infoframes
 as unsupported
Message-ID: <z333ysst5ifakomo35jtbpydj44epqwwn4da76rcnsq4are62m@32gsmgx2pcdi>
References: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
 <20250909-drm-limit-infoframes-v4-1-53fd0a65a4a2@oss.qualcomm.com>
 <20250910-furry-singing-axolotl-9aceac@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-furry-singing-axolotl-9aceac@houat>
X-Proofpoint-ORIG-GUID: euceeRQhS0nHwvdvxBe7G7-i3BH9cdgk
X-Proofpoint-GUID: euceeRQhS0nHwvdvxBe7G7-i3BH9cdgk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX1V6iaDfwJ9nA
 bTBC4dw7i0Pokr12lgf55tPDqqRGUVNUHe/vFYM3eNF4nXzRBZarLXA4fDry0G/+EJY3CaECG1C
 MOZS9mLbF4bYEZreLIWmxcKkO2Fkm+xKNUGRUcW1xN3wW7nfFDa0V2WOawO2+Cv+1qoX3AKBS0t
 cD3eNUzuvyEfgcAAwcXMLHy5m9QaOcegAuhwL73YqD79cuFRGXIEue6nUGg7xbwHeV1ErSRgws6
 asIptt7KCNSPArUtfIDiXnTaXh0AmSzu81Zmeil2fqLTK+oWLwWIKFHLB0SqIhFZWteBQ0OIY3Z
 eLEKaxj5HT5crLXs0H7VLtmCHU6OSa3OxgCiA4SjDo0iffMwe43HOds3ydXMIcTOGhrkDiFxLt5
 evTTvLko
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c1964e cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=Hspkq7dj2dKET-HI0ioA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=ST-jHhOKWsTCqRlWije3:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Wed, Sep 10, 2025 at 01:03:47PM +0200, Maxime Ripard wrote:
> On Tue, Sep 09, 2025 at 05:51:59PM +0300, Dmitry Baryshkov wrote:
> > Currently DRM framework expects that the HDMI connector driver supports
> > all infoframe types: it generates the data as required and calls into
> > the driver to program all of them, letting the driver to soft-fail if
> > the infoframe is unsupported. This has a major drawback on userspace
> > API: the framework also registers debugfs files for all Infoframe types,
> > possibly surprising the users when infoframe is visible in the debugfs
> > file, but it is not visible on the wire. Drivers are also expected to
> > return success even for unsuppoted InfoFrame types.
> > 
> > Let drivers declare that they support only a subset of infoframes,
> > creating a more consistent interface. Make the affected drivers return
> > -EOPNOTSUPP if they are asked to program (or clear) InfoFrames which are
> > not supported.
> > 
> > Acked-by: Liu Ying <victor.liu@nxp.com>
> > Acked-by: Daniel Stone <daniels@collabora.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Again, I still believe that it's a bad idea, goes against what the spec
> states, and the framework was meant to be.

Please correct me if I'm wrong. The specs (HDMI & CEA) define several
infoframes and whether we should be sending them. If I'm reading it
correctrly, CEA spec explicitly says 'If the Source supports the
transmission of [foo] InfoFrame..." (6.4 - AVI, 6.6 - Audio, 6.7 MPEG,
6.9 - DRM). For other InfoFrames (6.5 SPD, 6.8 NTSC VBI) it just defines
that sending those frames is optional.

We can't even infer support for InfoFrames from the Source features.
E.g. CEA 6.6.1 defines a case when digital audio is allowed to be sent,
without sending Audio InfoFrame.

As we will be getting more and more features, some of the InfoFrames
or data packets will be 'good to have, but not required'.

> 
> So, no, sorry. That's still a no for me. Please stop sending that patch

Oops :-)

> unless we have a discussion about it and you convince me that it's
> actually something that we'd need.

My main concern is that the drivers should not opt-out of the features.
E.g. if we start supporting ISRC packets or MPEG or NTSC VBI InfoFrames
(yes, stupid examples), it should not be required to go through all the
drivers, making sure that they disable those. Instead the DRM framework
should be able to make decisions like:

- The driver supports SPD and the VSDB defines SPD, enable this
  InfoFrame (BTW, this needs to be done anyway, we should not be sending
  SPD if it's not defined in VSDB, if I read it correctly).

- The driver hints that the pixel data has only 10 meaninful bits of
  data per component (e.g. out of 12 for DeepColor 36), the Sink has
  HF-VSDB, send HF-VSIF.

- The driver has enabled 3D stereo mode, but it doesn't declare support
  for HF-VSIF. Send only H14b-VSIF.

Similarly (no, I don't have these on my TODO list, these are just
examples):
- The driver defines support for NTSC VBI, register a VBI device.

- The driver defines support for ISRC packets, register ISRC-related
  properties.

- The driver defines support for MPEG Source InfoFrame, provide a way
  for media players to report frame type and bit rate.

- The driver provides limited support for Extended HDR DM InfoFrames,
  select the correct frame type according to driver capabilities.

Without the 'supported' information we should change atomic_check()
functions to set infoframe->set to false for all unsupported InfoFrames
_and_ go through all the drivers again each time we add support for a
feature (e.g. after adding HF-VSIF support).

-- 
With best wishes
Dmitry

