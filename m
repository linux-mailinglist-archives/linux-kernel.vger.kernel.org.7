Return-Path: <linux-kernel+bounces-820287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8CB7F111
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9767B66D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0B30C63E;
	Wed, 17 Sep 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="WkXgNAV/"
Received: from sg-1-36.ptr.blmpb.com (sg-1-36.ptr.blmpb.com [118.26.132.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1030BB8C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099193; cv=none; b=aBMV2Y0fTQT8eTCcbPKAavn3QTJsc0mwwxPcnyAkZyBZlBqwWADdMmIaI40qKpToRU/ojfAHUkg8OTQ5Tps9mjZJHHqz9nnAtwzLwh+DdTC9N5eE9jJY4CDZuMT2VQ/T9GGT1ZMAwSp0ChBMI0hZ0sGwnSlZs/1elvAsUWsWdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099193; c=relaxed/simple;
	bh=5D6XPXshtkVYsGDcoT85wx+v/thY03p43cV+BvUTXqE=;
	h=To:Mime-Version:Date:Content-Type:Subject:Message-Id:Cc:From; b=cwO4nkcS0NFlNMd1hKrMq+osw1D+HeXqvooQ7u4MUHyQCSscnAnmst4tD/0ltD8tv+IZDGzqfgER8QnaE7mZ9oXTbLqzwktuhnWG/C0YFMCM5kTJT9i3f5p/WNflXJmBk+RMgj3ElQYmh/pHiGIoK+aU0MwrFtQPEOPKi9zpN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=WkXgNAV/; arc=none smtp.client-ip=118.26.132.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1758099181;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=h7Z/HOQPJW5/DLBofPfWPAnGx2zrqJmmsBycrRC0XrQ=;
 b=WkXgNAV/SA8uP7jnNMyoR3dKk7+6PrGMp/9HHMySUNi4e7gkpZcmuhOqKluuU8k2iSkcpJ
 p9dIJ7+5dUKz0CfO+WTijrdIukMfnq7sVTFtaebrZETwB2T2pBdEMp93gMofYfMfQSLhCU
 EEl946pF3173RHATlpgr8YZD58iqByWkfveVTvX7oYuhYpFC0m2zXzaDWWVEQDr7Fwkgsx
 1KWc8YwwTN3iAjVdVisHiDss9INHsos9tVNYts7dAsj6IlpN3RoJ6crgPek6dJe1R05/yP
 C2BpjqMd9kiM2LvGZ+tV6Lb9/2Pxa049Ii6ePaFxhtymjnYpo5fJ2koUDIj5tQ==
To: <anup@brainfault.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
Date: Wed, 17 Sep 2025 16:52:46 +0800
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
X-Lms-Return-Path: <lba+268ca76eb+72b864+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] riscv: Move user-visible sbi ext ids to uapi
Message-Id: <20250917085246.1430354-1-xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Cc: <kvm-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <atishp@rivosinc.com>, 
	<ajones@ventanamicro.com>, 
	"BillXiang" <xiangwencheng@lanxincomputing.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Received: from Bill.localdomain ([222.128.9.250]) by smtp.feishu.cn with ESMTP; Wed, 17 Sep 2025 16:52:58 +0800

Move those sbi ext ids to uapi because they will be forwarded
to user space by kvm.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 arch/riscv/include/asm/sbi.h      | 16 +-----------
 arch/riscv/include/uapi/asm/sbi.h | 43 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/sbi.h

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..e196feaabb2e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -10,13 +10,12 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/jump_label.h>
+#include <uapi/asm/sbi.h>
 
 #ifdef CONFIG_RISCV_SBI
 enum sbi_ext_id {
 #ifdef CONFIG_RISCV_SBI_V01
 	SBI_EXT_0_1_SET_TIMER = 0x0,
-	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
-	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
 	SBI_EXT_0_1_CLEAR_IPI = 0x3,
 	SBI_EXT_0_1_SEND_IPI = 0x4,
 	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
@@ -37,13 +36,6 @@ enum sbi_ext_id {
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
 
-	/* Experimentals extensions must lie within this range */
-	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
-	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
-
-	/* Vendor extensions must lie within this range */
-	SBI_EXT_VENDOR_START = 0x09000000,
-	SBI_EXT_VENDOR_END = 0x09FFFFFF,
 };
 
 enum sbi_ext_base_fid {
@@ -263,12 +255,6 @@ enum sbi_pmu_ctr_type {
 #define SBI_PMU_STOP_FLAG_RESET BIT(0)
 #define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
 
-enum sbi_ext_dbcn_fid {
-	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
-	SBI_EXT_DBCN_CONSOLE_READ = 1,
-	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
-};
-
 /* SBI STA (steal-time accounting) extension */
 enum sbi_ext_sta_fid {
 	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
diff --git a/arch/riscv/include/uapi/asm/sbi.h b/arch/riscv/include/uapi/asm/sbi.h
new file mode 100644
index 000000000000..d29ac0abeefe
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/sbi.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2025 Lanxincomputing Corporation or its affiliates.
+ *
+ * Authors:
+ *     BillXiang <xiangwencheng@lanxincomputing.com>
+ */
+
+#ifndef _UAPI_ASM_RISCV_SBI_H
+#define _UAPI_ASM_RISCV_SBI_H
+
+
+enum SBI_EXT_ID {
+	/*
+	* The CONSOLE_GETCHAR/CONSOLE_PUTCHAR SBI calls cannot be
+	* handled in kernel so they will be forwarded to userspace by kvm.
+	*/
+	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
+	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
+	/*
+	* Both SBI experimental and vendor extensions are
+	* unconditionally forwarded to userspace by kvm.
+	*/
+	/* Experimentals extensions must lie within this range */
+	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
+	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
+
+	/* Vendor extensions must lie within this range */
+	SBI_EXT_VENDOR_START = 0x09000000,
+	SBI_EXT_VENDOR_END = 0x09FFFFFF,
+};
+
+/*
+* The SBI debug console functions are unconditionally
+* forwarded to the userspace by kvm.
+*/
+enum sbi_ext_dbcn_fid {
+	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
+	SBI_EXT_DBCN_CONSOLE_READ = 1,
+	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
+};
+
+#endif /* _UAPI_ASM_RISCV_SBI_H */
\ No newline at end of file
-- 
2.43.0

