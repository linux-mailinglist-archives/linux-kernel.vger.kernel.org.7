Return-Path: <linux-kernel+bounces-829401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E34B96FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB842E3FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48F274B23;
	Tue, 23 Sep 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2D6VEKk"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF491FECD4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647726; cv=none; b=PoL32aPcVtgV0M7jEQTxNlFu0usjXd8phbUQhR8gSoLycdLs0p3TO++J3L0gXupsW2zSN4qyqASzzfp0as1h34OUTcJK1iJXiikzMngr8vLybB4ZFu0sfT2NcL0OauPf5Ity3bVdbVx3ryTJKYBmsWkHN39jpdfje+efntOVJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647726; c=relaxed/simple;
	bh=/4ecEdJ+qGjfmy9yImHlAlNmO8QiCe+KsB7GVqxPqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDc3NTQzfkxYRs3gGJfuZgX9VmODDrJYkxFY9HP5+yuiAjkj1jp1rxLjhGoRDL8DGCpqTq+AH6TC3EsyPBubhEof/dwGq6WXNl3EqphJo8NBmRI/radPAOCzsIk4rf0ifZXdw0HYZ1y/XmjqAeuP2E4GtyNccEY36zTE8zd14bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2D6VEKk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758647712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GN4o6Rpepn1nYUO5av96IxMhD2q/WJpyOYfgvLYpNxI=;
	b=Y2D6VEKkYuZLHVEfhlP3Xh2YdeFXpFs13yvbTfGNd3j+OwROnT94F/tbswBH3lhv7bb2T6
	xT+PDgZ8UhdX5AaLPxoixST3OQJmsMhnG/8iLFg3ZOB7Tk1HqKo86nwNHyCU78W9QUdyVA
	u4S1JQTmeOQyhSgDPkF7sKSfLnen1d8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] scsi: hpsa: Replace kmalloc + copy_from_user with memdup_user
Date: Tue, 23 Sep 2025 19:15:04 +0200
Message-ID: <20250923171505.1847356-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify hpsa_passthru_ioctl().

Since memdup_user() already allocates memory, use kzalloc() in the else
branch instead of manually zeroing 'buff' using memset(0).

Return early if an error occurs and remove the 'out_kfree' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/hpsa.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c73a71ac3c29..55448238d8ed 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6407,18 +6407,14 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h,
 		return -EINVAL;
 	}
 	if (iocommand->buf_size > 0) {
-		buff = kmalloc(iocommand->buf_size, GFP_KERNEL);
-		if (buff == NULL)
-			return -ENOMEM;
 		if (iocommand->Request.Type.Direction & XFER_WRITE) {
-			/* Copy the data into the buffer we created */
-			if (copy_from_user(buff, iocommand->buf,
-				iocommand->buf_size)) {
-				rc = -EFAULT;
-				goto out_kfree;
-			}
+			buff = memdup_user(iocommand->buf, iocommand->buf_size);
+			if (IS_ERR(buff))
+				return PTR_ERR(buff);
 		} else {
-			memset(buff, 0, iocommand->buf_size);
+			buff = kzalloc(iocommand->buf_size, GFP_KERNEL);
+			if (!buff)
+				return -ENOMEM;
 		}
 	}
 	c = cmd_alloc(h);
@@ -6478,7 +6474,6 @@ static int hpsa_passthru_ioctl(struct ctlr_info *h,
 	}
 out:
 	cmd_free(h, c);
-out_kfree:
 	kfree(buff);
 	return rc;
 }
-- 
2.51.0


