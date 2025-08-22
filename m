Return-Path: <linux-kernel+bounces-782769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95269B3251E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C011C28A07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B82E3B00;
	Fri, 22 Aug 2025 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkU+Yl0d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC332D4B73
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902400; cv=none; b=V/4eQ6bDY0gmJ0fV+yjCZIaZ12cr0oO5InEVMrROlJRPOQRDEoUNJHEgpLBnKODR8nuO+jeTODat4GcTL44M2gAiQbw4vyBGKOFPWT0kZEWwZDMVGZONJ0wvtVqX8+prvDANStEHDnrGN0PTpLND6IRulKKmTRl5Cc6srQ4O8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902400; c=relaxed/simple;
	bh=WxDs6gQETaQLVITWmh0MKpxl4EzcKAc61KJOBP7owN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHkTz4m/isxgmOzjxoXwQd0dkTXKgUfRSYPC7CxdSM/+yHr3wKc5oq2ClgQDgDvItitx1OcneiInir9GVaZkgjutLLCVKYIymSPCbWJRtUIlnDBjGxldpHdV+KKPPz/WxFkyG/rq4uAAFZUyxiCzh03DpM5xcwqLshp1m1nCVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkU+Yl0d; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902399; x=1787438399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxDs6gQETaQLVITWmh0MKpxl4EzcKAc61KJOBP7owN8=;
  b=NkU+Yl0d0CxrG3GKj7/4BcZ7v4iv1+XaenuPeeNwh+6F3wNjBnbsaDxX
   51FX0mOeCOScudUOVTCuQaOfG/G/Q0C5dxYyrIB9rDAOkfg5/p5xhoo20
   GUxsTrekrjNJ1kIieAAI0LdWMbQupvmfCSfB7DMhxwavtAbGvGIydhBtg
   M5biVcqGb0OOcjBN7cAKkiBCniK3hfC+Fo7g4/Le7gRkBgzZEV/6mKt2A
   QY0Blgl+BbS+aXGcSxmhfj3le8IS1FKfYlGymJQhGXzONSYmKRyLq+OWM
   6axdq7H3nhJv5IdiTUxvZ1DQ8WaPnjTQuhAFVw4G2PE96eSUXNDxbNAdn
   A==;
X-CSE-ConnectionGUID: TmR/FbgXS8STL8PxyiLDzQ==
X-CSE-MsgGUID: a3ybmSXVSmCQp0BcEMmD4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75800191"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75800191"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:39:59 -0700
X-CSE-ConnectionGUID: n85ZGW2iQgCumlJIFcstpg==
X-CSE-MsgGUID: B1VJNIeHQAOlToY5TdRmwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168716302"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by orviesa007.jf.intel.com with ESMTP; 22 Aug 2025 15:39:57 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4a 4/6] x86/microcode/intel: Implement staging handler
Date: Fri, 22 Aug 2025 15:39:56 -0700
Message-ID: <20250822223956.12540-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <002f259d-2f20-4428-add3-a02650bc728b@intel.com>
References: <002f259d-2f20-4428-add3-a02650bc728b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, per-package staging invocations and their associated state
data were established. The next step is to implement the actual staging
handler according to the specified protocol. Below are key aspects to
note:

  (a)  Each staging process must begin by resetting the staging hardware.

  (b)  The staging hardware processes up to a page-sized chunk of the
       microcode image per iteration, requiring software to submit data
       incrementally.

  (c)  Once a data chunk is processed, the hardware responds with an
       offset in the image for the next chunk.

  (d) The offset may indicate completion or request retransmission of an
       already transferred chunk. As long as the total transferred data
       remains within the predefined limit (twice the image size),
       retransmissions should be acceptable.

With that, incorporate these code sequences to the staging handler:

  1.  Initialization: Map the MMIO space via ioremap(). Reset the staging
      hardware and initialize software state, ensuring a fresh staging
      process aligned with (a).

  2.  Processing Loop: Introduce a loop iterating over data chunk,
      following (b), with proper termination conditions established from
      (d) -- stop staging when the hardware signals completion, or if the
      total transmitted data exceeds the predefined limit.

  3.  Loop Body: Finally, compose the loop body with two steps --
      transmitting a data chunk and retrieving the next offset from the
      hardware response, aligning with (b) and (c).

Since data transmission and mailbox format handling require additional
details, they are implemented separately in next changes.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
V4 -> V4a:
* Convert helper functions to return error codes (Dave)
* Consolidate loop-control logic
* Refactor next-chunk calculation/check for clarity
* Remove offset sanity check (moved to next patch)
---
 arch/x86/kernel/cpu/microcode/intel.c | 137 +++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 3ca22457d839..a1b13202330d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -20,6 +20,8 @@
 #include <linux/cpu.h>
 #include <linux/uio.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
@@ -33,6 +35,16 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 #define UCODE_BSP_LOADED	((struct microcode_intel *)0x1UL)
 
+/* Defines for the microcode staging mailbox interface */
+
+#define MBOX_REG_NUM		4
+#define MBOX_REG_SIZE		sizeof(u32)
+
+#define MBOX_CONTROL_OFFSET	0x0
+#define MBOX_STATUS_OFFSET	0x4
+
+#define MASK_MBOX_CTRL_ABORT	BIT(0)
+
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
 static struct microcode_intel *ucode_patch_late __read_mostly;
@@ -319,13 +331,130 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 }
 
 /*
- * Handle the staging process using the mailbox MMIO interface.
- * Return the result state.
+ * Prepare for a new microcode transfer: reset hardware and record the
+ * image size.
+ */
+static void init_stage(struct staging_state *ss)
+{
+	ss->ucode_len = get_totalsize(&ucode_patch_late->hdr);
+
+	/*
+	 * Abort any ongoing process, effectively resetting the device.
+	 * Unlike regular mailbox data processing requests, this
+	 * operation does not require a status check.
+	 */
+	writel(MASK_MBOX_CTRL_ABORT, ss->mmio_base + MBOX_CONTROL_OFFSET);
+}
+
+/*
+ * Return PAGE_SIZE, or remaining bytes if this is the final chunk
+ */
+static inline unsigned int calc_next_chunk_size(unsigned int ucode_len, unsigned int offset)
+{
+	return min(PAGE_SIZE, ucode_len - offset);
+}
+
+/*
+ * Update the chunk size and decide whether another chunk can be sent.
+ * This accounts for remaining data and retry limits.
+ */
+static bool can_send_next_chunk(struct staging_state *ss)
+{
+	ss->chunk_size = calc_next_chunk_size(ss->ucode_len, ss->offset);
+	/*
+	 * Each microcode image is divided into chunks, each at most
+	 * one page size. A 10-chunk  image would typically require 10
+	 * transactions.
+	 *
+	 * However, the hardware managing the mailbox has limited
+	 * resources and may not cache the entire image, potentially
+	 * requesting the same chunk multiple times.
+	 *
+	 * To tolerate this behavior, allow up to twice the expected
+	 * number of transactions (i.e., a 10-chunk image can take up to
+	 * 20 attempts).
+	 *
+	 * If the number of attempts exceeds this limit, the hardware is
+	 * likely stuck and mark the state as timeout.
+	 */
+	if (ss->bytes_sent + ss->chunk_size > ss->ucode_len * 2) {
+		ss->state = UCODE_TIMEOUT;
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Determine whether staging is complete: either the hardware signaled
+ * the end offset, or no more transactions are permitted (retry limit
+ * reached).
+ */
+static inline bool staging_is_complete(struct staging_state *ss)
+{
+	return (ss->offset == UINT_MAX) || !can_send_next_chunk(ss);
+}
+
+/*
+ * Transmit a chunk of the microcode image to the hardware.
+ * Return 0 on success, or an error code on failure.
+ */
+static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe_unused)
+{
+	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
+	ss->state = UCODE_ERROR;
+	return -EPROTONOSUPPORT;
+}
+
+/*
+ * Retrieve the next offset from the hardware response.
+ * Return 0 on success, or an error code on failure.
+ */
+static int fetch_next_offset(struct staging_state *ss)
+{
+	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
+	ss->state = UCODE_ERROR;
+	return -EPROTONOSUPPORT;
+}
+
+/*
+ * Handle the staging process using the mailbox MMIO interface. The
+ * microcode image is transferred in chunks until completion. Return the
+ * result state.
  */
 static enum ucode_state do_stage(u64 mmio_pa)
 {
-	pr_debug_once("Staging implementation is pending.\n");
-	return UCODE_ERROR;
+	struct staging_state ss = {};
+	int err;
+
+	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!ss.mmio_base))
+		return UCODE_ERROR;
+
+	init_stage(&ss);
+
+	/* Perform the staging process while within the retry limit */
+	while (!staging_is_complete(&ss)) {
+		/* Send a chunk of microcode each time: */
+		err = send_data_chunk(&ss, ucode_patch_late);
+		if (err)
+			break;
+		/*
+		 * Then, ask the hardware which piece of the image it
+		 * needs next. The same piece may be sent more than once.
+		 */
+		err = fetch_next_offset(&ss);
+		if (err)
+			break;
+	}
+
+	iounmap(ss.mmio_base);
+
+	/*
+	 * The helpers update ss.state on error. The final state is
+	 * returned to the caller.
+	 */
+	return ss.state;
 }
 
 static void stage_microcode(void)
-- 
2.48.1


