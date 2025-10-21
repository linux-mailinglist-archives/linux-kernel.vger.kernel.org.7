Return-Path: <linux-kernel+bounces-862512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85D4BF57F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FBD1888DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF341329C7C;
	Tue, 21 Oct 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Af6GZtjj"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F11B7F4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038840; cv=none; b=crRzuog83q1w6vLgo5uL1wpeTloRiEPDnUO25hsNhiB5CcnFZYZj4jJHrHrg5EX3qEZ2QwQ9l+L49DIyehBJk1nXUZ0+7UBY11rPwrbIlV118eblKcVgPIJz9dNT0ZYBGJMSRW0Urw+tpK0lD2cMbu9XT937qOe0Tgt10Q1WoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038840; c=relaxed/simple;
	bh=C3UFtYPvhCa/7kR/n6nBhvuRYdUyMeuCywmoKDG2E+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUf+PlMAgUtBY5CP7Y4KxLBeOepoQ+HOckEpJ7iDjfznQ3l2PJvhZOFdUFb8zueCHCDiGRfghmArJCf8GrxcZXem1rsSr9AZoda22S04SL0iSpZb9gY4yh2jL31GLWuMSxpKoVMVJIVE77SeQKm7cAgvj1GxnMoL0CbsGvob6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Af6GZtjj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1083070566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761038837; x=1761643637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fiak3iwfikjarVQ22RTf8mHmUiPs3Zv+6ZrupgeqTg=;
        b=Af6GZtjjuklVSjPNuHHrETPjdHNgBn4+0edspvFOBDkKxfl6lsP1BSx4KZoDJk/Jlq
         Xgv4LVZuTF1MBgg4BUVVnpiLfZ2PclAHnmKQT5g0X9Q6IxXk6KGOsRWph+V7TgQCkI9i
         3KmiR8ZOMVQWz1fhhURSznYJ+pWmLDg+w75WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038837; x=1761643637;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fiak3iwfikjarVQ22RTf8mHmUiPs3Zv+6ZrupgeqTg=;
        b=nKYgW59xhtJ1oFnzmTYlZbn4V3EGx0r8YzL9b9G8taosFRugXwqvPmQesF5lnj0D7L
         Ef4me6yW7oGVZzCKmnH+iRK7zMInL9LNpO3Ukz1T+J61af+o7HYWBcLooIk2oum68ib1
         s37vqMxsmeMtha5UlfFkmiZ9ZTenJkKPAdhVbGJuTQb3/1cV6/oTnhAbIuG783U4oBcN
         6MN/oJHS6d/FVHAPbS2pOBB9X/+gdnePheeW+znM8S2QA1HK3yrvVslSk9v2dHMm7dgL
         Z8BM+YIf2B17uN1GeKntJa6JT1dlcBIE87HM/ximd5LfNOaa+/qXn5+Eaaxnz1b4hp9j
         6fnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT1swqdbPsOkGn7y8msPacKmKzRU2urCHNQNO9UB0QvolMfEN03i09RsDUQLI7IY8GrGO6ILEpi0VDxnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9J2fyuMBeQMJApMCGIBN2DAQFCAF7y7tDM16CrXYF+lHEh3G
	xaVZ5z316UOgjtgcZK26myVEh9F5S9Y9QQ0ebLRe6U7jTY2WWNSqzNCEd2RTK/B0AJQ=
X-Gm-Gg: ASbGncsJoAP5jNEbMg9naDsrjT49+Xw/NuzpqFyRm22vCVIOgnsZAQi/KgeeYSTzykR
	bvgIn/px5O6tH/ImTM6q/tOs+pT1bXTSQIy/vEPW3wPOoXE6aooIQR6nfCe6d0m26cqBY4XjMFD
	awnORsJrUWW9C5THMzwWUJOxgD4c9opNOAZiVZH6BcvPVV7RBcuTDz9wQ2C0NCPzRa5GUTAEc9K
	3kxbYqubsdr6H6jiDa4gvAdhiE1gVa5tBaI1/zqJijY9DVTLtojZV68k7XXjLwCTr8MRUNuRy+q
	d6tIwUfIXGJtZhS07MDLThpAcDuW7YI8Dnp2uIi0Vn94yVu+0Ym+miNjcK/7pqWmCzfIGLipU1p
	JAixrNJWwXleTUW+MWrodi1QvNibnqvkwy3fha03Z+LBfhT1kdHc7O5iO77CHIEkWIBJMTknDde
	mepCAV8QpjQt3AKCDHFLU2lRZF86tNjACu
X-Google-Smtp-Source: AGHT+IFm/KoayqzspHd8mI9RnV0dy/J2zGNTNE3AaiHK0wTHFJ8JnK4adD4zkjoh9BLc4aS8jUaUfw==
X-Received: by 2002:a17:907:d08:b0:b60:18d5:429a with SMTP id a640c23a62f3a-b647323fac1mr1812094666b.22.1761038836822;
        Tue, 21 Oct 2025 02:27:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e896f904sm1044786866b.35.2025.10.21.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:27:16 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:27:14 +0200
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
Subject: Re: [PATCH 13/29] drm/atomic_helper: Compare actual and readout
 states once the commit is done
Message-ID: <aPdR8g53oqJlHmYa@phenom.ffwll.local>
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
 <20250902-drm-state-readout-v1-13-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-13-14ad5315da3f@kernel.org>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 02, 2025 at 10:32:41AM +0200, Maxime Ripard wrote:
> The new atomic state readout infrastructure can be hard to test because
> getting access to every firmware variation is hard, but also because
> most firmware setup will be pretty basic and won't test a wide range of
> features. Noticing whether it was sucessful or not is also not very
> convenient.
> 
> In order to make it easier, we can however provide some infrastructure
> to read out a new state every time a non-blocking commit is made, and
> compare the readout one with the committed one. And since we do this
> only on non-blocking commits, the time penalty doesn't matter.
> 
> To do so, we introduce a new hook for every state, atomic_compare_state,
> that takes two state instances and is supposed to return whether they
> are identical or not.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 113 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic.h            |  14 +++++
>  include/drm/drm_bridge.h            |  14 +++++
>  include/drm/drm_connector.h         |  14 +++++
>  include/drm/drm_crtc.h              |  14 +++++
>  include/drm/drm_plane.h             |  14 +++++
>  6 files changed, 183 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 14d9bc282ca570964e494936090898b2dc6bee31..aa8f52b5d5a5e6146a6472eebaf02e675c35ccd2 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -428,10 +428,120 @@ void drm_atomic_helper_readout_state(struct drm_device *dev)
>  	drm_atomic_helper_install_readout_state(state);
>  	drm_atomic_state_put(state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_readout_state);
>  
> +static bool drm_atomic_helper_readout_compare(struct drm_atomic_state *committed_state)
> +{
> +	struct drm_device *dev = committed_state->dev;
> +	struct drm_printer p = drm_err_printer(dev, NULL);
> +	struct drm_private_state *new_obj_state;
> +	struct drm_private_obj *obj;
> +	struct drm_plane_state *new_plane_state;
> +	struct drm_plane *plane;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_crtc *crtc;
> +	struct drm_connector_state *new_conn_state;
> +	struct drm_connector *conn;
> +	struct drm_atomic_state *readout_state;
> +	unsigned int i;
> +	bool identical = true;
> +
> +	readout_state = drm_atomic_build_readout_state(dev);
> +	if (WARN_ON(IS_ERR(readout_state)))
> +		return false;
> +
> +	for_each_new_plane_in_state(committed_state, plane, new_plane_state, i) {
> +		const struct drm_plane_funcs *plane_funcs =
> +			plane->funcs;
> +		struct drm_plane_state *readout_plane_state;
> +
> +		readout_plane_state = drm_atomic_get_old_plane_state(readout_state, plane);
> +		if (!readout_plane_state) {
> +			identical = false;
> +			continue;
> +		}
> +
> +		if (!plane_funcs->atomic_compare_state)
> +			continue;
> +
> +		if (!plane_funcs->atomic_compare_state(plane, &p, new_plane_state, readout_plane_state)) {
> +			drm_warn(dev, "[PLANE:%d:%s] Committed and Readout PLANE state don't match\n",
> +				 plane->base.id, plane->name);
> +			identical = false;
> +			continue;
> +		}
> +	}
> +
> +	for_each_new_crtc_in_state(committed_state, crtc, new_crtc_state, i) {
> +		const struct drm_crtc_funcs *crtc_funcs = crtc->funcs;
> +		struct drm_crtc_state *readout_crtc_state;
> +
> +		readout_crtc_state = drm_atomic_get_old_crtc_state(readout_state, crtc);
> +		if (!readout_crtc_state) {
> +			identical = false;
> +			continue;
> +		}
> +
> +		if (!crtc_funcs->atomic_compare_state)
> +			continue;
> +
> +		if (!crtc_funcs->atomic_compare_state(crtc, &p, new_crtc_state, readout_crtc_state)) {
> +			drm_warn(dev, "[CRTC:%d:%s] Committed and Readout CRTC state don't match\n",
> +				 crtc->base.id, crtc->name);
> +			identical = false;
> +			continue;
> +		}
> +	}
> +
> +	for_each_new_connector_in_state(committed_state, conn, new_conn_state, i) {
> +		const struct drm_connector_funcs *conn_funcs =
> +			conn->funcs;
> +		struct drm_connector_state *readout_conn_state;
> +
> +		readout_conn_state = drm_atomic_get_old_connector_state(readout_state, conn);
> +		if (!readout_conn_state) {
> +			identical = false;
> +			continue;
> +		}
> +
> +		if (!conn_funcs->atomic_compare_state)
> +			continue;
> +
> +		if (!conn_funcs->atomic_compare_state(conn, &p, new_conn_state, readout_conn_state)) {
> +			drm_warn(dev, "[CONNECTOR:%d:%s] Committed and Readout connector state don't match\n",
> +				 conn->base.id, conn->name);
> +			identical = false;
> +			continue;
> +		}
> +	}
> +
> +	for_each_new_private_obj_in_state(committed_state, obj, new_obj_state, i) {
> +		const struct drm_private_state_funcs *obj_funcs = obj->funcs;
> +		struct drm_private_state *readout_obj_state;
> +
> +		readout_obj_state = drm_atomic_get_old_private_obj_state(readout_state, obj);
> +		if (!readout_obj_state) {
> +			identical = false;
> +			continue;
> +		}
> +
> +		if (!obj_funcs->atomic_compare_state)
> +			continue;
> +
> +		if (!obj_funcs->atomic_compare_state(obj, &p, new_obj_state, readout_obj_state)) {
> +			drm_warn(dev, "Committed and Readout private object state don't match\n");
> +			identical = false;
> +			continue;
> +		}
> +	}
> +
> +	drm_atomic_state_put(readout_state);
> +
> +	return identical;
> +}
> +
>  /**
>   * DOC: overview
>   *
>   * This helper library provides implementations of check and commit functions on
>   * top of the CRTC modeset helper callbacks and the plane helper callbacks. It
> @@ -2382,10 +2492,13 @@ static void commit_tail(struct drm_atomic_state *state, bool nonblock)
>  						 (unsigned long)commit_time_ms,
>  						 new_self_refresh_mask);
>  
>  	drm_atomic_helper_commit_cleanup_done(state);
>  

Over the w/e I've had a bit a panic about GFP_KERNEL allocations in the
readout code and how that's a problem if it's in the fence critical path.
But you've already implemented the same solution I've come up with (and
also what I've come up with for i915 way back), so all good.

I think a comment to explain why we can only do this after all the
completion signalling has been done but while we still hold all the
modeset locks, and how this check achieves that, would be great here.

Cheers, Sima

> +	if (!nonblock)
> +		drm_atomic_helper_readout_compare(state);
> +
>  	drm_atomic_state_put(state);
>  }
>  
>  static void commit_work(struct work_struct *work)
>  {
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index f13f926d21047e42bb9ac692c2dd4b88f2ebd91c..d75a9c7e23adf7fa264df766b47526f75e9cc753 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -226,10 +226,24 @@ struct drm_private_state_funcs {
>  	 * Frees the private object state created with @atomic_duplicate_state.
>  	 */
>  	void (*atomic_destroy_state)(struct drm_private_obj *obj,
>  				     struct drm_private_state *state);
>  
> +	/**
> +	 * @atomic_compare_state
> +	 *
> +	 * Compares two &struct drm_private_state instances.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * True if the states are identical, false otherwise.
> +	 */
> +	bool (*atomic_compare_state)(struct drm_private_obj *obj,
> +				     struct drm_printer *p,
> +				     struct drm_private_state *a,
> +				     struct drm_private_state *b);
> +
>  	/**
>  	 * @atomic_print_state:
>  	 *
>  	 * If driver subclasses &struct drm_private_state, it should implement
>  	 * this optional hook for printing additional driver specific state.
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 15b63053f01869786831936ba28b7efc1e55e2e8..5ea63b51a4dd4cb00468afcf7d126c774f63ade0 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -511,10 +511,24 @@ struct drm_bridge_funcs {
>  	int (*atomic_readout_state)(struct drm_bridge *bridge,
>  				    struct drm_bridge_state *bridge_state,
>  				    struct drm_crtc_state *crtc_state,
>  				    struct drm_connector_state *conn_state);
>  
> +	/**
> +	 * @atomic_compare_state
> +	 *
> +	 * Compares two &struct drm_bridge_state instances.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * True if the states are identical, false otherwise.
> +	 */
> +	bool (*atomic_compare_state)(struct drm_bridge *bridge,
> +				     struct drm_printer *p,
> +				     struct drm_bridge_state *a,
> +				     struct drm_bridge_state *b);
> +
>  	/**
>  	 * @atomic_duplicate_state:
>  	 *
>  	 * Duplicate the current bridge state object (which is guaranteed to be
>  	 * non-NULL).
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index f68bd9627c085c6d2463b847aaa245ccc651f27b..dc2c77b04df9010cbfb2028de8ef8c747003c489 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1534,10 +1534,24 @@ struct drm_connector_funcs {
>  	 * This callback is mandatory for atomic drivers.
>  	 */
>  	void (*atomic_destroy_state)(struct drm_connector *connector,
>  				     struct drm_connector_state *state);
>  
> +	/**
> +	 * @atomic_compare_state
> +	 *
> +	 * Compares two &struct drm_connector_state instances.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * True if the states are identical, false otherwise.
> +	 */
> +	bool (*atomic_compare_state)(struct drm_connector *connector,
> +				     struct drm_printer *p,
> +				     struct drm_connector_state *a,
> +				     struct drm_connector_state *b);
> +
>  	/**
>  	 * @atomic_set_property:
>  	 *
>  	 * Decode a driver-private property value and store the decoded value
>  	 * into the passed-in state structure. Since the atomic core decodes all
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 11e3299cfad1572c6e507918c7cceae7a28ba4cf..21c20ecdda40f3d155d3c140e06b3801270f5262 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -676,10 +676,24 @@ struct drm_crtc_funcs {
>  	 * This callback is mandatory for atomic drivers.
>  	 */
>  	void (*atomic_destroy_state)(struct drm_crtc *crtc,
>  				     struct drm_crtc_state *state);
>  
> +	/**
> +	 * @atomic_compare_state
> +	 *
> +	 * Compares two &struct drm_crtc_state instances.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * True if the states are identical, false otherwise.
> +	 */
> +	bool (*atomic_compare_state)(struct drm_crtc *crtc,
> +				     struct drm_printer *p,
> +				     struct drm_crtc_state *a,
> +				     struct drm_crtc_state *b);
> +
>  	/**
>  	 * @atomic_set_property:
>  	 *
>  	 * Decode a driver-private property value and store the decoded value
>  	 * into the passed-in state structure. Since the atomic core decodes all
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 691a267c857a228f674ef02a63fb6d1ff9e379a8..c24c10ccc8e8f2ba23e77e279aef61ae86e320c7 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -449,10 +449,24 @@ struct drm_plane_funcs {
>  	 * This callback is mandatory for atomic drivers.
>  	 */
>  	void (*atomic_destroy_state)(struct drm_plane *plane,
>  				     struct drm_plane_state *state);
>  
> +	/**
> +	 * @atomic_compare_state
> +	 *
> +	 * Compares two &struct drm_plane_state instances.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * True if the states are identical, false otherwise.
> +	 */
> +	bool (*atomic_compare_state)(struct drm_plane *plane,
> +				     struct drm_printer *p,
> +				     struct drm_plane_state *a,
> +				     struct drm_plane_state *b);
> +
>  	/**
>  	 * @atomic_set_property:
>  	 *
>  	 * Decode a driver-private property value and store the decoded value
>  	 * into the passed-in state structure. Since the atomic core decodes all
> 
> -- 
> 2.50.1
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

