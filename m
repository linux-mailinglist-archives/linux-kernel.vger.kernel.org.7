Return-Path: <linux-kernel+bounces-856821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8FBE52CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C16428764
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F923B611;
	Thu, 16 Oct 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqTGUXj6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504123816A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641615; cv=none; b=BtZ8gZnPrdXLPZJe1EYY1csC55TZprMrJoeXNgkcy72pY+TO2T51vACQWp11Cc2ed4GSzZlziFDbHKGSySckDQ+ULijFsNYwelV3ibcFLJwe4cNOMpCAm/hzcnKFgtnjNgrroVz2DcjxhnL+SXdlSBU9VCvVptaNabI0A7t4hRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641615; c=relaxed/simple;
	bh=YBxESa1CpdXRaPWaeva+4lHFBA8rLlw/72FIwmffHyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=btmnyYrzewLT/Yjh0WcV+JUzbsbneLGnorPCPmbqf1+LjXsONeZ0CMzpuoG2in2BuYBZwLwS7N4SUAKfAC8mxBmZhY4qb8i7kmTN2GOEw+azsHybCmZo7cSWSbXnNo6jMurZTAn7zyuHFqftwEWCF+hRXijL+RklL3IcW5z0Iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqTGUXj6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2681623f927so10692825ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760641614; x=1761246414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LABRqD9aUZpUjVf9UfWBC/peaZw13rHiQXEQ8T+Co+c=;
        b=QqTGUXj6Kvo5pGOCVucnTuR7nVHE+jW+cRQeqvEumQcV7kKPBEjpBX9r3exbpjJuoQ
         se/cu+I0639UX7lOKB4Zh/eMJpGUTtIbbSUiVELLNnI2RcmXiBrMWarrh0ErzDSllVV/
         vJTOm4lMMjwZJbDtcoy4kpu9vhH1TuxhrCk/uXt3lZ/HaFbL9DYgePOnkbiZvPJQ2Hs5
         P/8TollonBRepGzsqHqSw5uTYxf7d7NizJBodNuASBrBEBNFi8a7M8ORJnSmn0609Bm6
         iRTZLwhtL7DFkwxXVGeh/ktnnNMHsaXTQ9k1kewNTPdJPpI1pn/9JoETIkAJynv3L4hh
         0BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760641614; x=1761246414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LABRqD9aUZpUjVf9UfWBC/peaZw13rHiQXEQ8T+Co+c=;
        b=CDoCf4qPbUiGStb7OiKGzzq2O9ku3TKl3lCoASdTaQc1yhxNwJwjcJGskLmlBJVt5r
         i8uO4zlUuXePzA7RRVW3Okt13HEfi7F74axPgMRsQRIELhetapisy5Ahn/srEzHZP9mv
         aJD3x7Y3ybsLoPCvxcVAAKXHMIlngGbYfT61c1surqhDTY3F6w34yC8fvbknbJC/HJz7
         7lBbytFkJDR15AwPjlSO0f6iqYtY4qNExqcIJLjGPtXnl5zr4kD4C62T0UJq8JYj8WdW
         M7aqnWn1w7HFwBytLrxHQ67uSt9PfnHhK9CNDYZCTv7Qy8cyqZKXl1LQ6TXhGVyH7JuQ
         q70g==
X-Forwarded-Encrypted: i=1; AJvYcCXFrO4Jr6tKGS2vJAVRwDFdRsHtVBiJR6xbdsPzlbMjGPrRy0S+j7XhJcwoA/jZ2UqkrL0y8HdGyLJg1oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+bR42L4aN27Y6W85ydP2K2By7DFzlLK5Lq6QSXwOlX0uNX3T
	AHtM/aHjm0WCm5ZXguiXTMz9C6uMFf3D187JraeYYHr2KxmJaCAWXQFToPo7nt92dHEWf8OXg7E
	vshLRvg==
X-Google-Smtp-Source: AGHT+IHNkssHfRpTSPJv5vfJ0hG/avsJSbtPbn9niGhmFXN0nZWxcs3w1T94tFkiYA6sCa29Eo7CxIho5sU=
X-Received: from pjbge12.prod.google.com ([2002:a17:90b:e0c:b0:332:a4e1:42ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c8:b0:27d:6777:2833
 with SMTP id d9443c01a7336-290cb18415emr11317135ad.47.1760641613662; Thu, 16
 Oct 2025 12:06:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 12:06:43 -0700
In-Reply-To: <20251016190643.80529-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016190643.80529-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016190643.80529-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: SVM: Make avic_ga_log_notifier() local to avic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Make amd_iommu_register_ga_log_notifier() a local symbol now that it's
defined and used purely within avic.c.

No functional change intended.

Fixes: 4bdec12aa8d6 ("KVM: SVM: Detect X2APIC virtualization (x2AVIC) support")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 2 +-
 arch/x86/kvm/svm/svm.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3ab74f2bd584..89864fee6e83 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -216,7 +216,7 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
  * This function is called from IOMMU driver to notify
  * SVM to schedule in a particular vCPU of a particular VM.
  */
-int avic_ga_log_notifier(u32 ga_tag)
+static int avic_ga_log_notifier(u32 ga_tag)
 {
 	unsigned long flags;
 	struct kvm_svm *kvm_svm;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b0fe40c21728..8c36ee0d67ef 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -806,7 +806,6 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 
 bool __init avic_hardware_setup(void);
 void avic_hardware_unsetup(void);
-int avic_ga_log_notifier(u32 ga_tag);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
-- 
2.51.0.858.gf9c4a03a3a-goog


