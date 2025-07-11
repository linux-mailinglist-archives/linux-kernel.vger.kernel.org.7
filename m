Return-Path: <linux-kernel+bounces-727059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D74CB0148B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289B81AA1C97
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15D1EB5E1;
	Fri, 11 Jul 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgZ8WbA7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD131E834B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218706; cv=none; b=nOGa471cQbKB83cy/GRBM/08/HI/00/a0hwXGibltJPOQQkoSlw6AINa8JYmu3m8AV2KOUA1qGFHeuAwPMpnKGJ79oc+v8S5HgtlUxGH6riyOSYl4dIgQijSqU7ieOBbbOiYwnBQU+trFjISk1LICKk2TYOxMjvMV+4rKqFN+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218706; c=relaxed/simple;
	bh=qPMlPEUHasRhfrBOHDDaZo3TRKfCZ37IbFpQ9rOiGe4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BFdTxjjMyjkmCbqctwdMBb5i54pwvI1p50jKj/MVW5Yi0fn1VfIW0c3T9/JoXHas5hTTLXpxB8so+ZRn/16s0pqS0Lx9/CmrJiwlWZJ9PhsQXnVivEc+S0a7a1hFo+L5/te53TucbUgFiFx/EPNk+G0Jxap4k1YoH89+HRACw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgZ8WbA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040BFC4CEED;
	Fri, 11 Jul 2025 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218705;
	bh=qPMlPEUHasRhfrBOHDDaZo3TRKfCZ37IbFpQ9rOiGe4=;
	h=From:To:Cc:Subject:Date:From;
	b=pgZ8WbA7/Bq9U0ukiV55otfOvwZgPBBioQ/G4y/je8S7gI/QTQMyn12CuONYrXHFb
	 dhNhNAQGZnTAb95KRgD3qLrM01lSP3tDKZ0e+7ibD8yFUS37R6JLFrKK64HmLcRMS4
	 w3e7EwgWe6///Ileli0cZLLKqmbtSoZ+/ZuGMlc20GjT8wtLZqDkY2HdT1SU+eijLT
	 JMYjODCPXuM0rtz276g+sklH2QmgH80GYswN/K2wJSXiSHId0lciNHN1463ICdP3zM
	 DvekFp1Y/l36hLkVPMEQRa92xGrbLwapoPXHLCs05kgSToleA/oQjEWJo3fw+tPpUO
	 YydSDXgpha74g==
From: Arnd Bergmann <arnd@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: check ioctl command codes better
Date: Fri, 11 Jul 2025 09:24:53 +0200
Message-Id: <20250711072458.2665325-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

nouveau_drm_ioctl() only checks the _IOC_NR() bits in the DRM_NOUVEAU_NVIF
command, but ignores the type and direction bits, so any command with
'7' in the low eight bits gets passed into nouveau_abi16_ioctl() instead
of drm_ioctl().

Check for all the bits except the size that is handled inside of the handler.

Fixes: 27111a23d01c ("drm/nouveau: expose the full object/event interfaces to userspace")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 1527b801f013..506eeb44f0d4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1284,6 +1284,9 @@ nouveau_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(NOUVEAU_EXEC, nouveau_exec_ioctl_exec, DRM_RENDER_ALLOW),
 };
 
+#define DRM_IOCTL_NOUVEAU_NVIV _IOC(_IOC_READ|_IOC_WRITE, DRM_IOCTL_BASE, \
+				    DRM_COMMAND_BASE + DRM_NOUVEAU_NVIF, 0)
+
 long
 nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -1297,14 +1300,10 @@ nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return ret;
 	}
 
-	switch (_IOC_NR(cmd) - DRM_COMMAND_BASE) {
-	case DRM_NOUVEAU_NVIF:
+	if ((cmd & ~IOCSIZE_MASK) == DRM_IOCTL_NOUVEAU_NVIV)
 		ret = nouveau_abi16_ioctl(filp, (void __user *)arg, _IOC_SIZE(cmd));
-		break;
-	default:
+	else
 		ret = drm_ioctl(file, cmd, arg);
-		break;
-	}
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.39.5


