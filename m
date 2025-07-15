Return-Path: <linux-kernel+bounces-731244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B057B05199
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60E91AA6925
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37A265CA0;
	Tue, 15 Jul 2025 06:18:58 +0000 (UTC)
Received: from out28-108.mail.aliyun.com (out28-108.mail.aliyun.com [115.124.28.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C6224AFC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560338; cv=none; b=i3MnwxwxVu6JR23gkug0MaXoeDjuaeA3PiZN6ZsOj2iBaM763RiwaNsVKHA9fhhTjpaqbPHLQSvGpGPutUs0/bZMcEkwen/wT8xPvQBFRCWAM77ocWRWiSU0lKhdrKABMg8K8ocmF5yroVBMDOjMcdTwKKr8kWuD/da19prTIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560338; c=relaxed/simple;
	bh=Wds4b9jiWLRauaO2sAZY5rVDWujRKCrqzOiR8YGjCng=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rnOyLyXxcNlgQfpjiq+pGJBHr7ZGjzvB3q0vdYF3eo4WGS80ScQl701/BSaVZzNgwvXKk2iTRsKz9WoX35V80nWMI5kUkYH5RzES6Is+UZMfyip++jeypAozHb60XoSdDYJ+lONi8qZJRc9qdznAT8xwKfOr+G7Xac6u7ojMKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from aliyun.com(mailfrom:zhangzhijie@bosc.ac.cn fp:SMTPD_---.dnBBp8b_1752560320 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 14:18:41 +0800
From: zhangzhijie <zhangzhijie@bosc.ac.cn>
To: zhangzhijie@bosc.ac.cn,
	wangran@bosc.ac.cn,
	zhangjian@bosc.ac.cn,
	daniel@ffwll.ch,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] Support Intel Xe GPU dirver Porting on RISC-V Architecture
Date: Tue, 15 Jul 2025 14:18:37 +0800
Message-Id: <20250715061837.2144388-1-zhangzhijie@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    inb/outb speccial wire not support on other ARCH.
Should detect whether arch platform support or not.

Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
---
 drivers/gpu/drm/i915/display/intel_vga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
index 4b98833bfa8c..5e48e3282670 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -33,6 +33,7 @@ void intel_vga_disable(struct drm_i915_private *dev_priv)
 	if (intel_de_read(dev_priv, vga_reg) & VGA_DISP_DISABLE)
 		return;
 
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
 	/* WaEnableVGAAccessThroughIOPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
 	vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
 	outb(0x01, VGA_SEQ_I);
@@ -40,6 +41,7 @@ void intel_vga_disable(struct drm_i915_private *dev_priv)
 	outb(sr1 | VGA_SR01_SCREEN_OFF, VGA_SEQ_D);
 	vga_put(pdev, VGA_RSRC_LEGACY_IO);
 	udelay(300);
+#endif
 
 	intel_de_write(dev_priv, vga_reg, VGA_DISP_DISABLE);
 	intel_de_posting_read(dev_priv, vga_reg);
@@ -80,6 +82,7 @@ void intel_vga_redisable(struct drm_i915_private *i915)
 
 void intel_vga_reset_io_mem(struct drm_i915_private *i915)
 {
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 
 	/*
@@ -95,6 +98,7 @@ void intel_vga_reset_io_mem(struct drm_i915_private *i915)
 	vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
 	outb(inb(VGA_MIS_R), VGA_MIS_W);
 	vga_put(pdev, VGA_RSRC_LEGACY_IO);
+#endif
 }
 
 int intel_vga_register(struct drm_i915_private *i915)
-- 
2.34.1


