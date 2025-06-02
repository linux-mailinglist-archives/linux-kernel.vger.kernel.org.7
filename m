Return-Path: <linux-kernel+bounces-671095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35908ACBCCD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 23:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C4D3A459E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535B22D9F3;
	Mon,  2 Jun 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/gE50r/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84B22A819
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748900570; cv=none; b=pzagJR/sYYt/JF99TfXbUgDlUqqghgnyydGAFd9bgjO/Q6wAKBHFJr9zLQsQROFl8nTTU4C1kuinMcCnI2jhcfGeqRuCo/r0FwykdsDVkGYemtPpMP9rcpOyUlAU2sa0QOXOU9e6TyIIYJFnm9F4T03wWKpN5bRu2AoVjzh/6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748900570; c=relaxed/simple;
	bh=ckaYtR2Fj0bTMmLPJv/DKzJ6ZVnPamOnPCJGUN8RsNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+ZV3j1tEXKPi/pnk4lPH2208yCk+BhJ74CuS15VnjPLhgjoFDrSrhe9hdHDbmwPYy1oUyWTXoaLwURynCWtG4x2PpkZjfB5qfckbmGwA77RQs7fyln15XIi5sMEa7FclIO+rQS3mC1CtBlm8I4v37mdYtZUQm72mWrHTfP/w5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/gE50r/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740270e168aso3869676b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748900567; x=1749505367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dq9rWg0WQtk35a/syIdVrxIN1jVZ3Xs4zsk5PWEtjOs=;
        b=C/gE50r/vC4ZMqxFyUBaaqwgbBkNkKkfdQWqq397Ib7OxrDUhdLGq365w9HOEMktU7
         34il4QMMfHNM96xl3B23gs0/g6CXRGubTCtFcHclDX3hnCMIpoezfJEoPeBTAY9keqig
         uVKQYVFn3+eQDtRr4wenZGfF5rjQNZWTQaITNM50iVq17VV3V8VWyo6KlwlfbY3Qpqcy
         lDbzPU79MSQacxH3HzdpRPILmS/DG3+eu59fkKvrOiPwoBq8z8C/d6npHmXXQyEEDwN0
         yQK/kdisVjqQ1unHY8tCIpJEo50pf63ELrFAHUut96w/uIWQGeGF/aPs4Jtq0y5K1vub
         xdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748900567; x=1749505367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq9rWg0WQtk35a/syIdVrxIN1jVZ3Xs4zsk5PWEtjOs=;
        b=BCgg4ENciIWpfuOpP8qqmNEu7jjJPCPYRLAZPvWp/i431PABgXI6UNfN18VcfBodf3
         0us8Dn4g9ITMIwwv56bVr74hjZ9KBaRnYNxn228YfCWWm4orwPNnUUF0NR3qbe8Q9icq
         cqrSCbLaYARxSYDO18IL1yMTRAF28NypyJaqOLRPAzL6ux1ysPPyjraafvj0dKP2AtCV
         bOmWqHuyC9jl/SxGBvCJoFYwvqxu8fmrv3+QJt457ezE0ay7MOqlKFCEPWD3hJQMVP/3
         ByT9EOhKDrnuP2byfbetGXaiDaUjEb85xdd7QLhnZTU9x9cmmUBLXVV9QkOjyDioHZ7E
         HSrg==
X-Forwarded-Encrypted: i=1; AJvYcCX1pOBuo/74I3SpIelgovEttxtBI9fEHAIK5TaJV37qkx+AldKlIN5dYychicMx1LRNxcnSDDJfCrN0tNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrE2cNMGHirzSzQP7sNm+NoVOTpbLioV4vb3k7ssswrFJwr6Ys
	U1nAxG79E0xWNjQuMfbzE59SthMHrCcO2VoSFtdD38N8OioFUvKCztXY8IeFcbzHtZkV3/aTR5F
	rR3abwA==
X-Google-Smtp-Source: AGHT+IGP+igBSt2KbXYpY47Cum6/12d7ZKaJ7lAPbHVwRqO4FufM1cqAilI67WNoocjAfjBEbiMhF3OvXWQ=
X-Received: from pfbhd7.prod.google.com ([2002:a05:6a00:6587:b0:746:2e5d:3e6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:238b:b0:736:a540:c9ad
 with SMTP id d2e1a72fcca58-747bda1a68amr19816923b3a.20.1748900567066; Mon, 02
 Jun 2025 14:42:47 -0700 (PDT)
Date: Mon, 2 Jun 2025 14:42:45 -0700
In-Reply-To: <20250602192702.2125115-5-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com> <20250602192702.2125115-5-coltonlewis@google.com>
Message-ID: <aD4a1T7ZmBLNunxi@google.com>
Subject: Re: [PATCH 04/17] KVM: arm64: Cleanup PMU includes
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 02, 2025, Colton Lewis wrote:
> * Delete kvm/arm_pmu.h. These functions are mostly internal to KVM and
>   should go in asm/kvm_host.h.

Ha!  I'm a hair too late, as usual.  I _just_ resurrected a patch[*] to move and
rename all of the <kvm/arm_xxx.h> headers to <asm/kvm_xxx.h>.  If only I had
posted on Friday when they were ready :-)

It's a relatively small series (mostly arm64 code movement), but it does touch
all architectures due to giving the same treatment to kvm/iodev.h (and purging
include/kvm entirely).

Any preference/thoughts on how to proceed?  My stuff obviously isn't urgent since
I sat on the patches for almost two years.  On the other hand, the almost pure
code movement would be a nice precursor to this patch, e.g. move and rename to
asm/kvm_pmu.h before extracting chunks of code into asm/kvm_host.h.

[*] https://lore.kernel.org/all/20230916003118.2540661-15-seanjc@google.com


Diff stats for context:
---
Anish Ghulati (1):
  KVM: arm64: Move arm_{psci,hypercalls}.h to an internal KVM path

Sean Christopherson (7):
  KVM: arm64: Include KVM headers to get forward declarations
  KVM: arm64: Move ARM specific headers in include/kvm to arch directory
  KVM: Move include/kvm/iodev.h to include/linux as kvm_iodev.h
  KVM: MIPS: Stop adding virt/kvm to the arch include path
  KVM: PPC: Stop adding virt/kvm to the arch include path
  KVM: s390: Stop adding virt/kvm to the arch include path
  KVM: Standardize include paths across all architectures

 MAINTAINERS                                                | 1 -
 .../arm64/include/asm/kvm_arch_timer.h                     | 2 ++
 arch/arm64/include/asm/kvm_host.h                          | 7 +++----
 include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h  | 2 ++
 .../kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h    | 2 +-
 arch/arm64/kvm/Makefile                                    | 2 --
 arch/arm64/kvm/arch_timer.c                                | 5 ++---
 arch/arm64/kvm/arm.c                                       | 6 +++---
 {include => arch/arm64}/kvm/arm_hypercalls.h               | 0
 {include => arch/arm64}/kvm/arm_psci.h                     | 0
 arch/arm64/kvm/guest.c                                     | 2 +-
 arch/arm64/kvm/handle_exit.c                               | 2 +-
 arch/arm64/kvm/hyp/Makefile                                | 6 +++---
 arch/arm64/kvm/hyp/include/hyp/switch.h                    | 4 ++--
 arch/arm64/kvm/hyp/nvhe/switch.c                           | 4 ++--
 arch/arm64/kvm/hyp/vhe/switch.c                            | 4 ++--
 arch/arm64/kvm/hypercalls.c                                | 4 ++--
 arch/arm64/kvm/pmu-emul.c                                  | 4 ++--
 arch/arm64/kvm/psci.c                                      | 4 ++--
 arch/arm64/kvm/pvtime.c                                    | 2 +-
 arch/arm64/kvm/reset.c                                     | 3 +--
 arch/arm64/kvm/trace_arm.h                                 | 2 +-
 arch/arm64/kvm/trng.c                                      | 2 +-
 arch/arm64/kvm/vgic/vgic-debug.c                           | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c                            | 2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c                           | 2 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c                      | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                         | 4 ++--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                         | 4 ++--
 arch/arm64/kvm/vgic/vgic-mmio.c                            | 6 +++---
 arch/arm64/kvm/vgic/vgic-v2.c                              | 2 +-
 arch/arm64/kvm/vgic/vgic-v3-nested.c                       | 3 +--
 arch/arm64/kvm/vgic/vgic-v3.c                              | 2 +-
 arch/loongarch/include/asm/kvm_eiointc.h                   | 2 +-
 arch/loongarch/include/asm/kvm_ipi.h                       | 2 +-
 arch/loongarch/include/asm/kvm_pch_pic.h                   | 2 +-
 arch/mips/include/asm/kvm_host.h                           | 3 +--
 arch/mips/kvm/Makefile                                     | 2 --
 arch/powerpc/kvm/Makefile                                  | 2 --
 arch/powerpc/kvm/mpic.c                                    | 2 +-
 arch/riscv/kvm/Makefile                                    | 2 --
 arch/riscv/kvm/aia_aplic.c                                 | 2 +-
 arch/riscv/kvm/aia_imsic.c                                 | 2 +-
 arch/s390/kvm/Makefile                                     | 2 --
 arch/x86/kvm/Makefile                                      | 1 -
 arch/x86/kvm/i8254.h                                       | 2 +-
 arch/x86/kvm/ioapic.h                                      | 2 +-
 arch/x86/kvm/irq.h                                         | 2 +-
 arch/x86/kvm/lapic.h                                       | 2 +-
 include/{kvm/iodev.h => linux/kvm_iodev.h}                 | 0
 virt/kvm/Makefile.kvm                                      | 2 ++
 virt/kvm/coalesced_mmio.c                                  | 3 +--
 virt/kvm/eventfd.c                                         | 2 +-
 virt/kvm/kvm_main.c                                        | 3 +--
 54 files changed, 64 insertions(+), 77 deletions(-)
 rename include/kvm/arm_arch_timer.h => arch/arm64/include/asm/kvm_arch_timer.h (98%)
 rename include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h (99%)
 rename include/kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h (99%)
 rename {include => arch/arm64}/kvm/arm_hypercalls.h (100%)
 rename {include => arch/arm64}/kvm/arm_psci.h (100%)
 rename include/{kvm/iodev.h => linux/kvm_iodev.h} (100%)


base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
--

