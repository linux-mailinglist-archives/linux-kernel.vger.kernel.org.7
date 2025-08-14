Return-Path: <linux-kernel+bounces-768552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14536B26283
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC91CC31DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966C2FDC3F;
	Thu, 14 Aug 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Re+8Un1u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB02FD1A9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166553; cv=none; b=Y0viLsvuQSR3xLnGUrGSmJiHXkvZJ9UBsJvrZachWM3magLjFW13J65NS6nz7no3Qskr4hhcTMKi2rVeeDmK3k/OZdZ8dPztc7xrsoHIu9ML9z5CBaT1hFYqRnmrI/trHkjbqqBGe7BD1g69gsikLEVUQKXcqpA/qJqN11Gju6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166553; c=relaxed/simple;
	bh=cRBDZ0V4M7USIfEXDXK1MhDoXCarJ9SLFjiHd+H031I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uFDw5fOh7V1d4dwIWJ5lMutD1C73K9t1SXWZQ30CB5pk5t13wdKhiWWX566lRP6GfCSE1Z9ew9YRgxMZsw80GBYB5DirSQ1U20JJI9Vz9t8nGz2NZ3VW+HY96acakgXBmePeK1R6nhiAYbvx3fpsVYe2GJ1BRzqCZm2F0lO8bKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Re+8Un1u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=I9OqGrWe4bFx0j7k4ZODRtHJTXRM3rkKeIqs4AxHQOM=;
	b=Re+8Un1uavvoxM03r7GSt7LpX+/we2HZIsFnFznKvLewGoJ0WNK7lKme5rV4myoxg/nJ+4
	lPysfAZR4IAbQpSsCBPvhyyTxGCNXcFz1BrUkBrhKxif5yDyGlV3DVtJxID8BJlFVGNvUg
	ZbXxzOKEAUjRQzG0BLD9B6qct6YnVSw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-DoHpBq0pPJau2EwjgYIjQw-1; Thu,
 14 Aug 2025 06:15:46 -0400
X-MC-Unique: DoHpBq0pPJau2EwjgYIjQw-1
X-Mimecast-MFC-AGG-ID: DoHpBq0pPJau2EwjgYIjQw_1755166544
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 194C918003FC;
	Thu, 14 Aug 2025 10:15:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A45C81800297;
	Thu, 14 Aug 2025 10:15:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:14:28 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:14:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 3/6] x86/fpu: fold sync_fpstate() into get_fpstate()
Message-ID: <20250814101424.GA17352@redhat.com>
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


