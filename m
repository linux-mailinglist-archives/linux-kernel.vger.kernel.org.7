Return-Path: <linux-kernel+bounces-758898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1FB1D540
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2EE17C536
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058721FF24;
	Thu,  7 Aug 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d7doqlbP"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E06221FC4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754560083; cv=none; b=O3F8hh9FiQT9pYI6QSN1GemBo4PWtGBHoQb7s/v/VngxzvhE5KPqEQyIyY/KRd/kVkYtGoaOmuL2+s3XcIlzwCGTFANIDxCUGjbAng8JdnQh3sXBhzUuZkzOAVQ3fJH7keAdNIJluUSmfKdM+GwsDjOz8grTQrk3ICp5qwHhJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754560083; c=relaxed/simple;
	bh=a7GV8oZkKRbgbBlhJjrxG4bHZVDVwCvkjSf+UBHT6+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UykufCwnXVHd/QuO4jtAAPiF5nBQq8Jn+Cm8X2xUMcftFy9H8KmiZ+Iw1By2dbGjfxhScSokMXktg3Pz6oOuwYaVAiqz4/QUBLVtEsXl29oJykRQlpXq+15r9ijmw/Xs49k63Lqah0EEHBYJSODecmXGul9hyLtEdABt4tffwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d7doqlbP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yu
	060HFp7OokvIbTOySWGWsGGcfzytPoIFqY1n1bEK8=; b=d7doqlbPLjZP9cOhIp
	oyEjnKydTXd3Xi9ISgffSmOz8L4Ll/P4v2qDSJYrcIJp442vFq1+1jGi+9bechSL
	uxDGZscJmF8inMQANFJBone/LNUUdTxOU5/FrlN8G5z39OED93O+6oaHJAIYjAzt
	IZq4IfKGm9q6mx4t0PYILmO4w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3kiYpdpRoIY9GAQ--.12087S2;
	Thu, 07 Aug 2025 17:47:23 +0800 (CST)
From: oushixiong1025@163.com
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Alexandre Demers <alexandre.f.demers@gmail.com>,
	Boyuan Zhang <boyuan.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/amdgpu: skip disabling audio when device is unplugged
Date: Thu,  7 Aug 2025 17:47:19 +0800
Message-Id: <20250807094719.56145-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3kiYpdpRoIY9GAQ--.12087S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1DJF48Wr4xtw13ZrWxCrg_yoW5Aw18pF
	yFya4Fkw48Zw4jqa1IyF9rXrn8A3ZFg3Wfur4kJr1a9ayDA3s0qa4rJF18u3s8JrWqvF42
	q343J3yUZ3ZYg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0XdbUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRGZD2iI7Tg5FAACsA

From: Shixiong Ou <oushixiong@kylinos.cn>

When Stopping lightdm and removing amdgpu driver are executed, the following
error is triggered probably:

Unable to handle kernel paging request at virtual address 0000000000005e00
.....
[ 2] [T10084] Call trace:
[ 2] [T10084]  amdgpu_device_wreg.part.0+0x58/0x110 [amdgpu]
[ 2] [T10084]  amdgpu_device_wreg+0x20/0x38 [amdgpu]
[ 2] [T10084]  dce_v6_0_audio_endpt_wreg+0x64/0xd8 [amdgpu]
[ 2] [T10084]  dce_v6_0_sw_fini+0xa0/0x118 [amdgpu]
[ 2] [T10084]  amdgpu_device_ip_fini.isra.0+0xdc/0x1e8 [amdgpu]
[ 2] [T10084]  amdgpu_device_fini_sw+0x2c/0x220 [amdgpu]
[ 2] [T10084]  amdgpu_driver_release_kms+0x20/0x40 [amdgpu]
[ 2] [T10084]  devm_drm_dev_init_release+0x8c/0xc0 [drm]
[ 2] [T10084]  devm_action_release+0x18/0x28
[ 2] [T10084]  release_nodes+0x5c/0xc8
[ 2] [T10084]  devres_release_all+0xa0/0x130
[ 2] [T10084]  device_unbind_cleanup+0x1c/0x70
[ 2] [T10084]  device_release_driver_internal+0x1e4/0x228
[ 2] [T10084]  driver_detach+0x90/0x100
[ 2] [T10084]  bus_remove_driver+0x74/0x100
[ 2] [T10084]  driver_unregister+0x34/0x68
[ 2] [T10084]  pci_unregister_driver+0x24/0x108
[ 2] [T10084]  amdgpu_exit+0x1c/0x3270 [amdgpu]
[ 2] [T10084]  __do_sys_delete_module.constprop.0+0x1d0/0x330
[ 2] [T10084]  __arm64_sys_delete_module+0x18/0x28
[ 2] [T10084]  invoke_syscall+0x4c/0x120
[ 2] [T10084]  el0_svc_common.constprop.0+0xc4/0xf0
[ 2] [T10084]  do_el0_svc+0x24/0x38
[ 2] [T10084]  el0_svc+0x24/0x88
[ 2] [T10084]  el0t_64_sync_handler+0x134/0x150
[ 2] [T10084]  el0t_64_sync+0x14c/0x150
[ 2] [T10084] Code: f9401bf7 f9453e60 8b150000 d50332bf (b9000016)
[ 2] [T10084] ---[ end trace 0000000000000000 ]---

The adev->rmmio has been unmmaped in amdgpu_device_fini_hw().

So skip disabling audio when device is unplugged.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 276c025c4c03..48b29990da7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/pci.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper.h>
@@ -1459,8 +1460,10 @@ static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
+	if (!drm_dev_is_unplugged(adev_to_drm(adev))) {
+		for (i = 0; i < adev->mode_info.audio.num_pins; i++)
+			dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
+	}
 
 	adev->mode_info.audio.enabled = false;
 }
-- 
2.25.1


