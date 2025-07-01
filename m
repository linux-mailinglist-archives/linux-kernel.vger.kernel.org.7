Return-Path: <linux-kernel+bounces-711073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005DFAEF58B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 12:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56033BFA6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA879271443;
	Tue,  1 Jul 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p8o6kBRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2ED2701B3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366994; cv=none; b=hrwcDNEDd/mc30jacXXde/MAGIKZp68RWqz+DZSSBLzchwwdnWECtnD3uQi/NCBpli/Le72ZhbIMOvsFpHDEaihpBnsFjweo2FmO2rvqCC+4fDQzwYe549SJD9S9DGHglIxwfG5SPUYK3Q/QuLAaziR84jy03eVtnTF6SGiuKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366994; c=relaxed/simple;
	bh=rfmh8mLv26aS8gI+IYRKA9NzVJaudp50BtCKlSVDjfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFSEo3R8KJXzGcUx7sNuiZOTo7ixac7QWHOgcrtUumpqK5NSfqarugKGEDqFPlDWVacHHRIuIzdUnGKOiYyFtNZvkn8urizsNSE09cYrxFTYPZcEVsyr0jAAOnX+f4Q0JWi9MFUmHw+PhTibZCnD15KiDC5cbPvFYgyz14g+G/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p8o6kBRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5D9C4CEEE;
	Tue,  1 Jul 2025 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751366993;
	bh=rfmh8mLv26aS8gI+IYRKA9NzVJaudp50BtCKlSVDjfs=;
	h=From:To:Cc:Subject:Date:From;
	b=p8o6kBRjvT/CsthagHt2+YonQbhuyV62p/Vtd00HQRTefy1F8pXr8k2y5QDUHacfH
	 Pyqioei8ykiaTwZ+C6/qCg52AG+X7i7rLI+hsOxEWm4o/bpmLQUp4EYzZRjycLsYTw
	 jFeMxbz+83SNoUiW84zoZOSJGsrqoOdccliTexTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH v5] drm/vkms: convert to use faux_device
Date: Tue,  1 Jul 2025 12:49:48 +0200
Message-ID: <2025070147-antics-pleat-edd2@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 137
X-Developer-Signature: v=1; a=openpgp-sha256; l=4473; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=rfmh8mLv26aS8gI+IYRKA9NzVJaudp50BtCKlSVDjfs=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnJe71P2ip++1VzRr+PQc1gxZ5pNw4//bJ+S2cdn6dlU /6m8Bb5jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIxESGBWsthGSSLVamF4bq pV/KXNJ7RXHfMoZZzE+nXp/pOiXKIFpg2qI1yzQOGAS/AQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The vkms driver does not need to create a platform device, as there is
no real platform resources associated it,  it only did so because it was
simple to do that in order to get a device to use for resource
management of drm resources.  Change the driver to use the faux device
instead as this is NOT a real platform device.

Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v5: - rebased against 6.16-rc4
    - added reviewed-by and tested-by lines
    - was somehow dropped from drm trees, resending to make sure it
      isn't lost

v4: - first version of the patch, was part of a larger patch series that
      has been mostly all applied to the tree.

 drivers/gpu/drm/vkms/vkms_drv.c | 28 ++++++++++++++--------------
 drivers/gpu/drm/vkms/vkms_drv.h |  4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index a24d1655f7b8..e8472d9b6e3b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/dma-mapping.h>
 
 #include <drm/clients/drm_client_setup.h>
@@ -149,27 +149,27 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 static int vkms_create(struct vkms_config *config)
 {
 	int ret;
-	struct platform_device *pdev;
+	struct faux_device *fdev;
 	struct vkms_device *vkms_device;
 	const char *dev_name;
 
 	dev_name = vkms_config_get_device_name(config);
-	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	fdev = faux_device_create(dev_name, NULL, NULL);
+	if (!fdev)
+		return -ENODEV;
 
-	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
+	if (!devres_open_group(&fdev->dev, NULL, GFP_KERNEL)) {
 		ret = -ENOMEM;
 		goto out_unregister;
 	}
 
-	vkms_device = devm_drm_dev_alloc(&pdev->dev, &vkms_driver,
+	vkms_device = devm_drm_dev_alloc(&fdev->dev, &vkms_driver,
 					 struct vkms_device, drm);
 	if (IS_ERR(vkms_device)) {
 		ret = PTR_ERR(vkms_device);
 		goto out_devres;
 	}
-	vkms_device->platform = pdev;
+	vkms_device->faux_dev = fdev;
 	vkms_device->config = config;
 	config->dev = vkms_device;
 
@@ -203,9 +203,9 @@ static int vkms_create(struct vkms_config *config)
 	return 0;
 
 out_devres:
-	devres_release_group(&pdev->dev, NULL);
+	devres_release_group(&fdev->dev, NULL);
 out_unregister:
-	platform_device_unregister(pdev);
+	faux_device_destroy(fdev);
 	return ret;
 }
 
@@ -231,19 +231,19 @@ static int __init vkms_init(void)
 
 static void vkms_destroy(struct vkms_config *config)
 {
-	struct platform_device *pdev;
+	struct faux_device *fdev;
 
 	if (!config->dev) {
 		DRM_INFO("vkms_device is NULL.\n");
 		return;
 	}
 
-	pdev = config->dev->platform;
+	fdev = config->dev->faux_dev;
 
 	drm_dev_unregister(&config->dev->drm);
 	drm_atomic_helper_shutdown(&config->dev->drm);
-	devres_release_group(&pdev->dev, NULL);
-	platform_device_unregister(pdev);
+	devres_release_group(&fdev->dev, NULL);
+	faux_device_destroy(fdev);
 
 	config->dev = NULL;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index a74a7fc3a056..5a46016e1890 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -197,13 +197,13 @@ struct vkms_config;
  * struct vkms_device - Description of a VKMS device
  *
  * @drm - Base device in DRM
- * @platform - Associated platform device
+ * @faux_dev - Associated faux device
  * @output - Configuration and sub-components of the VKMS device
  * @config: Configuration used in this VKMS device
  */
 struct vkms_device {
 	struct drm_device drm;
-	struct platform_device *platform;
+	struct faux_device *faux_dev;
 	const struct vkms_config *config;
 };
 
-- 
2.50.0


