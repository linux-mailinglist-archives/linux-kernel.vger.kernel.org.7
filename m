Return-Path: <linux-kernel+bounces-762212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE3B20394
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01507A57AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91732E03E1;
	Mon, 11 Aug 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BGP3zFfN"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1D2DFA3B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904506; cv=none; b=kG4r1uh2a7JX2Ye/krgwYBIhwP4XecaQ3RlV7WOawd/lsGqNqKZYKDECqwUwTJKBpC2R/8Hmm2MMRhY+SXp9aCHRQEYbmhSJ5Eq3ON8FSllps8sGpYXz9PV/FSCS837oR5JwJzZP8vp2K8tctu3N3sUDzRasJ1+Z7N/KgBcySI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904506; c=relaxed/simple;
	bh=ogHVg2U4TnYZRN5gWBDUmmchrxO84Cc7oayXPA2f7zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZoD3DIF+KvlPIOmtTxV8HBjm08a85X0+agn89fLrVSvQ5fLt0PNm6OWs4LAnJw6f7I157++gJYdQKqpp/C9BUC6xBtaU/baiueyepShTSsfpBI8vGV3SWt3Fasoz3SoC35TbI6yoMcDSrOUa7jmvhT5ss61iyvxx9sqBmExPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BGP3zFfN; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bptUG6+6W2TjiSNT88rR5MzDy6r8MtSXxrLcyKgaTpk=;
	b=BGP3zFfNqnFS8+fpFseO1BHiuuPXajlLtT/byV8ZH/dAlGG12DovvVEOyLyVFPBzOLr4he
	ZRiw+HgQ5QfS5E9OfmDEtHKiLwpOFWruToeC6/vvh2sr+A7INlnAyj415vCp8/J6baigZb
	MEbSrUnG6tPvCIGJb3um4O7MI749nfY=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 4/6] LoongArch/kexec_file: Add crash dump support
Date: Mon, 11 Aug 2025 17:26:57 +0800
Message-Id: <20250811092659.14903-5-youling.tang@linux.dev>
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

Enabling crash dump (kdump) includes:
- prepare contents of ELF header of a core dump file, /proc/vmcore,
  using crash_prepare_elf64_headers().
- add "elfcorehdr=size@start" to command line.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec_file.c | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index e1240644f529..06def654cc09 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -34,6 +34,63 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+#ifdef CONFIG_CRASH_DUMP
+
+static int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	unsigned int nr_ranges;
+	int ret;
+	u64 i;
+	phys_addr_t start, end;
+
+	nr_ranges = 2; /* for exclusion of crashkernel region */
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
+
+	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
+	if (!cmem)
+		return -ENOMEM;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			goto out;
+	}
+
+	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+out:
+	kfree(cmem);
+	return ret;
+}
+
+/* Adds the "elfcorehdr=size@start" command line parameter to command line. */
+static void cmdline_add_elfcorehdr(struct kimage *image, unsigned long *cmdline_tmplen,
+				char *modified_cmdline, unsigned long elfcorehdr_sz)
+{
+	int elfcorehdr_strlen = 0;
+
+	elfcorehdr_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "elfcorehdr=0x%lx@0x%lx ",
+		elfcorehdr_sz, image->elf_load_addr);
+	*cmdline_tmplen += elfcorehdr_strlen;
+}
+
+#endif
+
 /* Adds the "initrd=start,size" command line parameter to command line. */
 static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmplen,
 				char *modified_cmdline, unsigned long initrd)
@@ -75,6 +132,42 @@ int load_other_segments(struct kimage *image,
 	/* Ensure it's nul terminated */
 	modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
 
+#ifdef CONFIG_CRASH_DUMP
+	/* load elf core header */
+	void *headers;
+	unsigned long headers_sz;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&headers, &headers_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out_err;
+		}
+
+		kbuf.buffer = headers;
+		kbuf.bufsz = headers_sz;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		kbuf.memsz = headers_sz;
+		kbuf.buf_align = SZ_64K; /* largest supported page size */
+		kbuf.buf_max = ULONG_MAX;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(headers);
+			goto out_err;
+		}
+		image->elf_headers = headers;
+		image->elf_load_addr = kbuf.mem;
+		image->elf_headers_sz = headers_sz;
+
+		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+
+		/* Add the elfcorehdr=size@start parameter to the command line */
+		cmdline_add_elfcorehdr(image, &cmdline_tmplen, modified_cmdline, headers_sz);
+	}
+#endif
+
 	/* load initrd */
 	if (initrd) {
 		kbuf.buffer = initrd;
-- 
2.34.1


