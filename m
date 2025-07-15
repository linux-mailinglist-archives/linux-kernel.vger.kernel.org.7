Return-Path: <linux-kernel+bounces-732306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757FB064E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672721887A71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB7028507C;
	Tue, 15 Jul 2025 17:06:11 +0000 (UTC)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807C27E052
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599171; cv=none; b=U/XPRgWWTVk5rsc/mqqumWF/TqGUcmpJ4pxieox2W4egjM479EaPRX3q7Lv4Jg68YCnBP7Axl5ISPhWQJMWBPW1YZLAw3dmVlkgEF1BbumgOZqTwqhM5Td7H8x5YiprzYjYf8ujQr97cMi+LatvPFIoL1WfckP/QbZXuoW9CyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599171; c=relaxed/simple;
	bh=3bn2wHNalDwZ/lSyGnuadMAEP0yF+VwohFcFdSElLQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNZgyj9zbma0nGRpld56RimozXq15fHtWk3opzs1KTobonXTYLqcMjcDNg3pTjB1WRldhjEXMzv5tKDKS/YIVN11KNnaH9ff+f4VwyEOuS1myb2ndCGucDnijyLu+U4VKmpHyMY5mJbi72BILCirb6MvoApXAoLVw7MeZznTTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH] accel/ivpu: Remove lockdep_assert_irqs_disabled()
Date: Tue, 15 Jul 2025 18:59:19 +0200
Message-ID: <20250715165919.33754-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This breaks on PREEMPT_RT, and should be unneeded since
lockdep can track irq disabled status itself.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/accel/ivpu/ivpu_ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 39f83225c1815..5f00809d448af 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -141,7 +141,6 @@ ivpu_ipc_rx_msg_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	struct ivpu_ipc_rx_msg *rx_msg;
 
 	lockdep_assert_held(&ipc->cons_lock);
-	lockdep_assert_irqs_disabled();
 
 	rx_msg = kzalloc(sizeof(*rx_msg), GFP_ATOMIC);
 	if (!rx_msg) {
-- 
2.45.2


