Return-Path: <linux-kernel+bounces-729109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED88B031E4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354B53AFB4A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA63280318;
	Sun, 13 Jul 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsaBkIjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1820E27FD5A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422023; cv=none; b=MGzouHtTlRm2GVy9eCODXUvXCrVfpT0UwSC1od6nmXOShGq5EHZBEQze6QOWnAcjp0IGHSgYfbjb9WHLPIMwod4/FiuqQQSuqsUE+bdQtQkVBb8GaKOeA+OgvDVIBEAw+CZtFSf3yEDdcdGQ6yrlzRMmbBlOrkc7I2sGCApxlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422023; c=relaxed/simple;
	bh=Cqc5//1m2maOwm2HqoVNQT8UubcKcYojQ6LRXW5C2TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3Qe3reu5Zwx1TICovq6DeEKM4m62t0kYQlyDvyLNVpya8UeCBB69MEQmPkYjgcIk7tJ7DqsPaIQYM/7aIq6GkCOW+HKhvl0ZEQuXTeilTzfMBlVVQCwjjVnQzd6+ba2EK/0KyuIS1szruEwNfjYLiWYTpTjb+FqvZuhg+gn3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsaBkIjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123D0C4CEF8;
	Sun, 13 Jul 2025 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752422022;
	bh=Cqc5//1m2maOwm2HqoVNQT8UubcKcYojQ6LRXW5C2TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsaBkIjQX1uFTFpJYFGZRixiM3tZmDdbQfTKFjZmIM9VHFqsH5BK4oPlBlCwRqyzX
	 6dARtro6O+SqxdJc7+9plVD2xztnB0AkXF1vB/PjDnPEsAILqfRhsqLjapj86AHnuy
	 hrH4HndSrptzCbWz3MYt9LH/ibB5Zj1Xr2/MfTCDcHOFjOsSBlA+rNTCL1aPy6Knkc
	 Y0rPiwojcA6Kd5CkPSolQe0NWs+8/s7UWUYvitMiijVeZDgtXU8A+IrtzhujUJ+8Em
	 hssztG/cAp5axo6983MpuIqKYDNw2ZyDNryzXXllyxszzY2Lmjb/QN6Ev5jBArXebX
	 VA8fWQj6EKlJg==
From: guoren@kernel.org
To: palmer@dabbelt.com,
	guoren@kernel.org,
	conor@kernel.org,
	alexghiti@rivosinc.com,
	paul.walmsley@sifive.com,
	bjorn@rivosinc.com,
	eobras@redhat.com,
	corbet@lwn.net,
	peterlin@andestech.com,
	rabenda.cn@gmail.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] riscv: Move vendor errata definitions to new header
Date: Sun, 13 Jul 2025 11:53:20 -0400
Message-Id: <20250713155321.2064856-2-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250713155321.2064856-1-guoren@kernel.org>
References: <20250713155321.2064856-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Move vendor errata definitions into errata_list_vendors.h.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/errata_list.h         | 19 +---------------
 arch/riscv/include/asm/errata_list_vendors.h | 24 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/include/asm/errata_list_vendors.h

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 6e426ed7919a..18c9f7ee9b7c 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -10,24 +10,7 @@
 #include <asm/insn-def.h>
 #include <asm/hwcap.h>
 #include <asm/vendorid_list.h>
-
-#ifdef CONFIG_ERRATA_ANDES
-#define ERRATA_ANDES_NO_IOCP 0
-#define ERRATA_ANDES_NUMBER 1
-#endif
-
-#ifdef CONFIG_ERRATA_SIFIVE
-#define	ERRATA_SIFIVE_CIP_453 0
-#define	ERRATA_SIFIVE_CIP_1200 1
-#define	ERRATA_SIFIVE_NUMBER 2
-#endif
-
-#ifdef CONFIG_ERRATA_THEAD
-#define	ERRATA_THEAD_MAE 0
-#define	ERRATA_THEAD_PMU 1
-#define	ERRATA_THEAD_GHOSTWRITE 2
-#define	ERRATA_THEAD_NUMBER 3
-#endif
+#include <asm/errata_list_vendors.h>
 
 #ifdef __ASSEMBLY__
 
diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/include/asm/errata_list_vendors.h
new file mode 100644
index 000000000000..a37d1558f39f
--- /dev/null
+++ b/arch/riscv/include/asm/errata_list_vendors.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef ASM_ERRATA_LIST_VENDORS_H
+#define ASM_ERRATA_LIST_VENDORS_H
+
+#ifdef CONFIG_ERRATA_ANDES
+#define ERRATA_ANDES_NO_IOCP 0
+#define ERRATA_ANDES_NUMBER 1
+#endif
+
+#ifdef CONFIG_ERRATA_SIFIVE
+#define	ERRATA_SIFIVE_CIP_453 0
+#define	ERRATA_SIFIVE_CIP_1200 1
+#define	ERRATA_SIFIVE_NUMBER 2
+#endif
+
+#ifdef CONFIG_ERRATA_THEAD
+#define	ERRATA_THEAD_MAE 0
+#define	ERRATA_THEAD_PMU 1
+#define	ERRATA_THEAD_GHOSTWRITE 2
+#define	ERRATA_THEAD_NUMBER 3
+#endif
+
+#endif
-- 
2.40.1


