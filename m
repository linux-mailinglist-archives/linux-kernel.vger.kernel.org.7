Return-Path: <linux-kernel+bounces-721638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE121AFCBE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5603717E0B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46D2DEA75;
	Tue,  8 Jul 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdUf0j19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88721FF29;
	Tue,  8 Jul 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981063; cv=none; b=uPGFOXZF7gJUDRS8G6wNtFqvLleSCbIEZr9xZYte/LedOiUyDygv4vA6zkGYsyhJfNxXEBksXoyz0mpMNZRwsuBhfH+33H30znvw5Y5LQ1KEAoEHQ0XhAO7QySMWjx/j4dBvpXH8YW+gUDNKtjtU8pJIK1LR+3MrgtiFL9f1bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981063; c=relaxed/simple;
	bh=agbYl8FZKWRFcU68ariNdhaDtMp1Ktz5EN2+CeAfRW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k63RrhA93bvG5+3FQJEt0ov978drG5GXt1vhDsgSQKGRGOiUwsKcZjrtvgW71hSwt18/OnNfY4dag24Mfa8mlVqz9wVO0Rkee0eEH0wjIpdC3k8OaenqlpV7y7sl3dyBP2SNfGXC2Fx42OLtAdnJXJbn66PU5BMz8Bzi/DiUPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdUf0j19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C90C4CEED;
	Tue,  8 Jul 2025 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981063;
	bh=agbYl8FZKWRFcU68ariNdhaDtMp1Ktz5EN2+CeAfRW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdUf0j19Dbn+bvjMaofQ3uXmT2w4KUSRTOJyPXceoI/KnNAL7Ju1ZgAlJn72YY6hF
	 jNutonuMc3Y/IGlS325d4BZk+snAiG+dtcCxO7IRxDPIFM/yKzrqHfjMUGQoxMq0Us
	 1X70aMqHD9HsB3kqoioIrmqzR7YFXo1typDSLUBXd5EGTCfgpa64ytyPbLCc4BmwZ3
	 MkNMBFgfOe3uoBn//gmrZ7l0m05oXgWlz0N2AsxmPGMiCHbH3dEfV69j0XkJtsViRk
	 9umqvSafoyjc9PUToN5NNwr9mEbgzxTZlXuCakRijWTGq4POYwnN9J5x9y78PY7C4e
	 eI0SEPD6g+bww==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv4 perf/core 03/22] uprobes: Make copy_from_page global
Date: Tue,  8 Jul 2025 15:23:12 +0200
Message-ID: <20250708132333.2739553-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708132333.2739553-1-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making copy_from_page global and adding uprobe prefix.
Adding the uprobe prefix to copy_to_page as well for symmetry.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 01112f27cd21..7447e15559b8 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -226,6 +226,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4e8e607abda8..37d3a3f6e48a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -177,7 +177,7 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
@@ -205,7 +205,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp = is_swbp_insn(&old_opcode);
 
 	if (is_swbp_insn(new_opcode)) {
@@ -1052,7 +1052,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	uprobe_copy_from_page(page, offset, insn, nbytes);
 	put_page(page);
 
 	return 0;
@@ -1398,7 +1398,7 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
+	 * This ensures that uprobe_copy_from_page(), copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
@@ -2394,7 +2394,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */
-- 
2.50.0


