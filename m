Return-Path: <linux-kernel+bounces-880719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F431C26632
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5947B4629FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5AF3563FD;
	Fri, 31 Oct 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JErt/xIl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C003081B6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931725; cv=none; b=bE0jXWjpUEkegoJS2Fm+8jfz1CccROCTRw926IYSdOwE5qXTp0PEXffWUiJsLaT6c+KuKKGrpnsGDPAX+geDdeQFyNSxks47GD2cetT+Yr8sr3Zvh+lbzi4qxcW5sxs5OcaeYZz5h+LLc1E8KbB92lPg/o7VHxw+D5i88uAs75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931725; c=relaxed/simple;
	bh=Dukl/WKTNn0wwgbhbk8IkuZav/VzD6UEX4T6MaTL8AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIwBaulFeDXdx4ASLScAhoI+QONEgsf6FGJrR6FGJ2E7yjl6W+zIVvSosKPj6plIIliHYUyewJ2NNMvyO8DpYE50LoinBOcTlWN9Tm3do9KicZC/25rDcXHhEK2cGUGjLMaVxDKCG3/xLqcV/+KnE9b8ZfiWUwydu1bTeo+KVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JErt/xIl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33F853A2;
	Fri, 31 Oct 2025 18:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931611;
	bh=Dukl/WKTNn0wwgbhbk8IkuZav/VzD6UEX4T6MaTL8AI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JErt/xIluRppHac6UmQLtNHQ8xbdP7NMebnfJobJMrO/5beQL2n18ETgdXfBKSpco
	 EWn77E+2ByJvQrUgVIkNXGX0CpMOMDMyXSFPcRNrNHa/kSyQFpORX8g9WWz6I6Hfud
	 lTHcD+Q3zi755s+0J9L8LphMtHh1eKsmRROT2L9w=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:27 +0530
Subject: [PATCH 07/13] platform/raspberrypi: vchiq-mmal: Free the event
 context for control ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-7-0dd5c0ec3f5c@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=fPg0a6AIcLpabOkEcm9pZiFTJR0XeNxvSGleuAQ11J8=;
 b=kA0DAAoBQ96R+SSacUUByyZiAGkE8ZqgehNmv8v3XSihPC2d1bJhKHNTCrIaLVCwkdJm2qI9e
 okCMwQAAQoAHRYhBE3g2Bjl1XXo1FqvxUPekfkkmnFFBQJpBPGaAAoJEEPekfkkmnFFM/0P/Rq7
 34LlQMjVNWBWKTieL7tV5W5qqp0AtCNAaXhGrIbeczi/hRveSe6jo9KEPhaHbVFVwGsezputZBp
 h7gsry5T+tZRT4Vr5VzBrIh4zbxs9qwmIluDU8mGlx6DyT2eTS4C9tSN9Jp+2dokoeffT3B2qXd
 /ztToWAspYbDFGYtQzPzGxa/kR/HBq9G/7GfcQt4v+kf/x/j3CfX0XPppooHmwZGISts6/1AsOo
 xde1q4GxMDsqSwOgU/WTeVY+n/Ntax41+HA5O8XLpKe1wh4aFrGzfYWzmlgQY5HoAnAw0ZtVKO/
 o51ZD90HlrLrNJ+GcNudDjpS2kW8/hGyf+9Y8olKSACykq63GQW7g+p2w/yVrYPkCeF/9sDx43J
 sSJqqxQnzGqqtVeSkAqw4cxyhFvMiSGV8LE2V7Wq/rbn0i8KgQ8E2+RmZp8lF8UsEVU84lVW04B
 dfLNf5pgo/Hw7JH9BJmkZrmcOZxNqVfQvTE3Jdr6Fi0yezUvd2FF29x/TS4Jrzk/65TMK8v/RD5
 xnfysoE7UZNSaDzRXDjIxJjuqPdJtcJFXLhuu7LSHOwtgp1wItDO2ICwhEIjdV75g9lAkTVzv0B
 n+VAbnHixBd4QucxeRyllZ/LDOFnIvx8KMIN3riWx3kn3gLXuF9aPfuKXvlaFwzX8WTmCy612mN
 Mr+A4
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

vchiq_mmal_component_init calls init_event_context for the
control port, but vchiq_mmal_component_finalise didn't free
it, causing a memory leak..

Add the free call.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index 6381495fc3867013f74bd3754ed64e0a1ce01574..36f3b068c825e6a26508aefe544f7061c9559510 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -1902,6 +1902,8 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 	for (idx = 0; idx < component->clocks; idx++)
 		free_event_context(&component->clock[idx]);
 
+	free_event_context(&component->control);
+
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;

-- 
2.51.0


