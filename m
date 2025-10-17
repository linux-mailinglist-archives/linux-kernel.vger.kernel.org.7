Return-Path: <linux-kernel+bounces-858112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E0BE8F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECCD3BBD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD072F6926;
	Fri, 17 Oct 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tx/lfZCQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEE2F691E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708517; cv=none; b=fR4a+G0PdFBvnNDWnUg3yX08qhOeQLKC3cmOZPJ7g3rd0LuuR78nTts1Txa3pSZDTu8URb7+5ZkDyLL4eQyAFKScyc7LHi3/ydFcYunilnNVSkAq/ZjK4t+4c4Rg260xui6ugz01A8t6j755GnGh8LBnv9/oxB2qPY7CCoRLuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708517; c=relaxed/simple;
	bh=uIHNs/fXIfldAO46Ff+IF8LZL7G27sRVkUza86d0Ih4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpAnWNUjhUKeJm7R36OJf96CRx5VWckFpKvVHhJVlxEjnn0rATrVX07RK8v3rNnFlhVftsa2v2OnBLLvQiVKFD9JgaJyBU/+hThdQ0BEplhclk95PFi8WViUEJWp2MZm1Z9tInrP5cuI25uTK4NlTq+fBdV9SsxCR3e7DtxI+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Tx/lfZCQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3414872a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1760708514; x=1761313314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tH2H8eAt58gE8KrC75AA+IjAWbJPnifDl1L9ov4LbGs=;
        b=Tx/lfZCQbTfLjsrASPhHbs82Vhv9IpVQwDnJWlbYCFdC1SUbTGla8SW1g6RJhYmiAU
         GIZqQ3aTf0PcpitLU2j3eO5/+3uCR+BpOpFcfQHMQK1Usz7XEBWKy/gCjZwdmNGTiikh
         HEP2EIST80eEwugo0koneqUdsTi8qMVDxvgY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760708514; x=1761313314;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH2H8eAt58gE8KrC75AA+IjAWbJPnifDl1L9ov4LbGs=;
        b=kn5i6vxWNuQMN0TOTgZJL37vUCrF26O3FEq0GBH9gZ3dTtPP9jxxnyluyz4F9xffz0
         Pi6Tg/2MHBoDUNHSY6S268I9/alzRnC3Ma8b3hiwHqx0qqNMNkkrYTbsg1d+3E/Krk3D
         IkEgK1aSZa20hVEXiw6zOHi+VJOm4IeAHS8XJP0wOFXj650gM5icT6NK2cn90YeE+P1Z
         DvgEVtwaLqmSoFjLwlXgn7JE8tPUUPZ4lPCt/lbjspFSgO23ejjNP57xrW1peC+TWjgs
         6qU40L2ZbPa39WCIsAMWSmWpmuR5Bwq7mH7fp2gJIZZWU2JJcdgv2Cgh8IcDUph0d2v3
         Tmhw==
X-Forwarded-Encrypted: i=1; AJvYcCVRit6JeUfukt3wdVI8IpVGYF9Qa682EOsqjAYx3lP3inSRIILSnEqWkOp8TR8gVGvWhBu003EXc0djUfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJ0ViCqXR6+zq2fhAl0APSWIw0K6XaZYAC7tQv7jNQrciD9WQ
	wqUMl49jTny91YVecp5TX/75WxPlSlrHm+J3QJURW7C0/G+0Bd/CA/yJtQ75tMWY4uU=
X-Gm-Gg: ASbGncvTvygtCWLukDYeYABiSymqwh+jolgRf40sz3D78wY/mB/ejyVNCZgrg/AC4FH
	EJ0dlO78qbtQ9zVwpPVI0YVVbsLvFltTz+EHdo4bQg288XlSqQ6hwfu/g5JQPCslnwoJLhdEbJ9
	lCAsb51dAlxiTRyis4D9eMVJgKiVX3BXfHxSzpEAYglGQRons3BbmnkGNjkzmJ5+m3Rouagzj2Y
	8SNRopTnaIF/EkDSV+hOKaqXPeaTGluWXqoauYhWV8L98ZfoG31EjmHqxpuO3XbMJOxMXqxEJsD
	xEFqAg3NA3UuoeOPDlpfj1PP0vLteE7bZaDRVSutAlo7NxVIfLieEmk7/GZvLKgOLk5JXv/U06y
	j1StN/vzjz9heNbU8IUlbbjZ51KlRn+46BW+jjbP013uwOvCUW8jVNguwnQuHweOK2Ya/dInwug
	98OkWWq6vu0WnBGaeTbmz26Q==
X-Google-Smtp-Source: AGHT+IETEQAv9ilKZHQqJwOJMs5gIz3I7I9h8E/Uz17nC4vGTfipIeU2J6GLFYX65rwKY2jzgl6P0g==
X-Received: by 2002:a05:6402:13d3:b0:634:b4cb:c892 with SMTP id 4fb4d7f45d1cf-63c1f6f5e21mr3627804a12.32.1760708513542;
        Fri, 17 Oct 2025 06:41:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63b6b1f5b24sm16979673a12.20.2025.10.17.06.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:41:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:41:50 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
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
Message-ID: <aPJHnoazyhrYBMI0@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 02, 2025 at 10:32:38AM +0200, Maxime Ripard wrote:
> In order to enable drivers to fill their initial state from the hardware
> state, we need to provide an alternative atomic_reset helper.
> 
> This helper relies on each state having its own atomic_state_readout()
> hooks. Each component will thus be able to fill the initial state based
> on what they can figure out from the hardware.
> 
> It also allocates a dummy drm_atomic_state to glue the whole thing
> together so atomic_state_readout implementations can still figure out
> the state of other related entities.
> 
> Link: https://lore.kernel.org/dri-devel/CAKMK7uHtqHy_oz4W7F+hmp9iqp7W5Ra8CxPvJ=9BwmvfU-O0gg@mail.gmail.com/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Ok, design feedback. First, I like your approach better than what I've
originally done in i915. To explain why, a bit of history:

Originally struct drm_atomic_state was really meant as a state container,
and not as an atomic commit that both tracks the old and new state. This
turned out to be a mistake, and we've partially fixed things up. Some of
the key changes:

- We've dropped passing explicit states to callbacks and instead just pass
  the entire transaction container, so that callbacks can fish out
  old/new states as they wish. The old design passed in the other state,
  which depending upon where in the commit sequence you were, meant either
  the old or the new state. This confused people to no end.

  One reason for this is the obj_state->state backpointer to
  drm_atomic_state - that is only valid as long as the state is part of a
  transaction and not when it's either a committed state, or when it's a
  read-out state. Too much code to delete that backpointer now, but I
  think that was a big mistake I've made in the design of atomic.

- We really should rename struct drm_atomic_state to
  drm_atomic_transaction or something like that. But well, it'd be super
  invasive.

- This also means that using drm_atomic_state as a general container for
  atomic states for the state readout purpose doesn't make sense anymore,
  because it's a transaction now, not a container. This also means that
  some of the backpointer clearing you're doing is messy at best (which I
  guess is another reason why trying to reuse ->reset callbacks is not a
  great idea).

I think what would be cleaner for state readout/comparison is if you push
this design to it's conclusion:

- Create a new struct drm_atomic_state_readout container which only has a
  single set of states per object, not old/new like our atomic transaction
  state. With that there's no confusion anymore why you need a stand-alone
  container for your readout, it's really what the design is meant to be.

- Just pass in that container to all state readout callbacks and let them
  fish out states they need themselves. This would be similar to what
  we've done with other callbacks.

- The latter point makes even more sense when you demidlayer this flow a
  bit and split out the individual phases: Some drivers will need to read
  out crtc before encoders, some will need to interleave by calling them
  multiple times (like we do with atomic_check in some drivers already),
  some will need to peak at already read-out states of other objects. With
  a true free-standing drm_atomic_readout_state container that's all a
  lot more doable and cleaner than by trying to wrestle the transaction
  container into working for this case too.

The downside is that it'll be a bunch of typing of very similar code that
we already have for drm_atomic_state to iterate over states and get them
(if they're set already). But I think that clear split between atomic
transactions and atomic state readout would be a real bonus in making
things not so clunky and easier to read.

I hope this makes some sense ...

Cheers, Sima


> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 382 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c   |   1 +
>  include/drm/drm_atomic_helper.h     |   1 +
>  include/drm/drm_bridge.h            |  21 ++
>  include/drm/drm_connector.h         |  26 +++
>  include/drm/drm_crtc.h              |  19 ++
>  include/drm/drm_plane.h             |  27 +++
>  7 files changed, 477 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index d5ebe6ea0acbc5a08aef7fa41ecb9ed5d8fa8e80..f59512476ebf2b48e1c7034950bcaf99237f03c6 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -45,10 +45,392 @@
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_writeback.h>
>  
>  #include "drm_crtc_helper_internal.h"
>  #include "drm_crtc_internal.h"
> +#include "drm_internal.h"
> +
> +static void drm_atomic_set_old_plane_state(struct drm_atomic_state *state,
> +					   struct drm_plane *plane,
> +					   struct drm_plane_state *plane_state)
> +{
> +	int idx = drm_plane_index(plane);
> +
> +	state->planes[idx].old_state = plane_state;
> +	state->planes[idx].ptr = plane;
> +
> +	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
> +		       plane->base.id, plane->name, plane_state, state);
> +}
> +
> +static void drm_atomic_set_old_crtc_state(struct drm_atomic_state *state,
> +					  struct drm_crtc *crtc,
> +					  struct drm_crtc_state *crtc_state)
> +{
> +	int idx = drm_crtc_index(crtc);
> +
> +	state->crtcs[idx].old_state = crtc_state;
> +	state->crtcs[idx].ptr = crtc;
> +
> +	drm_dbg_atomic(state->dev, "Added [CRTC:%d:%s] %p state to %p\n",
> +		       crtc->base.id, crtc->name, crtc_state, state);
> +}
> +
> +static void drm_atomic_set_old_connector_state(struct drm_atomic_state *state,
> +					       struct drm_connector *conn,
> +					       struct drm_connector_state *conn_state)
> +{
> +	int idx = drm_connector_index(conn);
> +
> +	drm_connector_get(conn);
> +	state->connectors[idx].old_state = conn_state;
> +	state->connectors[idx].ptr = conn;
> +	state->num_connector++;
> +
> +	drm_dbg_atomic(conn->dev,
> +		       "Added [CONNECTOR:%d:%s] %p state to %p\n",
> +		       conn->base.id, conn->name, conn_state, state);
> +}
> +
> +static void drm_atomic_set_old_private_obj_state(struct drm_atomic_state *state,
> +						 struct drm_private_obj *obj,
> +						 struct drm_private_state *obj_state)
> +{
> +	int idx = state->num_private_objs;
> +
> +	memset(&state->private_objs[idx], 0, sizeof(*state->private_objs));
> +	state->private_objs[idx].old_state = obj_state;
> +	state->private_objs[idx].ptr = obj;
> +	state->num_private_objs++;
> +
> +	drm_dbg_atomic(state->dev,
> +		       "Added new private object %p state %p to %p\n", obj,
> +		       obj_state, state);
> +}
> +
> +static void drm_atomic_set_old_bridge_state(struct drm_atomic_state *state,
> +					    struct drm_bridge *bridge,
> +					    struct drm_bridge_state *bridge_state)
> +{
> +	drm_atomic_set_old_private_obj_state(state, &bridge->base, &bridge_state->base);
> +}
> +
> +static struct drm_connector_state *
> +find_connector_state_for_encoder(struct drm_atomic_state *state,
> +				struct drm_encoder *encoder)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +
> +	drm_connector_list_iter_begin(state->dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *conn_state =
> +			drm_atomic_get_old_connector_state(state, connector);
> +
> +		if (WARN_ON(!conn_state))
> +			continue;
> +
> +		if (encoder == conn_state->best_encoder)
> +			return conn_state;
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return NULL;
> +}
> +
> +/**
> + * drm_atomic_helper_install_readout_state - Sets the state pointer from their readout state
> + * @state: drm_atomic_state to initialize the DRM device with.
> + *
> + * This function takes a &struct drm_atomic_state initialized by
> + * drm_atomic_build_readout_state() and sets up the entities state
> + * pointers (ie, &drm_crtc.state and similar) to properly setup the
> + * initial state.
> + */
> +static void
> +drm_atomic_helper_install_readout_state(struct drm_atomic_state *state)
> +{
> +	struct drm_connector_state *old_conn_state;
> +	struct drm_private_state *old_obj_state;
> +	struct drm_plane_state *old_plane_state;
> +	struct drm_crtc_state *old_crtc_state;
> +	struct drm_connector *connector;
> +	struct drm_private_obj *obj;
> +	struct drm_plane *plane;
> +	struct drm_crtc *crtc;
> +	unsigned int i;
> +
> +	for_each_old_connector_in_state(state, connector, old_conn_state, i) {
> +		connector->state = old_conn_state;
> +
> +		drm_connector_put(state->connectors[i].ptr);
> +		state->connectors[i].ptr = NULL;
> +		state->connectors[i].old_state = NULL;
> +	}
> +
> +	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
> +		crtc->state = old_crtc_state;
> +
> +		state->crtcs[i].ptr = NULL;
> +		state->crtcs[i].old_state = NULL;
> +	}
> +
> +	for_each_old_plane_in_state(state, plane, old_plane_state, i) {
> +		plane->state = old_plane_state;
> +
> +		state->planes[i].ptr = NULL;
> +		state->planes[i].old_state = NULL;
> +	}
> +
> +	for_each_old_private_obj_in_state(state, obj, old_obj_state, i) {
> +		obj->state = old_obj_state;
> +
> +		state->private_objs[i].ptr = NULL;
> +		state->private_objs[i].old_state = NULL;
> +	}
> +}
> +
> +static unsigned int count_private_obj(struct drm_device *dev)
> +{
> +	struct drm_mode_config *config = &dev->mode_config;
> +	struct drm_private_obj *obj;
> +	unsigned int count = 0;
> +
> +	list_for_each_entry(obj, &config->privobj_list, head)
> +		count++;
> +
> +	return count;
> +}
> +
> +/**
> + * drm_atomic_build_readout_state - Creates an initial state from the hardware
> + * @dev: DRM device to build the state for
> + *
> + * This function allocates a &struct drm_atomic_state, calls the
> + * atomic_readout_state callbacks, and fills the global state old states
> + * by what the callbacks returned.
> + *
> + * Returns:
> + *
> + * A partially initialized &struct drm_atomic_state on success, an error
> + * pointer otherwise.
> + */
> +static struct drm_atomic_state *
> +drm_atomic_build_readout_state(struct drm_device *dev)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_atomic_state *state;
> +	struct drm_mode_config *config =
> +		&dev->mode_config;
> +	struct drm_connector *connector;
> +	struct drm_printer p =
> +		drm_info_printer(dev->dev);
> +	struct drm_encoder *encoder;
> +	struct drm_plane *plane;
> +	struct drm_crtc *crtc;
> +	int ret;
> +
> +	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n");
> +
> +	state = drm_atomic_state_alloc(dev);
> +	if (WARN_ON(!state))
> +		return ERR_PTR(-ENOMEM);
> +
> +	state->connectors = kcalloc(config->num_connector, sizeof(*state->connectors), GFP_KERNEL);
> +	if (WARN_ON(!state->connectors)) {
> +		ret = -ENOMEM;
> +		goto err_state_put;
> +	}
> +
> +	state->private_objs = kcalloc(count_private_obj(dev), sizeof(*state->private_objs), GFP_KERNEL);
> +	if (WARN_ON(!state->private_objs)) {
> +		ret = -ENOMEM;
> +		goto err_state_put;
> +	}
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		const struct drm_crtc_funcs *crtc_funcs =
> +			crtc->funcs;
> +		struct drm_crtc_state *crtc_state;
> +
> +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
> +
> +		if (crtc_funcs->atomic_readout_state) {
> +			crtc_state = crtc_funcs->atomic_readout_state(crtc);
> +		} else if (crtc_funcs->reset) {
> +			crtc_funcs->reset(crtc);
> +
> +			/*
> +			 * We don't want to set crtc->state field yet. Let's save and clear it up.
> +			 */
> +			crtc_state = crtc->state;
> +			crtc->state = NULL;
> +		} else {
> +			drm_warn(dev, "No CRTC readout or reset implementation.");
> +			continue;
> +		}
> +
> +		if (WARN_ON(IS_ERR(crtc_state))) {
> +			ret = PTR_ERR(crtc_state);
> +			goto err_state_put;
> +		}
> +
> +		drm_atomic_set_old_crtc_state(state, crtc, crtc_state);
> +	}
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		const struct drm_connector_funcs *conn_funcs =
> +			connector->funcs;
> +		struct drm_connector_state *conn_state;
> +
> +		drm_dbg_kms(dev, "Initializing Connector %s state.\n", connector->name);
> +
> +		if (conn_funcs->atomic_readout_state) {
> +			conn_state = conn_funcs->atomic_readout_state(connector, state);
> +		} else if (conn_funcs->reset) {
> +			conn_funcs->reset(connector);
> +
> +			/*
> +			 * We don't want to set connector->state field yet. Let's save and clear it
> +			 * up.
> +			 */
> +			conn_state = connector->state;
> +			connector->state = NULL;
> +		} else {
> +			drm_warn(dev, "No Connector readout or reset implementation.");
> +			continue;
> +		}
> +
> +		if (WARN_ON(IS_ERR(conn_state))) {
> +			ret = PTR_ERR(conn_state);
> +			goto err_state_put;
> +		}
> +
> +		drm_atomic_set_old_connector_state(state, connector, conn_state);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	WARN_ON(state->num_connector != config->num_connector);
> +
> +	drm_for_each_encoder(encoder, dev) {
> +		struct drm_connector_state *enc_conn_state;
> +		struct drm_crtc_state *enc_crtc_state;
> +		struct drm_bridge *bridge;
> +
> +		/*
> +		 * It works a bit differently for bridges. Because they are
> +		 * using a drm_private_state, and because
> +		 * drm_atomic_private_obj_init() asks for its initial state when
> +		 * initializing, instead of doing it later on through a reset
> +		 * call like the other entities, we can't have reset xor
> +		 * readout.
> +		 *
> +		 * We'll need a mandatory reset to create that initial, blank,
> +		 * state, and then readout will fill that state later on if the
> +		 * driver implements it.
> +		 *
> +		 * This also means we don't need to call the readout state
> +		 * function if we don't have the bridge enabled (ie, if no
> +		 * drm_connector_state->best_encoder points to bridge->encoder,
> +		 * and / or if drm_connector_state->crtc is NULL).
> +		 *
> +		 * In such a case, we would get the blank state reset created
> +		 * during registration.
> +		 */
> +
> +		enc_conn_state = find_connector_state_for_encoder(state, encoder);
> +		if (!enc_conn_state)
> +			continue;
> +
> +		enc_crtc_state = drm_atomic_get_old_crtc_state(state, enc_conn_state->crtc);
> +		if (!enc_crtc_state)
> +			continue;
> +
> +		list_for_each_entry(bridge, &encoder->bridge_chain, chain_node) {
> +			const struct drm_bridge_funcs *bridge_funcs = bridge->funcs;
> +			struct drm_bridge_state *bridge_state;
> +
> +			bridge_state = drm_bridge_get_current_state(bridge);
> +			if (WARN_ON(!bridge_state)) {
> +				ret = -EINVAL;
> +				goto err_state_put;
> +			}
> +
> +			if (bridge_funcs->atomic_readout_state) {
> +				ret = bridge_funcs->atomic_readout_state(bridge,
> +									 bridge_state,
> +									 enc_crtc_state,
> +									 enc_conn_state);
> +				if (WARN_ON(ret))
> +					goto err_state_put;
> +			}
> +
> +			drm_atomic_set_old_bridge_state(state, bridge, bridge_state);
> +		}
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		const struct drm_plane_funcs *plane_funcs =
> +			plane->funcs;
> +		struct drm_plane_state *plane_state;
> +
> +		drm_dbg_kms(dev, "Initializing Plane %s state.\n", plane->name);
> +
> +		if (plane_funcs->atomic_readout_state) {
> +			plane_state = plane_funcs->atomic_readout_state(plane, state);
> +		} else if (plane_funcs->reset) {
> +			plane_funcs->reset(plane);
> +
> +			/*
> +			 * We don't want to set conn->state field yet. Let's save and clear it up.
> +			 */
> +			plane_state = plane->state;
> +			plane->state = NULL;
> +		} else {
> +			drm_warn(dev, "No plane readout or reset implementation.");
> +			continue;
> +		}
> +
> +		if (WARN_ON(IS_ERR(plane_state))) {
> +			ret = PTR_ERR(plane_state);
> +			goto err_state_put;
> +		}
> +
> +		drm_atomic_set_old_plane_state(state, plane, plane_state);
> +	}
> +
> +	drm_atomic_print_old_state(state, &p);
> +
> +	return state;
> +
> +err_state_put:
> +	drm_atomic_state_put(state);
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * drm_atomic_helper_readout_state - Builds an initial state from hardware state
> + * @dev: DRM device to build the state for
> + *
> + * This function creates the initial state for all the entities on a
> + * @dev. Drivers can use this as their
> + * &drm_mode_config_helper_funcs.atomic_reset callback to implement
> + * hardware state readout suppport.
> + */
> +void drm_atomic_helper_readout_state(struct drm_device *dev)
> +{
> +	struct drm_atomic_state *state;
> +
> +	state = drm_atomic_build_readout_state(dev);
> +	if (IS_ERR(state))
> +		return;
> +
> +	drm_atomic_helper_install_readout_state(state);
> +	drm_atomic_state_put(state);
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_readout_state);
>  
>  /**
>   * DOC: overview
>   *
>   * This helper library provides implementations of check and commit functions on
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 82180760032d3490d63fe83136465d2c26551d08..96d38a49be501a0090457cbe96135f82bb1358b5 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -26,10 +26,11 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_managed.h>
> +#include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_print.h>
>  #include <linux/dma-resv.h>
>  
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index 53382fe93537bbcda9cee8827bc95de9a515efb5..47902a9181727a08581fb808faabe67d92a755cf 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -45,10 +45,11 @@
>  
>  struct drm_atomic_state;
>  struct drm_private_obj;
>  struct drm_private_state;
>  
> +void drm_atomic_helper_readout_state(struct drm_device *dev);
>  int drm_atomic_helper_check_modeset(struct drm_device *dev,
>  				struct drm_atomic_state *state);
>  int drm_atomic_helper_check_wb_connector_state(struct drm_connector *connector,
>  					       struct drm_atomic_state *state);
>  int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 8d9d4fd078e72977677fd992d725261232754e3e..15b63053f01869786831936ba28b7efc1e55e2e8 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -490,10 +490,31 @@ struct drm_bridge_funcs {
>  	 * The @atomic_post_disable callback is optional.
>  	 */
>  	void (*atomic_post_disable)(struct drm_bridge *bridge,
>  				    struct drm_atomic_state *state);
>  
> +	/**
> +	 * @atomic_readout_state:
> +	 *
> +	 * Initializes,this bridge atomic state.
> +	 *
> +	 * It's meant to be used by drivers that wants to implement fast
> +	 * / flicker-free boot and allows to initialize the atomic state
> +	 * from the hardware state left by the firmware.
> +	 *
> +	 * It's used at initialization time, so drivers must make sure
> +	 * that the power state is sensible when accessing the hardware.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * 0 on success, an error code otherwise.
> +	 */
> +	int (*atomic_readout_state)(struct drm_bridge *bridge,
> +				    struct drm_bridge_state *bridge_state,
> +				    struct drm_crtc_state *crtc_state,
> +				    struct drm_connector_state *conn_state);
> +
>  	/**
>  	 * @atomic_duplicate_state:
>  	 *
>  	 * Duplicate the current bridge state object (which is guaranteed to be
>  	 * non-NULL).
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 8f34f4b8183d83dccd3e820a444fbf74fb6c16f2..f68bd9627c085c6d2463b847aaa245ccc651f27b 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1464,10 +1464,36 @@ struct drm_connector_funcs {
>  	 * when a connector is being hot-unplugged for drivers that support
>  	 * connector hotplugging (e.g. DisplayPort MST).
>  	 */
>  	void (*destroy)(struct drm_connector *connector);
>  
> +	/**
> +	 * @atomic_readout_state:
> +	 *
> +	 * Allocates, initializes, and returns an atomic state for this
> +	 * connector.
> +	 *
> +	 * It's meant to be used by drivers that wants to implement fast
> +	 * / flicker-free boot and allows to initialize the atomic state
> +	 * from the hardware state left by the firmware.
> +	 *
> +	 * It's used at initialization time, so drivers must make sure
> +	 * that the power state is sensible when accessing the hardware.
> +	 *
> +	 * The drm_atomic_state being passed is not fully filled. Only
> +	 * the CRTC state are there when this hooks is called, and only
> +	 * their old state. The only safe operation one can do on this
> +	 * state in this hook is calling
> +	 * drm_atomic_get_old_crtc_state().
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * An atomic state on success, an error pointer otherwise.
> +	 */
> +	struct drm_connector_state *(*atomic_readout_state)(struct drm_connector *connector,
> +							    struct drm_atomic_state *state);
> +
>  	/**
>  	 * @atomic_duplicate_state:
>  	 *
>  	 * Duplicate the current atomic state for this connector and return it.
>  	 * The core and helpers guarantee that any atomic state duplicated with
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index caa56e039da2a748cf40ebf45b37158acda439d9..c462bd9b2f7d3ae08e669463717002e5f78122fe 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -613,10 +613,29 @@ struct drm_crtc_funcs {
>  	 * 0 on success or a negative error code on failure.
>  	 */
>  	int (*set_property)(struct drm_crtc *crtc,
>  			    struct drm_property *property, uint64_t val);
>  
> +	/**
> +	 * @atomic_readout_state:
> +	 *
> +	 * Allocates, initializes, and returns an atomic state for this
> +	 * CRTC.
> +	 *
> +	 * It's meant to be used by drivers that wants to implement fast
> +	 * / flicker-free boot and allows to initialize the atomic state
> +	 * from the hardware state left by the firmware.
> +	 *
> +	 * It's used at initialization time, so drivers must make sure
> +	 * that the power state is sensible when accessing the hardware.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * An atomic state on success, an error pointer otherwise.
> +	 */
> +	struct drm_crtc_state *(*atomic_readout_state)(struct drm_crtc *crtc);
> +
>  	/**
>  	 * @atomic_duplicate_state:
>  	 *
>  	 * Duplicate the current atomic state for this CRTC and return it.
>  	 * The core and helpers guarantee that any atomic state duplicated with
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 01479dd94e76a8389a0c9e9d6744400aa2291064..691a267c857a228f674ef02a63fb6d1ff9e379a8 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -378,10 +378,37 @@ struct drm_plane_funcs {
>  	 * 0 on success or a negative error code on failure.
>  	 */
>  	int (*set_property)(struct drm_plane *plane,
>  			    struct drm_property *property, uint64_t val);
>  
> +	/**
> +	 * @atomic_readout_state:
> +	 *
> +	 * Allocates, initializes, and returns an atomic state for this
> +	 * plane.
> +	 *
> +	 * It's meant to be used by drivers that wants to implement fast
> +	 * / flicker-free boot and allows to initialize the atomic state
> +	 * from the hardware state left by the firmware.
> +	 *
> +	 * It's used at initialization time, so drivers must make sure
> +	 * that the power state is sensible when accessing the hardware.
> +	 *
> +	 * The drm_atomic_state being passed is not fully filled. Only
> +	 * the CRTC and connector states are there when this hooks is
> +	 * called, and only their old state. The only safe operation one
> +	 * can do on this state in this hook is calling
> +	 * drm_atomic_get_old_crtc_state() and
> +	 * drm_atomic_get_old_connector_state().
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * An atomic state on success, an error pointer otherwise.
> +	 */
> +	struct drm_plane_state *(*atomic_readout_state)(struct drm_plane *plane,
> +							struct drm_atomic_state *state);
> +
>  	/**
>  	 * @atomic_duplicate_state:
>  	 *
>  	 * Duplicate the current atomic state for this plane and return it.
>  	 * The core and helpers guarantee that any atomic state duplicated with
> 
> -- 
> 2.50.1
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

