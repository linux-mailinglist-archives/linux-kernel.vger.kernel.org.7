Return-Path: <linux-kernel+bounces-776989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0138B2D3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9CD58259A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E372BE632;
	Wed, 20 Aug 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wYgzfL6A"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837F2BD031
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669454; cv=none; b=pCtDuUn/OLhh1/uGqPMjQrhMMpb5EAYWtG1kRmQmz15bBvOTDtxTJmw05LGz+CLFWBYQLJNntwB6R2SujNgKBeX/iFzlNJr6WrmUc2qe0HNC6wEhmIGqB+czHx/4UD01Eup8b7xY5sC5n9CcME8J766A92kuQ0j3Qu0CsDdJAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669454; c=relaxed/simple;
	bh=M/+s+Rg4QX0UsMFsO33OqqJGq4/0/8jfcN6CZfBXJDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dtb+sY4y3/y2dtyr/3MH6WMhzV9Fd2jjgb/fwAGSGZ9p2x05UWcb9EGZ52r6AdFlIU7zU1Wq7lcGAuiAIevkZ5ZoIRe7+LYWi90Rsr7U7taTQzoYj4/PkxAkUVkq+8tZZdEPIVlzg4piyW2hR87RkCDq3F58m17L38bPvxWJ09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wYgzfL6A; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vujQZVf5TyhJiS/dKOstIc0xO8kGAvT4jnpNPRHbLQw=;
	b=wYgzfL6AM7+kHoEZULtwgFeqaqqIJ3ROtOncqgOKt5FEDatvgWSHyc9I3GQqMyEwnCGWYv
	tpqmf262KxbSoZyQtg/8uqUnR8dfgdr0uV0MpBeMMG557tshJt8eiSk4g/9fY5Q9SL3mvE
	iEZXl7UiF1GWhS9+RotvutUcMKPJtS4=
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
Subject: [PATCH v2 1/5] LoongArch: Add struct loongarch_image_header for kernel image
Date: Wed, 20 Aug 2025 13:56:56 +0800
Message-Id: <20250820055700.24344-2-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
References: <20250820055700.24344-1-youling.tang@linux.dev>
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
 arch/loongarch/include/asm/image.h | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 arch/loongarch/include/asm/image.h

diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
new file mode 100644
index 000000000000..1f090736e71d
--- /dev/null
+++ b/arch/loongarch/include/asm/image.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * LoongArch binary image header.
+ *
+ * Author: Youling Tang <tangyouling@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ *
+ * Most code is derived from LoongArch port of kexec-tools
+ */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+#ifndef __ASSEMBLY__
+
+/**
+ * struct loongarch_image_header
+ *
+ * @pe_sig: Optional PE format 'MZ' signature.
+ * @reserved_1: Reserved.
+ * @kernel_entry: Kernel image entry pointer.
+ * @image_size: An estimated size of the memory image size in LSB byte order.
+ * @text_offset: The image load offset in LSB byte order.
+ * @reserved_2: Reserved.
+ * @reserved_3: Reserved.
+ * @pe_header: Optional offset to a PE format header.
+ **/
+
+struct loongarch_image_header {
+	uint8_t pe_sig[2];
+	uint16_t reserved_1[3];
+	uint64_t kernel_entry;
+	uint64_t image_size;
+	uint64_t text_offset;
+	uint64_t reserved_2[3];
+	uint32_t reserved_3;
+	uint32_t pe_header;
+};
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_IMAGE_H */
-- 
2.43.0


