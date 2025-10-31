Return-Path: <linux-kernel+bounces-880694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80DC265BA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DD7A4F6EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1592034A3CC;
	Fri, 31 Oct 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D4wBnh8r"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6430596A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931700; cv=none; b=gn8z9li3gGL7SmDdSrjuD8a/qFPTGR32Yd0iMeD9YoL/QwNY3GAxoXE7yYPzotOl6UXRtxo2hlPKcDBvRnrWdikg5FdwcrEs2gKveiBg2AnJ1DdBQlzTJq5X+cpO72tS+duYm7TLX2gz+V807c5DQVH2PDFAxQN2zC4Wsj9cveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931700; c=relaxed/simple;
	bh=l68kN9KWDjW9nSkNO372Wnz3xFDAD1FzVJFblm6+7pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JH3rUuK6LNucwZyj4K8f7vBwpjZKfDPz/HZXGJ8wn/AHkZmKAYKXENfHyII4fMzEo8IhmV+ef7lFlUAVLXwXgUVMUBO29Mmcynmb7j9Wvr59dKXWBibGx5gdKWVUg0KRCMqLgAyfn/HifrxYMQUyY5DG3dGOqm+mdvsAI6PQ3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=D4wBnh8r; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B1EEE3A2;
	Fri, 31 Oct 2025 18:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931581;
	bh=l68kN9KWDjW9nSkNO372Wnz3xFDAD1FzVJFblm6+7pw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D4wBnh8rAxcgn6ryZtItSuDdg0e5rsCnnj/+oPNrGcrn//aEZDkkAIy68TONrfQEe
	 rZT3vAh+HADcrdY2EjHUfZbKTvWnCneR9yE0yz9ZHZdIn7etKg8doWy+Ub8Dja+tf2
	 dASRZNY3iIaJmmbdJskuYPdZwKc/VC4cRb9psxb4=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:21 +0530
Subject: [PATCH 01/13] platform/raspberrypi: vchiq-mmal: Avoid use of bool
 in structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-1-0dd5c0ec3f5c@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=966;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=dAC4ccqqIuDds5cBVf3x31HLujLoig4utiWVx2tzBPM=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGUV8VJlXk1bMRIIzM6TX/TQUmI37R6cD456
 M1HZLx4+t+JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxlAAKCRBD3pH5JJpx
 RazcD/93LmOyrHw43/Q7OPUE0Eecq95o/vz5Tnmsdd7jFhUYmzxOzJcEhDnhpIYCnL1HiXPfW7a
 eAe8FFZ4SwSdgV1uBHEUf2fEc2H7V++r0bgUOwFhWDHVjUrfE0d6Xj45PP85YuzR/dDSaFfnpCv
 X1Rdq0yKdtekoXHbUd10HL6vhKKFysPD+B7INA/L+85sn5U7qvL10WnLHc1r2aE9Lsancwv8nCS
 G0LwKQPoX+nbfh2vzgaCEbll6Pjce5JWaDNzk32niWGsXb4mDIhRRRqtnDjjfQRmdG+cZFJP87L
 6e/MM2KkWpPwLLIzdg/fzvR+P+BPF+fEzMJrjEDzuCkrGh49Cx3C0bR/9NJH0WtqG/0Av1w8MdW
 LlAhMGzKbXSi+vMfIoGy8mEWhTR6uWuoc6Pk8cyj60FldXR76NDWkKbVfyni0saF2KrOGNUdt4k
 YuGeHH9QcQLG6Yp0ts/b+EBXxr3d982eMcExwpDTY1exYW/Ek89iUR3MHa6FLDw8YXEeg/Xo95Q
 sBbcOsOdu4lp3+XTERyEaMMJkhVY/Q/T49Fp9nqXIrS7htS7cKGfOYW6Gq6SHOx7F0PcoKHzrpJ
 1xK3How1d4qETh4Xd12bo5/4ixuY+n9IT3hDtMNBcbcpfNeUgaGLxAmrn1bPLWXY5Ei04Gfw2pK
 NlI5jhi/1TaoAgQ==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

Fixes up a checkpatch error "Avoid using bool structure members
because of possible alignment issues".

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index cd073ed3ea2dd9c45b137f1a32e236e520b7b320..82c2c261fd9cf0669cbd2ca7c814e0703317885a 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -1776,7 +1776,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
 
 	ret = enable_component(instance, component);
 	if (ret == 0)
-		component->enabled = true;
+		component->enabled = 1;
 
 	mutex_unlock(&instance->vchiq_mutex);
 

-- 
2.51.0


