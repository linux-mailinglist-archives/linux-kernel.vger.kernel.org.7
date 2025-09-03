Return-Path: <linux-kernel+bounces-797626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E9B412B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F351B633C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD72C158F;
	Wed,  3 Sep 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7jOzflN"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CE22172E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868539; cv=none; b=E2iFql6i5FqNIl6bGRNvFUOBzWGPFrAcwlrmvcvPhH4ELuju6tNbaRYaDEmCPwHyGfTAyw9VBAhV/niLj7IMKtT6NDRYvniGU6DI405II8JgMdRclWmAoet6nPwh6ZwSr257WJMMHrHq2t/+hB5SI3+YPLoGH9aDfmUvU4waUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868539; c=relaxed/simple;
	bh=WjhsrADC0GwnfBXxhFnWnNnYaAC+LU2wLei9uwujpOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpIi31THROrvMmSsQX/4280++wkMffxRY/tbphQtDO9DlJN+GwXJMc33hOCl6+mXyD3/wBpRaL6kXnyCspltdEudVoUc+/2WBX2d1omdjrJNOAGgqaZC5I92IlcyYScaCc4lxflkr376aAocniIxiDd3YeiFxwL1bq9fDzUljJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7jOzflN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B6OfEVdBH7wSZaIebpK16txAhX6ctZF4LG8My4lKI0=;
	b=G7jOzflNI/vNR76mNjnQLgVxECxcx7TMgYOD0x3Tw8+UYC/6d0kHe2p0kLEJMe5tQd0wv6
	klmRVAZm5+zdcvBSJO9B5TVMqtsF95dpyCvCHBvz7NvnCfTO+FJ2QaG8ai7Jph2EIVg5cm
	GNadLNnoX5YawEMWVjJIHqEEF+pfDPU=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v4 1/7] LoongArch: Add struct loongarch_image_header for kernel image
Date: Wed,  3 Sep 2025 11:00:54 +0800
Message-Id: <20250903030100.196744-2-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Define a dedicated image header structure for LoongArch architecture to
standardize kernel loading in bootloaders (primarily for kexec_file).

This header includes critical metadata such as PE signature, entry points,
image size and load address offset, etc.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/include/asm/image.h | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 arch/loongarch/include/asm/image.h

diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
new file mode 100644
index 000000000000..ff539711c9ea
--- /dev/null
+++ b/arch/loongarch/include/asm/image.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch binary image header for EFI(PE/COFF) format.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+#ifndef __ASSEMBLER__
+
+/**
+ * struct loongarch_image_header
+ *
+ * @dos_sig: Optional PE format 'MZ' signature.
+ * @padding_1: Reserved.
+ * @kernel_entry: Kernel image entry pointer.
+ * @kernel_asize: An estimated size of the memory image size in LSB byte order.
+ * @text_offset: The image load offset in LSB byte order.
+ * @padding_2: Reserved.
+ * @pe_header: Optional offset to a PE format header.
+ **/
+
+struct loongarch_image_header {
+	uint8_t dos_sig[2];
+	uint16_t padding_1[3];
+	uint64_t kernel_entry;
+	uint64_t kernel_asize;
+	uint64_t text_offset;
+	uint32_t padding_2[7];
+	uint32_t pe_header;
+};
+
+#endif /* __ASSEMBLER__ */
+#endif /* __ASM_IMAGE_H */
-- 
2.43.0


