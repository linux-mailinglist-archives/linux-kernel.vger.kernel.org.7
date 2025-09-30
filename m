Return-Path: <linux-kernel+bounces-837683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F242BACF04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8F2188E4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18D42FD1DD;
	Tue, 30 Sep 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YgP4wE0q"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972B2AE90;
	Tue, 30 Sep 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236729; cv=none; b=jkEfi/J3RQV5PDoCu9ZOGJf5f+IBGeB3m/mwM/gPCqWJX+BWEs83crZIkG5k4H2xk78VaoW2+TTIO06ksXR00BNzXnw2oYuxgv1oUwiWx7jCkI8+lHcFW/1lP1aCTSoSIPKIusKNtMMoF9rhWuhA7SK2HO7CbQCeAaqEiXYj5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236729; c=relaxed/simple;
	bh=NBzs5D4uuWJUjPCHsfP6knc6Q/gyHDcuVmc8t+peMmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzgsySyQoaMUF3Zss9YToOicMX5ojob/UAfRUgOg9gG0GHzcSeYGrvkiB1bY8zyIwCJyZlocvalVtOPkDIL1mdg8T0Kkm5cCiOzhbHPNKTJvCl0n3bf1vSvzuIu2w/tDHcVp/NpiRkEETk4GA/cyH9GaEKRZFd898IAVjX5mzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YgP4wE0q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1J//rl64lw04ODF0oGXCCZsjqrxoJKz9lbEG9Hm9I+U=; b=YgP4wE0qqX3ifnlrg0BFrYJAtL
	mGbxN4ktg1xjYBoNO1aJrnzkLQlbIAvQgOUiafQ1I1Wk7iHbx2b/FlwfXd/cl3QQ3rnHkVZWRVXqU
	UzrY1LIsIND+2QuSXVXyU8hzmEpZcm+e5lWCv+Jegj4oMWxT4i1b9+tIvjQikOp2FVJnCUn8gjvEg
	/oHf0R71xww7cSPJbGLxbctdozyPj3w10zaC2JxXPE9hIpjiWelxegtIFKGK7neJNOxT9fvrQKDmL
	ycLwMA+/Y17U8NPGGUc8sobLLnZVb64iN9e+wO+gmBaApkpCxG3h6NWoyD3ZfmwtAufavR357hQgl
	VShkrpLA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Zpl-0000000Cq3s-2JQ3;
	Tue, 30 Sep 2025 12:51:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A26F300220; Tue, 30 Sep 2025 14:51:56 +0200 (CEST)
Date: Tue, 30 Sep 2025 14:51:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
Message-ID: <20250930125156.GK1386988@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <20250930085044.GK3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930085044.GK3245006@noisy.programming.kicks-ass.net>

On Tue, Sep 30, 2025 at 10:50:44AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 30, 2025 at 10:46:23AM +0200, Jürgen Groß wrote:

> > > 	asm_inline volatile goto(
> > > 		"1:\n"
> > > 		ALTERNATIVE(PREPARE_RCX_RDX_FOR_WRMSR
> > > 			    "2:\n"
> > > 			    ALTERNATIVE("ds wrmsr",
> > > 			                ASM_WRMSRNS, X86_FEATURE_WRMSRNS),
> > > 			    ASM_WRMSRNS_IMM, X86_FEATURE_MSR_IMM);
> > > 		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immediate */
> > > 		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */
> > > 
> > > 		:
> > > 		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
> > > 		: "memory", "ecx", "rdx"
> > > 		: badmsr);
> > > 

> Oh well, lets forget about this :-)

So I couldn't. I tried the below, which when building a .i generates the
following:


static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((no_instrument_function)) void clear_page(void *page)
{

 kmsan_unpoison_memory(page, ((1UL) << 12));
 asm __inline volatile(
 	"# ALT: oldinstr\n"
	"__UNIQUE_ID_altinstr_9" "_begin:\n\t" 

		"# ALT: oldinstr\n"
		"__UNIQUE_ID_altinstr_8" "_begin:\n\t"
		"call %c[old]" "\n"
		"__UNIQUE_ID_altinstr_8" "_pad:\n"
		"# ALT: padding\n"
		".skip -(((" "__UNIQUE_ID_altinstr_8" "_alt_end - " "__UNIQUE_ID_altinstr_8" "_alt_begin" ")-(" "__UNIQUE_ID_altinstr_8" "_pad - " "__UNIQUE_ID_altinstr_8" "_begin" ")) > 0) * " 
		"((" "__UNIQUE_ID_altinstr_8" "_alt_end - " "__UNIQUE_ID_altinstr_8" "_alt_begin" ")-(" "__UNIQUE_ID_altinstr_8" "_pad - " "__UNIQUE_ID_altinstr_8" "_begin" ")),0x90\n" 
		"__UNIQUE_ID_altinstr_8" "_end:\n"
		".pushsection .altinstructions,\"a\"\n"
		" .long " "__UNIQUE_ID_altinstr_8" "_begin - .\n"
		" .long " "__UNIQUE_ID_altinstr_8" "_alt_begin - .\n" 
		" .4byte " "( 3*32+16)" "\n" 
		" .byte " "__UNIQUE_ID_altinstr_8" "_end - " "__UNIQUE_ID_altinstr_8" "_begin" "\n" 
		" .byte " "__UNIQUE_ID_altinstr_8" "_alt_end - " "__UNIQUE_ID_altinstr_8" "_alt_begin" "\n" 
		".popsection\n" 
		".pushsection .altinstr_replacement, \"ax\"\n" 
		"# ALT: replacement\n" 
		"__UNIQUE_ID_altinstr_8" "_alt_begin:\n\t" 
		"call %c[new1]" "\n" 
		"__UNIQUE_ID_altinstr_8" "_alt_end:\n" 
		".popsection\n"
		"\n" 

	"__UNIQUE_ID_altinstr_9" "_pad:\n" 
	"# ALT: padding\n" 
	".skip -(((" "__UNIQUE_ID_altinstr_9" "_alt_end - " "__UNIQUE_ID_altinstr_9" "_alt_begin" ")-(" "__UNIQUE_ID_altinstr_9" "_pad - " "__UNIQUE_ID_altinstr_9" "_begin" ")) > 0) * "
	"((" "__UNIQUE_ID_altinstr_9" "_alt_end - " "__UNIQUE_ID_altinstr_9" "_alt_begin" ")-(" "__UNIQUE_ID_altinstr_9" "_pad - " "__UNIQUE_ID_altinstr_9" "_begin" ")),0x90\n" 
	"__UNIQUE_ID_altinstr_9" "_end:\n" 
	".pushsection .altinstructions,\"a\"\n" 
	" .long " "__UNIQUE_ID_altinstr_9" "_begin - .\n"
	" .long " "__UNIQUE_ID_altinstr_9" "_alt_begin - .\n" 
	" .4byte " "( 9*32+ 9)" "\n" 
	" .byte " "__UNIQUE_ID_altinstr_9" "_end - " "__UNIQUE_ID_altinstr_9" "_begin" "\n"
	" .byte " "__UNIQUE_ID_altinstr_9" "_alt_end - " "__UNIQUE_ID_altinstr_9" "_alt_begin" "\n"
	".popsection\n" 
	".pushsection .altinstr_replacement, \"ax\"\n" 
	"# ALT: replacement\n" 
	"__UNIQUE_ID_altinstr_9" "_alt_begin:\n\t" 
	"call %c[new2]" "\n" 
	"__UNIQUE_ID_altinstr_9" "_alt_end:\n" 
	".popsection\n" 
	: "+r" (current_stack_pointer), "=D" (page) 
	: [old] "i" (clear_page_orig), [new1] "i" (clear_page_rep), [new2] "i" (clear_page_erms) , "D" (page) 
	: "cc", "memory", "rax", "rcx")

                                   ;
}

Which looks right, but utterly fails to build :(


diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 15bc07a5ebb3..12a93982457a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stringify.h>
 #include <linux/objtool.h>
+#include <linux/compiler.h>
 #include <asm/asm.h>
 #include <asm/bug.h>
 
@@ -184,38 +185,41 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALT_CALL_INSTR		"call BUG_func"
 
-#define alt_slen		"772b-771b"
-#define alt_total_slen		"773b-771b"
-#define alt_rlen		"775f-774f"
+#define alt_slen(pfx)		#pfx "_pad - " #pfx "_begin"
+#define alt_total_slen(pfx)	#pfx "_end - " #pfx "_begin"
+#define alt_rlen(pfx)		#pfx "_alt_end - " #pfx "_alt_begin"
 
-#define OLDINSTR(oldinstr)						\
+#define OLDINSTR(oldinstr, pfx)						\
 	"# ALT: oldinstr\n"						\
-	"771:\n\t" oldinstr "\n772:\n"					\
+	#pfx "_begin:\n\t" oldinstr "\n" #pfx "_pad:\n"			\
 	"# ALT: padding\n"						\
-	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
-	"773:\n"
+	".skip -(((" alt_rlen(pfx) ")-(" alt_slen(pfx) ")) > 0) * "	\
+		"((" alt_rlen(pfx) ")-(" alt_slen(pfx) ")),0x90\n"	\
+	#pfx "_end:\n"
 
-#define ALTINSTR_ENTRY(ft_flags)					      \
+#define ALTINSTR_ENTRY(ft_flags, pfx)					      \
 	".pushsection .altinstructions,\"a\"\n"				      \
-	" .long 771b - .\n"				/* label           */ \
-	" .long 774f - .\n"				/* new instruction */ \
+	" .long " #pfx "_begin - .\n"			/* label           */ \
+	" .long " #pfx "_alt_begin - .\n"			/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
-	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen "\n"				/* replacement len */ \
+	" .byte " alt_total_slen(pfx) "\n"		/* source len      */ \
+	" .byte " alt_rlen(pfx) "\n"			/* replacement len */ \
 	".popsection\n"
 
-#define ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
+#define ALTINSTR_REPLACEMENT(newinstr, pfx)	/* replacement */	\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	"# ALT: replacement\n"						\
-	"774:\n\t" newinstr "\n775:\n"					\
+	#pfx "_alt_begin:\n\t" newinstr "\n" #pfx "_alt_end:\n"			\
 	".popsection\n"
 
 /* alternative assembly primitive: */
-#define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	OLDINSTR(oldinstr)						\
-	ALTINSTR_ENTRY(ft_flags)					\
-	ALTINSTR_REPLACEMENT(newinstr)
+#define __ALTERNATIVE(oldinstr, newinstr, ft_flags, pfx)		\
+	OLDINSTR(oldinstr, pfx)						\
+	ALTINSTR_ENTRY(ft_flags, pfx)					\
+	ALTINSTR_REPLACEMENT(newinstr, pfx)
+
+#define ALTERNATIVE(oldinstr, newinstr, feat)				\
+	__ALTERNATIVE(oldinstr, newinstr, feat, __UNIQUE_ID(altinstr))
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	ALTERNATIVE(ALTERNATIVE(oldinstr, newinstr1, ft_flags1), newinstr2, ft_flags2)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 64ff73c533e5..d79552a61fda 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -163,7 +163,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
+#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__PASTE(__UNIQUE_ID_, prefix), _), __COUNTER__)
 
 /**
  * data_race - mark an expression as containing intentional data races

