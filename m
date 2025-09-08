Return-Path: <linux-kernel+bounces-806700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9241EB49ABE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56589188DE03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D182D7DEE;
	Mon,  8 Sep 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqvgMC4m"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAB2D7DDA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362259; cv=none; b=K1HbEumWScataFwl9bA+heaOPWC/D5MDcpJlzEytjb1WcxR1RFUSrxVpJbUj1gR0kYCkUE1EVdrME1ii2UNVp6QLHRR0klLOleerb4mMeaoC3nxX/YbF759H/QOj4+Vdl25v8cuwhR5zGlixTK/Kc9ncFXlw1FoS3wT/JNDWlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362259; c=relaxed/simple;
	bh=GdWo5qY2s+/q2DpoLVfpe8mWXYCuezbFaAPeomuAb9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAPY1Oakxx/iWdHe4l5DcW2RuEkJbAxEzoKvYjXGrb7gy8+5yx7LzXBsgI2tuS3xS/PRkhS3r1x7rPvfFYpnpmP2Oo4N0O5YArZVXqxeqY7gtdMEm+F/jmrL4sbe5R926462X4XeZonAfj7j1S9MsEu6Y9+4i/OJ+X81M7KzeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqvgMC4m; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757362244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ARYB/S5SqL4eD+uW75wvhyRnd19Sdd8JhvFggm3s75Q=;
	b=XqvgMC4mKPssXCE7EmlpVlIaoMbGNzGc2Chh7TlK+hAi4I2DQhkE8qtc3TfqzMgs8R9QjE
	8kNSAwIyA/s8mj4OfpI8P6LmDYRtQzEdbWf6V6C/EG2pdcneqw0zjMlwJlGDBGaao9WSKn
	q3MrO7oc9diw7vVmejVz43wuBRnYw8A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: floppy: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Mon,  8 Sep 2025 22:10:20 +0200
Message-ID: <20250908201021.439952-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify raw_cmd_copyin().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/block/floppy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 24be0c2c4075..b33c6543ddf2 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3092,16 +3092,13 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	*rcmd = NULL;
 
 loop:
-	ptr = kmalloc(sizeof(struct floppy_raw_cmd), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
+	ptr = memdup_user(param, sizeof(*ptr));
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
 	*rcmd = ptr;
-	ret = copy_from_user(ptr, param, sizeof(*ptr));
 	ptr->next = NULL;
 	ptr->buffer_length = 0;
 	ptr->kernel_data = NULL;
-	if (ret)
-		return -EFAULT;
 	param += sizeof(struct floppy_raw_cmd);
 	if (ptr->cmd_count > FD_RAW_CMD_FULLSIZE)
 		return -EINVAL;
-- 
2.51.0


