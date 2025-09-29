Return-Path: <linux-kernel+bounces-835977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2EABA87CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F44189D42E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB92C031E;
	Mon, 29 Sep 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgQghBqq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B3273805
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136314; cv=none; b=RvovgBXyaCeGTuD+VgeL1+u8i39S1oZOYnpIYAY3J3ax7gHBWgnFcRMo5P/unRUPeUx3vzmg1SK6tIJc3IG3FXdBipeXgK32Fi+S6mrY2II01gonmLwFtzODwq+KWIka09YHpqFbdd5SKlZuQGLB9gYcP5vFOpMvTCGdDNO7Zqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136314; c=relaxed/simple;
	bh=W5RVkBnKmsxc6H3VKwcDAVQ0kUrB/s8qRiUIqWgXJjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlMvofILOrD1GGYBnEQ0DT5cmuIAKAl66szdv3gVzfH1m6+YdUJIuhuUsYfIMhHeaHBLeTm9d03l9YjF1tNziBCsRR3tY5XBDA365yDcDBDT8T+YOVOZkr66bOR1Oh3UWy/dtlm9HPAuiGApPQU9d6cstBMM1at7q32irtCmNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgQghBqq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLOH3L012624
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wSequNqFSYA0hQaFMGDh8sH2
	KqbBMi/C9WAGDMfQdVw=; b=CgQghBqqAX6HNwF8cUOrkL+/imUDeljUBwxSMLqU
	EABUCjKImHemM61jfkSa5ngSAaIIN9qk6jx0xNtyw/ve46+UV8CrZ855qA5wkC0j
	FSgIqWNYpuQxbvCgAz83PFQjPOdJBELHYSvfXbYkYH/oDfo4bcf37VgPicVaACDa
	AII0m6+fC6Qsd6ILfrex1yeoqb6DclNrOokHpZOgLmXoY+CV2NQHiV4XpasOiexT
	GvMBOrNzWP8MbsKx+20UPxjPyi71gb4UoYmKNhadnp/a3/onTUYD1TZcHHZKoqBL
	zVv/0A4znKvD6uCf1A4OqshGicsKhhpGhIwxE8Tp7fwnuw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fvm66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:58:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b302991816so84843051cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136310; x=1759741110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSequNqFSYA0hQaFMGDh8sH2KqbBMi/C9WAGDMfQdVw=;
        b=laN/VGdP01XgDtSe7BRgLknGiPJaS2aklq9emMCk9WkvarLsQ6Rt5/bhjlinLJWUZg
         OFQ3hu2Gn5Hf5+CBQWCDHxZL6d6DmWu2933UT1EA21wQKIAXsyAd8n9FZba6rxVARqJ1
         SN77cQxAjzyqzrGRnAIdFBTz0N1XyeOuOR7X1yYOtNxj1/saji/J43aD+GR5eGCHPEJk
         Zz9saYTz7xryyi+iv4ao8L6tZLxT/AeHC8d0htVHPLqXy6aPaDTwxNK+uycZXlhAkFtB
         vlKGQkGJWQPHaaRjCuzu/O73lw90Ay1PIKGGikZ1tsoOWEhRBBGD6DDm5uRMtrcaEWC5
         a5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh1l3kp5Vxtg11UQN7QD6rAX5z5xGk0+k8dAYAbo/aw9cwAxAohNIBXcAiRpU3f7FY3U49mquzWGjScSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdxwWV4mhlcmsqQ95Y03AXWsQcv6ks0U2/58yw5iI2mreBNDl
	Z0BhxYRUCs8twByJXZ1w89VxH0Z7epUYMonPkEtAjkqxdOysRXF+fhB1V86Qe4AEQN/NATgXZDf
	pB0qxiMMwSvm0QNf624hfFVX1zHsffgOP5demm6TogExlXWRrRMKqEtHs95RLkDcmKbs=
X-Gm-Gg: ASbGncv/t8MECzzj2x1t7DJLLxMLHMTwTo0trKtGVsHAMw5zd1ZG27HgavgYwnmYQvW
	RBbBBEfU4KYhMXUYc6k0Ji8xTEIjqgW4AL1SvvwF1Bp2QPM0BsqoWMCzJ8ofYVwc8gbgmhYXcq/
	bt9bgGNHZR/v4lCagHQ1t7lB4gdzhuyrtaa8bu13YBrvIH2KSZ9acgK76ZVmCGo5k36H70inQUI
	0W3GOwJ9kfsvWNqyRW4tKXI6uIEKGztt8tO4XE7hEpkGePuAXe8UbS2GKfARFlO76Z/R5UIKZn6
	rAzhnkHWdAsJvlKvGNVOM9ixKp7LXVM6NGCSGjkjzdVu/WyJxwgf8FV2Fb7rnrn+o+5Eta6ZhBq
	6Tna5G33F2mljqDGLpq2VCiyCtYV2K9N2XRxBj7xYM+VFg69rSuVF
X-Received: by 2002:a05:622a:5c17:b0:4df:45b1:1547 with SMTP id d75a77b69052e-4df45b11effmr106393161cf.69.1759136310518;
        Mon, 29 Sep 2025 01:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRXtkJG4+SzyzmUaBbzgU9Nn5Sl1tWg+sCFw1xHVc4pJ5o/wczABJ+K+k97kihrHCINuJSYw==
X-Received: by 2002:a05:622a:5c17:b0:4df:45b1:1547 with SMTP id d75a77b69052e-4df45b11effmr106392941cf.69.1759136310059;
        Mon, 29 Sep 2025 01:58:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831343130asm3993046e87.1.2025.09.29.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:58:29 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:58:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/9] drm/bridge: ite-it6263: handle unsupported
 InfoFrames
Message-ID: <y3sndmfnwtljkbrssyycg6scjujt4kkjfo3gjclo3suzvqdahl@bdrdzmiolcb4>
References: <20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com>
 <20250928-limit-infoframes-2-v2-3-6f8f5fd04214@oss.qualcomm.com>
 <a7f0ced8-d704-4a59-bcc7-e0bd4db113fd@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f0ced8-d704-4a59-bcc7-e0bd4db113fd@nxp.com>
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68da4a37 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Wi-JpQQdkJIPRSjGzdwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX4XjOiNBwRRaU
 gyQwfWmB1aVeNAs+ESiNRjMYPiEiLYi/n3J4r8q5GUpYdX7QySHATP0pIptXA6IfQ6aJf2QkIKA
 0LwIKuyF8TyrTH/4KYk4fYw1zpO4AYPH6gynxEDTGh1Ed9WwHcyKndGlO95XiZ5535YWElv8inX
 o23FEYPqhZ6uu0c8S8GINVDyrW1ZPDFUZ8t/NThJesjM/arqb92Zv1QrNhgOJWJ1FTznpT7YsBi
 HfW9BRMz38MjO+IuYi+dmCz+rKtnQAXG0joJMzav446RkHwtW6AvwOKG9v6Q+xAb4eSk93J1AgZ
 g2upYQ6XQ4cRcG/4nNX5SMDDxmJaMDG29OPNzpztK1Mh3a+U17VxF4cfYdBQsYDks5FlDb3cRL7
 43FT6deErZGhUl9nh5rmvvbAnxpzIw==
X-Proofpoint-GUID: 5_Z0Ihb5u5TO7z5PwKRorNm5L955mo5w
X-Proofpoint-ORIG-GUID: 5_Z0Ihb5u5TO7z5PwKRorNm5L955mo5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022

On Mon, Sep 29, 2025 at 03:56:31PM +0800, Liu Ying wrote:
> On 09/28/2025, Dmitry Baryshkov wrote:
> > Make hdmi_write_hdmi_infoframe() and hdmi_clear_infoframe() callbacks
> > return -EOPNOTSUPP for unsupported InfoFrames and make sure that
> > atomic_check() callback doesn't allow unsupported InfoFrames to be
> > enabled.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/ite-it6263.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
> > index 2eb8fba7016cbf0dcb19aec4ca8849f1fffaa64c..cf3d76d748dde51e93b2b19cc2cbe023ca2629b8 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6263.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> > @@ -26,6 +26,7 @@
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> > +#include <drm/drm_print.h>
> >  #include <drm/drm_probe_helper.h>
> >  
> >  /* -----------------------------------------------------------------------------
> > @@ -772,7 +773,7 @@ static int it6263_hdmi_clear_infoframe(struct drm_bridge *bridge,
> >  		regmap_write(it->hdmi_regmap, HDMI_REG_PKT_NULL_CTRL, 0);
> >  		break;
> >  	default:
> > -		dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
> > +		return -EOPNOTSUPP;
> >  	}
> >  
> >  	return 0;
> > @@ -812,13 +813,35 @@ static int it6263_hdmi_write_infoframe(struct drm_bridge *bridge,
> >  			     ENABLE_PKT | REPEAT_PKT);
> >  		break;
> >  	default:
> > -		dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
> > +		return -EOPNOTSUPP;
> >  	}
> >  
> >  	return 0;
> >  }
> >  
> > +static int it6263_bridge_atomic_check(struct drm_bridge *bridge,
> > +				      struct drm_bridge_state *bridge_state,
> > +				      struct drm_crtc_state *crtc_state,
> > +				      struct drm_connector_state *conn_state)
> > +{
> > +	/* not supported by the driver */
> > +	conn_state->hdmi.infoframes.spd.set = false;
> > +
> > +	/* should not happen, audio support not enabled */
> > +	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
> > +			     conn_state->connector->hdmi.infoframes.audio.set))
> 
> Maybe use drm_err_once() instead to provide the reason for the warning in
> a string?

I can change all of them to drm_err_once(), sure.

> 
> > +		return -EOPNOTSUPP;
> 
> As this check could return error, it should be moved before
> 'conn_state->hdmi.infoframes.spd.set = false;' to gain a little performance.

I'd say, it would be negligible.

> 
> > +
> > +	/* should not happen, HDR support not enabled */
> > +	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
> > +			     conn_state->hdmi.infoframes.hdr_drm.set))
> > +		return -EOPNOTSUPP;
> 
> I don't think IT6263 chip supports DRM infoframe.  The drm_WARN_ON_ONCE()
> call could make driver readers think that DRM infoframe could be enabled
> in the future as audio infoframe has the same warning and IT6263 chip does
> support audio infoframe.  So, maybe:
> 
> /* IT6263 chip doesn't support DRM infoframe. */
> conn_state->hdmi.infoframes.hdr_drm.set = false;

I'd rather not do that. My point here was that the driver can not end up
in the state where this frame is enabled, because it can only happen if
the driver sets max_bpc (which it doesn't). Likewise Audio InfoFrame can
not get enabled because the driver doesn't call into audio functions. On
the contrary, SPD frame (or HDMI in several other drivers) can be
enabled by the framework, so we silently turn then off here.

> 
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct drm_bridge_funcs it6263_bridge_funcs = {
> > +	.atomic_check = it6263_bridge_atomic_check,
> >  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> >  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> >  	.atomic_reset = drm_atomic_helper_bridge_reset,
> > 
> 
> 
> -- 
> Regards,
> Liu Ying

-- 
With best wishes
Dmitry

