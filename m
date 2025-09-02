Return-Path: <linux-kernel+bounces-795834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB21B3F87E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90161A84067
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B22E8B93;
	Tue,  2 Sep 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbrmIWsV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C2270576
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801992; cv=none; b=dR8KNIn1tBX9YIhQpS7FHnsxTrSqNkWYRlm1eNpMOIkzJHWnmKkYISCzNpnPFXanOsppKTKqVffHkmHjHS+eOvJulinBJutJa7LWKCn4bP2ncvH4hKc/xgQkgD/6GhDStl8VRBQYH9qbU72POeuiys89Dmr73krltSF1Rh383Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801992; c=relaxed/simple;
	bh=RSw/FevPuIg72kLXYX+y6FE8T6rOeXx1VhHt9C78V7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAqrnmKzHkDQ2D2GlNg7w024Qjfd922MD9FnFCxeFOYxLQUw7ACUS9LNGMQM/7C7ohh2KvOF2v73tRwearKKhNSdPyfiJeXcZDeZlkChzUOKe7g4KnkI2wesSnU6m0cOvyK6Of7N+DAbZGaBH+PdHcChHVvMJVzZjIRBaI30/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbrmIWsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99999C4CEF5;
	Tue,  2 Sep 2025 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801991;
	bh=RSw/FevPuIg72kLXYX+y6FE8T6rOeXx1VhHt9C78V7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WbrmIWsVxfHKK/d2jEVc/uodasQaXUxSPenru2Sn8bPUmc7lY/els15Tr/ze+Qb3k
	 G+TO8bbbuQ6hxyOE+WstZedrxyQx9be52h+G4IsXZEuJTgrCBJbxW9SMkN47u2FZco
	 efOxGr7BpmEUGFN8u4+WhGokvYzvFRjNXJmnvxxnIxaxxfImQW5gRYSFb5QDve9Hpq
	 1i4vk+EPbAHfavbvgIMkHpA2p5KE3Q9fw+S/sBYcaZQU03gMdGXFHlOmAXJueatuA1
	 Yb2evOmGFr7hpkY9bi1IxfWgBUQFCNjmhgbjbznsQzZSl5gRwz1Y1co33CaSqiHLEV
	 ytDu1Lqs+zipg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:29 +0200
Subject: [PATCH 01/29] drm/atomic: Document atomic state lifetime
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-1-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3774; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RSw/FevPuIg72kLXYX+y6FE8T6rOeXx1VhHt9C78V7E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVm+1FDpzW7NSZoNK288LE1UDtSPzzu6+73jK7ce6Z
 6GXJabt7JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+cLBWF8w4Ylg6Qq2+2Yf
 Vgium5h0f94t0Tuqr5ctjXOubktqWfZXOkR0ak906r7d5tqW/zRcXjA2tFvnnek4yT/tceDk0NC
 Hrzacl2i9HfalbPVJw7OlzRWH42cvPvZj6kenG9FHuCKbWUtkAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

How drm_atomic_state structures and the various entity structures are
allocated and freed isn't really trivial, so let's document it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/drm-kms.rst |  6 ++++++
 drivers/gpu/drm/drm_atomic.c  | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index abfe220764e1edc758a6bc6fb5ff9c8e1c7749ff..dc0f61a3d29e752889077d855a4bea381f2e2c18 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -280,10 +280,16 @@ structure, ordering of committing state changes to hardware is sequenced using
 :c:type:`struct drm_crtc_commit <drm_crtc_commit>`.
 
 Read on in this chapter, and also in :ref:`drm_atomic_helper` for more detailed
 coverage of specific topics.
 
+Atomic State Lifetime
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic.c
+   :doc: state lifetime
+
 Handling Driver Private State
 -----------------------------
 
 .. kernel-doc:: drivers/gpu/drm/drm_atomic.c
    :doc: handling driver private state
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index cd15cf52f0c9144711da5879da57884674aea9e4..b356d26faad4acaa25c1fe6f9bd5043b6364ce87 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -44,10 +44,55 @@
 #include <drm/drm_writeback.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
 
+/**
+ * DOC: state lifetime
+ *
+ * &struct drm_atomic_state represents an update to video pipeline state.
+ *
+ * Its lifetime is:
+ *
+ * - at reset time, the entity reset implementation will allocate a
+ *   new, default, state and will store it in the entity state pointer.
+ *
+ * - whenever a new update is needed:
+ *
+ *   + we allocate a new &struct drm_atomic_state using drm_atomic_state_alloc().
+ *
+ *   + we copy the state of each affected entity into our &struct
+ *     drm_atomic_state using drm_atomic_get_plane_state(),
+ *     drm_atomic_get_crtc_state(), drm_atomic_get_connector_state(), or
+ *     drm_atomic_get_private_obj_state(). That state can then be
+ *     modified.
+ *
+ *     At that point, &struct drm_atomic_state stores three state
+ *     pointers for that particular entity: the old, new, and existing
+ *     (called "state") states. The old state is the state currently
+ *     active in the hardware, ie either the one initialized by reset()
+ *     or a newer one if a commit has been made. The new state is the
+ *     state we just allocated and we might eventually commit to the
+ *     hardware. The existing state points to the state we'll eventually
+ *     have to free, the new state for now.
+ *
+ *   + Once we run a commit, it is first checked and if the check is
+ *     successful, it is committed. Part of the commit is a call to
+ *     drm_atomic_helper_swap_state() which will turn the new state into
+ *     the active state. Doing so involves updating the entity state
+ *     pointer (&drm_crtc.state or similar) to point to the new state,
+ *     and the existing state will now point to the old state, that used
+ *     to be active but isn't anymore.
+ *
+ *   + When the commit is done, and when all references to our &struct
+ *     drm_atomic_state are put, drm_atomic_state_clear() runs and will
+ *     free all the old states.
+ *
+ *   + Now, we don't have any active &struct drm_atomic_state anymore,
+ *     and only the entity active states remain allocated.
+ */
+
 void __drm_crtc_commit_free(struct kref *kref)
 {
 	struct drm_crtc_commit *commit =
 		container_of(kref, struct drm_crtc_commit, ref);
 

-- 
2.50.1


