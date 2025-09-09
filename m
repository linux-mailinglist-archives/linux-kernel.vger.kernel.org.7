Return-Path: <linux-kernel+bounces-808556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BAB50177
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AD93AF7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833E352098;
	Tue,  9 Sep 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Udv5OKaw"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79F350820
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431788; cv=none; b=cWKLh+DyBCUW3sUJbH7sHRq8FwqoNYW8zzSD5AhWgl14Z4eNfoiWbJ6F5jz3yabdXcM2PXdlkh4JcwQL3QHTNeFb63oxJivNA/cEW/JgD6OAsPe8MaqEc+SzaOpybDLa9SAk0qHQmof/gMGxriauNar1E5OnU45pIvefGCcHZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431788; c=relaxed/simple;
	bh=/4ecEdJ+qGjfmy9yImHlAlNmO8QiCe+KsB7GVqxPqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4B6ubM0VvDW4ZPXIzlsp94mbipahnwkucuAlUr2kKZUrwK9Vp4gjdq7DkWJK5Y8pvo+oxxx28wFRgVkWLcNQC59KCV7oDD0Yeos6UTayiWWQbRetQxKbD+BrLOzrIQS4QG9vi5CcitW1Gz/bVaWINphU6ij3mEILmCHeUNiXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Udv5OKaw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757431781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GN4o6Rpepn1nYUO5av96IxMhD2q/WJpyOYfgvLYpNxI=;
	b=Udv5OKaw3H1Wbm9wnqhs6hsaaB4FFGvv0GWuqvefXkF1nOTkR0jyeJtv8NWMolxJX7xK/D
	xToMU4p/lWBTyT0qIhREvJqXWPzRQvj670Q7r2MX3QJdu8EVrnwB8dvtfE8C8pKG8jBCZx
	H6FN5vTfx6v7leBgWu4xiNB4bHCJoMs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hpsa: Replace kmalloc + copy_from_user with memdup_user
Date: Tue,  9 Sep 2025 17:27:33 +0200
Message-ID: <20250909152732.760975-3-thorsten.blum@linux.dev>
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


