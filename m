Return-Path: <linux-kernel+bounces-660048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1CDAC1898
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F5EA20CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046A2E3360;
	Thu, 22 May 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI0kWp6k"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544862DFA24
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957973; cv=none; b=h4GrXAk0wPN1H6oCAJ/RJQiq+J2iO/tAQDfOopBgvf1SfXD4/rx/fBFiNQ0jCiNCf6EDXh9vvAosnO/V9zZp0uWmBRKp7w2hte1gyBhiONqPGXLrST8QrFMDcE8hSGCA1SapF2kG5DLaIkNUCct0HHd+zCejHZGVCKrsWsP73L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957973; c=relaxed/simple;
	bh=Ob2er87zWf/jP9Pn9aYWe5PdITMURa6xwa9Ym10iWu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2x+Ue5ypAX49vFiTiRqw/zOW4RUYCDr3CdQ5lQBqyUkHbNPYKzkQM1jN6UqbL2j8kjj/dgtNkYsfMNe2XRmjqfL2wk6CNE4Lpj2X7gsjVWip0LfYWDy7Jtlgho8ySLndLybigTwmAZ0pqWVUNBXEsrUKxqJMAyPPMZ5L7cUp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI0kWp6k; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742d077bdfaso6775832b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957969; x=1748562769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m999gU/AqGpWG+L7ciDbK5wL4BJk8SCse59imt7h3LE=;
        b=ZI0kWp6kAer4RjmE1OrpaVExnz0g73Zi0udLol8A9fCI8B21xamW/dtlQZXCohL4j5
         q6YqhmcBw6NA7OgxpCB6jPvWyzhiGtQx3zau6W0+kLmLDgc0MZ99V3gA0DzqzbSLf3le
         Ni9qDXv15vgzKwoyVl+SkFxhRWRisWtuD5p9nZ8Mc66GfSKkdPurJGOJdybXC0XODNxi
         qI/ny5QEJ21uEw+GjlliqQSVUmQoXZvPTwzDnXSOPi4l+1xXXYpvETegrm3TBCHKSCYi
         3fd24yi8lpCv61zMXaltp7yxfciSQfbLxiL+NRfUmlskC0JM2lLF7qIajYPBOnr3l06D
         LNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957969; x=1748562769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m999gU/AqGpWG+L7ciDbK5wL4BJk8SCse59imt7h3LE=;
        b=a5Rs9jlEG/5JirvX0RoKed2ZVBB2+adrIeVivUBsS+QiRmicWc8jTAkvof7CPHwVCM
         bbgqbZffVG/bJ5yAS+HluSamd1Zhh30QtV4JFmwFiT/gYLR2kLec+7AYCai9Z6JClQ4D
         CrrwFQtAVjDn3E9gIh0tLOYPnj46b8dphSAg+TzHrc2tMB56FdPTbtF3eSnvDcNagqVp
         kv3pHvsH2UEASZC/ZU3wY9ux/DPKw/B2J7l0NSMa5KjQy9j3BYHtZoX/TvvhnB+poNlx
         +s9EFp0rO9dksoCvLRoZ4WKvpCw23N5OmxGA45jV7S6gaAKRplV+On8l5dqeL1Mj17FF
         ALHw==
X-Gm-Message-State: AOJu0Yy/CcNrCNAxTssOCg8QHUx6MZxvtyhQ/4138i4DqmYczXn+0VoR
	ZrtxY8b/2biFZ71f0RDasM9SbXsjjS8jRKwlqCB7Qgf7VsVdQS9YnM1ggiUp7UCvyiEvtVIHdz0
	HrZYQOQ==
X-Google-Smtp-Source: AGHT+IGGw5zwjY0zFLgdg4fHQ7nOB9U/xbrTeYpuWgtfAceUKGlpNANWH4gnTKB5jligEj9ALMrYFDn6jAg=
X-Received: from pfjd1.prod.google.com ([2002:a05:6a00:2441:b0:730:743a:f2b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c82:b0:742:b3a6:db16
 with SMTP id d2e1a72fcca58-745ed90b8e2mr1286378b3a.20.1747957969447; Thu, 22
 May 2025 16:52:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:19 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-10-seanjc@google.com>
Subject: [PATCH v3 09/13] KVM: Disallow binding multiple irqfds to an eventfd
 with a priority waiter
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Disallow binding an irqfd to an eventfd that already has a priority waiter,
i.e. to an eventfd that already has an attached irqfd.  KVM always
operates in exclusive mode for EPOLL_IN (unconditionally returns '1'),
i.e. only the first waiter will be notified.

KVM already disallows binding multiple irqfds to an eventfd in a single
VM, but doesn't guard against multiple VMs binding to an eventfd.  Adding
the extra protection reduces the pain of a userspace VMM bug, e.g. if
userspace fails to de-assign before re-assigning when transferring state
for intra-host migration, then the migration will explicitly fail as
opposed to dropping IRQs on the destination VM.

Temporarily keep KVM's manual check on irqfds.items, but add a WARN, e.g.
to allow sanity checking the waitqueue enforcement.

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/eventfd.c | 55 +++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index c7969904637a..7b2e1f858f6d 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -291,38 +291,57 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 	struct kvm_kernel_irqfd *tmp;
 	struct kvm *kvm = p->kvm;
 
+	/*
+	 * Note, irqfds.lock protects the irqfd's irq_entry, i.e. its routing,
+	 * and irqfds.items.  It does NOT protect registering with the eventfd.
+	 */
 	spin_lock_irq(&kvm->irqfds.lock);
 
-	list_for_each_entry(tmp, &kvm->irqfds.items, list) {
-		if (irqfd->eventfd != tmp->eventfd)
-			continue;
-		/* This fd is used for another irq already. */
-		p->ret = -EBUSY;
-		spin_unlock_irq(&kvm->irqfds.lock);
-		return;
-	}
-
+	/*
+	 * Initialize the routing information prior to adding the irqfd to the
+	 * eventfd's waitqueue, as irqfd_wakeup() can be invoked as soon as the
+	 * irqfd is registered.
+	 */
 	irqfd_update(kvm, irqfd);
 
-	list_add_tail(&irqfd->list, &kvm->irqfds.items);
-
 	/*
 	 * Add the irqfd as a priority waiter on the eventfd, with a custom
 	 * wake-up handler, so that KVM *and only KVM* is notified whenever the
-	 * underlying eventfd is signaled.  Temporarily lie to lockdep about
-	 * holding irqfds.lock to avoid a false positive regarding potential
-	 * deadlock with irqfd_wakeup() (see irqfd_wakeup() for details).
+	 * underlying eventfd is signaled.
 	 */
 	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
 
+	/*
+	 * Temporarily lie to lockdep about holding irqfds.lock to avoid a
+	 * false positive regarding potential deadlock with irqfd_wakeup()
+	 * (see irqfd_wakeup() for details).
+	 *
+	 * Adding to the wait queue will fail if there is already a priority
+	 * waiter, i.e. if the eventfd is associated with another irqfd (in any
+	 * VM).  Note, kvm_irqfd_deassign() waits for all in-flight shutdown
+	 * jobs to complete, i.e. ensures the irqfd has been removed from the
+	 * eventfd's waitqueue before returning to userspace.
+	 */
 	spin_release(&kvm->irqfds.lock.dep_map, _RET_IP_);
-	irqfd->wait.flags |= WQ_FLAG_EXCLUSIVE;
-	add_wait_queue_priority(wqh, &irqfd->wait);
+	p->ret = add_wait_queue_priority_exclusive(wqh, &irqfd->wait);
 	spin_acquire(&kvm->irqfds.lock.dep_map, 0, 0, _RET_IP_);
+	if (p->ret)
+		goto out;
 
+	list_for_each_entry(tmp, &kvm->irqfds.items, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+
+		WARN_ON_ONCE(1);
+		/* This fd is used for another irq already. */
+		p->ret = -EBUSY;
+		goto out;
+	}
+
+	list_add_tail(&irqfd->list, &kvm->irqfds.items);
+
+out:
 	spin_unlock_irq(&kvm->irqfds.lock);
-
-	p->ret = 0;
 }
 
 #if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
-- 
2.49.0.1151.ga128411c76-goog


