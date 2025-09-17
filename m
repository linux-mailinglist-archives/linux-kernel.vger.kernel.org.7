Return-Path: <linux-kernel+bounces-819817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69BB7ECDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3887A46045B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09B21B9D2;
	Wed, 17 Sep 2025 01:10:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE7421D00A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071425; cv=none; b=bclv8Ku3FbVwe1ESXvUbEYrHhRlkSpE6Wui5qQRfJWLhXZ+2Daru/6mnjEx+QG148woIoDQNpBes/D8kfp0o4xtV2kAqZT+k5LuBCCRbdEaL1lcVWz8eba8d0HnO+5s4VHa9VKz3UXImwTnDI8XgRVXn1hxwWPlAFNhGXHlZ7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071425; c=relaxed/simple;
	bh=5xt4C80mQGWhGn4QWQy8RJCY75EMFYpXXeicgnELsmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czknP+QZ8uftM7J4Tf8jBvCw1Aa0Ee2I1aKaPjbqQYWbhEHv+yYZXXTpzMHG2NFZQlJ2Xv7y/EPR/05p9FkVmsep7xzR7OQ6tpw/Xf05qTsn/5MOqGnI5jJIfXik1Nt8eGHooFxasDrP5QtkfVHbvoQxBEAUn9g3CVVZrhnIUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxrr99CspoKy4LAA--.23095S3;
	Wed, 17 Sep 2025 09:10:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+RwCsposWOaAA--.35728S6;
	Wed, 17 Sep 2025 09:10:21 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] LoongArch: Remove is_entry_func() related code
Date: Wed, 17 Sep 2025 09:10:07 +0800
Message-ID: <20250917011007.4540-5-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxE+RwCsposWOaAA--.35728S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJryDCFW8Xr1rAF4rur15GFX_yoW8Gw15pF
	9xAwnrWrWFv3s2g34DXw1j9rWDZrn7XrnFgFZrKFyrW3Zrt3W3Cr1Fvw1j9FZ0y3yrWF1r
	XFnak3s0ka1DZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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


