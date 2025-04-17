Return-Path: <linux-kernel+bounces-609605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D9A92456
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 19:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136133B20CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9962561BD;
	Thu, 17 Apr 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H5OZ8HQd"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14081245020
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912090; cv=none; b=rwPjQ7/j7t3SwIAaEQQCcPoioLgCDvZg6zVqxrhMKAwL5/WLY82SoM8EEayX7tAu7Q2tGsm2wWY0x68pteaQYTQtlfLTBJFaIzOXHJ0nYBXCRaPReQS3sjhcKEudTMh468VNb0CY2NauP2QIbmcwzUimXzeoeir208sAyIiHe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912090; c=relaxed/simple;
	bh=efZOUVbO12d3BMx+8iRADLOz9htxGmN11Lx4RjDJNwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxlsgeJ1lBdsO6hEF1GnPnZZj3691NQPMr5TbFSkh1NTwii6yOgIUC1B5AQqTU58PM1WWDDKgloRhUH6c8jU0+S05dB9jxoX7ylgEA+aDG1Ly7vLGb1VLysapyxvXiTfVL4gDHxD7unVx8s9BkCKotiDWtCihb0eVAcbWlmKvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H5OZ8HQd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744912075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K0BNXfkJ3Uo96nxmEHcIGgrMK0PvXrRydTdFukEvwao=;
	b=H5OZ8HQdFIHZJDepT9UJuYCI0LhZt5BHzuhrEiZeHlXsI8bwwhoiCgObTwhlWTdsOFWwXD
	UdDhQ5tMWvnG93zGfCYLlEPklQRzcrqXNANarz0CAstv4EDj0nNSuZOP5EGe0otvFQUOsP
	XvjGO86b3a2SIjD4OjQonLwKDe2D7+0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Oleg Nesterov <oleg@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: Fix MAX_REG_OFFSET and remove zero-length struct member
Date: Thu, 17 Apr 2025 19:47:13 +0200
Message-ID: <20250417174712.69292-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unnecessary zero-length struct member '__last' and fix
MAX_REG_OFFSET to point to the last register in 'pt_regs'.

Fixes: 40e084a506eba ("MIPS: Add uprobes support.")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.

Changes in v2:
- Fix MAX_REG_OFFSET as suggested by Maciej (thanks!)
- Link to v1: https://lore.kernel.org/lkml/20250411090032.7844-1-thorsten.blum@linux.dev/
---
 arch/mips/include/asm/ptrace.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 85fa9962266a..23acad11ac8e 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -48,7 +48,6 @@ struct pt_regs {
 	unsigned long long mpl[6];        /* MTM{0-5} */
 	unsigned long long mtp[6];        /* MTP{0-5} */
 #endif
-	unsigned long __last[0];
 } __aligned(8);
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
@@ -65,7 +64,11 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define MAX_REG_OFFSET offsetof(struct pt_regs, mtp[5])
+#else
+#define MAX_REG_OFFSET offsetof(struct pt_regs, cp0_epc)
+#endif
 
 /**
  * regs_get_register() - get register value from its offset
-- 
2.49.0


