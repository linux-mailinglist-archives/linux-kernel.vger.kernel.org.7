Return-Path: <linux-kernel+bounces-857847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB18BE8107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 389954F3C59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FB31064A;
	Fri, 17 Oct 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQG4n4Va"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599D29BDB1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696911; cv=none; b=FRU3cSyFCJDBYs2AT+aMCDedGT/EHvmklOsMVSEDQZGuuqRcAoV890uqw/DtR2sEDx7w7EwKxfBnSUnCrWL0/PNn4w5J0Uxt5xzIq1I8w4EAEfVhj1V7es9uFDG+Bv5qMNeE9j5ZsJwunGVwbfVKXQp2eQ0aOCf+gyQuy+dWZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696911; c=relaxed/simple;
	bh=cwbKcDkqcazpSY0xW+hoZDJvn6Vdm8ZtWoRuzYArkyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4VPfWBr80A7+VVi/X4tZVXRUKQtH8y9CJ5vh7XKDYzlhRJ8UgH9J1Gj57xNC+vP/nDBMKdjugzWaDjGfB4ejO/J+sY60onJyurs0KZtJtLqrbo4biVpgcqWn/5LpghkgeXj1cb0sZHbEKfLjv8Xw9sLAQA6fcyhXrGsu/qkCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQG4n4Va; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760696907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W1IDrz3RmQ+DjnJHgkvZJfeGuFV4FYY3VXTJn4UzdsY=;
	b=LQG4n4Vai/wW3aF62q1eiUNmJjL5j3yRF7CeP3SbZ8TiUo9B8fklD1tcXvOIKbIQDhkTN+
	BuQVstW4GNimda8ZTHaPXOaCfuAXBZ1TGQCSEYCQRj/yTtLznR5VJlXq8+B2m/kuwNgGWI
	TN1vWPrCLBg0AHc+mvYBIoymOLwKMik=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] stm class: Replace kmalloc + copy_from_user with memdup_user
Date: Fri, 17 Oct 2025 12:27:42 +0200
Message-ID: <20251017102743.75394-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
simplify and improve stm_char_write().

Allocate and copy only 'count' bytes instead of 'count + 1' since the
extra byte is unused.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/hwtracing/stm/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index cdba4e875b28..5834f796e86b 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -645,15 +645,9 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 			return err;
 	}
 
-	kbuf = kmalloc(count + 1, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
-	err = copy_from_user(kbuf, buf, count);
-	if (err) {
-		kfree(kbuf);
-		return -EFAULT;
-	}
+	kbuf = memdup_user(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
 
 	pm_runtime_get_sync(&stm->dev);
 
-- 
2.51.0


