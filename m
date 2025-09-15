Return-Path: <linux-kernel+bounces-817372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D1B58164
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE31202EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064062367BF;
	Mon, 15 Sep 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x4Pdobj0"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BB2DC786
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951917; cv=none; b=kjzzvF+qIQ5yFRyYqvR10ZXy4mRejXre9WpHSyF3vFRHoR6Xdfmwd2S5F2Uga6sMqyGetaX3I240OYbeB/8+MfNLOXf/x/8Vg0BJl3/BnspDji8EPUC30wPwk3xFjZIormP4p4JoRTE0B/MwsplZdH0H/TwRCu15kYz1ZDpZlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951917; c=relaxed/simple;
	bh=XgZwLsglGazDQIGAEWOdcUILG780w7iP0hbpgVxGkpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBj/SfCSAgRDfZ/dhouYwwCiNR/pv3w7wvR+P9B7MUtxny3LK84aCHM6lwuUMvhRAkwyn/6oos7TU2Oj9u+gwIGM+h4WKb1BoZENqmTShvRidXm1qaUxKglApTGHpE7Vslu0gHcx6XZZ9LR26YoT0c+lz3HkzZIkhQTHqt49VHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x4Pdobj0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8EDD31A0E25;
	Mon, 15 Sep 2025 15:58:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F8586063F;
	Mon, 15 Sep 2025 15:58:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CAA2102F2A5C;
	Mon, 15 Sep 2025 17:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757951911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DamnrMPL+mXDLfGrUw/hnqqyh2Urrlm64DKRH83FzbA=;
	b=x4Pdobj0zrZkumQ8rF0dGvCIOsihT6/tmEvJOSyK4ZM0dL/TEFffUsWfNHpA7tCnZz0rHY
	ExaPG8VC8y1PjnbyfB7XnWAEIz4TkImhBHb4IKjMRMm8ZZyEgTKXoArnZPj6QGAkVIJH0H
	IIshDWowrJo0o6E4Qj4bAE+bmOu0ZLKHwPfybuNEM2HA+rXIqVe0nSF01e2O8xQnIXYSkv
	37ShdxkQoV3IIJRYSlJ66AmfcAlGv0A+JgYl2xlCzlQlSXQ238ykgpGR+RUAst5M9VW6tH
	9rvsThszzjgCcqgxGhPD+tl7fpmY+TlomeJ0GcyyTukkii93hp4ksi0OVYd1tg==
Date: Mon, 15 Sep 2025 17:58:05 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Chaoyi Chen
 <chaoyi.chen@rock-chips.com>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 7/9] drm/bridge: remove
 drm_for_each_bridge_in_chain()
Message-ID: <20250915175805.6e8df6ef@booty>
In-Reply-To: <20250915-optimal-hornet-of-potency-efa54a@penduick>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
	<20250808-drm-bridge-alloc-getput-for_each_bridge-v2-7-edb6ee81edf1@bootlin.com>
	<20250915-optimal-hornet-of-potency-efa54a@penduick>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 15 Sep 2025 14:22:24 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> On Fri, Aug 08, 2025 at 04:49:14PM +0200, Luca Ceresoli wrote:
> > All users have been replaced by drm_for_each_bridge_in_chain_scoped().
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  .clang-format            |  1 -
> >  include/drm/drm_bridge.h | 14 --------------
> >  2 files changed, 15 deletions(-)
> > 
> > diff --git a/.clang-format b/.clang-format
> > index 1cac7d4976644c8f083f801e98f619782c2e23cc..d5c05db1a0d96476b711b95912d2b82b2e780397 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -167,7 +167,6 @@ ForEachMacros:
> >    - 'drm_connector_for_each_possible_encoder'
> >    - 'drm_exec_for_each_locked_object'
> >    - 'drm_exec_for_each_locked_object_reverse'
> > -  - 'drm_for_each_bridge_in_chain'
> >    - 'drm_for_each_bridge_in_chain_scoped'
> >    - 'drm_for_each_connector_iter'
> >    - 'drm_for_each_crtc'
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index a8e2f599aea764c705da3582df0ca428bb32f19c..6adf9221c2d462ec8e0e4e281c97b39081b3da24 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -1358,20 +1358,6 @@ drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
> >  						       struct drm_bridge, chain_node));
> >  }
> >  
> > -/**
> > - * drm_for_each_bridge_in_chain() - Iterate over all bridges present in a chain
> > - * @encoder: the encoder to iterate bridges on
> > - * @bridge: a bridge pointer updated to point to the current bridge at each
> > - *	    iteration
> > - *
> > - * Iterate over all bridges present in the bridge chain attached to @encoder.
> > - *
> > - * This is deprecated, do not use!
> > - * New drivers shall use drm_for_each_bridge_in_chain_scoped().
> > - */
> > -#define drm_for_each_bridge_in_chain(encoder, bridge)			\
> > -	list_for_each_entry(bridge, &(encoder)->bridge_chain, chain_node)
> > -  
> 
> I think I'd go a step further and rename
> drm_for_each_bridge_in_chain_scoped to drm_for_each_bridge_in_chain,
> there's no need to have a "scoped" variant if it's our only variant.
> 
> It can be done in a subsequent patch though.

Sure, that's the plan. There's a note in patch 3:

Note 1: drm_for_each_bridge_in_chain_scoped() could be renamed removing the
        _scoped suffix after removing all the users of the current macro
        and eventually the current macro itself. Even though this series is
        converting all users, I'd at least wait one kernel release before
        renaming, to minimize issues with existing patches which would fail
        building.

> For the entire series:
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Great, thanks!

I'll wait a few more days before applying.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

