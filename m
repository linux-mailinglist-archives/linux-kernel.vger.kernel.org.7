Return-Path: <linux-kernel+bounces-798216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01BB41AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880F01B254C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B58B2F39A0;
	Wed,  3 Sep 2025 09:53:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339E2F28F0;
	Wed,  3 Sep 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893214; cv=none; b=SXV+YZsykN2HVa+5gdBbxW1YVwzuaimgBFzbqFl2RIIoy1Dc2m5S7u98guNYYuzvYc9vIMBbqu7t3mChWgdFrJYIR/O/PpASOA6psUC5JDERGVMlT8xchzxD/vdCyQlXvo5JUd+vAkqY+tI12C6rCgp6iiWsj6+TliA9IfrA36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893214; c=relaxed/simple;
	bh=PuAfWmWmu4+nzyctL9OZNVJZoNyu+8EySupeLi2tGKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9NuQIHMr0XlxBhkyqUtnoYqOkhx0uLUJPxU/i6/ID6kdQN/Xxp3Qcd6fuobexj3OAqPYEuA9IkagRz0lzi8h6tQeUkJRpHNJLXnD4uLm3CZ0dr0j4UCJDK9671Wq46UM9BVfqfDATa+vcwefMOQtG/m7L+1Dp2dJY/1eGGC0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx1tAUELho8i0GAA--.12914S3;
	Wed, 03 Sep 2025 17:53:24 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxfcEMELhom_16AA--.5842S5;
	Wed, 03 Sep 2025 17:53:24 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>,
	rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] LoongArch: Handle table jump option for RUST
Date: Wed,  3 Sep 2025 17:53:15 +0800
Message-ID: <20250903095315.15057-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250903095315.15057-1-yangtiezhu@loongson.cn>
References: <20250903095315.15057-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcEMELhom_16AA--.5842S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rtrW5uF4fJrWrZr1DurX_yoW5ZF1xpw
	nru3s5tr4rGFn7t39xJayUWr4rJrnxtw13XFs7G348Aay7X34UZrs2y3srXFy8AwnxW3yS
	qryrK3y3KFWDC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

When compiling with LLVM and CONFIG_RUST is set, there exist objtool
warnings "sibling call from callable instruction with modified stack
frame" in rust/core.o and rust/kernel.o.

For this special case, the related object file shows that there is no
generated relocation section '.rela.discard.tablejump_annotate' for the
table jump instruction jirl, thus objtool can not know that what is the
actual destination address.

If the rustc has the option "-Cllvm-args=--loongarch-annotate-tablejump",
pass the option to enable jump table for objtool, otherwise it is better
to remain -Zno-jump-tables to keep compatibility with older rustc.

How to test:

(1) Please install rustc 1.78.0 (without annotate-tablejump option) or
1.87.0 (with annotate-tablejump option), do not use the latest version
for now, otherwise there may be build error:

     --> rust/kernel/lib.rs:331:13
      |
  331 |         loc.file_with_nul()
      |             ^^^^^^^^^^^^^ method not found in `&'a Location<'a>`

  error: aborting due to 1 previous error

(2) Execute the following command:

  $ rustup component add rust-src
  $ make LLVM=1 rustavailable
  $ make ARCH=loongarch LLVM=1 clean defconfig
  $ scripts/config -d MODVERSIONS \
    -e RUST -e SAMPLES -e SAMPLES_RUST \
    -e SAMPLE_RUST_CONFIGFS -e SAMPLE_RUST_MINIMAL \
    -e SAMPLE_RUST_MISC_DEVICE -e SAMPLE_RUST_PRINT \
    -e SAMPLE_RUST_DMA -e SAMPLE_RUST_DRIVER_PCI \
    -e SAMPLE_RUST_DRIVER_PLATFORM -e SAMPLE_RUST_DRIVER_FAUX \
    -e SAMPLE_RUST_DRIVER_AUXILIARY -e SAMPLE_RUST_HOSTPROGS
  $ make ARCH=loongarch LLVM=1 olddefconfig all

Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig  | 4 ++++
 arch/loongarch/Makefile | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac..57933a717e92 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -298,6 +298,10 @@ config AS_HAS_LVZ_EXTENSION
 config CC_HAS_ANNOTATE_TABLEJUMP
 	def_bool $(cc-option,-mannotate-tablejump)
 
+config RUSTC_HAS_ANNOTATE_TABLEJUMP
+	depends on RUST
+	def_bool $(rustc-option,-Cllvm-args=--loongarch-annotate-tablejump)
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 9d80af7f75c8..b26d47707031 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -106,6 +106,12 @@ KBUILD_CFLAGS			+= -mannotate-tablejump
 else
 KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
 endif
+ifdef CONFIG_RUSTC_HAS_ANNOTATE_TABLEJUMP
+# Pass '--loongarch-annotate-tablejump' via '-Cllvm-args' to rustc when RUST is enabled.
+KBUILD_RUSTFLAGS		+= -Cllvm-args=--loongarch-annotate-tablejump
+else
+KBUILD_RUSTFLAGS		+= -Zno-jump-tables # keep compatibility with older compilers
+endif
 ifdef CONFIG_LTO_CLANG
 # The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
 # Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' also needs to
-- 
2.42.0


