Return-Path: <linux-kernel+bounces-780675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FDBB307BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937344E0EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710C26F2BF;
	Thu, 21 Aug 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syIvHM/S"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8728BABA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810048; cv=none; b=S+LdordkrYp/ykdJh0dvRzPDkM+D1jwHvLZv4+T/GDt+XAFabZ+z3RSAM/MOcqee4C5QEUUOI1MB9YWo/V1VwCKhZqcBKcRmmuGQqBKbw5IOmC3iyX2C1h8cYwEf/zUfLFpdvIHnVvvY/MxAlYRz2FuSKAGxyBPBu1+jdlheoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810048; c=relaxed/simple;
	bh=pnhR4u7zzImF/Q9sjPpvcLTIm1nBKcxgPPtEJd8L7Pw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t8iBK9F2C1GIcLTIspJspOvfaSCPKpgzVnOF7b+z6mEzXyWcguPGiTv/dN6UVrMoAG6keua4gOxYTrATVRsxvQV1phSFs/1sgSeRW1g4XAhqIBTT+OzlCverIPAqgRAbLAyIiVKvEguERyRIqF4rWxOWRYvuiFZNVPV1cPhlQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syIvHM/S; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce388so31490995ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810046; x=1756414846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRu9EPlqPIRbrAwuhln90egPhix9C1W7TbuFz42eH5A=;
        b=syIvHM/SSsULbRMVFd+GO/p3egT28XkjimpN0GfKXGQAscPqHOQaKV/0BTnQQKnAUP
         M0sAX90dii6YtQarahTkADKLEwwpU1504XUgIy6CzpzQ3qVVxbXnZSLh5ADCycMmZPWo
         bKWDMifmqhPsK6t+e0KaE3DI/b1DvRaUiQkTzLdDdWOJw/aaJwNuze3aEVvI9V97xiSM
         Bbm0IEP0Us9dkUjS/2/3rGSnHSoMG4XdurSlwYhVMOOStKdE4yTGz3ruE6H0rbGUKEaj
         QzkTfhCmoy2Wzo87EivixS3BzW8K1/NMD+rbEQezb/6vrSeXI1MDMxDwT23Gyn52NdBY
         vGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810046; x=1756414846;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRu9EPlqPIRbrAwuhln90egPhix9C1W7TbuFz42eH5A=;
        b=G2WTFUYl2xlOB1BsQVIiD+nxuKTRr0GN3NlTlS9VttDDfdheANrBnePQe4uOzDkO6+
         PJj7DS868z1kEd1Gxq4UPLwbL9rEwtCX1znfsZs9M3nLdsZtbPFnPFT+ZBHjjvhg5jGy
         8qBmyY/+mb1it/cECrIes4/CwiSFRql+5Biy+u0+koC4HifL/JNcAWt4hNWa6aMhoT8W
         8INb5CPNdWSldwOsDwzw3uaXeplujycxrBsf8UNmAkEwpC1vAjqTofgE6KHT4SxFX2tq
         PnPf5y2S7GlUpTQ5VjvOAfO8spCI2mezE8f5R7HD6+U0wR0TuC5kBM0gTSi95D0U9ooJ
         NtHg==
X-Forwarded-Encrypted: i=1; AJvYcCU11yK9eaKec8ru6h/m5J2X5hrOScyALCPLfm7yiQldnekBuv1xsZi/ZD9aSOG9r1NEGD6ulYUYSLk21v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiNNHD3ou1zaJs/GA+c9g6ldfSjwidwVeAHB66DivjmmPOY4u
	JeZdGM4RB7RxifjmTyUY6hwB5xjENDtBw50C4D0emtBE8Y1ixk/K/qRqTaBTu4U4GjA/CF9hByo
	Df5imog==
X-Google-Smtp-Source: AGHT+IHZUS2rRBwXbx5vsu0uArLnBj6wHgoX5fZrabl/HszonPOiLFCujnncNL374CLOxHiZbqaT370jPEA=
X-Received: from pjm15.prod.google.com ([2002:a17:90b:2fcf:b0:31f:61fc:b283])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f552:b0:240:b075:577f
 with SMTP id d9443c01a7336-2462ef1d579mr9364185ad.37.1755810045874; Thu, 21
 Aug 2025 14:00:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-1-seanjc@google.com>
Subject: [RFC PATCH 00/16] KVM: arm64: Add "struct kvm_page_fault"
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an arm64 version of "struct kvm_page_fault" to (hopefully) tidy up
the abort path, and to pave the way for things like KVM Userfault[*] that
want to consume kvm_page_fault in arch-neutral code.

This is essentially one giant nop of code shuffling.

RFC as this is only compile-tested.  I didn't want to spend time testing
until I got feedback on whether or not y'all are amenable to the general idea.

[*] https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google.com

Sean Christopherson (16):
  KVM: arm64: Drop nested "esr" to eliminate variable shadowing
  KVM: arm64: Get iabt status on-demand
  KVM: arm64: Move SRCU-protected region of kvm_handle_guest_abort() to
    helper
  KVM: arm64: Use guard(srcu) in kvm_handle_guest_abort()
  KVM: arm64: Introduce "struct kvm_page_fault" for tracking abort state
  KVM: arm64: Pass kvm_page_fault pointer to
    transparent_hugepage_adjust()
  KVM: arm64: Pass @fault to fault_supports_stage2_huge_mapping()
  KVM: arm64: Add helper to get permission fault granule from ESR
  KVM: arm64: Track perm fault granule in "struct kvm_page_fault"
  KVM: arm64: Drop local vfio_allow_any_uc, use vm_flags snapshot
  KVM: arm64: Drop local mte_allowed, use vm_flags snapshot
  KVM: arm64: Move VMA-related information into "struct kvm_page_fault"
  KVM: arm64: Stash "mmu_seq" in "struct kvm_page_fault"
  KVM: arm64: Track "forced" information in "struct kvm_page_fault"
  KVM: arm64: Extract mmap_lock-protected code to helper for user mem
    aborts
  KVM: arm64: Don't bother nullifying "vma" in mem abort path

 arch/arm64/include/asm/esr.h         |   6 +
 arch/arm64/include/asm/kvm_emulate.h |   9 -
 arch/arm64/include/asm/kvm_host.h    |  32 ++
 arch/arm64/kvm/mmu.c                 | 514 +++++++++++++--------------
 4 files changed, 282 insertions(+), 279 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0.261.g7ce5a0a67e-goog


