Return-Path: <linux-kernel+bounces-764743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF7B226B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663785632F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9697218827;
	Tue, 12 Aug 2025 12:20:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC11F0E3E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001257; cv=none; b=APfeXZsJ1cMfwPYyha2ghFemuA5V6ym8FiqwkT0ef01DSvMVt9jzLCADbL69OAJ3DWtB4BmEse69io1zq1aAUjak8x3up83HBpn/o/dA4FZ0HzJLx7Q2CsfTHqVD5qr0lOEHFj/v4OmFqwsZNliew+GXGLboQ6QE++7B/ASjgis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001257; c=relaxed/simple;
	bh=sH4/kzqznZkqHgl6zkPOskLZcdIa83+yau5+ni0pqww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VL0rI4LnyRcS1w2jO+1K45hsfKrF7C43QE9J8VJGuH4tLERjhPj4exHW2P38dOhV8p3nu4vuwW0YU9K6TPNqr7FWIBV701guqA/hj055pKxWD9tHzQkG1Na4hacYhedbvEgZWgwlif+jaJ36Rrt0qE0UbISkJRl7/gLRDHawJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8Bx63GjMZto3_M+AQ--.53955S3;
	Tue, 12 Aug 2025 20:20:51 +0800 (CST)
Received: from ubuntu.. (unknown [111.207.111.194])
	by front1 (Coremail) with SMTP id qMiowJCxH8KeMZtoQ5dGAA--.16281S2;
	Tue, 12 Aug 2025 20:20:47 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Ming Wang <wangming01@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: lixuefeng@loongson.cn,
	chenhuacai@loongson.cn,
	Huang Cun <cunhuang@tencent.com>
Subject: [PATCH] LoongArch: Increase COMMAND_LINE_SIZE to 4096
Date: Tue, 12 Aug 2025 20:20:43 +0800
Message-ID: <20250812122043.2462836-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxH8KeMZtoQ5dGAA--.16281S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEMEmia16IHHwAAsB
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1kZry3trWktF13Kw47KFX_yoW8Ar13pF
	98ursrGa1rCr1fCrWSqa4xur1Fka97Ww1Yya4Ig3y8KFnaq34vkr4vgFZIkFyUXw47X348
	Z3ZYg34j9F1UX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20x
	vEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jY0PfUUUUU=

The default COMMAND_LINE_SIZE of 512, inherited from asm-generic, is
too small for modern use cases. For example, kdump configurations or
extensive debugging parameters can easily exceed this limit.

Therefore, increase the command line size to 4096 bytes, aligning
LoongArch with the MIPS architecture. This change follows a broader
trend among architectures to raise this limit to support modern needs;
for instance, PowerPC increased its value for similar reasons in
commit a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE to 2048").

Similar to the change made for RISC-V in commit 61fc1ee8be26
("riscv: Bump COMMAND_LINE_SIZE value to 1024"), this is considered
a safe change. The broader kernel community has reached a consensus
that modifying COMMAND_LINE_SIZE from UAPI headers does not
constitute a uABI breakage, as well-behaved userspace applications
should not rely on this macro.

Suggested-by: Huang Cun <cunhuang@tencent.com>
Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 arch/loongarch/include/uapi/asm/setup.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/loongarch/include/uapi/asm/setup.h

diff --git a/arch/loongarch/include/uapi/asm/setup.h b/arch/loongarch/include/uapi/asm/setup.h
new file mode 100644
index 000000000000..d46363ce3e02
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/setup.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_ASM_LOONGARCH_SETUP_H
+#define _UAPI_ASM_LOONGARCH_SETUP_H
+
+#define COMMAND_LINE_SIZE	4096
+
+#endif /* _UAPI_ASM_LOONGARCH_SETUP_H */
-- 
2.43.0


