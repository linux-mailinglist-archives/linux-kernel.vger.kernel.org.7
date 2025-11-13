Return-Path: <linux-kernel+bounces-899095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF37C56C39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0E03BB177
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357592E62D9;
	Thu, 13 Nov 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariuszachmann.de header.i=@mariuszachmann.de header.b="KrgCdqcV"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BE2E3AF2;
	Thu, 13 Nov 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028389; cv=none; b=nI7EdEwI7C3UKUCfshHDRDXAk9BFpcH+x+xMpcmc7/qzYtd2cW2lCOfVugB4errgLtuNcQEKPPJVhyyD4osAVh9GAWfL/8D4vk4LPX6GT1e6OTkG9EHMFewOaSS1aPHv8fdnJc/kOmQC+qJMFq+iEiZ7I2AgSJ9fJpFbPdD1r5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028389; c=relaxed/simple;
	bh=pO8SwLnIvnuTHMLjXxP2KDEK/lQI9uUpXyBuVHnAocE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNV4e9+B1YKxfzz485jF+mID/FYexQX7ytEDKyCIeJfPUMwenPjE+9KM6HAnvULQU+wx8DPmO87M44KG/nWt57PJwTcxEHD1XrJxi6BzaP22dKxta73oiEQDm20hh9oU5vr5V1UBnTv2frpsME+IGjcTFJJV5df5oFiHuxbqNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; dkim=pass (2048-bit key) header.d=mariuszachmann.de header.i=@mariuszachmann.de header.b=KrgCdqcV; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4d6bPc1p9wz47Gm;
	Thu, 13 Nov 2025 11:00:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mariuszachmann.de;
	s=key2; t=1763028052;
	bh=pO8SwLnIvnuTHMLjXxP2KDEK/lQI9uUpXyBuVHnAocE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrgCdqcVGD+kPBS6mjHEwCdF24cJke1qxZFsZm7a7QmEIou0/aV643tDZ+u2SD+qm
	 xmHwdwtA64rUyCttZjjmJfvRWwyDcKcWptlNipzBM9IKOqpmWC4z2BGZclrbhtfY3Y
	 RrKGaGDZc7s1Sn+yeN0jIi3kDH4d+/LGaBJoixSvkGOYQWA89/jLR/ZtyivNo41GVi
	 fMvnV7/yL22WVcPVGvoLNHcIz/7S5HY/d4E756pHtUeeqcuIjIZHj1ZYzT+OqyJhHQ
	 9abiV5RP6YlSsYL/X1goZns41GCzekHStwPSk/RtUNwdtEIQ4i639JMvqdv8xQwksU
	 D/cC0eO0wrWGg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4d6bPc14mRz47GZ;
	Thu, 13 Nov 2025 11:00:52 +0100 (CET)
Received: from mxe9aa.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4d6bPb6Lf6z8sbC;
	Thu, 13 Nov 2025 11:00:51 +0100 (CET)
Received: from marius (dynamic-2a02-3102-8004-0800-b21c-0b06-5865-dcdb.310.pool.telefonica.de [IPv6:2a02:3102:8004:800:b21c:b06:5865:dcdb])
	by mxe9aa.netcup.net (Postfix) with ESMTPSA id 0E6D48009C;
	Thu, 13 Nov 2025 11:00:51 +0100 (CET)
Authentication-Results: mxe9aa;
	spf=pass (sender IP is 2a02:3102:8004:800:b21c:b06:5865:dcdb) smtp.mailfrom=mail@mariuszachmann.de smtp.helo=marius
Received-SPF: pass (mxe9aa: connection is authenticated)
From: Marius Zachmann <mail@mariuszachmann.de>
To: linux@roeck-us.net
Cc: mail@mariuszachmann.de,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Replace magic values with constants
Date: Thu, 13 Nov 2025 11:00:24 +0100
Message-ID: <20251113100024.11103-3-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113100024.11103-1-mail@mariuszachmann.de>
References: <20251113100024.11103-1-mail@mariuszachmann.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176302805133.2250130.5825952192716163697@mxe9aa.netcup.net>
X-NC-CID: EsN6IQ3yOu//ecgIdG13T6L9hBJpmHpB6XDXUTYxr9BSku0tmvk=
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 0E6D48009C

Replace two magic values in ccp_device with
existing constants.

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
 drivers/hwmon/corsair-cpro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 6e1c415f3e26..e755353dd461 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -90,10 +90,10 @@ struct ccp_device {
 	u8 *cmd_buffer;
 	u8 *buffer;
 	int buffer_recv_size; /* number of received bytes in buffer */
-	int target[6];
+	int target[NUM_FANS];
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
 	DECLARE_BITMAP(fan_cnct, NUM_FANS);
-	char fan_label[6][LABEL_LENGTH];
+	char fan_label[NUM_FANS][LABEL_LENGTH];
 	u8 firmware_ver[3];
 	u8 bootloader_ver[2];
 };
-- 
2.51.2


