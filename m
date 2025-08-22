Return-Path: <linux-kernel+bounces-782383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432FB31FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CA8B4398B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC752ECE89;
	Fri, 22 Aug 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ft6uXoDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8342FFDEB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877125; cv=none; b=RDd2HpkbXguI2OH//lz0HQxqD4FqhBA1ohAZEClROO08lFXQgvhaZsj1B4D/yhHQYbYjiof3SEgwooKFuYNr8ruimz/JLIpiy/jFaRDnlpk5zAONSKzH1tgXKvpVZW+SQakNlZPFStFURDrRFlpfTNrrHS00wARyZt1c4N+qy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877125; c=relaxed/simple;
	bh=Eh+zMIqztYIY2ggEJbUI5AiR3H04ggRlpFk382BjQDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MRJbs+q/pVd25mgNdN4y3vSzR+Gu03u08sfG44B5LUiWcQd40XY9tEABMBHJgyIKtDPFaOWtpNJW6i81wSGaKLYcLeQQCGUtvZ/67GS51J46hhCW9oCuR/LCArKQKaJx31m5xnxdw+GOAIhUCb5UQEPoZV3j6wG2pi1lAolB5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ft6uXoDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=sNdAklJ4NfQziNX1nrwBgXGN4LI63ON8uM/hjWZghWw=;
	b=ft6uXoDSkU1Jg5XTSSe6ykF97dzHUWeWv10PAG9HqhmGrvb5szS9Gt0FIH5Gnoh0X6cnEu
	5Vuktapl/lyMJozw9wrUihx7arXiKYpbpkOs4zJkxPjHcC4nogvEr98VdwNeTaU5XNRKMd
	ShYiEs61Fg0ipTWkiCNNg91pHI8KN9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Za_cNxj-OFW4IqN5RCn6hg-1; Fri,
 22 Aug 2025 11:38:36 -0400
X-MC-Unique: Za_cNxj-OFW4IqN5RCn6hg-1
X-Mimecast-MFC-AGG-ID: Za_cNxj-OFW4IqN5RCn6hg_1755877115
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D47001800285;
	Fri, 22 Aug 2025 15:38:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8068519560B0;
	Fri, 22 Aug 2025 15:38:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:37:14 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:37:09 +0200
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
Subject: [PATCH v2 5/5] x86/fpu: change get_fpstate() to return &init_fpstate
 if PF_USER_WORKER
Message-ID: <20250822153709.GA27159@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

PF_USER_WORKERs must never use FPU, this is what kernel_fpu_begin/etc
assume. The .regset_get() functions can safely use init_fpstate if
target->flags & PF_USER_WORKER.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/fpu/regset.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ecbabdc15ec1..dfd12d109f00 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -45,8 +45,12 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
  */
 static struct fpstate *get_fpstate(struct task_struct *task)
 {
-	struct fpu *fpu = x86_task_fpu(task);
+	struct fpu *fpu;
 
+	if (unlikely(task->flags & PF_USER_WORKER))
+		return &init_fpstate;
+
+	fpu = x86_task_fpu(task);
 	if (task == current)
 		fpu_sync_fpstate(fpu);
 	return fpu->fpstate;
-- 
2.25.1.362.g51ebf55


