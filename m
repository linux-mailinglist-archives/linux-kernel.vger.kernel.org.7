Return-Path: <linux-kernel+bounces-823808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10EB877A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4115263E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A32230274;
	Fri, 19 Sep 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z99SU4Z7"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2C1D5170
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241996; cv=none; b=reejqj9YM5joZVSpkox88xK2wWyIIFpf/GqESm23nf3ejm8qot+g7eOjy4dB6CqyXNylOtZzPprC0iHMUuLul1LZelJcDC2NXdeRx5X09vz6xxrI/n5vBNePpT0h5yQ1R2n8pJ2oIqJEjQFfRO1h00nPPTDwtEIVWfC5rWwiKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241996; c=relaxed/simple;
	bh=7ou8wxMoGQAGbCdOuqhfRktG4I8uJDQLMhLPE0ujZjc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NaOULsVuWFxK7SNR/nyW1gf1HLYQZ2ncolVsZQBcnVUMkDaCa75DIQ3KxNqdrq6GK/+6tfpG4Df1ETmQF5Fr1FZylHITsp8JKr7GTCeNfty40maW1Hk7Ot1iwhhrY6EOWCYzKWdR1ZwSEtdctIyhP5UvoXHhtAPQHD1l4K1alDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z99SU4Z7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b550fab38e9so672626a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758241994; x=1758846794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1cGeGaHWP255DyHLqElEz4ZozH/AyhNkucTFTu+Syc=;
        b=Z99SU4Z7p0bSXq9BO5tdEzM8zWh8bKh6zcPA92XUAftoqwA4RYVWP/y9oprH29Sb2i
         ULob8d7kUJFYnA8C5TSWpC4yvaXF6ya5EG1ULp1lPeweUxzSZ3A0nM+NtsSAjljLP8fd
         ePDERxd4YnVkj7M/Ep1n/AGc5HEVXrMySO4SlfpPAk65NJeBCEaV2NjQ3aMpjIiBjVpO
         DNWTx9HojJmc8Cg9+Jf+rRQfPbFo5637ujZVohpxCdGOWe1JxWOkQH+q947fncII6HxQ
         mgvFp/5pfjGbFoePF7/f/maIw8zPhDKDIE8m9oPIh0Wuy0nZ0pE7ErPqLlOjaXtPzlOm
         c+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758241994; x=1758846794;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1cGeGaHWP255DyHLqElEz4ZozH/AyhNkucTFTu+Syc=;
        b=wfHeLO8FFQujX8Qx7GTXPTBdxRgRnhx+FkWXhqGYI1f2e3x+Y80pTkqzkWdXL6ZgDO
         6OJwzMkefnhNqFy1OPlhn5slH+A7qwm023CI3wKvq0ZOhveqxd/RzY+Zz/BKe4KAzild
         13yt9VypCS3y83yxBcLgSwbr3PKPcAxGNVIDSyM/pvwhnbb6lQ7lm7LR1KOTXT7SQtrC
         FHpG1UZ+3+bH+XT5ErERYbJkR4ddR0y5nqITOgz50r/U7Fruxtl74VDa+GzFlux9YLLr
         I+ImDtJSRQMUEpG6aOl3dGr/uhWSw7SKVqcMqOL47XwFH6iFdSLJ/q9MnwDuGNYQ6WHi
         hN+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQmEcPCCvWNYo8gRnUmYiryRXNlMqu0XhBWUDN6X1RR0udsXlsi6YNu6NuZJaWcU/mZq23BTE+vHjkGvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0SV0QrhJomw6SNLJqoq4UJnjRuqwiM6qibeOdvO1SaYCk33e
	vcjHexVwR6FH1sXXL8but5PcXaerVSz0yC0d8+Erl+EyO2gKMQELYMAATgUOfKc4e9OQGgH9Rdp
	6Wuw2Ng==
X-Google-Smtp-Source: AGHT+IHhyh8RoFNFrbu7IWcTsJ8pGyYjiNB6Kv85S1lDZyDd2mWZEdW+4zL3DWhvxw7SMmsA++3rAzK4CyQ=
X-Received: from pjv14.prod.google.com ([2002:a17:90b:564e:b0:32d:69b3:b7b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5491:b0:251:9f29:453e
 with SMTP id adf61e73a8af0-2926e840fc8mr2025266637.39.1758241993727; Thu, 18
 Sep 2025 17:33:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:32:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919003303.1355064-1-seanjc@google.com>
Subject: [PATCH v2 0/5] KVM: Export KVM-internal symbols for sub-modules only
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the newfangled EXPORT_SYMBOL_FOR_MODULES() along with some macro
shenanigans to export KVM-internal symbols if and only if KVM has one or
more sub-modules, and only for those sub-modules, e.g. x86's kvm-amd.ko
and/or kvm-intel.ko.

Patch 5 gives KVM x86 the full treatment.  If anyone wants to tackle PPC,
it should be doable to restrict KVM PPC's exports as well.

Based on kvm-x86.  My plan is to take this through the KVM x86 tree as there's
an annoying conflict with an in-flight patch, and except for the vfio-ap
change that's been acked, PPC is the only other architecture that's at all
affected, and KVM PPC is maintained separately.

v2:
 - Omit the x86 patch, for now.
 - Drop "GPL" from KVM's macro to match EXPORT_SYMBOL_FOR_MODULES. [Vlastimil]

v1: https://lkml.kernel.org/r/20250729174238.593070-1-seanjc%40google.com

Sean Christopherson (5):
  KVM: s390/vfio-ap: Use kvm_is_gpa_in_memslot() instead of open coded
    equivalent
  KVM: Export KVM-internal symbols for sub-modules only
  KVM: x86: Move kvm_intr_is_single_vcpu() to lapic.c
  KVM: x86: Drop pointless exports of kvm_arch_xxx() hooks
  KVM: x86: Export KVM-internal symbols for sub-modules only

 arch/powerpc/include/asm/kvm_types.h |  15 ++
 arch/s390/include/asm/kvm_host.h     |   2 +
 arch/s390/kvm/priv.c                 |   8 +
 arch/x86/include/asm/kvm_host.h      |   3 -
 arch/x86/include/asm/kvm_types.h     |  10 ++
 arch/x86/kvm/cpuid.c                 |  10 +-
 arch/x86/kvm/hyperv.c                |   4 +-
 arch/x86/kvm/irq.c                   |  34 +----
 arch/x86/kvm/kvm_onhyperv.c          |   6 +-
 arch/x86/kvm/lapic.c                 |  71 ++++++---
 arch/x86/kvm/lapic.h                 |   4 +-
 arch/x86/kvm/mmu/mmu.c               |  36 ++---
 arch/x86/kvm/mmu/spte.c              |  10 +-
 arch/x86/kvm/mmu/tdp_mmu.c           |   2 +-
 arch/x86/kvm/pmu.c                   |  10 +-
 arch/x86/kvm/smm.c                   |   2 +-
 arch/x86/kvm/x86.c                   | 219 +++++++++++++--------------
 drivers/s390/crypto/vfio_ap_ops.c    |   2 +-
 include/linux/kvm_types.h            |  25 ++-
 virt/kvm/eventfd.c                   |   2 +-
 virt/kvm/guest_memfd.c               |   4 +-
 virt/kvm/kvm_main.c                  | 128 ++++++++--------
 22 files changed, 324 insertions(+), 283 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_types.h


base-commit: c8fbf7ceb2ae3f64b0c377c8c21f6df577a13eb4
-- 
2.51.0.470.ga7dc726c21-goog


