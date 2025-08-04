Return-Path: <linux-kernel+bounces-755686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285EB1AA62
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6A417F6A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97D2376F2;
	Mon,  4 Aug 2025 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tiUFuGKe"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC31C1F02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343252; cv=none; b=olbT1I4iO9KuK0StSz6LKMzR42g6W+rxiLU2tlyea29fxp0DIq3BWR+Riuo5vIMZrR+Q1kJOlILzCmYceQUE4wA0+rbDrNKwDGTBcamqWWulZlOIXOkSL3ISOYzZUjRy6lZNcE2flYhDoy0fl80SMaZsHpUGTBPEVxixwH0ZvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343252; c=relaxed/simple;
	bh=fTo77DFAznBBbINTAIa2yC0WD6SLTQsGPZ0BSJTmp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=golAhRqscgPuOGpnDkOmVAmK/YZK/O/jBk5cqdad0PbjwWynP0yoGcqG/CAeujaNW5KfsnhZpL3u8rgk1JMkvTrQGOlTHWJ8AgtYuwVy6RR3LFjCx7837r8sCicwo5xlCIrJjPJDpvyTE//Imr2bQ9zhB+W4l8NnrboU650UnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tiUFuGKe; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 75EAB9CE;
	Mon,  4 Aug 2025 23:33:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1754343194;
	bh=fTo77DFAznBBbINTAIa2yC0WD6SLTQsGPZ0BSJTmp4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiUFuGKegE+juoRIdYAS6/lJNVkyK1LNXwV4ie0s1KNamBp0KWgM7X0eWerWwUUT/
	 feqqUsuIQjciVUN5oXIkChm/cetFB9YC/SDYfyOK12g8wnYoO2LYsM66dseS1n06mE
	 z3WTGMe5X0gAawZO75+Wt/+RuXcDhancPHI9P368=
Date: Tue, 5 Aug 2025 00:33:47 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: sukrut heroorkar <hsukrut3@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] drm/drm_bridge: Document 'connector' parameter in
 drm_bridge_detect()
Message-ID: <20250804213347.GI30355@pendragon.ideasonboard.com>
References: <20250802161309.1198855-1-hsukrut3@gmail.com>
 <20250803165611.GG4906@pendragon.ideasonboard.com>
 <CAHCkknr+w3B0NWM065Rr_d9n9QEak7YmhehByQTdfwYr30RbSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCkknr+w3B0NWM065Rr_d9n9QEak7YmhehByQTdfwYr30RbSQ@mail.gmail.com>

On Mon, Aug 04, 2025 at 11:24:58PM +0200, sukrut heroorkar wrote:
> On Sun, Aug 3, 2025 at 6:56 PM Laurent Pinchart wrote:
> > On Sat, Aug 02, 2025 at 06:13:05PM +0200, Sukrut Heroorkar wrote:
> > > drm: drm_bridge: fix missing parameter documentation
> > >
> > > The function documentation was missing description for the
> > > parameter 'connector'.
> > >
> > > Add missing function parameter documentation for drm_bridge_detect()
> > > to fix kernel-doc warnings.
> > >
> > > Warning: drivers/gpu/drm/drm_bridge.c:1241 function parameter 'connector' not described in 'drm_bridge_detect'
> > >
> >
> > A Fixes: tag would be nice.
> >
> > > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_bridge.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > > index dd45d9b504d8..387a3b6cda54 100644
> > > --- a/drivers/gpu/drm/drm_bridge.c
> > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > @@ -1227,6 +1227,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
> > >  /**
> > >   * drm_bridge_detect - check if anything is attached to the bridge output
> > >   * @bridge: bridge control structure
> > > + * @connector: connector associated with the bridge
> >
> > "associated with the bridge" isn't very clear.
> >
> > >   *
> > >   * If the bridge supports output detection, as reported by the
> > >   * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect for the
> 
> Thanks for the review.
> I will send a V2 shortly with updated connector description and Fixes
> tag, as suggested.

It appears that a competing patch got merged in the meantime:
https://lore.kernel.org/r/20250716125602.3166573-1-andyshrk@163.com

It was submitted earlier than yours, and the usual rule in the kernel is
that the first patch wins when there are multiple similar or identical
submissions.

-- 
Regards,

Laurent Pinchart

