Return-Path: <linux-kernel+bounces-807702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DBB4A80B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF80716EBBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA772D63F9;
	Tue,  9 Sep 2025 09:27:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0802C3769;
	Tue,  9 Sep 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410036; cv=none; b=HbswvN8FkHuhfd5Qpiw4ssknUQnAIQjnzooeZi/nqHrCfWu8LK+QlKB0sJtLiSL2ce8vhVauA5kPOvdY1lyPfansFTUpN3NjcAoQpSMbe/luZX/Xt+3SEZcHsbgPMof1FSdF5Uz6rX8cxONMhLTMxSbdasonj8A6w6SsZKjTV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410036; c=relaxed/simple;
	bh=nIFaynFcEbl7rcXVOS3FG8O9m5LAgsOVRJWqjgbAzcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cej5lRwYVOHKJiOkDwGcUDqtz3+ZO1eDQuIEsjtaM9FAQ2BVqwzIpxIIMYvr6XMfbcXHNfNuN/RuEKPTXME48+Ywp2frh2DjjMKglisRKNIlJsbrr3OGL4Cx0qMNcENkLJmE+L66CuBrmf0W97JRw1d6IZqhHP7NERh82B61W+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxXNLw8r9ook8IAA--.17608S3;
	Tue, 09 Sep 2025 17:27:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxbMHr8r9oeuSJAA--.56108S4;
	Tue, 09 Sep 2025 17:27:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>,
	rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] LoongArch: Handle jump tables option for RUST
Date: Tue,  9 Sep 2025 17:27:07 +0800
Message-ID: <20250909092707.3127-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250909092707.3127-1-yangtiezhu@loongson.cn>
References: <20250909092707.3127-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxbMHr8r9oeuSJAA--.56108S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF47Gw1fKF48JFWDKryDArc_yoW5Zr1Upw
	nruas5tr4rGF1kt39xJayUWr45Jrnxtw17XF4xG348Ar47Z34UZr4vqr9rXFyUAwsxu3yS
	qryrKrW3KFWUC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU

When compiling with LLVM and CONFIG_RUST is set, there exist objtool
warnings in rust/core.o and rust/kernel.o, like this:

    rust/core.o: warning: objtool:
_RNvXs1_NtNtCs5QSdWC790r4_4core5ascii10ascii_charNtB5_9AsciiCharNtNtB9_3fmt5Debug3fmt+0x54:
sibling call from callable instruction with modified stack frame

For this special case, the related object file shows that there is no
generated relocation section '.rela.discard.tablejump_annotate' for the
table jump instruction jirl, thus objtool can not know that what is the
actual destination address.

If the rustc has the option "-Cllvm-args=--loongarch-annotate-tablejump",
pass the option to enable jump tables for objtool, otherwise it should
pass "-Zno-jump-tables" to keep compatibility with older rustc.

How to test:

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

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/rust-for-linux/CANiq72mNeCuPkCDrG2db3w=AX+O-zYrfprisDPmRac_qh65Dmg@mail.gmail.com/
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


