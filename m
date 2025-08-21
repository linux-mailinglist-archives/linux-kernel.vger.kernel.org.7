Return-Path: <linux-kernel+bounces-780683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75757B30803
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B535AB07D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B052D7DF7;
	Thu, 21 Aug 2025 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYtWLudv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666CD393DC1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810061; cv=none; b=ppmLyfYDAOuug6+lLTg05b3BLWIiWlCk4tz+MjkjWQZPeEqQZ7jkp1WZMSgjOrELfBQOeA2TF61sz0BPivm4iBWlcd+CHRc/IkooczOQBKzOAmcT9D7+a2yDPc8istojVeG531hrGR4NahJGcdKCUKLL1GnzNSuaMFVZZ13snMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810061; c=relaxed/simple;
	bh=ABhvefXpoIuEQ5mRvyqgcnHqEvoUbf3IKbz3Y8+eKrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHtzK/xMUrR5gYxjK+X+63osuY0sWVXX9IosQfecZoaZDIrG2k/A/4MAV0d8cpr6hM/CPCdaeOo6OL18E4P+dhdnwBVBcYRv9BZRA8PS4iTPzRj0xah/hVkfOoX7C180IhkugOARVD92KceK670IGeffvX9l/QdKetMy9uXJ6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYtWLudv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f54bb2so37582555ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810060; x=1756414860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qF0NqksTmsFEMXYPOijW2W+Po4z2kEGBRHxGZcBCgsM=;
        b=NYtWLudv3YsFzR/EfmOeSQ+hRqUY7Q9sWOoHEC3Dw2LoIFSVv8FY+qCDhhv09y+49Z
         CqT+LgwE9IQtGzbVYj4UnhRsMI/0W5uTPXLyIqTrrR7BT4CGz81tKujRklszhYqp+zUl
         pnaSAsIHEOfgu79o5qpMeQmcUJsUTYBotw29HrXbj8KVb3yi/lKNnk2Wgi7ETmXiApcV
         Q6pv1PhZjTpi55Amu1SAhUMXNfEA4TrDzJS3GMjZgZbDeRanFUtuApZ+B2ifAIICuBQQ
         sZHEEaHjZXSXoIMrP4Bhu5kVxrSPQy9uM2/BKFWvQh42+tTBWHJGaet01CInCvCUXpFS
         n3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810060; x=1756414860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qF0NqksTmsFEMXYPOijW2W+Po4z2kEGBRHxGZcBCgsM=;
        b=s9+LwPrUpGEGuR7wk045yDqzix2OzjaJJlQqORkhx/XbocnageGGYh0hhrXRU1F74d
         n3jVfou/I5bE9kyLnDHTAEGt2eFIHzRViJUCEwOMX8jb5Oox6EiRvtXQXG1qqUuTsc6W
         A+8fcR0mZTqwlZ1kLRS8lnULt46pjRN/OwSRHT1i7W56qiPr6ufhlsh9IJCBGvhTrzCG
         R3uCtkD3QmUI8DBrGPgGuu7yLWz2cvoAdaslu3gUOvf/Qt0+C+BMiOsO/lxlVK8TLws7
         2qNNea2ugQtwuMCVJ6BmUpaf9EIB40j7mtQrFtKeUR+FYyG9qxKc6yoqokhLiE5PBJGi
         0S5w==
X-Forwarded-Encrypted: i=1; AJvYcCWifxQfJJYlnzlLo172iTd16zwwBY24fPp/XMKE/wxMuLXaf88hCJ8A9hJy7YlHwQ3Gzqu7OqBDt7MB3T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydH4mWcIHQJpuB3T18vifsCowPXfdDu46Ib+glSF6V5UtMHQxa
	mJ5F/DcLiI1j0Y0gvsL9N1Y9PEk6aV5pIhoOyj79jyCZD6lvMjjeqNfSL2qmT7dSLtveBM7cgpm
	zMGyQTQ==
X-Google-Smtp-Source: AGHT+IG5Izpq2Sl1N9Hzv50wRfJpmndOfATaks3Z+gYK79D4NeWWn/zwR5Uaz/7EA8M4H+pgD0lOKvSxa0c=
X-Received: from plgv17.prod.google.com ([2002:a17:902:e8d1:b0:23c:7695:dcc5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce01:b0:240:52c8:2556
 with SMTP id d9443c01a7336-2462ef44433mr9049685ad.39.1755810059747; Thu, 21
 Aug 2025 14:00:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:34 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-9-seanjc@google.com>
Subject: [RFC PATCH 08/16] KVM: arm64: Add helper to get permission fault
 granule from ESR
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract KVM's code for getting the granule for a permission fault into a
standalone API that takes in a raw ESR, so that KVM can get the granule
from a local copy of the ESR instead of re-retrieving the value from the
vCPU.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/esr.h         | 6 ++++++
 arch/arm64/include/asm/kvm_emulate.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index e1deed824464..5bb99cfd184a 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -8,6 +8,7 @@
 #define __ASM_ESR_H
 
 #include <asm/memory.h>
+#include <asm/pgtable-hwdef.h>
 #include <asm/sysreg.h>
 
 #define ESR_ELx_EC_UNKNOWN	UL(0x00)
@@ -478,6 +479,11 @@ static inline bool esr_fsc_is_permission_fault(unsigned long esr)
 	       (esr == ESR_ELx_FSC_PERM_L(0));
 }
 
+static inline u64 esr_fsc_perm_fault_granule(unsigned long esr)
+{
+	return BIT(ARM64_HW_PGTABLE_LEVEL_SHIFT(esr & ESR_ELx_FSC_LEVEL));
+}
+
 static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
 {
 	esr = esr & ESR_ELx_FSC;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index fa8a08a1ccd5..8065f54927cb 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -455,7 +455,7 @@ u64 kvm_vcpu_trap_get_perm_fault_granule(const struct kvm_vcpu *vcpu)
 	unsigned long esr = kvm_vcpu_get_esr(vcpu);
 
 	BUG_ON(!esr_fsc_is_permission_fault(esr));
-	return BIT(ARM64_HW_PGTABLE_LEVEL_SHIFT(esr & ESR_ELx_FSC_LEVEL));
+	return esr_fsc_perm_fault_granule(esr);
 }
 
 static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
-- 
2.51.0.261.g7ce5a0a67e-goog


