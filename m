Return-Path: <linux-kernel+bounces-797212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F812B40D79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3291881D2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE8322775;
	Tue,  2 Sep 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DlS4b9LX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4434573D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839578; cv=none; b=eka4es4MAz/BwKnbPmCAt90r6gxRpCJkCBtyS9fjg4mJfXHBlourVZoKoqZktZjmWDrd3fLy4FQIS5YiBgwYjMDuViPhI3gg14Yt2d0OQ2WVewUCpc68D9KjRwGI+Bii5rkarxPxeMvozc0t9qQs+u82Mjs/mkE2RhgRwa/fxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839578; c=relaxed/simple;
	bh=ydS3fHo6dtfRbbLr6ELgLFSahEylegh68Q+lf3A8SFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrI53dc0M9PLOSEpb+vkJas2/Ky7sdPqdezcuNfvEi1jRKBfMp4p9IXtnb0VsGy/7IyI4RkkscJeMfxSpu0cgkzctqpR1DrdTD90IeHbf7Alj+MTpHsA9+lCvWKI3Bb+SLPmu/tv8HtMXRxOswFmqi2vBaEZegTT0p476kNsnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DlS4b9LX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (230.215-178-91.adsl-dyn.isp.belgacom.be [91.178.215.230])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 8A435C71;
	Tue,  2 Sep 2025 20:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756839505;
	bh=ydS3fHo6dtfRbbLr6ELgLFSahEylegh68Q+lf3A8SFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlS4b9LXRtDUSjyt3eLr5ahWc64vi6B0sGQ6BmSCoF9e+car+qYeX7tI4SSVgxr44
	 BhHmyLzMWhxAOY57kx1++Ungr5J5FPaDML0W87GZeBpoF1HbbzJH2GRGrjgGvDCpEf
	 4Yag2dtqKt2z43EiyGGyGi03ULbXMOApUElnxlfw=
Date: Tue, 2 Sep 2025 20:59:12 +0200
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
Subject: Re: [PATCH 01/29] drm/atomic: Document atomic state lifetime
Message-ID: <20250902185912.GP13448@pendragon.ideasonboard.com>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-1-14ad5315da3f@kernel.org>
 <d807d181-6b14-4711-b297-72dcd49b4937@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d807d181-6b14-4711-b297-72dcd49b4937@suse.de>

On Tue, Sep 02, 2025 at 03:08:12PM +0200, Thomas Zimmermann wrote:
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > How drm_atomic_state structures and the various entity structures are

"entity" isn't commonly used in this sense in DRM/KMS. "object" is the
best term I can think so, even if some DRM objects (in the
drm_mode_object sense) are out of scope in this context. Same below
where you use "entity".

> > allocated and freed isn't really trivial, so let's document it.
> 
> Thanks for doing this.
> 
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   Documentation/gpu/drm-kms.rst |  6 ++++++
> >   drivers/gpu/drm/drm_atomic.c  | 45 +++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 51 insertions(+)
> >
> > diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> > index abfe220764e1edc758a6bc6fb5ff9c8e1c7749ff..dc0f61a3d29e752889077d855a4bea381f2e2c18 100644
> > --- a/Documentation/gpu/drm-kms.rst
> > +++ b/Documentation/gpu/drm-kms.rst
> > @@ -280,10 +280,16 @@ structure, ordering of committing state changes to hardware is sequenced using
> >   :c:type:`struct drm_crtc_commit <drm_crtc_commit>`.
> >   
> >   Read on in this chapter, and also in :ref:`drm_atomic_helper` for more detailed
> >   coverage of specific topics.
> >   
> > +Atomic State Lifetime
> > +---------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/drm_atomic.c
> > +   :doc: state lifetime
> > +
> >   Handling Driver Private State
> >   -----------------------------
> >   
> >   .. kernel-doc:: drivers/gpu/drm/drm_atomic.c
> >      :doc: handling driver private state
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index cd15cf52f0c9144711da5879da57884674aea9e4..b356d26faad4acaa25c1fe6f9bd5043b6364ce87 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -44,10 +44,55 @@
> >   #include <drm/drm_writeback.h>
> >   
> >   #include "drm_crtc_internal.h"
> >   #include "drm_internal.h"
> >   
> > +/**
> > + * DOC: state lifetime
> > + *
> > + * &struct drm_atomic_state represents an update to video pipeline state.
> > + *
> > + * Its lifetime is:

This indicates you'll talk about the lifetime of drm_atomic_state
itself, while the text below also covers the lifetime of the state of
the individual objects. This is a bit confusing. One of the important
aspects that I think you should document is that drm_atomic_state is a
transient object that holds a state update (I once proposed renaming it
to drm_atomic_commit, and to my surprise the idea wasn't rejected right
away, but it would cause lots of churn) in the form of pointers to
individual objects' states, and only exists for the duration of an
atomic commit operation, while object states have a different lifetime.

> > + *
> > + * - at reset time, the entity reset implementation will allocate a
> > + *   new, default, state and will store it in the entity state pointer.

Strictly speaking, this isn't related to the drm_atomic_state lifetime.

> Can you somehow mention drm_mode_config_reset() here? 'Reset time' might 
> be too abstract.
> 
> > + *
> > + * - whenever a new update is needed:
> > + *
> > + *   + we allocate a new &struct drm_atomic_state using drm_atomic_state_alloc().
> > + *
> > + *   + we copy the state of each affected entity into our &struct
> > + *     drm_atomic_state using drm_atomic_get_plane_state(),
> > + *     drm_atomic_get_crtc_state(), drm_atomic_get_connector_state(), or
> > + *     drm_atomic_get_private_obj_state(). That state can then be
> > + *     modified.
> > + *
> > + *     At that point, &struct drm_atomic_state stores three state
> > + *     pointers for that particular entity: the old, new, and existing
> > + *     (called "state") states. The old state is the state currently
> > + *     active in the hardware, ie either the one initialized by reset()
> 
> 'ie' should be replaced by 'which is'. AFAIK ie is used like this: 
> (i.e., ...).
> 
> > + *     or a newer one if a commit has been made. The new state is the
> > + *     state we just allocated and we might eventually commit to the
> > + *     hardware. The existing state points to the state we'll eventually
> > + *     have to free, the new state for now.
> 
> That final sentence is confusing. What are we doing with the existing 
> state? Will the old state ever become the existing state? You also never 
> explain this below.
> 
> Maybe only focus on the old and new state for now and explain the 
> meaning of the existing state in a separate bullet point.

I agree, the documentation here is clear for someone who knows exactly
how things work, but quite confusing for a newcomer.

> > + *
> > + *   + Once we run a commit, it is first checked and if the check is
> > + *     successful, it is committed. Part of the commit is a call to

"Committing a commit" sounds weird. As you define the atomic state above
as "an update to video pipeline state", I would write

  After the state is populated, it is checked. If the check is successful, the
  state update is then committed.

> > + *     drm_atomic_helper_swap_state() which will turn the new state into
> > + *     the active state. Doing so involves updating the entity state
> > + *     pointer (&drm_crtc.state or similar) to point to the new state,
> > + *     and the existing state will now point to the old state, that used
> > + *     to be active but isn't anymore.
> > + *
> > + *   + When the commit is done, and when all references to our &struct
> > + *     drm_atomic_state are put, drm_atomic_state_clear() runs and will
> > + *     free all the old states.
> > + *
> > + *   + Now, we don't have any active &struct drm_atomic_state anymore,
> > + *     and only the entity active states remain allocated.
> > + */
> > +
> >   void __drm_crtc_commit_free(struct kref *kref)
> >   {
> >   	struct drm_crtc_commit *commit =
> >   		container_of(kref, struct drm_crtc_commit, ref);
> >   

-- 
Regards,

Laurent Pinchart

