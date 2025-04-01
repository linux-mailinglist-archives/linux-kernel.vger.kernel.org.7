Return-Path: <linux-kernel+bounces-584124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66753A78379
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C4716C7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984721A447;
	Tue,  1 Apr 2025 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="az1JtS7x"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF414AD20
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540415; cv=none; b=jsgv1YZMyd92plQZSwcw5e48M2kybLUuzi2g8yI/L0SMDUftJE0F0CbPO+MT9/TihZmj/chpPA1O7KmgSOfITz47x17722rlI/9JxsLH0+vaWh/bxiMBSWobP+qKmqfGHuZCQ5sNjP7CDNEp8a/DiiCXDXaVfckfj+PWLDtSOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540415; c=relaxed/simple;
	bh=n5kNCwE5Iky7W7cF5KbIIZcTecdXBfhV99PPLi3pmUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pkSnVGKskZhJijsJnV5bXOynDc6hj/osJyA94oRZjYt4sF9FI3KSvJ5phSFwJ1EHrXg6nLuapf+7oGL1PtZKLks3NLL/fhMT9S0gvoQHftRlIt+icoRFPI2njGSk2B2U2yRNk0/8qacwmIdyeiEY9WTl5BfXOKusr6MwbB25WL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=az1JtS7x; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30566e34290so1442953a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743540413; x=1744145213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HjN0v0W9m0IvqgYola2hOx5XLKml5O0udJOiHGE/eik=;
        b=az1JtS7xhDSs7uBWcG0wzhOyjV5Kt49ItVvyz9xEA1/S+qnR2c2GiK/D97nYUGCFwC
         qAO84UnBptl5VHR2QfzxZMzhBwLDwe5VPhL+iNv4061C48MeFJivaNwyTZnUfyNSL5m2
         axeR+JAxMGZHF6an5cIwctkV4AEfZKO36ad2KVLxJblI/oJLEy2gfaTEfJCZUNqa/+Av
         Mcy8i+HPusLFxS1PaQqhwXLVvpqj/i+HdbamO7/j8nW8BUH0VaOoGbV2Tpb0y5+jStDx
         Bw8fb50tLIKwEaO2t7SrvVE//+yPb/eNTj5E87vmAqSdDV1UfrcD3VdtJgz6TnoInGyN
         fDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540413; x=1744145213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjN0v0W9m0IvqgYola2hOx5XLKml5O0udJOiHGE/eik=;
        b=S0G3AXglAx/bEKV3wlbYI5VRRD/sUyjmx3Phjwak7KZqt0oVE0P+bBPufZ4L/2KVd3
         A1WKfFfkyoxUEeZXx8ZSwHi16LLodzZgfDjh4O4LEEVtgMf1MnzQTViUq6bjbVNhj5OF
         HZ8pLFUyHQBLUU3xZOlq1ujw2p0NgaTZXi8cGoqDYzTTeFziri/kWC+ePMjm5Tz1iySS
         NbaFoVje83gWjxDHLvHnL4irt6p1NkUrHEdkHrT+Ks7Tj9pi47KK6gj/gXMAoN8T3lah
         IseN/N4hH7kchB3wRKMm7CyacRmMPhjKI5TqeFfp090r8QlP4MJab/ZLgkzxir5r1geE
         caTw==
X-Forwarded-Encrypted: i=1; AJvYcCXNmMa4WmKyqgYbnWdHzDNc3G66GD3Esw8v5QrJGgO7ykklmGMF9KH6yIz22JaqS2zFabT/USVpsHWC/mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9PHpiWP8Q8XTv3xrcVdlavGjLNZIuEvU1Pov+BFb32GQX5GS
	rJpKIrwGVEuwayehVbcZayS3bI9QoUi3XyulV7CuW218MSsE0SGEcjsQIkOWYfDvTkKE2590Ki8
	1yg==
X-Google-Smtp-Source: AGHT+IHcYPdS+ntkX0QFkx6mSIlTj1AO51n1TbjklGmZnx1XnyN+enbKGYXER1TOaq4aVQk11+wCSyWBHf8=
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:2f9:c349:2f84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dcc:b0:2fa:157e:c790
 with SMTP id 98e67ed59e1d1-3056ee181a6mr177513a91.5.1743540413076; Tue, 01
 Apr 2025 13:46:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  1 Apr 2025 13:44:15 -0700
In-Reply-To: <20250401204425.904001-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401204425.904001-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401204425.904001-4-seanjc@google.com>
Subject: [PATCH 03/12] KVM: Initialize irqfd waitqueue callback when adding to
 the queue
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, David Matlack <dmatlack@google.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Content-Type: text/plain; charset="UTF-8"

Initialize the irqfd waitqueue callback immediately prior to inserting the
irqfd into the eventfd's waitqueue.  Pre-initializing the state in a
completely different context is all kinds of confusing, and incorrectly
suggests that the waitqueue function needs to be initialize prior to
vfs_poll().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/eventfd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index e47b7b6df94f..69bf2881635e 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -256,6 +256,13 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 	struct kvm_irqfd_pt *p = container_of(pt, struct kvm_irqfd_pt, pt);
 	struct kvm_kernel_irqfd *irqfd = p->irqfd;
 
+	/*
+	 * Add the irqfd as a priority waiter on the eventfd, with a custom
+	 * wake-up handler, so that KVM *and only KVM* is notified whenever the
+	 * underlying eventfd is signaled.
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+
 	add_wait_queue_priority(wqh, &irqfd->wait);
 }
 
@@ -395,12 +402,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 		mutex_unlock(&kvm->irqfds.resampler_lock);
 	}
 
-	/*
-	 * Install our own custom wake-up handling so we are notified via
-	 * a callback whenever someone signals the underlying eventfd
-	 */
-	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
-
 	/*
 	 * Set the irqfd routing and add it to KVM's list before registering
 	 * the irqfd with the eventfd, so that the routing information is valid
-- 
2.49.0.504.g3bcea36a83-goog


