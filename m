Return-Path: <linux-kernel+bounces-795843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 953A6B3F8A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EB7189AD48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAE2EA485;
	Tue,  2 Sep 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOHZAMRP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37412EA47F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802012; cv=none; b=NAOR2Pxdt0RARY98b3QXIecjy+3iLpTosaZrovwtudOWT+fLuKEn41tEmcA7iBu5XomdCd06LdGsabsE0PJb+XQmVDPgdzvfdIqvk5aPUdBl5O0AQS0FGKiumsX+RGqnjoCGcXfaXPDeP9tUlT8svYmZOBCq4xlA6up92/AvqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802012; c=relaxed/simple;
	bh=LFeGHCO304zdeHgumCSjX6EUrk3szDEz7RjVAng3QuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEt1sjGG4H/Bz4jCoKLLG3Wzl+bTG+/JEoR3HD4vRf61mOclgeIkRq/YA4Ns+tpYA6zo3Z7CdcKnPsBu1v/B1jj9FP7i/UGfyCDp/NXSYXXCNULNbUMjbiiuoQs5JaWXJCl2UWph7yaUIOGwt7CJCL7mnYyjHnKIySRiCWKOqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOHZAMRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B72C4CEFA;
	Tue,  2 Sep 2025 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802011;
	bh=LFeGHCO304zdeHgumCSjX6EUrk3szDEz7RjVAng3QuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rOHZAMRP/UBRLCKs4/YieUn0EkFRq9F1Tryx52shs/O5so9vD9YeiDJEgmKoTL8at
	 +ZjtmCrTiGx8w/R6Swu54MqPdvkNrb8TXx/jwzVR8uPCAhZef3ByCuJ96jfE8AaqAO
	 Mbtw0fNju+Dmpe17ShKQgX1RKOeNk0FwRNjiMQrsjhrmaFE67UJb7kqe8C8kUGyvSA
	 1U4V9lzPeC8XHHoPO01b1cUez2Uq+6QGfhFwxj+Tz4IM8VPClgOZvhKGi5a1C+COsR
	 BhdL5dJbxh0qZPC3CwG3/zXbLjOT+m+gz4Cm3pwj9tAzMBVRp93WChu8NuFz7CHAzF
	 VR1yTp/wtT7IA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:36 +0200
Subject: [PATCH 08/29] drm/atomic: Only call atomic_destroy_state on a
 !NULL pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-8-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3581; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LFeGHCO304zdeHgumCSjX6EUrk3szDEz7RjVAng3QuU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu+Qv9mXMrF1oWLUuV3n3mwL7aoOCTxYHfvGuWv1S
 oHoG3POdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ1C5irI/8zcvk0GiR8r5x
 8q91HDESKncyrtoEyDDN2fipLpzBKefuEt1H9dP+eVolPuHJ6j/lz9hwVeq7XvZW6dmOy8NW/D6
 fkazxNCyqoHlp7MYTb98ti7v+w7B10hKePQs5eLoDVr25zycMAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The drm_atomic_state structure is freed through the
drm_atomic_state_put() function, that eventually calls
drm_atomic_state_default_clear() by default when there's no active
users of that state.

It then iterates over all entities with a state, and will call the
atomic_destroy_state callback on the state pointer. The state pointer is
mostly used these days to point to which of the old or new state needs
to be freed, depending on whether the state was committed or not.

So it all makes sense.

However, with the hardware state readout support approaching, we might
have a state, with multiple entities in it, but no state to free because
we want them to persist. In such a case, state is going to be NULL, and
thus we'll end up with NULL pointer dereference.

In order to make it work, let's first test if the state pointer isn't
NULL before calling atomic_destroy_state on it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 38f2b2633fa992b3543e8c425c7faeab1ce69765..f26678835a94f40da56a8c1297d92f226d7ff2e2 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -249,12 +249,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_connector *connector = state->connectors[i].ptr;
 
 		if (!connector)
 			continue;
 
-		connector->funcs->atomic_destroy_state(connector,
-						       state->connectors[i].state);
+		if (state->connectors[i].state)
+			connector->funcs->atomic_destroy_state(connector,
+							       state->connectors[i].state);
+
 		state->connectors[i].ptr = NULL;
 		state->connectors[i].state = NULL;
 		state->connectors[i].old_state = NULL;
 		state->connectors[i].new_state = NULL;
 		drm_connector_put(connector);
@@ -264,12 +266,13 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_crtc *crtc = state->crtcs[i].ptr;
 
 		if (!crtc)
 			continue;
 
-		crtc->funcs->atomic_destroy_state(crtc,
-						  state->crtcs[i].state);
+		if (state->crtcs[i].state)
+			crtc->funcs->atomic_destroy_state(crtc,
+							  state->crtcs[i].state);
 
 		state->crtcs[i].ptr = NULL;
 		state->crtcs[i].state = NULL;
 		state->crtcs[i].old_state = NULL;
 		state->crtcs[i].new_state = NULL;
@@ -284,12 +287,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_plane *plane = state->planes[i].ptr;
 
 		if (!plane)
 			continue;
 
-		plane->funcs->atomic_destroy_state(plane,
-						   state->planes[i].state);
+		if (state->planes[i].state)
+			plane->funcs->atomic_destroy_state(plane,
+							       state->planes[i].state);
+
 		state->planes[i].ptr = NULL;
 		state->planes[i].state = NULL;
 		state->planes[i].old_state = NULL;
 		state->planes[i].new_state = NULL;
 	}
@@ -298,12 +303,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 		struct drm_private_obj *obj = state->private_objs[i].ptr;
 
 		if (!obj)
 			continue;
 
-		obj->funcs->atomic_destroy_state(obj,
-						 state->private_objs[i].state);
+		if (state->private_objs[i].state)
+			obj->funcs->atomic_destroy_state(obj,
+							       state->private_objs[i].state);
+
 		state->private_objs[i].ptr = NULL;
 		state->private_objs[i].state = NULL;
 		state->private_objs[i].old_state = NULL;
 		state->private_objs[i].new_state = NULL;
 	}

-- 
2.50.1


