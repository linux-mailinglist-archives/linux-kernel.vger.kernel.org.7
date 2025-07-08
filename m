Return-Path: <linux-kernel+bounces-720893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520AAFC1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945B34A4597
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609921ADC5;
	Tue,  8 Jul 2025 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqbKuWzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761021767D;
	Tue,  8 Jul 2025 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751950196; cv=none; b=VYAtyVpnTVMuvqMFSgzEe4TBaTe0L2bA5Z5NBGeIKVSUUvVy/wJOL03ubEwd3KRiSWkw6Yg51ZoZ7tZnXiHlOxFNPPvyNaWUK7uY/akLLmN7Ex/fKnkpOcQ12gEm8cES7p0x/r9jmI7OmmcZenznodFECWrcf4z5uhvcnM0IsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751950196; c=relaxed/simple;
	bh=9lgdtjlJsTHXMEL0blCsq/7tTtWLs7jUyFt4YWViNtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udRbJ9RW9dtZQ4BBPLQh3HLlo0xS30tsbB6FP2Itzw2/BWa0wQsMBLoMFAp1VlY1hqwRZ2Sf8ySYth0WMroJdvIkHbvxeJERgVtq4LnF7RMFZyqKCBNgUmNOpeYhLO4SFQDlOUXtxWNcM+YPenB/AsC9+UEdM4K649DPE5Mk4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqbKuWzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1A2EC4CEED;
	Tue,  8 Jul 2025 04:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751950195;
	bh=9lgdtjlJsTHXMEL0blCsq/7tTtWLs7jUyFt4YWViNtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dqbKuWzFC41kWPPNTE1SP64nTqdqUJv53241JCBfvN7sedliVAhRu1v5UVcrLqQWs
	 l1J/xh02m55Qh52xOBCErEKsyh+lF3A7+exsNAXGuG2hC4IhMJKCofRBC1p7G0R0c8
	 egLFwjjr6g+FflB44SQYE7QYVxZhWxAkkAPCgfIvjqBd3qZvA2RWHJjppvxRUzOzzi
	 IDvIdvXZ1qr7VhDJ8gsKFU4DB/rjdLl+bdMPqebvX0LGZps7UqJs7sXI2K8nUORYiJ
	 tT3C9IQRaF64fJxnvR3IfseXwzQXk+sa7fbaZoh1Fq+PtumyUcs/YkXb5RR2s2jqeA
	 7UAdjYR8ZWzMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3168C71130;
	Tue,  8 Jul 2025 04:49:55 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Tue, 08 Jul 2025 12:49:06 +0800
Subject: [PATCH RESEND v5 1/5] firmware: stratix10-svc: Add mutex lock and
 unlock in stratix10 memory allocation/free
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-sip_svc_upstream-v5-1-9c4289256d54@altera.com>
References: <20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com>
In-Reply-To: <20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751950193; l=3746;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=QE+KovkU/XowK2W0xahzC8La4au8qJPO8bMmVQGHmLo=;
 b=61oPSdmYsY/8RATt+14R6rcBykTqR8UdMsydWoda4X7BXa25/JrzB/ghi1/GnXjnKt1sQzXhM
 6yKW0XS5Q8LC4DC3HWpgGFFdb6Blyd6y+SmR4WCx9XbKsXONVqLwlbq
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

This commit adds a mutex lock to protect the
stratix10_svc_allocate_memory and
stratix10_svc_free_memory functions to ensure
thread safety when allocating and freeing memory.
This prevents potential race conditions and ensures
synchronization.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/firmware/stratix10-svc.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d71829f0ab22b8a59aa7af0316bea0..73c77b8e9f2b44a6729dd349ef0947ed47be681b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017-2018, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
  */
 
 #include <linux/completion.h>
@@ -171,6 +172,10 @@ struct stratix10_svc_chan {
 
 static LIST_HEAD(svc_ctrl);
 static LIST_HEAD(svc_data_mem);
+/* svc_mem_lock protects access to the svc_data_mem list for
+ * concurrent multi-client operations
+ */
+static DEFINE_MUTEX(svc_mem_lock);
 
 /**
  * svc_pa_to_va() - translate physical address to virtual address
@@ -182,14 +187,18 @@ static LIST_HEAD(svc_data_mem);
 static void *svc_pa_to_va(unsigned long addr)
 {
 	struct stratix10_svc_data_mem *pmem;
+	void *ret = NULL;
 
 	pr_debug("claim back P-addr=0x%016x\n", (unsigned int)addr);
+	mutex_lock(&svc_mem_lock);
 	list_for_each_entry(pmem, &svc_data_mem, node)
-		if (pmem->paddr == addr)
-			return pmem->vaddr;
-
-	/* physical address is not found */
-	return NULL;
+		if (pmem->paddr == addr) {
+			/* physical address is found */
+			ret = pmem->vaddr;
+			break;
+		}
+	mutex_unlock(&svc_mem_lock);
+	return ret;
 }
 
 /**
@@ -990,6 +999,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			p_data->flag = ct->flags;
 		}
 	} else {
+		mutex_lock(&svc_mem_lock);
 		list_for_each_entry(p_mem, &svc_data_mem, node)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
@@ -1006,6 +1016,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 					break;
 				}
 		}
+		mutex_unlock(&svc_mem_lock);
 	}
 
 	p_data->command = p_msg->command;
@@ -1072,9 +1083,12 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_lock(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
-	if (!va)
+	if (!va) {
+		mutex_unlock(&svc_mem_lock);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset((void *)va, 0, s);
 	pa = gen_pool_virt_to_phys(genpool, va);
@@ -1086,6 +1100,7 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	pr_debug("%s: va=%p, pa=0x%016x\n", __func__,
 		 pmem->vaddr, (unsigned int)pmem->paddr);
 
+	mutex_unlock(&svc_mem_lock);
 	return (void *)va;
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
@@ -1100,6 +1115,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+	mutex_lock(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {
@@ -1107,9 +1123,10 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 				       (unsigned long)kaddr, pmem->size);
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
+			mutex_unlock(&svc_mem_lock);
 			return;
 		}
-
+	mutex_unlock(&svc_mem_lock);
 	list_del(&svc_data_mem);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);

-- 
2.35.3



