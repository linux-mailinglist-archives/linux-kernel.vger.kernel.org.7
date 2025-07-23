Return-Path: <linux-kernel+bounces-742262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E33B0EF52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B607B9297
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8328C869;
	Wed, 23 Jul 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZwBw95Rm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938228C029
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265143; cv=none; b=HOTQGG8t4TGc7zto5+W4IhZOuEzL0MrKWH6MVMlwldfIxlU/vu94KSH/WQGqS2N6hzeVkBIU3EsfkSRYDcL61lstyPNU304ezPQgYpJh5OtHIFjIZVi7beRX2WLGDQDJ2IOBe2iAvFXcudWjxmG+nC0mFsx7Vy5WETo9xrInlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265143; c=relaxed/simple;
	bh=ORJ+r9QXRlTePgAiA6Oc9ykTVuz6BMPrXnHDUBW7+tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ggj4OrRCqYFEuUuzyL0ad9Fa7G9vGdJWydR4KEApPt/i9uuSBjRciHpgjEWA9RW2Q3pnOqSpkmEgLmhM/p1S65qgsyT4iRBaKzNsLPrXLe4PDYye1ygjcGwI9UlLYKOc1Jw+oMgc9yKoQmo0yFEK67rujair7UTcqF3NrT0r0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZwBw95Rm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2C6BF0B;
	Wed, 23 Jul 2025 12:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265100;
	bh=ORJ+r9QXRlTePgAiA6Oc9ykTVuz6BMPrXnHDUBW7+tA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZwBw95RmpEJaC4q9D0iCiR3XOHlc5Eke5Y1lPizelg4h3jhxfsDa09QGaScgRs+Xu
	 g7UuCo0KAl06l6wl+kwJiZsyjs73D6RW76WWYrV21AbobbaLNgcK3BHnP2V0gfHG/T
	 47UiPbsU9pffBjoyQW/TvOZUFHp+BqHCobmmt1cw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:08 +0300
Subject: [PATCH v5 02/15] drm/tidss: Fix missing includes and struct decls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-2-e61cc06074c2@ideasonboard.com>
References: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
In-Reply-To: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ORJ+r9QXRlTePgAiA6Oc9ykTVuz6BMPrXnHDUBW7+tA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPp6kU/4JIExEPKogdspBc6ktmg57XLDNNpo
 iOOklnleBuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6QAKCRD6PaqMvJYe
 9aDUD/4s3YKIhT5PfWB6Fy4SGIOCjBhxa2MDayzUI4BoaHAjSEuJ4O1G2T73C3FWVLOlKjdtxL+
 tnDLofKetsbnw/HDU1YdPtm8gbPhScEJP4uHL6MKTPSD1CJEd/aq4HKlzh3KTkLNsrXZkCVt0il
 QSBhpn6VLauVh85jUiDKyOR4ARqIOSUU/Nf1VPn5YBKWHsvOh8pjwx5LXiD3YoRXoXpC8JtvZ1r
 VnCSHpTlqzo3NKsj4BSaqk7bEn7QZL/2EjSZrbzSMf+zroAUUwV1Xoeqbv8rAF8myyEnE+/pwIE
 ORs6q4Bgz0H9el1oWUPTZUD4AdCN1zL7BUPQvcLuXii5hzDlFeTXxviZJWDBgJjSL8qaUplp6Dt
 VcvAwJD7cQLyBie737+yqBP4yXlVSsCw1emL99WrEGRD3fDEUJ5ugxlPbe40o6QuJmVxJUe7K2o
 /a8K27ftRdTheuGdQz6Kv8KwrNNO4Zkq7ki7j9EVTsdel83XbyWAG2GDBW1NQe1T7ovT7gl1q02
 7HHjhgng/B8NsKTUbvZVdgtFyLS12lkJwWXw7WA7VsZATkQPsODU4nkWzW0N6OBbbJvSK0H2vtA
 sldzNcTS5M+mfmrJuo7q2bczzxdIR1ZPXktZEC0+ODbqomNYHqmpZnA1sE7VqR6MFqZr2n6+iZj
 2AX71AJqsUl87uw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Fix missing includes and struct declarations. Even if these don't cause
any compile issues at the moment, it's good to have them correct.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.h       | 3 +++
 drivers/gpu/drm/tidss/tidss_drv.h         | 2 ++
 drivers/gpu/drm/tidss/tidss_plane.h       | 2 ++
 drivers/gpu/drm/tidss/tidss_scale_coefs.h | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index b8614f62186c..60c1b400eb89 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -7,11 +7,14 @@
 #ifndef __TIDSS_DISPC_H__
 #define __TIDSS_DISPC_H__
 
+#include <drm/drm_color_mgmt.h>
+
 #include "tidss_drv.h"
 
 struct dispc_device;
 
 struct drm_crtc_state;
+struct drm_plane_state;
 
 enum tidss_gamma_type { TIDSS_GAMMA_8BIT, TIDSS_GAMMA_10BIT };
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
index d14d5d28f0a3..84454a4855d1 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.h
+++ b/drivers/gpu/drm/tidss/tidss_drv.h
@@ -9,6 +9,8 @@
 
 #include <linux/spinlock.h>
 
+#include <drm/drm_device.h>
+
 #define TIDSS_MAX_PORTS 4
 #define TIDSS_MAX_PLANES 4
 #define TIDSS_MAX_OLDI_TXES 2
diff --git a/drivers/gpu/drm/tidss/tidss_plane.h b/drivers/gpu/drm/tidss/tidss_plane.h
index aecaf2728406..92c560c3a621 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.h
+++ b/drivers/gpu/drm/tidss/tidss_plane.h
@@ -7,6 +7,8 @@
 #ifndef __TIDSS_PLANE_H__
 #define __TIDSS_PLANE_H__
 
+#include <drm/drm_plane.h>
+
 #define to_tidss_plane(p) container_of((p), struct tidss_plane, plane)
 
 struct tidss_device;
diff --git a/drivers/gpu/drm/tidss/tidss_scale_coefs.h b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
index 9c560d0fdac0..9824d02d9d1f 100644
--- a/drivers/gpu/drm/tidss/tidss_scale_coefs.h
+++ b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
@@ -9,6 +9,8 @@
 
 #include <linux/types.h>
 
+struct device;
+
 struct tidss_scale_coefs {
 	s16 c2[16];
 	s16 c1[16];

-- 
2.43.0


