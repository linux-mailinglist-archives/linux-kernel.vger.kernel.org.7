Return-Path: <linux-kernel+bounces-872508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63072C11570
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2A1A26124
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24B0328618;
	Mon, 27 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDZExIWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F13322DD6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595990; cv=none; b=ddB+4X0s/ZFJ89fx9F2gn3hQ9Zm4CDMD5AIfQhrKW9bFjK/FS4ri3rhX/mdOoRdsL2Czr0GpfPCpIP7OD0MV3zu9kjVbZvCoyzJy5TuF8FvT+sky2Vb6ycGmfZYuDZcCjLHDw517z1j7bUHL8VH7XKqoU++06c/pgdhx8uE8Opk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595990; c=relaxed/simple;
	bh=2zOi1mLRqdjzyiBeVVKQK59r3iiSd/fIMgnPAEKsCtg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JhaviFeBG9SgoVxDEGn5XYGwT3mGL0xaiiPDA1nzkKEsqgd0acVHwCoiTLb0HquX7OuP5dmn147+xKF8da4uV69/QNvKa4+2F0zuL4C6iY+YhxTUo67XUfeeN8u7VMdMV4vhSr9sI/UbAHhvC9j9uhaXSaRFDWa0EfvACNzO5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDZExIWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02D2C4CEF1;
	Mon, 27 Oct 2025 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595990;
	bh=2zOi1mLRqdjzyiBeVVKQK59r3iiSd/fIMgnPAEKsCtg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=EDZExIWktq2Pm1pGdRPg9hr4x0x9+wQaxVj8KOoqRTfCgk22jo9czUwkMPP+CM17F
	 +X1Y6gDmjvlA165UeJooBxuMNi7dzYPoE18zccAxa7b4n03GD9P9H4jxdpdYOfWNvZ
	 /BRl9ToSrlhuqqFd6Mm1i4C+tZZ9FXRqh7MK/x+85XL8p1K5O3l2qcyuhmJNO4NqsS
	 iq3qj3swFedJSJUv3nFGidNgc2zXkVycZffFDxr/dJCo4WZ3ZktAn/a77/iWOerqsF
	 YTcF7/WXiamOSsTYYQwVDTJ8I1u+CpQeWhKXJj7UDrFnV/Nkh8OU4aN+wWapcFZSl+
	 ejuoAqIcxRmcw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDTb8-00000004Pn4-1p7M;
	Mon, 27 Oct 2025 16:13:46 -0400
Message-ID: <20251027201346.290440153@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 27 Oct 2025 16:13:27 -0400
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
Subject: [for-next][PATCH 2/5] tracing: Add a tracepoint verification check at build time
References: <20251027201325.076180660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a tracepoint is defined via DECLARE_TRACE() or TRACE_EVENT() but never
called (via the trace_<tracepoint>() function), its metadata is still
around in memory and not discarded.

When created via TRACE_EVENT() the situation is worse because the
TRACE_EVENT() creates metadata that can be around 5k per trace event.
Having unused trace events causes several thousand of wasted bytes.

Add a verifier that injects a string of the name of the tracepoint it
calls that is added to the discarded section "__tracepoint_check".
For every builtin tracepoint, its name (which is saved in the in-memory
section "__tracepoint_strings") will have its name also in the
"__tracepoint_check" section if it is used.

Add a new program that is run on build called tracepoint-update. This is
executed on the vmlinux.o before the __tracepoint_check section is
discarded (the section is discarded before vmlinux is created). This
program will create an array of each string in the __tracepoint_check
section and then sort it. Then it will walk the strings in the
__tracepoint_strings section and do a binary search to check if its name
is in the __tracepoint_check section. If it is not, then it is unused and
a warning is printed.

Note, this currently only handles tracepoints that are builtin and not in
modules.

Enabling this currently with a given config produces:

warning: tracepoint 'sched_move_numa' is unused.
warning: tracepoint 'sched_stick_numa' is unused.
warning: tracepoint 'sched_swap_numa' is unused.
warning: tracepoint 'pelt_hw_tp' is unused.
warning: tracepoint 'pelt_irq_tp' is unused.
warning: tracepoint 'rcu_preempt_task' is unused.
warning: tracepoint 'rcu_unlock_preempted_task' is unused.
warning: tracepoint 'xdp_bulk_tx' is unused.
warning: tracepoint 'xdp_redirect_map' is unused.
warning: tracepoint 'xdp_redirect_map_err' is unused.
warning: tracepoint 'vma_mas_szero' is unused.
warning: tracepoint 'vma_store' is unused.
warning: tracepoint 'hugepage_set_pmd' is unused.
warning: tracepoint 'hugepage_set_pud' is unused.
warning: tracepoint 'hugepage_update_pmd' is unused.
warning: tracepoint 'hugepage_update_pud' is unused.
warning: tracepoint 'block_rq_remap' is unused.
warning: tracepoint 'xhci_dbc_handle_event' is unused.
warning: tracepoint 'xhci_dbc_handle_transfer' is unused.
warning: tracepoint 'xhci_dbc_gadget_ep_queue' is unused.
warning: tracepoint 'xhci_dbc_alloc_request' is unused.
warning: tracepoint 'xhci_dbc_free_request' is unused.
warning: tracepoint 'xhci_dbc_queue_request' is unused.
warning: tracepoint 'xhci_dbc_giveback_request' is unused.
warning: tracepoint 'tcp_ao_wrong_maclen' is unused.
warning: tracepoint 'tcp_ao_mismatch' is unused.
warning: tracepoint 'tcp_ao_key_not_found' is unused.
warning: tracepoint 'tcp_ao_rnext_request' is unused.
warning: tracepoint 'tcp_ao_synack_no_key' is unused.
warning: tracepoint 'tcp_ao_snd_sne_update' is unused.
warning: tracepoint 'tcp_ao_rcv_sne_update' is unused.

Some of the above is totally unused but others are not used due to their
"trace_" functions being inside configs, in which case, the defined
tracepoints should also be inside those same configs. Others are
architecture specific but defined in generic code, where they should
either be moved to the architecture or be surrounded by #ifdef for the
architectures they are for.

This tool could be updated to process modules in the future.

I'd like to thank Mathieu Desnoyers for suggesting using strings instead
of pointers, as using pointers in vmlinux.o required handling relocations
and it required implementing almost a full feature linker to do so.

To enable this check, run the build with: make UT=1

Note, when all the existing unused tracepoints are removed from the build,
the "UT=1" will be removed and this will always be enabled when
tracepoints are configured to warn on any new tracepoints. The reason this
isn't always enabled now is because it will introduce a lot of warnings
for the current unused tracepoints, and all bisects would end at this
commit for those warnings.

Link: https://lore.kernel.org/all/20250528114549.4d8a5e03@gandalf.local.home/

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
Link: https://lore.kernel.org/20251022004452.920728129@kernel.org
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> # for using strings instead of pointers
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Makefile                          |  21 +++
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/tracepoint.h        |  11 ++
 scripts/Makefile                  |   3 +
 scripts/link-vmlinux.sh           |   7 +
 scripts/tracepoint-update.c       | 232 ++++++++++++++++++++++++++++++
 6 files changed, 275 insertions(+)
 create mode 100644 scripts/tracepoint-update.c

diff --git a/Makefile b/Makefile
index d14824792227..9823c20c4278 100644
--- a/Makefile
+++ b/Makefile
@@ -810,6 +810,25 @@ ifdef CONFIG_FUNCTION_TRACER
   CC_FLAGS_FTRACE := -pg
 endif
 
+ifdef CONFIG_TRACEPOINTS
+# To check for unused tracepoints (tracepoints that are defined but never
+# called), run with:
+#
+# make UT=1
+#
+# Each unused tracepoints can take up to 5KB of memory in the running kernel.
+# It is best to remove any that are not used.
+#
+# This command line option will be removed when all current unused
+# tracepoints are removed.
+
+ifeq ("$(origin UT)", "command line")
+  WARN_ON_UNUSED_TRACEPOINTS := $(UT)
+endif
+endif # CONFIG_TRACEPOINTS
+
+export WARN_ON_UNUSED_TRACEPOINTS
+
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifdef need-config
@@ -1772,6 +1791,8 @@ help:
 	@echo  '		c: extra checks in the configuration stage (Kconfig)'
 	@echo  '		e: warnings are being treated as errors'
 	@echo  '		Multiple levels can be combined with W=12 or W=123'
+	@echo  '  make UT=1   [targets] Warn if a tracepoint is defined but not used.'
+	@echo  '          [ This will be removed when all current unused tracepoints are eliminated. ]'
 	@$(if $(dtstree), \
 		echo '  make CHECK_DTBS=1 [targets] Check all generated dtb files against schema'; \
 		echo '         This can be applied both to "dtbs" and to individual "foo.dtb" targets' ; \
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8a9a2e732a65..c510fb097a8c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1048,6 +1048,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	*(.no_trim_symbol)						\
 	/* ld.bfd warns about .gnu.version* even when not emitted */	\
 	*(.gnu.version*)						\
+	*(__tracepoint_check)						\
 
 #define DISCARDS							\
 	/DISCARD/ : {							\
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..1e53d3626c78 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -221,6 +221,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		__do_trace_##name(args);				\
 	}
 
+/*
+ * When a tracepoint is used, it's name is added to the __tracepoint_check
+ * section. This section is only used at build time to make sure all
+ * defined tracepoints are used. It is discarded after the build.
+ */
+# define TRACEPOINT_CHECK(name)						\
+	static const char __used __section("__tracepoint_check") __trace_check[] = \
+		#name;
+
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -270,6 +279,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
+		TRACEPOINT_CHECK(name)					\
 		if (cond) {						\
 			guard(preempt_notrace)();			\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
@@ -289,6 +299,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
+		TRACEPOINT_CHECK(name)					\
 		guard(rcu_tasks_trace)();				\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 	}								\
diff --git a/scripts/Makefile b/scripts/Makefile
index f19624b3ed92..0941e5ce7b57 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -11,8 +11,10 @@ hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
+hostprogs-always-$(CONFIG_TRACEPOINTS)			+= tracepoint-update
 
 sorttable-objs := sorttable.o elf-parse.o
+tracepoint-update-objs := tracepoint-update.o elf-parse.o
 
 ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 always-$(CONFIG_RUST)					+= target.json
@@ -27,6 +29,7 @@ generate_rust_target-rust := y
 rustdoc_test_builder-rust := y
 rustdoc_test_gen-rust := y
 
+HOSTCFLAGS_tracepoint-update.o = -I$(srctree)/tools/include
 HOSTCFLAGS_elf-parse.o = -I$(srctree)/tools/include
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849ff7529..d304029fa6da 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -208,6 +208,13 @@ kallsymso=
 strip_debug=
 generate_map=
 
+# Use "make UT=1" to trigger warnings on unused tracepoints
+case "${WARN_ON_UNUSED_TRACEPOINTS}" in
+*1*)
+	${objtree}/scripts/tracepoint-update vmlinux.o
+	;;
+esac
+
 if is_enabled CONFIG_KALLSYMS; then
 	true > .tmp_vmlinux0.syms
 	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
new file mode 100644
index 000000000000..6ec30f39d0ad
--- /dev/null
+++ b/scripts/tracepoint-update.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <getopt.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <pthread.h>
+
+#include "elf-parse.h"
+
+static Elf_Shdr *check_data_sec;
+static Elf_Shdr *tracepoint_data_sec;
+
+static inline void *get_index(void *start, int entsize, int index)
+{
+	return start + (entsize * index);
+}
+
+static int compare_strings(const void *a, const void *b)
+{
+	const char *av = *(const char **)a;
+	const char *bv = *(const char **)b;
+
+	return strcmp(av, bv);
+}
+
+struct elf_tracepoint {
+	Elf_Ehdr *ehdr;
+	const char **array;
+	int count;
+};
+
+#define REALLOC_SIZE (1 << 10)
+#define REALLOC_MASK (REALLOC_SIZE - 1)
+
+static int add_string(const char *str, const char ***vals, int *count)
+{
+	const char **array = *vals;
+
+	if (!(*count & REALLOC_MASK)) {
+		int size = (*count) + REALLOC_SIZE;
+
+		array = realloc(array, sizeof(char *) * size);
+		if (!array) {
+			fprintf(stderr, "Failed memory allocation\n");
+			return -1;
+		}
+		*vals = array;
+	}
+
+	array[(*count)++] = str;
+	return 0;
+}
+
+/**
+ * for_each_shdr_str - iterator that reads strings that are in an ELF section.
+ * @len: "int" to hold the length of the current string
+ * @ehdr: A pointer to the ehdr of the ELF file
+ * @sec: The section that has the strings to iterate on
+ *
+ * This is a for loop that iterates over all the nul terminated strings
+ * that are in a given ELF section. The variable "str" will hold
+ * the current string for each iteration and the passed in @len will
+ * contain the strlen() of that string.
+ */
+#define for_each_shdr_str(len, ehdr, sec)				\
+	for (const char *str = (void *)(ehdr) + shdr_offset(sec),	\
+			*end = str + shdr_size(sec);			\
+	     len = strlen(str), str < end;				\
+	     str += (len) + 1)
+
+
+static void make_trace_array(struct elf_tracepoint *etrace)
+{
+	Elf_Ehdr *ehdr = etrace->ehdr;
+	const char **vals = NULL;
+	int count = 0;
+	int len;
+
+	etrace->array = NULL;
+
+	/*
+	 * The __tracepoint_check section is filled with strings of the
+	 * names of tracepoints (in tracepoint_strings). Create an array
+	 * that points to each string and then sort the array.
+	 */
+	for_each_shdr_str(len, ehdr, check_data_sec) {
+		if (!len)
+			continue;
+		if (add_string(str, &vals, &count) < 0)
+			return;
+	}
+
+	/* If CONFIG_TRACEPOINT_VERIFY_USED is not set, there's nothing to do */
+	if (!count)
+		return;
+
+	qsort(vals, count, sizeof(char *), compare_strings);
+
+	etrace->array = vals;
+	etrace->count = count;
+}
+
+static int find_event(const char *str, void *array, size_t size)
+{
+	return bsearch(&str, array, size, sizeof(char *), compare_strings) != NULL;
+}
+
+static void check_tracepoints(struct elf_tracepoint *etrace)
+{
+	Elf_Ehdr *ehdr = etrace->ehdr;
+	int len;
+
+	if (!etrace->array)
+		return;
+
+	/*
+	 * The __tracepoints_strings section holds all the names of the
+	 * defined tracepoints. If any of them are not in the
+	 * __tracepoint_check_section it means they are not used.
+	 */
+	for_each_shdr_str(len, ehdr, tracepoint_data_sec) {
+		if (!len)
+			continue;
+		if (!find_event(str, etrace->array, etrace->count)) {
+			fprintf(stderr, "warning: tracepoint '%s' is unused.\n", str);
+		}
+	}
+
+	free(etrace->array);
+}
+
+static void *tracepoint_check(struct elf_tracepoint *etrace)
+{
+	make_trace_array(etrace);
+	check_tracepoints(etrace);
+
+	return NULL;
+}
+
+static int process_tracepoints(void *addr, char const *const fname)
+{
+	struct elf_tracepoint etrace = {0};
+	Elf_Ehdr *ehdr = addr;
+	Elf_Shdr *shdr_start;
+	Elf_Shdr *string_sec;
+	const char *secstrings;
+	unsigned int shnum;
+	unsigned int shstrndx;
+	int shentsize;
+	int idx;
+	int done = 2;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	shstrndx = ehdr_shstrndx(ehdr);
+	if (shstrndx == SHN_XINDEX)
+		shstrndx = shdr_link(shdr_start);
+	string_sec = get_index(shdr_start, shentsize, shstrndx);
+	secstrings = (const char *)ehdr + shdr_offset(string_sec);
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	for (int i = 0; done && i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+
+		idx = shdr_name(shdr);
+
+		/* locate the __tracepoint_check in vmlinux */
+		if (!strcmp(secstrings + idx, "__tracepoint_check")) {
+			check_data_sec = shdr;
+			done--;
+		}
+
+		/* locate the __tracepoints_ptrs section in vmlinux */
+		if (!strcmp(secstrings + idx, "__tracepoints_strings")) {
+			tracepoint_data_sec = shdr;
+			done--;
+		}
+	}
+
+	if (!check_data_sec) {
+		fprintf(stderr,	"no __tracepoint_check in file: %s\n", fname);
+		return -1;
+	}
+
+	if (!tracepoint_data_sec) {
+		fprintf(stderr,	"no __tracepoint_strings in file: %s\n", fname);
+		return -1;
+	}
+
+	etrace.ehdr = ehdr;
+	tracepoint_check(&etrace);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int n_error = 0;
+	size_t size = 0;
+	void *addr = NULL;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: tracepoint-update vmlinux...\n");
+		return 0;
+	}
+
+	/* Process each file in turn, allowing deep failure. */
+	for (int i = 1; i < argc; i++) {
+		addr = elf_map(argv[i], &size, 1 << ET_REL);
+		if (!addr) {
+			++n_error;
+			continue;
+		}
+
+		if (process_tracepoints(addr, argv[i]))
+			++n_error;
+
+		elf_unmap(addr, size);
+	}
+
+	return !!n_error;
+}
-- 
2.51.0



