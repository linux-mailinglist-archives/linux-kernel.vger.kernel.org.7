Return-Path: <linux-kernel+bounces-872507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8AAC1156A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6681A25F42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E572326D6C;
	Mon, 27 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwh21v7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E91322C60
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595990; cv=none; b=K6ZVHUUm1gCJfELvIny3wWNbXno890eTeqtmkHHVJHsz9VZkvjnhqgnfJrPVS0IQNSL3tZ5StKt+CEepbmFRB+WNmQfI8DaY9innH90r3imkrMjjkt3Ig2r+iEzWiCJ0byGG+3yUitTHxgYkIgJ1++2+pCsfO+V/fLmRHPl1qf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595990; c=relaxed/simple;
	bh=hAANbjJfOO/CeUn4fUduUj9KYluJ1QFV6bSA5XWAAQU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sUImAf36eDTyneEK2zbHS8HUuDo/v6GjTHXFmAlr/ndgeL3S8n4cJ9i20R8TZZ+gEgQbdBeAvHt/BWDdFuix8yVf2HPTiGxFxMWn3T5gx+Gn2BIqY+uHcimDzGEcBIt72EHr7lkdzyh22uUknY1V+nWNegT1wgBpSK66pIw2D98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwh21v7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6AC116D0;
	Mon, 27 Oct 2025 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595990;
	bh=hAANbjJfOO/CeUn4fUduUj9KYluJ1QFV6bSA5XWAAQU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rwh21v7VZov0B153yA4GzAwLi/Un4Y3Gp2c7ts73I5v+i+r3k6kYZ2qTm5JVR0pOD
	 iQT4xaAk0cwId1QNZ19TNDdhdXJ9/tHEn53BhEH7G0kvRWOhr3RatcYAp8Plkv+RSP
	 MRzoJQiQYgeAVKYwPfdEjERE8u/L5I1yYlSStz3yK5cKv4kdhpisjEDUS4tdg0XMwX
	 QBHmWts2YP12y8qFIWMpHjiEFeRzFkbKucRsxbXMApGDtM0MGyHrKsol9noDDWmcq/
	 CRBQe3uSAQmHQ6JmgUokqHBtAvUUJ5uqx9Im1mm2ppBt3j/Ds5C8viigl8T+HLUg2z
	 sqxiG+7HSNIiA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDTb8-00000004Po3-3Eh8;
	Mon, 27 Oct 2025 16:13:46 -0400
Message-ID: <20251027201346.621559530@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 27 Oct 2025 16:13:29 -0400
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
Subject: [for-next][PATCH 4/5] tracing: Allow tracepoint-update.c to work with modules
References: <20251027201325.076180660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order for tracepoint-update.c to work with modules, it cannot error out
if both "__tracepoint_check" and "__tracepoints_strings" are not found.
When enabled, the vmlinux.o may be required to have both, but modules only
have these sections if they have tracepoints. Modules without tracepoints
will not have either. They should not fail to build because of that.

If one section exists the other one should too. Note, if a module defines
a tracepoint but doesn't use any, it can cause this to fail.

Add a new "--module" parameter to tracepoint-update to be used when
running on module code. It will not error out if this is set and both
sections are missing. If this is set, and only the "__tracepoint_check"
section is missing, it means the module has defined tracepoints but none
of them are used. In that case, it prints a warning that the module has
only unused tracepoints and exits normally to not fail the build.

If the "__tracepoint_check" section exists but not the
"__tracepoint_strings", then that is an error and should fail the build.

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
Link: https://lore.kernel.org/20251022004453.255696445@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/tracepoint-update.c | 45 ++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 6ec30f39d0ad..7f7d90df14ce 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -112,7 +112,7 @@ static int find_event(const char *str, void *array, size_t size)
 	return bsearch(&str, array, size, sizeof(char *), compare_strings) != NULL;
 }
 
-static void check_tracepoints(struct elf_tracepoint *etrace)
+static void check_tracepoints(struct elf_tracepoint *etrace, const char *fname)
 {
 	Elf_Ehdr *ehdr = etrace->ehdr;
 	int len;
@@ -129,22 +129,26 @@ static void check_tracepoints(struct elf_tracepoint *etrace)
 		if (!len)
 			continue;
 		if (!find_event(str, etrace->array, etrace->count)) {
-			fprintf(stderr, "warning: tracepoint '%s' is unused.\n", str);
+			fprintf(stderr, "warning: tracepoint '%s' is unused", str);
+			if (fname)
+				fprintf(stderr, " in module %s\n", fname);
+			else
+				fprintf(stderr, "\n");
 		}
 	}
 
 	free(etrace->array);
 }
 
-static void *tracepoint_check(struct elf_tracepoint *etrace)
+static void *tracepoint_check(struct elf_tracepoint *etrace, const char *fname)
 {
 	make_trace_array(etrace);
-	check_tracepoints(etrace);
+	check_tracepoints(etrace, fname);
 
 	return NULL;
 }
 
-static int process_tracepoints(void *addr, char const *const fname)
+static int process_tracepoints(bool mod, void *addr, const char *fname)
 {
 	struct elf_tracepoint etrace = {0};
 	Elf_Ehdr *ehdr = addr;
@@ -188,7 +192,19 @@ static int process_tracepoints(void *addr, char const *const fname)
 		}
 	}
 
+	/*
+	 * Modules may not have either section. But if it has one section,
+	 * it should have both of them.
+	 */
+	if (mod && !check_data_sec && !tracepoint_data_sec)
+		return 0;
+
 	if (!check_data_sec) {
+		if (mod) {
+			fprintf(stderr, "warning: Module %s has only unused tracepoints\n", fname);
+			/* Do not fail build */
+			return 0;
+		}
 		fprintf(stderr,	"no __tracepoint_check in file: %s\n", fname);
 		return -1;
 	}
@@ -198,8 +214,11 @@ static int process_tracepoints(void *addr, char const *const fname)
 		return -1;
 	}
 
+	if (!mod)
+		fname = NULL;
+
 	etrace.ehdr = ehdr;
-	tracepoint_check(&etrace);
+	tracepoint_check(&etrace, fname);
 	return 0;
 }
 
@@ -208,9 +227,19 @@ int main(int argc, char *argv[])
 	int n_error = 0;
 	size_t size = 0;
 	void *addr = NULL;
+	bool mod = false;
+
+	if (argc > 1 && strcmp(argv[1], "--module") == 0) {
+		mod = true;
+		argc--;
+		argv++;
+	}
 
 	if (argc < 2) {
-		fprintf(stderr, "usage: tracepoint-update vmlinux...\n");
+		if (mod)
+			fprintf(stderr, "usage: tracepoint-update --module module...\n");
+		else
+			fprintf(stderr, "usage: tracepoint-update vmlinux...\n");
 		return 0;
 	}
 
@@ -222,7 +251,7 @@ int main(int argc, char *argv[])
 			continue;
 		}
 
-		if (process_tracepoints(addr, argv[i]))
+		if (process_tracepoints(mod, addr, argv[i]))
 			++n_error;
 
 		elf_unmap(addr, size);
-- 
2.51.0



