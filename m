Return-Path: <linux-kernel+bounces-890680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A7C40A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684771883CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03232E156;
	Fri,  7 Nov 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDWntB76"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BE32D7E0;
	Fri,  7 Nov 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530380; cv=none; b=nprdfmOx1VmvX2NkL9ec0xv6YIL1YLbCE7FTGlQTwKd6adJiYC/Pe9P0s8dZLs/6IgLlgM1E4s08B27o58PEvGHUAuYhGfOhQi9o/JVEJM8jBLRSutgWExj/bMPl7QOieLGWZrvWR9BUA9jCSJs3EUDKw5n+3/R+slPg+EYanq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530380; c=relaxed/simple;
	bh=hOz9aMEOW6B+di25hxqFYc5gSXWNe9oczqafeIXvjP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ/3XrL8GwBCJ1d7Ge4m2DFmZR2YB62d2hfaBBeKaHtiVq9AduYW8f7Ch/NHY4ASkAct1/5mKP6hUK/iU4scGPE/hxGj3rfahZzYT/KLazOsIqBvtiGEDmNuA+49/+IXXiuE03MHJBHohAVfSMeCMa+MAyBP2lEDikg9CfVO40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDWntB76; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762530377; x=1794066377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOz9aMEOW6B+di25hxqFYc5gSXWNe9oczqafeIXvjP8=;
  b=TDWntB76tUplsbn5YH1uauz4LvWrmd5YxRyGdG8pYheaM4QN/TdcmMSZ
   EXzevchxWVEuQuXQFR1AX6C2JjuxkIkrC7TBSUCBKtxyX13QwjROlLGRx
   XtPFTztyKyrEoVHGvfMwFwpLYsHOdKtRqGP5ExTXAC0DztB4wvAAxkauV
   FyllTrwSDbQtND8J3di7/DBn4FB/1XMLnZA/h0DHHXw3nmerWegyLkVrw
   rZNkWSEsJw3W1DU95PqWICa6LkHt+bOAqX0WKOJYLgZiXHMNkBkywmAjO
   1D5HxBi3frKr+yFUGFRHxF4lyKKzOVW7e1gMJViRZBzA8+EnwzQZd89vZ
   Q==;
X-CSE-ConnectionGUID: XHJvDpLFQr+AFGP6a5r3Ug==
X-CSE-MsgGUID: 56SvSzOSTcKex/E2lCuz0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68519972"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="68519972"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 07:46:17 -0800
X-CSE-ConnectionGUID: y3Bn7e2QShiptPbwWzALKg==
X-CSE-MsgGUID: 0lU8iujtTFS3nqH07Fv8UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="225324820"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 07:46:15 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: uttkarsh.aggarwal@oss.qualcomm.com
Cc: mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	wesley.cheng@oss.qualcomm.com
Subject: [TESTPATCH] xhci: testpatch add temporary debug to cmd ring handling
Date: Fri,  7 Nov 2025 17:46:03 +0200
Message-ID: <20251107154604.1301374-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5e55d9ba-6b4f-4d92-bb47-04b4a68328d2@linux.intel.com>
References: <5e55d9ba-6b4f-4d92-bb47-04b4a68328d2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print messages with CMDDBG prefix if command ring is cleared
with pending commands, or fails to start due to sw state

TESTPATCH

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c |  5 ++++-
 drivers/usb/host/xhci.c      | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b9e676d37a33..f8029d837428 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -421,8 +421,11 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
 /* Ring the host controller doorbell after placing a command on the ring */
 void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 {
-	if (!(xhci->cmd_ring_state & CMD_RING_STATE_RUNNING))
+	if (!(xhci->cmd_ring_state & CMD_RING_STATE_RUNNING)) {
+		xhci_err(xhci, "%pS Failed to start cmd ring, sw cmd_ring_state %d\n",
+			 __builtin_return_address(0), xhci->cmd_ring_state);
 		return;
+	}
 
 	xhci_dbg(xhci, "// Ding dong!\n");
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d3063f796130..fe157813c136 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -504,6 +504,14 @@ static void xhci_set_cmd_ring_deq(struct xhci_hcd *xhci)
 	dma_addr_t deq_dma;
 	u64 crcr;
 
+	if (!list_empty(&xhci->cmd_list))
+		xhci_err(xhci, "%pS CMDDBG set cmd ring deq pendig commands\n",
+			 __builtin_return_address(0));
+	if (xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue)
+		xhci_err(xhci,"%pS CMDDBG set cmd ring deq: %p and enq %p mismatch\n",
+			 __builtin_return_address(0),
+			 xhci->cmd_ring->dequeue, xhci->cmd_ring->enqueue);
+
 	deq_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg, xhci->cmd_ring->dequeue);
 	deq_dma &= CMD_RING_PTR_MASK;
 
@@ -871,6 +879,14 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 	struct xhci_segment *seg;
 
 	ring = xhci->cmd_ring;
+
+	if (!list_empty(&xhci->cmd_list))
+		xhci_err(xhci, "CMDDBG Clearing command ring with pendig commands\n");
+
+	if (ring->dequeue != ring->enqueue)
+		xhci_err(xhci,"CMDDBG clear cmd ring deq: %p and enq %p mismatch\n",
+			 ring->dequeue, ring->enqueue);
+
 	xhci_for_each_ring_seg(ring->first_seg, seg) {
 		/* erase all TRBs before the link */
 		memset(seg->trbs, 0, sizeof(union xhci_trb) * (TRBS_PER_SEGMENT - 1));
-- 
2.43.0


