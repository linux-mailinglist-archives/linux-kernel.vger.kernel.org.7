Return-Path: <linux-kernel+bounces-879991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F3C24919
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94A814E50B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10133BBA8;
	Fri, 31 Oct 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L3PjIlR6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B919E7D1;
	Fri, 31 Oct 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907616; cv=none; b=SdACt1I7KZOXbB33A6G40PzrGlQ9QAGJxHT/imnUKHBNqKJqljEZzGj/+o/Hf8N/gSaQ4twxV4787ZggRyowDLLav9qjzN+Mi+Sd7Q87Qzhx9I0KGmIUArzCcPArnij/KYhCqd4tgyyPBcK2H+PQIr+Q50gF+hcyolWqlRnL2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907616; c=relaxed/simple;
	bh=CPM+vsHQl6EFaX40FeSueptepIVspNa3p54a9w8tG6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMPQFKW8IF3JKtJGr/JTzx7F1MbcJ5m/j+fqLT8KKd9uEulfVEA7Vfas592TEmOcjl57qWaDqJ/ZrSYxQlK2lOhJN9vVAq2YulCeBuPya5GcWHz4Stt6fwrW/jB5dCPAjLoNirI9Ya3hqOduq9S3cXoWtYr+iOOJv45xu3V/gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L3PjIlR6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d7rh/2cGEG8iH61fSKApmB0WMeuzb6vBDfneW+zwIT8=; b=L3PjIlR6omQZ4dzchuhI5SfjOl
	sAOo97HWAl1VYN4Gq0F7nDf0xh6omfuHtnloegIO0PBIiEOnvUBrJ+cstS6jwgYR0/Is4T04Y2Cbi
	OZ626av9RW6mx4MwA5VFSngpR02TuOO+186cenDoH8pR7z6pYbxIVU2VF7qbBZMRhGJO7lVbDpwvQ
	igJ1td4oadhk9XD+FoRPmKHL7MvAE3KRPxyTzCemtcqDmUPvhf3UY1ZyNKjJOxc7bxJpeeTAfz/Yy
	ndqZP37yVGLkPRxG+UITB+EoV2hhMN6mAaGS2sak9i5Cky6CgEyDHiwH7S6gjqo5tNqmTOD02qRGp
	WA6cczAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEmec-0000000D0UY-1c0I;
	Fri, 31 Oct 2025 10:46:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F05A530029E; Fri, 31 Oct 2025 11:46:45 +0100 (CET)
Date: Fri, 31 Oct 2025 11:46:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [tip:core/rseq 39/42] vmlinux.o: error: objtool:
 irqentry_exit+0x323: call to class_user_rw_access_destructor() with UACCESS
 enabled
Message-ID: <20251031104645.GL4067720@noisy.programming.kicks-ass.net>
References: <202510311508.2nnmAG7r-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510311508.2nnmAG7r-lkp@intel.com>

On Fri, Oct 31, 2025 at 03:23:43PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq
> head:   69c8e3d1610588d677faaa6035e1bd5de9431d6e
> commit: 84eeeb00203526c29135d5352833d01e53fc1e16 [39/42] rseq: Switch to fast path processing on exit to user
> config: x86_64-randconfig-016-20251031 (https://download.01.org/0day-ci/archive/20251031/202510311508.2nnmAG7r-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311508.2nnmAG7r-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510311508.2nnmAG7r-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> vmlinux.o: error: objtool: irqentry_exit+0x323: call to class_user_rw_access_destructor() with UACCESS enabled
>    vmlinux.o: error: objtool: .altinstr_replacement+0x12cc: redundant UACCESS disable
>    vmlinux.o: error: objtool: .altinstr_replacement+0x12cf: redundant UACCESS disable

This is a KASAN build and all the instrumentation fucks with the inline
heuristics. The below cures this build.

---
 arch/x86/include/asm/ptrace.h | 4 ++--
 include/linux/cleanup.h       | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..750b8f353cae 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -287,8 +287,8 @@ static inline unsigned long instruction_pointer(struct pt_regs *regs)
 	return regs->ip;
 }
 
-static inline void instruction_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline 
+void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->ip = val;
 }
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..5500f30e2e7a 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -274,16 +274,16 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
-static inline void class_##_name##_destructor(_type *p)			\
+static __always_inline void class_##_name##_destructor(_type *p)	\
 { _type _T = *p; _exit; }						\
-static inline _type class_##_name##_constructor(_init_args)		\
+static __always_inline _type class_##_name##_constructor(_init_args)	\
 { _type t = _init; return t; }
 
 #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
 typedef class_##_name##_t class_##_name##ext##_t;			\
-static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
+static __always_inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
 { class_##_name##_destructor(p); }					\
-static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+static __always_inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 { class_##_name##_t t = _init; return t; }
 
 #define CLASS(_name, var)						\

