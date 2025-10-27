Return-Path: <linux-kernel+bounces-872509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FEC115B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9C1C4F8ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A7328B46;
	Mon, 27 Oct 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+as1HHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75C324B0B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595990; cv=none; b=GF+ssiq7OpXXfySuT+evDp+2VarP/DSdss6nkmSYmlwFlpKwFZ14lavMX5sMpVkC86j+4CsKf+unC/wa8cgXcxdOP2XVLPIPot2qJlIMRiZ+JQR7L0LWhNCC1qAZSSS0L3v8iCD/sOyyxrdVWF6uGJMGo6Zv19Baj/N8jGh3uuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595990; c=relaxed/simple;
	bh=91E83ZijfHm0ABFXcEmjFJO6wE4SNSNgOyqdt3N4Qhk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kAX6H6yNs9YPjJ/knxHYMqs1BYxcKdQ1VL6s2uz4KBfPnuYVrelCk3fhsfaOYoxFXZM/+pLLDbCjBgGNJT63rvt9HACqtj/Lw2rGfdvsiSu1rOjr16i/iAtXuea9pc1tFQ78LtVt6KFRL+r0787cMEKUE7G8/r6DLsHT+ua30sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+as1HHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43581C16AAE;
	Mon, 27 Oct 2025 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595990;
	bh=91E83ZijfHm0ABFXcEmjFJO6wE4SNSNgOyqdt3N4Qhk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=e+as1HHm1QC0VY/sCrL7Y7W0gQoDj08xm0WncSSfXuM/MrgsHajXyYRXIccDlJAw0
	 jadWKc/CbCDuT3s7tgnU0ldd+evTRflxs5PSLXpbM9iwFbefG3Nh7Tte4RcvIgqlzf
	 rRYq2ARiXxFxPgGXL3tSbVfbL6bJbhtwr05+Jqzcl8JC6W4DbXfs7oL8sXshjjz2WV
	 jrY1jdmVLXCt1NlszzgVYs/NZFXkA+kR9iMyOMbNMmxNTRzLP12TakqasnnMXYOCar
	 7epLlpp7Usi1mh1ceOZcz2LglANCQj3Lwl+eqJkty0Yy69DHoLcJwAmg2gA0HbTGRT
	 tNIeGhIcPWENQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDTb8-00000004PoX-3xSS;
	Mon, 27 Oct 2025 16:13:46 -0400
Message-ID: <20251027201346.791511994@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 27 Oct 2025 16:13:30 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH 5/5] tracing: Add warnings for unused tracepoints for modules
References: <20251027201325.076180660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a modules has TRACE_EVENT() but does not use it, add a warning about it
at build time.

Currently, the build must be made by adding "UT=1" to the make command
line in order for this to trigger.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/20251022004453.422000794@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/Makefile.modfinal | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 542ba462ed3e..149e12ff5700 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -28,6 +28,10 @@ ccflags-remove-y := $(CC_FLAGS_CFI)
 .module-common.o: $(srctree)/scripts/module-common.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+ifneq ($(WARN_ON_UNUSED_TRACEPOINTS),)
+cmd_check_tracepoint = $(objtree)/scripts/tracepoint-update --module $<;
+endif
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
@@ -57,6 +61,7 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
+	+$(call cmd,check_tracepoint)
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
 
-- 
2.51.0



