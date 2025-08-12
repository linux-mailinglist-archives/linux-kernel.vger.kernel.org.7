Return-Path: <linux-kernel+bounces-764906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F2B2286E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF1D7AE5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E12857E6;
	Tue, 12 Aug 2025 13:27:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6752586DA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005254; cv=none; b=ZaVRJRpyA8bOvvXUNb6nO+hQsjzF1WS4YBYBk9I7iy5Pon+86PT64H7tKsP6/Ppa1mJeQ/tqJIf7TZaDHCldR14TtNFdYeu+inDHaJcoe5OR2cVMk1AIgdN3DV1p6/1QfAwisb5CFZgcuyQA44J1V1SRdhCdpg+/2V5pm/390u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005254; c=relaxed/simple;
	bh=YZ09Id6v7EjDAgnRDASiWJGhvIAMhXex9LIsQ5F9RnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOkFZ0LGxZOHdxgi3f4YjRJVBbQ59krAfOhfkfo7r9ApG0g7mS84ZZIh6KIQzFSWlCxhs8ogfan4/AOmsaUX1aaPcF6Ua8yfPZk+qFnwqfP9SIKAZP06ZJ4mKRNipl5FnNCcVOv6Mx0nhU7JLRlr40wpceR8WLg8WZ/N7ySKadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxG6w7QZtoJ_g+AQ--.13111S3;
	Tue, 12 Aug 2025 21:27:23 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQ0QZtoOLVGAA--.6029S4;
	Tue, 12 Aug 2025 21:27:22 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] LoongArch: Pass annotate-tablejump option if LTO is enabled
Date: Tue, 12 Aug 2025 21:27:16 +0800
Message-ID: <20250812132716.1465-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250812132716.1465-1-yangtiezhu@loongson.cn>
References: <20250812132716.1465-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQ0QZtoOLVGAA--.6029S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AryrKr4rCw4xZry5ZF18Zwc_yoW8Kr1kp3
	9xCFZYqFs5Xrn7Kr9rJ3y2gr98KrZxK3W7WFyay348AwsxXa12vr10qF9FqFyrZws5XrWI
	qrZ3KrZ8KF4DCacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ApnDUUUU

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist
many objtool warnings "sibling call from callable instruction with
modified stack frame".

For this special case, the related object file shows that there is
no generated relocation section '.rela.discard.tablejump_annotate'
for the table jump instruction jirl, thus objtool can not know that
what is the actual destination address.

It needs to do something on the LLVM side to make sure that there is
the relocation section '.rela.discard.tablejump_annotate' if LTO is
enabled, but in order to maintain compatibility for the current LLVM
compiler, this can be done in the kernel Makefile for now. Ensure it
is aware of linker with LTO, '--loongarch-annotate-tablejump' needs
to be passed via '-mllvm' to ld.lld.

Note that it should also pass the compiler option -mannotate-tablejump
rather than only pass '-mllvm --loongarch-annotate-tablejump' to ld.lld
if LTO is enabled, otherwise there are no jump info for some table jump
instructions.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/loongarch/20250731175655.GA1455142@ax162/
Fixes: e20ab7d454ee ("LoongArch: Enable jump table for objtool")
Co-developed-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index b0703a4e02a2..6cdbcbbe730e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -103,6 +103,12 @@ KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
 ifdef CONFIG_OBJTOOL
 ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
 KBUILD_CFLAGS			+= -mannotate-tablejump
+# The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
+# Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' needs to be
+# passed via '-mllvm' to ld.lld.
+ifdef CONFIG_LTO_CLANG
+KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
+endif
 else
 KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
 endif
-- 
2.42.0


