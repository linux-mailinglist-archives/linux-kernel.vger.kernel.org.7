Return-Path: <linux-kernel+bounces-724692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E76AFF5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1758556441D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A619CD13;
	Thu, 10 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W68ETzKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848583CC7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107552; cv=none; b=GMs/EWeDVSlFkPjE8gnpFqKLSOjnhc4pzZ2kEPBtzSdpQ52gzyC05srCO0Kx8wDoFZ6u5o4Xf6HQe+unHzfu6PcArvROzf3xSG43sHdc1nO+BqJlP5a1hCE04AtWXwm7VEjtjP9sCpm2a5GmkY32vKTrHFSreo2h4byAKg/tK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107552; c=relaxed/simple;
	bh=kRH1bCB8ne6m128KerpvU2IrCPOjChoMX05DviKRJPM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gWHbQpLjzix+M2YNJ7KV0qUcf5/rY3NvlABwIvCFUYso+HpoQKQjr5g0qWV6sknWWGMp4OWtHzV96VPXL+32H0rdhcoFbAwqJPS+YSdyM72ekJqKtvWy9JtHkRMA8i18pfw2W1IEUAUlSn7Brx27USjRNvDcn4wV/iVGxa/iLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W68ETzKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAFCC113CF;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107552;
	bh=kRH1bCB8ne6m128KerpvU2IrCPOjChoMX05DviKRJPM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=W68ETzKzMyOSzztjalw6/lEzM1umwGcJRGebYSW5HPi67RdxzIFvcrYB1iDmvLokB
	 dOBR6E1p3ykejzo4LyAwlY+RXv5TAf+YWErfNAnLvU3wgkBZAipzG0ud2ScNBtMXnO
	 UepsGlYPO8UufFt1e0hzTQH/54oI5GwlFCycfDgC2tl1ShyihlH6UFLgoLlSJQeC+/
	 loMWVgJZw1NIZ/BWTD2GNMuZB3huF3FH+okDixF19WWAcuhyd+skkTvWITcyopAhxq
	 /vGPB6rD6hw1tf33m9dYw7Rot1EzhHUoDgVFr3UFx5RRp/SxE1BDMLYAkqOVKfIqzY
	 fkWKAN6nH+y1g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDI-00000001WRF-3cqr;
	Wed, 09 Jul 2025 20:32:36 -0400
Message-ID: <20250710003236.710679622@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nam Cao <namcao@linutronix.de>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [for-next][PATCH 08/12] riscv: mm: Add page fault trace points
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Add page fault trace points, which are useful to implement RV monitor that
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/riscv/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c50..04ed6f8acae4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -20,6 +20,9 @@
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 #include "../kernel/head.h"
 
 static void show_pte(unsigned long addr)
@@ -291,6 +294,11 @@ void handle_page_fault(struct pt_regs *regs)
 	if (kprobe_page_fault(regs, cause))
 		return;
 
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, cause);
+	else
+		trace_page_fault_kernel(addr, regs, cause);
+
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
-- 
2.47.2



