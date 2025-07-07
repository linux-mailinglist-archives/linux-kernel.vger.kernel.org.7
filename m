Return-Path: <linux-kernel+bounces-719438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E4AFADF9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 10:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D532E1AA0BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA63728A3EF;
	Mon,  7 Jul 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKznEaWz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FC800;
	Mon,  7 Jul 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875413; cv=none; b=C7XmW6AHmrFQnV/w1dnCxldohLYOgLm6MLAwC1W6AmsO5Wk3mZ5SI8z5AV18LYB/Tw/kx/orQPHarYm+/Ngz/nOX9n1R+k25RFl59hdTNob9EKF97fpCr0SK+yw3DOXCwcWDRSh2bSmu239BrGlA2R3xpwa6katpTiwmYADE7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875413; c=relaxed/simple;
	bh=g1usd24mzRnTIn8RaPaizytARVjhWOOMWYiw3ko0c9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cx7fC2qKrtoLJxRELJGqbLoSuNwSGVBTJua89SmdeV98WkX0JSfucfpz3zXGLsWh3zGtVasEQbpR3m4hvbWv4sm1dR4TqHdXiyAtHKCriG3yudTe7gVtaz43hSiWuH1l5krQunMeRv4virpQZHAKuWzkSZuMw8HTp+pblKcDJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKznEaWz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875411; x=1783411411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g1usd24mzRnTIn8RaPaizytARVjhWOOMWYiw3ko0c9w=;
  b=bKznEaWzcYMgoRT2Un5r5ixdwIwRNO/k/wzxlCEelOMxf4yBZeKGZIo5
   ujw8YPfF6kR7UPyKtfJ+ckVgEnfANjeGStZ6IbN72sNfNKSGJYpfshatB
   VQABcDp3I+WFafPdtmgTFffcLfYALuqspVwfPIfsOkV7yxQdTTPY3saGY
   cLtAraoDaTVZMvsJG8Ue0+0xzcBv3paFXOTsSSMCnivF5VYDkdBi+CYe8
   HhUeeZRjcFDWpfr8xgMKVQ36kkKomJ0VfDiqAlqCzzl+0LI5Zqj84gWNm
   +fgkdzOHqm9Rb+2pQ1hnmDOIpU6TPM0N/MUd4TQpkSRlmHSwtemJHEyfQ
   Q==;
X-CSE-ConnectionGUID: WWkoCbj9QTmNDPS854oayw==
X-CSE-MsgGUID: EPMaFhT2Qa2SDL7oPWOl2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53807168"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="53807168"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:30 -0700
X-CSE-ConnectionGUID: vyXTIaloR7aLTzXQqPoEKA==
X-CSE-MsgGUID: +Ex8rCk0Svq8GLwiRF3otQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="160804321"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 07 Jul 2025 01:03:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A0BD01DF; Mon, 07 Jul 2025 11:03:17 +0300 (EEST)
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
Subject: [PATCHv9 02/16] x86/alternatives: Disable LASS when patching kernel alternatives
Date: Mon,  7 Jul 2025 11:03:02 +0300
Message-ID: <20250707080317.3791624-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. See commit 4fc19708b165 ("x86/alternatives:
Initialize temporary mm for patching").

Disable LASS enforcement during patching to avoid triggering a #GP
fault.

The objtool warns due to a call to a non-allowed function that exists
outside of the stac/clac guard, or references to any function with a
dynamic function pointer inside the guard. See the Objtool warnings
section #9 in the document tools/objtool/Documentation/objtool.txt.

Considering that patching is usually small, replace the memcpy() and
memset() functions in the text poking functions with their open coded
versions.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/smap.h   | 33 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/alternative.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..d0cc24348641 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,47 @@
 
 #else /* __ASSEMBLER__ */
 
+/*
+ * The CLAC/STAC instructions toggle the enforcement of X86_FEATURE_SMAP and
+ * X86_FEATURE_LASS.
+ *
+ * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page tables: the
+ * kernel is not allowed to touch pages with the bit set unless the AC bit is
+ * set.
+ *
+ * LASS enforcement is based on bit 63 of the virtual address. The kernel is
+ * not allowed to touch memory in the lower half of the virtual address space
+ * unless the AC bit is set.
+ *
+ * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
+ * regardless of location.
+ *
+ * Use lass_stac()/lass_clac() when accessing kernel mappings (!_PAGE_USER)
+ * in the lower half of the address space.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
 static __always_inline void clac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "clac", X86_FEATURE_SMAP);
 }
 
 static __always_inline void stac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "stac", X86_FEATURE_SMAP);
 }
 
+static __always_inline void lass_clac(void)
+{
+	alternative("", "clac", X86_FEATURE_LASS);
+}
+
+static __always_inline void lass_stac(void)
+{
+	alternative("", "stac", X86_FEATURE_LASS);
+}
+
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ea1d984166cd..992ece0e879a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2447,16 +2447,40 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;
 
+/*
+ * Text poking creates and uses a mapping in the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking
+ * address.
+ */
+
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	lass_stac();
+
+	/*
+	 * Objtool is picky about what occurs within the STAC/CLAC region
+	 * because this code runs with protection disabled. Objtool typically
+	 * does not permit function calls in this area.
+	 *
+	 * Avoid using memcpy() here. Instead, open code it.
+	 */
+	asm volatile("rep movsb"
+		     : "+D" (dst), "+S" (src), "+c" (len) : : "memory");
+
+	lass_clac();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	memset(dst, c, len);
+	lass_stac();
+
+	/* Open code memset(): make objtool happy. See text_poke_memcpy(). */
+	asm volatile("rep stosb"
+		     : "+D" (dst), "+c" (len) : "a" (c) : "memory");
+
+	lass_clac();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
-- 
2.47.2


