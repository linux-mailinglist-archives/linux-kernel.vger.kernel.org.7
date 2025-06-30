Return-Path: <linux-kernel+bounces-709260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF50AEDB00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB282178820
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F67921A455;
	Mon, 30 Jun 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V5JaRGrU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912A1DF73C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283039; cv=none; b=AGMYFZlBYtjdzVMhZ8E3FON7dfiEmOpgfpggQQ717ZRBeKtgEgKw8FGMZzCnK9fMttF9aRlf+EqltwoTB20NHVgA+OtfJIL50zWtXL4RX/PpY5/vX21fBZDqZFBvj/RiiazDcARCild4z/b6t2PfKFXt0S0NWhQzG7Hdj/WLRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283039; c=relaxed/simple;
	bh=f8UGTCDHYUrbrwvxFMRydIPYre+TP2vUFa3uY2UjE3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZQIxjarjBY0qe43GXmu1jIhGXyKe1w02PvSat0Y40zs5HKyCSZ7cKuzUucOKFhQ4QJ7HxBquywTVfU25bFd8zpDNsxUJGCPNpc5iHKucIJ6yYq5lhipIGkbzAQ4VLNYYU383ThpXJJecyqt8kxPqm8L4fLc2KbDCZcOf0JGrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=V5JaRGrU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 55B53928;
	Mon, 30 Jun 2025 13:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751283012;
	bh=f8UGTCDHYUrbrwvxFMRydIPYre+TP2vUFa3uY2UjE3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5JaRGrUmgKsFenh53PLVTcWCNAKl1NB2vLxyVYinBaWGgSEFN5FULnUIocHmCZns
	 lftjSc7ySRFu9V3xuE1aXarNkSVN7TcxHvbbJYR+1z6dvjXH+yrMiP53f12vzyQ1Vb
	 CHekjsxnYiGfyj/MT8h2yYae02fw3lVyVRo6ufuY=
Date: Mon, 30 Jun 2025 14:30:08 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Michal Simek <michal.simek@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: zynqmp_dp: Support DRM_FORMAT_XRGB8888
Message-ID: <20250630113008.GD20333@pendragon.ideasonboard.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fb98a918-329e-4536-a0a5-a99b22ba0120@emailsignatures365.codetwo.com>
 <20250627145058.6880-1-mike.looijmans@topic.nl>
 <20250627181911.GF24912@pendragon.ideasonboard.com>
 <42af6260-c8af-42e1-a9bb-adfaaabf0190@topic.nl>
 <20250630-psychedelic-tested-smilodon-adcbb3@houat>
 <20250630091156.GE24861@pendragon.ideasonboard.com>
 <20250630-phenomenal-taipan-of-imagination-59b300@houat>
 <20250630093335.GC20333@pendragon.ideasonboard.com>
 <20250630-delicate-stirring-sawfly-dd81be@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-delicate-stirring-sawfly-dd81be@houat>

On Mon, Jun 30, 2025 at 12:52:48PM +0200, Maxime Ripard wrote:
> On Mon, Jun 30, 2025 at 12:33:35PM +0300, Laurent Pinchart wrote:
> > On Mon, Jun 30, 2025 at 11:29:08AM +0200, Maxime Ripard wrote:
> > > On Mon, Jun 30, 2025 at 12:11:56PM +0300, Laurent Pinchart wrote:
> > > > On Mon, Jun 30, 2025 at 10:27:55AM +0200, Maxime Ripard wrote:
> > > > > On Mon, Jun 30, 2025 at 10:03:16AM +0200, Mike Looijmans wrote:
> > > > > > On 27-06-2025 20:19, Laurent Pinchart wrote:
> > > > > > > On Fri, Jun 27, 2025 at 04:50:46PM +0200, Mike Looijmans wrote:
> > > > > > > > XRGB8888 is the default mode that Xorg will want to use. Add support
> > > > > > > > for this to the Zynqmp DisplayPort driver, so that applications can use
> > > > > > > > 32-bit framebuffers. This solves that the X server would fail to start
> > > > > > > > unless one provided an xorg.conf that sets DefaultDepth to 16.
> > > > > > > > 
> > > > > > > > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > >   drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
> > > > > > > >   1 file changed, 5 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > > > > > index 80d1e499a18d..501428437000 100644
> > > > > > > > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > > > > > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > > > > > @@ -312,6 +312,11 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
> > > > > > > >   		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
> > > > > > > >   		.swap		= true,
> > > > > > > >   		.sf		= scaling_factors_888,
> > > > > > > > +	}, {
> > > > > > > > +		.drm_fmt	= DRM_FORMAT_XRGB8888,
> > > > > > > > +		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
> > > > > > > > +		.swap		= true,
> > > > > > > > +		.sf		= scaling_factors_888,
> > > > > > > 
> > > > > > > I'm afraid that's not enough. There's a crucial difference between
> > > > > > > DRM_FORMAT_ARGB8888 (already supported by this driver) and
> > > > > > > DRM_FORMAT_XRGB8888: for the latter, the 'X' component must be ignored.
> > > > > > > The graphics layer is blended on top of the video layer, and the blender
> > > > > > > uses both a global alpha parameter and the alpha channel of the graphics
> > > > > > > layer for 32-bit RGB formats. This will lead to incorrect operation when
> > > > > > > the 'X' component is not set to full opacity.
> > > > > > 
> > > > > > I spent a few hours digging in the source code and what I could find in the
> > > > > > TRM and register maps, but there's not enough information in there to
> > > > > > explain how the blender works. The obvious "XRGB" implementation would be to
> > > > > > just disable the blender.
> > > > > > 
> > > > > > What I got from experimenting so far is that the alpha component is ignored
> > > > > > anyway while the video path isn't active. So as long as one isn't using the
> > > > > > video blending path, the ARGB and XRGB modes are identical.
> > > > > > 
> > > > > > Guess I'll need assistance from AMD/Xilinx to completely implement the XRGB
> > > > > > modes.
> > > > > > 
> > > > > > (For our application, this patch is sufficient as it solves the issues like
> > > > > > X11 not starting up, OpenGL not working and horrendously slow scaling
> > > > > > performance)
> > > > > 
> > > > > Given that we consider XRGB8888 mandatory,
> > > > 
> > > > How about platforms that can't support it at all ?
> > > 
> > > We emulate it.
> > 
> > Does that imply a full memcpy of the frame buffer in the kernel driver,
> > or is it emulated in userspace ?
> 
> Neither :)
> 
> The kernel deals with it through drm_fb_xrgb8888_to_* helpers, but only
> on the parts of the framebuffer that were modified through the damage
> API.

Aahhh OK, it's for the fbdev emulation. So that means that drivers are
not required to support XRGB8888 ?


-- 
Regards,

Laurent Pinchart

