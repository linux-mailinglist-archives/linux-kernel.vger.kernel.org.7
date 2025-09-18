Return-Path: <linux-kernel+bounces-823015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D47B854ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C794635DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CBB308F1C;
	Thu, 18 Sep 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kqKQkA7n"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB4214204
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206530; cv=none; b=qPJC4gB/J9hUwW1i5YUZ8+kF8jlWQnQHbclRY6A+aFF5yMQCOKnXCHOljHrlOoEXDQS4B8ulFZmw7vL3GZW4TZPbrBqcvC/uNZs4F0L2UHCn+2ra5o9rYx+RJ02Uupgj8omiOw85fAG6NlVc4aqBVYxmelmCy6qCvEnrweGSqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206530; c=relaxed/simple;
	bh=lIqF7SobE3jlk9Ur+yA6oA5MrzHP8rPuVgTkZhdOYas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fts3Sjs5jr3yNEzQdd/mae7Ul5UOiQEbp8miO0//sVtVQEe2ciGW5TNOqLBPuunIPBFBEFnGfrT1XXWfQG4VHfZXLqMu2GU5TxW11N/00L6YJueAq4/jvP7aYihMimN4fgXfaYMQCmJhx8IcwgvxKrbTDf5Yrpa2bA5Hyc3EgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kqKQkA7n; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758206510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+WnQWfcuRskG69FtOy67tDcJOkD2U0BCxAn6o7LjEV0=;
	b=kqKQkA7nLP9mVnK1LJaXwMxG2bnygclpaDMFijhynBfxZTrP2q5Yg7t4Rd0JXcucFPIcJh
	Vo/6e2BTki08VwGBY0EHrxjiBWH9T8M1lqiZxRb61iwOhYs4atmL89HHf6GtgSx9U0KKuX
	mUXz9bwAZZb02nHJAMhc2Kbpp/iMr9U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bfa: Replace kzalloc + copy_from_user with memdup_user
Date: Thu, 18 Sep 2025 16:40:32 +0200
Message-ID: <20250918144031.175148-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify bfad_im_bsg_els_ct_request(). memdup_user() returns
either -ENOMEM or -EFAULT (instead of -EIO) if an error occurs.

Use u64_to_user_ptr() instead of manually casting 'bsg_data->payload'.

No functional changes intended other than returning the more idiomatic
error code -EFAULT.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/bfa/bfad_bsg.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 54bd11e6d593..d90dfee95160 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -3392,21 +3392,10 @@ bfad_im_bsg_els_ct_request(struct bsg_job *job)
 	if (bsg_data == NULL)
 		goto out;
 
-	/*
-	 * Allocate buffer for bsg_fcpt and do a copy_from_user op for payload
-	 * buffer of size bsg_data->payload_len
-	 */
-	bsg_fcpt = kzalloc(bsg_data->payload_len, GFP_KERNEL);
-	if (!bsg_fcpt) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	if (copy_from_user((uint8_t *)bsg_fcpt,
-				(void *)(unsigned long)bsg_data->payload,
-				bsg_data->payload_len)) {
-		kfree(bsg_fcpt);
-		rc = -EIO;
+	bsg_fcpt = memdup_user(u64_to_user_ptr(bsg_data->payload),
+			       bsg_data->payload_len);
+	if (IS_ERR(bsg_fcpt)) {
+		rc = PTR_ERR(bsg_fcpt);
 		goto out;
 	}
 
-- 
2.51.0


