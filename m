Return-Path: <linux-kernel+bounces-880009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA2C24A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E274E4E97
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA7342C9A;
	Fri, 31 Oct 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olH13QUB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA7342CBA;
	Fri, 31 Oct 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908086; cv=none; b=i4iwEYY6PvRZODDpN55m2LAaFUEi82A2F8DLAVfaDj7G8rIDRNnWpAeZuE5EVW1XSnIEWDjSng2SuSTtr7gmA9lP/eOvtBtb7hHE6wC7MJOQHyFLw1zamo8T9d8/3hcZmGkpOT4HJrALKeMWWRvBjNr+5c237YUubMseDiQVSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908086; c=relaxed/simple;
	bh=46pMBdJj8ZJWZWuROwJ0QRzwo4bQjxJWKnq3nGFsDwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksbVtweRtbTi8vpUGZNWVEcyNLczlYWgC4clBy0JqRjsmVFIo7vKNnIpLeR8qUMduuenZumFbiEqPyrw/JLY+BbPcIJn59VcigpK9+m/ozN1pIq86yM5p/2OjoFpL+Dmxh3V5AzjBMNuX//qHtfRqFUrmSsXQpKQtmQSXpTl08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olH13QUB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tT6sHcykGMYO/AhLm9Ak7MuFxFE3as9QY7i91YdirEE=; b=olH13QUBrtbXyU6i2h//TdEEPw
	ZjEcAE1/AOM6+1KSs9VaBVlAI8T+dmFmL75Ge8Ba8N4WIo5qgN2tr2TzwFF18xoxgNmjpakblJpqk
	Lm1RWj2ZB76WluEHo5/KqNmRXBNA5eBhb5ZCmWBH8J/DTo3ri7MCe/K7ALEQkrxy4UIr6Z/5EoJ9/
	vLI9CUG0cqRX3rbw+324yh9q7k0YiiK5KR3BU57rBl4jY7kYAU+CwTdzaZBFCA0Ee4GWzePYs6RwS
	8ic8nQ+DyuxfULFV0MLID+oMCDibuZYB4JYCmZ/j4jritZWW8mwzLLMKqddzzyv9X4ougV7ScOa0F
	QibUTrOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEluT-0000000B5Yb-2bGR;
	Fri, 31 Oct 2025 09:59:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4AF323001D0; Fri, 31 Oct 2025 11:54:35 +0100 (CET)
Date: Fri, 31 Oct 2025 11:54:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [tip:core/rseq 39/42] vmlinux.o: error: objtool:
 irqentry_exit+0x323: call to class_user_rw_access_destructor() with UACCESS
 enabled
Message-ID: <20251031105435.GU4068168@noisy.programming.kicks-ass.net>
References: <202510311508.2nnmAG7r-lkp@intel.com>
 <20251031104645.GL4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031104645.GL4067720@noisy.programming.kicks-ass.net>

On Fri, Oct 31, 2025 at 11:46:45AM +0100, Peter Zijlstra wrote:
> On Fri, Oct 31, 2025 at 03:23:43PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq
> > head:   69c8e3d1610588d677faaa6035e1bd5de9431d6e
> > commit: 84eeeb00203526c29135d5352833d01e53fc1e16 [39/42] rseq: Switch to fast path processing on exit to user
> > config: x86_64-randconfig-016-20251031 (https://download.01.org/0day-ci/archive/20251031/202510311508.2nnmAG7r-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311508.2nnmAG7r-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202510311508.2nnmAG7r-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> vmlinux.o: error: objtool: irqentry_exit+0x323: call to class_user_rw_access_destructor() with UACCESS enabled
> >    vmlinux.o: error: objtool: .altinstr_replacement+0x12cc: redundant UACCESS disable
> >    vmlinux.o: error: objtool: .altinstr_replacement+0x12cf: redundant UACCESS disable
> 
> This is a KASAN build and all the instrumentation fucks with the inline
> heuristics. The below cures this build.
> 

Although, for consistencies sake, I suppose we should do this.


---
 arch/x86/include/asm/ptrace.h | 20 ++++++++++----------
 include/linux/cleanup.h       | 30 +++++++++++++++---------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..b5dec859bc75 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -187,12 +187,12 @@ convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
 extern void send_sigtrap(struct pt_regs *regs, int error_code, int si_code);
 
 
-static inline unsigned long regs_return_value(struct pt_regs *regs)
+static __always_inline unsigned long regs_return_value(struct pt_regs *regs)
 {
 	return regs->ax;
 }
 
-static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+static __always_inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 {
 	regs->ax = rc;
 }
@@ -277,34 +277,34 @@ static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 }
 #endif
 
-static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
 	return regs->sp;
 }
 
-static inline unsigned long instruction_pointer(struct pt_regs *regs)
+static __always_inline unsigned long instruction_pointer(struct pt_regs *regs)
 {
 	return regs->ip;
 }
 
-static inline void instruction_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline
+void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->ip = val;
 }
 
-static inline unsigned long frame_pointer(struct pt_regs *regs)
+static __always_inline unsigned long frame_pointer(struct pt_regs *regs)
 {
 	return regs->bp;
 }
 
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
 	return regs->sp;
 }
 
-static inline void user_stack_pointer_set(struct pt_regs *regs,
-		unsigned long val)
+static __always_inline
+void user_stack_pointer_set(struct pt_regs *regs, unsigned long val)
 {
 	regs->sp = val;
 }
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..d1806ac5342c 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -208,7 +208,7 @@
  */
 
 #define DEFINE_FREE(_name, _type, _free) \
-	static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
+	static __always_inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
 
 #define __free(_name)	__cleanup(__free_##_name)
 
@@ -220,7 +220,7 @@
 		__val;                      \
 	})
 
-static inline __must_check
+static __always_inline __must_check
 const volatile void * __must_check_fn(const volatile void *val)
 { return val; }
 
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
+static __always_inline void class_##_name##ext##_destructor(class_##_name##_t *p) \
 { class_##_name##_destructor(p); }					\
-static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+static __always_inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 { class_##_name##_t t = _init; return t; }
 
 #define CLASS(_name, var)						\
@@ -347,7 +347,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	})
 
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp)                                \
-	static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	static __always_inline void *class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{                                                                   \
 		void *_ptr = (void *)(__force unsigned long)*(_exp);        \
 		if (IS_ERR(_ptr)) {                                         \
@@ -355,7 +355,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 		}                                                           \
 		return _ptr;                                                \
 	}                                                                   \
-	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
+	static __always_inline int class_##_name##_lock_err(class_##_name##_t *_T) \
 	{                                                                   \
 		long _rc = (__force unsigned long)*(_exp);                  \
 		if (!_rc) {                                                 \
@@ -384,9 +384,9 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; int _RET = (_lock); if (_T && !(_cond)) _t = ERR_PTR(_RET); _t; }), \
 		     class_##_name##_t _T) \
-	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	static __always_inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); } \
-	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	static __always_inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_err(_T); }
 
 /*
@@ -466,7 +466,7 @@ typedef struct {							\
 	__VA_ARGS__;							\
 } class_##_name##_t;							\
 									\
-static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+static __always_inline void class_##_name##_destructor(class_##_name##_t *_T) \
 {									\
 	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
@@ -474,7 +474,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
-static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+static __always_inline class_##_name##_t class_##_name##_constructor(_type *l) \
 {									\
 	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
 	_lock;								\
@@ -482,7 +482,7 @@ static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
 }
 
 #define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
-static inline class_##_name##_t class_##_name##_constructor(void)	\
+static __always_inline class_##_name##_t class_##_name##_constructor(void) \
 {									\
 	class_##_name##_t _t = { .lock = (void*)1 },			\
 			 *_T __maybe_unused = &_t;			\
@@ -508,9 +508,9 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 		        if (_T->lock && !(_cond)) _T->lock = ERR_PTR(_RET);\
 			_t; }),						\
 		     typeof_member(class_##_name##_t, lock) l)		\
-	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	static __always_inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); } \
-	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	static __always_inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_err(_T); }
 
 #define DEFINE_LOCK_GUARD_1_COND_3(_name, _ext, _lock) \

