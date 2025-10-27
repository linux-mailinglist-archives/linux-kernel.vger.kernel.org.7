Return-Path: <linux-kernel+bounces-871339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E78C0CF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67DFE34C917
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F428A1E6;
	Mon, 27 Oct 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="aKip5H3V"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD6226D14
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561148; cv=none; b=VGUFeoBs8ECvMslcnlmhqZ7Ymuw53rCTWMKA/M9USPx5K0O6llLHZSqFFWLI1tbcVe7jolQkIj80nm/PuiogvogsmA3CSBJIUW/CwMHfY38NmZmhOXZTqbQA5ApjE/Fpk/HeDiykqDrKCsfw4NCbqgXIZr8pEio4j8FjDJklRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561148; c=relaxed/simple;
	bh=L2IzAn4ESmWJ/Va8+/7dlmBGOTw1hw0qVf7Aqztrinw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5zJP0C06jmVSTpMf+cxpx8WLRhkQoGqmVRu7RBZ+9LqR8lWQ2xqD3LCoRErswzoURAw/YjSstoFDgYe80ef6QG5JQWem464LaQBQqsoujgO/zKOe9CKdiS9s+YhOMJTFgCa2l0v0H4Mr+1yWgr2eXkK5WIMMDRL8TPZK7s2L8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=aKip5H3V; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1761560725; bh=kizbgZvklvMXOG6pO1Ki/BcFsT/5S5oMvzZSn/JC6xw=;
	h=From:Message-Id:From;
	b=aKip5H3V4LqCKpDGWIxdTth3Z47o8/u4GwxpTMjscd1fx+Vu+QJhaJrWxXXR8JAk5
	 YTkQl+CNmpcHhnxPrLNjMFXboOpR9zkiLli8Bd6jjzzQiE/6BVuBJEEE+qgODSMcPL
	 Ta04WIhntyLKVVPlsoGnF60Q3O2iEzJIcBOTJlI0=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 4F673C0952;
	Mon, 27 Oct 2025 11:25:25 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Thomas Weissschuh <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH] tools/nolibc: x86: fix section mismatch caused by asm "mem*" functions
Date: Mon, 27 Oct 2025 11:24:57 +0100
Message-Id: <20251027102457.11280-1-w@1wt.eu>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I recently got occasional build failures at -Os or -Oz that would always
involve waitpid(), where the assembler would complain about this:

   init.s: Error: .size expression for waitpid.constprop.0 does not evaluate to a constant

And without -fno-asynchronous-unwind-tables it could also spit such
errors:

  init.s:836: Error: CFI instruction used without previous .cfi_startproc
  init.s:838: Error: .cfi_endproc without corresponding .cfi_startproc
  init.s: Error: open CFI at the end of file; missing .cfi_endproc directive

A trimmed down reproducer is as simple as this:

  int main(int argc, char **argv)
  {
        int ret, status;

        if (argc == 0)
                ret = waitpid(-1, &status, 0);
        else
                ret = waitpid(-1, &status, 0);

        return status;
  }

It produces the following asm code on x86_64:

        .text
  .section .text.nolibc_memmove_memcpy
  .weak memmove
  .weak memcpy
  memmove:
  memcpy:
        movq %rdx, %rcx
	(...)
        retq
  .section .text.nolibc_memset
  .weak memset
  memset:
        xchgl %eax, %esi
        movq  %rdx, %rcx
        pushq %rdi
        rep stosb
        popq  %rax
        retq

        .type	waitpid.constprop.0.isra.0, @function
  waitpid.constprop.0.isra.0:
        subq	$8, %rsp
        (...)
        jmp	*.L5(,%rax,8)
        .section	.rodata
        .align 8
        .align 4
  .L5:
        .quad	.L10
        (...)
        .quad	.L4
        .text
  .L10:
        (...)
        .cfi_def_cfa_offset 8
        ret
        .cfi_endproc
  .LFE273:
        .size	waitpid.constprop.0.isra.0, .-waitpid.constprop.0.isra.0

It's a bit dense, but here's the explanation: the compiler has emitted a
".text" statement because it knows it's working in the .text section.

Then, our hand-written asm code for the mem* functions forced the section
to .text.something without the compiler knowing about it, so it thinks
the code is still being emitted for .text. As such, without any .section
statement, the waitpid.constprop.0.isra.0 label is in fact placed in the
previously created section, here .text.nolibc_memset.

The waitpid() function involves a switch/case statement that can be
turned to a jump table, which is what the compiler does with the .rodata
section, and after that it restores .text, which is no longer the
previous .text.nolibc_memset section. Then the CFI statements cross a
section, so does the .size calculation, which explains the error.

While a first approach consisting in placing an explicit ".text" at the
end of these functions was verified to work, it's still unreliable as
it depends on what the compiler remembers having emitted previously. A
better approach is to replace the ".section" with ".pushsection", and
place a ".popsection" at the end, so that these code blocks are agnostic
to where they're placed relative to other blocks.

Fixes: 553845eebd60 ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")
Fixes: 12108aa8c1a1 ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-x86.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/arch-x86.h b/tools/include/nolibc/arch-x86.h
index d3efc0c3b8ad..c8b0c3e624a5 100644
--- a/tools/include/nolibc/arch-x86.h
+++ b/tools/include/nolibc/arch-x86.h
@@ -351,7 +351,7 @@ void *memcpy(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 
 __asm__ (
-".section .text.nolibc_memmove_memcpy\n"
+".pushsection .text.nolibc_memmove_memcpy\n"
 ".weak memmove\n"
 ".weak memcpy\n"
 "memmove:\n"
@@ -371,8 +371,9 @@ __asm__ (
 	"rep movsb\n\t"
 	"cld\n\t"
 	"retq\n"
+".popsection\n"
 
-".section .text.nolibc_memset\n"
+".pushsection .text.nolibc_memset\n"
 ".weak memset\n"
 "memset:\n"
 	"xchgl %eax, %esi\n\t"
@@ -381,6 +382,7 @@ __asm__ (
 	"rep stosb\n\t"
 	"popq  %rax\n\t"
 	"retq\n"
+".popsection\n"
 );
 
 #endif /* !defined(__x86_64__) */
-- 
2.35.3


