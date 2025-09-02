Return-Path: <linux-kernel+bounces-795840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA607B3F89D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053A8202FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435B2E8B88;
	Tue,  2 Sep 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWexjkhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3082E9EC9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802003; cv=none; b=Dxp9U9YbVm50MlA5tv7SVdXXwgGdO+nVcWZOODuIXbN2ueG1j5yiUCiIDMhH/Igp1rQZBKmTyymt7vvpfWy7nSOKt3sNDpg7ZOHVPMB8O0S2n26ctsxXlP7ToZEve1i8xqgufr30p5MFfB1PuqugXz70pKsgjCBhj9bF+I3wNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802003; c=relaxed/simple;
	bh=ymXL3YOVpngIrQ5Uh/MtWSLd5T18BYRz7YHzVv+IsMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYK0ohT8J6vIeZIpm4nd5/7lnbeZTOm0SPFosU14OjGddWuKwsiWKbEI7+3y6cK0sDullGJJ+zbq9WoRtAaPCxWVKR27ofvO7Z6x72nlaCop0XaXdKSwKfop7MwcvwcIq3H1wH07GIdsrqYcGRVrqgE1/N55M5c2bf4X++GHYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWexjkhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF86C4CEF8;
	Tue,  2 Sep 2025 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802003;
	bh=ymXL3YOVpngIrQ5Uh/MtWSLd5T18BYRz7YHzVv+IsMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lWexjkhO/JciMGnbiWpcHeqAA0/F8ypD0TOktIDj+RDkjcoDKh8mjvI/A/ERUTJ7C
	 +GstNNrTokBi7tX2wjfOt2pWBVmh6H4fj3FhCtAeEksK2I46WhvbIdYIXMxoHUipZw
	 D8k5FzCe67qrR5sYCmpcq27KPHp1rToIO1Gju/323UlXXTeavKFf5/3ge90z1d+qKU
	 2KJBYKKo7WMieLXHlIn7ZvoPdxQhWLdksUxQJSZHOO5Cwe4+nDDV7EeihatT/IXwVn
	 E9Nvsdqxxszw3cV3f0Sqyt8SXBykbJoVW5HCyLTu1xkNUthrbq3guGcHDt6fxp9thg
	 Mtwiq5tAzBklQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:33 +0200
Subject: [PATCH 05/29] drm/atomic_state_helper: Fix bridge state
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-5-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ymXL3YOVpngIrQ5Uh/MtWSLd5T18BYRz7YHzVv+IsMw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVm+bbJU35eXunS31k8pcFn1SXpW2fumR36/K5y6fV
 H23sUc4t2MqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBM5NQUxloR2y2zhB7eUVux
 5aGTJefcv/fDT+0Mnv+2LVinmN8tdKv8rOc/e1Occidtm5RafLrtny5jwwzVFNsQtiM1uQpez0T
 fZIdxr0nN6jiRZhYw48LJ1uaix85VPpsMLer2ax7xUJ4rzjcNAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Bridges implement their state using a drm_private_obj and an
hand-crafted reset implementation.

Since drm_private_obj doesn't have a set of reset helper like the other
states, __drm_atomic_helper_bridge_reset() was initializing both the
drm_private_state and the drm_bridge_state structures.

This initialization however was missing the drm_private_state.obj
pointer to the drm_private_obj the state was allocated for, creating a
NULL pointer dereference when trying to access it.

Fixes: 751465913f04 ("drm/bridge: Add a drm_bridge_state object")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 7142e163e618ea0d7d9d828e1bd9ff2a6ec0dfeb..b962c342b16aabf4e3bea52a914e5deb1c2080ce 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -707,10 +707,17 @@ void drm_atomic_helper_connector_destroy_state(struct drm_connector *connector,
 	__drm_atomic_helper_connector_destroy_state(state);
 	kfree(state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
 
+static void __drm_atomic_helper_private_obj_reset(struct drm_private_obj *obj,
+						  struct drm_private_state *state)
+{
+	memset(state, 0, sizeof(*state));
+	state->obj = obj;
+}
+
 /**
  * __drm_atomic_helper_private_obj_duplicate_state - copy atomic private state
  * @obj: CRTC object
  * @state: new private object state
  *
@@ -796,10 +803,11 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
  */
 void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state)
 {
 	memset(state, 0, sizeof(*state));
+	__drm_atomic_helper_private_obj_reset(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
 
 /**

-- 
2.50.1


