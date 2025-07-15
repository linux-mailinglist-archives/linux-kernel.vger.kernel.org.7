Return-Path: <linux-kernel+bounces-731398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84FEB053B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11B4560C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6E272E43;
	Tue, 15 Jul 2025 07:52:10 +0000 (UTC)
Received: from out198-38.us.a.mail.aliyun.com (out198-38.us.a.mail.aliyun.com [47.90.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73096271456
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565929; cv=none; b=Mzp8Pq0AuO/vqf1DiJrkgVm1fvOVQKzfCZeHr/xBHVq2sf1xRWpy8Y/ucYIG9H3+OUp69NTsONOfq/NAXuPczrK8vvzhGJVne0WRrPpyXSHNoJcMOkQhYV/NWLMlnS+nWphi8uU1fpNAKs67GX2Re56TMbyTvYw6ULUpgmAN2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565929; c=relaxed/simple;
	bh=Wds4b9jiWLRauaO2sAZY5rVDWujRKCrqzOiR8YGjCng=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fwY9TtZ/w+WNJyHtcDSVfP8G1Tnqsg9nt+uvJgD1cQu2Rp2S62gDoMk7HPaAmo9N7bcAGy4NOWb7kVV7fsZIL+xBHW/1mC0AfHSA1r9rHxXLSRDE7MiPIjfRlN4n/tebTZCq/pN5kma2oNltEWIw0SB85jffdTmgZ+uYoZjKGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=47.90.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from aliyun.com(mailfrom:zhangzhijie@bosc.ac.cn fp:SMTPD_---.dnAL8W3_1752564970 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 15:36:11 +0800
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
Subject: [PATCH v1] drm/xe: Support Intel Xe GPU dirver Porting on RISC-V Architecture
Date: Tue, 15 Jul 2025 15:36:08 +0800
Message-Id: <20250715073608.2387698-1-zhangzhijie@bosc.ac.cn>
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


