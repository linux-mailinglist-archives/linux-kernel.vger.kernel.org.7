Return-Path: <linux-kernel+bounces-795842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA6B3F89F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41337204478
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158412EA17F;
	Tue,  2 Sep 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVDAv5rs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBF2EA17E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802010; cv=none; b=Zvp07FbJaKPEE0XwhV8gSyMyU0HAIjNNiMfUhAtjwp7MuC7ilZjKz2+dJ87r9vtF6C+KdQXEMffYDorTmPoEnnQupoG+kg88fbp+buLZf+9UDByrJcrXkete+V4HZLE/h2v1dGNyRY2Kj0xc1KPrH4ZxvN0rntjzfl93Jyq1JBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802010; c=relaxed/simple;
	bh=1R/cmhynuL7ZkKUF0HfDvx8YnoSqeyk82pR1KuKcrL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7nUapiFdj0N+5YrLp04SaEexg+YpCUCWgV66Ggl+37Hr1/EydvgZcGQtHq0PpSiuZrI8htK25pERG8DcZ5mz5uK1dro//zJnpXST8SqTuNXJ3YaUc1nCAIha6Ziw67RbqHHKLyIyfbDlZEIfWC/D2PkMyuh8eGrittzTSrwLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVDAv5rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F0C4CEF7;
	Tue,  2 Sep 2025 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802008;
	bh=1R/cmhynuL7ZkKUF0HfDvx8YnoSqeyk82pR1KuKcrL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVDAv5rsYs5Eg2FMQbAnvGb/nmo0/W1SCh+813xyTz0ayU50iPpplEQOh+VWYZy64
	 sm1ap9xpC4Da6PvBWw5jDvru+wpLDM/2LWu0Mb878h2ZCj8EU7KSBUukSOJCvd9B+z
	 4a5piVrvodkd3KIDZ47tk/uOPulwzjyKGGjEBTb/wWs1zFeQZaXfYOp4MUhAVwmFQ1
	 JgOXVfWP4MJZeJGnmvKYujVOjT2D7S8h/tSXDE/d3o1iPKwojKncoVuzeiXKsptcSZ
	 mmO85QXTe+pLOHOHr7vakv/0QXLWR8388MZJvpfqoLixY6lne0Du6amRlrWGca8xYm
	 g3LTEk75Z5jIg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:35 +0200
Subject: [PATCH 07/29] drm/atomic: Implement drm_atomic_print_old_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-7-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1R/cmhynuL7ZkKUF0HfDvx8YnoSqeyk82pR1KuKcrL0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVm9/c31t2Dx/6at9gnwPTixN2/RMXiL83dzp0WceK
 z/VLIni6ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATUf3PWJ9T7tX42PfpbKcn
 iquSluzj8j3qc/hQqo3T0dkZ/qFCDmc0jXWmFT9StJUr+7+YbY70T8aGB04uqnuDJhc7K+cxTPD
 OPHfK79xnjqPTtl6verjgVnPzPa34Ux1J259PEnXYY7y7Su8KAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We currently have a helper to print the new states associated to a
drm_atomic_state, but we don't have a variant to print the old state.

It's somewhat expected, since we almost never care about what the new
state looks like when we commit a new state, but we're about to change
that.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c        | 45 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_crtc_internal.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9b198610791d19c7fd276ca59264a961d21caf43..38f2b2633fa992b3543e8c425c7faeab1ce69765 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1875,10 +1875,55 @@ void drm_atomic_print_new_state(const struct drm_atomic_state *state,
 	for_each_new_private_obj_in_state(state, obj, obj_state, i)
 		drm_atomic_private_obj_print_state(p, obj_state);
 }
 EXPORT_SYMBOL(drm_atomic_print_new_state);
 
+/**
+ * drm_atomic_print_old_state - prints drm atomic state
+ * @state: atomic configuration to check
+ * @p: drm printer
+ *
+ * This functions prints the drm atomic state snapshot using the drm printer
+ * which is passed to it. This snapshot can be used for debugging purposes.
+ *
+ * Note that this function looks into the old state objects and hence its not
+ * safe to be used after the call to drm_atomic_helper_commit_hw_done().
+ */
+void drm_atomic_print_old_state(const struct drm_atomic_state *state,
+		struct drm_printer *p)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	struct drm_connector_state *connector_state;
+	struct drm_private_obj *obj;
+	struct drm_private_state *obj_state;
+	int i;
+
+	if (!p) {
+		drm_err(state->dev, "invalid drm printer\n");
+		return;
+	}
+
+	drm_dbg_atomic(state->dev, "checking %p\n", state);
+
+	for_each_old_plane_in_state(state, plane, plane_state, i)
+		drm_atomic_plane_print_state(p, plane_state);
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i)
+		drm_atomic_crtc_print_state(p, crtc_state);
+
+	for_each_old_connector_in_state(state, connector, connector_state, i)
+		drm_atomic_connector_print_state(p, connector_state);
+
+	for_each_old_private_obj_in_state(state, obj, obj_state, i)
+		drm_atomic_private_obj_print_state(p, obj_state);
+}
+EXPORT_SYMBOL(drm_atomic_print_old_state);
+
 static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 			     bool take_locks)
 {
 	struct drm_mode_config *config = &dev->mode_config;
 	struct drm_plane *plane;
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 89706aa8232fc0b2830af67c7588985a29653299..a8139fda1a1015c2ac8d8af3b12c5ac0b00cfc1a 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -249,10 +249,12 @@ int __drm_atomic_helper_disable_plane(struct drm_plane *plane,
 int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 				   struct drm_atomic_state *state);
 
 void drm_atomic_print_new_state(const struct drm_atomic_state *state,
 		struct drm_printer *p);
+void drm_atomic_print_old_state(const struct drm_atomic_state *state,
+				struct drm_printer *p);
 
 /* drm_atomic_uapi.c */
 int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 				     struct drm_connector *connector,
 				     int mode);

-- 
2.50.1


