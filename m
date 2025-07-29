Return-Path: <linux-kernel+bounces-749835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB205B15377
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FA718A6369
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4A293462;
	Tue, 29 Jul 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dw5dQutD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3AC260582
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817632; cv=none; b=oZng6ktOWaFFSs7/BMW3mFnzyyWmzecMZDS2InF0s+WMTYAjg8Tck3jXz/SoEyvdkXhD1lCszZJbAWnzEskSYEG0GDE5tOwFgyZiFOYmh56yt9pvMT1vk1qEm4+O45DQ9YmmnSiboZ9ykaLLLVkn9NT4oCbnU6V8xhoCWPTw8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817632; c=relaxed/simple;
	bh=sqgm1EIxKlNrAgPRJQWz+ccC/dJ7P7wFp1H9ZQzuLhw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRdrfHNj4MnjAeewjTeQyLovO85FTWGrGPPXIyQkTRtJDal//a6GZyABYB1l+icqS+hQQwTEPCfkSM4UvDmYrtmbiUqrhrW1a9Rapp2C8bZZubQaC+W5GhPEVraaK/g/l2Hpr0u3V8lfxuZrbfZNKwvbL+k4fhXRYv2W+wrMMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dw5dQutD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ed2a7d475so2822225a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817630; x=1754422430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JJX8dU8+n+0QNuI44F28R1+g564ctZSa7EPvc3ZFM1U=;
        b=Dw5dQutD1AQktBJZnfWwu/psiv4pYLyZN9TSImEP3IRqHg5D3v8tlrSWUhtf7Ys+Bl
         8X6h+hVLebqlKjiJiuxuaIilf/14PPMh7P9xELldDIQpuRp6OYncSi0tzunnKB4jy2RA
         ESWYhaA1EzW6JiqvSaGP1zLMa0EUO3PYkTM/5ASfEkzRsVRte0xwjawlVlITWLK4njSj
         UzsQKcLgkROUFMCSbHAjoLWwDOkWZIT/GJJNiGP5lmch4woQEN4r+kzv1Xgx1gDuz4GJ
         st9eT8lk/QPVHD7i0X9+OXGLCnuOIKO7nRBQlq8M0KVSdmByao/bfs4Zbq6HFQiiJcr3
         PY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817630; x=1754422430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJX8dU8+n+0QNuI44F28R1+g564ctZSa7EPvc3ZFM1U=;
        b=dLU050eBNy+cO7+Lz7gGqv6qGT0JmzQWntzv2VWAueU4QFynylIV1NgcjA2p8rqh4J
         mDRJUo/OlMH89BRvDPpPdpo4tgsbeqc1lSU/iFG1O0f3yCV//sgclUBdtSoHQj/fLvw6
         gfRD41uW5rUGS5bqtDGZC41dh1DQpdKDz9mk1r8O3ag4EWTlTh/CTIXToX6Hz89hLRz7
         RGWru27VmqQHk65CEpng3wQ5P70hnTdDxahPKK70I/ZGQ9h/a5nQ4757HjZ5uOYc7qZE
         lfwtV4yZReRm3RvOBeugkafnNGHMP391jmiKCPrMIcXWMXNeHwfbaHeTW2975WclJ/Sw
         P05A==
X-Forwarded-Encrypted: i=1; AJvYcCVcAl4VLtk2TkR9spiKtAtf8a8oI0EQeHb5Z0Kp7ycStP9DiCVukHc/IrdIRY86uV4aWJSS3YcMvDaxT6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YySf0DKN/KxKs4yzVNh79Q/iPLWANwzL6ockLJOUDX8PPHtCjSC
	2lcqJBWOj61ll1v+tHJjcEmnMwiPRFjg0kEHMaCIVtUnDGuE9oPysyCZoALXI9Q3h2x0avZ1SZI
	+zSGpMA==
X-Google-Smtp-Source: AGHT+IHfEWMEuUfBMeiKYE9aLfHbALVYy3IIrBllmmLaQcn7q2hIwc6mBe+teoBHRd1eD2W+YlhcAuMLoXU=
X-Received: from pjbpv8.prod.google.com ([2002:a17:90b:3c88:b0:31e:998f:7b79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33d2:b0:31e:c8fc:e630
 with SMTP id 98e67ed59e1d1-31f5de73bf9mr824146a91.26.1753817630463; Tue, 29
 Jul 2025 12:33:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 12:33:37 -0700
In-Reply-To: <20250729193341.621487-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193341.621487-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193341.621487-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: TDX: Exit with MEMORY_FAULT on unexpected pending
 S-EPT Violation
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

Exit to userspace with -EFAULT and a valid MEMORY_FAULT exit if a vCPU
hits an unexpected pending S-EPT Violation instead of marking the VM dead.
While it's unlikely the VM can continue on, whether or not to terminate
the VM is not KVM's decision to make.

Set memory_fault.size to zero to communicate to userspace that reported
fault is "bad", and to effectively terminate the VM if userspace blindly
treats the exit as a conversion attempt (KVM_SET_MEMORY_ATTRIBUTES will
fail with -EINVAL if the size is zero).

Opportunistically delete the pr_warn(), which could be abused to spam the
kernel log, and is largely useless outside of interact debug as it doesn't
specify which VM encountered a failure.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3e0d4edee849..c2ef03f39c32 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1937,10 +1937,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 
 	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
 		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
-			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
-				gpa, vcpu->vcpu_id);
-			kvm_vm_dead(vcpu->kvm);
-			return -EIO;
+			kvm_prepare_memory_fault_exit(vcpu, gpa, 0, true, false, true);
+			return -EFAULT;
 		}
 		/*
 		 * Always treat SEPT violations as write faults.  Ignore the
-- 
2.50.1.552.g942d659e1b-goog


