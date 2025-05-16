Return-Path: <linux-kernel+bounces-651956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F66ABA52A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11CF3A61CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4705280308;
	Fri, 16 May 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGU1WcHa"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB742280034
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431007; cv=none; b=AanNJomtQ7PPSWA8PKywRdoqXzjQvzg6SAl7J7Dcq2IiYDpQqJkYrkJ2D+bZVCNqFH7CqTw+1QSib7CpVN9VGFMTv0Msms0PEduFPW1Jfba2cAHt+1Wr8CTJUhabhQdqQRzkkuC6PFMQWxLj28cudYjk0zrVqZPg6C4hH3VgybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431007; c=relaxed/simple;
	bh=rU/OOmXSxzdbXeVGOVp3Atr0buHumvJkkL63QEVbDk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E7hogexMa77wJ4vRoe3ZxERFgoCKbFcnhaUq08gvz4NG7YYMmVlavRTQdrYub35BfRDqNYPxWtxhF2fI8gRW0zDurMQGCMPbE6dwZONNhdsbUzk72b/H+2fVUxjaAQyzPUqSNfdcN59gxpxLB8HEjWYW4tbOcfHtOGjFOmQAnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGU1WcHa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2318043effaso27996005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747431005; x=1748035805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl8sKId1p4fnSWsbXS5nPLz/0J3dr2L1BPCgdcqnxp0=;
        b=uGU1WcHaBipogCUU3hXvzA0CjoyVheHr8s7lhmBElXt/4lqJ+xeSMWTTFgpQ1cTcJ5
         xdSiF6eAqkOWnP9Yp4Yh/vxnuULaOUP/S0CWN5z/sAWy+BAU6R3/+UUh9SXQsK01i7Op
         iiEajK5eFgFJbsjlbzYS5xeKg3PDBj95Njz9HqZHO4FxidMooGVurKudehAT107J4rNk
         u7RG6pwaILeAz00HkynkC2rNqjHyTwpRfrhoKZ1uE0OI1YyoLzj8yBfZA6Jb1OlO0W/5
         t6a6tcDipvEeJbkEVGg+baWU0Czhr6Yp8aqhmLYS0JdWF49hNwF0arCgFd1X2Ggysn8Y
         NPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431005; x=1748035805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl8sKId1p4fnSWsbXS5nPLz/0J3dr2L1BPCgdcqnxp0=;
        b=cfAvqJ4JsCkrcAE9s+LcheTLbryPp4xz82f5U60YiSXVOZF+VciSQFeZ1vtOtU2C1K
         sWTOZu5udkq4T2ba/EvX1rfi9PDL1uIzaaKZ6dC3CGUb4Ij1mvFfb2/mbyDSot07dwXw
         zmGyjv5N2w+P/9oz/VLksZl4BAT32FGywfiQIr7jrIKPuHCZ/6t2uK/TTKWOdJmbBIip
         uWkscqhl41gAbB80R4I2pvRYn7TODrsWCzJs6iIiAY8YKoEd+Dbj5V+sdo7zCJZ/2vYb
         oLaDrmvZ1jGtmWOmmccJFuy7rn6Vk8x0acJFeZ/by570FMx6T8sXwD72ZFlJbxr/Hyd0
         IYlg==
X-Gm-Message-State: AOJu0YwM9l1ZCauNqNoNzbJJunomzzvfTR/8Lth1QpuJoDkT4XmwDQPZ
	LbjnbFZdBPpp6LRrYteOSC0dPET4AP1umBxfZZoQ0zitQKZx//IaIY1iBqx9xVEx6DXLSvtlbPS
	t03Hnug==
X-Google-Smtp-Source: AGHT+IF6I89C9mEIARSlw1bcJepJA60kvrJai+jIj3fEWudVeM5rH1kouHgj/taWzfpRfkrGgw+/t4fBuRo=
X-Received: from pjbsw16.prod.google.com ([2002:a17:90b:2c90:b0:2ff:84e6:b2bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d07:b0:224:a96:e39
 with SMTP id d9443c01a7336-231d438b420mr68386655ad.9.1747431004975; Fri, 16
 May 2025 14:30:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 14:28:26 -0700
In-Reply-To: <20250516212833.2544737-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516212833.2544737-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516212833.2544737-2-seanjc@google.com>
Subject: [PATCH v2 1/8] KVM: SVM: Remove wbinvd in sev_vm_destroy()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Zheyun Shen <szy0127@sjtu.edu.cn>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Kai Huang <kai.huang@intel.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Zheyun Shen <szy0127@sjtu.edu.cn>

Before sev_vm_destroy() is called, kvm_arch_guest_memory_reclaimed()
has been called for SEV and SEV-ES and kvm_arch_gmem_invalidate()
has been called for SEV-SNP. These functions have already handled
flushing the memory. Therefore, this wbinvd_on_all_cpus() can
simply be dropped.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 978a0088a3f1..e9fd3bcec37a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2883,12 +2883,6 @@ void sev_vm_destroy(struct kvm *kvm)
 		return;
 	}
 
-	/*
-	 * Ensure that all guest tagged cache entries are flushed before
-	 * releasing the pages back to the system for use. CLFLUSH will
-	 * not do this, so issue a WBINVD.
-	 */
-	wbinvd_on_all_cpus();
 
 	/*
 	 * if userspace was terminated before unregistering the memory regions
-- 
2.49.0.1112.g889b7c5bd8-goog


