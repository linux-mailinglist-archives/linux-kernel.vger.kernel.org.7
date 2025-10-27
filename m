Return-Path: <linux-kernel+bounces-871895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D51C0EC32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0C2D4FAE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D23093D8;
	Mon, 27 Oct 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLf/iieQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD712C235A;
	Mon, 27 Oct 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576957; cv=none; b=p45F/ZRBwQKLcVMWbI48WCbVVVIp/1jAcV6zRNGjRCPR7bpqcJScdMhIvPE/PRApwMcO3HBI/uQVfEd53X5s4avjqMXUPwVL9glf1+sWocvdt0x3PbGv/rrvt5OkG6fL/mWvSZaqNzP/m8G1j6kI2Uu2q8zu4ekU6hzgMHnDTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576957; c=relaxed/simple;
	bh=630iEkx+YNPZ4//7+pyREH3IJH/Xcs2Vt1WdwrNDa48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CdePA/yETdp05aTvIaIHsvZFT/+/GbYbXVNKHPB6hEj0NhMBoYd7cOx0bSa3IPflEh5/rWT1irTkVEGrnSMHmOUcDcrqx9oLn83nzxtbtwXN4dxCDFnJaRtap2B78VBNmpHd+kIYRcEw3liDCJci2uh3wzX2HDZ1Y5Vya3lAoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLf/iieQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EE3AC4AF0D;
	Mon, 27 Oct 2025 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576957;
	bh=630iEkx+YNPZ4//7+pyREH3IJH/Xcs2Vt1WdwrNDa48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SLf/iieQa14Vwm91zPmbOWMMaOIKdUMgSiNNkJj89s3n+LtlJRJFt4lkP00+wv+oL
	 qqhx8hLl0JfZT+geudIS8DP0Q+rtLYK5T+X+QAR2arzaGHn6VJ3oqYFgLWMrqpGHW7
	 HfGVzszEyLH6gnRX0GEIRi0VRLmpLAFXe4UNJ1cjYtdUwNBpfdqPBtoplmSvBSOrZv
	 Cs9w6/jWBqXsmJ0h6fO9U0icMpG52fvF7HxxUhH5sG+tZzEHr13gkId9HVtoVGbsJF
	 0dAIb04FYsX9XUOUZwvsJhFzevChOasQlak6hRBlOuSC2y9+UZZ9MCP1Jg1WZRkG6g
	 7a3Zl9zGlDWIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E5CCF9E5;
	Mon, 27 Oct 2025 14:55:57 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Date: Mon, 27 Oct 2025 22:54:40 +0800
Subject: [PATCH v7 1/4] firmware: stratix10-svc: Add mutex in stratix10
 memory management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-sip_svc_upstream-v7-1-6e9ab26d7480@altera.com>
References: <20251027-sip_svc_upstream-v7-0-6e9ab26d7480@altera.com>
In-Reply-To: <20251027-sip_svc_upstream-v7-0-6e9ab26d7480@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>, 
 Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761576953; l=2638;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=0fTSklXVsq/tvEDKt4nwGZPVgU/SjDg904S5A3vTUzI=;
 b=ecuWGXs43wXI+9Bh2xWvfRJUM+kPx/zUXNvychsYFnvV49ueaoXO8Cdpq94DPlRhLoToRY96t
 sGF43Tpcz7sCqsMiy1b9DZaDxw8zteSJkjYposllXmr5fq8+ndhBbqb
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
index 5a32c1054bee1d05809bbe828880ce4f30534c96..9372a17d89b7ceccee5e6efa23303175caddd038 100644
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
@@ -1002,6 +1010,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			p_data->flag = ct->flags;
 		}
 	} else {
+		guard(mutex)(&svc_mem_lock);
 		list_for_each_entry(p_mem, &svc_data_mem, node)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
@@ -1084,6 +1093,7 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
+	guard(mutex)(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
 	if (!va)
 		return ERR_PTR(-ENOMEM);
@@ -1112,6 +1122,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {

-- 
2.43.7



