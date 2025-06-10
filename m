Return-Path: <linux-kernel+bounces-679127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27AAD327D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F114516563C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF028DB50;
	Tue, 10 Jun 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3EMHvmu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jwS4cz8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EE28C5C2;
	Tue, 10 Jun 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548650; cv=none; b=MEpk1nuydzTJoHeZJWh1syk+Al0a4gdhr2uXvg1IPdkCRfxgnedbhoDLjxKZSnjXKES02tTR4C6BVHC15lC9veLm9uxKYQShjUgOsQeR1tr+oJhB3J/hfJasWHcBr8ZnCZAiFs472MxpjsXQcvmnRcQgyr3LYIJ7Zy+S5xSmNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548650; c=relaxed/simple;
	bh=4FOxR9psjW0Lh3QZr9aY3QjFek8yvbpSbYrpDCkguxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtlnC+H3wHNE+Uy6zCFwOhq/NH4ht4UEjHXDwql6kx+Qa3D4R50hiYvVACPwk+zRjLaU5A9px635Dd19+TYdBNUkS0kBrsokfs2vQJv+FnvnrjIoNxzVIxNnklDfMgIJcu/4bv1ZVbQXlvqS9YVN841B2scMRpr5LfeozEOUuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3EMHvmu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jwS4cz8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eh7rmA0Cl1o4yt9TMnFteZzX4SWFzi/ZV4bMT0NRh8=;
	b=r3EMHvmuPzv/YMdohLDmR/hjxPR/GlwDwL3UPD4gNFVzuSgkzKI0qRKNSlQ+Sa90qUMrtm
	kKGg5xy3VZp2OGtfp+U9SgsCCLJw+uiuCmVcioZz5cJpj2ASCWqNSLl6UYrtW/lKBBSfy9
	KS8QCyVV9JDgzLkMhqfy/8r6ELPZG5NjF1zpFeys02AJmL0njPHfvGsvYchlKrZe2gN+Nc
	OEI7Tk+raA0CAiN8MbDstooiHWpLH2O2ezSO3or4SBPnl6iej5OVX+mh4dK8zjZ0EwXbAn
	yB1AmX1MgDJGSbkdxrW+Yn9IqR2ZhAaHuZ7hVkJdeqqcdDCYeNBS8oEFq4m6ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eh7rmA0Cl1o4yt9TMnFteZzX4SWFzi/ZV4bMT0NRh8=;
	b=2jwS4cz8nw4DchmIN4TEbdrF9IqQm7u+oo/JEI2Hw/knR2SL0uqXrebvfeA8aRNOyYRppT
	FPGZUepQoVANPXAg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 15/19] riscv: mm: Add page fault trace points
Date: Tue, 10 Jun 2025 11:43:40 +0200
Message-Id: <8ec7721c8c300ee99d5ec0782558c7689b7ec203.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add page fault trace points, which are useful to implement RV monitor that
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c506..04ed6f8acae4f 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -20,6 +20,9 @@
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 #include "../kernel/head.h"
=20
 static void show_pte(unsigned long addr)
@@ -291,6 +294,11 @@ void handle_page_fault(struct pt_regs *regs)
 	if (kprobe_page_fault(regs, cause))
 		return;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, cause);
+	else
+		trace_page_fault_kernel(addr, regs, cause);
+
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
--=20
2.39.5


