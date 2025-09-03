Return-Path: <linux-kernel+bounces-798739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28DB4224C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D0B1B238E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1930EF87;
	Wed,  3 Sep 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alr4ML9M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF630EF9C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907021; cv=none; b=WeTvFYiq0DjxTg+24MtwQgK2UiNzwr0VlhGX47Ac6yiVswunYxDULIUsrRGPQxJ/rKVmJjaZNcRYZcE79/7TLaBUDDnmhTso/tOeFD5MXnfFOH374pudKJdzixAs9A/TLgMXh2x5rcYQPCx3N4qdqP/GlMGvPvDMkD9vNDmQy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907021; c=relaxed/simple;
	bh=WPc7WhVN0tGsLfqlycF9KlwA/i80htq24n2H/UNM0CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnUT5qWDmhFc9PJpM0GhwCSeVyjTUXZFJkPCvYy99g1K8+EFIMQC+vjPmuF33Bme1PxosllgmeyzBrrS+vxajzLwsHrFJTQrCkpl8Kfla0ww2npLWehnDrR9tMSEHrvCW0CzzNnl5rbCfQf2CKlSfCBrivriA48AsIHDKw/DomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alr4ML9M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756907018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vzu94fnD+e7KAgvvelNnxmZqRHzDmyFYbsmOBpYMj4k=;
	b=alr4ML9M92tAfCj5Na69Te2db3O1VYBymwsICN0Cql33sn16luKv21XE5ib7FhRTbjEO6Q
	3ocNfEe+olt1bWXkyt+hoaOd1GUEdEh8u6vPwjaazxexs4imtwY79VEQ0CjNj7cLL8YpeA
	Rb1NtO0W3IijGpMNypkaWGyndM1vO5I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-4nN21lwMNRiLOIE6VB15wA-1; Wed,
 03 Sep 2025 09:43:34 -0400
X-MC-Unique: 4nN21lwMNRiLOIE6VB15wA-1
X-Mimecast-MFC-AGG-ID: 4nN21lwMNRiLOIE6VB15wA_1756907012
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6F151956056;
	Wed,  3 Sep 2025 13:43:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3CC621800579;
	Wed,  3 Sep 2025 13:43:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 15:42:09 +0200 (CEST)
Date: Wed, 3 Sep 2025 15:42:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 1/1] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250903134203.GA27651@redhat.com>
References: <20250903134126.GA27641@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903134126.GA27641@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If a features_enabled(ARCH_SHSTK_SHSTK) userspace thread creates a
PF_USER_WORKER thread, shstk_alloc_thread_stack() allocates a shadow
stack for no reason, the new (kernel) thread will never return to usermode.

Another problem is that the current logic looks simply wrong. In this case
fpu_clone() won't call update_fpu_shstk(), so xstate->user_ssp won't be
initialized.

But since the copy_thread() paths do not clear the ARCH_SHSTK_SHSTK flag
copied by arch_dup_task_struct(), ssp_active(PF_USER_WORKER) will return
true in ssp_get(), so ssp_get() will try to report cetregs->user_ssp which
can't be correct.

Add the new "bool minimal = !!args->fn" argument (which matches that of
fpu_clone()) to shstk_alloc_thread_stack() and change it to not allocate
shstk and to clear ARCH_SHSTK_SHSTK if minimal == true.

With this patch ssp_get() and ssp_set() will return -ENODEV right after
the ssp_active() check if target->flags & PF_USER_WORKER.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/shstk.h | 4 ++--
 arch/x86/kernel/process.c    | 2 +-
 arch/x86/kernel/shstk.c      | 9 +++++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ba6f2fe43848..a4ee2baab51c 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -17,7 +17,7 @@ struct thread_shstk {
 long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(void);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
-				       unsigned long stack_size);
+				       bool minimal, unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
@@ -28,7 +28,7 @@ static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
 static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
-						     unsigned long clone_flags,
+						     unsigned long clone_flags, bool minimal,
 						     unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1b7960cf6eb0..e932e0e53972 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -209,7 +209,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
 	 * update it.
 	 */
-	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->fn, args->stack_size);
 	if (IS_ERR_VALUE(new_ssp))
 		return PTR_ERR((void *)new_ssp);
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 2ddf23387c7e..6c8c4593e202 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -192,7 +192,7 @@ void reset_thread_features(void)
 }
 
 unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
+				       bool minimal, unsigned long stack_size)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
 	unsigned long addr, size;
@@ -208,8 +208,13 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 	 * For CLONE_VFORK the child will share the parents shadow stack.
 	 * Make sure to clear the internal tracking of the thread shadow
 	 * stack so the freeing logic run for child knows to leave it alone.
+	 *
+	 * If minimal == true, the new kernel thread cloned from userspace
+	 * thread will never return to usermode.
 	 */
-	if (clone_flags & CLONE_VFORK) {
+	if ((clone_flags & CLONE_VFORK) || minimal) {
+		if (minimal)
+			tsk->thread.features &= ~ARCH_SHSTK_SHSTK;
 		shstk->base = 0;
 		shstk->size = 0;
 		return 0;
-- 
2.25.1.362.g51ebf55



