Return-Path: <linux-kernel+bounces-660160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E393AC19A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CBE7BD1F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352521FF4F;
	Fri, 23 May 2025 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNNo8hx0"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D531CB518
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747963088; cv=none; b=WCKMXT51X4Gpk02YojYzkqg9u8L+wYExzCoMNb8V/pDC/YmRRD/IOqMA91IUZoKhvvBg/OJHSSSMhjnf3T1uesH/+tVqzW5w+TYyhZePcHUai9XVuUl0rQeyJ+Zy5OYmLGfyrBR3zeoCe5Ke0URpqk5SrrNxdcJWxMQzrfrnD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747963088; c=relaxed/simple;
	bh=v0i9XFKRas/49gZ2a2wU7oWN5OJL8p0CsC9g9Dbr8MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wb4yjQa8eh3e/W/f5HtfMLk5okAlREXbFvqj7LDYpN2Q+CXTqiyxgNZEwxNRIwemUkNC3ril2dTlljiG2PLx91ecmxLJILC48bh/hXd6Q5VCxg5Blz9gbtNAQ7tEtrlSrCu7OFvbsYi15Illrvo7o5zX89Usvur0JbXr5P7yRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNNo8hx0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e6980471cso6974866a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747963086; x=1748567886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fTBTDLrGR2u813pcv7sYfr/Q+KML7c2us8ddsfnVayQ=;
        b=kNNo8hx08LuT5ABTk+A1MIBYsuxbhVzLIWEjJbpuOJcTPGuHKssqAnLgNZsgJO7B2o
         JodRw9zLo5TUgziJDbInjETACgiLXRhZmGj2dS/NeDNhpDnHxfi8QlJlSHM1wveRyL3m
         vbn91VY26VmLFBZ+zrbkKiBOgwyhxXLOgvP4y+d2hMv6PUFan1zHtSoCw4Ige7wdr3WY
         8wiPZovFQPD9yzTVph4XK/DNewt2Y2q2UZcF9wX27MS3G6c+8FB3fiLKIpLZ9JmEg5hI
         xH3PJIVqPreY6UbJ57dafiQ+EK33CLN47eDIS2AsYZvrlEDl4FkDd3K2SXAti0wmqFch
         abEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747963086; x=1748567886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTBTDLrGR2u813pcv7sYfr/Q+KML7c2us8ddsfnVayQ=;
        b=my0hovPYsDBpaSyNAb3PvwGpa267wKZ9kyHEMOCw6im+uvv4viK1Hd4Wgd3gFAk6g1
         skbzVfJVhDOjmKtqsCcAepfRyyLVRqbBOrHqzb1VUmds4oP8C7hLwHksyo6NTFo+aSCA
         9SvLsgrDfhbaZXpGOqpoMh4sdB+N1CQshYVLcGrLF3E9HhOE0nUW15sdSv+REFTXR+yM
         l43VZkhkpOWjuB+cfuIhkqUH+1l3aSncesTOvZrO/doyw6bIrOfCHuPIUugMIIsOE73r
         hQmG/+EtPAjPXJhBuvSfND0/lCFciJj2V+f/amAZmj4NXf+RFseSZOeLsOTJdoo66sa8
         JlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQGYrKLiDCLWeRs6SZAmiBI7Z844aAufzISNuqQoeBJJ9OotmIY/lkWt3O/VUab7UTyaS4Yosl8oHvl5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfWtu5bJ6NwFoznH0DVPQK/Ovxi6pSJX8XJHg2+KLznMQdSCw
	yUzxMga8j37ZcDet7xSlmcIskRsPajswuJtyPcr1gyxH5UxDrS/QezWIise+tqR24I2kb9Ccxmh
	pupI6NA==
X-Google-Smtp-Source: AGHT+IGpv4P+ODkqYm9t4Pze/9SaR4vsp6B14xH4cnqHe5pE3SxHs7E/dTqTwNcOj1dkoAiUjvMAkLqVaXw=
X-Received: from pjbpq9.prod.google.com ([2002:a17:90b:3d89:b0:2ee:3128:390f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2cd:b0:2fe:861b:1ae3
 with SMTP id 98e67ed59e1d1-30e7d5212aemr41307871a91.8.1747963086468; Thu, 22
 May 2025 18:18:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 18:17:55 -0700
In-Reply-To: <20250523011756.3243624-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523011756.3243624-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523011756.3243624-5-seanjc@google.com>
Subject: [PATCH 4/5] Revert "kvm: detect assigned device via irqbypass manager"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM explicitly tracks the number of possible bypass IRQs, and
doesn't conflate IRQ bypass with host MMIO access, stop bumping the
assigned device count when adding an IRQ bypass producer.

This reverts commit 2edd9cb79fb31b0907c6e0cdce2824780cf9b153.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 7586cf6f1215..b9bdec66a611 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -565,8 +565,6 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	struct kvm *kvm = irqfd->kvm;
 	int ret = 0;
 
-	kvm_arch_start_assignment(irqfd->kvm);
-
 	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
@@ -575,10 +573,8 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
-		if (ret) {
+		if (ret)
 			kvm->arch.nr_possible_bypass_irqs--;
-			kvm_arch_end_assignment(irqfd->kvm);
-		}
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);
 
@@ -614,9 +610,6 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	kvm->arch.nr_possible_bypass_irqs--;
 
 	spin_unlock_irq(&kvm->irqfds.lock);
-
-
-	kvm_arch_end_assignment(irqfd->kvm);
 }
 
 void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
-- 
2.49.0.1151.ga128411c76-goog


