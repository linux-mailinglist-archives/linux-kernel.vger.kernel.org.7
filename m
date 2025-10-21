Return-Path: <linux-kernel+bounces-862488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFB2BF572D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED3734EC1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECF32AADF;
	Tue, 21 Oct 2025 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GLo8ZfOJ"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B532A3FD
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037953; cv=none; b=SMHjZ7lDZyFL0xDv7zvGuZAOMVjEmlY8Bg3wy6sELH+ULwDMPrA2Z5y98AqxxM5Tki4RZuan76iWp7ivWqcuGkzEYGyQ0sy8FWA+cLplgXI0apj7yAhrGG9bl2+3kQeGuJzFChT/KQiOE0Y8EadrqoZGxcvtTOVu8QQF0RvU3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037953; c=relaxed/simple;
	bh=FRqje6zZqwQFspWHvUiPAxQygWNim8OVJRmR3NbaxYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4304txRwDWnPwEZ17PMfGfj3uV011TtKbzYv7IHhbPcBZs12wVN8SXSzlPVj1p/vjcPETMUCS/04zZ2DDPPLVCgm1DEs0Dy6sdbqyFqYzIsekicGA9N0QTD8rCa8Gq5CEtVt3T+LldrE93zCYbOWBQB6Agc1xX23jnikLUqGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GLo8ZfOJ; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761037908;
	bh=NFpwIvY8OI+j5BVs1t2HxeAH2S2XYLpAzZObsYvHy6s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=GLo8ZfOJDGNMjdyt4FuLeizKSG4m8hJLFqzkIUX97rqHYNNDyoXdIw0Diukot/g28
	 rL32lGPhIG3L0YpOd36SMZBl+qH/tXdJgcY2Rs9Sg+sXpHqIjhmxGu9Ck+9BfOVwVV
	 atiwvoQ+MoFRrgxV96WjiK7yOuZZvHPwiwVzl1u0=
X-QQ-mid: zesmtpsz4t1761037903t5eefea4c
X-QQ-Originating-IP: wVogaDMgnwbVTvybg6BtlltHTXkOW5VMPO1Dbf5yshA=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 17:11:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3431755223997503707
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] LoongArch: kexec_file: print out debugging message if required
Date: Tue, 21 Oct 2025 17:11:14 +0800
Message-Id: <20251021091114.982820-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NyqG2qnv0b2db+leZrY/G1ua8gNsmqbtm7mpaBgm6uBFCLTQEn4/Ct6C
	epM8mUjKecW6mW5A1ZpLo3c6POw/6JmC0Myj8rdN1QJdIzVzDhD+XiksWUFJDQTmxAUFAPa
	pavUM7N+7ZLWftOSUBgJy85tXuTFDnzjGrgepnUX82W3eFMtdWfLxoNxF3a9qifm8WqdKQ0
	orRZ5s9RjxTwWgRIi5U5bLVlXEiAT323afMIH9aeWCrSXDyo4srNisBRypSXlT/kkGCXaDb
	47nyYacsNefGgWabUsbV87OvWiEfPf9XV/ykYAAlz8G3H7m6XS97JPklK2WWlbskRZPTgK6
	DOwKHfA3m+o2OjRIepmyheOXFUNxS9xdZZfd4Ke0n9M2tYvQ5PrPm+ICnHW+zViy+/0zBtp
	0LtrUjNiieOTDUBK2UQQdWBBICsGxkJ+GEYJd0WvAZvrBurZfQb3Or2F+fepoaMYPVGLVBI
	5L9t4oFIhJJ+ju1HcaFtQa5tVuP6gTr3e1dpE/Bdqw7u9o2wo1dMyq4vqimHuSlWX4BRvNz
	VD4eqCHCZanoc5Qi1l09YPN7CjpWbiJanurZvyFXXEKRRAaw1/qVbVzLSI3F/nTZ5uS2HnU
	reMp7JJCfcB9gOwT9VZIbuPCfM9uejeYbqwyGg4cTVCabxpRgn3m3lvOJf38Sjvlmp2r8Qy
	AbE+hOJ3PWtMUax/zUl+GQ+WoM5mY/onJ7pcb1M2E8gw/6rriUKxLkqKjjNfY0A+sr+rjTJ
	g1xlZ0zEGkNnhje4geG9zktGiVNyqCQwNiK9TH5N7myLNXwzId4rxVK0kpOw4DRhXUdc3/a
	83Uq91CNv84sHuFrVCr4vIJCdx6+CNTkb6viNsPnITMh8o9mgvb81qL2sXoqMOskvF21K9a
	ZmPp+Y23ynt3bUA+4xdEgl+p0O4QPv63zgN8zAQC6EPpMyNBE3QYlKF9htsuBXPd0Uy57VC
	VQP1zxmnwtGNThaPD6B5e7EDJ/CL0GKWk1dNZ6W7vai1yN4Jw5WR7orWwaNFHbMO9WJKcWa
	joV6Uoyg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

When specifying '-d' for kexec_file_load interface, loaded locations
of kernel/initrd/cmdline etc can be printed out to help debug.

Commit eb7622d908a0 ("kexec_file, riscv: print out debugging message
if required") fixes the same issue on RISC-V.

So, remove kexec_image_info() because the content has been printed
out in generic code.

And on Loongson-3A5000, the printed messages look like below:

[  288.667939] kexec_file: kernel: 00000000d9aad283 kernel_size: 0x2e77f30
[  288.668414] kexec_file(EFI): No LoongArch PE image header.
[  288.703104] kexec_file: Loaded initrd at 0x80000000 bufsz=0x1637cd0 memsz=0x1638000
[  288.703674] kexec_file(ELF): Loaded kernel at 0x9c20000 bufsz=0x27f1800 memsz=0x2950000
[  288.704092] kexec_file: nr_segments = 2
[  288.704277] kexec_file: segment[0]: buf=0x00000000cc3e6c33 bufsz=0x27f1800 mem=0x9c20000 memsz=0x2950000
[  288.741213] kexec_file: segment[1]: buf=0x00000000bb75a541 bufsz=0x1637cd0 mem=0x80000000 memsz=0x1638000
[  288.757182] kexec_file: kexec_file_load: type:0, start:0xb15d000 head:0x18db60002 flags:0x8

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/loongarch/kernel/machine_kexec.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index e4b2bbc47e62..2d64b7c81e5e 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -39,34 +39,12 @@ static unsigned long systable_ptr;
 static unsigned long start_addr;
 static unsigned long first_ind_entry;
 
-static void kexec_image_info(const struct kimage *kimage)
-{
-	unsigned long i;
-
-	pr_debug("kexec kimage info:\n");
-	pr_debug("\ttype:        %d\n", kimage->type);
-	pr_debug("\tstart:       %lx\n", kimage->start);
-	pr_debug("\thead:        %lx\n", kimage->head);
-	pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
-
-	for (i = 0; i < kimage->nr_segments; i++) {
-		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
-			kimage->segment[i].mem,
-			kimage->segment[i].mem + kimage->segment[i].memsz);
-		pr_debug("\t\t0x%lx bytes, %lu pages\n",
-			(unsigned long)kimage->segment[i].memsz,
-			(unsigned long)kimage->segment[i].memsz /  PAGE_SIZE);
-	}
-}
-
 int machine_kexec_prepare(struct kimage *kimage)
 {
 	int i;
 	char *bootloader = "kexec";
 	void *cmdline_ptr = (void *)KEXEC_CMDLINE_ADDR;
 
-	kexec_image_info(kimage);
-
 	kimage->arch.efi_boot = fw_arg0;
 	kimage->arch.systable_ptr = fw_arg2;
 
-- 
2.20.1


