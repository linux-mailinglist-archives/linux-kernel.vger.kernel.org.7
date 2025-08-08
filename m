Return-Path: <linux-kernel+bounces-760378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF23B1EA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFA856006C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360827F732;
	Fri,  8 Aug 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="zG+M9Jbc"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D427F4CA;
	Fri,  8 Aug 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663179; cv=none; b=a86tBYAdJMiVLJqAmEtaj+t4NGZBuSmundvcZiEmI9ZAkA+Ogtzv8pUFuHkzvWse6Pnqa9YvXZD7/g4g+OlGH+2nM98NrJPgSnEv6P+uFibNo4jf7CzmWZlLzU411Ibrid6CiytX53VkJ5EUBJ2WU1gp4Bq2FonufMqE3jVh4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663179; c=relaxed/simple;
	bh=kkyVshGMpGzmbE/aE9WZGKD4p6KWlCXK/H35AsfvTTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuBPJ/lIjsdCqsOg68dXYIqq0Wzc1FsMAwBsSqnSRvnQsoj0MeHTKRcoZf/QrP3Y8LK5GILmeG+vIm5kZIrcB4ydItZVe1WvwhFwfulOI1C6caan+zWeNRD2wrGcTPcqacv+Ot0tEsSXOPHOfZB59mV0JLlrfHAQDdtdk4YQ+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=zG+M9Jbc; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SDL+Rq9GgcTZOkaHUT1vF7UlpxYPz+V5uGuMYiaqC0Y=; b=zG+M9Jbc2l6JzESAb4jdb5Ml1p
	7QssWR18Y0M0aECZPvwOp/1nu2cbStOsJFAs8moKVfmcBeZX/vIBHDTwnYT10YbJmZPcyeMNcERoQ
	25CJpOCQADAsTmzXRtF12LvAFw7/n1cR1Xtqzt4dTZ51bWzIHrV1fW5SHiqd/iD4vAfP5XLD6R2Ul
	PGB9MtwcFYTCyeDSryxvhz8KhjniR4AfJpQcMWkySIPklza0N1rKP6hRvBcimOSLP0TYjmX0Zk6bm
	JkONABMDZ4Nzoj3heEmV7+pnosfa/3fLW/ShsblsBJuyqYQix5NU790Zy8GMe80Zq8BpNEBeIsX6N
	fn3gtEcQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ukO2o-00ADEk-3L; Fri, 08 Aug 2025 15:26:06 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1ukO2n-00000000axb-2E1r;
	Fri, 08 Aug 2025 15:26:05 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC/PATCH] drivers/of: add debug for early dump of the dtb strcutrue
Date: Fri,  8 Aug 2025 15:25:15 +0100
Message-Id: <20250808142515.142058-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

When testing for boot issues, it was helpful to dump the
list of nodes and properties in the device-tree passed into
the kernel.

Add CONFIG_OF_EARLY_DUMP option to dump the list of nodes
and properties to the standard console output early in the
boot sequence. Note, you may need to have some sort of
early or debug console output if there are issues stopping
the kernel starting properly.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/of/Kconfig |  8 ++++++++
 drivers/of/fdt.c   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 50697cc3b07e..ed2c52c54a7d 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -126,4 +126,12 @@ config OF_OVERLAY_KUNIT_TEST
 config OF_NUMA
 	bool
 
+config OF_EARLY_DUMP
+	bool "Dump node list at startup"
+	help
+	  This debug feature runs through all the nodes/properties at startup
+	  to show if the dtb has been passed correctly from the boot stage.
+
+	  If unsure, say N here
+
 endif # OF
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0edd639898a6..ab40db0e71a5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1164,6 +1164,43 @@ static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 	return memblock_alloc_or_panic(size, align);
 }
 
+#ifdef CONFIG_OF_EARLY_DUMP
+static int __init early_init_iterate_nodes(unsigned long node,
+					   const char *uname,
+					   int depth, void *data)
+{
+	void *blob = initial_boot_params;
+	int cur;
+
+	pr_info("node '%s', depth %d\n", uname, depth);
+
+	for (cur = fdt_first_property_offset(blob, node);
+	     cur >= 0;
+	     cur = fdt_next_property_offset(blob, cur)) {
+		const char *pname;
+		const __be32 *val;
+		u32 sz;
+
+		val = fdt_getprop_by_offset(blob, cur, &pname, &sz);
+		if (!val) {
+			pr_warn("Cannot locate property at 0x%x\n", cur);
+			continue;
+		}
+
+		pr_info("node %s: property %s\n", uname, pname ? pname : "unnamed");
+	}
+
+	return 0;
+}
+
+static inline void early_init_dump_dt(void)
+{
+	of_scan_flat_dt(early_init_iterate_nodes, NULL);
+}
+#else
+static inline void early_init_dump_dt(void) { }
+#endif /* CONFIG_OF_EARLY_DUMP */
+
 bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
 {
 	if (!dt_virt)
@@ -1178,6 +1215,8 @@ bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
 	initial_boot_params_pa = dt_phys;
 	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
 				fdt_totalsize(initial_boot_params));
+	
+	early_init_dump_dt();
 
 	/* Initialize {size,address}-cells info */
 	early_init_dt_scan_root();
-- 
2.37.2.352.g3c44437643


