Return-Path: <linux-kernel+bounces-765074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99FB22B25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D2C3AF258
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26C2ED155;
	Tue, 12 Aug 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J7Hhq1Md"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7202ED149
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009858; cv=none; b=pULjUet4doDeB4yZFQcU+WBQNTYCqwfM/4B08E7fNKKq2RmOmHn5ss6cHvYNyNS79FnBAKaeDCOFWZFdGcVKwyY/faNThVBNojexZ/TIr7T4JcoGYeWmbspETSjDA9Woj0VdebNHKaoqtAGaEprwIdeA5WCnGwbBJRv+zZjQ9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009858; c=relaxed/simple;
	bh=5EwuJcm6AhJtJ8vTEKl3568WYBq/RFLMOdDStPBbwxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMFRZ/L/vAts7X5Hg3rbojh5QXaVhsyeGoBIfLDMflT4N/saJ/jANgC31GR3VGDAxzfqQaT6V53pLiojgYSH20cf8jIcbps3whwCQJ8wEgePcjeJEI4rvnFsD/p9SbuUIPuxsA4BHoBy3w3Rpc/WzLtragoRS5uAWKLKsvc19WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J7Hhq1Md; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755009852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTqnhR6tyqtUkbvKNDEAKenG6XgSBtu4zIxOIgfHtBM=;
	b=J7Hhq1Md6G8yPtsqGt9XiRxqETYVZcsk7uHewmUWZC4r9c1LyDpLQUstenRItHTdPF0xGD
	7KEfsgkiJpDDUXVxnsyuyeQw9bd2mIRqIRb92a4KcG3gU16eLG9LjbC+9saU/5mJRmi3nR
	xHHnF7n9DuQabUqhRzigciWnZc556gA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: realtek_cr: Simplify rts51x_bulk_transport()
Date: Tue, 12 Aug 2025 16:43:58 +0200
Message-ID: <20250812144358.122154-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Change the function parameter 'buf_len' from 'int' to 'unsigned int' and
only update the local variable 'residue' if needed.

Update the rts51x_read_status() function signature accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/storage/realtek_cr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 7dea28c2b8ee..8a4d7c0f2662 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -199,7 +199,8 @@ static const struct us_unusual_dev realtek_cr_unusual_dev_list[] = {
 #undef UNUSUAL_DEV
 
 static int rts51x_bulk_transport(struct us_data *us, u8 lun,
-				 u8 *cmd, int cmd_len, u8 *buf, int buf_len,
+				 u8 *cmd, int cmd_len, u8 *buf,
+				 unsigned int buf_len,
 				 enum dma_data_direction dir, int *act_len)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *)us->iobuf;
@@ -260,8 +261,8 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 	 * try to compute the actual residue, based on how much data
 	 * was really transferred and what the device tells us
 	 */
-	if (residue)
-		residue = residue < buf_len ? residue : buf_len;
+	if (residue > buf_len)
+		residue = buf_len;
 
 	if (act_len)
 		*act_len = buf_len - residue;
@@ -417,7 +418,7 @@ static int rts51x_write_mem(struct us_data *us, u16 addr, u8 *data, u16 len)
 }
 
 static int rts51x_read_status(struct us_data *us,
-			      u8 lun, u8 *status, int len, int *actlen)
+			      u8 lun, u8 *status, unsigned int len, int *actlen)
 {
 	int retval;
 	u8 cmnd[12] = { 0 };
-- 
2.50.1


