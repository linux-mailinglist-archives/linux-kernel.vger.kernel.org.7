Return-Path: <linux-kernel+bounces-764782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FDDB22742
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E06506805
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9006230BC9;
	Tue, 12 Aug 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OkBwbnR/"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600132264CF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002705; cv=none; b=G2w4CbIubWiRm3EVpFeR0ranEFsSf4UXS2HgxRNo7hwrOzi5EKj8xLPBec4f4RtNiQcqL+3RE+4K1eE612/3xXdgWv+iawcTIF3LjjGp6a3xZidTwvAprTNs/ikKtNk0Iq/ZRalRkCU23P+cJ4vgTxeCcIe8EUjB/0esf6TVZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002705; c=relaxed/simple;
	bh=OeOKNsp1TJ3tODdB1TRUZ3miPBw028X/E/exf2UaPZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uI3bEzQ91phhfCwCXPeaQ5ERuL1jReWT2Ij8XHopf5iqSgYcxtWdSOaB4Ltuf86DvSi/Te0OvKuCTZ/hLnTRMUkNNTC2ot0nro9B29qrIIm446LSd3IogloVIzdOxsJVIdSPwQQZZc0K4AU6ui9ZEW/WtFAuIRNPFiElG4gjroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OkBwbnR/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cO
	k9r79i534l33IHFcOZxUqkWETUF/VetwHEVDXWx2k=; b=OkBwbnR/PkeJgGQPvY
	E1oGt50+/fZnVylA9t4EyYKFzdoVZz8LZAUEjWTkYM9DquQdJC2MSikNoPNwSQRW
	IPVKDUqaY2JdBRdX9doJTSQFwwLMk45Di80qzf1e5pI5o7135aVjgtmAKcAV4x0A
	QTnkU2wcWMM2bDn8xLD5JH/XQ=
Received: from lizhuoheng-virtual-machine.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXl1EnN5to+6r_Aw--.33623S2;
	Tue, 12 Aug 2025 20:44:24 +0800 (CST)
From: 15620332615@163.com
To: suijingfeng@loongson.cn,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zhuoheng Li <lizhuoheng@kylinos.cn>
Subject: [PATCH] drm/lsdc: Use drm_gem_dumb_map_offset() helper
Date: Tue, 12 Aug 2025 20:44:18 +0800
Message-Id: <20250812124418.30914-1-15620332615@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXl1EnN5to+6r_Aw--.33623S2
X-Coremail-Antispam: 1Uf129KBjvPXoW5Xr4kXw43Kr48uFWxXrW5p5X_Xr1kKoWIvF
	13Ja1rtw1xAw4IyF13KFsxZFZrXrWa93y7Gr4DX3yDt3WUAr13XF97JFn5Ar13AFW3Z34j
	kws3XrW7Ca18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3AaLa
	J3UbIYCTnIWIevJa73UjIFyTuYvjxUx18BUUUUU
X-CM-SenderInfo: 5o2kikywsqjjiswrkqqrwthudrp/xtbBSQ6nLmibLAD5dwAAsf

From: Zhuoheng Li <lizhuoheng@kylinos.cn>

Replace the open-coded mmap offset calculation in the LSDC
driver with the drm_gem_dumb_map_offset() helper. This avoids
code duplication and ensures consistency with other DRM
drivers.

No functional changes intended.

Signed-off-by: Zhuoheng Li <lizhuoheng@kylinos.cn>
---
 drivers/gpu/drm/loongson/lsdc_drv.c |  2 +-
 drivers/gpu/drm/loongson/lsdc_gem.c | 16 ----------------
 drivers/gpu/drm/loongson/lsdc_gem.h |  5 -----
 3 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 12193d2a301a..7638cb6dd9b2 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -44,7 +44,7 @@ static const struct drm_driver lsdc_drm_driver = {
 
 	.debugfs_init = lsdc_debugfs_init,
 	.dumb_create = lsdc_dumb_create,
-	.dumb_map_offset = lsdc_dumb_map_offset,
+	.dumb_map_offset = drm_gem_dumb_map_offset,
 	.gem_prime_import_sg_table = lsdc_prime_import_sg_table,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 };
diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c b/drivers/gpu/drm/loongson/lsdc_gem.c
index a720d8f53209..107efd240756 100644
--- a/drivers/gpu/drm/loongson/lsdc_gem.c
+++ b/drivers/gpu/drm/loongson/lsdc_gem.c
@@ -246,22 +246,6 @@ int lsdc_dumb_create(struct drm_file *file, struct drm_device *ddev,
 	return 0;
 }
 
-int lsdc_dumb_map_offset(struct drm_file *filp, struct drm_device *ddev,
-			 u32 handle, uint64_t *offset)
-{
-	struct drm_gem_object *gobj;
-
-	gobj = drm_gem_object_lookup(filp, handle);
-	if (!gobj)
-		return -ENOENT;
-
-	*offset = drm_vma_node_offset_addr(&gobj->vma_node);
-
-	drm_gem_object_put(gobj);
-
-	return 0;
-}
-
 void lsdc_gem_init(struct drm_device *ddev)
 {
 	struct lsdc_device *ldev = to_lsdc(ddev);
diff --git a/drivers/gpu/drm/loongson/lsdc_gem.h b/drivers/gpu/drm/loongson/lsdc_gem.h
index 92cbb10e6e13..f79f06874286 100644
--- a/drivers/gpu/drm/loongson/lsdc_gem.h
+++ b/drivers/gpu/drm/loongson/lsdc_gem.h
@@ -14,11 +14,6 @@ lsdc_prime_import_sg_table(struct drm_device *ddev,
 			   struct dma_buf_attachment *attach,
 			   struct sg_table *sg);
 
-int lsdc_dumb_map_offset(struct drm_file *file,
-			 struct drm_device *dev,
-			 u32 handle,
-			 uint64_t *offset);
-
 int lsdc_dumb_create(struct drm_file *file,
 		     struct drm_device *ddev,
 		     struct drm_mode_create_dumb *args);
-- 
2.34.1


