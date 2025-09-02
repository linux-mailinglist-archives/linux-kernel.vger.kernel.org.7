Return-Path: <linux-kernel+bounces-795841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E9DB3F89E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0210485B21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D72EA178;
	Tue,  2 Sep 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLwRQkRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5202EA16D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802006; cv=none; b=m3uH23TKOjad3sy4iZgCxtPtcEvz4QXNIZof/d2AOGK4KVkloliycXXDYUWAwKNIeWk05uLjkQ1dsII1CqJjAjOyHI6EEAayYNlPiSCRsDljtzcS1Dfhs9BoQgwFjtRPauyEfQJVqQSgOHA41MO+7zXPlLBEJIyQXMf6O9uTcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802006; c=relaxed/simple;
	bh=dxIMcnZXqFeVSb69JHsUsUX0GPYjiSufclb+3jXwpPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INrRuWTIEovVNEtyF+9xFrIHZ3DRZZBYnBNSqbNBClEr6xVeb7b/ShTzUI+XN57pEicSgCbVy6Rq/uckXnQwYRY5pLbyH3nC6nsHPtseguhctUNE6PHCl4IDmOZ+5ngvD/ZVYKsa/bCj12ujrDfy7zkvxjxRmN9ZHhwm4VCHP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLwRQkRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF74C4CEF8;
	Tue,  2 Sep 2025 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802006;
	bh=dxIMcnZXqFeVSb69JHsUsUX0GPYjiSufclb+3jXwpPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RLwRQkRkACo8pJRB/IOaydCjEX9xJZO0bdZN0LzGLB4IdrnEX2pQotjgtbY4xlyUW
	 QANwKYBfKiCu74x8HEf8s8GF94BqDmCJOvwNXZ0HkLasguNGBnlmyuC+G1xwm6f237
	 hFu6JaEqQjuBwOEmqRyyZcLubz0siwI6ziRshnMfOC4x6djhNn6ugvj5uJgXRrNwYD
	 1+eE67KVo5bwJqnHyQ0/0etHAOJAa05is/4HE0d/cXSpaqk6nBF7aJwj8trVMSurFz
	 NIIQ2rVR1TEs5iSIKArbOCkHpVQ6eXoz3yzssAfTRxv/8lgJ3NBd7rFVJuqIUdj5IX
	 oxA9TGheorNbA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:34 +0200
Subject: [PATCH 06/29] drm/bridge: Implement atomic_print_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-6-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dxIMcnZXqFeVSb69JHsUsUX0GPYjiSufclb+3jXwpPk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVm93P2Qj3zpBa+Nan9cH/k6eHX7So2Azw9FM74QfV
 zm+rzhyrGMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBM5JE6Y31YjCkbr7K8zbPi
 N4ePhexQ/ju56ezvTZk+is3CtUk7TJJ4/hmHcH3qVv58XXrDqq9xgowNsx9Yz3ebrl9ztibjML9
 6ePSv/Vf/P1JTaXJW0/yjKuKgkVH/x+hOAROfgavvhdKVC8sB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Bridges have some fields in their state worth printing, but we don't
provide an atomic_print_state implementation to show those fields.

Let's do so.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index dd439d55177a867acb7ab73c02182bada44d93c9..e803dfd8fd5aae9c16931445213df04d8715b9f6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -370,13 +370,31 @@ drm_bridge_atomic_destroy_priv_state(struct drm_private_obj *obj,
 	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
 
 	bridge->funcs->atomic_destroy_state(bridge, state);
 }
 
+static void
+drm_bridge_atomic_print_priv_state(struct drm_printer *p,
+				   const struct drm_private_state *s)
+{
+	const struct drm_bridge_state *state =
+		container_of_const(s, struct drm_bridge_state, base);
+	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
+
+	drm_printf(p, "bridge: %s", drm_get_connector_type_name(bridge->type));
+	drm_printf(p, "\tinput bus configuration:");
+	drm_printf(p, "\t\tcode: %04x", state->input_bus_cfg.format);
+	drm_printf(p, "\t\tflags: %08x", state->input_bus_cfg.flags);
+	drm_printf(p, "\toutput bus configuration:");
+	drm_printf(p, "\t\tcode: %04x", state->output_bus_cfg.format);
+	drm_printf(p, "\t\tflags: %08x", state->output_bus_cfg.flags);
+}
+
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
+	.atomic_print_state = drm_bridge_atomic_print_priv_state,
 };
 
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
 	return bridge->funcs->atomic_reset != NULL;

-- 
2.50.1


