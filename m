Return-Path: <linux-kernel+bounces-791967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4D2B3BEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64ED1C81FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48169321F29;
	Fri, 29 Aug 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8olGzEi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373B31E111
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480031; cv=none; b=qfHT02x+JkEwV8JTh2ISbygPP9GFrIXdRdrU2dP5JUkWfRMeYCpW8MA8nSF/2/3yR+G0Kzn4UcOw2KDauBOBQzgelDZJqnDsZGiMMBrhxpemcXPIM6jBiH7ng7XeDBRwIBvDFRVXoyeV1/o7I9X7T5I10iRTS0W0Ohpz9TXvBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480031; c=relaxed/simple;
	bh=UX7V0x7og9V/sL9HCsljPyJjlMpAaquEqOi61jNmms0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E73UyMyfsdd/PT/94BE52RabfWqruMImww0vfZ/bfU9T+en6Dzg1+bB2tGp/8hDFjI+gIBOtTcDbt9Dcq59P3sn9RjAG99uTh+xfAJO3MMcms/KJXTp2H1qRFi8WtFRQOw+7Gh9Tk7QndaeadaMawlwVpxSyO/GXCGWDSSWx7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8olGzEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756480029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=M4G/SsSoHk9srl5BBJ2wGcDhRw8UjDp+MZR6I1St2To=;
	b=W8olGzEi61VCqor2lm8Ii26G+nxl9V74BoOHbksKmqAvqzmQcC9Ev6rD5fGmWKKZiQa+Xp
	e1A3Bxb6Jg10ClvYEDaY4idc1cKVwIJ0/2gfXLA4fk31VXtJpPZMLS4yG8rpz5CE75PqBz
	qoVO6+XxOEFCrewh83h6chA4KrIQtGY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661--YbBTsmtOUazeMsWCqn_IA-1; Fri,
 29 Aug 2025 11:07:05 -0400
X-MC-Unique: -YbBTsmtOUazeMsWCqn_IA-1
X-Mimecast-MFC-AGG-ID: -YbBTsmtOUazeMsWCqn_IA_1756480024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DB5418004A7;
	Fri, 29 Aug 2025 15:07:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.111])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9DCEC18003FC;
	Fri, 29 Aug 2025 15:06:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 29 Aug 2025 17:05:41 +0200 (CEST)
Date: Fri, 29 Aug 2025 17:05:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Chao Gao <chao.gao@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Eric Biggers <ebiggers@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] x86/fpu: kill the PF_KTHREAD|PF_USER_WORKER check in
 switch_fpu() and kernel_fpu_begin_mask()
Message-ID: <20250829150535.GA17416@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

PF_KTHREAD | PF_USER_WORKER kernel threads do not use their FPU context,
this means that TIF_NEED_FPU_LOAD must be always set, we can remove the
unnecessary "PF_KTHREAD | PF_USER_WORKER" check.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/fpu/sched.h | 3 +--
 arch/x86/kernel/fpu/core.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index c060549c6c94..20091b4cda6a 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -32,8 +32,7 @@ extern void fpu_flush_thread(void);
 static inline void switch_fpu(struct task_struct *old, int cpu)
 {
 	if (!test_tsk_thread_flag(old, TIF_NEED_FPU_LOAD) &&
-	    cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	    cpu_feature_enabled(X86_FEATURE_FPU)) {
 		struct fpu *old_fpu = x86_task_fpu(old);
 
 		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index aefd412a23dc..ef54da3c1f1a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -453,8 +453,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	WARN_ON_FPU(!this_cpu_read(kernel_fpu_allowed));
 	this_cpu_write(kernel_fpu_allowed, false);
 
-	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
-	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(x86_task_fpu(current));
 	}
-- 
2.25.1.362.g51ebf55



