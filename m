Return-Path: <linux-kernel+bounces-768554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5FB26288
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D325C2430
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5A302CC0;
	Thu, 14 Aug 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVXFvV0u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F192EBBA7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166567; cv=none; b=RBUYDBKh0UCWqFZEJYNe4Sqqj2xdmJ+tVVO+TEq0p4RIqIoMoz/pDhDNa1LZFG2On+mZvk4HCRCd5iZhZNk2SqYKJ+HnQPiA/Ze2JDky0RtrbqF0Jq8lXMSSeMXGMRjoXVwmn9C8q7QFkiL41w3pxjd7r35yup5taaLv5vNqIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166567; c=relaxed/simple;
	bh=K9wUwnjWFxdOJ7Wm33r78Qn4RUe2Lz37lf3pYpYOLXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EzH3qmKo00GaeFCUMy/OCxqFIgSGbqxiZbgb2+sC4THD2DVnuxm7yP0uSpLGMGyiiurkLTeyFIl6Bo0cm9jgoOV6tlPIPkqlK9QUl8NHk3tfq5E8AYjXaWUGwPK9iijojErSkVDW6NWhLWABpMMc0H+jAS82hA6DQNC9Ylhdl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVXFvV0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=DVY1QUCNIwldEWKREIgkBawz/WH7nI6qPUesGk16egQ=;
	b=ZVXFvV0u5s8eEVPk8CX4BuHOhhy0b/tzj8C3/aVgBw7/X4nbnq1IHJnLKwVVaAUwe15YGF
	RbeCGtUz5EC3a+HCv3wyz+dtYUJQnhLrlA4FqmaambGebWS+mY+DhkEgz/anV3bPbUTKBx
	CZDxvMM0Kr0z/+SHfUHTGV4QMF464GM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-JBqeZ61SNCqTASO1AyXFcw-1; Thu,
 14 Aug 2025 06:16:01 -0400
X-MC-Unique: JBqeZ61SNCqTASO1AyXFcw-1
X-Mimecast-MFC-AGG-ID: JBqeZ61SNCqTASO1AyXFcw_1755166560
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BDEF18824F2;
	Thu, 14 Aug 2025 10:15:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0B1911800446;
	Thu, 14 Aug 2025 10:15:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:14:43 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:14:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250814101435.GA17362@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814101340.GA17288@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If a features_enabled(ARCH_SHSTK_SHSTK) userspace thread creates a
PF_USER_WORKER thread, shstk_alloc_thread_stack() allocates the shadow
stack for no reason, the new (kernel) thread will never return to usermode.

Plus the current code doesn't even look correct, in this case fpu_clone()
won't call update_fpu_shstk().

Add the new "bool minimal = !!args->fn" argument (which matches that of
fpu_clone()) to shstk_alloc_thread_stack() and change it to do
reset_thread_features(tsk) if "minimal" is true.

With this patch ssp_get() -> ssp_active(target) should never return true
if target->flags & PF_USER_WORKER.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/shstk.h |  4 ++--
 arch/x86/kernel/process.c    |  2 +-
 arch/x86/kernel/shstk.c      | 11 ++++++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 92d449cc352a..dfb2aeebc25f 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -17,7 +17,7 @@ struct thread_shstk {
 long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(struct task_struct *task);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
-				       unsigned long stack_size);
+				       bool minimal, unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
@@ -28,7 +28,7 @@ static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(struct task_struct *task) {}
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
index e6d3b1371b11..3da22c6f5874 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -192,11 +192,20 @@ void reset_thread_features(struct task_struct *tsk)
 }
 
 unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
+				       bool minimal, unsigned long stack_size)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
 	unsigned long addr, size;
 
+	/*
+	 * Kernel threads cloned from userspace thread never return to
+	 * usermode.
+	 */
+	if (minimal) {
+		reset_thread_features(tsk);
+		return 0;
+	}
+
 	/*
 	 * If shadow stack is not enabled on the new thread, skip any
 	 * switch to a new shadow stack.
-- 
2.25.1.362.g51ebf55


