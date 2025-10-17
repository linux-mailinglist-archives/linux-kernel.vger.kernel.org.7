Return-Path: <linux-kernel+bounces-858075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A1BE8CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05E958885F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E0332EA3;
	Fri, 17 Oct 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c8WXXQ+m"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4F34F47B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707302; cv=none; b=HwNappG2oBobcow5dVbBkWB/kEEKaybH2KEB0dmZ0mCWsFutKwJTbAq9sxzLYPxR0CREfCphzkFsxaawSAeS3qBdqZI5CvdcTxEvfV4jtew5wIRj0ZZNUBRkFOEY3q4D05YcCMWDoawjCcfwsi+WvSfLdnEzUtSx2jfnhThMx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707302; c=relaxed/simple;
	bh=Vlvn2es2pW9MaIEVcuWuLpGf7A7oXk33ZNahh7pOBRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAh6jutlbNxOLG4pyBuwAOTsgjgPgnOu+W3sJSzXiOFLTsaImqPOww1qlK7fTwPPGyRIlq1nAx/lFA5hZs55CkMqMoWdLQ8H7vpRE6CgknDC0d4E224Jb6o2L//eaUKfGHqV1YZfRzneO0zMvcTOGjR4Pt66uRaOXu5ObMkwOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=c8WXXQ+m; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso323716866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1760707299; x=1761312099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEsKJoTinruIUsm0dpCz/6W6OuXaFFaRpbudO/5KEks=;
        b=c8WXXQ+mE5ksn1SmrdE3IkqgpeM/bU0Vg++fgMP18qm3zDU/DEf/ch4Huq61nwgRwg
         xxcjuIQ1mhzuXjLFCIGzFK7sU+3CtODnwAGOnLWdAbz39FgkXefPx5zhXq7jY9Rl50hk
         N4AKnhyAcQEt5hINCrQ2javKfImTBd+awkBcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707299; x=1761312099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEsKJoTinruIUsm0dpCz/6W6OuXaFFaRpbudO/5KEks=;
        b=PLmFCrnED2hSBdEcKBpgCVd88FcDN1bdWe7/i7LK1pCD3VqqYtPHESKVAre9JJ8ByP
         hPfvwX+1bb1AahzV2Y7IwhawYnFc3tJ0s6SBJpFg5iFFa9ZiZux9B4MI12YsWSJrIln5
         XANzmZB8iNiHKD5AJH80oRYeEGqIKFE9JgMgB3aVy5qyXYUcLbQH6lQdDT/rD9uolCPE
         wM0BWn9z2tVU99a6y92VbaHOE95C/r/eU7XTDcnX5FDxy6DfZ74zR7QiguK4V3UtCCgE
         352l14MTwR9rpcmk7Ut+i3OwSXo9J1zhQJoDq/20dwYEVCTZ9SKAuYnVL6hip+2NS58s
         3jKg==
X-Forwarded-Encrypted: i=1; AJvYcCV4kM9c8v3Mn1FC0qCGzF6aj5T7A+JQFnvDhpo0ZWx3FAJLV6praCqdpuy3d4CJCMHIGqfI/5zbCqezGWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnD+kjanWAFggjkKLFlLYMRqGnYAWc0h40/9M9FUL/DiI3UEx
	F8o0N8lLpTt8Rq9jDiJTFmfDQgRqzwIi3tUbuBhrNHgXfJKJVTHO5X7vdPp/IYL1hR4=
X-Gm-Gg: ASbGncsEgkXnOI/c5X3XBsUa4v5ZjwtNuR77EADUQqvoyAwWfntZ3XDCs5zh4mRUQtb
	rthmLKlczPvzK6o9gKV3O1rigeDMTeQer6GaH0FFcICSqr3m1c3uzU7T9cf7F6tDJ+7eQa1U8lQ
	Sv4sfY1EKy005B+PsKm2gBEaUjtlQev7bla1jlFEjdb1zdoTa/79wp3oeoD+tyPJwtMkFiphxSB
	K6k8iihwb0LHYC2KDD/YmFvivOTgxrLRchNG80gjBEUP7gToOmFcFGSePgljATwne0H9WZDaPm4
	8vuRcxFzWdLPRq5CdIfuXz+V8AQRhyF6xps05lX+LsnP0N+G01832qTPxgAJQhl1Yg7cyh0m55P
	khSPS8Fejype6kg0groqMSGr4CtRWUbEHak8Xit85Gz7pKoXFsgdm99uBRaACsEoLcp5nAHIlUf
	+ZQRJxP3NqT4V7NJQBqfnM4g==
X-Google-Smtp-Source: AGHT+IGym7DoxL5l3AN/IUAohqUuqSKOXLtkCATQpizikNGk/PDRDgFAt2MuZJOWyfIwPWNuMWrhbw==
X-Received: by 2002:a17:907:3e85:b0:b3e:8252:cd54 with SMTP id a640c23a62f3a-b647395033fmr440615966b.32.1760707298775;
        Fri, 17 Oct 2025 06:21:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06c187sm794912066b.31.2025.10.17.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:21:37 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:21:36 +0200
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
Message-ID: <aPJC4CisqouIX-Wi@phenom.ffwll.local>
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

Both these callbacks for connector/crtc/plane need to be moved into the
respective _helper_funcs structs, because they're not uapi stuff.
priv/bridge funcs do not have this split, because they're not uapi visible
objects.
-Sima

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

