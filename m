Return-Path: <linux-kernel+bounces-639793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782CAAAFC78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92C716B996
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F3266B59;
	Thu,  8 May 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZQgNjfL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF187265611
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713423; cv=none; b=E2hWGxsSJhCTSzasICTHbE4Ly0GncBpW092Gbb0YjJIojwdZmOFYWzYiahh/EDuBwwPxXigJ2JChl3e5TZLYcp4o4ipdkAnriWVQKVThYNzbkOXpCDiEbRJJaYClB/qoufRvUolyDCkkumPOntw839Sv/8ecokqJGKJgV5vA0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713423; c=relaxed/simple;
	bh=rBZ8oHeY+uQoBWsAP98N8CQDCX40XW60zl1C5BKmQ7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhtHQOzdY+9U2ltVzVbrh/GQXGKl/f5yZLtXcB/FMkbz3gzFr9f2iw0g7va9fNmqpEhh/dIWDzbgx4yBClJ/1bU94sz+tDS+PUcebOa8r6f9hb+e2ZBZippxItmEQdwLiyYXRd89gdG0TEtqg8vNvh8a6gmb5enyihpen6p+kiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZQgNjfL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736b5f9279cso1085034b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746713421; x=1747318221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KJVX1DCqX7vbNbrylbBP6BivBKN94o2apUJMFPAVyIY=;
        b=yZQgNjfLY8tMCqmk/kgtHcZGrwP+oXxFgh1o3ToR8ifTATCjTnpwLEfFcf607mTV3l
         ZKlrYYUPZMyWKFDSlyJ1YcM/zxjw1TtNtt2VveUG71ZdDu7TtoI6uW+XVxdAfpiOyjKE
         FqTJbwgF701mkifSYOt/vGBVrz3fAKOtst4iqCGApXJGiank5KlFqK/i2CJJoY5FXdqS
         +g8lxUb/hqKZMsbXEFIsYuL590X1UlCZ0HVKePbLWnr08onXu/dUAZyk42JHNLaM8SgP
         FCySqyIxKoWwc+LFFamibqBJqckq+43yB4lnaqpgNksC/mwNe2Vk7w/NXdPY+lW+p0sW
         XuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713421; x=1747318221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJVX1DCqX7vbNbrylbBP6BivBKN94o2apUJMFPAVyIY=;
        b=MXaVaMLEr7P8Ssyl1+oOxMF7BxAihYx0WPBPiuEZqzt+zdV8fNeKYF3glRpVI+pyNZ
         of/2KeBa9quNQFiHrnGtXfUgbhDWhJTX7hSgzHtpSxy/TBvoPR1XojDSkkwyX+Oq4USf
         uqaBupdDdChDxNnDIkKAGDb4jE/cpntDKgM3g77umzxlI6SLQbiMWB7vXYL4+FbFKLVB
         cP9UQIOHMpkH4RzmVVO6HlkStsrx9XJFvm/f8YNMzWXvqaHr/XcSYGWgrq1e/DDKtpG2
         WVpn2ALFJKCH2CiFMoiwhCyjMlpBzi3wwf6rCK0eYpWZdnpkQ7cNSFrOgyzKkNqsVMIg
         yONQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrpYrCz1NZcs6mHXBIrTAhpOyRcf3pl45+Wq6LlbKtvWfjoVeSh1Ii45UgbruivwNHc5vutO6mbZeokSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqi1BGcJ2fSeQUBwkhyGsXQHfXMLS70zzhb2l9ptA+zqU+Y22r
	il93IuqiqtJemqEy6Z+t33hchklZ866dM/zyNvEC0sDzyRzN6htFh2kwjMGdur+4oJD8asphZjo
	pug==
X-Google-Smtp-Source: AGHT+IGeOozbRNnQDObWfA03lfKGbI9CmCxprWmItBaqzUSnplsOV8hYwrU5Or4chHdRZ8SUt7GQWEf4fi8=
X-Received: from pful19.prod.google.com ([2002:a05:6a00:1413:b0:740:addd:daba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2908:b0:72d:3b2e:fef9
 with SMTP id d2e1a72fcca58-7409d00d6fbmr11961256b3a.20.1746713420600; Thu, 08
 May 2025 07:10:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  8 May 2025 07:10:10 -0700
In-Reply-To: <20250508141012.1411952-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508141012.1411952-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508141012.1411952-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: Conditionally reschedule when resetting the dirty ring
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When resetting a dirty ring, conditionally reschedule on each iteration
after the first.  The recently introduced hard limit mitigates the issue
of an endless reset, but isn't sufficient to completely prevent RCU
stalls, soft lockups, etc., nor is the hard limit intended to guard
against such badness.

Note!  Take care to check for reschedule even in the "continue" paths,
as a pathological scenario (or malicious userspace) could dirty the same
gfn over and over, i.e. always hit the continue path.

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu: 	4-....: (5249 ticks this GP) idle=51e4/1/0x4000000000000000 softirq=309/309 fqs=2563
  rcu: 	(t=5250 jiffies g=-319 q=608 ncpus=24)
  CPU: 4 UID: 1000 PID: 1067 Comm: dirty_log_test Tainted: G             L     6.13.0-rc3-17fa7a24ea1e-HEAD-vm #814
  Tainted: [L]=SOFTLOCKUP
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_arch_mmu_enable_log_dirty_pt_masked+0x26/0x200 [kvm]
  Call Trace:
   <TASK>
   kvm_reset_dirty_gfn.part.0+0xb4/0xe0 [kvm]
   kvm_dirty_ring_reset+0x58/0x220 [kvm]
   kvm_vm_ioctl+0x10eb/0x15d0 [kvm]
   __x64_sys_ioctl+0x8b/0xb0
   do_syscall_64+0x5b/0x160
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  Tainted: [L]=SOFTLOCKUP
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_arch_mmu_enable_log_dirty_pt_masked+0x17/0x200 [kvm]
  Call Trace:
   <TASK>
   kvm_reset_dirty_gfn.part.0+0xb4/0xe0 [kvm]
   kvm_dirty_ring_reset+0x58/0x220 [kvm]
   kvm_vm_ioctl+0x10eb/0x15d0 [kvm]
   __x64_sys_ioctl+0x8b/0xb0
   do_syscall_64+0x5b/0x160
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/dirty_ring.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index e844e869e8c7..97cca0c02fd1 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -134,6 +134,16 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 
 		ring->reset_index++;
 		(*nr_entries_reset)++;
+
+		/*
+		 * While the size of each ring is fixed, it's possible for the
+		 * ring to be constantly re-dirtied/harvested while the reset
+		 * is in-progress (the hard limit exists only to guard against
+		 * wrapping the count into negative space).
+		 */
+		if (!first_round)
+			cond_resched();
+
 		/*
 		 * Try to coalesce the reset operations when the guest is
 		 * scanning pages in the same slot.
-- 
2.49.0.1015.ga840276032-goog


