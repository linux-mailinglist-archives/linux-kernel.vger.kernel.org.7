Return-Path: <linux-kernel+bounces-794622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29154B3E451
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E8FA4E2A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988101E3DE8;
	Mon,  1 Sep 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSP6KokB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4014AD20;
	Mon,  1 Sep 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732418; cv=none; b=fcJuCIHPuvHcAjxbBgH/Exf9r7cvyR4R+ge2pIkpLVpItk/d87gZDWAB2tPx0AA1EofLRacP5B/TYP506Ul2DcGN0x4kzK75fT599ywnCrohE4qk1fFJDO5COiXvY7XHn/NqK4UXTz21LApXKi4SRSgoYzvEadDauuhgRNcZfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732418; c=relaxed/simple;
	bh=vjv0APeeoG1fWjX2XoSPj9yPRXUWX7UbrjgPR60waKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbYIEZ3OXXugJjO4h/kRDKI6SlsXoxAbGWCqMzEo3JU/uJLFTOZaTdSDLVzpOrIqCbn+XIhNVkMEBkYn94CC91V8txyfutriCdoUE/OGPybp9F9lGN+zUH4s2M/FdHzW/ab1z8xQ3PP53Yx66K1sAqQi4SvlMPqVlGu7ofjSXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSP6KokB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CFC8C4CEF9;
	Mon,  1 Sep 2025 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732418;
	bh=vjv0APeeoG1fWjX2XoSPj9yPRXUWX7UbrjgPR60waKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jSP6KokBnC3cqL3aZ95o8l9pnz131mAxW2Dzboh0S4mSeLWlFLExeaZJO3Yc+LGiB
	 0DB5Q+Nu1e4N9fTRQ4gUPMkyEU04KmpwkHgNRhbF/WszGMbHJogkB+8sPTXdH+f8GG
	 zm7hvbSfKe+GxzM//i0KR4U3u+sP4jPcsSgs8Ik1Hcc/QLyfBURAP63mlYkRlUuRKO
	 tFUbbj8Vo2F7aCT/84dqAwNqV1YCuuwctlhCpaMnpphGrJiQBCgiR6R+8T7WCpygo8
	 Bv7/YZk2SF9nhu/bYfnS5O2bJmhhxPkHjV9c1XXLl+SQY4oF1m4iygE52RDxYwjQHe
	 nJpX3RzWDeJNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D350CA0FF0;
	Mon,  1 Sep 2025 13:13:38 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Mon, 01 Sep 2025 21:13:23 +0800
Subject: [PATCH v6 1/4] firmware: stratix10-svc: Add mutex in stratix10
 memory management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-sip_svc_upstream-v6-1-b4db7f07cbb2@altera.com>
References: <20250901-sip_svc_upstream-v6-0-b4db7f07cbb2@altera.com>
In-Reply-To: <20250901-sip_svc_upstream-v6-0-b4db7f07cbb2@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>, 
 Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756732415; l=2636;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=J8C8plJk1PvTp7FsIIIEajn58AqxeR5Do+hcdH7Sil4=;
 b=b1Qj7AInmPcbCE52VzJwvYuTT/kAegbaf+sCJUEMn0C5bybw0x1G8h6FNAGXDjSkvCxY/Y/H2
 UOdnRS/B8hYBYYKGXvLruIWoykC7Wfw51H/Q17OGZw2QjN2bCIalwgT
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

From: Mahesh Rao <mahesh.rao@altera.com>

Add mutex lock to stratix10_svc_allocate_memory and
stratix10_svc_free_memory for thread safety. This prevents race
conditions and ensures proper synchronization during memory operations.
This is required for parallel communication with the Stratix10 service
channel.

Fixes: 7ca5ce896524f ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d71829f0ab22b8a59aa7af0316bea0..11285df8681bfac71c9bace6b7d39c1848f40f08 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017-2018, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
  */
 
 #include <linux/completion.h>
@@ -172,6 +173,12 @@ struct stratix10_svc_chan {
 static LIST_HEAD(svc_ctrl);
 static LIST_HEAD(svc_data_mem);
 
+/**
+ * svc_mem_lock protects access to the svc_data_mem list for
+ * concurrent multi-client operations
+ */
+static DEFINE_MUTEX(svc_mem_lock);
+
 /**
  * svc_pa_to_va() - translate physical address to virtual address
  * @addr: to be translated physical address
@@ -184,6 +191,7 @@ static void *svc_pa_to_va(unsigned long addr)
 	struct stratix10_svc_data_mem *pmem;
 
 	pr_debug("claim back P-addr=0x%016x\n", (unsigned int)addr);
+	guard(mutex)(&svc_mem_lock);
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->paddr == addr)
 			return pmem->vaddr;
@@ -990,6 +998,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			p_data->flag = ct->flags;
 		}
 	} else {
+		guard(mutex)(&svc_mem_lock);
 		list_for_each_entry(p_mem, &svc_data_mem, node)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
@@ -1072,6 +1081,7 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
+	guard(mutex)(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
 	if (!va)
 		return ERR_PTR(-ENOMEM);
@@ -1100,6 +1110,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {

-- 
2.35.3



