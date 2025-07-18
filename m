Return-Path: <linux-kernel+bounces-737296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A8B0AA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821C3189B822
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7609B2E7658;
	Fri, 18 Jul 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7xigkn+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcgTa2uy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3A17A305
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864849; cv=none; b=hJvbIu4nwnasX735B0P8p8AIXEUZhIxCh05H3LEfgnlhEd+w/UUwdapMjOwdQ0EW/Fiq2GKTGQVPM0FysW3BZ5Ro4Erm61z+2+7JhJj2F7dAVwOyl2DmvTuJE8bQZ467YesvMBoi/feSTTuX5lgMeEtj950UQm2M87WosxOrr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864849; c=relaxed/simple;
	bh=TeQ6auG3LYz8GImd7YeqYRttjoRqhz+o6uRKuCUXoIA=;
	h=Message-ID:From:To:Cc:Subject:Date; b=c3irpxe6b4VvEQbKvat3SFIKpZol5FDPycXEo38h6F5ENw2LKmbgWQ8EGd1ahO3FqHAUowu+DU8nNYtlMdyjxqt9o/Zz3zMvtpuSyvyC7l4UaN8KY3o+a5ZMBs6nIutp079theKdUmJmYm5Z8G0J+0pnffSSGjYjRXIKhPU7SnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7xigkn+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcgTa2uy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250718184935.232983339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752864845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=qSso+NkgXOWY1A0/MIo8qUvZBEB+CwsTtlsN2WUIpQE=;
	b=M7xigkn+9d6J7CNiLVuNGdliOakOQvFH78qwgUwViuXsOY2aSfuaoE3VJyZ+KYVVxUC8Pt
	3wQzrLusxXtMlizw/88gWkAzg4/YGQjewL4pXW2Yf270g64u7/LNP+SldtL/5BQlN2Qu9K
	PpaCzLaqz4GxeUHQ9egndvb7xk57qTY84blUz6EBXz4HVzGPVlz4eT7tpruTxt9HOO4cDp
	sZIbXU5JjgAPk6PUuDziUrqTdhrI3zeYD9lflME071MBmLuY6yRS/YCwOGXN+p7jDQIagi
	GgJUYd/WlSh4BJ4UWuLKbb3KDai2M1pc5fo7SUWZ2q1bF+WQVDMiSNJ3IJkYQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752864845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=qSso+NkgXOWY1A0/MIo8qUvZBEB+CwsTtlsN2WUIpQE=;
	b=CcgTa2uyqBOjXNOadc1U1FvO/iXHhSRfxiWMFv454Me+DcNzusu4RdYBUIZLmdM5LfT5Lu
	IqCZBA8AkV20AvBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 0/4] genirq: Prevent migration live lock in handle_edge_irq()
Date: Fri, 18 Jul 2025 20:54:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Yicon reported and Liangyan debugged a live lock in handle_edge_irq()
related to interrupt migration.

If the interrupt affinity is moved to a new target CPU and the interrupt is
currently handled on the previous target CPU for edge type interrupts the
handler might get stuck on the previous target:

CPU 0 (previous target)		CPU 1 (new target)

  handle_edge_irq()
   repeat:
	handle_event()		handle_edge_irq()
			        if (INPROGESS) {
				  set(PENDING);
				  mask();
				  return;
				}
	if (PENDING) {
	  clear(PENDING);
	  unmask();
	  goto repeat;
	}

The migration in software never completes and CPU0 continues to handle the
pending events forever. This happens when the device raises interrupts with
a high rate and always before handle_event() completes and before the CPU0
handler can clear INPROGRESS so that CPU1 sets the PENDING flag over and
over. This has been observed in virtual machines.

The following series is addressing this by making the new target CPU wait
for the handler to complete on CPU1 and thereby completing the software
migration.

A draft combo patch of this has been tested by Liangyan:

  https://lore.kernel.org/all/87o6u0rpaa.ffs@tglx

The series splits up the draft patch and has proper changelogs.

Thanks,

	tglx
---
 chip.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 internals.h |    6 ++---
 pm.c        |   16 +++++---------
 spurious.c  |   37 --------------------------------
 4 files changed, 69 insertions(+), 58 deletions(-)



