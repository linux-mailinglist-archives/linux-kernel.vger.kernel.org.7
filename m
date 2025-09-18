Return-Path: <linux-kernel+bounces-821832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69FB82696
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1566B1C23130
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DE1F12E0;
	Thu, 18 Sep 2025 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZVBvmw/3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D80201266
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156240; cv=none; b=eAowkDTUvDobnkUmBrQdROxRyNvwNJRut/ba348tDryfCMZdI1JtNusg1ASLBTW5m/MUK8/dAtoDLynoVpxIsSisT263XynS4vK118vCjXM/MTfM/Oq1GtOtNLIm2bk87SS6JNnXTNV9nzjsDPfT/YfTU2hYDyeOt4gm18izqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156240; c=relaxed/simple;
	bh=dKVddj22378G3qUL23iU4CBZKRmzaPKe4vly3Qyzsmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6C7w3hqnU1kCZqApyuFJvIvRPLzOX6bWq5mpuF7/9nDMMqrFs3mjscqU7w59s4yn8oKAMMo/vlHkGN1Ye4rF0XKpv1fenJe1bTJUoKZVaXs9OEzY5kYtqH5g1Vs7XDjB7urjlAQ/Grl9S8va7NUGEMUNDNBwjbQJk7OQCeDxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZVBvmw/3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156236;
	bh=dKVddj22378G3qUL23iU4CBZKRmzaPKe4vly3Qyzsmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZVBvmw/3q9LsoPVOBx05ypBHeehd5IpdKepWnzClBPxOrR0LF5jVN49ZJnIsf7vgJ
	 29QPKP5EaI++wXqMF1qpQ0am+SICw0c004TSyEyKUhHnjuWY0YZzDNNjn6jF/l/HtB
	 LrK0itqhR+p/ceMlQIs3MizcO1Ahn6r1w+ncc7iEHBTKLwRMyCFap1upqzbVWE6aFV
	 xZidiHcE1DhVc2Zz53BUuSEzUGjfHZX2qmfIBLlh0B01phyEEZXkfpTWsj5j3fss5f
	 Uizr1pOowakT/RbH6xW9ROZZIHuhLzYEz1Cx1QvSv/TTaBmoajFrSm9V3uECE9f4l5
	 l57IOk9JPsRbg==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 50A1B17E0DC2;
	Thu, 18 Sep 2025 02:43:50 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:14 -0400
Subject: [PATCH RFC v2 05/20] drm: Introduce
 DRM_CAP_POST_BLEND_COLOR_PIPELINE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-5-ac4471b44758@collabora.com>
References: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
In-Reply-To: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, wayland-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, leo.liu@amd.com, ville.syrjala@linux.intel.com, 
 pekka.paalanen@collabora.com, contact@emersion.fr, mwen@igalia.com, 
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com, 
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 xaver.hugl@gmail.com, victoria@system76.com, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, 
 mcanal@igalia.com, kernel@collabora.com, daniels@collabora.com, 
 leandro.ribeiro@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2

Add a new cap that drivers can set to signal they support post-blend
color pipelines.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/drm_ioctl.c | 3 +++
 include/drm/drm_drv.h       | 6 ++++++
 include/uapi/drm/drm.h      | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e7e863888d8958458978566b144f8..01592d10e3465ddceddef94bc417f98d3ec12087 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -304,6 +304,9 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
 			     dev->mode_config.async_page_flip;
 		break;
+	case DRM_CAP_POST_BLEND_COLOR_PIPELINE:
+		req->value = drm_core_check_feature(dev, DRIVER_POST_BLEND_COLOR_PIPELINE);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986dee9261f8b08c4fc7d93b8d6d9769..6b0f4904e69766232283d430c2540d30afef850f 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -122,6 +122,12 @@ enum drm_driver_feature {
 	 * the cursor planes to work correctly).
 	 */
 	DRIVER_CURSOR_HOTSPOT           = BIT(9),
+	/**
+	 * @DRIVER_POST_BLEND_COLOR_PIPELINE:
+	 *
+	 * Driver supports post-blend color pipeline.
+	 */
+	DRIVER_POST_BLEND_COLOR_PIPELINE		= BIT(10),
 
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d275c7a7fe057840ef792f30a582bb7..c6c53e57958e951204154ce41a69696a6876f0e8 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -812,6 +812,12 @@ struct drm_gem_change_handle {
  * commits.
  */
 #define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
+/**
+ * DRM_CAP_POST_BLEND_COLOR_PIPELINE
+ *
+ * If set to 1, the driver supports post-blend color pipelines.
+ */
+#define DRM_CAP_POST_BLEND_COLOR_PIPELINE	0x16
 
 /* DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {

-- 
2.50.1


