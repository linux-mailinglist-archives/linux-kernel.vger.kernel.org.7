Return-Path: <linux-kernel+bounces-795861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B9B3F8B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6802A172558
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F22ECD2C;
	Tue,  2 Sep 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE9wNu6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761152ECD20
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802056; cv=none; b=NOhiTk6nZSTOMfs+gZ4NnmvUknxzDN4oe56bfUGdQIU6TeUQ8i4BKg+N6ugPr4WwkU54lEGYA49o9jt3YIwe4/8dbecJOdL0cYrEnlRWkXdnFoJahIl1E7UG9v9Eq+0iogPbeI7SgCrR4ho2yiHgBUpazokjFHwgRjQu8H9QgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802056; c=relaxed/simple;
	bh=rt6xHw1/6F4wIZvvIQx12pdyMgsEZs64/BuHhHgoQwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skpyybpHaoVgQllpCzXeJxbEz/gKdZqK4Tj8QLokHclhhT6SaUMisqSqdecJovEGk0nU2E0pMhdJm+2WfZLuW8EZlx7tycdWO1sybPlJj9FjHYtESU5tS3Rsyi/n6XQw7m70cSIqm7jGBPB8TRSvXBW9/XKuA+EGI969KkHkjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE9wNu6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A02C4CEED;
	Tue,  2 Sep 2025 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802056;
	bh=rt6xHw1/6F4wIZvvIQx12pdyMgsEZs64/BuHhHgoQwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OE9wNu6Fow/wzbcDKpaesIgEoPQDBgwiy3phinjKnfBpJjNYcFqDTaZHjgx22BYrn
	 JuRDoSEXIkqzW0itymk/DH6pMziXluwWwdzaK+iVXOJTtTSQsRvv1yfW/ujpHICsQ0
	 q4T+b0VOivpxSLB+1qqJILq4qz0cO96bawJs0sp8Zq+p94icSWLdxcEb76PA1qPFhR
	 4Q2iGyB7eCWpA/9EEsruBBG8cW3I8eIZBu1ihtV/lcSFyxxqcQQRnXDTwbQeAFPxXy
	 m3U5PqVjikq9gendmC5hS6dHCOJoUY4BJOEDz5UJqXN4CvKvEMtsGwr5WwyA+Vy/69
	 /0D9ukBT7+UuA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:53 +0200
Subject: [PATCH 25/29] drm/tidss: dispc: Move dispc_device definition to
 headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-25-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rt6xHw1/6F4wIZvvIQx12pdyMgsEZs64/BuHhHgoQwY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu9vWbVg48IHYQnLPijEmvWE2DJstFfbbHFAdnr2j
 U3qJgwzO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEFu5irE/61DHnc6/J/VVS
 s56FM9Wvz+cTep4wMWl26IcmAfsrE+96Lti571nNreyAyQl9J8/tj2BsuFGn7jBlyck5LZu2met
 f/nS6tM74UY9ewYQeyz1dlZ97/CV37Up1TVi52KFgps8lCxklAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We'll need to access the dispc_device structure from other parts of the
driver so let's move it to a header.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 33 ---------------------------------
 drivers/gpu/drm/tidss/tidss_dispc.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index ef948e3041e10bc65cf2c4794a4e4cffa7e3fb3a..2f9cf95d6d0525a02d8adaae968aa551b7e27077 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -476,43 +476,10 @@ const struct dispc_features dispc_am62l_feats = {
 	.vid_order = {0},
 };
 
 static const u16 *dispc_common_regmap;
 
-struct dss_vp_data {
-	u32 *gamma_table;
-};
-
-struct dispc_device {
-	struct tidss_device *tidss;
-	struct device *dev;
-
-	void __iomem *base_common;
-	void __iomem *base_vid[TIDSS_MAX_PLANES];
-	void __iomem *base_ovr[TIDSS_MAX_PORTS];
-	void __iomem *base_vp[TIDSS_MAX_PORTS];
-
-	struct regmap *am65x_oldi_io_ctrl;
-
-	struct clk *vp_clk[TIDSS_MAX_PORTS];
-
-	const struct dispc_features *feat;
-
-	struct clk *fclk;
-
-	bool is_enabled;
-
-	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
-
-	u32 *fourccs;
-	u32 num_fourccs;
-
-	u32 memory_bandwidth_limit;
-
-	struct dispc_errata errata;
-};
-
 static void CH(struct dispc_device *dispc)
 {
 	WARN_ON((dispc->dev->power.runtime_status != RPM_ACTIVE) &&
 		(dispc->dev->power.runtime_status != RPM_RESUMING) &&
 		(dispc->dev->power.runtime_status != RPM_SUSPENDING));
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 849ec984026e223de7c8a55a4b5672c2262f38c0..f5d5798de1ba550dedbcba36b1ef41d5ecceaa0c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -95,10 +95,43 @@ struct dispc_features {
 	u32 num_vids;
 	struct dispc_vid_info vid_info[TIDSS_MAX_PLANES];
 	u32 vid_order[TIDSS_MAX_PLANES];
 };
 
+struct dss_vp_data {
+	u32 *gamma_table;
+};
+
+struct dispc_device {
+	struct tidss_device *tidss;
+	struct device *dev;
+
+	void __iomem *base_common;
+	void __iomem *base_vid[TIDSS_MAX_PLANES];
+	void __iomem *base_ovr[TIDSS_MAX_PORTS];
+	void __iomem *base_vp[TIDSS_MAX_PORTS];
+
+	struct regmap *am65x_oldi_io_ctrl;
+
+	struct clk *vp_clk[TIDSS_MAX_PORTS];
+
+	const struct dispc_features *feat;
+
+	struct clk *fclk;
+
+	bool is_enabled;
+
+	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
+
+	u32 *fourccs;
+	u32 num_fourccs;
+
+	u32 memory_bandwidth_limit;
+
+	struct dispc_errata errata;
+};
+
 extern const struct dispc_features dispc_k2g_feats;
 extern const struct dispc_features dispc_am625_feats;
 extern const struct dispc_features dispc_am62a7_feats;
 extern const struct dispc_features dispc_am62l_feats;
 extern const struct dispc_features dispc_am65x_feats;

-- 
2.50.1


