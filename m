Return-Path: <linux-kernel+bounces-824275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A8B888C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563633B2019
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A02F39C3;
	Fri, 19 Sep 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y1BKNLPF"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC32F25EF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274008; cv=none; b=tUfiGGTxfy+fxFqJITLhU6wWAMTyYaiq0PDQhcIyUiXXkgG2hgDEk5tkMI6fTMZa6PnD8EB/t7d0Mgbyl54ftmITZegiuFidsAhHCoqctd520KJvKM9HeTZarmj6dbSAHHBokoYd/SG0EX8gjR5H63M30CDK5faVmULq7gc09fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274008; c=relaxed/simple;
	bh=dKCx85s/6PwtEqwRZtinMLXnxG+yVQJWnrxtNuzd434=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9Z1FjAhBvnJoWBFWbDTBcbZe/A7WAIgkom3kL4ZIbz+c9uwmtGIYkzqiqka5eRSIifqoi5SLu7fFL4/rlh5f45kSK5q0fNvxYjz1lZOTRRerD5RXWArunGefv8WTKK2sSVTJNP3gybSwi+TOusrW6zHJZbdSTElGge5JKDZSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y1BKNLPF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758274003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lHA5A5Q3mB9GbMIkMKtbrVhd8m+plyRqseHgs1TRbeY=;
	b=Y1BKNLPF8QBUOjfsyh8CesFs2DtdZ4NcSYe4o46wSglwMTeH6OYmrpmRTbJzfhbDyj17a4
	REyo+KMhfE7FJjpOHi3vrGyh+UpI3frvlLhri+4enDMz4FIPviMOS5Yw71DboNfksh1Q6f
	miPC5vWjez+XGDlpmBE5zijqtec6zLY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Miller <mikem@beardog.cce.hp.com>,
	James Bottomley <James.Bottomley@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Chiang <achiang@hp.com>,
	"Stephen M. Cameron" <scameron@beardog.cce.hp.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
Date: Fri, 19 Sep 2025 11:26:37 +0200
Message-ID: <20250919092637.721325-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to fix
a memory leak that occurs when copy_from_user(buff[sg_used],,) fails and
the 'cleanup1:' path does not free the memory for 'buff[sg_used]'. Using
memdup_user() avoids this by freeing the memory internally.

Since memdup_user() already allocates memory, use kzalloc() in the else
branch instead of manually zeroing 'buff[sg_used]' using memset(0).

Cc: stable@vger.kernel.org
Fixes: edd163687ea5 ("[SCSI] hpsa: add driver for HP Smart Array controllers.")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/hpsa.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c73a71ac3c29..1c6161d0b85c 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6522,18 +6522,21 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
 	while (left) {
 		sz = (left > ioc->malloc_size) ? ioc->malloc_size : left;
 		buff_size[sg_used] = sz;
-		buff[sg_used] = kmalloc(sz, GFP_KERNEL);
-		if (buff[sg_used] == NULL) {
-			status = -ENOMEM;
-			goto cleanup1;
-		}
+
 		if (ioc->Request.Type.Direction & XFER_WRITE) {
-			if (copy_from_user(buff[sg_used], data_ptr, sz)) {
-				status = -EFAULT;
+			buff[sg_used] = memdup_user(data_ptr, sz);
+			if (IS_ERR(buff[sg_used])) {
+				status = PTR_ERR(buff[sg_used]);
 				goto cleanup1;
 			}
-		} else
-			memset(buff[sg_used], 0, sz);
+		} else {
+			buff[sg_used] = kzalloc(sz, GFP_KERNEL);
+			if (!buff[sg_used]) {
+				status = -ENOMEM;
+				goto cleanup1;
+			}
+		}
+
 		left -= sz;
 		data_ptr += sz;
 		sg_used++;
-- 
2.51.0


