Return-Path: <linux-kernel+bounces-820556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D6AB7CFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C625580B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844432B49F;
	Wed, 17 Sep 2025 11:27:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED455309DD2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108447; cv=none; b=EFp7L6CcjZuVmE7fEbEA875CAmlwRVFxzB4g6j00IWRFZraEZARyEpeYtB2IexevZ1JTBil7XrALkjSqos/VIIO+wWYtKA71BZGZeSyhYP3XUbGCrwDo1PJINV4jh7qO/kD6eLORW8qd+m+0mq5kcOTeER+fk37y39U461O1OFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108447; c=relaxed/simple;
	bh=5xt4C80mQGWhGn4QWQy8RJCY75EMFYpXXeicgnELsmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw3Cs8qlXBaRnxjVy9ClMXLcSjvx7bBbsdKxgYyA9HVQ0fH3fT4BZi9ZrYpyQPWSi2UC6CR9RRd9Qzr3VVWdOjV9xmMqTEHvvf5yGBF7kEHX3BxUvlwyqwUYRg3UE9husoKy4hDe0avrA1d7WjBsd05SGzzkT3Sh6ktHnukfRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxK9Iam8poHVkLAA--.23130S3;
	Wed, 17 Sep 2025 19:27:22 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxQ+QVm8por2abAA--.39884S5;
	Wed, 17 Sep 2025 19:27:21 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] LoongArch: Remove is_entry_func() related code
Date: Wed, 17 Sep 2025 19:27:16 +0800
Message-ID: <20250917112716.24415-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250917112716.24415-1-yangtiezhu@loongson.cn>
References: <20250917112716.24415-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+QVm8por2abAA--.39884S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJryDCFW8Xr1rAF4rur15GFX_yoW8Gw15pF
	9xAwnrWrWFv3s2g34DXw1j9rWDZrn7XrnFgFZrKFyrW3Zrt3W3Cr1Fvw1j9FZ0y3yrWF1r
	XFnak3s0ka1DZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU4OzVUUUUU

For now, there is UNWIND_HINT_END_OF_STACK for the entry points
kernel_entry() and smpboot_entry(), just remove is_entry_func()
related code.

Link: https://lore.kernel.org/lkml/kjiyla6qj3l7ezspitulrdoc5laj2e6hoecvd254hssnpddczm@g6nkaombh6va/
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/unwind_orc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 0d5fa64a2225..710f82d73797 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -348,14 +348,6 @@ void unwind_start(struct unwind_state *state, struct task_struct *task,
 }
 EXPORT_SYMBOL_GPL(unwind_start);
 
-static bool is_entry_func(unsigned long addr)
-{
-	extern u32 kernel_entry;
-	extern u32 kernel_entry_end;
-
-	return addr >= (unsigned long)&kernel_entry && addr < (unsigned long)&kernel_entry_end;
-}
-
 static inline unsigned long bt_address(unsigned long ra)
 {
 	extern unsigned long eentry;
@@ -402,9 +394,6 @@ bool unwind_next_frame(struct unwind_state *state)
 	/* Don't let modules unload while we're reading their ORC data. */
 	guard(rcu)();
 
-	if (is_entry_func(state->pc))
-		goto end;
-
 	orc = orc_find(state->pc);
 	if (!orc) {
 		/*
-- 
2.42.0


