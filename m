Return-Path: <linux-kernel+bounces-816987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FDB57BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32881A26F56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E61DFD9A;
	Mon, 15 Sep 2025 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eu/s6Ih9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347430B53B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940861; cv=none; b=IXNKMw4l/cBH+n/kgOyJAg+Rm4hk4kQkuqe2omWz9dr/rlcyuidZP5tJ8/H8zhl7KuhdpEJLGYla0JOMTKc0IXo8wSse7+fG8vTMze3v6Ov+NCfXCrtWEtQ70qGokD3C1PCgRKfCpc4Yn2kgUct4etHAr9eoN+s1858jstcPDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940861; c=relaxed/simple;
	bh=SbhXtqpSXXyIu6nI3pQGW8+82wbAmY3iE3aPb8JZP1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCcLk62n+8lX73n6A4MO7QCanqri/5k+SMSWvYKyuAsWi1cPdInYMLvdHq6C5KN0KdVr5LLHy18y+vai5qnvQIOixNCUJ2VwW+uir06DsOtp1dg2+fLwdWEcGaPJ0AYPN2ITEnfzMDhLu/bP39ykE2YxanOVVtH9DQ/FclU5jcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eu/s6Ih9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FfF5027158
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o0T8uyDJ7tOU3W9Euxtpr2nB
	WWgLIb6UxinGBw7EkVs=; b=Eu/s6Ih9acp92r/ty4Em8hZPAU92SYR2vN58BaoB
	NWe1Ls6CQll88f2PgD9zLmkJWD3vQDKqyjq9HVEl8Hdxn6+qWdj+3q2ZGkUNvjuy
	+Jf61RdNv57W1pucmcann7nGZwp3aI27yl8mmM6cJpv+TCNliOdiw84ZEGlbISJR
	kFmE2xhqzg/CeXgtdLAYblQ3KEMNxxumz56DF/LCdIbyA8TJzoU/WKnrdiBm671y
	SZvvZI8mW8d1+WKoJHt4Gimai72RSn/6Hrs25pS+5/WwAU5QqSFrpyI5xv8EYZwS
	NTgC+9JTlhCVYiGy1y/vYhYdM/EZyuNhKO4GtI4mALlOOw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072mxn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:54:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f818eea9so83112301cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757940858; x=1758545658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0T8uyDJ7tOU3W9Euxtpr2nBWWgLIb6UxinGBw7EkVs=;
        b=c+069k60p1tXqW0iEi5SxqtFrktWeg/4tPzFvaeUHqbL9wYOVsL7okX6ekrvvfqFwL
         j3WCyq4OcWawA0tDcx+z2Dol8Wwip6Xgxo8sOfCNaYcA5o2jcxSzSC5YOLMhx7OxrDE1
         ID0CucHtqvVyZgcfYQAkSsXfYwKgZr6T4z+MBOC+QxqKGcxKiElBzTqBlkYwlTwYSPto
         rwmhNgOWh//eDdcjuLHkMSCRdvXf2pSrXhQIcxJPTVRIWJPm11wN0uxvRkVlNOjoLaTr
         5JR+Y1CvnusUQXQ+GPw+Tb847h7YUeavmD0ly7ug03qEl/CFBKLS8iA/24d26NHvnGo2
         1TDw==
X-Forwarded-Encrypted: i=1; AJvYcCXd/5VVEGE+Z+p1BmWL/PoJy7qiTQBvvaR4YHNYjtCYYnvWC2kamFwKVE0Dqg+EdIBuxmpJ7LWeJtVTxuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVavaynwBEadwUPP2tUFk32KHYHDaGt+LwAOXDuJ9vKIboShMk
	K5MzSh2uZMULLY97l3Hny3NjUzgTElVKIf4R3pCs/mCNPpuev7pQroz+hcya1SGiIwm+/mPoPpy
	5oyNXXSZOys1ErU4gerpK8EdLGuTufOOVeOsvBfQpjtObLt+NJaxDumYFTk/CIcaJ6DE=
X-Gm-Gg: ASbGncv8Q1SJcmevbhe63GJUgh45cZU+NNUifIRrWefrmnlNotT2jiz9rUzkjKyTlAe
	vf3b3MZuC1XiMSH2zEIErWxB7ZoBAngaSPSlv7I7mlc3X/dkPzk1Jis7aKvyqCKjADr3s9vJf7j
	1PKMzN8LTTgsHLQnXxdIDvV1WGhUVZftO8gwSAtgEf/QjZcvUlmvlJ99m3rEAClY3b2qlhZGssv
	cEyjQmUUdlg5DezR06/r2CxE7vD0dVtWU5bKQWeNRcgiu6un0WQ1FIBhShSRY4cvgUfbwJXq1KJ
	YZCJxVNbTLtkCLSZHPn8BKJyqWs8k/mySc8b6vwjs6Ot3/9wTqYZZYS5H91Ky9xslJjZN+fl2at
	fazrlkeJTSYODG/LbR0iThOGs8NiSHHwCWRdb5X02wPUsnXGUvrvh
X-Received: by 2002:a05:622a:114b:b0:4b2:f786:92dd with SMTP id d75a77b69052e-4b77d057aaamr140665781cf.57.1757940857961;
        Mon, 15 Sep 2025 05:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK/Dntm41+HPvtouzaomkvJm85bXcfqIOmnG7ih6nBJsgKKnkSKf2PgTx38rP0sVjrJYYKiQ==
X-Received: by 2002:a05:622a:114b:b0:4b2:f786:92dd with SMTP id d75a77b69052e-4b77d057aaamr140665411cf.57.1757940857417;
        Mon, 15 Sep 2025 05:54:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8212d8sm25926991fa.36.2025.09.15.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:54:16 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:54:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/29] drm/atomic_state_helper: Fix bridge state
 initialization
Message-ID: <epllmgesjxcnadjjsaeotgsdw63eu4uyx5q7zifn2gkudfi7e7@oirj5aiv47qf>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-5-14ad5315da3f@kernel.org>
 <9f17dfd9-a4d4-41e9-b988-bd8ca858e5e7@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f17dfd9-a4d4-41e9-b988-bd8ca858e5e7@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX/J/445vxMeTM
 tO/2t73MoQzuseLfcIfvxrEDRucR76Xn0YF9+wXb0uNLySzF6xHFrrgTlo2QXewYQlxMt5zTu6F
 EPmNGut7XR08JwJl8L2QcbE15A68q9tBv9gCvzlySZtVA4G3yvWVQm1XkR7cDPgXKlwLMOvk/Nz
 RkHjhPI2nDYLI5HAqXsH3Zl5ruaaKWGOBNDZwqQuTBQiWuoJh9hf09gYv63cmUPahnGzPRG8mO8
 5+CxoSGMMIDHMT3GP+OKURio3o1Ye8/P35kynOUuWjiHoJpTESd9lHRCzpT97y3knMbhxGD9+aJ
 tJugmJ0c0xGSwUzH5baXxczPSGBXvQ4cNrPduXRfNOAHpLSjQlQ/GPfs2XgNxSJ664dM3FaUuqW
 L7Al0wmH
X-Proofpoint-GUID: kXZobU2B_dU40GdxbisdG-aM4sdWzhUK
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c80c7b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=ZlCgwJgu-Kaulvl6kbsA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: kXZobU2B_dU40GdxbisdG-aM4sdWzhUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Tue, Sep 02, 2025 at 03:18:17PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > Bridges implement their state using a drm_private_obj and an
> > hand-crafted reset implementation.
> > 
> > Since drm_private_obj doesn't have a set of reset helper like the other
> > states, __drm_atomic_helper_bridge_reset() was initializing both the
> > drm_private_state and the drm_bridge_state structures.
> > 
> > This initialization however was missing the drm_private_state.obj
> > pointer to the drm_private_obj the state was allocated for, creating a
> > NULL pointer dereference when trying to access it.
> > 
> > Fixes: 751465913f04 ("drm/bridge: Add a drm_bridge_state object")
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/drm_atomic_state_helper.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> > index 7142e163e618ea0d7d9d828e1bd9ff2a6ec0dfeb..b962c342b16aabf4e3bea52a914e5deb1c2080ce 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -707,10 +707,17 @@ void drm_atomic_helper_connector_destroy_state(struct drm_connector *connector,
> >   	__drm_atomic_helper_connector_destroy_state(state);
> >   	kfree(state);
> >   }
> >   EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
> > +static void __drm_atomic_helper_private_obj_reset(struct drm_private_obj *obj,
> > +						  struct drm_private_state *state)

Which should probably be used for other private objects. Do we have a
good place to add a warning on state->obj being NULL for all private
objects? It looks like we have only drm_atomic_helper_swap_state(), but
it feels weird.

> > +{
> > +	memset(state, 0, sizeof(*state));
> 
> This argument is guaranteed to be zero'd, I think. No need for a memset.

In this case, but not in case of a generic object.

> 
> > +	state->obj = obj;
> > +}
> > +
> >   /**
> >    * __drm_atomic_helper_private_obj_duplicate_state - copy atomic private state
> >    * @obj: CRTC object
> >    * @state: new private object state
> >    *
> > @@ -796,10 +803,11 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
> >    */
> >   void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
> >   				      struct drm_bridge_state *state)
> >   {
> >   	memset(state, 0, sizeof(*state));
> 
> Another unnecessary memset?
> 
> Best regards
> Thomas
> 
> > +	__drm_atomic_helper_private_obj_reset(&bridge->base, &state->base);
> >   	state->bridge = bridge;
> >   }
> >   EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
> >   /**
> > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 
> 

-- 
With best wishes
Dmitry

