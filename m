Return-Path: <linux-kernel+bounces-802626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A10B454CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D48A5A70B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0C2C3761;
	Fri,  5 Sep 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k8IdPkbP"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0D25C81B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068415; cv=none; b=Ikr7Wx3vfIeri/p0P/yC66TvvhJat6Btm8lLlmockOQcwr3FFg5SDmHLECJnDsC3xKjKl+rapGOZS/9GBF/2cjX6KVrZznuruBifwiLfcHdNPwCP4j+qWK98JUlJrxlIP3tdm4qvW/WLoS6Ajyt9bG17SjJ/ULPHZtQqc7eezVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068415; c=relaxed/simple;
	bh=D7YdwhW1vYvMcOjQRLMZzGjxkzyVgthdK5KrId8iQBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO/g7SgEycKptGC26bGZA975yUFHJ87XChsDqoD4vlBXEM5Ew8Xfo4i/SkOuDEkR8Uc5ZkJAWroa3Jnx3PMsWPcPAks3VOt2OjFNTVIARsJH3wA0gAPSwtK390buArlaGEeli0vuaXLVL92jqkjqb7VBCcKknwGFGCf9IhI4/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k8IdPkbP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757068409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=93WUhwR/8sRIdEVQbXn2jRw424RE7/R4H5cbMH5sd+U=;
	b=k8IdPkbPuKwiN0WQtnVQSqlrWPc0gupOr48El0oaEMvMfD5qFg9dIpDTPvqBwdRXW+TaNf
	GhqrKAtq2q7IKzvF2uT0ArfsLLOpaA+DhFmUbMbF/YgFZGbOqmMBtcH1gZ1rvwcZH4Egfx
	XWGc0V4zIiMDg2MUXy+cy5CZ5kE8e2o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ibmasm: Replace kzalloc() + copy_from_user() with memdup_user_nul()
Date: Fri,  5 Sep 2025 12:32:44 +0200
Message-ID: <20250905103247.423840-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user_nul() to
improve and simplify remote_settings_file_write().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/misc/ibmasm/ibmasmfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index c44de892a61e..2d5c1df82732 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -525,15 +525,9 @@ static ssize_t remote_settings_file_write(struct file *file, const char __user *
 	if (*offset != 0)
 		return 0;
 
-	buff = kzalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-
-
-	if (copy_from_user(buff, ubuff, count)) {
-		kfree(buff);
-		return -EFAULT;
-	}
+	buff = memdup_user_nul(ubuff, count);
+	if (IS_ERR(buff))
+		return PTR_ERR(buff);
 
 	value = simple_strtoul(buff, NULL, 10);
 	writel(value, address);
-- 
2.51.0


