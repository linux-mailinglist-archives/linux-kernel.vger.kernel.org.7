Return-Path: <linux-kernel+bounces-807867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5315B4AA8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8181C6092E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19231B116;
	Tue,  9 Sep 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOzGirjN"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFB23ABB3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413553; cv=none; b=U+Sn2f+fHv9fAQ0Nu6O3OD6CMm6+gQH5lMw2iN/jVEM1tNCKK+aVZrFw7okzA8197z3UFZcNHuPLaWB1qXMo73+SWy/9HVysQp3zV1axxVd9n71RiQCPqGVs9xHcfcn1NKpebYiWpm0gUgepW0w+VENcxGhA2QRUuRNx0t2r/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413553; c=relaxed/simple;
	bh=p5LhXEGcLou/f6INyxNHsNzvlEz6x7HFoLOSbFUaVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQcDOj9tnv0cH3CuuT9RF5HdBJrZUt1gAsYFW//y/AELuEOFvMSwVLDrmwq+ePY15vP97ZC0F6cLUKSnBUu1HHpYMLIU9Tj4sGoAFYGae60TiDzboWBzp6/GCzVbRw3yopjsECqwAAtcwnnGFzpETjCNyoV6FM5N5FCMdsixqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOzGirjN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757413546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ejyOVWNZnM4N3Ivi3K/PAopR0Lc4S3yDQSFJewEL248=;
	b=bOzGirjNc89HFYUO7bNBKxqLRtE6F/lgIIgN3nre+0+sMsO9BDJv4t3oByr5BnzI6VYtU6
	A50lAWW+/SrsIVMEp3qCA5EmWZOOned6SOI0QkGT9qR3E9vWGtCrx8bwiQ/M2dSkFxGYFY
	aFSw28tR9jSscq0VwVjpkNll4VSkXBY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] stm class: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Tue,  9 Sep 2025 12:25:12 +0200
Message-ID: <20250909102512.694203-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify stm_char_write().

Allocate and copy only 'count' bytes instead of 'count + 1' since the
extra byte is unused.

No functional changes intended.

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


