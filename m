Return-Path: <linux-kernel+bounces-770575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CBBB27CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4679E1CC1CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2272BE7AC;
	Fri, 15 Aug 2025 09:09:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA620D50C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248966; cv=none; b=e6NjYCBRbKZCJ1Jo/XA1gvsOKo+TKdqmRRHdWh1ELFMXeV4IhX2TVA64Ve8G6w1V6RrP7cn9d/5ZP+FInk45uCFgE0cwcn365562U5pk7Bv1CL7maAzwTWHJ3+6r5HNifeqEXF7025HXzXu21F1nuFMU8hT1Di4q7+rCHG35Nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248966; c=relaxed/simple;
	bh=IiOXunXG6Wpt4Dt7F+FTN1G6+TjBVJhYZCdnhrxDbc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+qAkFtofo6O5lJgnRPPAH5JZkQkUFBNHC5jxJIrwgc6k7qAhroqz4DbS+NaMKjgGVVf7hQLuyqtfLy0L++jNFcpnKvgOdcZmfEURZ+g2DPzeyAOI84rStTNy1Z4sPIMYrUSNrZuzY/TvfHl5SyFBW+NBjOBMKhi2Kxf2d3de0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.45])
	by gateway (Coremail) with SMTP id _____8AxbeI8+Z5o_TpAAQ--.17953S3;
	Fri, 15 Aug 2025 17:09:16 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.45])
	by front1 (Coremail) with SMTP id qMiowJAx_8E2+Z5oYrlNAA--.33158S2;
	Fri, 15 Aug 2025 17:09:16 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Hanlu Li <lihanlu@loongson.cn>
Subject: [PATCH] LoongArch: Save LBT before FPU in setup_sigcontext()
Date: Fri, 15 Aug 2025 17:09:02 +0800
Message-ID: <20250815090902.1587392-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx_8E2+Z5oYrlNAA--.33158S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW5CFykGF4fWFWrKr13KFX_yoW8Wr43pF
	srCrn2yrW8G3Z3AFyDt348u3y5uryvqa4DW3Z2k34Fkr1qvrn8Gr1Iy3WvvFy5Xas3Jr40
	vFs5K3WayF1UK3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8EeHDUUUUU==

Now if preemption happens between protected_save_fpu_context() and
protected_save_lbt_context(), FTOP context is lost. Because FTOP is
saved by protected_save_lbt_context() but protected_save_fpu_context()
disables TM before that. So save LBT before FPU in setup_sigcontext()
to avoid this potential risk.

Signed-off-by: Hanlu Li <lihanlu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 4740cb5b2388..c9f7ca778364 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -677,6 +677,11 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
 	for (i = 1; i < 32; i++)
 		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
 
+#ifdef CONFIG_CPU_HAS_LBT
+	if (extctx->lbt.addr)
+		err |= protected_save_lbt_context(extctx);
+#endif
+
 	if (extctx->lasx.addr)
 		err |= protected_save_lasx_context(extctx);
 	else if (extctx->lsx.addr)
@@ -684,11 +689,6 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
 	else if (extctx->fpu.addr)
 		err |= protected_save_fpu_context(extctx);
 
-#ifdef CONFIG_CPU_HAS_LBT
-	if (extctx->lbt.addr)
-		err |= protected_save_lbt_context(extctx);
-#endif
-
 	/* Set the "end" magic */
 	info = (struct sctx_info *)extctx->end.addr;
 	err |= __put_user(0, &info->magic);
-- 
2.47.3


