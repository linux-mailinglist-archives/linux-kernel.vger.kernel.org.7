Return-Path: <linux-kernel+bounces-797242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A0B40DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD633B3316
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F82E54B0;
	Tue,  2 Sep 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bkYeAaTg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709162E6127
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841405; cv=none; b=baM1J+b8uIa/TwwAg6sCDVgbu46fJsRa43f1OIz9t9kd4oODnOHqfsF+yuUCWOKZsVMHo1FKpKBCI2h7eqj3Rg1QS3t6LkADDzXwP/J/3gkZAb39+VIPh3WF4MoWf0VZWpRburzzZ+8GfYJ1hkAOjkKk5npxKb+E9p7zA01qJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841405; c=relaxed/simple;
	bh=uubYWsLB8sHbJ6sg4su53nUp1k3XLRTGP2lt3u71QCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsW0RbrDUkdvAxwe6R/21JOY0opjCMA+lyj28beEsfeo46zo5GnQI5yzqsiQVsFitkdYkNIPtj8c+c0Gd1Wk2MozSqlDZpNk6SEyrMGZG5uD/EOC2+d/pspzdPMv3JdlKEgTRwxhgqhR9GsKnOUZVDJnohxo+ihfI6eUMmUMe1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bkYeAaTg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (230.215-178-91.adsl-dyn.isp.belgacom.be [91.178.215.230])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 469148BF;
	Tue,  2 Sep 2025 21:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756841333;
	bh=uubYWsLB8sHbJ6sg4su53nUp1k3XLRTGP2lt3u71QCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkYeAaTg/SyaEP1d9BCrHM0cdmikJ7k+Tvc3/DVxY3o8lNkxczQYu6ItqIGnlcdUw
	 bSFDZtIKmWtvsanhO8wJQbJPxlt0ewK/T6YBI4jy5/9MbXbXgPYdje6WlOSi2CeZCa
	 RI/BLA6BMZVPZXZU0br31o3NqDV994r5cAGXuXLQ=
Date: Tue, 2 Sep 2025 21:29:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/29] drm/atomic_helper: Skip over NULL private_obj
 pointers
Message-ID: <20250902192940.GS13448@pendragon.ideasonboard.com>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-4-14ad5315da3f@kernel.org>
 <adba0c39-228b-4311-83d1-09aa71ddb911@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adba0c39-228b-4311-83d1-09aa71ddb911@suse.de>

On Tue, Sep 02, 2025 at 03:13:30PM +0200, Thomas Zimmermann wrote:
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> However, can this happen? Private state objects without state data?

I was going to ask the same. The commit message should explain why.

> > ---
> >   drivers/gpu/drm/drm_atomic.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index b356d26faad4acaa25c1fe6f9bd5043b6364ce87..9b198610791d19c7fd276ca59264a961d21caf43 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -295,10 +295,13 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
> >   	}
> >   
> >   	for (i = 0; i < state->num_private_objs; i++) {
> >   		struct drm_private_obj *obj = state->private_objs[i].ptr;
> >   
> > +		if (!obj)
> > +			continue;
> > +
> >   		obj->funcs->atomic_destroy_state(obj,
> >   						 state->private_objs[i].state);
> >   		state->private_objs[i].ptr = NULL;
> >   		state->private_objs[i].state = NULL;
> >   		state->private_objs[i].old_state = NULL;

-- 
Regards,

Laurent Pinchart

