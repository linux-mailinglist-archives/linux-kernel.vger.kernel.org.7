Return-Path: <linux-kernel+bounces-768553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88694B26285
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CBD5C0A62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B316302774;
	Thu, 14 Aug 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHh9ybAI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D24301475
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166559; cv=none; b=PZYH5OsmZC5WcNWkCToNRAKr70FIoJEFZjn7MlZrulImtdUgj5/TrpLQ6048FKv61wr/2/X8VIogUTOUSdF1CDF794JPc5PmMBaRp5rgMNYKVyjYVLUd+9Ng0bOd6wYFqNkw40AzabLRrjT6sCL+K3fMsUbsf+SNPmXCvPwOFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166559; c=relaxed/simple;
	bh=ikwK1L1Zqv+UgFsFXEmpO+tfpHaf2zCZIQITeI8jLNs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d5oR+0daOTjKEEnxsjmycFQDOUEd0K/ddQBDLSv3pFg/RK/fRMC4Av38syExT1yuQ6OeaO30CvsBYLHvEgDHg7lBrVHboFBdJvD6hnPXcWXeuOH2DeIMyWOtKoOwFRgv2uvDFRQ/284bdVZwgcbSbHbZUEL0ncErx7EqnKVlJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHh9ybAI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=cc8JTYkYXyLOfAFP05hC+s4ahvBhm0jxKwqiDB0jMOc=;
	b=fHh9ybAIGo9NfQ3D4ka8wV95/DTAZYqb5imuIJ1gla5ZMbEAb88TPkKmiqOCclKdCSLcjA
	AC6wpDE445MfbMkfR62Fh9clBCfpvU88a+bIGIhTPY9euFhV22z9VY+JqVUTwLbYatS4Rg
	9QsHc5508AN/CrxztjrS2pcXqGSZz24=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-FS5_zYP6OA-_seZQdQ0AFA-1; Thu,
 14 Aug 2025 06:15:51 -0400
X-MC-Unique: FS5_zYP6OA-_seZQdQ0AFA-1
X-Mimecast-MFC-AGG-ID: FS5_zYP6OA-_seZQdQ0AFA_1755166550
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 091BD1882805;
	Thu, 14 Aug 2025 10:15:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 02A051955E89;
	Thu, 14 Aug 2025 10:15:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:14:34 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:14:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 4/6] x86/shstk: add "task_struct *tsk" argument to
 reset_thread_features()
Message-ID: <20250814101429.GA17356@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Preparation for the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/shstk.h | 4 ++--
 arch/x86/kernel/process_64.c | 2 +-
 arch/x86/kernel/shstk.c      | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ba6f2fe43848..92d449cc352a 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -15,7 +15,7 @@ struct thread_shstk {
 };
 
 long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
-void reset_thread_features(void);
+void reset_thread_features(struct task_struct *task);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 				       unsigned long stack_size);
 void shstk_free(struct task_struct *p);
@@ -26,7 +26,7 @@ bool shstk_is_enabled(void);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
-static inline void reset_thread_features(void) {}
+static inline void reset_thread_features(struct task_struct *task) {}
 static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
 						     unsigned long clone_flags,
 						     unsigned long stack_size) { return 0; }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 52a5c03c353c..543425ea8d44 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -540,7 +540,7 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		load_gs_index(__USER_DS);
 	}
 
-	reset_thread_features();
+	reset_thread_features(current);
 
 	loadsegment(fs, 0);
 	loadsegment(es, _ds);
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 2ddf23387c7e..e6d3b1371b11 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -184,11 +184,11 @@ static int shstk_setup(void)
 	return 0;
 }
 
-void reset_thread_features(void)
+void reset_thread_features(struct task_struct *tsk)
 {
-	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
-	current->thread.features = 0;
-	current->thread.features_locked = 0;
+	memset(&tsk->thread.shstk, 0, sizeof(struct thread_shstk));
+	tsk->thread.features = 0;
+	tsk->thread.features_locked = 0;
 }
 
 unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-- 
2.25.1.362.g51ebf55


