Return-Path: <linux-kernel+bounces-828781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF96B95705
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DCA2E5E10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766E31D381;
	Tue, 23 Sep 2025 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCSjZYGL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3927815B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623450; cv=none; b=YoeVaJdD6LS3inCy05N68M1oiAMlIXGudPhAL/0YwzIgfeLevhl4XJdJ8wOY3LH9Fp7ZoMWO8DmV08EFSQx/qPYsi7eo7Cxmi6+ksNwUDAogPyC4EfCHK1MQyqzemv82AwT5kzcswYmL+RTvjUi2K0NuSp7cPdXVDJ9kFGI6tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623450; c=relaxed/simple;
	bh=0kseKmskiumyjSjkV7jMIbV2xj5zCY2Nj7TT5yfbqKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S49PDPgqPwD9fJudVgAKzYk3IkCG+eYq3bebZy1AZiKa6v/tKv6WpQk7iwrJSSaY0Uan12PxQrXLonqFHlMOtLz2KXh+7OfSz2k1ohROWSsC7OcwDBtP7PdLQFqPyXnG4ni3lp3HaW5hjPWSfbUWtm1jlPbDGg4vJyp/Q8N5+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SCSjZYGL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HC2R004522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rmYafpFQXnUuREV9KWT8YpXu
	+YN1bGGL9IDEPsJa/9k=; b=SCSjZYGL9TC8YvVreRTZ7mH2YiSeZKqsFZJXgaOu
	WLwMu9ZQVTWiyKlf9Vn5qy9+XU7+T4nb3oxFz1fWIftkjESLFNkYoIHu3V8CqToL
	rHSY17QCg1eIwQpT02Km9HUzt8jHbAQSaoTbZ5oZzbmUIZe6COC3FrtnLCyJnVXe
	mw+J8TJyUvzd6vJuPhpTkjnvk4aPrkUmDDlq+e1dDbVQ9fRrv0oNVVznjrLa+5y+
	s67I1/u55N983IQgdMXmFA9269miV5os/6wjd4hGO09NCLL8+flcvpMNtkQAgFI+
	dQhemkVzH1Y+kU5DIMSzkYh14VRV9ls/KZnIgw/qTRfmow==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnrfxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:30:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7946137e7c2so133915536d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623447; x=1759228247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmYafpFQXnUuREV9KWT8YpXu+YN1bGGL9IDEPsJa/9k=;
        b=V43+wmoECVg/u1WqR5FLm0OwQj01tJpXe7Sd3DitX7gVVE4VVozw5jfWaOzgckOumH
         Irtzafdc+/b0JHYWzSsRH9FkrxB8fwN/vqOLJQxo+l5nwkfZ0QWgfVT7mEW1FVK+rV84
         dCJ5XVUHYX62+xLKiM13zq/4/fkDvA0zuGWMHR8qncLfpiFg8CTsk9IN1k1xz5deLlKY
         PJ7z/ZcXaPyL1wjmOdhXxNk8bY52rVkaXMmP1/MtSJmkTA9BoxTtV2AY0qwIj2dUU0Xi
         3LRh7e9RQ5L9v5jlAkv6qn/kspMc58duYlArgmiAGrgYQ7jcYwPwEwsYILDucPxSl+LV
         pwYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/qWozbreAb2hn+gLHeYtGHXasFa6FGk1yswg+iB1YM7gQAVitUbSjfbviM11eQ1IgKG59jJfWuEaxo1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RMTpD8U7paCnb9J09La98PTkqUaADKsrdjErBxHKeCfdorCt
	U11V+gR3IMFdJnhVSO/bv8uQ66reaV0BZ3v8tMWENtktp6khARHxlIVqU3+ql/8MpI0pC/VkLKj
	xAezeXEWMls4l7boyY9bvbc145kj3qdo+sQAb1JbVjPKXPcb0nu7J9cHssNJYTuC0LFQ=
X-Gm-Gg: ASbGncvSJmpEmwG+Q11usGjN9kmPn4TlkoZPlV/tClkL9vU1XBea4KhPaeSzGibz81B
	fJQ3/1hy4Aea7PFkRWP5FLiKr2GcG6H/OnlUbv4Yd8W32oQ5tzQ5m6a3sk2V6ofLU2jnRwKFvfa
	U+Lh6oKjfgefpKPnJxJziVniPgD5WHZLa1g2TebtB/Gs1QbijHrWWgM0TvmZTqvK6BmzIla7D4q
	9P5zAPYJgLu3+mbeQ2+Q3wf7om3ZUSds2fn6MrGHQuR4z7ddJ7X36w9QSOhPgm2K1DTKAto2fbT
	XjLLBk4q4/zEqmJCs3ERMMF7JkH77+hQpH2xUOzEvW7yBIf05rgkX+jHNtETgn6EY2wEU4iV8i7
	BAiIjXKrgR7NT7KgYJhnhdRPxxHsMCiICTyRrabsA3qKfQRAmaCti
X-Received: by 2002:a05:6214:260c:b0:78d:5c0b:eda5 with SMTP id 6a1803df08f44-7e716783203mr24618276d6.45.1758623446747;
        Tue, 23 Sep 2025 03:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtwhCVG3iS/ZEW5EfzF5O4nQC+BKSNVhZ2kuzs27fGTin6ba+1epQrvdKbopUgS7pPF4jSFg==
X-Received: by 2002:a05:6214:260c:b0:78d:5c0b:eda5 with SMTP id 6a1803df08f44-7e716783203mr24617966d6.45.1758623446135;
        Tue, 23 Sep 2025 03:30:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44740sm4067725e87.14.2025.09.23.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:30:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:30:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
Message-ID: <hd7gjmsbxjfaffxaxvnafzlq6rf625nxqfmcrllnndl6yigtaq@o6vaotpu55by>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <zvqtehg66dbrrdmik6ylo2kdk74umfzo5hbfkizwsb352nlyqv@jgouvmbfwa4x>
 <20250923-rigorous-tamarin-of-cookies-2f1a25@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-rigorous-tamarin-of-cookies-2f1a25@penduick>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d276d7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gJwGxJFpRMUGz6KCoQ4A:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: pLWFZk6PDQtArWsooBm3GLuN55d9Zd24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfXwsSd5QSDZhRd
 RJWP27hOs0lMn0kaHwtfT025E575iX3/M/+kk+q6JT/zZP4DpvAZKfMRw4Y48i0RKni99C/chnp
 8qICbpWmSrxE4+VLk1zX1w8xMigUCbo7QTnoFgoJ12LPuFo04KEjeXgaDf/I7323Ck9MYUOEt74
 F6iV5nw0ZBmIK8ygPa7fjb2iouA1/z3EpEJfn/ZjFlQYfj2e61AqxhK5CLG59pIOpfDrSFT4jOQ
 ot1dnZ+d4WsyXrPmpbMtcFR/qwbZFSnhcssgBy4XKFblLoxwNEgSFU1BDZ94K4hwEhnRLRMy2+j
 3UVpfiA3tAxLqeyhrXdtPbqUhoZpLRyhWrPJQyocXQwrKShVWLAXGMDFYEdhPWpvKq/mAKQE32b
 DQHV5u1q
X-Proofpoint-GUID: pLWFZk6PDQtArWsooBm3GLuN55d9Zd24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Tue, Sep 23, 2025 at 11:45:49AM +0200, Maxime Ripard wrote:
> On Mon, Sep 15, 2025 at 09:40:57PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Sep 02, 2025 at 10:32:38AM +0200, Maxime Ripard wrote:
> > > In order to enable drivers to fill their initial state from the hardware
> > > state, we need to provide an alternative atomic_reset helper.
> > > 
> > > This helper relies on each state having its own atomic_state_readout()
> > > hooks. Each component will thus be able to fill the initial state based
> > > on what they can figure out from the hardware.
> > > 
> > > It also allocates a dummy drm_atomic_state to glue the whole thing
> > > together so atomic_state_readout implementations can still figure out
> > > the state of other related entities.
> > > 
> > > Link: https://lore.kernel.org/dri-devel/CAKMK7uHtqHy_oz4W7F+hmp9iqp7W5Ra8CxPvJ=9BwmvfU-O0gg@mail.gmail.com/
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 382 ++++++++++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/drm_mode_config.c   |   1 +
> > >  include/drm/drm_atomic_helper.h     |   1 +
> > >  include/drm/drm_bridge.h            |  21 ++
> > >  include/drm/drm_connector.h         |  26 +++
> > >  include/drm/drm_crtc.h              |  19 ++
> > >  include/drm/drm_plane.h             |  27 +++
> > >  7 files changed, 477 insertions(+)
> > > 
> > > +	drm_for_each_encoder(encoder, dev) {
> > > +		struct drm_connector_state *enc_conn_state;
> > > +		struct drm_crtc_state *enc_crtc_state;
> > > +		struct drm_bridge *bridge;
> > > +
> > > +		/*
> > > +		 * It works a bit differently for bridges. Because they are
> > > +		 * using a drm_private_state, and because
> > > +		 * drm_atomic_private_obj_init() asks for its initial state when
> > > +		 * initializing, instead of doing it later on through a reset
> > > +		 * call like the other entities, we can't have reset xor
> > > +		 * readout.
> > 
> > Would it make sense to unify the way the bridges / priv_obj handle the
> > state with the rest of the object types?
> 
> I would be all for it, but I think this is pretty much the same
> conversation we had in my recent bridge improvement series. Aren't
> bridges not assumed to have atomic support and thus we can't really do
> something better here?
> 
> Or should we move all bridges to be atomic?

I think I had something smaller on my mind: make drm_private_obj /
drm_bride provide the initial state during the reset call, like all
other entities.

-- 
With best wishes
Dmitry

