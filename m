Return-Path: <linux-kernel+bounces-893493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB4C47965
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53783BCF18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A65246795;
	Mon, 10 Nov 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEK+Zlnb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyS0Eybc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E026738C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788337; cv=none; b=liJkB4UuxQPoI0zI4bf4FS05pJrytZRihM5zMNCNVbmNoY4bThPHVZ1KnoXTh3mCXUz/Gye5jZ8KDHWRRSqky1LIZw1rLeFzSwwfqHkU716hKIaA8jiNFo4XP/SglLkNHDUTY1VRbdEgC35WmePHAWXzLeVZbDiQfwUv7Rc5MEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788337; c=relaxed/simple;
	bh=3PdoaQ69lO98fxJxlxz78/56MDJZTv4E2mJnO7/mo0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irX4Z1roSTr9ewsnHPWK/hlgU5u5I2cFFEL7amf3toglcCgtJwoCvLj9CUnexIQaoh7F8l0YlfTc8nqt14S8cr9HtW7bQsScnVWCo2tL0T5fLlK0gAY1lOxL/Q4vj2LdfCUQpliqlo55mbNxN5l4ckNtnjUNxjyHt6xWRz213fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEK+Zlnb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyS0Eybc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762788334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YJCJNPxt+7zeWQvgKHWvJDmRLvWvUbVuicewdqhIuZQ=;
	b=DEK+ZlnbW9M6T4AvWBZSVvZly4a1S0aiuF3TAOPvIIAMxxKxOGCeuaSLrk5m/GcR3kD9H+
	OkolgnNZ3t8wI4Hn4jO30rIUYmJKvAnJpMVxZA++vKnG8txxXQGlvcxF30u50e2WR/N0xK
	TZatyYUAlia8nN/fb0ca4jLqmYEikBE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Zi97cUCrMQCuhJpBvCHADg-1; Mon, 10 Nov 2025 10:25:28 -0500
X-MC-Unique: Zi97cUCrMQCuhJpBvCHADg-1
X-Mimecast-MFC-AGG-ID: Zi97cUCrMQCuhJpBvCHADg_1762788327
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e597f6fbso55401465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762788327; x=1763393127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJCJNPxt+7zeWQvgKHWvJDmRLvWvUbVuicewdqhIuZQ=;
        b=OyS0EybceKhO2JMX/AcPD9wKbeXdRFDTPrQKz1K9tJSHcH2afuf8NSLptNXFEcu9H/
         TsWe6qzgg8bI+6W1qrARFbq5XCDD+G3Mx69dtFugYFFUo05DXO7kLQTzeVQxtbxyU64F
         kVTy6F500ntb3BBSCsAn6zphffsmzw73/Tg0BXKh2KZuIhn7X22tpySL9A1eedOUJQN7
         e5xySv5XsDEYZqGk6aklyepwxaet3jaZilZC+2xzoZg4kQqKKgPST5hMNCU8iSOXRLJW
         7PUsdOYEznMc3JLxKUBUCGr3ICMiJjxwGaJQ8e3uL9JzD7SX1hASitwTaL34XkqRQZSi
         8zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788327; x=1763393127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJCJNPxt+7zeWQvgKHWvJDmRLvWvUbVuicewdqhIuZQ=;
        b=PODNZ4ppy4qRc2nhIY+j3FrzucC3EHjwgD2AvFcWGT++GN/fOIxNdydA4FB+EESTwF
         6yQ4cyzEk8rY6xs2ZsEPoaqCz4pGJ/XZX4aoV1Z6+/0EQAAuPCDkyAkaSyZKeSf2LBRH
         BqA4sR+yP5PsdlotgcW9yVbBsMBGW1eQSORmwf/Ei9k5QZ6547qxLYTramaS/1KkZn8D
         7AKLDTgnz+U+h7XilO93pmwWs2a98zW832+eylYcQr6p2pRVT8uNaouQ3ZLlf4NkSWfc
         3oIcDl5rhZtNSMbTz2S9VRsQ0B9VcSZyxjKa3ggFPGxinAaobgJo+7/Sq3KJubx7rKpp
         63sg==
X-Gm-Message-State: AOJu0YwxBaCpNP16kPP9cDM0516x4KukKcPy11pK49+lckyQNlfybahq
	Cy/bVm/mNqosXu8RPrhav1a2V55LJxLb3Hy6ZpcwszJjQmMzIQrRTwXHk9wauw88aAnfonkM6Ow
	1/PGmZgkv5feGadvduU2XOQ4uvx7R0ZGgKbff7ZB6u3ZCWIU3dJ/k/m/03wjstuhdSQ==
X-Gm-Gg: ASbGncsQWbicUevDxobv3p+ndqda8urPMC86Mh9RxAlnK+R1dBaYoNhnBMLCbc/UF2K
	r9U1sI8DrJgQSv9oj3M1abQg0SBl8nrvy/LgUBkGnw9CdUgWA1hOnamhUC2U7FFZvAz7vBku0kf
	y2FalVaQX6/Rr6sA/aT9QYx+dpkzbJWijO+VU2Bnjb+Szs/eLm8xPC+Q12F+pHEY002Z74++1GV
	1xPceA+G+oQ8xA4kUoul7yDl9LUDcy8rgTz59YzMZLWNS0pW7n3cyJ1aDZ8wSrDNpKNOIbDUGOl
	zHY3/mkUE4kE1JZI4kOwvaAtRVx6WYV+5pOQoEt5xYaT2BIFiPYyHVpfdmQh537CvrZgoYqLUuk
	5t2mJUCgpqb95uTQkVA8eh0uki06hOIE2CzIWesxefTwkTJu2iTdKo/PmQjMS7lOrqSn/QKY8rg
	RH0YLXNXZkGjmxwXMq1NaYMLA0mqq+
X-Received: by 2002:a17:902:e88f:b0:295:592e:7633 with SMTP id d9443c01a7336-297e56be211mr121170585ad.29.1762788326974;
        Mon, 10 Nov 2025 07:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp6btLyGMbhBFVf9NawnEUuYIX/bUHYsz7izUv20oBDHeYwe1eKrgYurw9h6/x7rKkrG1fEQ==
X-Received: by 2002:a17:902:e88f:b0:295:592e:7633 with SMTP id d9443c01a7336-297e56be211mr121170135ad.29.1762788326458;
        Mon, 10 Nov 2025 07:25:26 -0800 (PST)
Received: from [10.201.49.111] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682bfsm153193685ad.4.2025.11.10.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:25:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 6.18-rc5^H6
Date: Mon, 10 Nov 2025 16:25:17 +0100
Message-ID: <20251110152517.421706-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 8a4821412cf2c1429fffa07c012dd150f2edf78c:

  KVM: nSVM: Fix and simplify LBR virtualization handling with nested (2025-11-09 08:50:13 +0100)

I generally try to send out on Sunday to ensure I collect pull requests
from all submaintainers, but yesterday I only prepared this one and
didn't have time to send it; the timing will therefore make 6.18-rc6 a
bit bigger.

Paolo
----------------------------------------------------------------
Arm:

- Fix trapping regression when no in-kernel irqchip is present

- Check host-provided, untrusted ranges and offsets in pKVM

- Fix regression restoring the ID_PFR1_EL1 register

- Fix vgic ITS locking issues when LPIs are not directly injected

Arm selftests:

- Correct target CPU programming in vgic_lpi_stress selftest

- Fix exposure of SCTLR2_EL2 and ZCR_EL2 in get-reg-list selftest

RISC-V:

- Fix check for local interrupts on riscv32

- Read HGEIP CSR on the correct cpu when checking for IMSIC interrupts

- Remove automatic I/O mapping from kvm_arch_prepare_memory_region()

x86:

- Inject #UD if the guest attempts to execute SEAMCALL or TDCALL as KVM
  doesn't support virtualization the instructions, but the instructions
  are gated only by VMXON.  That is, they will VM-Exit instead of taking
  a #UD and until now this resulted in KVM exiting to userspace with an
  emulation error.

- Unload the "FPU" when emulating INIT of XSTATE features if and only if
  the FPU is actually loaded, instead of trying to predict when KVM will
  emulate an INIT (CET support missed the MP_STATE path).  Add sanity
  checks to detect and harden against similar bugs in the future.

- Unregister KVM's GALog notifier (for AVIC) when kvm-amd.ko is unloaded.

- Use a raw spinlock for svm->ir_list_lock as the lock is taken during
  schedule(), and "normal" spinlocks are sleepable locks when PREEMPT_RT=y.

- Remove guest_memfd bindings on memslot deletion when a gmem file is dying
  to fix a use-after-free race found by syzkaller.

- Fix a goof in the EPT Violation handler where KVM checks the wrong
  variable when determining if the reported GVA is valid.

- Fix and simplify the handling of LBR virtualization on AMD, which was made
  buggy and unnecessarily complicated by nested VM support

Misc:

- Update Oliver's email address

----------------------------------------------------------------
Chao Gao (1):
      KVM: x86: Call out MSR_IA32_S_CET is not handled by XSAVES

Fangyu Yu (2):
      RISC-V: KVM: Read HGEIP CSR on the correct cpu
      RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP

Marc Zyngier (3):
      KVM: arm64: Make all 32bit ID registers fully writable
      KVM: arm64: Set ID_{AA64PFR0,PFR1}_EL1.GIC when GICv3 is configured
      KVM: arm64: Limit clearing of ID_{AA64PFR0,PFR1}_EL1.GIC to userspace irqchip

Mark Brown (2):
      KVM: arm64: selftests: Add SCTLR2_EL2 to get-reg-list
      KVM: arm64: selftests: Filter ZCR_EL2 in get-reg-list

Maxim Levitsky (1):
      KVM: SVM: switch to raw spinlock for svm->ir_list_lock

Maximilian Dittgen (1):
      KVM: selftests: fix MAPC RDbase target formatting in vgic_lpi_stress

Oliver Upton (3):
      KVM: arm64: vgic-v3: Reinstate IRQ lock ordering for LPI xarray
      KVM: arm64: vgic-v3: Release reserved slot outside of lpi_xa's lock
      MAINTAINERS: Switch myself to using kernel.org address

Paolo Bonzini (3):
      Merge tag 'kvm-riscv-fixes-6.18-2' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'kvm-x86-fixes-6.18-rc5' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvmarm-fixes-6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Samuel Holland (1):
      RISC-V: KVM: Fix check for local interrupts on riscv32

Sascha Bischoff (1):
      KVM: arm64: vgic-v3: Trap all if no in-kernel irqchip

Sean Christopherson (7):
      KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL
      KVM: x86: Unload "FPU" state on INIT if and only if its currently in-use
      KVM: x86: Harden KVM against imbalanced load/put of guest FPU state
      KVM: SVM: Initialize per-CPU svm_data at the end of hardware setup
      KVM: SVM: Unregister KVM's GALog notifier on kvm-amd.ko exit
      KVM: SVM: Make avic_ga_log_notifier() local to avic.c
      KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying

Sebastian Ene (1):
      KVM: arm64: Check the untrusted offset in FF-A memory share

Sukrit Bhatnagar (1):
      KVM: VMX: Fix check for valid GVA on an EPT violation

Vincent Donnefort (1):
      KVM: arm64: Check range args for pKVM mem transitions

Yosry Ahmed (3):
      KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated
      KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
      KVM: nSVM: Fix and simplify LBR virtualization handling with nested

 .mailmap                                           |  3 +-
 MAINTAINERS                                        |  2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |  9 ++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              | 28 +++++++
 arch/arm64/kvm/sys_regs.c                          | 71 +++++++++--------
 arch/arm64/kvm/vgic/vgic-debug.c                   | 16 +++-
 arch/arm64/kvm/vgic/vgic-init.c                    | 16 +++-
 arch/arm64/kvm/vgic/vgic-its.c                     | 18 ++---
 arch/arm64/kvm/vgic/vgic-v3.c                      |  3 +-
 arch/arm64/kvm/vgic/vgic.c                         | 23 ++++--
 arch/riscv/kvm/aia_imsic.c                         | 16 +++-
 arch/riscv/kvm/mmu.c                               | 25 +-----
 arch/riscv/kvm/vcpu.c                              |  2 +-
 arch/x86/include/uapi/asm/vmx.h                    |  1 +
 arch/x86/kvm/svm/avic.c                            | 24 +++---
 arch/x86/kvm/svm/nested.c                          | 20 ++---
 arch/x86/kvm/svm/svm.c                             | 88 ++++++++++------------
 arch/x86/kvm/svm/svm.h                             |  4 +-
 arch/x86/kvm/vmx/common.h                          |  2 +-
 arch/x86/kvm/vmx/nested.c                          |  8 ++
 arch/x86/kvm/vmx/vmx.c                             |  8 ++
 arch/x86/kvm/x86.c                                 | 48 +++++++-----
 tools/testing/selftests/kvm/arm64/get-reg-list.c   |  3 +
 tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |  9 ++-
 virt/kvm/guest_memfd.c                             | 47 ++++++++----
 25 files changed, 297 insertions(+), 197 deletions(-)


