Return-Path: <linux-kernel+bounces-729605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBEAB03903
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6BC189D8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD257239E67;
	Mon, 14 Jul 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTqa48Ul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B232239E60
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481000; cv=none; b=UghevSqe5Td0Edhcw1jVio1yL2ufBt/QL89ngLUwpkyfyn6/OKpM5/gUCC+Ea8mZx+iKpPV44GcK9mGxTgTDSLtD5JGfZf/CzGpiPCAloXpMaTtn+5h/2GEyutGvOszPGJeQkzirm3WGrMI7qtuZoJq+1r7E4ylePFhOLl3l6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481000; c=relaxed/simple;
	bh=EXUNVHi0qvG4fFZ1xPIguHipbPUIz2io8+UJKpg8FyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOP7kwl7aRq9NqrWAQXVqSi762BUmt4VxLYLqpZMsOrIxfD7xSKnSHTfRpvgHnURMr1nVpgT7qaZ8z6ly0EXtk3aNB/HHUNFvZlseWOXIi9UJFCzcTZe16bcaxWnFtehl9E4+ySaTRfx9nePWn2dLptr3cN3aBWI8YP7QdCRl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTqa48Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68839C4CEED;
	Mon, 14 Jul 2025 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480999;
	bh=EXUNVHi0qvG4fFZ1xPIguHipbPUIz2io8+UJKpg8FyU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZTqa48UlO78Li3onnWYC5vQW8yqGdlM649Pkr8uH4P6SI/5WTAAbNjVGWB5S9R1S4
	 aQtjlseQIh7URWzGAN2CnyZWO1GkXpwR2tIGtMkhTLd5rytdwig2Hj3QWLlPtucMbZ
	 Z+0ole/U3r2CaYcKXu+kT0bCzGa6sUnU4/WU1z+AkruB9NAKV7yhUTRBuPYvs8cSZ1
	 1c6swSGzxDru7CQMUXKYap5O+NiY5xHX/XkkFRgZS+aPKv3XurelBpM6JtY5dDlBJv
	 NogSKEh55G9ljgahYZYLacZnBUWqCrKZJrowdSU7iABgFWSsel0QEjFxS45xeSyX0y
	 wzg1w3KAEWnTw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Samuel Zhang <guoqing.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix link error for !PM_SLEEP
Date: Mon, 14 Jul 2025 10:16:25 +0200
Message-Id: <20250714081635.4071570-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When power management is not enabled in the kernel build, the newly
added hibernation changes cause a link failure:

arm-linux-gnueabi-ld: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o: in function `amdgpu_pmops_thaw':
amdgpu_drv.c:(.text+0x1514): undefined reference to `pm_hibernate_is_recovering'

Make the power management code in this driver conditional on
CONFIG_PM and CONFIG_PM_SLEEP

Fixes: 530694f54dd5 ("drm/amdgpu: do not resume device in thaw for normal hibernation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 021defca9b61..66b5b3260fb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2963,15 +2963,15 @@ long amdgpu_drm_ioctl(struct file *filp,
 }
 
 static const struct dev_pm_ops amdgpu_pm_ops = {
-	.prepare = amdgpu_pmops_prepare,
-	.complete = amdgpu_pmops_complete,
-	.suspend = amdgpu_pmops_suspend,
-	.suspend_noirq = amdgpu_pmops_suspend_noirq,
-	.resume = amdgpu_pmops_resume,
-	.freeze = amdgpu_pmops_freeze,
-	.thaw = amdgpu_pmops_thaw,
-	.poweroff = amdgpu_pmops_poweroff,
-	.restore = amdgpu_pmops_restore,
+	.prepare = pm_sleep_ptr(amdgpu_pmops_prepare),
+	.complete = pm_sleep_ptr(amdgpu_pmops_complete),
+	.suspend = pm_sleep_ptr(amdgpu_pmops_suspend),
+	.suspend_noirq = pm_sleep_ptr(amdgpu_pmops_suspend_noirq),
+	.resume = pm_sleep_ptr(amdgpu_pmops_resume),
+	.freeze = pm_sleep_ptr(amdgpu_pmops_freeze),
+	.thaw = pm_sleep_ptr(amdgpu_pmops_thaw),
+	.poweroff = pm_sleep_ptr(amdgpu_pmops_poweroff),
+	.restore = pm_sleep_ptr(amdgpu_pmops_restore),
 	.runtime_suspend = amdgpu_pmops_runtime_suspend,
 	.runtime_resume = amdgpu_pmops_runtime_resume,
 	.runtime_idle = amdgpu_pmops_runtime_idle,
@@ -3116,7 +3116,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
 	.probe = amdgpu_pci_probe,
 	.remove = amdgpu_pci_remove,
 	.shutdown = amdgpu_pci_shutdown,
-	.driver.pm = &amdgpu_pm_ops,
+	.driver.pm = pm_ptr(&amdgpu_pm_ops),
 	.err_handler = &amdgpu_pci_err_handler,
 	.dev_groups = amdgpu_sysfs_groups,
 };
-- 
2.39.5


