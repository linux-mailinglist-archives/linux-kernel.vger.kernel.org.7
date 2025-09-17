Return-Path: <linux-kernel+bounces-819819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06278B7F4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A153BD436
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D912222BF;
	Wed, 17 Sep 2025 01:10:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1021720C004
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071426; cv=none; b=TZcVjTizpEbkF4cjqUUbPKh/fyrEJmbCo+OkS86NM5B9ZoFUbtxHcTzqPwhpM8DSmWc0jjjWowLs6v5fTboTgHBZin6n320wIV3DligTpojONPSwwqy1hCblZee2Q2Kvh1XntU8/Lsd4d+gcy3o8IQioJ0+uXZBq8HpFx6HIus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071426; c=relaxed/simple;
	bh=wKMnfmUFWqrW3ySwm0v+v7NekQfUF/7ARBBzoLlWHsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9fuGpHXHOl6DE058JF9XVEIFMctJysbwUjznNOyNIxjnuKDe3NicFp+eeVUZRUQdvlI1MVm1wmi3qg6fXGLJex8SGmBT3TPkQwddNx9BoQPdLX3VB3IYzwiiq0wC+FKti4SBUm+yqpiBH0O2fB7KRV7q40yRoNrMOjJrmFm+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx3798CspoJi4LAA--.22702S3;
	Wed, 17 Sep 2025 09:10:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+RwCsposWOaAA--.35728S4;
	Wed, 17 Sep 2025 09:10:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] objtool/LoongArch: Fix unreachable instruction warnings about image header
Date: Wed, 17 Sep 2025 09:10:05 +0800
Message-ID: <20250917011007.4540-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250917011007.4540-1-yangtiezhu@loongson.cn>
References: <20250917011007.4540-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+RwCsposWOaAA--.35728S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF45AFyUKw1fCF17tF4rCrX_yoW5Cw4UpF
	47Cr1jyFZ8WFyqgw4DCw4a93yaqan8Xr4vqF1UJa43J3yq9asFq3ZYyw17GFyqqr4YgF4f
	Xr4UKrWDCa4jy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU1xpnPUUUUU==

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
following objtool warnings:

  vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
  vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction

All of the above instructions are in arch/loongarch/kernel/head.S,
and there is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
does not work for link time validation of vmlinux.o according to
tools/objtool/Documentation/objtool.txt.

After many discussions, it is not proper to ignore .head.text section
in objtool or put them from text section to data section, so just give
a unwind hint to fix the above warnings.

Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/lkml/CAAhV-H6A_swQmqpWHp6ryAEvc96CAMOMd2ZGyJEVNMsJfLkz6w@mail.gmail.com/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index e3865e92a917..6ce999586757 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -20,6 +20,7 @@
 	__HEAD
 
 _head:
+	UNWIND_HINT_UNDEFINED
 	.word	IMAGE_DOS_SIGNATURE	/* "MZ", MS-DOS header */
 	.org	0x8
 	.dword	_kernel_entry		/* Kernel entry point (physical address) */
-- 
2.42.0


