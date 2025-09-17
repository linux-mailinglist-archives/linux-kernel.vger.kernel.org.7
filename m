Return-Path: <linux-kernel+bounces-821107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE64B8062B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42BAD4E1A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91953195F1;
	Wed, 17 Sep 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wULMu29G"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917D2BEC59
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121795; cv=none; b=JfqGFP7i5bPIGJuarjl0M35GkRz4C2hsOFEPlu1w8z5jzPFVnimYR0mQg5PVM1iYruow2mmDCi9qZWi2BHZBSqBqt/VnpxHHAGcC+PbS0BckzMQXYvCjMEtk7QmZ0mIqpUmjfgMYND5dNgYba2yH8tj/3RY5PiQfbVkWfAaXFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121795; c=relaxed/simple;
	bh=kf8VtuEeGuzsqenExd2mZ3cKSBKala/jqEao6XvHsgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAvS4IfeToulxt6TemU19RVbTf5aw8ZA1n3jUKbarNtOwD5oddmZyZA6EoNf9BrM6dIwrkMIT49drr08TwqlwPYZQg98PWcsL1MIlpnTtRA9gEe+Qb6ubrWSppfXf68Q063W+drbAE4C3mBAtYdHXjhVUmUddxK9hEE7jdzPzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wULMu29G; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758121791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/DizY6OliTy4h47FKf45qepZIcbS41tX2/E6LjUYQ0U=;
	b=wULMu29Gp/4PzgbYd8SBr1UsohabphMT0bnkVHT8ZLhLgCupAgYQZSj7Vmn/HN25nfUX43
	Uud64nWg84ioXKUoSDTU+wdNFvL2rB5VLal8wUginWHHW++vYIJdXqSt+jnbOQ5m5uLfIF
	Ex10kCWvBELMdQJIBw7EsC3nEq1R7aE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pds_fwctl: Replace kzalloc + copy_from_user with memdup_user in pdsfc_fw_rpc
Date: Wed, 17 Sep 2025 17:09:41 +0200
Message-ID: <20250917150941.168887-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify pdsfc_fw_rpc().

Return early if an error occurs and remove the obsolete 'err_out' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/fwctl/pds/main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 9b9d1f6b5556..04d84f892fb8 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/bitfield.h>
+#include <linux/string.h>
 
 #include <uapi/fwctl/fwctl.h>
 #include <uapi/fwctl/pds.h>
@@ -366,18 +367,10 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 		return ERR_PTR(err);
 
 	if (rpc->in.len > 0) {
-		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
-		if (!in_payload) {
-			dev_err(dev, "Failed to allocate in_payload\n");
-			err = -ENOMEM;
-			goto err_out;
-		}
-
-		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
-				   rpc->in.len)) {
+		in_payload = memdup_user(u64_to_user_ptr(rpc->in.payload), rpc->in.len);
+		if (IS_ERR(in_payload)) {
 			dev_dbg(dev, "Failed to copy in_payload from user\n");
-			err = -EFAULT;
-			goto err_in_payload;
+			return in_payload;
 		}
 
 		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
@@ -453,7 +446,6 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 				 rpc->in.len, DMA_TO_DEVICE);
 err_in_payload:
 	kfree(in_payload);
-err_out:
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.51.0


