Return-Path: <linux-kernel+bounces-818360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4BB590A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1317AAFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30462F3C36;
	Tue, 16 Sep 2025 08:25:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5522F3611
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011149; cv=none; b=P3ZlBRYCf/q0tU8hfMetsj7oDrFDSBO1HC4HmnyhBlvC9By2r1s26MICUVvBeWzujFZz36dihzaDByHVuTP15uUJFa8gaLim92kZIh3hrQN7XeJlOq5bla4FB4WnskhJYNeVOfO22C9C7T5EfTveH6bp+mjrkDrtL4KwNa4ACgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011149; c=relaxed/simple;
	bh=vR4ujFeL/c/rSyeE+Ew/QgmViHAeCETlnfNIV7PYf2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q65Rqx2zHgulj/fiKoc7JS0qXgDNhoxHuKS4rqfe+K2vSujUQNIhnrHW0aoEX0o5DawyZvnwl8CWclfQG0Y71xzlR83ESMyUo56i5v7K3PTsip5gM3Su2E3pIJldpoi5IUq/QWl0N51yBjjfXWitlmBM5HSyL9hUEYNeYT7kORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cQw2D1yMHz14MXG;
	Tue, 16 Sep 2025 16:25:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F03180087;
	Tue, 16 Sep 2025 16:25:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 16:25:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <charlie@rivosinc.com>,
	<macro@orcam.me.uk>, <deller@gmx.de>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v6 05/10] arm64/ptrace: Handle ptrace_report_syscall_entry() error
Date: Tue, 16 Sep 2025 16:26:06 +0800
Message-ID: <20250916082611.2972008-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082611.2972008-1-ruanjinjie@huawei.com>
References: <20250916082611.2972008-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The generic entry handle error of ptrace_report_syscall_entry(), but
arm64 not.

As the comment said, the calling arch code should abort the system
call and must prevent normal entry so no system call is
made if ptrace_report_syscall_entry() return nonzero.

In preparation for moving arm64 over to the generic entry code,
return early if ptrace_report_syscall_entry() encounters an error.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 95984bbf53db..707951ad5d24 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2317,10 +2317,10 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void report_syscall_enter(struct pt_regs *regs)
+static int report_syscall_enter(struct pt_regs *regs)
 {
-	int regno;
 	unsigned long saved_reg;
+	int regno, ret;
 
 	/*
 	 * We have some ABI weirdness here in the way that we handle syscall
@@ -2342,9 +2342,13 @@ static void report_syscall_enter(struct pt_regs *regs)
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
 
-	if (ptrace_report_syscall_entry(regs))
+	ret = ptrace_report_syscall_entry(regs);
+	if (ret)
 		forget_syscall(regs);
+
 	regs->regs[regno] = saved_reg;
+
+	return ret;
 }
 
 static void report_syscall_exit(struct pt_regs *regs)
@@ -2374,9 +2378,11 @@ static void report_syscall_exit(struct pt_regs *regs)
 
 int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 {
+	int ret;
+
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall_enter(regs);
-		if (flags & _TIF_SYSCALL_EMU)
+		ret = report_syscall_enter(regs);
+		if (ret || (flags & _TIF_SYSCALL_EMU))
 			return NO_SYSCALL;
 	}
 
-- 
2.34.1


