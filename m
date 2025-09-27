Return-Path: <linux-kernel+bounces-834827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A81BA59AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A974E17A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF23258CE2;
	Sat, 27 Sep 2025 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9fnKluj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD10276025
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953365; cv=none; b=sDFn7l229umgeXc7XQvS59rPp+8GYq/2fsSYrvKl28nEzWKXz5T4a0GdC9qaHB5uXi1QkV4J74Op/6obcnGU7mMol6hk3CYEUU5nHDhYluaARWu3VcjZJug9jNavec/C6n4/iWgd4vSXJHzH6Xom7UEMgwfkJwp0hOlR/boIpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953365; c=relaxed/simple;
	bh=Aw3LpoKze6Od7iNis+pOk5VCoxGuRw9YdIepK1YikRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kekH4tudAnOX7QRz1VEFuileTh8cO4rr00bb60PpS4zG7AHe15ltqzT2VbVuQ0ESq7Npt5uwqd0jUCKcaSe9otNDNI42dKR6a6E2iNtbDFVJn/wCE49U4k2UmrRrEeErEU03t6xw7bmI12/LjCfEqHcx2i7mxNwSOCUCi7ZnH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9fnKluj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so4684248a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758953363; x=1759558163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FomVTg8fXS3IIL+VtBjYE48chX58x7ITpnVKFfqAzqY=;
        b=S9fnKlujFHiQ8MWiI2JJAyj8k8yGnzK/HnR0vDpiN061iaVX8kzBQkJV7XF3mQ7o1i
         aAflboy93cLI9DLrd6iF5sRShygTMALsuVxHySO0Il5DqgPRSR9vNCLBX730Ue9gnIMK
         zHiZeZ9GHlobT1rV4mvwVKjHKe/zykeDzrXMAiBnrGmiuYjku0uQSxc3aH6f2+AitFuj
         joAOp+PCtE4d+qVCw/+C1HncUhhhVhYEKp5ARncxoVk7bWlLFPcGqr72xW1LTd+wYWo5
         E1GqsSl1AJM9Ph1WVgXeXBCnxms+vd1/RJlouaM5Al4wfZ8qcJzEc9tbuTJuwTuZQjM5
         XK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953363; x=1759558163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FomVTg8fXS3IIL+VtBjYE48chX58x7ITpnVKFfqAzqY=;
        b=APU4ZwDN7u8+DK4krV5aD00M285QGFzjaZfKe+so2CUKPLoWQMCGpz+KVOx3TyZum6
         acWJ9uyq37Www2qj032vPDq07g1u7PeazUkCOAf+GsG3zFJN6+rcu51ZxAykcNhOiKX/
         Zy+nlfwqgufEKovs9zdw1s4gKcQzvmMZqN1E/NQQcF3mPIcK8SWtXMhHuMkjhugCO9c/
         lynqhiRUa3A+P4BkVPWoRFrQb3PnGsb7mZQnUY7gMZTErbCiEQ1tnKVr015RCYpwlTD4
         zSH7EV2I5PXjB8vJnbNp7NLEY0IHRbW6xr0HniyZIUPbeetjSl3+4e9ypOgc06H7VVa/
         K8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdyoKVj1cUNiC0F1TNFRhFL8HtE3Pl/a2R7Z6vequXZnDpgHob5a0uSF6ix80bM1udmGeqy4GvUfUqAcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweR/oCF662yMfLIpV9SRTcYXKkS8plcOBVvxYK3cuprwkP1EtU
	+711bVI6OFi/kWe7INsdQoIxWOM/0tHSBB8zy2+7w6+ueSpZoqM6JZTDVeeohwt4prVxOzxBuHy
	fRZL5PA==
X-Google-Smtp-Source: AGHT+IHGMjhNm8XpXCT9kovxBim2WMFctvMUN3tR5/GKMzL0Upe/cYZE49AAW4RcIPh/KTxREz18WObBlIM=
X-Received: from pjvp6.prod.google.com ([2002:a17:90a:df86:b0:335:2761:ae0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380f:b0:32e:32e4:9789
 with SMTP id 98e67ed59e1d1-3342a257486mr11317437a91.3.1758953363496; Fri, 26
 Sep 2025 23:09:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 23:09:06 -0700
In-Reply-To: <20250927060910.2933942-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927060910.2933942-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 6.18
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The headliner here is to enable AVIC by deafult for Zen4+ if x2AVIC is
supported.  The other highlight is support for Secure TSC (support for
CiphertextHiding is coming in a separate pull request).

The "lowlight" is a bug fix for an issue where KVM could clobber TSC_AUX if an
SEV-ES+ vCPU runs on the same pCPU as a non-SEV-ES CPU.

Regarding enabling AVIC by default, despite there still being at least one
known wart (the IRQ window inhibit mess), I think AVIC is stable enough to
enable by default.  More importantly, I think that getting it enabled in 6.18
in particular, i.e. in the next LTS, will be a net positive in the sense that
we'll hopefully get more "free" testing, and thus help fix any lurking bugs
for the folks that are explicitly enabling AVIC.

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.18

for you to fetch changes up to ca2967de5a5b098b43c5ad665672945ce7e7d4f7:

  KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC is support (2025-09-23 08:56:49 -0700)

----------------------------------------------------------------
KVM SVM changes for 6.18

 - Require a minimum GHCB version of 2 when starting SEV-SNP guests via
   KVM_SEV_INIT2 so that invalid GHCB versions result in immediate errors
   instead of latent guest failures.

 - Add support for Secure TSC for SEV-SNP guests, which prevents the untrusted
   host from tampering with the guest's TSC frequency, while still allowing the
   the VMM to configure the guest's TSC frequency prior to launch.

 - Mitigate the potential for TOCTOU bugs when accessing GHCB fields by
   wrapping all accesses via READ_ONCE().

 - Validate the XCR0 provided by the guest (via the GHCB) to avoid tracking a
   bogous XCR0 value in KVM's software model.

 - Save an SEV guest's policy if and only if LAUNCH_START fully succeeds to
   avoid leaving behind stale state (thankfully not consumed in KVM).

 - Explicitly reject non-positive effective lengths during SNP's LAUNCH_UPDATE
   instead of subtly relying on guest_memfd to do the "heavy" lifting.

 - Reload the pre-VMRUN TSC_AUX on #VMEXIT for SEV-ES guests, not the host's
   desired TSC_AUX, to fix a bug where KVM could clobber a different vCPU's
   TSC_AUX due to hardware not matching the value cached in the user-return MSR
   infrastructure.

 - Enable AVIC by default for Zen4+ if x2AVIC (and other prereqs) is supported,
   and clean up the AVIC initialization code along the way.

----------------------------------------------------------------
Hou Wenlong (2):
      KVM: x86: Add helper to retrieve current value of user return MSR
      KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from SEV-ES guest

Naveen N Rao (1):
      KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC is support

Nikunj A Dadhania (4):
      KVM: SEV: Drop GHCB_VERSION_DEFAULT and open code it
      KVM: SEV: Enforce minimum GHCB version requirement for SEV-SNP guests
      x86/cpufeatures: Add SNP Secure TSC
      KVM: SVM: Enable Secure TSC for SNP guests

Sean Christopherson (15):
      KVM: SVM: Move SEV-ES VMSA allocation to a dedicated sev_vcpu_create() helper
      KVM: SEV: Move init of SNP guest state into sev_init_vmcb()
      KVM: SEV: Set RESET GHCB MSR value during sev_es_init_vmcb()
      KVM: SEV: Fold sev_es_vcpu_reset() into sev_vcpu_create()
      KVM: SEV: Save the SEV policy if and only if LAUNCH_START succeeds
      KVM: SEV: Rename kvm_ghcb_get_sw_exit_code() to kvm_get_cached_sw_exit_code()
      KVM: SEV: Read save fields from GHCB exactly once
      KVM: SEV: Validate XCR0 provided by guest in GHCB
      KVM: SEV: Reject non-positive effective lengths during LAUNCH_UPDATE
      KVM: SVM: Make svm_x86_ops globally visible, clean up on-HyperV usage
      KVM: SVM: Move x2AVIC MSR interception helper to avic.c
      KVM: SVM: Update "APICv in x2APIC without x2AVIC" in avic.c, not svm.c
      KVM: SVM: Always print "AVIC enabled" separately, even when force enabled
      KVM: SVM: Don't advise the user to do force_avic=y (when x2AVIC is detected)
      KVM: SVM: Move global "avic" variable to avic.c

Thorsten Blum (1):
      KVM: nSVM: Replace kzalloc() + copy_from_user() with memdup_user()

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   2 +
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/kvm/svm/avic.c            | 151 ++++++++++++++++++++++++++++------
 arch/x86/kvm/svm/nested.c          |  18 ++---
 arch/x86/kvm/svm/sev.c             | 160 +++++++++++++++++++++++++------------
 arch/x86/kvm/svm/svm.c             | 126 +++++------------------------
 arch/x86/kvm/svm/svm.h             |  40 ++++++----
 arch/x86/kvm/svm/svm_onhyperv.c    |  28 ++++++-
 arch/x86/kvm/svm/svm_onhyperv.h    |  31 +------
 arch/x86/kvm/x86.c                 |   9 ++-
 virt/kvm/guest_memfd.c             |   3 +-
 12 files changed, 323 insertions(+), 247 deletions(-)

