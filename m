Return-Path: <linux-kernel+bounces-768555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61162B26286
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF1A1CC3AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C1303CA6;
	Thu, 14 Aug 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmtdiWJf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298A2FABED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166573; cv=none; b=MiELMdSacTaEYjrtUny6bdCveDcR0b7e72/t9aKrJLSruRZvFpV28Va8fuwSkAiEV7YGtEPUxOtpTc+tbcG7ICVe63dHDSJWdsEwrNI7XE9yV9HZ7h8+9thjV+dQuz14hWOOwZrfj6Xx5eUJCWlYULaACNhomaqPckzlK6jI6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166573; c=relaxed/simple;
	bh=Eh+zMIqztYIY2ggEJbUI5AiR3H04ggRlpFk382BjQDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AOvq8pGjam2zqRs2X/evBSkTbPm/SFLVGYXzNKpIv79LvHdAZkc7EhuUffw9g9jUwzTxQMmNQQrIcnMCs4MvY6/2gO5Kybl6dA8I9sV3IGft4/9tfw0NWjPDwvndONNsy2JQvt4efwwbB4kyfcz6pmbfvOkDu0C/1RdwPsnoNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmtdiWJf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=sNdAklJ4NfQziNX1nrwBgXGN4LI63ON8uM/hjWZghWw=;
	b=PmtdiWJfHbm1JLuCvHxnn5Cglp8yJQj04RP7umSu26jGqcyiv6Ekd2PPOzkcVWinio6kWg
	2pnHMelMk1GBJ2jhdHpj91u0os0r5mvAa0p7c7NvRiz6s4E1VuASnBFG0hZyyWcB6tiVyV
	WT0usLQFOQTWjg5M9Gn+262Hcflogjc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-FT_HeovZMUK15syjokGoow-1; Thu,
 14 Aug 2025 06:16:07 -0400
X-MC-Unique: FT_HeovZMUK15syjokGoow-1
X-Mimecast-MFC-AGG-ID: FT_HeovZMUK15syjokGoow_1755166566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5C9319373D8;
	Thu, 14 Aug 2025 10:16:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A2D471955E89;
	Thu, 14 Aug 2025 10:16:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:14:50 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:14:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 6/6] x86/fpu: change get_fpstate() to return &init_fpstate if
 PF_USER_WORKER
Message-ID: <20250814101444.GA17366@redhat.com>
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


