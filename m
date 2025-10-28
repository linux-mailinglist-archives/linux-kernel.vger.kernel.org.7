Return-Path: <linux-kernel+bounces-872807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B422EC1215D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329EF4607DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FC32E68C;
	Mon, 27 Oct 2025 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwIypBY8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32E313E36;
	Mon, 27 Oct 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608604; cv=none; b=ofQSMoaFO7b+4QQjvtoS4KJmpo9W1J4xmiWQhTiU/N15dOBZVKSET8/Z390B2Y3Qsw33RtfVxY7eOdUr8+ptccxe9gyLL/aCQzpQsuVBoFmuhyk24Q0DxKA32sN8JtSpToSCq7kDy4xe/BTXSOvslZE39MOmGHTkMMgrBONGf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608604; c=relaxed/simple;
	bh=pDGPXjJuojOtoV9Jg7lMss0iLOqplPaCMXHqoKdeXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojtdZWUhu5ZDx0ukbkkQH0vC7CQgzp3wnwd4cssvkIJUg7oszT5IhjgoMjgzCRrnsfFPsQX1ZBpVDcqMa+WbLBTzqasqKUK5RwMWi5cAgIO7XOjneJgeDDJ2uXCT2pEZ6kg+peGTVJH4gIZgcpWEfDtrFv4oXRC/Zno4bIRWL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwIypBY8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761608603; x=1793144603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDGPXjJuojOtoV9Jg7lMss0iLOqplPaCMXHqoKdeXvE=;
  b=dwIypBY8qbGDG7qyMqDCMJSbFaFymKgIEq4/dMs5iVJ9c1zwRMLxlqaH
   DVPO6f7lXH4E3wg9hjN8z5o69hPU0B9lsK2ZYA/cUvu9U0mVgbeBN0UWF
   +sl4ZGs4Cm00lgS4yXovPfNC7jTbnuOnQrlWY2JwxKbeiViBVeAJffbVq
   Sh6G6saILNVYfD6BALEEFnCcW0hB1+rhiGhJOFLgfJaareVr5jyKD6N1W
   H7qr9fp0AjMO/LLPrMChMXKA2Xnv1bT+R+W+Iz+p7A1cyU74FQYV3fVUr
   17gwdHip29k26YdcpC1GiJelJ7vzuScGEGeTitxRx+OpiG/ZkuoEX80/o
   w==;
X-CSE-ConnectionGUID: 0WvCM/azSdWUMps2lp7Lnw==
X-CSE-MsgGUID: 8ESJfIruRAqMuaB4YKzwBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74376375"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="74376375"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:43:22 -0700
X-CSE-ConnectionGUID: ZVscPFaiSY+fDy3OEZImPg==
X-CSE-MsgGUID: 6K8V5A1uQzORXPPY9lzSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="189235083"
Received: from jjgreens-desk15.amr.corp.intel.com (HELO desk) ([10.124.222.186])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:43:21 -0700
Date: Mon, 27 Oct 2025 16:43:20 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>
Subject: [PATCH v3 1/3] x86/bhi: Add BHB clearing for CPUs with larger branch
 history
Message-ID: <20251027-vmscape-bhb-v3-1-5793c2534e93@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20251027-vmscape-bhb-v3-0-5793c2534e93@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-vmscape-bhb-v3-0-5793c2534e93@linux.intel.com>

Add a version of clear_bhb_loop() that works on CPUs with larger branch
history table such as Alder Lake and newer. This could serve as a cheaper
alternative to IBPB mitigation for VMSCAPE.

clear_bhb_loop() and the new clear_bhb_long_loop() only differ in the loop
counter. Convert the asm implementation of clear_bhb_loop() into a macro
that is used by both the variants, passing counter as an argument.

There is no difference in the output of:

  $ objdump --disassemble=clear_bhb_loop vmlinux

before and after this commit.

Acked-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            | 47 ++++++++++++++++++++++++++----------
 arch/x86/include/asm/nospec-branch.h |  3 +++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ed04a968cc7d0095ab0185b2e3b5beffb7680afd..f5f62af080d8ec6fe81e4dbe78ce44d08e62aa59 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1499,11 +1499,6 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * from the branch history tracker in the Branch Predictor, therefore removing
  * user influence on subsequent BTB lookups.
  *
- * It should be used on parts prior to Alder Lake. Newer parts should use the
- * BHI_DIS_S hardware control instead. If a pre-Alder Lake part is being
- * virtualized on newer hardware the VMM should protect against BHI attacks by
- * setting BHI_DIS_S for the guests.
- *
  * CALLs/RETs are necessary to prevent Loop Stream Detector(LSD) from engaging
  * and not clearing the branch history. The call tree looks like:
  *
@@ -1529,11 +1524,12 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * that all RETs are in the second half of a cacheline to mitigate Indirect
  * Target Selection, rather than taking the slowpath via its_return_thunk.
  */
-SYM_FUNC_START(clear_bhb_loop)
+.macro	__CLEAR_BHB_LOOP outer_loop_count:req, inner_loop_count:req
 	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
+	movl	$\outer_loop_count, %ecx
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1542,29 +1538,54 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * Shift instructions so that the RET is in the upper half of the
 	 * cacheline and don't take the slowpath to its_return_thunk.
 	 */
-	.skip 32 - (.Lret1 - 1f), 0xcc
+	.skip 32 - (.Lret1_\@ - 1f), 0xcc
 	ANNOTATE_INTRA_FUNCTION_CALL
 1:	call	2f
-.Lret1:	RET
+.Lret1_\@:
+	RET
 	.align 64, 0xcc
 	/*
-	 * As above shift instructions for RET at .Lret2 as well.
+	 * As above shift instructions for RET at .Lret2_\@ as well.
 	 *
-	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
+	 * This should be ideally be: .skip 32 - (.Lret2_\@ - 2f), 0xcc
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
 	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+2:	movl	$\inner_loop_count, %eax
 3:	jmp	4f
 	nop
 4:	sub	$1, %eax
 	jnz	3b
 	sub	$1, %ecx
 	jnz	1b
-.Lret2:	RET
+.Lret2_\@:
+	RET
 5:	lfence
+
 	pop	%rbp
 	RET
+.endm
+
+/*
+ * This should be used on parts prior to Alder Lake. Newer parts should use the
+ * BHI_DIS_S hardware control instead. If a pre-Alder Lake part is being
+ * virtualized on newer hardware the VMM should protect against BHI attacks by
+ * setting BHI_DIS_S for the guests.
+ */
+SYM_FUNC_START(clear_bhb_loop)
+	__CLEAR_BHB_LOOP 5, 5
 SYM_FUNC_END(clear_bhb_loop)
 EXPORT_SYMBOL_GPL(clear_bhb_loop)
 STACK_FRAME_NON_STANDARD(clear_bhb_loop)
+
+/*
+ * A longer version of clear_bhb_loop to ensure that the BHB is cleared on CPUs
+ * with larger branch history tables (i.e. Alder Lake and newer). BHI_DIS_S
+ * protects the kernel, but to mitigate the guest influence on the host
+ * userspace either IBPB or this sequence should be used. See VMSCAPE bug.
+ */
+SYM_FUNC_START(clear_bhb_long_loop)
+	__CLEAR_BHB_LOOP 12, 7
+SYM_FUNC_END(clear_bhb_long_loop)
+EXPORT_SYMBOL_GPL(clear_bhb_long_loop)
+STACK_FRAME_NON_STANDARD(clear_bhb_long_loop)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 08ed5a2e46a5fd790bcb1b73feb6469518809c06..49707e563bdf71bdd05d3827f10dd2b8ac6bca2c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -388,6 +388,9 @@ extern void write_ibpb(void);
 
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
+extern void clear_bhb_long_loop(void);
+#else
+static inline void clear_bhb_long_loop(void) {}
 #endif
 
 extern void (*x86_return_thunk)(void);

-- 
2.34.1



