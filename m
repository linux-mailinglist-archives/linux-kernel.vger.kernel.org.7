Return-Path: <linux-kernel+bounces-778215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF4EB2E2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B8E17CC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48805334371;
	Wed, 20 Aug 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUKoJb6k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AD13B58D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708505; cv=none; b=HraBGawCoMnJ9LMyVsekdD7q0S5nQ1oYxoW0UpJdpzp2TDMXipd2k5JJvhUpPiedTMsEKee7W4wvNI4HRj0t46HoBO5Z1S2ot3noZ2qcoyyluy1gRmcFFd/jbjjgDreqBP+ZoiClnlJ/VmXv7FjrfoAsXX1hyUhFYWBCbRBtO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708505; c=relaxed/simple;
	bh=lR/doXCxqRGhTs+btwwZ53cL3VmEiUxO4Vw/HoStQx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bmBFQeR4V0TKOkfxQ4OLAm8/ZY+48c9dDr58gmOEFDSzFSRjaGY/Oa9wiPsvTx3C43vxAmKtFI3ehqWpnkh8DtC/mKqhwTTd2r8G452s4+7ntZ5netNnlkaWkt++aofPq1o5HJ22++dDmoDfbX6/KXex0cCUv8/0Xtq8dzhszEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUKoJb6k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755708503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IVkKZgDnXJP9v/D7QUFQ6eomDEjHubr4yDiPYTASo/c=;
	b=eUKoJb6k9qY5ymdWmFly9MZ4qu8S+UhX/sNenLKsGjADBcVQJjxQblWNRDGEsfrPWUdark
	Pxmac0W/LTwL4jkm0O1t4pcVQwFKIyonbuFGgCf7txSpORA/QmgpY02wDLRi81G00PXBn9
	vsrze9kcWkXA45bqVHMs4laU1JJS2l8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-9aYsQmTAMh2XbAp3Ce-3pg-1; Wed,
 20 Aug 2025 12:48:17 -0400
X-MC-Unique: 9aYsQmTAMh2XbAp3Ce-3pg-1
X-Mimecast-MFC-AGG-ID: 9aYsQmTAMh2XbAp3Ce-3pg_1755708495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE5891800340;
	Wed, 20 Aug 2025 16:48:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 31D9A180028C;
	Wed, 20 Aug 2025 16:48:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 20 Aug 2025 18:46:56 +0200 (CEST)
Date: Wed, 20 Aug 2025 18:46:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Mark Brown <broonie@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/process: fix the misleading comment about
 PF_USER_WORKERs in copy_thread()
Message-ID: <20250820164651.GA18799@redhat.com>
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

The comment says "doesn't return to ret_after_fork()" but in fact it should
say "doesn't return from ret_from_fork()".

Plus the comment lacks some important details, and even "user space thread"
doesn't look accurate, if nothing else this doesn't match the comment about
PF_USER_WORKER in include/linux/sched.h.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/process.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e932e0e53972..cc4fe540d952 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -237,14 +237,20 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	if (unlikely(args->fn)) {
 		/*
-		 * A user space thread, but it doesn't return to
-		 * ret_after_fork().
+		 * A non-PF_KTHREAD thread, but it doesn't return from
+		 * ret_from_fork().
+		 *
+		 * Either a PF_USER_WORKER kernel thread, in this case
+		 * arg->fn() must not return.
+		 * Or a user space task created by user_mode_thread(), in
+		 * this case arg->fn() can only return after a successful
+		 * kernel_execve().
 		 *
 		 * In order to indicate that to tools like gdb,
 		 * we reset the stack and instruction pointers.
 		 *
 		 * It does the same kernel frame setup to return to a kernel
-		 * function that a kernel thread does.
+		 * function that a PF_KTHREAD thread does.
 		 */
 		childregs->sp = 0;
 		childregs->ip = 0;
-- 
2.25.1.362.g51ebf55



