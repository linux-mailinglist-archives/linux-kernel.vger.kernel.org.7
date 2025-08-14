Return-Path: <linux-kernel+bounces-769280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D916FB26C35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABEA64E2842
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F62202C3A;
	Thu, 14 Aug 2025 16:14:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4EC218592
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188044; cv=none; b=WMiMWeS4yNE9uSX85iWz0+SO4y3JWZr+gLP5dYgF0SA+jb/h2/eFEAUXY2lH+ou+0gBLF5G7MuzSvf7w4kDaERW/D9oe9F0aZuDrRT/KNLKJvvC0xgO8FpoC/5MHUqrQ5UEI8IGpvfYC0TOglHLAmV0Pbw8AD3yzDuVMQx317h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188044; c=relaxed/simple;
	bh=Fr6xTqn+YFAKntbls3pZMJ3VQKpDZwrzY1H8n1hFwDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2RPnxPubdoE31I4nougMMoZnptHjjpSiPllXVajQcqXnTnUUz/XGfUlETkM23Hynre1Fo0eP5U5vUY3daBjpmdjLcfyEFK5Cr5nJpjNftgLZZ7e7w0iTX+cSBCeuQZ1w912MqoumOHJ2SDpHAy0+JcRUfXwJXHFPEvJY2qY6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C8E1691
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:13:53 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 720CA3F738
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:14:01 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:13:54 +0100
From: "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
	"mripard@kernel.org" <mripard@kernel.org>,
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
Message-ID: <aJ4LQvqli36TlETu@e110455-lin.cambridge.arm.com>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
 <20250811094429.GE21313@pendragon.ideasonboard.com>
 <awtqznhquyn7etojonmjn7karznefsb7fdudawcjsj5g2bok3u@2iqcdviuiz2s>
 <20250811111546.GA30760@pendragon.ideasonboard.com>
 <2ah3pau7p7brgw7huoxznvej3djct76vgfwtc72n6uub7sjojd@zzaebjdcpdwf>
 <DM3PPF208195D8D0E55A761A3C16B87BAEEE32AA@DM3PPF208195D8D.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM3PPF208195D8D0E55A761A3C16B87BAEEE32AA@DM3PPF208195D8D.namprd11.prod.outlook.com>

Hi,

On Wed, Aug 13, 2025 at 10:04:22AM +0000, Kandpal, Suraj wrote:
> > > > };
> > >
> > > I still don't like that. This really doesn't belong here. If anything,
> > > the drm_connector for writeback belongs to drm_crtc.
> > 
> > Why? We already have generic HDMI field inside drm_connector. I am really
> > hoping to be able to land DP parts next to it. In theory we can have a DVI-
> > specific entry there (e.g. with the subconnector type).
> > The idea is not to limit how the drivers subclass those structures.
> > 
> > I don't see a good case why WB should deviate from that design.
> > 
> > > If the issue is that some drivers need a custom drm_connector
> > > subclass, then I'd rather turn the connector field of
> > > drm_writeback_connector into a pointer.
> > 
> > Having a pointer requires additional ops in order to get drm_connector from
> > WB code and vice versa. Having drm_connector_wb inside drm_connector
> > saves us from those ops (which don't manifest for any other kind of structure).
> > Nor will it take any more space since union will reuse space already taken up by
> > HDMI part.
> > 
> > >
> 
> Seems like this thread has died. We need to get a conclusion on the design.
> Laurent do you have any issue with the design given Dmitry's explanation as to why this
> Design is good for drm_writeback_connector.

I'm with Laurent here. The idea for drm_connector (and a lot of drm structures) are to
be used as base "classes" for extended structures. I don't know why HDMI connector ended
up inside drm_connector as not all connectors have HDMI functionality, but that's a cleanup
for another day.

drm_writeback_connector uses the 'base' drm_connector only for a few things, mostly in
__drm_writeback_connector_init() and prepare_job()/cleanup_job(). In _init() we just setup
the properties and the encoder after we disable interlacing. prepare_job()/cleanup_job()
is another workaround to be to some custom ops some drivers might want for signalling. So
we should be able to convert the 'base' drm_connector to a pointer relatively easy. We shouldn't
need to get to the drm_connector from a drm_writeback_connector() outside drm_writeback.c.

Then it looks like what we need is a __drm_writeback_connector_init_with_connector() where we
can pass a base pointer and remember it. Maybe an extra parameter to existing init functions,
or a new one that skips the encoder initialisation entirely.

Best regards,
Liviu


> 
> Regards,
> Suraj Kandpal
> 
> > > > I plan to add drm_connector_dp in a similar way, covering DP needs
> > > > (currently WIP).
> > 
> > --
> > With best wishes
> > Dmitry

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

