Return-Path: <linux-kernel+bounces-756941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7AB1BB56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CF23BE543
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA9C24293C;
	Tue,  5 Aug 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6aYExZi"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0E1E5B88
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425350; cv=none; b=bRSsVtxjpz00d6GRZhBWjzKnR7LX2NYvBGJTHutIgxri4lLU9klutvr+OWwN0YhZgE2l8aYMMH/0WwuwW5lhkRBVtfunQhR/v5PskJY+xUVWqIVGqsmKnW+G8sJy1vq/WRAhojM/7IyWO+8F4/Lgsu8MUKrChSGMT6/NxCSQcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425350; c=relaxed/simple;
	bh=QcBUlYt1R7LPHeweiP1yPx9OZlFVFmYXWZvSDuChNI8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iUTm24Co4Am60AIqcuxeBKH0Z/rONF4UcB6uG564qHLcx2kBaJa057fJLwuOxP8hvdXjeEtRrl7CQ9pqzO4e1A10sgXsSd50s4gy7ihb5ulUAT8y6tVrUeRBZQKEGmOYbmynXspBfTA2JrXg9kerLcW8mEvQ0ziXykfpSNyGNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6aYExZi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31edd69d754so4530650a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754425349; x=1755030149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIKuNcCEEy4d1Lnb9vFuuPNEj5BYXJY2MfS6bx587ys=;
        b=r6aYExZivSM5ZVcbCBx/GpXgO7wolXJ0vQ2tTN9q96xKva9HiGr+r9YAlOVycT6ae2
         9uDSm928UHoJlzv2eUR/MUTzSWCM6EIyNHog4gWaSKTVN4IF9LKC6LqqQTNEBmqWMgIe
         0vN72LpLMOViftgSvV12Q5LfpkGqyEAhRgQM1hl/OqZZEHvLOAR253WpvoeZxLiG3R5+
         EeRWeRFvBRkxxoRNwcWjyuKdsB1KYvfDQ2sEv19MYZ4CbIDqIja0UrRv+jZO4+al3cpe
         2c7GyqaMiZ+nqhfls2KtQ1gfRdhVMJtakmjrn5i3bmTNhEPcMcttRj37gYTfrqX7N5ct
         7AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425349; x=1755030149;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIKuNcCEEy4d1Lnb9vFuuPNEj5BYXJY2MfS6bx587ys=;
        b=iFhVTtSpOWff0SbB1VRqbS7y2hNK0qhMhAwkXjpRYro9AhALtpAzYKjsEu9m7mrEPD
         zV4NJd76LGKO6Ux8p9zvVgjU81fgpkwTwZdUKIGa719UfL/HvB+jB5O1yxygYaBVd4Co
         jZ3w1s/2oLPceeONVI/xadQucfVQBdFejstYnW5xM3LFMDR/unEANfO7v0oQNb9n6L9+
         K1KQM6HjxZRMAe96T+VSoWXlKeSPUEgA0WPjG0eg9AjuVFDk9ZT3M07+MvZ6bZTOUeF+
         fRKbIhBK7SIDiJ/Akd8gry3DoyTCiZNvRq/xVMtHx5uBG4P/Uf6eRUHdAZNtRKKLL6Q1
         m+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWxHncZxMjEjArKMZadrN7eFlcynhz8zw1p7PZ75GMkE95wpeqRpGZEU2/vMLlmP4UEzNobZW/ALdaf0NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYLxBepj8F1Lq+5e9wd8r1UJQ0QQbB+rb6vOGcVx87Ruppnxl
	5YvvorV0cmN9Cm6JCl2eQXmtT4+w/D6rEnCyh2aytOabacYSqC2XN8g86xaeISRnYgpeovJSf24
	TnJ9HXA==
X-Google-Smtp-Source: AGHT+IE6U61qhafIDWBzagByS8xaVy780THwV6kGJd6xzP4Z+/iOWdC/TR08MgA3sk98reGaWJVBTybIPvc=
X-Received: from pjqo21.prod.google.com ([2002:a17:90a:ac15:b0:312:1e70:e233])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3848:b0:31f:1744:e7fd
 with SMTP id 98e67ed59e1d1-321675ac368mr90445a91.31.1754425348700; Tue, 05
 Aug 2025 13:22:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 13:22:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805202224.1475590-1-seanjc@google.com>
Subject: [PATCH v3 0/6] KVM: VMX: Handle the immediate form of MSR instructions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On behalf of Xin, to avoid having to resolve conflicts when applying.
This applies on the fastpath cleanup series:
https://lore.kernel.org/all/20250805190526.1453366-1-seanjc@google.com

This patch set handles two newly introduced VM exit reasons associated
with the immediate form of MSR instructions to ensure proper
virtualization of these instructions.

The immediate form of MSR access instructions are primarily motivated
by performance, not code size: by having the MSR number in an immediate,
it is available *much* earlier in the pipeline, which allows the
hardware much more leeway about how a particular MSR is handled.

For proper virtualization of the immediate form of MSR instructions,
Intel VMX architecture adds the following changes:

  1) The immediate form of RDMSR uses VM exit reason 84.

  2) The immediate form of WRMSRNS uses VM exit reason 85.

  3) For both VM exit reasons 84 and 85, the exit qualification is set
     to the MSR address causing the VM exit.

  4) Bits 3 ~ 6 of the VM exit instruction information field represent
     the operand register used in the immediate form of MSR instruction.

  5) The VM-exit instruction length field records the size of the
     immediate form of the MSR instruction.

Note: The VMX specification for the immediate form of MSR instructions
was inadvertently omitted from the last published ISE, but it will be
included in the upcoming edition.

Linux bare metal support of the immediate form of MSR instructions is
still under development; however, the KVM support effort is proceeding
independently of the bare metal implementation.

v3:
 - Rebase on the fastpath cleanups.
 - Split patches to better isolate the functional changes.
 - Massage and expand on a changelogs.
 - Make a handful of (mostly) stylistic changes (shouldn't affect
   functionality, key word "should").

v2: https://lore.kernel.org/all/20250802001520.3142577-1-xin@zytor.com
v1: https://lore.kernel.org/lkml/20250730174605.1614792-1-xin@zytor.com

Sean Christopherson (1):
  KVM: x86: Rename local "ecx" variables to "msr" and "pmc" as
    appropriate

Xin Li (5):
  x86/cpufeatures: Add a CPU feature bit for MSR immediate form
    instructions
  KVM: x86: Rename handle_fastpath_set_msr_irqoff() to
    handle_fastpath_wrmsr()
  KVM: x86: Add support for RDMSR/WRMSRNS w/ immediate on Intel
  KVM: VMX: Support the immediate form of WRMSRNS in the VM-Exit
    fastpath
  KVM: x86: Advertise support for the immediate form of MSR instructions

 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  4 ++
 arch/x86/include/uapi/asm/vmx.h    |  6 +-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 arch/x86/kvm/cpuid.c               |  6 +-
 arch/x86/kvm/reverse_cpuid.h       |  5 ++
 arch/x86/kvm/svm/svm.c             |  8 ++-
 arch/x86/kvm/vmx/nested.c          | 13 ++++-
 arch/x86/kvm/vmx/vmx.c             | 26 ++++++++-
 arch/x86/kvm/vmx/vmx.h             |  5 ++
 arch/x86/kvm/x86.c                 | 94 ++++++++++++++++++++++--------
 arch/x86/kvm/x86.h                 |  3 +-
 12 files changed, 139 insertions(+), 33 deletions(-)


base-commit: 53d61a43a7973f812caa08fa922b607574befef4
-- 
2.50.1.565.gc32cd1483b-goog


