Return-Path: <linux-kernel+bounces-782374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF5B31F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C6FB61A98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA0289E07;
	Fri, 22 Aug 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9HWjYPT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76F258CDA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877057; cv=none; b=mxsjvlsRorn2E+/OdIHBp7DsomlxKCZwFX5I2l1H9NQpYvmJNm0k7jy2jubGgU+kErO0r638fKmzz1fswnMUUmiQagMT7l8EZTzxbIhh7c0yn3urOVb/J4hFeAcCzMtFNmVJrngKnFEsrAj8wnJGoQQYWF7byw63l7BQzHQsgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877057; c=relaxed/simple;
	bh=qnsv/ZjCG1JYu1kJwQKMQn4UOqSRvURuwm56KGssZxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YvLDw/W6f+Yj01Xt0RQrPYdwI127MDwnKLOJVkQ6Qssjsx4Oke4IgAhR0+V8rtsYrmOscD3hAF+aBCIB1MQj9pPBhp5ni0+0Q1k4SAV6cMdoNHDAOB1jyq7scX4eBlOAiexxyg76MzPGfvsGZ/UF7guzTxMDtW7oVHK0J1O7bLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9HWjYPT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wFw6mFQ+6kbDnXHcYzeKbdQfDYtk1RfBmdQBYPTnIxY=;
	b=J9HWjYPTi/uTkQ0x1Pva/PSrwhFfOLuUTe3j+Rwe+MdJ8zyXpEfXVQ99c/oupxcXQURYoh
	8evJAT4iBYka9r5tkLw1JLQy/j6JIVX6mFfCAH4YSqBkxGYmBlIOqDf0QSbf1RmiTfAj6I
	9aFrydDYeVJOgzbmALDOMmOe8Djv494=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-jKZGxJbUMqmT4pje4n2NVg-1; Fri,
 22 Aug 2025 11:37:32 -0400
X-MC-Unique: jKZGxJbUMqmT4pje4n2NVg-1
X-Mimecast-MFC-AGG-ID: jKZGxJbUMqmT4pje4n2NVg_1755877051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AA8819541A4;
	Fri, 22 Aug 2025 15:37:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 015B3180047F;
	Fri, 22 Aug 2025 15:37:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:36:10 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:36:03 +0200
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
Subject: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in
 .regset_get() paths
Message-ID: <20250822153603.GA27103@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

PF_USER_WORKER threads don't really differ from PF_KTHREAD threads
at least in that they never return to usermode and never use their
FPU state.

However, ptrace or coredump paths can access their FPU state and this
is the only reason why x86_task_fpu(PF_USER_WORKER) needs to work and
and discriminate PF_USER_WORKER from PF_KTHREAD. Unlike all other x86
FPU code paths which do not distinguish them.

OTOH, arch/x86/kernel/fpu/regset.c doesn't really need "struct fpu *",
the .regset_get() functions actually need a "struct fpstate *". If the
target task is PF_USER_WORKER, they can safely use &init_fpstate. So
this series adds the new simple helper

	static struct fpstate *get_fpstate(struct task_struct *task)
	{
		struct fpu *fpu;

		if (unlikely(task->flags & PF_USER_WORKER))
			return &init_fpstate;

		fpu = x86_task_fpu(task);
		if (task == current)
			fpu_sync_fpstate(fpu);
		return fpu->fpstate;
	}

which can be used instead of x86_task_fpu(task)->fpstate pattern in
arch/x86/kernel/fpu/regset.c.

However, there is an annoying complication: shstk_alloc_thread_stack()
can alloc the pointless shadow stack for PF_USER_WORKER thread and set
the ARCH_SHSTK_SHSTK flag. This means that ssp_get()->ssp_active() can
return true, and in this case it wouldn't be right to use the "unrelated"
init_fpstate.

That is why this series includes 4/5, and to me it looks like a cleanup
which makes sense regardless.

Link to V1: https://lore.kernel.org/all/20250814101340.GA17288@redhat.com/

Changes:

	- improve the subject/changelog in 1/5

	- drop "x86/shstk: add "task_struct *tsk" argument to reset_thread_features()"

	- rework 4/5 to not use reset_thread_features()

TODO:
	update the fpregs_soft_get() and user_regset.set() paths as well

Oleg.
---

 arch/x86/include/asm/shstk.h |  4 ++--
 arch/x86/kernel/fpu/regset.c | 46 ++++++++++++++++++++++++++------------------
 arch/x86/kernel/fpu/xstate.c | 12 ++++++------
 arch/x86/kernel/fpu/xstate.h |  4 ++--
 arch/x86/kernel/process.c    |  2 +-
 arch/x86/kernel/shstk.c      |  9 +++++++--
 6 files changed, 45 insertions(+), 32 deletions(-)


