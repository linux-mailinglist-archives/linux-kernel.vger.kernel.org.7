Return-Path: <linux-kernel+bounces-782382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7007FB31FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291053A8C42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A32FE56C;
	Fri, 22 Aug 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUiAyH0I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8D25C833
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877116; cv=none; b=YoJdPSo3YPeRvMUlGX2Z5X0EJYrrfQvzu1/+YNoiF2/MRtuQ82XPOcEXiFKHZb4XUHdzwQVjyXcs7f4lKYPgPwjjqV/jmeCYoulEn0s2Ne8hCqMoOd6/XqD5fDeM4CeFxTW5OhtSliE/rxHn7M6/EZYn/d6BQ09tRTCya+9nbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877116; c=relaxed/simple;
	bh=IApp4LzrpZfZpq4FOoG4uXSMm/Rh7qJX8SvuMXYVIdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tLtZprVlJbnLkmb5j6mL9KKqYGJnsuSflWgqU7gUXBLw2KucSGryG1VBi2JtuwKnsMJrH23ZQj2sE6u5SeA5hr3ffNpHo+H+AbvxeSlmeCBLKAr/7/rVCZr2E0B3hN6amJ1ZatepHDTF9FE+/ZZ2fanhuFwc2Nj2NsmYTnR1ifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUiAyH0I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=iwwQoFvPri9HBUT5vlx/GnO2PxJgU97nR07EdM103u0=;
	b=SUiAyH0Ie1htWS1NhZFV+W8vz6Q3H5zDxR7mivEOsM3cBo5LzAf/4ybo6wsws03XKcTl+0
	Se/8hfAMPJjr5noUkhsvGD+/iQx84/+i1LgIopTj1TqaJZnudafTPXs6mXuHqaTI5wxi7v
	9WwJq2TqV8ExT2hgdWLdEsg7y/HDafA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-pk2HpOYUNqapQm2ot-_90g-1; Fri,
 22 Aug 2025 11:38:30 -0400
X-MC-Unique: pk2HpOYUNqapQm2ot-_90g-1
X-Mimecast-MFC-AGG-ID: pk2HpOYUNqapQm2ot-_90g_1755877108
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 029761800366;
	Fri, 22 Aug 2025 15:38:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8D9221955F24;
	Fri, 22 Aug 2025 15:38:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:37:08 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:37:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Brown <broonie@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 4/5] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250822153702.GA27153@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153603.GA27103@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If a features_enabled(ARCH_SHSTK_SHSTK) userspace thread creates a
PF_USER_WORKER thread, shstk_alloc_thread_stack() allocates the shadow
stack for no reason, the new (kernel) thread will never return to usermode.

Plus the current code doesn't even look correct, in this case fpu_clone()
won't call update_fpu_shstk().

Add the new "bool minimal = !!args->fn" argument (which matches that of
fpu_clone()) to shstk_alloc_thread_stack() and change it to check this
argument along with CLONE_VFORK.

With this patch ssp_get() -> ssp_active(target) should never return true
if target->flags & PF_USER_WORKER.

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


