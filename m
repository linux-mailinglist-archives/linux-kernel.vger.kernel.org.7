Return-Path: <linux-kernel+bounces-880725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6BC2660B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8279F3520E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B353587AC;
	Fri, 31 Oct 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n1ZforE8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042C357A3A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931731; cv=none; b=U12VCbw+MHC/rjeZi2ViZiBlXNDInKDOFj+xUiMW62Gxx2w2mFiysrRzZdCgdgUlUTPueuUshIgfaciVUnr9Smiifm9Z2ZFdugi0MkVkcSQe1QI2QLX9hJkspDwUt8fiqLef3Td3EtnOgjQmH7pMFzjPfIYvYB2qg5rWLG+2cfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931731; c=relaxed/simple;
	bh=M82WFeZ7VFa/oUdRBWdKzF41B/nKaOXYBrqQT4FuP9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOXVbMyWRydbNjGhWn+wrKx/xl4av0dhoQRNx7aY2LBAcaAnJU7j9DORwWLUQ8o81Q/NKVlEdc35Qwa0UisUlEYXK8+YRzreoNGauUA+BBvdbTEdG4I2aoqe/h4Bk8HN/ALNXUMSzP+QPlArCx9OhN15rmhkLzsetUN9pCemPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=n1ZforE8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CBBD53A2;
	Fri, 31 Oct 2025 18:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931618;
	bh=M82WFeZ7VFa/oUdRBWdKzF41B/nKaOXYBrqQT4FuP9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n1ZforE8se6yQpa1hRW6XeuqOfbEzxy2X8H17+hRobxK0Df31mofoTg5HKQTbORTz
	 RuTJxS3j0j89pvaiKcXAC5kORXkBq2Fu+FzQhzY1pkgtb7DBs07SAzyZXNgbubemza
	 PgSABl02s8tQDG5/+0rXjkuSgBVJwhCF2QgxU2nA=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:28 +0530
Subject: [PATCH 08/13] platform/raspberrypi: vchiq-mmal: Fix memory leak in
 error path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-8-0dd5c0ec3f5c@ideasonboard.com>
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
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2672;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=El+RK8d9+LHdrGvU0xUfqJDBZbtRjVDpARQlhUyJjtE=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGbBw5eStZhVv0NTK+DUkgbbUDFcFgFCQzwh
 /meHGhP0DyJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxmwAKCRBD3pH5JJpx
 RTgdD/9zIM/KFkyFaHgf7omYZbb8OUtQlRrw5U6e4jASYThQKOYjYQozZ/e0QFlE5QIuTQLkGKs
 Lf5em85iM90WSXjhL8WXk9dFKx3v36Ii1ySuAwwv21VwLYIwSpt6fGclGqomJEc39CFtsOEbkvp
 PIqEs46sZn5a6pUPAYNus9x6P36DG5tHSf9oaVKW8DPiKPUv/iww5ocvJgyfN4JfDedWDOYvpGJ
 /GWx+Xe+Kj4HyCLor+2GMI/A0RNpCEw9vQdAPdM5PcXgwyJoYbSkAbvAXY/xmPVRXLMOJIaW3ZJ
 A2cgtiXLcUCB9dJrIc6GuAQJ4jxVLUA9LrmU+rpI8yAZSnY/mQyTEa8AJUtaG7RuxQG1mC9cf9r
 R3MO1/gMxrEsulEEZs4BgxAQndIR1X0W5iQNPZoHBpBOq+dRI3XUHWYvdWioKhZZyBQutcPHY74
 Uw/l0kFz1DF32kKYwqzkB4ytmnjmzCEOOlYvvk/wZ05+kipQK0twK51xHw+jfDcB857M7gURltw
 Tx8APgPaab7T5cdmMS+vxv+7QmttV8R/+t29VKHeKseCV7mfP6mGygmcDe7q+HGqBE3U8PBR/ND
 jXmlTiq7uSs1zMp4iizxD+TCLS4QC0CsZpGo8VSmh5427PnqcA1EMZzxlGdxfZWLreTD+tW/8yo
 3gU72VCsqy7VL9w==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

On error, vchiq_mmal_component_init could leave the
event context allocated for ports.
Clean them up in the error path.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index 36f3b068c825e6a26508aefe544f7061c9559510..3c99d0f3e57178761ec57d97cd77e59aa26143fa 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -1768,9 +1768,26 @@ static void free_event_context(struct vchiq_mmal_port *port)
 {
 	struct mmal_msg_context *ctx = port->event_context;
 
+	if (!ctx)
+		return;
+
 	kfree(ctx->u.bulk.buffer->buffer);
 	kfree(ctx->u.bulk.buffer);
 	release_msg_context(ctx);
+	port->event_context = NULL;
+}
+
+static void release_all_event_contexts(struct vchiq_mmal_component *component)
+{
+	int idx;
+
+	for (idx = 0; idx < component->inputs; idx++)
+		free_event_context(&component->input[idx]);
+	for (idx = 0; idx < component->outputs; idx++)
+		free_event_context(&component->output[idx]);
+	for (idx = 0; idx < component->clocks; idx++)
+		free_event_context(&component->clock[idx]);
+	free_event_context(&component->control);
 }
 
 /* Initialise a mmal component and its ports
@@ -1868,6 +1885,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 
 release_component:
 	destroy_component(instance, component);
+	release_all_event_contexts(component);
 unlock:
 	if (component)
 		component->in_use = false;
@@ -1883,7 +1901,7 @@ EXPORT_SYMBOL_GPL(vchiq_mmal_component_init);
 int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 				  struct vchiq_mmal_component *component)
 {
-	int ret, idx;
+	int ret;
 
 	if (mutex_lock_interruptible(&instance->vchiq_mutex))
 		return -EINTR;
@@ -1895,14 +1913,7 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 
 	component->in_use = false;
 
-	for (idx = 0; idx < component->inputs; idx++)
-		free_event_context(&component->input[idx]);
-	for (idx = 0; idx < component->outputs; idx++)
-		free_event_context(&component->output[idx]);
-	for (idx = 0; idx < component->clocks; idx++)
-		free_event_context(&component->clock[idx]);
-
-	free_event_context(&component->control);
+	release_all_event_contexts(component);
 
 	mutex_unlock(&instance->vchiq_mutex);
 

-- 
2.51.0


