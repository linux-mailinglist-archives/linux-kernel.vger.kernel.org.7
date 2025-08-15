Return-Path: <linux-kernel+bounces-769840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C27B27453
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993585C7385
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56015185B48;
	Fri, 15 Aug 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNtZ9T1i"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918E2D052
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219452; cv=none; b=byI/grmDkOT7Qa6TpTBpXU7duhkgRHc5ItEhvcAZg+sPiWP/xFxVBDQLsjpG5Ddsjnh0Mf3hQkaIH52qhRTMnmMtAH9FZpUzd5SFsG9VRuNkT+hzEnB7hWcmHIl4je0lIycXPpj3x8JTX3BvpnAQ0vn4oLfIPLmP/cY9Lslg8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219452; c=relaxed/simple;
	bh=9t9FszQWUhMri63drGVSczqbrk4+8tTMRg7vpbRoElE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GmKAR5qigLGoUoGEFyEw6e2HjlSXCzz8ko1XzaHyiuHUi/YydjlFZNb/JdgI3Y9KXRbY9Apwt2vpS8l7m7kTsoUSzpniFIb3X5p9zrB2+I4jRC5fMhOL0vFeRa7TiBezTF5+R5h4mdsWjrY5G4knlm0jY/Id3Dn5XTjyPTcbW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNtZ9T1i; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445823bc21so30264595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219449; x=1755824249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiwqRmmCbJXPteijHQcOHZyVOII/6Ocy4eYGUGiwKhE=;
        b=gNtZ9T1i7tT3qsRJZ+m2iebh44delc+lq86uHQ8amyDve2t+/DhkMeZioYc8+Y5jkh
         zzHlFmWBCCrO/UuMzZz0tSqwD22pAzEad6qmzrXLGiZtWAJYMC1DkfP02b4rrDaJ3WjP
         xs2u96giYCQyV4AvYVboZ/aWst/TPbJ1cT0ERzwBTR56VR7K+AkudKM/iHoWnDSO8oXF
         4WwaVy7dnw369qMnV7AdlfHhovnPy5/TKKQL2iHNWkZfSYTGlr3D1/gt/Oa7P/+UHbg4
         fcCZgxrD4bGypUcr7MuS3wlof7/Ub+2H9MIftBotbNFCECCAupJWjBmWm3D9BvIOrpi6
         cZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219449; x=1755824249;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiwqRmmCbJXPteijHQcOHZyVOII/6Ocy4eYGUGiwKhE=;
        b=aHFRn5UoBWsP2PfSaCRBLv1KFb1I++yAuBZrVACbaLxtXrNJh3MwHUZKOhnVcZ4AHL
         hNTbNM23rSu0hxBgf8Pe0VFQMWxp5sDOdZHIR0jreicb+Tcq8j2eaSacAVCr06tyYTey
         W6jiq7P5hj/j0UX8BiIR56IzzcDJKpI13+e2Qagod9fG1HbPwXO4UdFc9XXP+Gb9BHfe
         wsJFCwA/KacziSYZAx5zvohqVzEu8RLVWUKQaAQymJfTXva2Eud2OiBvNSUj7oEAk6VK
         S7mht2eiMRyJGp9I/uAXhVJUW14+oJCEYAT9QpDyBxP0JGEXNbZQfmadjrllsEOuOg0S
         GsaA==
X-Forwarded-Encrypted: i=1; AJvYcCWDIk0CR1/tB2e7TTXtKlg+M+AYtqxwDtmvA9nG74lRmBcj61zifvY2l5v0JXCODkcyPwCJLbfB37WB13s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsmlGg2ED/crzhTRukSKTB2nxVDTuDr6Qc4wqrr4NCbBPVqbw
	NB79AAeOKe7iGzNI2D74lg0yUg3BhskwQQtcZc0JSmkhaX8IZjppYltGnnzVMIrYx67XSgi3l6v
	hHJS1BA==
X-Google-Smtp-Source: AGHT+IEr6R4fe01LLKu3KV8wgkRfMZ3b9gIIuv8qMD6A7q8+n+fl8TsnN+y41iNkRNs4BR6s5fMF6bIaeCo=
X-Received: from plbkw12.prod.google.com ([2002:a17:902:f90c:b0:243:47b6:afae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f82:b0:235:15f3:ef16
 with SMTP id d9443c01a7336-2446d6ed729mr3093825ad.13.1755219449271; Thu, 14
 Aug 2025 17:57:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-1-seanjc@google.com>
Subject: [PATCH 6.12.y 0/7] KVM: x86: Backports for 6.12.y
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

More KVM backports, this time for 6.12.y (and with far fewer dependencies).

Same note/caveat about Sasha already posting[1][2] many/most of these:

  KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
  KVM: VMX: Extract checking of guest's DEBUGCTL into helper
  KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
  KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs

I'm including them here to hopefully make life easier for y'all, and because
the order they are presented here is the preferred ordering, i.e. should be
the same ordering as the original upstream patches.

But, if you end up grabbing Sasha's patches first, it's not a big deal as the
only true dependencies is that the DEBUGCTL.RTM_DEBUG patch needs to land
before "Check vmcs12->guest_ia32_debugctl on nested VM-Enter".

[1] https://lore.kernel.org/all/20250813182455.2068642-1-sashal@kernel.org
[2] https://lore.kernel.org/all/20250814125614.2090890-1-sashal@kernel.org

Maxim Levitsky (3):
  KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
  KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
  KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the
    guest

Sean Christopherson (4):
  KVM: x86: Convert vcpu_run()'s immediate exit param into a generic
    bitmap
  KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
  KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
  KVM: VMX: Extract checking of guest's DEBUGCTL into helper

 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    | 15 ++++++--
 arch/x86/include/asm/msr-index.h   |  1 +
 arch/x86/kvm/svm/svm.c             | 14 ++++----
 arch/x86/kvm/vmx/main.c            |  3 +-
 arch/x86/kvm/vmx/nested.c          | 21 ++++++++---
 arch/x86/kvm/vmx/pmu_intel.c       |  8 ++---
 arch/x86/kvm/vmx/vmx.c             | 57 ++++++++++++++++++------------
 arch/x86/kvm/vmx/vmx.h             | 26 ++++++++++++++
 arch/x86/kvm/vmx/x86_ops.h         |  2 +-
 arch/x86/kvm/x86.c                 | 25 ++++++++++---
 11 files changed, 125 insertions(+), 48 deletions(-)


base-commit: 8f5ff9784f3262e6e85c68d86f8b7931827f2983
-- 
2.51.0.rc1.163.g2494970778-goog


