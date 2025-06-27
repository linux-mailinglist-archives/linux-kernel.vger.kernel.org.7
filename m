Return-Path: <linux-kernel+bounces-705457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828CFAEA9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE816E218
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803427146B;
	Thu, 26 Jun 2025 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUZdMufG"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7A26E707
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977822; cv=none; b=OzpRfuLySB5Ai+ZCEDGY2s1vFbjIzUdamnmopjAlaRTmr642ZqA5DR1smKqYSCR12SvbFPAE5WN5YhZynGKbW8tlmSENGxgvXiyLD+YPB6bpazp9XASxUuv7NrpyGvLc+eI1ic10Mv1NiDYofsYH6BgZj7CLlAKt+tB4V2B++pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977822; c=relaxed/simple;
	bh=SAOGsbHcFwt1RIPCltcbSOYs2IVPDVh8pHbL4j2k0RY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CaDERaxvBXvhidsqVpRFAhOaiQmzbmHG+PH55MHwca3+KeyrkZLQDNGXO+xJVDCB1hDQ+Ed2c0R72ndAZmB3C68XR675HR4WnnDQROVBi90MlQL9t5CMTlogv9detkUgg2UxEzVLcQSMsxX4syDfLMGLInCd+roxfh8/GwOmy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUZdMufG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74927be2ec0so2152204b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750977821; x=1751582621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+aNfx32rCA8ptyZuXuy/RXxrC6yFTb63LaStdM2TSw=;
        b=iUZdMufG+YuYoMJgk8LSoEa432xOuOPORY8MIBKuroWu848KKSXGhk0mNWXcEjULeF
         pzRcrI04hyKKY4RYsMmFDsaB6Dy/TlX5zzF6BztGB/er8nLgzvrLMNCzsUjGYPtrQmxe
         mMRmJZyHL3Ka8ioqmQqwp3TY+X45mErD9hUJ1Ws/Yb9kFmuSi1YEGkatFE/4Kdmq+kLy
         BIN8127YUoPQRsU8B8tf/QXi8lkrPSqSJVpnePqIrp52+YLs9jf50LJe6nMuSx8HLSAU
         zsPtEL5g4ZU5Z9I54r1wX80tKW3EpT3qm5uBRXnDEMCluVr0qeI5bfrfXjAOXSyOdY51
         AocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750977821; x=1751582621;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+aNfx32rCA8ptyZuXuy/RXxrC6yFTb63LaStdM2TSw=;
        b=aNCxtXQSKzVRWCKIkp/NdSPsMhpNSNSgn2O/jCABX9qKTWV2PcevOUtQMCxcRWelwW
         9WnTPmAM5gXoHmwsYfEznabOP3ZYQN32xh3AxgzBieoIn6YV87h2CtOXNKdLfiGCXv2M
         dpc5i1P3cXvMXIsbfcofB4gvZ6wGHDOuihXSxHMFcC/A6EqPvtOgrPCC8QMYyy3MDu8a
         sCFujiZVVehO/CRzbP3UVlJRpjjxbDZY09ex56xBnqaBL8ZvfI5veRUGBOtW/K7GZ51u
         0fWpICLkuZE2WXXqp1y77w1igoALNkn5WbunHCz+Adyl6SDwVgCmGXHBx169mp0Pl1lf
         jslg==
X-Forwarded-Encrypted: i=1; AJvYcCWmzDIKVvaJTuDx6h5wSNtvxFQqSZD3Q9igzIeWH8n21snXnEGxanFpwDFaXTZGcIbqDeCW8YuwAbNBcfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VZh4jNccpeC1u0KELgwJF5w3ZAX12EYdCW5wYRwydoJ/aq1B
	2pzqOl/mThcF0NVuh/X36N4stoDmXTfFqbl0+vsknNUcyQOuSjkZmuaKpPPPGcgoB/Snk4Ggz4P
	BqIHnQQ==
X-Google-Smtp-Source: AGHT+IF+I3hj6sD+7mRVKugWfwkI8uGSKayYGM8ET1hZ//75fEERgX12/UwIpz5Ec/SzX4PUw0wWAN3iqZU=
X-Received: from pgcy10.prod.google.com ([2002:a63:7d0a:0:b0:b31:c667:9fce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8f:b0:216:1ea0:a51a
 with SMTP id adf61e73a8af0-220a16ca805mr1016548637.38.1750977820750; Thu, 26
 Jun 2025 15:43:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 26 Jun 2025 15:43:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626224336.867412-1-seanjc@google.com>
Subject: [kvm-unit-tests GIT PULL] x86: Fixes, cleanups, and new testcases
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a self-centered set of KUT changes.

The following changes since commit 507612326c9417b6330b91f7931678a4c6866395:

  travis.yml: Remove the aarch64 job (2025-06-05 10:07:07 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2025.06.26

for you to fetch changes up to 525bdb5d65d51a367341f471eb1bcd505d73c51f:

  x86/pmu: Verify all available GP counters in check_counters_many() (2025-06-25 14:20:34 -0700)

----------------------------------------------------------------
x86 fixes, cleanups, and new test coverage

 - Ensure APIC is xAPIC mode for APIC MMIO tests.

 - Expand the I/O APIC routing reconfiguration vs. EOI interception testcase
   to validate multiple in-flight interrupts.

 - Fix a variety of minor PMU/PEBS bugs and warts.

 - Fix the nSVM MSR interception test to actually detect failures, and expand
   its coverage to validate more scenarios.

 - Add X86_PROPERTY_xxx macros (stolen from KVM selftests) and use them to
   clean up related code.

 - Add testcases for MSR_SPEC_CTRL, and an msr64 config to validate negative
   testcases (i.e. when MSRs aren't supposed to exist).

 - Disable PIT re-injection for all tests so that (x2)AVIC isn't inhibited due
   to enabling in-kernel PIT emulation.

 - Play nice with QEMU builds that disable VNX support.

----------------------------------------------------------------
Dapeng Mi (2):
      x86/pmu_pebs: Initalize and enable PMU interrupt (PMI_VECTOR)
      x86/pmu: Verify all available GP counters in check_counters_many()

Sean Christopherson (41):
      x86: apic: Move helpers for querying APIC state to library code
      x86: nSVM: Ensure APIC MMIO tests run with APIC in xAPIC mode
      x86: ioapic: Expand routing reconfiguration => EOI interception testcase
      runtime: Skip tests if the target "kernel" file doesn't exist
      x86/pks: Actually skip the PKS test if PKS isn't support
      x86/pmu: Explicitly zero PERF_GLOBAL_CTRL at start of PMU test
      x86/run: Specify "-vnc none" for QEMU if and only if QEMU supports VNC
      lib: Add and use static_assert() convenience wrappers
      x86: Call setup_idt() from start{32,64}(), not from smp_init()
      x86: Drop protection against setup_idt() being called multiple times
      x86: Move call to load_idt() out of setup_tr_and_percpu macro
      x86: Load IDT on BSP as part of setup_idt()
      x86: Cache availability of forced emulation during setup_idt()
      nVMX: Force emulation of LGDT/LIDT in iff FEP is available
      x86: nSVM: Actually report missed MSR intercepts as failures
      x86: nSVM: Test MSRs just outside the ranges of the MSR Permissions Map
      x86: nSVM: Clean up variable types and names in test_msr_intercept()
      x86: Expand the suite of bitops to cover all set/clear operations
      x86: nVMX: Use set_bit() instead of test_and_set_bit() when return is ignored
      x86: nSVM: Set MSRPM bit on-demand when testing interception
      x86: nSVM: Verify disabling {RD,WR}MSR interception behaves as expected
      x86: nSVM: Verify L1 and L2 see same MSR value when interception is disabled
      x86: Disable PIT re-injection for all tests to play nice with (x2)AVIC
      x86: Delete split IRQ chip variants of apic and ioapic tests
      x86: Encode X86_FEATURE_* definitions using a structure
      x86: Add X86_PROPERTY_* framework to retrieve CPUID values
      x86: Use X86_PROPERTY_MAX_VIRT_ADDR in is_canonical()
      x86: Implement get_supported_xcr0() using X86_PROPERTY_SUPPORTED_XCR0_{LO,HI}
      x86: Add and use X86_PROPERTY_INTEL_PT_NR_RANGES
      x86/pmu: Mark all arch events as available on AMD, and rename fields
      x86/pmu: Mark Intel architectural event available iff X <= CPUID.0xA.EAX[31:24]
      x86/pmu: Use X86_PROPERTY_PMU_* macros to retrieve PMU information
      x86/sev: Use VC_VECTOR from processor.h
      x86/sev: Skip the AMD SEV test if SEV is unsupported/disabled
      x86/sev: Define and use X86_FEATURE_* flags for CPUID 0x8000001F
      x86/sev: Use X86_PROPERTY_SEV_C_BIT to get the AMD SEV C-bit location
      x86/sev: Use amd_sev_es_enabled() to detect if SEV-ES is enabled
      x86: Move SEV MSR definitions to msr.h
      x86/msr: Treat PRED_CMD as support if CPU has SBPB
      x86/msr: Add a testcase to verify SPEC_CTRL exists (or not) as expected
      x86/msr: Add an "msr64" test configuration to validate negative cases

 lib/riscv/asm/isa.h      |   4 +-
 lib/s390x/asm/arch_def.h |   6 +-
 lib/s390x/fault.c        |   3 +-
 lib/util.h               |   3 +
 lib/x86/amd_sev.c        |  48 ++-----
 lib/x86/amd_sev.h        |  29 -----
 lib/x86/apic.h           |  21 +++
 lib/x86/asm/bitops.h     |  86 +++++++++++-
 lib/x86/desc.c           |  29 ++++-
 lib/x86/desc.h           |  14 +-
 lib/x86/msr.h            |  14 +-
 lib/x86/pmu.c            |  25 ++--
 lib/x86/pmu.h            |   8 +-
 lib/x86/processor.h      | 332 +++++++++++++++++++++++++++++++++--------------
 lib/x86/setup.c          |   1 -
 lib/x86/smp.c            |   1 -
 scripts/runtime.bash     |   5 +
 x86/access.c             |   2 +-
 x86/amd_sev.c            |  63 ++-------
 x86/apic.c               |  20 ---
 x86/cstart.S             |   3 +-
 x86/cstart64.S           |   2 +-
 x86/emulator.c           |  11 +-
 x86/emulator64.c         |   2 +-
 x86/ioapic.c             |  52 +++++++-
 x86/la57.c               |   4 +-
 x86/lam.c                |   6 +-
 x86/msr.c                |  36 ++++-
 x86/pks.c                |   2 +-
 x86/pmu.c                |  37 ++++--
 x86/pmu_pebs.c           |   3 +
 x86/run                  |  15 ++-
 x86/svm_npt.c            |  27 ++++
 x86/svm_tests.c          | 240 ++++++++++++++++++++++++++--------
 x86/unittests.cfg        |  30 ++---
 x86/vmx_tests.c          |  11 +-
 x86/xsave.c              |  11 +-
 37 files changed, 792 insertions(+), 414 deletions(-)

