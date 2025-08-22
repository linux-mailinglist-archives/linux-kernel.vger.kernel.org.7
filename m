Return-Path: <linux-kernel+bounces-782381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B379BB31FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2DB1D61C24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AF2FB631;
	Fri, 22 Aug 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ5fMd7Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF225BEFD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877111; cv=none; b=NwI2W3X2PCLxoZBa5CNieOnwW9xkzYslicBLu53N+HdlIv3EB0ejws4YL2uPcV+E15jm4rGfstyzzXdzjbRVY4lMNypRX49HN2cUxydSlll/JXC87fm4KZfuHyHfGVntQNZXCEN68ShrO9OH2dx+D95LDttjO2Dgr68qmzk+NvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877111; c=relaxed/simple;
	bh=cRBDZ0V4M7USIfEXDXK1MhDoXCarJ9SLFjiHd+H031I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iBihwSO6KTyrFe2/jeydMeAPQ+K4iSB/n5D/KcWxYrXxq9KyUbZheVjsfGmHbRvdQNR5kw2UDP8a0prACmQFsDox1kCeh9mTu99MZDY46FWsYmsa5yQiPZk0zx4SG2eM5FIqaC20LNFrLwl/PRDjl0eBWTRJZWDEfdF6QhLQdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQ5fMd7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=I9OqGrWe4bFx0j7k4ZODRtHJTXRM3rkKeIqs4AxHQOM=;
	b=OQ5fMd7QY6tNI5q9b4taC8I+8gzHjjb6FLsqNx8KsmDmkeSDcizi6fqiYxM4d4Bd5UbU1W
	swKRSmDuqambpWqpliWF27Uejgj5kCHI8WNhTQmYINl7AWEznQA9RaQQt4Q9BR3FoZX12d
	f4i1gF/ECICl8aCxhvCR0FOglHnSQ+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-nSGTsydMNwuQi9co0eihyw-1; Fri,
 22 Aug 2025 11:38:23 -0400
X-MC-Unique: nSGTsydMNwuQi9co0eihyw-1
X-Mimecast-MFC-AGG-ID: nSGTsydMNwuQi9co0eihyw_1755877101
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58BD1180048E;
	Fri, 22 Aug 2025 15:38:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 905A51800296;
	Fri, 22 Aug 2025 15:38:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:37:01 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:36:53 +0200
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
Subject: [PATCH v2 3/5] x86/fpu: fold sync_fpstate() into get_fpstate()
Message-ID: <20250822153653.GA27150@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

After the previous change sync_fpstate() has no other callers.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/fpu/regset.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index f5a803774e1c..ecbabdc15ec1 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -43,16 +43,12 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
  *   - ptrace to dump fpstate of a stopped task, in which case the registers
  *     have already been saved to fpstate on context switch.
  */
-static void sync_fpstate(struct fpu *fpu)
-{
-	if (fpu == x86_task_fpu(current))
-		fpu_sync_fpstate(fpu);
-}
-
 static struct fpstate *get_fpstate(struct task_struct *task)
 {
 	struct fpu *fpu = x86_task_fpu(task);
-	sync_fpstate(fpu);
+
+	if (task == current)
+		fpu_sync_fpstate(fpu);
 	return fpu->fpstate;
 }
 
-- 
2.25.1.362.g51ebf55


