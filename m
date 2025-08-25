Return-Path: <linux-kernel+bounces-784396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8BB33B13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F828203F00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF42C21D0;
	Mon, 25 Aug 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XlG1Zg00"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5E2BEC43
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114006; cv=none; b=ocx8zLdhgVZKeCKjJ5xOGD1X/OoAlsEX7zd1cSmzmXDS7LzXeV6J3bFhIzXFroMy7bi+yYHni52OiieC2zE14/z69vzhWkdmklc6h7mA8RATEjsPxbUiKucuh6vjtdMMXIoyQCt7xUPd8lJFPLHWFHoAR99vA1RfK2uP1/UXfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114006; c=relaxed/simple;
	bh=R87Y9+RWgFFCPzkxvv/rH4Dvb9WaYn5c3cVJvawzpxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT59avC9pv9dnbNpGR84sqBKKxEcnL0jfZPJKBaPMCSNg3T83eb5rgfjRZ0IpNqliq34yHA3bCcw7ahy0w+XNA5gM95mDOx737zeHIf3xz6q8BfONffrpkl2I6mJ26vnQb2ADvyK+6PAYoRxMY+8uCRRpIYTYb2J9pQV4RVP5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XlG1Zg00; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8e1t5014221
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4EjmfETgNQm/Vlvha9wFXQHI
	t0wG5jz8jtoxkPVtlaI=; b=XlG1Zg007yo8B7QsjnIaAxiPH9JAUnbzR9Sab0I3
	YHz+BiXJi/mP3RdpI6WVigzYtLwx6oOTG51Yrn9GneL9axk7y47GahXNS9xHdBjR
	macTnmoASdfVIYIxqLuL6IG9rUS79yUrksDyXcUVlWzqceHPjXh9qS9iLGIUXpD/
	DSRuKz3jSsmXW4rBN0qDlOv+LSLwxTV4d2ZA1U1bUOUV0/MJ/FRiNDO0/Lq1GpUR
	M2uUZlHtnqYt/POZif6PT/757sXTQfYKiUhKtzVg1qCLtyAudYXo+28fu7weMMll
	DeMHZH3f2KfZzHtUTT0b25G8n5UTpdC64UeVQaf4Pz6+0w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5cgkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:26:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70db892e7b2so21344596d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756114002; x=1756718802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EjmfETgNQm/Vlvha9wFXQHIt0wG5jz8jtoxkPVtlaI=;
        b=EBHLvydBfj97AAtmEpxTb7Z7ZQknx0sehVLqZI/K10HQ4M2hO6RY/TTLcFE3HLdHjd
         y7RpoK+5N/whswMvNSVogUv/bH/SHfmaiznX5OUHNxtjeWxbHsRh+JYmlLidI7s6C7tK
         XKl7+uM65IuU0m6MOhEHt+Kb1cwmQxwyhi9hWxyQ//HM5NNoMMX+YtT2LYdtyTDs+rD8
         ID/eVy6zvznXhT7fjXAQI9Jo31C91dgq6lJFuAddRfN0YEVezVrSXnBTC2VDDDmxU0SJ
         lugWldcmcgnkvAoe8DkyrSZy+vpSg3qWolctBZbdC726Sj+ikHQ0F4z2kacZlh+65A9Q
         TSjA==
X-Forwarded-Encrypted: i=1; AJvYcCW+j2kbk1WdQIHyuUik4rR4h2P/hinZhC/YZqv1nf7CIdkVBzRwYmY3qZ//kkdMnTxXOirr8nQGiGlJPQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtBHW+gLt3pBdc9mq1rUY6hQP97KufHRt0nE9d7txIeBwkEU4
	y7ZYDDWSp43whnZnDDm4mceQvNLoWopJXocW4Rktdvd8oktx0EBe/lnEwOW2EZONQdxPOO32c+e
	lvZwlLKXzVg4iG4vNMAl7nQZ32WUHTjA20Di7hbw1u8tojgKvHPmjum0OFq5qnLExE7nCJfuec4
	g=
X-Gm-Gg: ASbGncvYO3eY99AFdXCdHU1PnCb/Zh+Zrd/K9DTHs0AGcldz+j1UCuSekhvOA8tK0uo
	U4y2Pa/ZO0q5JtYuOsjwgUTAuwBC5Hpg+ko9yRLvo/ho24OOcQM0pre2GhBjEsrLO0wpeKLxzxY
	mbtlv0ci5LP6rytLeSqoaNe1aJhuWchlVq6eTieuZHmogQ6H762a3QWmRzuu+Yv0Nlm0fY8wSGG
	SBzh4yeigpZ2FDuDpzqaVAaEhMZfPBEBr5YgqDQGAVxk5FLOluUGO2xU6GMH5s7LHgGT7km3g6E
	O4AiwEFIyWgMPgI3BwKz9sbXYOTddSHS8dGOKXOn6vfxsu4ekhwu5paI+qbeGkmJ2hSF2M0l/oe
	bp5zrFi02sHR7WBpXQIDAYimMwCtq5fQXzcstrx7KMXchT/qVuRVP
X-Received: by 2002:a05:6214:4a02:b0:70d:a44c:7888 with SMTP id 6a1803df08f44-70da44c7dc8mr92019906d6.24.1756114001841;
        Mon, 25 Aug 2025 02:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm4osqf3FKfdRsdXmqHxRRVdAGOSVE7liNGQR4vahCuDo4dZvvt3gTYb3tINRaNS66Ihgu0w==
X-Received: by 2002:a05:6214:4a02:b0:70d:a44c:7888 with SMTP id 6a1803df08f44-70da44c7dc8mr92019466d6.24.1756114001224;
        Mon, 25 Aug 2025 02:26:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20ed53sm15882191fa.4.2025.08.25.02.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:26:40 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:26:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: "mripard@kernel.org" <mripard@kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "kernel-list@raspberrypi.com" <kernel-list@raspberrypi.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        "Murthy, Arun R" <arun.r.murthy@intel.com>,
        "Shankar, Uma" <uma.shankar@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "siqueira@igalia.com" <siqueira@igalia.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
        "abhinav.kumar@linux.dev" <abhinav.kumar@linux.dev>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "jessica.zhang@oss.qualcomm.com" <jessica.zhang@oss.qualcomm.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
        "mcanal@igalia.com" <mcanal@igalia.com>,
        "dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
        "tomi.valkeinen+renesas@ideasonboard.com" <tomi.valkeinen+renesas@ideasonboard.com>,
        "kieran.bingham+renesas@ideasonboard.com" <kieran.bingham+renesas@ideasonboard.com>,
        "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <tk2x6a3laaiwa2tiaewa4esl5o2gi363h3tfb5uha6apno34gr@fxqbhixyicw6>
References: <20250811092707.3986802-2-suraj.kandpal@intel.com>
 <20250811094429.GE21313@pendragon.ideasonboard.com>
 <awtqznhquyn7etojonmjn7karznefsb7fdudawcjsj5g2bok3u@2iqcdviuiz2s>
 <20250811111546.GA30760@pendragon.ideasonboard.com>
 <2ah3pau7p7brgw7huoxznvej3djct76vgfwtc72n6uub7sjojd@zzaebjdcpdwf>
 <DM3PPF208195D8D0E55A761A3C16B87BAEEE32AA@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <aJ4LQvqli36TlETu@e110455-lin.cambridge.arm.com>
 <hc6f6wgsnauh72cowocpm55tikejhiha5z4mgufeq7v6gb2qml@kmgfd26bigos>
 <wr76vyag2osox2xf7ducnkiaanzk2k5ehd2ahnoyqdm5qiywlk@penf4v5bvg5z>
 <DM3PPF208195D8D87AECE8397914A67D9A1E33EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF208195D8D87AECE8397914A67D9A1E33EA@DM3PPF208195D8D.namprd11.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4k8+ysphFy6W
 4/IyH/oU2o76vK+CVaU+iup4CMao6nb/d072LkNp6HgDwCENCaej13JclXLTedotzBucV7/Jwdn
 spQc1EuHIx5kZeht9sa599MEWBeqRk3oLKEAR4wHOYHh2awsSe9SOcoqZXPqCHJxgDa6Jv2s12Z
 rydBH6VTP3svdAPISfiI8BSfJijl/0hRycHRyrqpv1D8D1KjDun4WfOnMNpx84Kn1i0mFyz8AO6
 CcwEucHdEQyC+jrxrMMf4Y1twF0P5KArEEYB4LIPxu7NZThEqum7fhNFEfHvTAg4Y0K96EqpVSa
 +hDEHFLoRdvgJtJqYQ/wJmoEheIRSyXcY6/b0RzGhYinEOlFCw/qido2MCzrui+RFhIjbULYPKB
 fzYyxT4a
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ac2c53 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=2bDsevyxfkvo1t3REK0A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: IvwBEtbbNXYPJiCy8ORtVxRzU3vN5_UM
X-Proofpoint-ORIG-GUID: IvwBEtbbNXYPJiCy8ORtVxRzU3vN5_UM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 06:26:48AM +0000, Kandpal, Suraj wrote:
> > Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor
> > drm_writeback_connector structure
> > 
> > Hi,
> > 
> > On Sat, Aug 16, 2025 at 01:20:53AM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Aug 14, 2025 at 05:13:54PM +0100, liviu.dudau@arm.com wrote:
> > > > Hi,
> > > >
> > > > On Wed, Aug 13, 2025 at 10:04:22AM +0000, Kandpal, Suraj wrote:
> > > > > > > > };
> > > > > > >
> > > > > > > I still don't like that. This really doesn't belong here. If
> > > > > > > anything, the drm_connector for writeback belongs to drm_crtc.
> > > > > >
> > > > > > Why? We already have generic HDMI field inside drm_connector. I
> > > > > > am really hoping to be able to land DP parts next to it. In
> > > > > > theory we can have a DVI- specific entry there (e.g. with the
> > subconnector type).
> > > > > > The idea is not to limit how the drivers subclass those structures.
> > > > > >
> > > > > > I don't see a good case why WB should deviate from that design.
> > > > > >
> > > > > > > If the issue is that some drivers need a custom drm_connector
> > > > > > > subclass, then I'd rather turn the connector field of
> > > > > > > drm_writeback_connector into a pointer.
> > > > > >
> > > > > > Having a pointer requires additional ops in order to get
> > > > > > drm_connector from WB code and vice versa. Having
> > > > > > drm_connector_wb inside drm_connector saves us from those ops
> > (which don't manifest for any other kind of structure).
> > > > > > Nor will it take any more space since union will reuse space
> > > > > > already taken up by HDMI part.
> > > > > >
> > > > > > >
> > > > >
> > > > > Seems like this thread has died. We need to get a conclusion on the
> > design.
> > > > > Laurent do you have any issue with the design given Dmitry's
> > > > > explanation as to why this Design is good for drm_writeback_connector.
> > > >
> > > > I'm with Laurent here. The idea for drm_connector (and a lot of drm
> > > > structures) are to be used as base "classes" for extended
> > > > structures. I don't know why HDMI connector ended up inside
> > > > drm_connector as not all connectors have HDMI functionality, but that's a
> > cleanup for another day.
> > >
> > > Maybe Maxime can better comment on it, but I think it was made exactly
> > > for the purpose of not limiting the driver's design. For example, a
> > > lot of drivers subclass drm_connector via drm_bridge_connector. If
> > > struct drm_connector_hdmi was a wrapper around struct drm_connector,
> > > then it would have been impossible to use HDMI helpers for bridge
> > > drivers, while current design freely allows any driver to utilize
> > > corresponding library code.
> > 
> > That's exactly why we ended up like this. With that design, we wouldn't have
> > been able to "inherit" two connector "classes": bridge_connector is one,
> > intel_connector another one.
> > 
> > See here for the rationale:
> > https://lore.kernel.org/dri-devel/ZOTDKHxn2bOg+Xmg@phenom.ffwll.local/
> > 
> > I don't think the "but we'll bloat drm_connector" makes sense either.
> > There's already a *lot* of things that aren't useful to every connector (fwnode,
> > display_info, edid in general, scaling, vrr, etc.)
> > 
> > And it's not like we allocate more than a handful of them during a system's life.
> 
> So Are we okay with the approach mentioned here with the changes that have been proposed here like
> Having drm_writeback_connector in union with drm_hdmi_connector
> Also one more thing I would like to clarify here is how everyone would like the patches
> patches where each patch changes both the drm core and all related drivers (ensures buildability but then review is tough for each driver).
> Or patches where we have initial drm core changes and then each patch does the all changes in a driver in its own respective patch.

The kernel must be bisectable. Which means that after each patch in the
series the kernel must build completely and work without additionally
introduced issues.

-- 
With best wishes
Dmitry

