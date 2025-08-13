Return-Path: <linux-kernel+bounces-767269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F01B25222
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78AF3B91F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62B291889;
	Wed, 13 Aug 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJYi9qUK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19728C5D9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106036; cv=none; b=miMS3nY1qjntPg77uku2+53HgN6git3PwubTZBR0FZFS6wTt0vEUFgZc/0RTrmXeekimel3ecy9dbyN/xbkYegX6HN6R1qf2VzhSVuZgBY7AMk998fbhT81Lwq8Rb/S88pMZTWCF+FkGdCfJ8Fb3OsQKt9tAZcO/kGGFT8ffoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106036; c=relaxed/simple;
	bh=ZrZJtVEmXZ9Mr8fQMBIZygqxXvpJUmoC9YWZOeHW0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUmYKbcdIr73wGhcQWBZ5nwjRLTL3XMBNLFhAhGv4ITe88+Oq9y9+wrAso6MWzjH+SPuu43pMZbmFrnMJMOqaXbHyoLoBNHYsJw40PPsm1UrZVBiX89aYznc1WGJEXLcSUq7mLezbzx/LhT6fC7aJem8Fcm51K7NoUIf7pvqRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJYi9qUK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106035; x=1786642035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZrZJtVEmXZ9Mr8fQMBIZygqxXvpJUmoC9YWZOeHW0Qs=;
  b=LJYi9qUKqTXEU8yTUiuGJRKGIvK/AMHwfsxcYLfqszecdJtTkqN/ObbF
   QOLECX2aXNVjTpyJpjbxOJDYJKhnFPfo8gurwtFyPjozC08uJfGo56Uo7
   UkR2MKFATrXqwxGDR0wElMnhH++uKzB7bq2XuvDZHv8Q4YeVXLbSlqsLn
   RzEv6LC3wogMgPYKG0Zl6jCPmsg4oT4XqXVgQIHAffCf0bdcdES1fKNRj
   so8BqjdwND6vSgTsfBXb8Ey6NPfEX31m3Nzh9mtRYScXcDR/Q1VYXW/by
   AXodwL+C8zNYOYsPCakTtDo9psC+ld68rLFx4pGC+O2OdiiwCWITJH4l5
   Q==;
X-CSE-ConnectionGUID: yoID1EYIQvm0Z3qZ02+J3Q==
X-CSE-MsgGUID: vRqGdS8TRm2/uW7o9yYORQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255238"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255238"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:27:15 -0700
X-CSE-ConnectionGUID: WmRKfmfPTBm4d17DnxJiYg==
X-CSE-MsgGUID: 0ajkj4qvSZ+Mcl5CP3TZ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329712"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:27:14 -0700
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
Subject: [PATCH v4 4/6] x86/microcode/intel: Implement staging handler
Date: Wed, 13 Aug 2025 10:26:47 -0700
Message-ID: <20250813172649.15474-5-chang.seok.bae@intel.com>
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
V2 -> V3:
* Rework code to eliminate global variables (Dave)
* Remove redundant variable resets (Chao)

V1 -> V2:
* Re-write the changelog for clarity (Dave).
* Move staging handling code into intel.c (Boris).
* Add extensive comments to clarify staging logic and hardware
  interactions, along with function renaming (Dave).
---
 arch/x86/kernel/cpu/microcode/intel.c | 120 +++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 36b426a90844..3eb3331c5012 100644
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
@@ -33,6 +35,29 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
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
+/*
+ * Each microcode image is divided into chunks, each at most
+ * MBOX_XACTION_SIZE in size. A 10-chunk image would typically require
+ * 10 transactions. However, the hardware managing the mailbox has
+ * limited resources and may not cache the entire image, potentially
+ * requesting the same chunk multiple times.
+ *
+ * To accommodate this behavior, allow up to twice the expected number of
+ * transactions (i.e., a 10-chunk image can take up to 20 attempts).
+ */
+#define MBOX_XACTION_SIZE	PAGE_SIZE
+#define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
+
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
 static struct microcode_intel *ucode_patch_late __read_mostly;
@@ -321,13 +346,100 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 }
 
 /*
- * Handle the staging process using the mailbox MMIO interface.
- * Return the result state.
+ * Prepare for a new microcode transfer by resetting hardware and
+ * configuring microcode image info.
+ */
+static void init_stage(struct staging_state *ss)
+{
+	ss->ucode_ptr = ucode_patch_late;
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
+ * Check if the staging process has completed. The hardware signals
+ * completion by setting a unique end offset.
+ */
+static inline bool is_stage_complete(unsigned int offset)
+{
+	return offset == UINT_MAX;
+}
+
+/*
+ * Determine if the next data chunk can be sent. Each chunk is typically
+ * one page unless the remaining data is smaller. If the total
+ * transmitted data exceeds the defined limit, a timeout occurs.
+ */
+static bool can_send_next_chunk(struct staging_state *ss)
+{
+	WARN_ON_ONCE(ss->ucode_len < ss->offset);
+	ss->chunk_size = min(MBOX_XACTION_SIZE, ss->ucode_len - ss->offset);
+
+	if (ss->bytes_sent + ss->chunk_size > MBOX_XACTION_MAX(ss->ucode_len)) {
+		ss->state = UCODE_TIMEOUT;
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Transmit a chunk of the microcode image to the hardware.
+ * Return true if the chunk is processed successfully.
+ */
+static bool send_data_chunk(struct staging_state *ss)
+{
+	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
+	ss->state = UCODE_ERROR;
+	return false;
+}
+
+/*
+ * Retrieve the next offset from the hardware response.
+ * Return true if the response is valid, false otherwise.
+ */
+static bool fetch_next_offset(struct staging_state *ss)
+{
+	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
+	ss->state = UCODE_ERROR;
+	return false;
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
+
+	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!ss.mmio_base))
+		return UCODE_ERROR;
+
+	init_stage(&ss);
+
+	/* Perform the staging process while within the retry limit */
+	while (!is_stage_complete(ss.offset) && can_send_next_chunk(&ss)) {
+		/* Send a chunk of microcode each time: */
+		if (!send_data_chunk(&ss))
+			break;
+		/*
+		 * Then, ask the hardware which piece of the image it
+		 * needs next. The same piece may be sent more than once.
+		 */
+		if (!fetch_next_offset(&ss))
+			break;
+	}
+
+	iounmap(ss.mmio_base);
+	return ss.state;
 }
 
 static void stage_microcode(void)
-- 
2.48.1


