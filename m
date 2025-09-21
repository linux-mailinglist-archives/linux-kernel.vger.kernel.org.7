Return-Path: <linux-kernel+bounces-826456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F2B8E937
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A5E189B9EC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A182D97AC;
	Sun, 21 Sep 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNdDc4aW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8284226863
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494932; cv=none; b=MZwX6g95U71cXPGjm2vIJJ+qjgIc7JvHpOUJ9QR4Pm7fCZP9KfzmbMvv44cb9ul6Lx8/D6vc2GuTgpwOIPmoS16Vmvn50e0q4DNHuz8i0VaQZ4ckNZ7zXIFqXJ39rNY7ncTrwtulGtcV8F5KgE7s9Np5x/anrAthPftOeD4odjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494932; c=relaxed/simple;
	bh=0e9YXXcVmoNX4ypjLvaFo66muk6wMOodjuWTW6xgsg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvBQYO2ru6d0RmELBvEy074j/svDFsSYpiVHBkPE1PHijveycl2bNaZPPNGCMPKytqoyOoPfT+83kL3I+r4CW5chvi19ZMMFr2Tx6trEWBqczrBLIOPBf4eFa+Ppmk6yNv5pD/hsMfnrodQ/yRlzN2baCxSR2zXN0lm6mBcnJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNdDc4aW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494931; x=1790030931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0e9YXXcVmoNX4ypjLvaFo66muk6wMOodjuWTW6xgsg0=;
  b=nNdDc4aWkuunEKlBMCcreBmJ272Up93DH8Bomf0U31QyA87OG2uo5GMR
   ZKZk2/tRr+jZ+IUrZ7vWfzXE/NtIFB3h8AMFhz0EHQMZQANOIJsUHMDiV
   Aznq84rsyYDsbtPNLJLU8MOZgSMHdScvxSql1/Z61pY3np6QztoRdVT3x
   E6/LQlNOCxqAT8wTH2k7RFJfeGFD/m7t0iTm2sX65oMPox0sJ3vwyd1/z
   dP5JNz84a7YxKfXTra8hoBO8unjF3al1tA4z+s6x3/N3eozR/zNGXMKrs
   WbI2S+zU2QQZBweEtHhjo8JpGwgsdiTYhAavMJKqkNkh9a0QHEp7TLsOG
   w==;
X-CSE-ConnectionGUID: soxHXY1iSfWLm4kIZ63B+Q==
X-CSE-MsgGUID: w5txOVbpQ/qNQV0aq3w91A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562362"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562362"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:50 -0700
X-CSE-ConnectionGUID: RNMXBNyWQc+IBLqRxjE5hg==
X-CSE-MsgGUID: +xZn6RfHRa6Qlo24yaFeFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129805"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:49 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	tony.luck@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v6 5/7] x86/microcode/intel: Implement staging handler
Date: Sun, 21 Sep 2025 15:48:39 -0700
Message-ID: <20250921224841.3545-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921224841.3545-1-chang.seok.bae@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
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

  (d)  The offset may indicate completion or request retransmission of an
       already transferred chunk. As long as the total transferred data
       remains within the predefined limit (twice the image size),
       retransmissions should be acceptable.

Incorporate them in the handler, while data transmission and mailbox
format handling are implemented separately.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
V5 -> V6:
* Remove a single-line helper and fold it (Boris)
* Fix the header file ordering (Boris)
* Fix typo in comment (Boris)
* Adjust code to return a unique error code: ETIMEDOUT => EMSGSIZE
* Trim the changelog.
* Collect Tony's review tag

V4 -> V5:
* Convert helper functions to return error codes (Dave)
* Consolidate loop-control logic
* Refactor next-chunk calculation/check for clarity
* Remove offset sanity check (moved to next patch)

V2 -> V3:
* Rework code to eliminate global variables (Dave)
* Remove redundant variable resets (Chao)

V1 -> V2:
* Re-write the changelog for clarity (Dave).
* Move staging handling code into intel.c (Boris).
* Add extensive comments to clarify staging logic and hardware
  interactions, along with function renaming (Dave).
---
 arch/x86/kernel/cpu/microcode/intel.c | 123 +++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index b9f6bfbc7fea..d3e15f23d53a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -12,9 +12,11 @@
  */
 #define pr_fmt(fmt) "microcode: " fmt
 #include <linux/earlycpio.h>
+#include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
 #include <linux/initrd.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
@@ -33,6 +35,15 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 #define UCODE_BSP_LOADED	((struct microcode_intel *)0x1UL)
 
+/* Defines for the microcode staging mailbox interface */
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
@@ -317,13 +328,119 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 }
 
 /*
- * Handle the staging process using the mailbox MMIO interface.
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
+ * Update the chunk size and decide whether another chunk can be sent.
+ * This accounts for remaining data and retry limits.
+ */
+static bool can_send_next_chunk(struct staging_state *ss, int *err)
+{
+	/* A page size or remaining bytes if this is the final chunk */
+	ss->chunk_size = min(PAGE_SIZE, ss->ucode_len - ss->offset);
+
+	/*
+	 * Each microcode image is divided into chunks, each at most
+	 * one page size. A 10-chunk image would typically require 10
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
+	 * If the number of attempts exceeds this limit, treat it as
+	 * exceeding the maximum allowed transfer size.
+	 */
+	if (ss->bytes_sent + ss->chunk_size > ss->ucode_len * 2) {
+		*err = -EMSGSIZE;
+		return false;
+	}
+
+	*err = 0;
+	return true;
+}
+
+/*
+ * Determine whether staging is complete: either the hardware signaled
+ * the end offset, or no more transactions are permitted (retry limit
+ * reached).
+ */
+static inline bool staging_is_complete(struct staging_state *ss, int *err)
+{
+	return (ss->offset == UINT_MAX) || !can_send_next_chunk(ss, err);
+}
+
+/*
+ * Transmit a chunk of the microcode image to the hardware.
+ * Return 0 on success, or an error code on failure.
+ */
+static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe_unused)
+{
+	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
+	return -EPROTONOSUPPORT;
+}
+
+/*
+ * Retrieve the next offset from the hardware response.
+ * Return 0 on success, or an error code on failure.
+ */
+static int fetch_next_offset(struct staging_state *ss)
+{
+	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n");
+	return -EPROTONOSUPPORT;
+}
+
+/*
+ * Handle the staging process using the mailbox MMIO interface. The
+ * microcode image is transferred in chunks until completion.
  * Return 0 on success or an error code on failure.
  */
 static int do_stage(u64 mmio_pa)
 {
-	pr_debug_once("Staging implementation is pending.\n");
-	return -EPROTONOSUPPORT;
+	struct staging_state ss = {};
+	int err;
+
+	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!ss.mmio_base))
+		return -EADDRNOTAVAIL;
+
+	init_stage(&ss);
+
+	/* Perform the staging process while within the retry limit */
+	while (!staging_is_complete(&ss, &err)) {
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
+	return err;
 }
 
 static void stage_microcode(void)
-- 
2.48.1


