Return-Path: <linux-kernel+bounces-880731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D4C2668F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE664FAA44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239973271F7;
	Fri, 31 Oct 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MJdDdwY6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158D322DD0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931758; cv=none; b=k6tf/WTgnAHe6ez1DNT5Q3GbJyqqAzEHJVre+f1j3X0XGywxdMDpWamlp55SHDTJzJ+ukXRr56zwOwVZvDhx0bxJRw0IHEpNDsCd/2W1AZXwa7SD6LtsSOgePzn8ZNI7DC6CNsXq4NGFPp+xB4V/f1S2B1EZBbWOzKTAPCWOnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931758; c=relaxed/simple;
	bh=9CJ7u1jnlnm84awcn639u6Yp/yBstqIpcAoOOdICSkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQTQQbjpXovOZYLHtwmD6l4IWU+sXWqyhg0eWmGJnA1gOEo+ZWLOHqVJ+gM85dC8pOJrD0BKoLePH7ZSspwb10vmC9rb9KOSU3SSvInjwkrH3Rhzf0Uf7wV8VcmJnmw5esupILJCGINr2Seey1ewx+i4kI2rgdvdRmDqLrzYC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MJdDdwY6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 660DD19AD;
	Fri, 31 Oct 2025 18:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931644;
	bh=9CJ7u1jnlnm84awcn639u6Yp/yBstqIpcAoOOdICSkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MJdDdwY6W2U6sGWpx79RZex9hPLCL0rz6ZVb0ZU5ctpvkqx6nGysWUil4gbDvrdjh
	 0M4INmFp7O38NvgKOYyD7zIWhUUpQIuvFs/ciPbbnjpGYmx/+d0NiU0qxXnBQmUUHB
	 /KbzPPnKxIhxKSALiGtJPad4Ky7baUYW/M531ERs=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:33 +0530
Subject: [PATCH 13/13] platform/raspberrypi: vchiq: Register vc-sm-cma as a
 platform driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-13-0dd5c0ec3f5c@ideasonboard.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=rAaQpRHtWGp7BJRz7YWXM337EB/6DfYZ9A46xHhwYZY=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGgaG15cb+ogx/QrVis56z2df+pwHeMLcxzo
 qRCX/wZD3yJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxoAAKCRBD3pH5JJpx
 RbJgD/4wpdKvt6yg4rO214J6mG4ABEkpeK7I0bf88qPV1ZaNUcjEAz9XusPjEpkUOwDxPgoBfmH
 1FBudws2zDI2/GgOa/H8/1+IWkJY+SSMWzo4hf/KbdWM8tvFST1efw5jt4Tc7UvmItrtbDXVesI
 Eswog4EObYV/E88rvqxRX9aaF3xEqwMz3H8an0MIGIt3DtU7gpO5AuaKcQBiXyUd+jPYy6TLijD
 /fHo0tkjjJC484M7eIE8IFoudnuoD1RHxZzDURgZAgpEBQur+y5k+mjsA6lKXoVdifBX5JYl3WV
 Mjpcl8i5V1I8+eM0dPzwaff1niZHbe5Twz66m8S02LIaAv0jDo3LF4w3lLDMDzX7Uv2jaR6XeKc
 e3yK+2u/SguX6cRULhgu4ukwWMFujsOFWi185jbLSZhF00Gy3YqaXCR5K9Ip7drsPMaxQv2pRW/
 Fw98H16fY5yAKxlQSKHim9ETcdfSLm0uGCW6N9J43E6AKvSm4bNENCgh2TA6Cl+KPNwAPvuW1uj
 /veJBmoYagW91F+gyq23/VSeuQ6hhO6XMKzYyK5H8PMtV6p05OPo3aDYglBZS74P5JxvucjB4zQ
 0NstgRBYQoeVRD5KKqyxmzzQNNm2k1FE64UAgMtcotHGoSW+lNc+NzsBl36WbwZNuxD0vr31ISP
 skDwFCSpnquUd9Q==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Register the vc-sm-cma driver as a platform driver under vchiq.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
index 6a7b96d3dae6275a483ef15dc619c5510454765e..09d33bec46ec45175378fff8dd1084d0a8a12dd6 100644
--- a/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
+++ b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
@@ -63,6 +63,7 @@
  * the interface.
  */
 static struct vchiq_device *bcm2835_audio;
+static struct vchiq_device *vcsm_cma;
 
 static const struct vchiq_platform_info bcm2835_info = {
 	.cache_line_size = 32,
@@ -1421,6 +1422,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	vchiq_debugfs_init(&mgmt->state);
 
+	vcsm_cma = vchiq_device_register(&pdev->dev, "vcsm-cma");
 	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
 
 	return 0;
@@ -1431,6 +1433,7 @@ static void vchiq_remove(struct platform_device *pdev)
 	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(&pdev->dev);
 
 	vchiq_device_unregister(bcm2835_audio);
+	vchiq_device_unregister(vcsm_cma);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 	vchiq_platform_uninit(mgmt);

-- 
2.51.0


