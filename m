Return-Path: <linux-kernel+bounces-748956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F7B14803
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C61416747D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A27256C9C;
	Tue, 29 Jul 2025 06:10:15 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F01D516F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769415; cv=none; b=gK9aP0xYLmwGvOk+EHUX/wQUlMLH/iQXsfmbKLD7cU5D334+vQRTvQN5ZVgvxkU4upgvoyjZykLg/8+pEQY3hblRddF+0Qaccsq+l6m5r5B7rBhCzLd18q/vsExJ7dGgSUyNiEOif+wLNCsP8ByVcXIsfURXcsrCY0m8YOy3L40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769415; c=relaxed/simple;
	bh=TxqpKgeabHTrggDWlP/yd6DObHnaciiz5dvW2MJ4y/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSoe8N+tiBRPh6x3vq/YVtSdlslXcIIhdUz07b0L0mox9EQ1nx5DrTENzEC7bYpV2MW0nplkBwx9fPx7LsEkAcOQO48yHAmb0iBvGxIFXWniNiisXRv0hx7Fq8oic0tUod5foha4mXbDMEgmcw5Y7UD2Z3cMj5UtXZ9R0XKo6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201605.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507291408431416;
        Tue, 29 Jul 2025 14:08:43 +0800
Received: from localhost.localdomain.com (10.94.7.32) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 29 Jul 2025 14:08:42 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH 1/1] gpu: drm: fix compilation errors in drm_vram_helper
Date: Tue, 29 Jul 2025 14:07:28 +0800
Message-ID: <20250729060728.82402-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025729140843678e23873c30db11b3d61f0bbdc984db
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

We encountered the following errors while compiling drm_vram_helper.ko

ERROR: modpost: "drm_gem_ttm_print_info" [drivers/gpu/drm/drm_vram_helper.ko] undefined!
ERROR: modpost: "drm_gem_ttm_mmap" [drivers/gpu/drm/drm_vram_helper.ko] undefined!

The functions drm_gem_ttm_mmap and drm_gem_ttm_print_info are defined in drm_gem_ttm_helper.c. This patch adds drm_gem_ttm_helper.o to DRM_VRAM_HELPER to resolve the undefined symbol errors.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/gpu/drm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 4dafbdc8f86a..abbe32ddf6d0 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -125,7 +125,7 @@ drm_suballoc_helper-y := drm_suballoc.o
 obj-$(CONFIG_DRM_SUBALLOC_HELPER) += drm_suballoc_helper.o
 
 drm_vram_helper-y := drm_gem_vram_helper.o
-obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
+obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o drm_gem_ttm_helper.o
 
 drm_ttm_helper-y := drm_gem_ttm_helper.o
 drm_ttm_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_ttm.o
-- 
2.43.5


