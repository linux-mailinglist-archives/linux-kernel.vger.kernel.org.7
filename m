Return-Path: <linux-kernel+bounces-810277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D3B51828
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CA21762CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F431E0F5;
	Wed, 10 Sep 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMj36H+T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37831E0EC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511801; cv=none; b=i5hGXg0eATSy/uLaLAz//UDtfh17aYGeV3nERANv+bGv1P86cDYimLehuocBEz4nR1572mLQXQ78fe+0tk7RT9dBpqmrdQHZjc+qeqi4DR33fIATaLvOUoCZNcHFE4DjVAFfaQ71NGPLRwecqzdbE2LPOsb+9YWHY8rOgaDG160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511801; c=relaxed/simple;
	bh=FaoC9FE73l9rVXL86nM2CVRZSz8t/nV5eIPjehZkKRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogdm2NJ05w3gVpxv9IRVv9p1GoBwyYoUd7Z3WMoJgVeZsITywU22bycrditSlWGqvcwSDw5186GtmtCFbp6OLx3xC6ryYUT2do1It812RenM+MLODznRGAuhWt+149hb2RHw3DwUThoaPYQQh23PAYgNJgJIxOfEMaYAE75fpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMj36H+T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADZFAE031602
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5nQ4xWao/W1S9JuuivQg6TVz
	V1TXFvvS01+Hu/ewF2o=; b=CMj36H+TbjJBbjGtUj0Ww+XkCiSfcr453ccD4RI3
	hTtPq14K7WLeczHyI3OgAOvTURohBosbgyEm6KyyTR1RRzEjx7OtROVcxmf8UQLP
	0VKsVvp8OptJoxAa45jIjayw4Rwpnz5wXobNCFeoYDLZb3nZdYV95mTZUZwToUDO
	qW/9hCsr/xLIau/U8M2P76aKr/mPj0RtK5OTWevRpYpqqqYNkJCG3pQOJxM0n6oG
	UrIwfu6uMWp5ZqJjKH3ssj53PvqM6DXgXBWp2n3qp1ab9yS+3PK3cuzipo0xtLJR
	kdomeuFiz78IGAYiv5uzR7f4OsOvt7AbGymNwg/318RmmA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapm90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:43:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7fff4abc97cso1732125085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511796; x=1758116596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nQ4xWao/W1S9JuuivQg6TVzV1TXFvvS01+Hu/ewF2o=;
        b=ha2gjg+HoT6S8nnjHd7JcO5VKO9K0rXLrdCwOHjXXfOa+Bj6vxxkpxHJJ8FXywDk4/
         N48qFVAzB4f8qc1JsPu9jn81u7m4bAMNo/02LTtEihrpiDkHKyCke0FaMGvTYzk8gN2I
         jpi4vflxfJaV+SngFsUn5SRkFT2WRZty8Y1XMN4JcfyInchLzowrP7+eYzrMx1I4CW1o
         6XvyP4D2uIS9v8nbFWUVKTo2UjN8SjfSOtJJm+Q0XzI+XV7mQEuKQO9e/gDnGLUsXIiN
         GYD/X0M1NSQS+HcUTmE46FgaEsJ4oKhDHLz9PuvS+RswQP4vvfBSFf7mRxwd+ASdmlKW
         tj2g==
X-Forwarded-Encrypted: i=1; AJvYcCUws4AtHFQzN4LSFIO40t2rtKEmriszvcbfouAEZ6Q9xx5cUm+WOTcZkQ64egp7cFiAQmBmqrV3l3Sjv90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6YUiZ0SkJcA11T/4JmxYNNLY4B93xmGR69dJBU3m1XAuytrh
	uA8qAO1rrrraHmylw7m6jpNJ3gNx2Y8BKp2g9OBpApMfL/TCHRtSFqkzrSkVypfi5cDNgg1wDJX
	/FYpIvRXC+Hh3uVClqGscUF9HwBW8cBFqoHX5q0zvi6YyfNWeq0h9laAbo7a1GIh0jFBgE61sKU
	g=
X-Gm-Gg: ASbGncsegIuFjG1uON1nUk/e91qaOVLkE+Wp2UxlMhXOUbXsLA2fmB48MrHA/9YstjS
	P8GXEXnA0GhfkFeChkT8GD3jzIzKCRhgD7hApaHanGxtRGEm684MA7Gld8fWvktTznFOc/Foeox
	JWZ40tNbgGpASU0R4V8Krta/x86O/tSvxNHV4YYJ/Fn8oTHrzW1B09eOEzjozP+bUZI2eqMk3ZU
	vdHsR9fQEBDX+okg3xqkvOuedgwkO4rbWxFp2HUSlbfRy0DROei1QvyI62Lhp1MZqAwIU/mIygQ
	xKcWIJzN+R95JZKjQl16UcDE6v5C8ECf/OnSTOzLu4IlJCsZ/JUw/A+dwxv/yawNWDUqJ0BpqNw
	VXXpkdqLCTewfeN2WLCgZ4W23Tq5mReZSyYh/PknIfGllktJccXC/
X-Received: by 2002:ad4:5945:0:b0:70d:cc1b:68d8 with SMTP id 6a1803df08f44-73946e7c091mr163021856d6.60.1757511796365;
        Wed, 10 Sep 2025 06:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6PHZIhUDI560woSHXbXEfXTfCiGlJ/BbPfkyDjwFSiQx7owU5WH313TRjCymTd7ql0gFT6Q==
X-Received: by 2002:ad4:5945:0:b0:70d:cc1b:68d8 with SMTP id 6a1803df08f44-73946e7c091mr163021196d6.60.1757511795562;
        Wed, 10 Sep 2025 06:43:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c4ed3csm43091651fa.4.2025.09.10.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:43:14 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:43:12 +0300
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
Subject: Re: [PATCH v4 10/10] drm/display: hdmi-audio: warn if HDMI connector
 doesn't support Audio IF
Message-ID: <zjfnbabmnpopxy3r2dbpiiuhspoapc4mvpkha6bfses2mf6gpi@tmp4konlmimh>
References: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
 <20250909-drm-limit-infoframes-v4-10-53fd0a65a4a2@oss.qualcomm.com>
 <20250910-magic-natural-saluki-4aca9d@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-magic-natural-saluki-4aca9d@houat>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c18075 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=41mUuBG4nv7vr-MJPacA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: ijbwj1KgvpWz4n5-nwUTamCMeQ7O_u81
X-Proofpoint-ORIG-GUID: ijbwj1KgvpWz4n5-nwUTamCMeQ7O_u81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXw8qqLzk7BQpP
 frjnI/06v5u3Q1pHpL/Ll7uAPTkGxdmbSa0QbVa1QSfN4kaXYCu78XygSr5TlHbT/1ZdKt21nan
 wouEgXAVT5GxkdAUHrKpbmF4flAzNSOVS49OeCnueM1T710eNWbJ+ViaxD+CuXc+W6lFJAXDSrv
 eTBmHC/U/L8BsgTEiLuCUUqcP27Fcx2KWj+PKXNvhZ6htSfOZmAZu9osYdK3wSWqluS/3ie1Lhs
 3TbfOssTJmhrt1htyzzwzYnhzYXujvFN0NYTYs4p1UvB5IlNlv+diz7E1Cvi7ODX6ZQFZe5xfR4
 I33AacIuQxXhwOx7p6sjqp3xKwot1eha7sE55pbAXxKk4or/jP725nwyRXc7bOLTYOlQfazSbil
 4drpkZxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Wed, Sep 10, 2025 at 01:05:47PM +0200, Maxime Ripard wrote:
> On Tue, Sep 09, 2025 at 05:52:08PM +0300, Dmitry Baryshkov wrote:
> > Sending Audio InfoFrames is mandatory for getting audio to work over the
> > HDMI link. Warn if the driver requests HDMI audio support for the HDMI
> > connector, but there is no support for Audio InfoFrames.
> > 
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Acked-by: Daniel Stone <daniels@collabora.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> > index 7d78b02c144621de528b40b1425f25e465edd1ae..35e0e79cb683a68af813344aa86c154c3a5531fe 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_device.h>
> > +#include <drm/drm_print.h>
> >  #include <drm/display/drm_hdmi_audio_helper.h>
> >  
> >  #include <sound/hdmi-codec.h>
> > @@ -178,6 +179,17 @@ int drm_connector_hdmi_audio_init(struct drm_connector *connector,
> >  	    !funcs->shutdown)
> >  		return -EINVAL;
> >  
> > +	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
> > +	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
> > +		unsigned long supported_infoframes =
> > +			connector->hdmi.supported_infoframes;
> > +
> > +		if (supported_infoframes &&
> > +		    !(supported_infoframes & DRM_CONNECTOR_INFOFRAME_AUDIO))
> > +			drm_warn(connector->dev, "HDMI Audio with no support for Audio InfoFrames\n");
> > +	}
> > +
> > +
> 
> That's not what I suggested. What I suggested was that we tould check
> the return code of write_infoframe, and warn if it is set by the
> framework, but returns EOPNOTSUPP.

I see, I misunderstood you then. I will respond to the comment at patch
1.


-- 
With best wishes
Dmitry

