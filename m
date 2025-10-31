Return-Path: <linux-kernel+bounces-880729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BFC26626
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF79D352211
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3A358D15;
	Fri, 31 Oct 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="brKhu+F3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A23590B2
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931749; cv=none; b=GLr+zramnBJqI9n3AuElGqMJ6/yNEf6m8gl3iD5rXQgaMPw158aYF0Ok1sGAYR1EUrL4Bmik9o84LJsUdLBm+CH13k60WF4KYWx5D0ysPVK78UMDogB2/SMnN3ijzoxi2w1O9iFLZdkgCQn66P/ORZbbZMu9zKWVxJ0PlNMsCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931749; c=relaxed/simple;
	bh=5LsFZf/cIZrJvTxKTyeuhDVpVX8Vu2fnD0rlBUYfDdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOuQ/a8pxZdeeyU+pHw1ut5wC7OHd0XAdd1eGJ9tMiPuMVcm38T5Lf8Rfax9DDpUYOgNw1YVP3w/UszbWtzhzR7+U4+o49NI5jT0UWBGX5a5GFF/Y9ew/y60KBMMu/9mV9EVJk4Ju/3Zf4rcOv8YtPus9jqdcyW0Uk7IrEw8syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=brKhu+F3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD8BA16A8;
	Fri, 31 Oct 2025 18:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931634;
	bh=5LsFZf/cIZrJvTxKTyeuhDVpVX8Vu2fnD0rlBUYfDdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=brKhu+F3/ZRM/yOou/442+jj52hYUp94MxAi9MLiP3xMKIax2qmXoteg4rlTE8k52
	 HngMmcNsp7WkN+B/Gt98ljKXPvDlg2a3cOFPEjJL3jR8klcjPLVc9UBfBEkNUJFblY
	 TN9ZolPxlnq9YyF9BvOTz3ETco/+y6AH9zr21T4A=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:31 +0530
Subject: [PATCH 11/13] platform/raspberrypi: vchiq-mmal: Reset
 buffers_with_vpu on port_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-11-0dd5c0ec3f5c@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=xRyZ+PABcf09n5xFUP7XusKRU9z53iVixMht1alL/A0=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGe+YXRZScfcvd11TYSAIT6cz7VulpYyCdGN
 b+AW3CIOimJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxngAKCRBD3pH5JJpx
 RQ7+D/9aCr4U1C13o6L/8MAlZAO+/GW5nOOwjVt/uijThW+GJnyexb/ttjdJ+/R4vdO4NxSxP+6
 rDGYpQhMbFiaAKKd9wfMW+Vo4+dRAW8S2oy3PLKoGJVNU0A+sx6dHLbByDiMsg73ALYdJT5DwBu
 J1VwCfMoPuqVeKiVbRtZZoSYkUBlptGmsbqDqhQY1S/PB1VAQ5uU8bysjEm0YKqGhiWwXZPSik3
 q8wgxim2pr3aRd1cfGM5PfyM3FUbzQRVK4k+B2Jxwxx2WtH0FsmjjN6/8DcY2z5KJrf0kMOTphz
 WEJwOU+kHIrRtfaHLVB5ei+1npC2y07IzCkhjn/mgdTbEHq0moUWH1nQbRPmmxbBwCUh3ovLn9t
 sYfI8A4ncKfoFh0ziwT29DF4X7EGZQ9EHyN5uAZ7bkTni2bjz8cKFZ0LN5p+K30uSv9b/Yv2wKB
 RGaBGTy2H+6sXNtxoszQt5irEMwNaaXpUNfv0XQVWDhfCxEWKmO28W8eN74k2YY++0gZrzxGSN7
 86VpsndO1CZXzhJYdJQ/SgvC7fwPE9vebHA96+tvvZCHYOnJwSMsnyUljc3VI5XFr5C+MxP7lIY
 bjIjfVSz1d9DiUnSxpFNaWDnGDu60U5rP9HfHjpKmgyXZvNtJpDKq09GNTmWwvJ1Ecxub27UMVq
 2jZ8mp83cYQFc2w==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Should we go through the timeout failure case with port_disable
not returning all buffers for whatever reason, the
buffers_with_vpu counter gets left at a non-zero value, which
will cause reference counting issues should the instance be
reused.

Reset the count when the port is enabled again, but before
any buffers have been sent to the VPU.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index 02fbf061c171cba287657266aa1731333609b3b0..f9e1a773fa55f885f240f4945b980f77676d83a6 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -1490,6 +1490,8 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 
 	port->enabled = true;
 
+	atomic_set(&port->buffers_with_vpu, 0);
+
 	if (port->buffer_cb) {
 		/* send buffer headers to videocore */
 		hdr_count = 1;

-- 
2.51.0


