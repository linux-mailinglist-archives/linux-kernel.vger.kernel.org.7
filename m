Return-Path: <linux-kernel+bounces-782379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E76B31FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27EEAA2469
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928F2EDD59;
	Fri, 22 Aug 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmazHfqA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9B23D7C4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877096; cv=none; b=uQCwUwqLIUdUXVPtm9Wh7o+mpcrs5QBMEdKvvf8TC/TxErpXYAokwii8TqBF/fTKZwdvB0qvnuQX3DrwurhzoD/MWl5AaJ2034NHglxiL5VzWjj/WZ2f56l515GgGUY8hBfkvsVkZxJ9mabqRA9Ur2Od7btbV63FnoTWVWMAY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877096; c=relaxed/simple;
	bh=vtoLwSy+rSGK7Qrg8w4sry4YSsxubqnZXpbq0bBBQ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ef5sNpXJNsKDwQT4U00t5Fj6vEIIgXSHurp9XNNVrlUUli5QU611lZX1tP5G+SNHuU1PTbHqb/Lm/rL3dut05XQZDVdbpZ2igxCyjdQ0Acl5dhSFNoewnjToYC82FzQS07N1whEsoUdWB/F9dTPsuIBbQBJeMmijrNs2sdwvco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmazHfqA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=wcb+UP6uLJYVIufEAJyNrWK+nKSeXT9MKLtT9eMyJe4=;
	b=JmazHfqAVHOB5Tu3xmasw38lwkKIMMoKy3EyV8VNbYU12YYIfugZqB0rpLX5r/yPUfkZCY
	PYuJL72iGbRbn/fsbSNgiWO4R5zc1hWqnC2Mr6ZNBzgVX9BKETcp9ynNyZO+Ys0KgO2vLN
	zjeOqt+xUo++z1gSLJFuGTeDpIUyR/Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-Z-lD4Dc_NTq8iJsVqLjeZw-1; Fri,
 22 Aug 2025 11:38:08 -0400
X-MC-Unique: Z-lD4Dc_NTq8iJsVqLjeZw-1
X-Mimecast-MFC-AGG-ID: Z-lD4Dc_NTq8iJsVqLjeZw_1755877086
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 743841800561;
	Fri, 22 Aug 2025 15:38:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A0633180044F;
	Fri, 22 Aug 2025 15:38:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:36:45 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:36:39 +0200
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
Subject: [PATCH v2 1/5] x86/fpu: don't use x86_task_fpu() in
 copy_xstate_to_uabi_buf()
Message-ID: <20250822153639.GA27139@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

No functional changes, preparation for the next patches.

Change copy_xstate_to_uabi_buf() to take a "struct fpstate *" and
"u32 pkru" instead of "struct task_struct *" to avoid x86_task_fpu(tsk).
The callers already have "struct fpu *" and can pass fpu->fpstate directly.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/fpu/regset.c | 10 ++++++----
 arch/x86/kernel/fpu/xstate.c | 12 ++++++------
 arch/x86/kernel/fpu/xstate.h |  4 ++--
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 0986c2200adc..d280d415b171 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -83,7 +83,7 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 				    sizeof(fpu->fpstate->regs.fxsave));
 	}
 
-	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_FX);
+	copy_xstate_to_uabi_buf(to, fpu->fpstate, target->thread.pkru, XSTATE_COPY_FX);
 	return 0;
 }
 
@@ -130,12 +130,14 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
+	struct fpu *fpu = x86_task_fpu(target);
+
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(x86_task_fpu(target));
+	sync_fpstate(fpu);
 
-	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
+	copy_xstate_to_uabi_buf(to, fpu->fpstate, target->thread.pkru, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
@@ -419,7 +421,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
 		/* Handle init state optimized xstate correctly */
-		copy_xstate_to_uabi_buf(mb, target, XSTATE_COPY_FP);
+		copy_xstate_to_uabi_buf(mb, fpu->fpstate, target->thread.pkru, XSTATE_COPY_FP);
 		fx = &fxsave;
 	} else {
 		fx = &fpu->fpstate->regs.fxsave;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 12ed75c1b567..2bd5974d5f0e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1256,7 +1256,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 /**
  * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @tsk:	The task from which to copy the saved xstate
+ * @fpstate:	The fpstate buffer from which to copy
+ * @pkru_val:	The PKRU value to store in the PKRU component
  * @copy_mode:	The requested copy mode
  *
  * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
@@ -1265,12 +1266,11 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
-			     enum xstate_copy_mode copy_mode)
+void copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
+			     u32 pkru_val, enum xstate_copy_mode copy_mode)
 {
-	__copy_xstate_to_uabi_buf(to, x86_task_fpu(tsk)->fpstate,
-				  x86_task_fpu(tsk)->fpstate->user_xfeatures,
-				  tsk->thread.pkru, copy_mode);
+	__copy_xstate_to_uabi_buf(to, fpstate, fpstate->user_xfeatures,
+				  pkru_val, copy_mode);
 }
 
 static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 52ce19289989..9d76ded84cdd 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -46,8 +46,8 @@ struct membuf;
 extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 				      u64 xfeatures, u32 pkru_val,
 				      enum xstate_copy_mode copy_mode);
-extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
-				    enum xstate_copy_mode mode);
+extern void copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
+				    u32 pkru_val, enum xstate_copy_mode copy_mode);
 extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru);
 extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void __user *ubuf);
 
-- 
2.25.1.362.g51ebf55


