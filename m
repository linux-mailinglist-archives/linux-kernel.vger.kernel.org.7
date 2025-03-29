Return-Path: <linux-kernel+bounces-580776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D66A75617
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 12:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C8F16F6BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7E1C4A13;
	Sat, 29 Mar 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqqhzicK"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F51CAA6C
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249247; cv=none; b=Sso8zL1vVrUP0gyrvayoYCusSMDNDqAcNSs9DphQsyw4+vNZGjOCOqVUaItI6pVxDEoMm+mlEFDK5N1JP3xH4Gplf3CRI5I5+ijKQgDFxpiGQHpke2frYosvq7LmHcDOe5AcAmkLqBTNHDEqyXhT3+MT/B8irMwF+0fP1z9BBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249247; c=relaxed/simple;
	bh=TsCmolc9blFKbyLhgY3DInxT7HXoqZnMlrizWIskL18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMsYSMj04XKAwZsN7MC/YaPevok6F+JqlJj1SVtWdB0gdIZaTRynpQtaU593OHmXruR1etYpooFpTT+0kUMIfQT0X9+3o46OX3qoqGhY1zi7HJ7goyosC+VP5G2UeBfZSc5Rtmz19kGjQfrAM2L3f6DQdIrCUty4d2PU9jL/i+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqqhzicK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743249243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THxuM/PMfTP0Y+Z6SEtj+1K+JpeW8z2FyoRNt+QLTYA=;
	b=jqqhzicKmbz5crbssFy0Qgrpg7BiBCXgHzDgzUlPX2T1ld9OhkfC5S7W4S3fpXMjPrmM44
	KW4Es0cXhpgw0n4IgLxi2OEDEaHiLwbuOnRxjUtOPkcZ7FARkAajQ6QVIfhbY+zq70oyW8
	yWa0suAwwx9LjVFyTGXw2XHFoUj8E+Q=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Dominik Haller <d.haller@phytec.de>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: [PATCH v11 13/14] drm/bridge: Update the bridge enable/disable doc
Date: Sat, 29 Mar 2025 17:23:32 +0530
Message-Id: <20250329115333.72614-3-aradhya.bhatia@linux.dev>
In-Reply-To: <20250329113925.68204-1-aradhya.bhatia@linux.dev>
References: <20250329113925.68204-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that the bridges get pre-enabled before the CRTC is enabled, and get
post-disabled after the CRTC is disabled, update the function
descriptions to accurately reflect the updated scenario.

The enable sequence for the display pipeline looks like:

	bridge[n]_pre_enable
	...
	bridge[1]_pre_enable

	crtc_enable
	encoder_enable

	bridge[1]_enable
	...
	bridge[n]_enable

And, the disable sequence for the display pipeline looks like:

	bridge[n]_disable
	...
	bridge[1]_disable

	encoder_disable
	crtc_disable

	bridge[1]_post_disable
	...
	bridge[n]_post_disable

Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 include/drm/drm_bridge.h | 216 +++++++++++++++++++++++++++------------
 1 file changed, 150 insertions(+), 66 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index cdad3b78a195..fc126562733c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -164,17 +164,28 @@ struct drm_bridge_funcs {
 	/**
 	 * @disable:
 	 *
-	 * This callback should disable the bridge. It is called right before
-	 * the preceding element in the display pipe is disabled. If the
-	 * preceding element is a bridge this means it's called before that
-	 * bridge's @disable vfunc. If the preceding element is a &drm_encoder
-	 * it's called right before the &drm_encoder_helper_funcs.disable,
-	 * &drm_encoder_helper_funcs.prepare or &drm_encoder_helper_funcs.dpms
-	 * hook.
+	 * The @disable callback should disable the bridge.
 	 *
 	 * The bridge can assume that the display pipe (i.e. clocks and timing
 	 * signals) feeding it is still running when this callback is called.
 	 *
+	 * It is called right before the preceding element in the display pipe
+	 * is disabled. If the preceding element is a &drm_bridge, then it's
+	 * called before that bridge is disabled.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right before the encoder and the CRTC are disabled via the
+	 * following hooks.
+	 * &drm_encoder_helper_funcs.atomic_disable, or
+	 * &drm_encoder_helper_funcs.prepare, or
+	 * &drm_encoder_helper_funcs.disable, or &drm_encoder_helper_funcs.dpms
+	 * hook for the encoder, and
+	 * &drm_crtc_helper_funcs.prepare, or
+	 * &drm_crtc_helper_funcs.atomic_disable, or
+	 * &drm_crtc_helper_funcs.disable, or &drm_crtc_helper_funcs.dpms hook
+	 * for the CRTC.
+	 *
 	 * The @disable callback is optional.
 	 *
 	 * NOTE:
@@ -187,17 +198,30 @@ struct drm_bridge_funcs {
 	/**
 	 * @post_disable:
 	 *
-	 * This callback should disable the bridge. It is called right after the
-	 * preceding element in the display pipe is disabled. If the preceding
-	 * element is a bridge this means it's called after that bridge's
-	 * @post_disable function. If the preceding element is a &drm_encoder
-	 * it's called right after the encoder's
-	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
-	 * or &drm_encoder_helper_funcs.dpms hook.
-	 *
 	 * The bridge must assume that the display pipe (i.e. clocks and timing
-	 * signals) feeding it is no longer running when this callback is
-	 * called.
+	 * signals) feeding this bridge is no longer running when the
+	 * @post_disable is called.
+	 *
+	 * This callback should perform all the actions required by the hardware
+	 * after it has stopped receiving signals from the preceding element.
+	 *
+	 * It is called right after the preceding element is post-disabled, and
+	 * right before the following element gets post-disabled (given that the
+	 * preceding and following elements are &drm_bridges), unless marked
+	 * otherwise by the @pre_enable_prev_first flag.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right after the encoder and the CRTC are disabled via the
+	 * following hooks.
+	 * &drm_encoder_helper_funcs.atomic_disable, or
+	 * &drm_encoder_helper_funcs.prepare, or
+	 * &drm_encoder_helper_funcs.disable, or &drm_encoder_helper_funcs.dpms
+	 * hook for the encoder, and
+	 * &drm_crtc_helper_funcs.prepare, or
+	 * &drm_crtc_helper_funcs.atomic_disable, or
+	 * &drm_crtc_helper_funcs.disable, or &drm_crtc_helper_funcs.dpms hook
+	 * for the CRTC.
 	 *
 	 * The @post_disable callback is optional.
 	 *
@@ -240,18 +264,26 @@ struct drm_bridge_funcs {
 	/**
 	 * @pre_enable:
 	 *
-	 * This callback should enable the bridge. It is called right before
-	 * the preceding element in the display pipe is enabled. If the
-	 * preceding element is a bridge this means it's called before that
-	 * bridge's @pre_enable function. If the preceding element is a
-	 * &drm_encoder it's called right before the encoder's
-	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
-	 * &drm_encoder_helper_funcs.dpms hook.
-	 *
 	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
-	 * will not yet be running when this callback is called. The bridge must
-	 * not enable the display link feeding the next bridge in the chain (if
-	 * there is one) when this callback is called.
+	 * will not yet be running when the @pre_enable is called.
+	 *
+	 * This callback should perform all the necessary actions to prepare the
+	 * bridge to accept signals from the preceding element.
+	 *
+	 * It is called right after the following element is pre-enabled, and
+	 * right before the preceding element gets pre-enabled (given that the
+	 * following and preceding elements are &drm_bridges), unless marked
+	 * otherwise by @pre_enable_prev_first flag.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right before the CRTC and the encoder are enabled via these
+	 * hooks.
+	 * &drm_crtc_helper_funcs.atomic_enable, or
+	 * &drm_crtc_helper_funcs.commit hook for the CRTC, and
+	 * &drm_encoder_helper_funcs.atomic_enable, or
+	 * &drm_encoder_helper_funcs.enable, or &drm_encoder_helper_funcs.commit
+	 * hook for the encoder.
 	 *
 	 * The @pre_enable callback is optional.
 	 *
@@ -265,19 +297,27 @@ struct drm_bridge_funcs {
 	/**
 	 * @enable:
 	 *
-	 * This callback should enable the bridge. It is called right after
-	 * the preceding element in the display pipe is enabled. If the
-	 * preceding element is a bridge this means it's called after that
-	 * bridge's @enable function. If the preceding element is a
-	 * &drm_encoder it's called right after the encoder's
-	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
-	 * &drm_encoder_helper_funcs.dpms hook.
+	 * The @enable callback should enable the bridge.
 	 *
 	 * The bridge can assume that the display pipe (i.e. clocks and timing
 	 * signals) feeding it is running when this callback is called. This
 	 * callback must enable the display link feeding the next bridge in the
 	 * chain if there is one.
 	 *
+	 * It is called right after the preceding element in the display pipe is
+	 * enabled. If the preceding element is a &drm_bridge, then it's called
+	 * after that bridge is enabled.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right after the CRTC and the encoder are enabled via these
+	 * hooks.
+	 * &drm_crtc_helper_funcs.atomic_enable, or
+	 * &drm_crtc_helper_funcs.commit hook for the CRTC, and
+	 * &drm_encoder_helper_funcs.atomic_enable, or
+	 * &drm_encoder_helper_funcs.enable, or &drm_encoder_helper_funcs.commit
+	 * hook for the encoder.
+	 *
 	 * The @enable callback is optional.
 	 *
 	 * NOTE:
@@ -290,17 +330,26 @@ struct drm_bridge_funcs {
 	/**
 	 * @atomic_pre_enable:
 	 *
-	 * This callback should enable the bridge. It is called right before
-	 * the preceding element in the display pipe is enabled. If the
-	 * preceding element is a bridge this means it's called before that
-	 * bridge's @atomic_pre_enable or @pre_enable function. If the preceding
-	 * element is a &drm_encoder it's called right before the encoder's
-	 * &drm_encoder_helper_funcs.atomic_enable hook.
-	 *
 	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
-	 * will not yet be running when this callback is called. The bridge must
-	 * not enable the display link feeding the next bridge in the chain (if
-	 * there is one) when this callback is called.
+	 * will not yet be running when the @atomic_pre_enable is called.
+	 *
+	 * This callback should perform all the necessary actions to prepare the
+	 * bridge to accept signals from the preceding element.
+	 *
+	 * It is called right after the following element is pre-enabled, and
+	 * right before the preceding element gets pre-enabled (given that the
+	 * following and preceding elements are &drm_bridges), unless marked
+	 * otherwise by @pre_enable_prev_first flag.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right before the CRTC and the encoder are enabled via these
+	 * hooks.
+	 * &drm_crtc_helper_funcs.atomic_enable, or
+	 * &drm_crtc_helper_funcs.commit hook for the CRTC, and
+	 * &drm_encoder_helper_funcs.atomic_enable, or
+	 * &drm_encoder_helper_funcs.enable, or &drm_encoder_helper_funcs.commit
+	 * hook for the encoder.
 	 *
 	 * The @atomic_pre_enable callback is optional.
 	 */
@@ -310,18 +359,27 @@ struct drm_bridge_funcs {
 	/**
 	 * @atomic_enable:
 	 *
-	 * This callback should enable the bridge. It is called right after
-	 * the preceding element in the display pipe is enabled. If the
-	 * preceding element is a bridge this means it's called after that
-	 * bridge's @atomic_enable or @enable function. If the preceding element
-	 * is a &drm_encoder it's called right after the encoder's
-	 * &drm_encoder_helper_funcs.atomic_enable hook.
+	 * The @atomic_enable callback should enable the bridge.
 	 *
 	 * The bridge can assume that the display pipe (i.e. clocks and timing
 	 * signals) feeding it is running when this callback is called. This
 	 * callback must enable the display link feeding the next bridge in the
 	 * chain if there is one.
 	 *
+	 * It is called right after the preceding element in the display pipe is
+	 * enabled. If the preceding element is a &drm_bridge, then it's called
+	 * after that bridge is enabled.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right after the CRTC and the encoder are enabled via these
+	 * hooks.
+	 * &drm_crtc_helper_funcs.atomic_enable, or
+	 * &drm_crtc_helper_funcs.commit hook for the CRTC, and
+	 * &drm_encoder_helper_funcs.atomic_enable, or
+	 * &drm_encoder_helper_funcs.enable, or &drm_encoder_helper_funcs.commit
+	 * hook for the encoder.
+	 *
 	 * The @atomic_enable callback is optional.
 	 */
 	void (*atomic_enable)(struct drm_bridge *bridge,
@@ -329,16 +387,28 @@ struct drm_bridge_funcs {
 	/**
 	 * @atomic_disable:
 	 *
-	 * This callback should disable the bridge. It is called right before
-	 * the preceding element in the display pipe is disabled. If the
-	 * preceding element is a bridge this means it's called before that
-	 * bridge's @atomic_disable or @disable vfunc. If the preceding element
-	 * is a &drm_encoder it's called right before the
-	 * &drm_encoder_helper_funcs.atomic_disable hook.
+	 * The @atomic_disable callback should disable the bridge.
 	 *
 	 * The bridge can assume that the display pipe (i.e. clocks and timing
 	 * signals) feeding it is still running when this callback is called.
 	 *
+	 * It is called right before the preceding element in the display pipe
+	 * is disabled. If the preceding element is a &drm_bridge, then it's
+	 * called before that bridge is disabled.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right before the encoder and the CRTC are disabled via the
+	 * following hooks.
+	 * &drm_encoder_helper_funcs.atomic_disable, or
+	 * &drm_encoder_helper_funcs.prepare, or
+	 * &drm_encoder_helper_funcs.disable, or &drm_encoder_helper_funcs.dpms
+	 * hook for the encoder, and
+	 * &drm_crtc_helper_funcs.prepare, or
+	 * &drm_crtc_helper_funcs.atomic_disable, or
+	 * &drm_crtc_helper_funcs.disable, or &drm_crtc_helper_funcs.dpms hook
+	 * for the CRTC.
+	 *
 	 * The @atomic_disable callback is optional.
 	 */
 	void (*atomic_disable)(struct drm_bridge *bridge,
@@ -347,16 +417,30 @@ struct drm_bridge_funcs {
 	/**
 	 * @atomic_post_disable:
 	 *
-	 * This callback should disable the bridge. It is called right after the
-	 * preceding element in the display pipe is disabled. If the preceding
-	 * element is a bridge this means it's called after that bridge's
-	 * @atomic_post_disable or @post_disable function. If the preceding
-	 * element is a &drm_encoder it's called right after the encoder's
-	 * &drm_encoder_helper_funcs.atomic_disable hook.
-	 *
 	 * The bridge must assume that the display pipe (i.e. clocks and timing
-	 * signals) feeding it is no longer running when this callback is
-	 * called.
+	 * signals) feeding this bridge is no longer running when the
+	 * @atomic_post_disable is called.
+	 *
+	 * This callback should perform all the actions required by the hardware
+	 * after it has stopped receiving signals from the preceding element.
+	 *
+	 * It is called right after the preceding element is post-disabled, and
+	 * right before the following element gets post-disabled (given that the
+	 * preceding and following elements are &drm_bridges), unless marked
+	 * otherwise by the @pre_enable_prev_first flag.
+	 *
+	 * If the preceding element of the bridge is a display controller, which
+	 * has under it a &drm_crtc and a &drm_encoder, then this callback is
+	 * called right after the encoder and the CRTC are disabled via the
+	 * following hooks.
+	 * &drm_encoder_helper_funcs.atomic_disable, or
+	 * &drm_encoder_helper_funcs.prepare, or
+	 * &drm_encoder_helper_funcs.disable, or &drm_encoder_helper_funcs.dpms
+	 * hook for the encoder, and
+	 * &drm_crtc_helper_funcs.prepare, or
+	 * &drm_crtc_helper_funcs.atomic_disable, or
+	 * &drm_crtc_helper_funcs.disable, or &drm_crtc_helper_funcs.dpms hook
+	 * for the CRTC.
 	 *
 	 * The @atomic_post_disable callback is optional.
 	 */
-- 
2.34.1


