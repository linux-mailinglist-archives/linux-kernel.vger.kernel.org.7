Return-Path: <linux-kernel+bounces-872987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74825C12C91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30071AA6BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F6242D84;
	Tue, 28 Oct 2025 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SzHxACLp"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550717C21E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622848; cv=none; b=Y5Z00YCyALj3GOaugCwu4B1OnS5TH6zzGAww0oMydvrBVCxW97vrLXSJkYvs06Wuwp8EbohK5WrhND1N6xZZ2EqL0b5r5aN79JsHvwZ29EJvB/WJ/mN6ldA4bNP4khjqaZSnMuFByLXW6JrvoUhnyWSotchWBmTJlOYQvjEMtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622848; c=relaxed/simple;
	bh=DNq4+3TXq9EfjM7kdNigYuP8GMWIJc/TUvBGaZPD+5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8MVCH1aH6CuFXGjabk1sqZLFOW/gQJsnxzIKV8fCJti+3LgTOVY+FkL5hoyo5wf+MEJH/zt7I2masq1Oih7+QS6Caz/4VT5MZANzhRoG9bb7vT8wfbpURcMm90e5oo8ANiP91yZZh6eY1aP+GqI3QXB9J5nFPEcnwnBpRePfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SzHxACLp; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59S3e8i31399677;
	Mon, 27 Oct 2025 22:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761622808;
	bh=8YsUL3FmjkiSJTuL3XXGj1pESxfnhDNRpNWlSDg3YYA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SzHxACLpIScA45hT2Z8iRmwYYxDbK8UfrpV9X1ifwCBIjuvYap0SuwMWa30Q8wG9E
	 hPAIzDztRn4yfK+mkXAOu1gmbQCT+zw5tR0gJg+z7rMHYN5Cg4nRLtA/cN1cu/sAAg
	 qvQZj1B00tk9+faE5xdwKyD0uk9sYnBCWDmRHvG0=
Received: from DFLE201.ent.ti.com (dfle201.ent.ti.com [10.64.6.59])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59S3e81t1393714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 22:40:08 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 22:40:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 22:40:08 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59S3dxWT1685770;
	Mon, 27 Oct 2025 22:40:04 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <mripard@kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <simona@ffwll.ch>,
        <airlied@gmail.com>, <tzimmermann@suse.de>, <h-shenoy@ti.com>
CC: <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <s-jain1@ti.com>
Subject: [RESEND PATCH v7 1/2] drm/tidss: Remove max_pclk_khz and min_pclk_khz from tidss display features
Date: Tue, 28 Oct 2025 09:09:57 +0530
Message-ID: <20251028033958.369100-2-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028033958.369100-1-s-jain1@ti.com>
References: <20251028033958.369100-1-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Jayesh Choudhary <j-choudhary@ti.com>

The TIDSS hardware does not have independent maximum or minimum pixel
clock limits for each video port. Instead, these limits are determined
by the SoC's clock architecture. Previously, this constraint was
modeled using the 'max_pclk_khz' and 'min_pclk_khz' fields in
'dispc_features', but this approach is static and does not account for
the dynamic behavior of PLLs.

This patch removes the 'max_pclk_khz' and 'min_pclk_khz' fields from
'dispc_features'. The correct way to check if a requested mode's pixel
clock is supported is by using 'clk_round_rate()' in the 'mode_valid()'
hook. If the best frequency match for the mode clock falls within the
supported tolerance, it is approved. TIDSS supports a 5% pixel clock
tolerance, which is now reflected in the validation logic.

This change allows existing DSS-compatible drivers to be reused across
SoCs that only differ in their pixel clock characteristics. The
validation uses 'clk_round_rate()' for each mode, which may introduce
additional delay (about 3.5 ms for 30 modes), but this is generally
negligible. Users desiring faster validation may bypass these calls
selectively, for example, checking only the highest resolution mode,
as shown here[1].

[1]: https://lore.kernel.org/all/20250704094851.182131-3-j-choudhary@ti.com/

Tested-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 85 ++++++++++-------------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  3 -
 2 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index d0b191c470ca..07731b02490f 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -57,12 +57,6 @@ static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 };
 
 const struct dispc_features dispc_k2g_feats = {
-	.min_pclk_khz = 4375,
-
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 150000,
-	},
-
 	/*
 	 * XXX According TRM the RGB input buffer width up to 2560 should
 	 *     work on 3 taps, but in practice it only works up to 1280.
@@ -145,11 +139,6 @@ static const u16 tidss_am65x_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 };
 
 const struct dispc_features dispc_am65x_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 165000,
-		[DISPC_VP_OLDI_AM65X] = 165000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 1280,
 		.in_width_max_3tap_rgb = 2560,
@@ -245,11 +234,6 @@ static const u16 tidss_j721e_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 };
 
 const struct dispc_features dispc_j721e_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 170000,
-		[DISPC_VP_INTERNAL] = 600000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 2048,
 		.in_width_max_3tap_rgb = 4096,
@@ -316,11 +300,6 @@ const struct dispc_features dispc_j721e_feats = {
 };
 
 const struct dispc_features dispc_am625_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 165000,
-		[DISPC_VP_INTERNAL] = 170000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 1280,
 		.in_width_max_3tap_rgb = 2560,
@@ -377,15 +356,6 @@ const struct dispc_features dispc_am625_feats = {
 };
 
 const struct dispc_features dispc_am62a7_feats = {
-	/*
-	 * if the code reaches dispc_mode_valid with VP1,
-	 * it should return MODE_BAD.
-	 */
-	.max_pclk_khz = {
-		[DISPC_VP_TIED_OFF] = 0,
-		[DISPC_VP_DPI] = 165000,
-	},
-
 	.scaling = {
 		.in_width_max_5tap_rgb = 1280,
 		.in_width_max_3tap_rgb = 2560,
@@ -442,10 +412,6 @@ const struct dispc_features dispc_am62a7_feats = {
 };
 
 const struct dispc_features dispc_am62l_feats = {
-	.max_pclk_khz = {
-		[DISPC_VP_DPI] = 165000,
-	},
-
 	.subrev = DISPC_AM62L,
 
 	.common = "common",
@@ -1333,33 +1299,53 @@ static void dispc_vp_set_default_color(struct dispc_device *dispc,
 			DISPC_OVR_DEFAULT_COLOR2, (v >> 32) & 0xffff);
 }
 
+/*
+ * Calculate the percentage difference between the requested pixel clock rate
+ * and the effective rate resulting from calculating the clock divider value.
+ */
+unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate)
+{
+	int r = rate / 100, rr = real_rate / 100;
+
+	return (unsigned int)(abs(((rr - r) * 100) / r));
+}
+
+static int check_pixel_clock(struct dispc_device *dispc,
+			     u32 hw_videoport, unsigned long clock)
+{
+	unsigned long round_clock;
+
+	round_clock = clk_round_rate(dispc->vp_clk[hw_videoport], clock);
+	/*
+	 * To keep the check consistent with dispc_vp_set_clk_rate(), we
+	 * use the same 5% check here.
+	 */
+	if (dispc_pclk_diff(clock, round_clock) > 5)
+		return -EINVAL;
+	return 0;
+}
+
 enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 u32 hw_videoport,
 					 const struct drm_display_mode *mode)
 {
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 	enum dispc_vp_bus_type bus_type;
-	int max_pclk;
 
 	bus_type = dispc->feat->vp_bus_type[hw_videoport];
 
-	max_pclk = dispc->feat->max_pclk_khz[bus_type];
-
-	if (WARN_ON(max_pclk == 0))
+	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
 		return MODE_BAD;
 
-	if (mode->clock < dispc->feat->min_pclk_khz)
-		return MODE_CLOCK_LOW;
-
-	if (mode->clock > max_pclk)
-		return MODE_CLOCK_HIGH;
-
 	if (mode->hdisplay > 4096)
 		return MODE_BAD;
 
 	if (mode->vdisplay > 4096)
 		return MODE_BAD;
 
+	if (check_pixel_clock(dispc, hw_videoport, mode->clock * 1000))
+		return MODE_CLOCK_HIGH;
+
 	/* TODO: add interlace support */
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		return MODE_NO_INTERLACE;
@@ -1423,17 +1409,6 @@ void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport)
 	clk_disable_unprepare(dispc->vp_clk[hw_videoport]);
 }
 
-/*
- * Calculate the percentage difference between the requested pixel clock rate
- * and the effective rate resulting from calculating the clock divider value.
- */
-unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate)
-{
-	int r = rate / 100, rr = real_rate / 100;
-
-	return (unsigned int)(abs(((rr - r) * 100) / r));
-}
-
 int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 			  unsigned long rate)
 {
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 60c1b400eb89..42279312dcc1 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -77,9 +77,6 @@ enum dispc_dss_subrevision {
 };
 
 struct dispc_features {
-	int min_pclk_khz;
-	int max_pclk_khz[DISPC_VP_MAX_BUS_TYPE];
-
 	struct dispc_features_scaling scaling;
 
 	enum dispc_dss_subrevision subrev;

