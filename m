Return-Path: <linux-kernel+bounces-768551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F4B2627F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37157586B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1C2F99BC;
	Thu, 14 Aug 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR7cdcTe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7D2F39CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166549; cv=none; b=si05ZP1hUni04bEEEKe9boAe5KC4P+sWYJPXpreNLRhRsquX1QNUqrgwLVA/QDGZqW2/vHMa71tCk3kyywVs+AxiYlq7SVrd3iV1HRNsJjpksM/ICY2p56c2g+38wp7/s3sv5Iynqi8+PjKHhx7GtDgT+Oqgb17itw/jV0FhTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166549; c=relaxed/simple;
	bh=3rig9o0mKKdZLmjoLPG8hkOvBttTRwc/0hPS8s3NewQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aMyhEHmSFyq5OoSlrm8jt6Y/Bm2J2y8rMTit75XC76PKnx2jG7Ev/y9ImzAq25GDksA3ma8FpF/6Jkc1ET22wdvbR2BIIFfKFknoTn/greDIy9Ewce8Z6pqHvW8cCTq3oU8iRTQWKL405mn5TZrwBlAAWhETOF80PptnchYixJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dR7cdcTe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=oIM+QpfetU8Xpz9SmqBoW9/2mND86Ux35Wm3WP2cxcY=;
	b=dR7cdcTeuvZZ6ath6+GEyiO1Q8bXrVzD2pdcGnYgU/qpJG0xpOTLaqxbB4tZe7ngSZUHmZ
	1DtdsAMjkRj1Fvt4q79VNuLkH6RGd4CvcJRbBySmi+F9yJxJcE3HOimHCcZSPG7KtfVM4G
	agU5iLX/QWYb31cGK+uyNdd2hHMTrtY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-GXEuGU2QOcCvFWNzSOkkuQ-1; Thu,
 14 Aug 2025 06:15:41 -0400
X-MC-Unique: GXEuGU2QOcCvFWNzSOkkuQ-1
X-Mimecast-MFC-AGG-ID: GXEuGU2QOcCvFWNzSOkkuQ_1755166539
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1975D1955BE4;
	Thu, 14 Aug 2025 10:15:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AD07E1800447;
	Thu, 14 Aug 2025 10:15:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:14:23 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:14:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/6] x86/fpu: regset: introduce get_fpstate() helper
Message-ID: <20250814101418.GA17349@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

After the previous change the regset get() functions do not really need
"struct fpu *", they can use "struct fpstate *" returned by the new helper
which also does sync_fpstate().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/fpu/regset.c | 42 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index d280d415b171..f5a803774e1c 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -49,6 +49,13 @@ static void sync_fpstate(struct fpu *fpu)
 		fpu_sync_fpstate(fpu);
 }
 
+static struct fpstate *get_fpstate(struct task_struct *task)
+{
+	struct fpu *fpu = x86_task_fpu(task);
+	sync_fpstate(fpu);
+	return fpu->fpstate;
+}
+
 /*
  * Invalidate cached FPU registers before modifying the stopped target
  * task's fpstate.
@@ -71,19 +78,19 @@ static void fpu_force_restore(struct fpu *fpu)
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = x86_task_fpu(target);
+	struct fpstate *fpstate;
 
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
-	sync_fpstate(fpu);
+	fpstate = get_fpstate(target);
 
 	if (!use_xsave()) {
-		return membuf_write(&to, &fpu->fpstate->regs.fxsave,
-				    sizeof(fpu->fpstate->regs.fxsave));
+		return membuf_write(&to, &fpstate->regs.fxsave,
+				    sizeof(fpstate->regs.fxsave));
 	}
 
-	copy_xstate_to_uabi_buf(to, fpu->fpstate, target->thread.pkru, XSTATE_COPY_FX);
+	copy_xstate_to_uabi_buf(to, fpstate, target->thread.pkru, XSTATE_COPY_FX);
 	return 0;
 }
 
@@ -130,14 +137,13 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = x86_task_fpu(target);
+	struct fpstate *fpstate;
 
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(fpu);
-
-	copy_xstate_to_uabi_buf(to, fpu->fpstate, target->thread.pkru, XSTATE_COPY_XSAVE);
+	fpstate = get_fpstate(target);
+	copy_xstate_to_uabi_buf(to, fpstate, target->thread.pkru, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
@@ -189,15 +195,15 @@ int ssp_active(struct task_struct *target, const struct user_regset *regset)
 int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	    struct membuf to)
 {
-	struct fpu *fpu = x86_task_fpu(target);
+	struct fpstate *fpstate;
 	struct cet_user_state *cetregs;
 
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
 	    !ssp_active(target, regset))
 		return -ENODEV;
 
-	sync_fpstate(fpu);
-	cetregs = get_xsave_addr(&fpu->fpstate->regs.xsave, XFEATURE_CET_USER);
+	fpstate = get_fpstate(target);
+	cetregs = get_xsave_addr(&fpstate->regs.xsave, XFEATURE_CET_USER);
 	if (WARN_ON(!cetregs)) {
 		/*
 		 * This shouldn't ever be NULL because shadow stack was
@@ -403,17 +409,17 @@ void convert_to_fxsr(struct fxregs_state *fxsave,
 int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 	       struct membuf to)
 {
-	struct fpu *fpu = x86_task_fpu(target);
+	struct fpstate *fpstate;
 	struct user_i387_ia32_struct env;
 	struct fxregs_state fxsave, *fx;
 
-	sync_fpstate(fpu);
-
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);
 
+	fpstate = get_fpstate(target);
+
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
-		return membuf_write(&to, &fpu->fpstate->regs.fsave,
+		return membuf_write(&to, &fpstate->regs.fsave,
 				    sizeof(struct fregs_state));
 	}
 
@@ -421,10 +427,10 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
 		/* Handle init state optimized xstate correctly */
-		copy_xstate_to_uabi_buf(mb, fpu->fpstate, target->thread.pkru, XSTATE_COPY_FP);
+		copy_xstate_to_uabi_buf(mb, fpstate, target->thread.pkru, XSTATE_COPY_FP);
 		fx = &fxsave;
 	} else {
-		fx = &fpu->fpstate->regs.fxsave;
+		fx = &fpstate->regs.fxsave;
 	}
 
 	__convert_from_fxsr(&env, target, fx);
-- 
2.25.1.362.g51ebf55


