Return-Path: <linux-kernel+bounces-890055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B033FC3F281
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B13B0A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761082D8797;
	Fri,  7 Nov 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fhEFB3AS"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7E3016F8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507661; cv=none; b=RnjFzcKLTXmAqJZ4BHnDgjXalZjOp2zIle5G6nLdMe+QYADUGOWol0vEc+KgbeL4hHxQyb7ayNGjQR3+K33PW27FQea3HEIpXJh4J9ob0S7XaFMRu5fOqz2yfvmhxm8vhepKLoshAD0smjh6/9Cpo+M44O9vsssduz43NFxUxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507661; c=relaxed/simple;
	bh=FJHozqKfW1QSX/ANGLhrMEHA2rqgpJCcUwfFCa8hl1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AllI/wxI6Y2TAi2wiwC95olTYznm1bpP2+iujIqTuAgNOyqxxgif0TBBGgRArWq8s9yAq9DIaFri/ATGtVG10djcD74PScItf07ubb2UgAk9TMaMkX7MNHVTG/UBixCPKVsZNx7/Yg+RKkaBDcJDf0B2XN1XGUF3SEv509bkuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fhEFB3AS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SQ
	6/DT7d0y656zGChdvpEtQN2UlsTQvlp/F01LtJh4A=; b=fhEFB3ASFtiUhaaY5v
	dr3GDv16x7/otolIc0Fzl35czQCWPNxYs5zT5ZXGCKs/z7ZaZN9i0p1kspmnph8u
	G0n42C3vM4vjGSymGum8uHCcGEDc1punTa0d7SCNrvQlW/IaPplxZdjgyO7UorVC
	IDLk6fCiFMLvUKv0KS9Y+EG3U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXj99iuw1p+3QvCQ--.20605S2;
	Fri, 07 Nov 2025 17:26:59 +0800 (CST)
From: oushixiong1025@163.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Tiger Liu <liuyihu@kylinos.cn>
Subject: [PATCH] drm/fb-helper: add fbdev screen expended mode display support
Date: Fri,  7 Nov 2025 17:26:41 +0800
Message-Id: <20251107092641.111431-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj99iuw1p+3QvCQ--.20605S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4kJFWrGr18WFW8trW7twb_yoWxAF4xpF
	47WayfKr1UJF93Gay8tws7Zwn3GwsxAr48JrWfG3WfCr1Dtr9a9F4UA3sruFWfGr18Gr15
	Jrn0kF429F1kCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8J5rUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwn+D2kNtT2h6wAAs9

From: Shixiong Ou <oushixiong@kylinos.cn>

Add fbdev screen extended mode display support

Signed-off-by: Tiger Liu <liuyihu@kylinos.cn>
Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/drm_fb_helper.c | 143 ++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 53e9dc0543de..a6ec03bf3aef 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -78,6 +78,17 @@ MODULE_PARM_DESC(drm_leak_fbdev_smem,
 		 "Allow unsafe leaking fbdev physical smem address [default=false]");
 #endif
 
+#define SCREEN_CLONE			0x0
+#define SCREEN_EXPAND_HORIZONTAL	0x1
+#define SCREEN_EXPAND_VERTICAL		0x2
+
+static bool drm_fbdev_screen_expand_mode_enabled;
+static int drm_fbdev_screen_mode = SCREEN_CLONE;
+module_param_named(screen_mode, drm_fbdev_screen_mode, int, 0444);
+MODULE_PARM_DESC(screen_mode,
+		 "Screen display of the fbdev. [0 = clone(default), 1 = expand horizontally,"
+		 "2 = expand vertically]");
+
 static LIST_HEAD(kernel_fb_helper_list);
 static DEFINE_MUTEX(kernel_fb_helper_lock);
 
@@ -1345,15 +1356,35 @@ int drm_fb_helper_set_par(struct fb_info *info)
 }
 EXPORT_SYMBOL(drm_fb_helper_set_par);
 
-static void pan_set(struct drm_fb_helper *fb_helper, int dx, int dy)
+static void pan_set_locked(struct drm_client_dev *client,
+			   int dx, int dy)
 {
 	struct drm_mode_set *mode_set;
+	int screen_x_offset = dx;
+	int screen_y_offset = dy;
 
-	mutex_lock(&fb_helper->client.modeset_mutex);
-	drm_client_for_each_modeset(mode_set, &fb_helper->client) {
-		mode_set->x += dx;
-		mode_set->y += dy;
+	drm_client_for_each_modeset(mode_set, client) {
+		if (drm_fbdev_screen_expand_mode_enabled) {
+			if (drm_fbdev_screen_mode == SCREEN_EXPAND_HORIZONTAL) {
+				mode_set->x += screen_x_offset;
+				mode_set->y += screen_y_offset;
+				screen_x_offset += mode_set->mode->hdisplay;
+			} else if (drm_fbdev_screen_mode == SCREEN_EXPAND_VERTICAL) {
+				mode_set->x += screen_x_offset;
+				mode_set->y += screen_y_offset;
+				screen_y_offset += mode_set->mode->vdisplay;
+			}
+		} else {
+			mode_set->x = screen_x_offset;
+			mode_set->y = screen_y_offset;
+		}
 	}
+}
+
+static void pan_set(struct drm_fb_helper *fb_helper, int dx, int dy)
+{
+	mutex_lock(&fb_helper->client.modeset_mutex);
+	pan_set_locked(&fb_helper->client, dx, dy);
 	mutex_unlock(&fb_helper->client.modeset_mutex);
 }
 
@@ -1387,10 +1418,8 @@ static int pan_display_legacy(struct fb_var_screeninfo *var,
 
 	mutex_lock(&client->modeset_mutex);
 	drm_modeset_lock_all(fb_helper->dev);
+	pan_set_locked(client, var->xoffset, var->yoffset);
 	drm_client_for_each_modeset(modeset, client) {
-		modeset->x = var->xoffset;
-		modeset->y = var->yoffset;
-
 		if (modeset->num_connectors) {
 			ret = drm_mode_set_config_internal(modeset);
 			if (!ret) {
@@ -1461,6 +1490,94 @@ static uint32_t drm_fb_helper_find_format(struct drm_fb_helper *fb_helper, const
 	return DRM_FORMAT_INVALID;
 }
 
+/*
+ * Check if the device supports extended mode
+ *
+ * return true if the device supports extended mode,
+ * otherwise return false.
+ */
+static bool drm_fb_helper_validate_extended_mode(struct drm_fb_helper *fb_helper,
+						 struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_client_dev *client = &fb_helper->client;
+	struct drm_device *dev = fb_helper->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_mode_set *mode_set;
+	u32 crtc_count;
+
+	drm_client_for_each_modeset(mode_set, client) {
+		crtc_count++;
+
+		for (int j = 0; j < mode_set->num_connectors; j++) {
+			struct drm_connector *connector = mode_set->connectors[j];
+
+			if (connector->has_tile) {
+				drm_dbg_kms(client->dev,
+					    "Don't support extended with tile mode connector yet\n");
+				return false;
+			}
+		}
+	}
+
+	if (crtc_count < 2) {
+		drm_dbg_kms(client->dev,
+			    "Only support extended mode when device have mult-crtcs\n");
+		return false;
+	}
+
+	if (drm_fbdev_screen_mode == SCREEN_EXPAND_HORIZONTAL) {
+		u32 x = 0;
+
+		drm_client_for_each_modeset(mode_set, client) {
+			struct drm_display_mode *desired_mode;
+
+			desired_mode = mode_set->mode;
+			x = mode_set->x;
+			sizes->fb_width = sizes->surface_width  += desired_mode->hdisplay;
+			sizes->surface_height =
+				min_t(u32, desired_mode->vdisplay + mode_set->y,
+				      sizes->surface_height);
+			sizes->fb_height = min_t(u32, desired_mode->vdisplay + mode_set->y,
+						 sizes->fb_height);
+		}
+		sizes->fb_width = sizes->surface_width += x;
+
+		if (sizes->fb_width > config->max_width) {
+			drm_dbg_kms(client->dev,
+				    "screen_buffer total width %d > config width %d\n",
+				    sizes->fb_width, config->max_width);
+			return false;
+		}
+	} else if (drm_fbdev_screen_mode == SCREEN_EXPAND_VERTICAL) {
+		u32 y = 0;
+
+		drm_client_for_each_modeset(mode_set, client) {
+			struct drm_display_mode *desired_mode;
+
+			desired_mode = mode_set->mode;
+			y = mode_set->y;
+			sizes->fb_height = sizes->surface_height += desired_mode->vdisplay;
+			sizes->surface_width =
+				min_t(u32, desired_mode->hdisplay + mode_set->x,
+				      sizes->surface_width);
+			sizes->fb_width = min_t(u32, desired_mode->hdisplay + mode_set->x,
+						sizes->fb_width);
+		}
+		sizes->fb_height = sizes->surface_height += y;
+
+		if (sizes->fb_height > config->max_height) {
+			drm_dbg_kms(client->dev,
+				    "screen_buffer_total_height %d > config height %d\n",
+				    sizes->fb_height, config->max_height);
+			return false;
+		}
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
 static int __drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 				      struct drm_fb_helper_surface_size *sizes)
 {
@@ -1527,6 +1644,16 @@ static int __drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 
 	/* first up get a count of crtcs now in use and new min/maxes width/heights */
 	crtc_count = 0;
+
+	/* Check if we support extended mode. If we do, we will adjust the sizes accordingly. */
+	if (drm_fbdev_screen_mode &&
+		drm_fb_helper_validate_extended_mode(fb_helper, sizes)) {
+		drm_fbdev_screen_expand_mode_enabled = true;
+		drm_dbg_kms(dev, "Extended mode: horizontal expansion, width: %d, height: %d\n",
+			    sizes->surface_width, sizes->surface_height);
+		return 0;
+	}
+
 	drm_client_for_each_modeset(mode_set, client) {
 		struct drm_display_mode *desired_mode;
 		int x, y, j;
-- 
2.25.1


