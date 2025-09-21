Return-Path: <linux-kernel+bounces-826457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27DB8E93A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D1917A591
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F52D9EEF;
	Sun, 21 Sep 2025 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlMUILLs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEB2D73A7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494932; cv=none; b=pdQqgbN8pd8tHqHELTikE6TG6YOKXEqMmEZ/47r+1FPqBgR2wfznzmv/vdd9oQ5F/9FE3DkuNCKH7eIlmjCQZ9RucrJrSm18GXOw60FlNVu5UewarDoJNPEG0DuZJHw0yC3SIvXMIof+u6lgJf91+f7tcJYfXWp0Cg9RbB0Hmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494932; c=relaxed/simple;
	bh=hWrP76qUxvmoIMC97vuCs65TBMc6Jo7iHX/hP81dHFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWkK//jqD8z1w7EsysTmBMytlYlcT2jKnUpbjOVLuLcxUhpeouiMK0yAQwMZFmfh3kzcsUWzGa3ep00pXCEQyV1xrXHyAXn8ZOea+LIrQnoRQnI4fKSa+3AYoZTyfealyy7qo9J4R68elsjPisY+Kph4Qjbx+4VgF711U2xhuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlMUILLs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494932; x=1790030932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWrP76qUxvmoIMC97vuCs65TBMc6Jo7iHX/hP81dHFQ=;
  b=UlMUILLsAdb8XmxAJ9w35v6h3UqZ5R7wNu4+6/qIeZC/nv2gkgXVdSmj
   5CrCJf7hZuclTvANoX9+i0YaePtvIIGZE7tyW353g0bgLZIuBF22VWtSM
   fcp+3L0ydT41bU+s7LjA2IwRtWzVz4zUjrJZrATwS8Oj+A7RWhHxvHSS2
   b+JDVVzgSHMzlI8O7XGn59ut6clqEBCGMkVXWYA+jLZ/CrxcaVXRgG6dJ
   UecZb8DFLwG/R+XVZDSC5yPni7RNgs4lvjqSnwZxd2whZu/3Kf4hDf/Qu
   gIO8xcqoFZGEZRPdfM1ycjVR2A25Pj4wDQHz8X8dPRj9Z6YvvKtRthLas
   A==;
X-CSE-ConnectionGUID: 55rLbPmpSluJxFucdMlBZg==
X-CSE-MsgGUID: iPwn/oi/Sd2EQbh+ugFvdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562369"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:51 -0700
X-CSE-ConnectionGUID: tJCcIs8cSqSXPebkz3hW3A==
X-CSE-MsgGUID: pXxNIv9MRZWdHbQstUh73Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129812"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:50 -0700
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
Subject: [PATCH v6 6/7] x86/microcode/intel: Support mailbox transfer
Date: Sun, 21 Sep 2025 15:48:40 -0700
Message-ID: <20250921224841.3545-7-chang.seok.bae@intel.com>
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

The functions for sending microcode data and retrieving the next offset
were previously placeholders, as they need to handle a specific mailbox
format.

While the kernel supports similar mailboxes, none of them are compatible
with this one. Attempts to share code led to unnecessary complexity, so
add a dedicated implementation instead.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
V5 -> V6:
* Trim the changelog, narrowing down the reason (Boris)
* Polish the error message (Boris)
* Fix the grammar: 'hardware is responded' => 'hardware has responded' (Boris)
* Fix the header file ordering (Boris)
* Fix typo: 'resemble' => 'reassemble' (Boris)
* Adjust code to return a unique error code
* Collect Tony's review tag

V4 -> V5: Addressed Dave's feedback
* fetch_next_offset():
  - Make dword reads explicit
  - Consolidate offset validation -- adding another user for the
    end-offset checker
  - Convert WARN_* with pr_err_once()
* Simplify transaction waiting logic a bit

V2 -> V3:
* Update code to reflect the removal of a global variable (Dave).

V1 -> V2:
* Add lots of code comments and edit the changelog (Dave).
* Encapsulate register read/write operations for processing header and
  data sections.
---
 arch/x86/kernel/cpu/microcode/intel.c | 172 +++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d3e15f23d53a..22b9c3d4f43d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -18,6 +18,7 @@
 #include <linux/initrd.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/pci_ids.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/uio.h>
@@ -41,8 +42,31 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 #define MBOX_CONTROL_OFFSET	0x0
 #define MBOX_STATUS_OFFSET	0x4
+#define MBOX_WRDATA_OFFSET	0x8
+#define MBOX_RDDATA_OFFSET	0xc
 
 #define MASK_MBOX_CTRL_ABORT	BIT(0)
+#define MASK_MBOX_CTRL_GO	BIT(31)
+
+#define MASK_MBOX_STATUS_ERROR	BIT(2)
+#define MASK_MBOX_STATUS_READY	BIT(31)
+
+#define MASK_MBOX_RESP_SUCCESS	BIT(0)
+#define MASK_MBOX_RESP_PROGRESS	BIT(1)
+#define MASK_MBOX_RESP_ERROR	BIT(2)
+
+#define MBOX_CMD_LOAD		0x3
+#define MBOX_OBJ_STAGING	0xb
+#define MBOX_HEADER(size)	((PCI_VENDOR_ID_INTEL)    | \
+				 (MBOX_OBJ_STAGING << 16) | \
+				 ((u64)((size) / sizeof(u32)) << 32))
+
+/* The size of each mailbox header */
+#define MBOX_HEADER_SIZE	sizeof(u64)
+/* The size of staging hardware response */
+#define MBOX_RESPONSE_SIZE	sizeof(u64)
+
+#define MBOX_XACTION_TIMEOUT_MS	(10 * MSEC_PER_SEC)
 
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
@@ -327,6 +351,49 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+static inline u32 read_mbox_dword(void __iomem *mmio_base)
+{
+	u32 dword = readl(mmio_base + MBOX_RDDATA_OFFSET);
+
+	/* Acknowledge read completion to the staging hardware */
+	writel(0, mmio_base + MBOX_RDDATA_OFFSET);
+	return dword;
+}
+
+static inline void write_mbox_dword(void __iomem *mmio_base, u32 dword)
+{
+	writel(dword, mmio_base + MBOX_WRDATA_OFFSET);
+}
+
+static inline u64 read_mbox_header(void __iomem *mmio_base)
+{
+	u32 high, low;
+
+	low  = read_mbox_dword(mmio_base);
+	high = read_mbox_dword(mmio_base);
+
+	return ((u64)high << 32) | low;
+}
+
+static inline void write_mbox_header(void __iomem *mmio_base, u64 value)
+{
+	write_mbox_dword(mmio_base, value);
+	write_mbox_dword(mmio_base, value >> 32);
+}
+
+static void write_mbox_data(void __iomem *mmio_base, u32 *chunk, unsigned int chunk_bytes)
+{
+	int i;
+
+	/*
+	 * The MMIO space is mapped as Uncached (UC). Each write arrives
+	 * at the device as an individual transaction in program order.
+	 * The device can then reassemble the sequence accordingly.
+	 */
+	for (i = 0; i < chunk_bytes / sizeof(u32); i++)
+		write_mbox_dword(mmio_base, chunk[i]);
+}
+
 /*
  * Prepare for a new microcode transfer: reset hardware and record the
  * image size.
@@ -377,6 +444,14 @@ static bool can_send_next_chunk(struct staging_state *ss, int *err)
 	return true;
 }
 
+/*
+ * The hardware indicates completion by returning a sentinel end offset.
+ */
+static inline bool is_end_offset(u32 offset)
+{
+	return offset == UINT_MAX;
+}
+
 /*
  * Determine whether staging is complete: either the hardware signaled
  * the end offset, or no more transactions are permitted (retry limit
@@ -384,17 +459,68 @@ static bool can_send_next_chunk(struct staging_state *ss, int *err)
  */
 static inline bool staging_is_complete(struct staging_state *ss, int *err)
 {
-	return (ss->offset == UINT_MAX) || !can_send_next_chunk(ss, err);
+	return is_end_offset(ss->offset) || !can_send_next_chunk(ss, err);
+}
+
+/*
+ * Wait for the hardware to complete a transaction.
+ * Return 0 on success, or an error code on failure.
+ */
+static int wait_for_transaction(struct staging_state *ss)
+{
+	u32 timeout, status;
+
+	/* Allow time for hardware to complete the operation: */
+	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT_MS; timeout++) {
+		msleep(1);
+
+		status = readl(ss->mmio_base + MBOX_STATUS_OFFSET);
+		/* Break out early if the hardware is ready: */
+		if (status & MASK_MBOX_STATUS_READY)
+			break;
+	}
+
+	/* Check for explicit error response */
+	if (status & MASK_MBOX_STATUS_ERROR)
+		return -EIO;
+
+	/*
+	 * Hardware has neither responded to the action nor signaled any
+	 * error. Treat this as a timeout.
+	 */
+	if (!(status & MASK_MBOX_STATUS_READY))
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
 /*
  * Transmit a chunk of the microcode image to the hardware.
  * Return 0 on success, or an error code on failure.
  */
-static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe_unused)
+static int send_data_chunk(struct staging_state *ss, void *ucode_ptr)
 {
-	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
-	return -EPROTONOSUPPORT;
+	u32 *src_chunk = ucode_ptr + ss->offset;
+	u16 mbox_size;
+
+	/*
+	 * Write a 'request' mailbox object in this order:
+	 *  1. Mailbox header includes total size
+	 *  2. Command header specifies the load operation
+	 *  3. Data section contains a microcode chunk
+	 *
+	 * Thus, the mailbox size is two headers plus the chunk size.
+	 */
+	mbox_size = MBOX_HEADER_SIZE * 2 + ss->chunk_size;
+	write_mbox_header(ss->mmio_base, MBOX_HEADER(mbox_size));
+	write_mbox_header(ss->mmio_base, MBOX_CMD_LOAD);
+	write_mbox_data(ss->mmio_base, src_chunk, ss->chunk_size);
+	ss->bytes_sent += ss->chunk_size;
+
+	/* Notify the hardware that the mailbox is ready for processing. */
+	writel(MASK_MBOX_CTRL_GO, ss->mmio_base + MBOX_CONTROL_OFFSET);
+
+	return wait_for_transaction(ss);
 }
 
 /*
@@ -403,8 +529,42 @@ static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe_unu
  */
 static int fetch_next_offset(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n");
-	return -EPROTONOSUPPORT;
+	const u64 expected_header = MBOX_HEADER(MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE);
+	u32 offset, status;
+	u64 header;
+
+	/*
+	 * The 'response' mailbox returns three fields, in order:
+	 *  1. Header
+	 *  2. Next offset in the microcode image
+	 *  3. Status flags
+	 */
+	header = read_mbox_header(ss->mmio_base);
+	offset = read_mbox_dword(ss->mmio_base);
+	status = read_mbox_dword(ss->mmio_base);
+
+	/* All valid responses must start with the expected header. */
+	if (header != expected_header) {
+		pr_err_once("staging: invalid response header (0x%llx)\n", header);
+		return -EBADR;
+	}
+
+	/*
+	 * Verify the offset: If not at the end marker, it must not
+	 * exceed the microcode image length.
+	 */
+	if (!is_end_offset(offset) && offset > ss->ucode_len) {
+		pr_err_once("staging: invalid offset (%u) past the image end (%u)\n",
+			    offset, ss->ucode_len);
+		return -EINVAL;
+	}
+
+	/* Hardware may report errors explicitly in the status field */
+	if (status & MASK_MBOX_RESP_ERROR)
+		return -EPROTO;
+
+	ss->offset = offset;
+	return 0;
 }
 
 /*
-- 
2.48.1


