Return-Path: <linux-kernel+bounces-657967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F916ABFAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BBF50563D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7D21CC62;
	Wed, 21 May 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etehtsea.me header.i=@etehtsea.me header.b="bygdaMO+"
Received: from outbound.mr.icloud.com (p-west2-cluster6-host2-snip4-10.eps.apple.com [57.103.70.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16E1804A
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843583; cv=none; b=JLfclzYTKurwLhq7BI0Sc2NLGPrRKJv+ZfskUjd3VDMBlu/T8sC7XB4mz4c982RJ2sPvl+qHYgQhzNOV86JDNGwuukqAMke8tzUAOsc4yDbgvezW/XKnH0A+f4WGC2tGcOMjUbhaXnW199EFgDJ0t6M62c8UAv4fz1t5DgL+65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843583; c=relaxed/simple;
	bh=E6OOXxE5/OOt+LA14hsb/VnyvJ7pKX+dyBkj1A/DHDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQJxlFzgKHMJfVaGCk24kRY//JzGQA2iQQR5C+GfzxssX6Q0rC1cxHZ5P7hXM78x63EhFUGwkSP6pz9fcvHnsNYIpOcVIuL+pFnZgorcaMnGJywbF4/t035m2qMYnSkXxYiZ89NcnnIJmCtkaHlqJCzcanAH2ppmoGmFZXbtRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etehtsea.me; spf=pass smtp.mailfrom=etehtsea.me; dkim=pass (2048-bit key) header.d=etehtsea.me header.i=@etehtsea.me header.b=bygdaMO+; arc=none smtp.client-ip=57.103.70.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etehtsea.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etehtsea.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etehtsea.me; s=sig1;
	bh=ViGRzst8PRFAp1WtMCQF+6FUrUPaBvnWi6sBdgUbNg0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=bygdaMO+llfLATI70XIiXllBBYfBr0gwymLEN2Ze8kLXsTOG84gZf5/4GfglECd5u
	 zF6tv1rxmXBJYv1In6/WmXaG4fpvHQL+n/MBNb35qg/g4Ko84CzL+txhgDSd5q/Yxy
	 EN1S3k/vxDOuO9tEIDN/pXE86nbwp3ImpgWBXAsjz/U1ShUW1QGxiuV+SkAI1fVL9J
	 J8d73/f0EKdeN1s4OM4hIBNQ69Ind+RQdDi7L5FwVXcQY09meKfURyJYxLxtqIWbDk
	 IxwCGOAUdDGiY7k3nb95MIYb6En6nypwNSiMtni2fx9J8CHZgU50rzuf2LGg6Jj3F/
	 Ce74x93ua327Q==
Received: from outbound.mr.icloud.com (localhost [127.0.0.1])
	by outbound.mr.icloud.com (Postfix) with ESMTPS id 81E09180048F;
	Wed, 21 May 2025 16:06:11 +0000 (UTC)
Received: from localhost (unknown [17.57.152.38])
	by outbound.mr.icloud.com (Postfix) with ESMTPSA id 3A4A1180084D;
	Wed, 21 May 2025 16:06:09 +0000 (UTC)
From: Konstantin Shabanov <mail@etehtsea.me>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Konstantin Shabanov <mail@etehtsea.me>,
	Daniel Stone <daniel@fooishbar.org>,
	Andy Yan <andyshrk@163.com>,
	Dan Callaghan <djc@djc.id.au>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] drm/rockchip: Reject AFBC for res >2560 on rk3399
Date: Wed, 21 May 2025 16:05:55 +0000
Message-ID: <20250521160556.14346-2-mail@etehtsea.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417065759.5948-1-mail@etehtsea.me>
References: <20250417065759.5948-1-mail@etehtsea.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SM59gz_tD3cOB4yA3XtYIu0OZTPHHxxY
X-Proofpoint-ORIG-GUID: SM59gz_tD3cOB4yA3XtYIu0OZTPHHxxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2503310001 definitions=main-2505210158

As it isn't supported by rk3399. From the datasheet[1]
("1.2.10 Video IN/OUT", "Display Interface", p. 17):

  Support AFBC function co-operation with GPU
    * support 2560x1600 UI

Signed-off-by: Konstantin Shabanov <mail@etehtsea.me>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Andy Yan <andyshrk@163.com>
Reported-by: Dan Callaghan <djc@djc.id.au>
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/7968

[1]: https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
---
 V4 -> V5: Extract AFBC support check into drv
 V3 -> V4: Correct redundant header inclusion
 V2 -> V3: Run check only on rk3399
 V1 -> V2: Move the check to the fb_create callback

 AFBC check is implemented in a similar manner as in the malidp driver.
 
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 16 ++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  2 ++
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 180fad5d49ad..9fb04022b2f3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -42,6 +42,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+#define RK3399_AFBC_MAX_WIDTH		2560
+
 static const struct drm_driver rockchip_drm_driver;
 
 /*
@@ -350,6 +352,20 @@ int rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
 	return false;
 }
 
+bool rockchip_verify_afbc_framebuffer_size(struct drm_device *dev,
+					   const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (of_machine_is_compatible("rockchip,rk3399") &&
+	    mode_cmd->width > RK3399_AFBC_MAX_WIDTH) {
+		DRM_DEBUG_KMS("AFBC is not supported for the width %d (max %d)\n",
+			      mode_cmd->width,
+			      RK3399_AFBC_MAX_WIDTH);
+		return false;
+	}
+
+	return true;
+}
+
 static void rockchip_drm_match_remove(struct device *dev)
 {
 	struct device_link *link;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index c183e82a42a5..5dabceaa4fd6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -86,6 +86,8 @@ int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 int rockchip_drm_encoder_set_crtc_endpoint_id(struct rockchip_encoder *rencoder,
 					      struct device_node *np, int port, int reg);
 int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
+bool rockchip_verify_afbc_framebuffer_size(struct drm_device *dev,
+					   const struct drm_mode_fb_cmd2 *mode_cmd);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_hdmi_qp_rockchip_pltfm_driver;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 5829ee061c61..f0527f12f568 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -52,6 +52,9 @@ rockchip_fb_create(struct drm_device *dev, struct drm_file *file,
 	}
 
 	if (drm_is_afbc(mode_cmd->modifier[0])) {
+		if (!rockchip_verify_afbc_framebuffer_size(dev, mode_cmd))
+			return ERR_PTR(-EINVAL);
+
 		ret = drm_gem_fb_afbc_init(dev, mode_cmd, afbc_fb);
 		if (ret) {
 			drm_framebuffer_put(&afbc_fb->base);

base-commit: 6ad88bf9e74dae83c992d8a16683360117b7e2d8
-- 
2.49.0


