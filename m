Return-Path: <linux-kernel+bounces-880706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D54C26602
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16A84F99B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897234FF42;
	Fri, 31 Oct 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rqmu002J"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D534EEEF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931712; cv=none; b=jOAFtyYORcJEMhopXXsurI+8FuF7uacHefi1wNi16nG1x7buVU+giYVRAPKe/VPvS6o5cz5z6sjInrU9kYR0X0LYWmkuG2LjsxeM6nVy0d/LGCVRu5qSJvPcHj1CohDboPgslZEy+g0awNiEwaSxlOrMPCUaS4VjHDZnEgMbf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931712; c=relaxed/simple;
	bh=0VUnvhN+JpMns0ilAaC0RXBzsIqOeBD+ERttPQmNyI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhhB79b04jzuga21c3L3+tWOTSIe4hOwKxpMiIabSWHoaUOXu8xlDdHB2KhfLY8Mm5QWR9uR5sTmhy5edNyETAw0cw0iZ0tOV7Vqg4yfWcaLW/TL97iBFCavS+y5tTAysv59djd2DQ/hUvIFeX1ivNU1CLX2PJLaH35Bmv03jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rqmu002J; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C2EBB5;
	Fri, 31 Oct 2025 18:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931597;
	bh=0VUnvhN+JpMns0ilAaC0RXBzsIqOeBD+ERttPQmNyI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rqmu002Jn4ajVplh3U5ft9HREwtt9GyJP0vx91+GU42zBiP2ZH+aEuooz7l84Y3ob
	 xE/pwVnRMVvdc38HECwGF7reFL7nqDCcn9od6keV2yQA7HU/cWYrUp2atfMzyqQEpL
	 qomPkgGB2WBT1mFufeKHRx6Eiju6X25cwC2Q5s9k=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:24 +0530
Subject: [PATCH 04/13] platform/raspberrypi: vchiq-mmal: Fix
 client_component for 64 bit kernel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-4-0dd5c0ec3f5c@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=2VK8OHXcpTdqTpiX4wSB7ZKhEke5bjaA9vgjkEN/2M0=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGX+g4pLvMHyqwNp/aj0Link2ixR+06q0DXQ
 wacJ4x7sAiJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxlwAKCRBD3pH5JJpx
 RRPpD/9C5Vm9gJ3qGANqziq1xjWZiDH0CsCzRTusupu78C7pddH8gCdhc4Up/wfLuYCyM7T0b0R
 Mw6UuBd1wvq9XUQYSMiKVClTEzRQqTcaa7Fe9vk+YvjUB4xRGJBdiRN1IfEzB+kv5DD88mte1Dp
 btx9k6U40KsmDestcjB1aN2fmgogWZg6Ti6PjxQx3H1TAbCo5nC1BHQ85G3zr/WFIZIXnC+3MpB
 pUmo/ZcogM4mCZcRUX4vJY1GqYZe8+XuUYYhfkjHlsTP39tanlWOI/T9yPBvCmjGTbJ9j8XPkMf
 PYgZttqE+2MFLDVNPsxzmKnN8XrlvI2YaLIjsQBXiTLGyc1kKyE/qdZuySR0c1imHYsIMB3jY6P
 qqFhSjMZV6k0TYBb37c9KqAnzVxAcheZEiWnuDdHmAZvJ9FLMioLGnsu7lazF36ggCQ9eF9ujqa
 ESJzwNNxRIGyNclqY62LxAe2KQyBwvVda5/U5vaPn7LK8DOx9bzIs7zDX9JT5nABuHaEV29KjPm
 MtzzcrIfOuJegTU552YtvxhTN9VMIY7++nwXEu40owLtWjz74SEsLHTbW/O9uyxx+QuoDf0hQp3
 NriZL+3waT+FQ/KlYNXGS6MrKSfZvafsoI6PVB8VDzOfxol3zGte3CdqpkSSxsWeZKU9KjiWgXG
 nTJY94EDZys8upg==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The MMAL client_component field is used with the event
mechanism to allow the client to identify the component for
which the event is generated.
The field is only 32bits in size, therefore we can't use a
pointer to the component in a 64 bit kernel.

Component handles are already held in an array per VCHI
instance, so use the array index as the client_component handle
to avoid having to create a new IDR for this purpose.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index 1ad00bb0a02b482719a75749ed6ca50f43df24b2..6381495fc3867013f74bd3754ed64e0a1ce01574 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -459,9 +459,9 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 static void event_to_host_cb(struct vchiq_mmal_instance *instance,
 			     struct mmal_msg *msg, u32 msg_len)
 {
-	/* FIXME: Not going to work on 64 bit */
+	int comp_idx = msg->u.event_to_host.client_component;
 	struct vchiq_mmal_component *component =
-		(struct vchiq_mmal_component *)msg->u.event_to_host.client_component;
+					&instance->component[comp_idx];
 	struct vchiq_mmal_port *port = NULL;
 	struct mmal_msg_context *msg_context;
 	u32 port_num = msg->u.event_to_host.port_num;

-- 
2.51.0


