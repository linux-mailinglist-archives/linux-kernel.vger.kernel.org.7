Return-Path: <linux-kernel+bounces-783135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97271B329E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D937B9B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F5D2EA737;
	Sat, 23 Aug 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8yx24Ye"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1E2E9EB6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964346; cv=none; b=M/DFYdfnLQs6If9UrkhRatTbSkHwOzWjKujD/XBKHpdHyhQuMGx0aXIduDbx4HbDb93bgtmwW0cDhVUU5klHSwjem6GVxnkMejnJSHrFsZf7oKvF1A/TWSFNM+t7UybYXUKk5HEdF5qVvVc8wDCdY+wlrBJQscrJJJT3p5ceaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964346; c=relaxed/simple;
	bh=oOCHdwhJ2hlEVHdewE67M/hBZ7Bq05iNcMK6LOevBAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAJieKvhwG2eXsTDP8YnYxUcvfzTqNZ6bLe3d6sD9x+c1Q2NECuGBrpfkts1k5v5d4IdCLaaeaabIuznNh2I6SKBTTAFM8fZuQkhmpCE4MdjuFo27Rtos5el5Nh9MSO4P3IqmZONhqXtPuwJChGj8l32px5MVRoQneH/i8g77WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8yx24Ye; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964345; x=1787500345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOCHdwhJ2hlEVHdewE67M/hBZ7Bq05iNcMK6LOevBAQ=;
  b=D8yx24Yedvjm8daUjlbx+5dnUBNKVh6LNFeUaWJS1HE7u8YdVjqXFA0Z
   ffCWV7kAfdZBVveAWHi85gRbcHOrhbAv4HOwf4Imdx7jwefpQr3sCDjQy
   BSKYQLWvQKgYcXcT3Ih0zGf7R8PN/lFzyWlXK9hsbklwAn6A6r2SOiHB5
   Zi7eAmR5IhyL+ox1G82JBzhObVanNyBhVHMJem0OUdobYXn9uHJ3sQKUw
   adAPCO+WA9HmaOsby/Ombn+P9S8TCEulKX7ap3CZvOANIGR1BNmfX5UlQ
   fhX8dM8oIf9mfAs+FmOAtTzIlGyj69Vlz3pW8WivWRPO/NSRsH6BLFCxZ
   g==;
X-CSE-ConnectionGUID: pQg7VnQFQkm2xC+VOSgEnQ==
X-CSE-MsgGUID: qJkM+pVtQx2nj2RgGc4hLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832825"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832825"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:24 -0700
X-CSE-ConnectionGUID: Nfh+ptDhRTS6vjQ40Cnt9A==
X-CSE-MsgGUID: 5ECjXZgBS0+xtuMJG+900A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748243"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:24 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v5 6/7] x86/microcode/intel: Support mailbox transfer
Date: Sat, 23 Aug 2025 08:52:09 -0700
Message-ID: <20250823155214.17465-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823155214.17465-1-chang.seok.bae@intel.com>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the functions for sending microcode data and retrieving the
next offset were placeholders, as they required handling the specific
mailbox format. Implement them as following:

== Mailbox Format ==

The staging mailbox consists of two primary sections: 'header' and
'data'. While the microcode must be transferred following this format,
the actual data transfer mechanism involves reading and writing to
specific MMIO registers.

== Mailbox Data Registers ==

Unlike conventional interfaces that allocate MMIO space for each data
chunk, the staging interface features a "narrow" interface, using only
two dword-sized registers for read and write operations.

For example, if writing 2 dwords of data to a device. Typically, the
device would expose 2 dwords of "wide" MMIO space. To send the data to
the device:

	writel(buf[0], io_addr + 0);
	writel(buf[1], io_addr + 1);

But, this interface is a bit different. Instead of having a "wide"
interface where there is separate MMIO space for each word in a
transaction, it has a "narrow" interface where several words are written
to the same spot in MMIO space:

	writel(buf[0], io_addr);
	writel(buf[1], io_addr);

The same goes for the read side.

== Implementation Summary ==

Given that, introduce two layers of helper functions at first:

  * Low-level helpers for reading and writing to data registers directly.
  * Wrapper functions for handling mailbox header and data sections.

Using them, implement send_data_chunk() and fetch_next_offset()
functions. Add explicit error and timeout handling routine in
wait_for_transaction(), finishing up the transfer.

Both hardware error states and implicit errors -- invalid header or
offset -- result in UCODE_ERROR. Emit a clear message for the latter.

Note: The kernel has support for similar mailboxes. But none of them are
compatible with this one. Trying to share code resulted in a bloated
mess, so this code is standalone.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
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
 arch/x86/kernel/cpu/microcode/intel.c | 186 +++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a1b13202330d..f6b365eba6a2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pci_ids.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
@@ -42,8 +43,31 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
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
@@ -330,6 +354,49 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
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
+	 * The device can then resemble the sequence accordingly.
+	 */
+	for (i = 0; i < chunk_bytes / sizeof(u32); i++)
+		write_mbox_dword(mmio_base, chunk[i]);
+}
+
 /*
  * Prepare for a new microcode transfer: reset hardware and record the
  * image size.
@@ -385,6 +452,14 @@ static bool can_send_next_chunk(struct staging_state *ss)
 	return true;
 }
 
+/*
+ * The hardware indicates completion by returning a sentinel end offset
+ */
+static inline bool is_end_offset(u32 offset)
+{
+	return offset == UINT_MAX;
+}
+
 /*
  * Determine whether staging is complete: either the hardware signaled
  * the end offset, or no more transactions are permitted (retry limit
@@ -392,18 +467,73 @@ static bool can_send_next_chunk(struct staging_state *ss)
  */
 static inline bool staging_is_complete(struct staging_state *ss)
 {
-	return (ss->offset == UINT_MAX) || !can_send_next_chunk(ss);
+	return is_end_offset(ss->offset) || !can_send_next_chunk(ss);
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
+	if (status & MASK_MBOX_STATUS_ERROR) {
+		ss->state = UCODE_ERROR;
+		return -EPROTO;
+	}
+
+	/*
+	 * Hardware is neither responded to the action nor signaled any
+	 * error. Treat this as timeout.
+	 */
+	if (!(status & MASK_MBOX_STATUS_READY)) {
+		ss->state = UCODE_TIMEOUT;
+		return -ETIMEDOUT;
+	}
+
+	ss->state = UCODE_OK;
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
-	ss->state = UCODE_ERROR;
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
@@ -412,9 +542,51 @@ static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe_unu
  */
 static int fetch_next_offset(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
+	const u64 expected_header = MBOX_HEADER(MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE);
+	u32 offset, status;
+	u64 header;
+	int err;
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
+		pr_err_once("staging: invalid response header\n");
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	/*
+	 * Verify the offset: If not at the end marker, it must not
+	 * exceed the microcode image length
+	 */
+	if (!is_end_offset(offset) && offset > ss->ucode_len) {
+		pr_err_once("staging: invalid response offset\n");
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	/* Hardware may report errors explicitly in the status field */
+	if (status & MASK_MBOX_RESP_ERROR) {
+		err = -EPROTO;
+		goto err_out;
+	}
+
+	ss->offset = offset;
+	ss->state  = UCODE_OK;
+	return 0;
+
+err_out:
 	ss->state = UCODE_ERROR;
-	return -EPROTONOSUPPORT;
+	return err;
 }
 
 /*
-- 
2.48.1


