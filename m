Return-Path: <linux-kernel+bounces-761881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B1B1FF95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DBA189C15A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFCC2D77E1;
	Mon, 11 Aug 2025 06:47:54 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284E2D63EF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894873; cv=none; b=ElzLRr7ZtFLqqSrjUEY5VVx4CBlfxhesSDsj/fUQk2fI8l09LDBXOxaYGr6g49Hdiz6BMaTDkGoPPcZ8GI2RNuRSBjKoFWTivtU050WW8WsvusfN/N6Pjp700r2mSXv8427TsYtqGbyVH1Xez33lL/8w8z7vvxJj3XjtvvxF1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894873; c=relaxed/simple;
	bh=Aawnwfa4PGy1oiez0LYgQqA7ZTuH+JVaYq4JQwiu42A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u0fGwDpXqwuZWQHLXUE34HSScTapldESKBjXDD6GH6XdnqtSrfki2EIBzOgThYzY7bxAKExtZdj2mdynYRmKeqlEb441nZTQac+6+frDv5KHsYlcS/6a3WQ1my/6ykm54+aVgcVN9dF06+zRaoRU1LRI9cNGqxaEEloE57dPcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <samuel.holland@sifive.com>, <paul.walmsley@sifive.com>,
	<tglx@linutronix.de>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] irqchip/irq-sifive-plic: Use for_each_present_cpu() instead of for_each_cpu()
Date: Mon, 11 Aug 2025 14:47:01 +0800
Message-ID: <20250811064701.2906-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc12.internal.baidu.com (172.31.51.12) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the opencoded for_each_cpu(cpu, cpu_present_mask) loop with the
more readable and equivalent for_each_present_cpu(cpu) macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..3de54606b8f8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -257,7 +257,7 @@ static int plic_irq_suspend(void)
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
 
-	for_each_cpu(cpu, cpu_present_mask) {
+	for_each_present_cpu(cpu) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (!handler->present)
@@ -289,7 +289,7 @@ static void plic_irq_resume(void)
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
 	}
 
-	for_each_cpu(cpu, cpu_present_mask) {
+	for_each_present_cpu(cpu) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (!handler->present)
-- 
2.36.1


