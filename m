Return-Path: <linux-kernel+bounces-762214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D897EB20395
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084B217D422
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3442E0419;
	Mon, 11 Aug 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwKHGRpT"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591942DFF28
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904508; cv=none; b=AATzkWKY8HflkuGXnUQasNWkbdkYbUjI+Mj0DKRWSClrqmG92dCuAk7mFFPVVGekJSrw8zAkIS4HFDTU1zWGmkFzmhbN8J7w7uyGt4i8HZroY8F8nJUD3mLffjIzC1BkFqthm3qMaIU/vkum2oGTRiju1M2r7d5YD+5pyP/FUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904508; c=relaxed/simple;
	bh=/vC9osK8wfB1+R2JlW34aWLlJGmHsgTTDK1oQaPrH9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWOSW2Eqhn9Z8zIo0nXFo5Vk8n78WrkGT51BNiTQbmxY1m066zaE9LmnqTqNVfSMake9mZvH93bjHwkO6mEy3Zvg/koSaWvP43L3LgIAbdviuFjHHkF8zujrPfvYj/LhD9e23sIvff2fi573rsgg9isROBeeaawpmIrGyd+a7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hwKHGRpT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wABBNQ3mHZ/Q4oyr/JGJiJ2cVXrJHeWuyGrS/7dyF1s=;
	b=hwKHGRpTwcj5BnYND7AUt6PvBNz24D5wu7pvV+pT3oIVgQM16TUOiEfmR5zIrUo/zIa/ZN
	33xkg7+hz0dUpiH9gD2Clb6XR36ZEEca1c5Vw1UvnN4KbQa27VE5RBcauGlM9bU7Rf3q3z
	fqGpZNysr9Fdqxk9cgpla5SLDtPx6bY=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 5/6] LoongArch/kexec_file: Add "mem" parameter to limit memory usage of kdump kernel
Date: Mon, 11 Aug 2025 17:26:58 +0800
Message-Id: <20250811092659.14903-6-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
References: <20250811092659.14903-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Add the "mem=size@start" parameter to the cmdline and pass it to the
capture kernel. Limit the runtime memory area for capturing the kernel
to avoid disrupting the production kernel site.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec_file.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 06def654cc09..7da88c80cace 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -89,6 +89,26 @@ static void cmdline_add_elfcorehdr(struct kimage *image, unsigned long *cmdline_
 	*cmdline_tmplen += elfcorehdr_strlen;
 }
 
+/*
+ * Adds the "mem=size@start" command line parameter to command line, indicating the
+ * memory region the new kernel can use to boot into.
+ */
+static void cmdline_add_mem(struct kimage *image, unsigned long *cmdline_tmplen,
+				char *modified_cmdline)
+{
+	int mem_strlen = 0;
+
+	mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%llx@0x%llx ",
+		crashk_res.end - crashk_res.start + 1, crashk_res.start);
+	*cmdline_tmplen += mem_strlen;
+
+	if (crashk_low_res.end) {
+		mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%llx@0x%llx ",
+			crashk_low_res.end - crashk_low_res.start + 1, crashk_low_res.start);
+		*cmdline_tmplen += mem_strlen;
+	}
+}
+
 #endif
 
 /* Adds the "initrd=start,size" command line parameter to command line. */
@@ -136,6 +156,7 @@ int load_other_segments(struct kimage *image,
 	/* load elf core header */
 	void *headers;
 	unsigned long headers_sz;
+
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
@@ -165,6 +186,9 @@ int load_other_segments(struct kimage *image,
 
 		/* Add the elfcorehdr=size@start parameter to the command line */
 		cmdline_add_elfcorehdr(image, &cmdline_tmplen, modified_cmdline, headers_sz);
+
+		/* Add the mem=size@start parameter to the command line */
+		cmdline_add_mem(image, &cmdline_tmplen, modified_cmdline);
 	}
 #endif
 
-- 
2.34.1


