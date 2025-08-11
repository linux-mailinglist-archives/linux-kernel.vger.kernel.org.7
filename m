Return-Path: <linux-kernel+bounces-762211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E923B20392
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909083BEC96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE572DE70A;
	Mon, 11 Aug 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l5eXt6ER"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C82DFA2A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904503; cv=none; b=fwrE7LWKBoX8Pu5v1fn4hv4c84zqjtI5mBunTTA7yZNxCApPC178gYDPh9FFozGJv8w7f0YcgSzPKmLdRMymnsbuV9LKR70nvTz+f7XZgoN0hqWhqC122OV1VtFsxGxW+sWzw2QZhDKv+WjPTQbZAuKTSFlif2uZptOMtEJZzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904503; c=relaxed/simple;
	bh=TWmefRoC55W7AVicXj3J/cV4CdEcntC6RZQ0S5QOBSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJO20VJleGMrhz2ozoi6G2w3ZSdES9Vq8eeOWXA7WECQ4BaoMzGnQ3U/STu6b6igU9E2Fjyzy/coVmAA58vEq/WDcdBdLMO3y2TBBvVgaQl+tvNSkUPoXOZhb5VtmoOWGmOhT+g6M2UzYQ5sy7amGZAImdxXcPf8+xKW2fRXTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l5eXt6ER; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1fZPuz6xxyXns5V9c+B6pAeL+oN23MEikk16JZKk2w=;
	b=l5eXt6ERjCvzJ8rIOVvwNo2eM+PByJrlb98f/pBGcJB+DEWL0eNzEhSLrTUENgw/fAdPcW
	QC3tSk+dlAuXPU7LBzHcKZRN+IQklsx2sp0txteBTwTVrpj5apV3vayiheuAjFrr2oJXMR
	AidcjYtm3kXBxgm2xWBZ7UlRXbHxiGg=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
Date: Mon, 11 Aug 2025 17:26:56 +0800
Message-Id: <20250811092659.14903-4-youling.tang@linux.dev>
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

Add inird loading support and pass it to the second kernel via the
cmdline 'initrd=start,size'.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index bc91ae0afa4c..e1240644f529 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+/* Adds the "initrd=start,size" command line parameter to command line. */
+static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
+				char *modified_cmdline, unsigned long initrd)
+{
+	int initrd_strlen;
+
+	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
+		initrd, image->initrd_buf_len);
+	*cmdline_tmplen += initrd_strlen;
+}
+
+/*
+ * Tries to add the initrd to the image. If it is not possible to find
+ * valid locations, this function will undo changes to the image and return non
+ * zero.
+ */
 int load_other_segments(struct kimage *image,
 			unsigned long kernel_load_addr,
 			unsigned long kernel_size,
 			char *initrd, unsigned long initrd_len,
 			char *cmdline, unsigned long cmdline_len)
 {
+	struct kexec_buf kbuf;
+	unsigned long orig_segments = image->nr_segments;
+	char *modified_cmdline = NULL;
+	unsigned long cmdline_tmplen = 0;
+	unsigned long initrd_load_addr = 0;
+	int ret = 0;
+
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = kernel_load_addr + kernel_size;
+
+	modified_cmdline = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
+	if (!modified_cmdline)
+		return -EINVAL;
+
+	/* Ensure it's nul terminated */
+	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+
+	/* load initrd */
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = 0;
+		/* within 1GB-aligned window of up to 32GB in size */
+		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
+						+ (unsigned long)SZ_1G * 32;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+		initrd_load_addr = kbuf.mem;
+
+		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		/* Add the initrd=start,size parameter to the command line */
+		cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdline, initrd_load_addr);
+	}
+
+	if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
+		pr_err("Appending kdump cmdline exceeds cmdline size\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
+	cmdline = modified_cmdline;
 	image->arch.cmdline_ptr = (unsigned long)cmdline;
 
 	return 0;
+
+out_err:
+	image->nr_segments = orig_segments;
+	kfree(modified_cmdline);
+	return ret;
 }
-- 
2.34.1


