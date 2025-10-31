Return-Path: <linux-kernel+bounces-880948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89497C26F88
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCD11B273A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88BE27B331;
	Fri, 31 Oct 2025 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fIHsLXOm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79759153BD9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944516; cv=none; b=Zaz3P4tA2CBpK/iqCCk8mWtKIQaAZCm5WHBkAO/vh0wCd41C+tRUeS6xONotfatPZi0LrcvzVqCzFyxMl77QXkKXimuAA8QsM/yM7GiCWOANJVXRfg3PABE+tgFe3YOro4h+wmobA6U/msC+69FI3bhG9BnninHK5GYKT6SXolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944516; c=relaxed/simple;
	bh=d5On631v640g25k6PtMWVcBVMc4KL0oihRe5ij2aGv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgvcduZZTNPokCsGVbArukVJJLIX14JYh9+DTXI2HMUbAfzfdndCHB3PlaXJ89QpLIC66u+nFLalDtI/yFqhH+NargWbDEQQB4A8Jm1ZbwGELvPqdrgZN7x2p9U6660V3W8GVwh6oAqE0eAUqrvZoMWnmenb9S718bUUeqgoBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fIHsLXOm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64071184811so3994055a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761944512; x=1762549312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/2E9x7BbDTtx7HnTL34SKyTlbPO9vuJAvxeFHtIWo8=;
        b=fIHsLXOmyQ+fwPoPxCr7JOJBwUpFzviQ4w3+36HyNBDZVoDBku755AFzwLGPalYvfe
         QBda8KccLDSMNwcfylxzfcnpiTjVqbMowG1aCB+sRzZFWU/UGRArlLAKvYzHGXENwy/E
         G95hBZq0V3g+FnemjRX44eHPTBJyuqR2nXBIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761944512; x=1762549312;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/2E9x7BbDTtx7HnTL34SKyTlbPO9vuJAvxeFHtIWo8=;
        b=qLq0LemDtLEHZhnesFV7Y7fQsTb87Kg4SuOHWgBfz0EiYl0vvdz2gCa563zN4sQvoF
         tsW5wAqfZIf2G1DDvpoARDghx6EuSBPzAX2ZWAbF384QiQmKLPN9+5tNw1ln5r4j1iQA
         YVpx0Q8+/N0F97S9fWX/oPpK18qkQ1hi4RtR0hdBj9qebP83ryJ27TcpCyTcLoUwbDEX
         oxi0ELt83bI6M1fjMpTdw82TtURV4jnNBPVFe370Hc46peiMDA4SPSa6rnOZmg2GpFIu
         3GZ5nIihwuK7Z78mTty/1e5xxIJiraAiBCNVAiwepnEsfcolpTTlYqXxtpPqzRPJygMS
         OZmA==
X-Forwarded-Encrypted: i=1; AJvYcCUC+Fz2+NkdHJvuHZ3h44m+gPyvP1DbntC+oLEpzR+33lA02204hG/J339HXQ+G4OXJCe6TZeDh1EGXYLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6I/ad326b3TmeLkhGOsf8SmX8jtgadbUhm4eAmfyY78TZOdd
	qE5rQNQqvZAtHXuGXWy7oFWcLBBTxbH2YDBQx54BoQIoiSpfH57wEz4WDZwspbLNJsk=
X-Gm-Gg: ASbGncvwxbNHgS0C37vCzP9y3i5eETVPZLaL0CQSijY74IL0voN7qNoFRaCRXCGsLjQ
	oRaqSpQxysa7eb4Y84dQjzJK2jNAAZBw6bqe/kOsi7SWUYGMsaKYxa5ZhAaXNW82Ngo4wLuxk2h
	KA6CLQBcd7GNwYoNg6RbV/23rs/KX4KmS1C2WiByvH0x1dFB+xQSpbkWkP67c/sA9W0K++lENFU
	A7q+nBx947fW7DcskyKBjUrJ/Pw8V0JZ4QTmrpLf/ZJCdh0uz1mepsKasoHOGN0PuxHkUkmr17+
	uVo6bleJMp9+L80hV+SrizBVXZOuck3jdswptDtVl9ye/I781Z2V+AvRx4v55W5UfPLGIUuGuzL
	vy6cxbeqn9rIMGmlirhR+bGlA+QIoVMGvUFeK5ytI1etpBFSp90gthpj5AOdbhxW7IuPK5sEC4z
	QuDq4C1h3mYVY0mTVzQwfmyQ==
X-Google-Smtp-Source: AGHT+IFx1yFDshiwWTtuDi5x70CKSfd6CGOmSiAgSIRqs8qGEWp+EK499OIrMAyQuSb+s3JSp0K08w==
X-Received: by 2002:a05:6402:524d:b0:640:6c3c:6498 with SMTP id 4fb4d7f45d1cf-64076f78ce4mr3782070a12.9.1761944512005;
        Fri, 31 Oct 2025 14:01:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64092e1a405sm621398a12.31.2025.10.31.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:01:50 -0700 (PDT)
Date: Fri, 31 Oct 2025 22:01:47 +0100
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
Message-ID: <aQUju16InQgSq1pE@phenom.ffwll.local>
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

Ok, after much pondering I have another one: I think the actual helpers
for state readout should be extracted (it'll be really tiny) and shared
between this code here and the fasboot/reset logic. And because that'd be
really silly, here's the reason:

This would give us a really nice place to document and enforce the locking
rules, which I think are:

- The drm_device is either not yet registered or
- You hold the relevant drm_modeset_lock for that state (which
  unfortunately isn't very uniform, maybe we should fix that).

The latter is also the reason (ok, one of the reasons) why we cannot read
out the state in the nonblocking commit_tail, because we don't hold the
modeset locks in that path anymore.

Thirdly, allocations are allowed, so maybe whack a might_alloc(GFP_KERNEL)
for completion in there. But I've already threw in reply for that issue.

So yeah I think tactical sprinkling of

	if (dev->registered)
		lockdep_assert_held();

over these small helpers to give them some substance would be great.

Cheers, Sima

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

