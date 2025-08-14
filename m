Return-Path: <linux-kernel+bounces-768550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF5B26287
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D7C3A3ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8922D7383;
	Thu, 14 Aug 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk0cNVCH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C522BF009
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166541; cv=none; b=sqLuz0G/+Z2nlc63/kb+qzM+J10Vz92V39/fA74rzLELfYw3xMoehpGYB0k/KCKDWvlcBMpqL52t4v09bUIt9wuUxsllE3ij6HgM34q/Z8zQGFGPkZCf4Td3l41PvG+Ylfpq3hKcQRV/HNDSnCdTHixb4MQU/SNozHXchh/3S6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166541; c=relaxed/simple;
	bh=lDGy6jHs+vuuTEUpjz4ACNHrl6wiJe/Q7+nM7ZD2nQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qY5WYtsG4laWU+l3Cec+lDdlT8HnwQpDDHcDs0dNNFnc6IhbDEFPaTpSGj7qBGz1fPjkNy74akfV8PtFoYE2+KGQa5hJg+owEBwxjBCTC8BGwVBNgon1Qpw6QeYSJ/5QZucgzsRMouMSr0u6zJeHdwMmgfY4Rhg0dOyXRg9nckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fk0cNVCH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=mi40gkloI3WzbXMRLyBw5TNSNsrPISTg/pT33snPr9k=;
	b=Fk0cNVCH/hw8V9htqqZWaYGR/63o4i3Teh0xcJXx5npwHBiShRPmGnk/jPS9giTlokAk2a
	uD8bSrDX/eOaExzVdZJSKUuNBFPxNfjF+6cYhnx3K30qSM65FEa/0KKjUWMt+Kn4DS7vub
	M6dpWSq3WhwjFGw2e0m175anMbg/nJI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-DOt6xThKOJSRkApuNgzTkQ-1; Thu,
 14 Aug 2025 06:15:35 -0400
X-MC-Unique: DOt6xThKOJSRkApuNgzTkQ-1
X-Mimecast-MFC-AGG-ID: DOt6xThKOJSRkApuNgzTkQ_1755166533
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA57619775A5;
	Thu, 14 Aug 2025 10:15:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4E669300019F;
	Thu, 14 Aug 2025 10:15:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:14:17 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:14:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 1/6] x86/fpu: change copy_xstate_to_uabi_buf() to accept
 fpstate + pkru instead of task_struct
Message-ID: <20250814101411.GA17341@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Preparation for the next change.

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


