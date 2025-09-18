Return-Path: <linux-kernel+bounces-767270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A55B25223
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803355A81DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5628D827;
	Wed, 13 Aug 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnklfIXu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E9E28D8ED
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106037; cv=none; b=ArlaWiqCweTwMZ4VQHLxmyW1iIV2f05D5CqPSFCyBxGsVQN/uyiZVliH/KdcSjKXQknfrnSuHfdJbC/5Q42l+c1SSI7K0D28UfMZjwaJDR1ZgrYVuzwEI5xKvwob7doStlFGZZOLPjYGd+xKzXdlnnTEUQiSJAzNLw7ovqcihsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106037; c=relaxed/simple;
	bh=+2PlyR2Mfu2HfSnv645I17k79gyNKv3yi1r6lbBvNsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmEsWsrD5Q9cMudq5l7AR4NUhJ5fBbc8qiMA5y0QVnbBEmS53dulJTtdXPnaqlFD56JnjEA6b9T4nkExwvm6UBdHmXlHkVRyOp7UnySNTqehzs6VV/IOGxwQedlAWiKylcNRgBPeNpwGneX8pUQQIjUX4hte2s62dIWyuNbCLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnklfIXu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106037; x=1786642037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2PlyR2Mfu2HfSnv645I17k79gyNKv3yi1r6lbBvNsk=;
  b=XnklfIXuqYnIFzRvvZY4gRX4p6t/vQ2gC9QSNLR5LAnZEv5uwdaUSQgb
   yto2WvRP2H4ZDDXNdpbMarbhrQrQxRpeuf3kl8wMagw89Yuei2zZG1Vqk
   gXpWgkuPdQ7gNKToQiqBEXB1k8OQ7TcsEY11SXYtKwMAn0HyJMVVq3NJR
   7j6Y92unod/bx63HWqTrTsQxZKVVWEJ7Z3D2Lo1NUrv+SGD8m4xefRUd+
   /AM0ihPQ+z12/kHIyCo55CU5v/ayDNeljBZw4j3ntDWVXB5cHHp7+LNUf
   wNBsls89K6j7nwoqMYQMCmguSoh2INFZGEhsMWIn+6ZkD5PsIAXx1gVkd
   w==;
X-CSE-ConnectionGUID: jYJ+4dyvQuaeNRcBi0JNjg==
X-CSE-MsgGUID: yRorfvVNTe28Wr0wf6rQaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255252"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255252"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:27:16 -0700
X-CSE-ConnectionGUID: DvozPFRZRlG1SmR3MFnCiQ==
X-CSE-MsgGUID: bEi/Ndb0SPqqGCqtj4V0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329716"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:27:15 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] x86/microcode/intel: Support mailbox transfer
Date: Wed, 13 Aug 2025 10:26:48 -0700
Message-ID: <20250813172649.15474-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813172649.15474-1-chang.seok.bae@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
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

Note: The kernel has support for similar mailboxes. But none of them are
compatible with this one. Trying to share code resulted in a bloated
mess, so this code is standalone.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
V2 -> V3:
* Update code to reflect the removal of a global variable (Dave).

V1 -> V2:
* Add lots of code comments and edit the changelog (Dave).
* Encapsulate register read/write operations for processing header and
  data sections.
---
 arch/x86/kernel/cpu/microcode/intel.c | 150 ++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 3eb3331c5012..5402bcb96f47 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pci_ids.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
@@ -42,8 +43,30 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
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
+#define DWORD_ALIGN(size)	((size) / sizeof(u32))
+#define MBOX_HEADER(mbox_size)	(PCI_VENDOR_ID_INTEL | \
+				 (MBOX_OBJ_STAGING << 16) | \
+				 ((u64)DWORD_ALIGN(mbox_size) << 32))
+
+/* The size of each mailbox header */
+#define MBOX_HEADER_SIZE	sizeof(u64)
+/* The size of staging hardware response */
+#define MBOX_RESPONSE_SIZE	sizeof(u64)
 
 /*
  * Each microcode image is divided into chunks, each at most
@@ -57,6 +80,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
  */
 #define MBOX_XACTION_SIZE	PAGE_SIZE
 #define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
+#define MBOX_XACTION_TIMEOUT_MS	(10 * MSEC_PER_SEC)
 
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
@@ -345,6 +369,49 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
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
+static void write_mbox_data(void __iomem *mmio_base, u32 *chunk, unsigned int chunk_size)
+{
+	int i;
+
+	/*
+	 * The MMIO space is mapped as Uncached (UC). Each write arrives
+	 * at the device as an individual transaction in program order.
+	 * The device can then resemble the sequence accordingly.
+	 */
+	for (i = 0; i < DWORD_ALIGN(chunk_size); i++)
+		write_mbox_dword(mmio_base, chunk[i]);
+}
+
 /*
  * Prepare for a new microcode transfer by resetting hardware and
  * configuring microcode image info.
@@ -388,15 +455,71 @@ static bool can_send_next_chunk(struct staging_state *ss)
 	return true;
 }
 
+/*
+ * Wait for the hardware to complete a transaction.
+ * Return true on success, false on failure.
+ */
+static bool wait_for_transaction(struct staging_state *ss)
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
+	status = readl(ss->mmio_base + MBOX_STATUS_OFFSET);
+
+	/* Check for explicit error response */
+	if (status & MASK_MBOX_STATUS_ERROR) {
+		ss->state = UCODE_ERROR;
+		return false;
+	}
+
+	/*
+	 * Hardware is neither responded to the action nor
+	 * signaled any error. Treat the case as timeout.
+	 */
+	if (!(status & MASK_MBOX_STATUS_READY)) {
+		ss->state = UCODE_TIMEOUT;
+		return false;
+	}
+
+	ss->state = UCODE_OK;
+	return true;
+}
+
 /*
  * Transmit a chunk of the microcode image to the hardware.
  * Return true if the chunk is processed successfully.
  */
 static bool send_data_chunk(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
-	ss->state = UCODE_ERROR;
-	return false;
+	u16 mbox_size = MBOX_HEADER_SIZE * 2 + ss->chunk_size;
+	u32 *chunk = ss->ucode_ptr + ss->offset;
+
+	/*
+	 * Write 'request' mailbox object in the following order:
+	 * - Mailbox header includes total size
+	 * - Command header specifies the load operation
+	 * - Data section contains a microcode chunk
+	 */
+	write_mbox_header(ss->mmio_base, MBOX_HEADER(mbox_size));
+	write_mbox_header(ss->mmio_base, MBOX_CMD_LOAD);
+	write_mbox_data(ss->mmio_base, chunk, ss->chunk_size);
+	ss->bytes_sent += ss->chunk_size;
+
+	/*
+	 * Notify the hardware that the mailbox is ready for processing.
+	 * The staging hardware will process the request asynchronously.
+	 */
+	writel(MASK_MBOX_CTRL_GO, ss->mmio_base + MBOX_CONTROL_OFFSET);
+	return wait_for_transaction(ss);
 }
 
 /*
@@ -405,9 +528,24 @@ static bool send_data_chunk(struct staging_state *ss)
  */
 static bool fetch_next_offset(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
-	ss->state = UCODE_ERROR;
-	return false;
+	const u16 mbox_size = MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE;
+
+	/* All responses begin with the same header value: */
+	WARN_ON_ONCE(read_mbox_header(ss->mmio_base) != MBOX_HEADER(mbox_size));
+
+	/*
+	 * The 'response' mailbox contains two dword data:
+	 * - First has next offset in microcode image
+	 * - Second delivers status flag
+	 */
+	ss->offset = read_mbox_dword(ss->mmio_base);
+	if (read_mbox_dword(ss->mmio_base) & MASK_MBOX_RESP_ERROR) {
+		ss->state = UCODE_ERROR;
+		return false;
+	}
+
+	ss->state = UCODE_OK;
+	return true;
 }
 
 /*
-- 
2.48.1


