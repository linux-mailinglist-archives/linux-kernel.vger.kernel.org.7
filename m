Return-Path: <linux-kernel+bounces-702512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D108AE834E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA85D6A0CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35972690DB;
	Wed, 25 Jun 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KD9Q5YpC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949F265CC2;
	Wed, 25 Jun 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855894; cv=none; b=lv5shVe5bAfmZ9g3jThMiEnp/EjnSGFctoBNnnAnQl/YEYmKR7pbpsT0D+OWX2z711pUeTfZqsgb2Wog68YrsgM5SCFQQf7rhPDkb3BPL4mlE+/FkFMU+bev+Mymipntn9/1OrOSrbwaCmG/Pg8yAY/bGD1bngz6ys6WhWfm0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855894; c=relaxed/simple;
	bh=Y6wMD+f3zIu+lL8OF4jucYTQX8f5E+hJrr2IotIkhTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT+M66vcwk5NV1BRkWL+VYKnIDaChb0uDzsPKNBNcarGIzDnpd1RQt4TXtcxh8nvVWqOwWBW/AtdF9DO3pOlqdf3N2e19HhHSE+a3YrXaWdz4j05GFJTy3MlPzLP9mktSpeq1g0MAGlYvoLmtuLOKClk+bcQoNnDcyByqhdBGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KD9Q5YpC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855892; x=1782391892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6wMD+f3zIu+lL8OF4jucYTQX8f5E+hJrr2IotIkhTA=;
  b=KD9Q5YpCKm/ebIDLb68hT1se9gRoPohYMyx9NqJZEcELTlfsJC7QSts2
   TqGK/ooQmxg4l/sCQChSwJUBmLGNfVikIr78oVWfqmHO4+0o6UOg3c2Ah
   /7dkwSXfwniiBJ0YYR7kCbpctwtxkTnkOCyNuquQpWARLkG7xNOz5AM1Z
   a+PFHw7H+nCpzqta4JjQwrzYwiVQ5ziHK50HtgDBZeuv9mh0yWOIqrsDh
   1T75i+uMkJQmmICQYA+bz4/pbmezuwPLgfSgkIbuEdgSGFnuWOFsvWRuz
   bd+e14qjbNEXlp99avxxx65DUFYXTG8aCrqEtJT1OOgIQ5pf4LoVxVr/z
   Q==;
X-CSE-ConnectionGUID: Jzk8jmPKTSi7dQMGjJMtWA==
X-CSE-MsgGUID: J8mZxeN3Q++ezGq/6g9RoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53189588"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53189588"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:31 -0700
X-CSE-ConnectionGUID: 3aR7eyQdRUyRi6BV08OKxQ==
X-CSE-MsgGUID: 3wHJbqqdSM+g/ULnDyauBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151830973"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 05:51:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E71966BC; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 09/16] x86/vsyscall: Add vsyscall emulation for #GP
Date: Wed, 25 Jun 2025 15:51:02 +0300
Message-ID: <20250625125112.3943745-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

The legacy vsyscall page is mapped at a fixed address in the kernel
address range 0xffffffffff600000-0xffffffffff601000. Prior to LASS being
introduced, a legacy vsyscall page access from userspace would always
generate a page fault. The kernel emulates the execute (XONLY) accesses
in the page fault handler and returns back to userspace with the
appropriate register values.

Since LASS intercepts these accesses before the paging structures are
traversed it generates a general protection fault instead of a page
fault. The #GP fault doesn't provide much information in terms of the
error code. So, use the faulting RIP which is preserved in the user
registers to emulate the vsyscall access without going through complex
instruction decoding.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 14 +++++++++++++-
 arch/x86/include/asm/vsyscall.h       |  6 ++++++
 arch/x86/kernel/traps.c               |  4 ++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 25f94ac5fd35..be77385b311e 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -23,7 +23,7 @@
  * soon be no new userspace code that will ever use a vsyscall.
  *
  * The code in this file emulates vsyscalls when notified of a page
- * fault to a vsyscall address.
+ * fault or a general protection fault to a vsyscall address.
  */
 
 #include <linux/kernel.h>
@@ -278,6 +278,18 @@ bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
 	return false;
 }
 
+bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return false;
+
+	/* Emulate only if the RIP points to the vsyscall address */
+	if (!is_vsyscall_vaddr(regs->ip))
+		return false;
+
+	return __emulate_vsyscall(regs, regs->ip);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index 214977f4fa11..4eb8d3673223 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -16,6 +16,7 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  */
 extern bool emulate_vsyscall_pf(unsigned long error_code,
 				struct pt_regs *regs, unsigned long address);
+extern bool emulate_vsyscall_gp(struct pt_regs *regs);
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall_pf(unsigned long error_code,
@@ -23,6 +24,11 @@ static inline bool emulate_vsyscall_pf(unsigned long error_code,
 {
 	return false;
 }
+
+static inline bool emulate_vsyscall_gp(struct pt_regs *regs)
+{
+	return false;
+}
 #endif
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 10856e0ac46c..40e34bb66d7c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -69,6 +69,7 @@
 #include <asm/tdx.h>
 #include <asm/cfi.h>
 #include <asm/msr.h>
+#include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -817,6 +818,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_umip_exception(regs))
 			goto exit;
 
+		if (emulate_vsyscall_gp(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.47.2


