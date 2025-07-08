Return-Path: <linux-kernel+bounces-721889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27250AFCF1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2CF18969A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096592E174A;
	Tue,  8 Jul 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QZeV6BBe"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5932E0412
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988348; cv=none; b=P+WqoucB5d3NP3RZpZlk0PEm1PZHZEWLG6ga5fOZQYel5ego+PTm90DlyobNd582tCqSwxoLimTSblIe6OSlJxQNhndeFnvG6kvQAcYd1j/e3ojINKAKP1tWJQB8cHwwzIlT0hdN0Pq/seS3wNDkotLFMzdIUjtEmzs4o4nESJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988348; c=relaxed/simple;
	bh=8WRCqiYzHM/4HvNVgM1G0kbo4E5btQncRscglNhiMl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYUwBWe8aE+opsLYJwpywx7QyRE4UCbpHCK+thBTfaTHcX84vfhRTnnOXQ47YqrJBQA/y2/9MizYUDBFiMZOJXCjF66xVRmQajFTC14DcHVe+PExfQygdBv12j1+loH5RZclbe7W5j6ZtVnHFQTRc1sNFDiOBAqDK8mmVQJcGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QZeV6BBe; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEE91443E4;
	Tue,  8 Jul 2025 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751988338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdiALbMjSC98BQrOYTgMnjsehTN/QLAP4GL7RBITAns=;
	b=QZeV6BBeqkeibFaCyYZoUTZYydxY55aEg9fjreHnmqR/ey1qV5uSq5qeAP7ZIAMiNKS31q
	IhtzUrcG89Olm4XAaGV/d54wTwZc11mpCB7IQYlT/itEmuMshaLw1aD/aRP5/TAwfu1N6R
	b0cQNGqNsWoZG/nXJxDrYmLL4S3KFAoJK1rkmaplFstUY2NTktLlOfDUNfrirf8tLFlRPk
	9XqywYBDauGi2GIc8if6F+V6s8Zu5W3sslToUMBa2CZIvvgWgtCep7ETmzkcwBck2fk96O
	F58dwC3uAXOt6ejjsyIh31xNWQwEbsy9YtF7f0Ty57LGbjI3KA8/xwBrYY9s7g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 08 Jul 2025 17:24:42 +0200
Subject: [PATCH 1/2] drm/sti: hdmi: convert to devm_drm_bridge_alloc() API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-1-6285de8c3759@bootlin.com>
References: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
In-Reply-To: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheejgfdugedvudekgeevtdfgudduhedtgfetfeevgfehkeejhedviefhtdffhfeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeejrdduvddtrddvudekrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeejrdduvddtrddvudekrddvtdejpdhhvghloheplgduledvrdduieekrddurddufegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtr
 giiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehrghgrlhhlrghishhpohhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

devm_drm_bridge_alloc() is the new API to be used for allocating (and
partially initializing) a private driver struct embedding a struct
drm_bridge.

This driver was missed during the automated conversion in commit
9c399719cfb9 ("drm: convert many bridge drivers from devm_kzalloc() to
devm_drm_bridge_alloc() API") and following commits.

The lack of conversion for this driver is a bug since commit a7748dd127ea
("drm/bridge: get/put the bridge reference in drm_bridge_add/remove()")
which is the first commmit having added a drm_bridge_get/put() pair and
thus exposing the incorrect initial refcount issue.

Fix this by switching the driver to the new API.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/ce9c6aa3-5372-468f-a4bf-5a261259e459@samsung.com/
Fixes: a7748dd127ea ("drm/bridge: get/put the bridge reference in drm_bridge_add/remove()")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 26 ++++++++++++--------------
 drivers/gpu/drm/sti/sti_hdmi.h |  2 ++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 37b8d619066ef14a2def26e2e4f90a9c2194238d..4e7c3d78b2b971f8083deae96f3967b44a6499cb 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -168,6 +168,11 @@ struct sti_hdmi_connector {
 #define to_sti_hdmi_connector(x) \
 	container_of(x, struct sti_hdmi_connector, drm_connector)
 
+static struct sti_hdmi *drm_bridge_to_sti_hdmi(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct sti_hdmi, bridge);
+}
+
 static const struct drm_prop_enum_list colorspace_mode_names[] = {
 	{ HDMI_COLORSPACE_RGB, "rgb" },
 	{ HDMI_COLORSPACE_YUV422, "yuv422" },
@@ -749,7 +754,7 @@ static void hdmi_debugfs_init(struct sti_hdmi *hdmi, struct drm_minor *minor)
 
 static void sti_hdmi_disable(struct drm_bridge *bridge)
 {
-	struct sti_hdmi *hdmi = bridge->driver_private;
+	struct sti_hdmi *hdmi = drm_bridge_to_sti_hdmi(bridge);
 
 	u32 val = hdmi_read(hdmi, HDMI_CFG);
 
@@ -881,7 +886,7 @@ static int hdmi_audio_configure(struct sti_hdmi *hdmi)
 
 static void sti_hdmi_pre_enable(struct drm_bridge *bridge)
 {
-	struct sti_hdmi *hdmi = bridge->driver_private;
+	struct sti_hdmi *hdmi = drm_bridge_to_sti_hdmi(bridge);
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -936,7 +941,7 @@ static void sti_hdmi_set_mode(struct drm_bridge *bridge,
 			      const struct drm_display_mode *mode,
 			      const struct drm_display_mode *adjusted_mode)
 {
-	struct sti_hdmi *hdmi = bridge->driver_private;
+	struct sti_hdmi *hdmi = drm_bridge_to_sti_hdmi(bridge);
 	int ret;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -1273,7 +1278,6 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct sti_hdmi_connector *connector;
 	struct cec_connector_info conn_info;
 	struct drm_connector *drm_connector;
-	struct drm_bridge *bridge;
 	int err;
 
 	/* Set the drm device handle */
@@ -1289,13 +1293,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	connector->hdmi = hdmi;
 
-	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge)
-		return -EINVAL;
-
-	bridge->driver_private = hdmi;
-	bridge->funcs = &sti_hdmi_bridge_funcs;
-	drm_bridge_attach(encoder, bridge, NULL, 0);
+	drm_bridge_attach(encoder, &hdmi->bridge, NULL, 0);
 
 	connector->encoder = encoder;
 
@@ -1385,9 +1383,9 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 
 	DRM_INFO("%s\n", __func__);
 
-	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
-	if (!hdmi)
-		return -ENOMEM;
+	hdmi = devm_drm_bridge_alloc(dev, struct sti_hdmi, bridge, &sti_hdmi_bridge_funcs);
+	if (IS_ERR(hdmi))
+		return PTR_ERR(hdmi);
 
 	ddc = of_parse_phandle(pdev->dev.of_node, "ddc", 0);
 	if (ddc) {
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
index 6d4c3f57bc46ea7d685682e6635840aaedd94fba..91d43dd46f1393ff182ee19804140897f216a260 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -12,6 +12,7 @@
 
 #include <media/cec-notifier.h>
 
+#include <drm/drm_bridge.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_property.h>
 
@@ -86,6 +87,7 @@ struct sti_hdmi {
 	struct hdmi_audio_params audio;
 	struct drm_connector *drm_connector;
 	struct cec_notifier *notifier;
+	struct drm_bridge bridge;
 };
 
 u32 hdmi_read(struct sti_hdmi *hdmi, int offset);

-- 
2.50.0


