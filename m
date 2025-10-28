Return-Path: <linux-kernel+bounces-874715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5140C16EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB011C267B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83698350D54;
	Tue, 28 Oct 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT8MH6L1"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3017A2E0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686457; cv=none; b=taS8LkyQIAA9aXOKBEl9/n4+E6PszRbt61BJ82sx0kBTqGbTn/y3mNbOOhQ/mwi/LrVQO1nPYMEilgOA2ueKu+JZ+d6iR1y4AFRf5M3j0yL//fcilpvAWXWtf6Lh1LDzL0CBdkbo9sdhwZi+13UP1dkz8L6klNaHd3QhsCy57tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686457; c=relaxed/simple;
	bh=aI393HHSFrPRrP1TYQXkGhBCKEVGaI5rPBItcAACXFE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fTOSl1b/j6NHHg4Hd+s5uRvLEwk3acBF/uZH04xLfgiSpTCrm3I7WfkOnMhsvza8LFsKi5Bx4JpuICMJ4nNkf2UI8ZBfhyiujhcNh59KvkMr/i65ZFBCDsVJ/6YXTBA2njtb0NgYywbWz1e1T5crRxXKPhp+3hLGxBIzprnfwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HT8MH6L1; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-945a5690cb4so1054330739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686455; x=1762291255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbXGpdEtMxmsgkOEQR9G6JRoqvRR42H2pkMCyvLlyO8=;
        b=HT8MH6L1df79/coHuMRxcedanyAi6q+JqK4KZR3/w83uu5lICs61uPUonu3Jy0th07
         IXMVKO4mnTAyDSE1ivFWou5H+6tg0gqVcfk6lV/0hWf9ncKUOqt6zy2CQ43fmcP/5onr
         /depBjBVV/aXChkTrWh6zXfuTWEI58EL/k6YNmkzYOMol9p8zJ78hdyYq0huzU1RVTN4
         JiY6Mf/DPvv8pCKyzblGnBpy+2pfid0vY0HheCvelr3D8tCugMdhpAl11c0+uyuk7pij
         MRP2PPmI+dZS93NiGpqi/EN/J7A7/9W+weYa6EHnra/3PtGMNOI/Nb8vapx6CNsn4rtd
         MwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686455; x=1762291255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbXGpdEtMxmsgkOEQR9G6JRoqvRR42H2pkMCyvLlyO8=;
        b=Uv/HV6H/LKmfWahCGIh2nVQaURIy+Mn4bmXcqzrQ+zaIdlxKtGXSOUbUXhK+hCgpOj
         oAvT3I0rm0CrKv+jxTwU1PRf0P/5MFfMRa5O/l+Tbuga0NV3ReyxbzbnjZg3ayTM0QfH
         ta9JsbORtrOHVgYP9dICoWS5nJGQheyIYP3mg1BHRaBu7JR+jV6afQMPqTXtF1p94u+q
         ZKMAF4ymc53ktVvcNsU+UpVeR7KeW7FfU4xK3koO/AnLBInqw+hVUG1USIRqoGNz5XUE
         6djs1tzdvsCgTgLpOiobfFySZSVqXkBc10GuqqhmOZshz+sEXLn8v/fqRLrJbIzCfSG8
         mMww==
X-Gm-Message-State: AOJu0YyBwwagVaBKr3I+xHPoeX5YCUPdHyXqkc9il922mZwhDHivhj1h
	PicU9uEHmLG3y5SnHMk+jZJFRAANsJQXRqsBSjFhj3FvYaCCN+YXyspM130YKbY7l6zD1JVJ8qn
	J2g==
X-Google-Smtp-Source: AGHT+IHHK3Lpv/CrWgug/vynbjwC/QLsygeiFA9f7pr2XzijuISDak85wUMo+BGH9CICCpjmvcf93JNQOw==
X-Received: from iobjh17.prod.google.com ([2002:a05:6602:7191:b0:945:a321:1fc4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:2b0a:b0:944:185:d846
 with SMTP id ca18e2360f4ac-945c96d927amr167632639f.7.1761686455266; Tue, 28
 Oct 2025 14:20:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-1-sagis@google.com>
Subject: [PATCH v12 00/23] TDX KVM selftests
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is v12 of the TDX selftests.

This series is based on v6.18-rc3

Changes from v11 [1]:
- Rebased on top of v6.18-rc3.
- Hook vm_tdx_finalize() into kvm_arch_vm_finalize_vcpus instead of
  calling it as part of vm_tdx_create_with_one_vcpu. See "KVM: selftests:
  Finalize TD memory as part of kvm_arch_vm_finalize_vcpus" which was
  added to this series.
- Replaced vm_tdx_create_with_one_vcpu with vm_create_shape_with_one_vcpu
  following Sean's patch to simplify creating VM shapes.

[1] https://lore.kernel.org/lkml/20250925172851.606193-1-sagis@google.com/

Ackerley Tng (2):
  KVM: selftests: Add helpers to init TDX memory and finalize VM
  KVM: selftests: Add ucall support for TDX

Erdem Aktas (2):
  KVM: selftests: Add TDX boot code
  KVM: selftests: Add support for TDX TDCALL from guest

Isaku Yamahata (2):
  KVM: selftests: Update kvm_init_vm_address_properties() for TDX
  KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
    attribute configuration

Sagi Shahar (16):
  KVM: selftests: Allocate pgd in virt_map() as necessary
  KVM: selftests: Expose functions to get default sregs values
  KVM: selftests: Expose function to allocate guest vCPU stack
  KVM: selftests: Expose segment definitons to assembly files
  KVM: selftests: Add kbuild definitons
  KVM: selftests: Define structs to pass parameters to TDX boot code
  KVM: selftests: Set up TDX boot code region
  KVM: selftests: Set up TDX boot parameters region
  KVM: selftests: Add helper to initialize TDX VM
  KVM: selftests: Call TDX init when creating a new TDX vm
  KVM: selftests: Setup memory regions for TDX on vm creation
  KVM: selftests: Call KVM_TDX_INIT_VCPU when creating a new TDX vcpu
  KVM: selftests: Set entry point for TDX guest code
  KVM: selftests: Finalize TD memory as part of
    kvm_arch_vm_finalize_vcpus
  KVM: selftests: Add wrapper for TDX MMIO from guest
  KVM: selftests: Add TDX lifecycle test

Sean Christopherson (1):
  KVM: selftests: Add macros so simplify creating VM shapes for
    non-default types

 tools/include/linux/kbuild.h                  |  18 +
 tools/testing/selftests/kvm/Makefile.kvm      |  32 ++
 .../testing/selftests/kvm/include/kvm_util.h  |  14 +
 .../selftests/kvm/include/ucall_common.h      |   1 +
 .../selftests/kvm/include/x86/processor.h     |  40 +++
 .../selftests/kvm/include/x86/processor_asm.h |  12 +
 tools/testing/selftests/kvm/include/x86/sev.h |   2 -
 .../selftests/kvm/include/x86/tdx/td_boot.h   |  74 ++++
 .../kvm/include/x86/tdx/td_boot_asm.h         |  16 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  34 ++
 .../selftests/kvm/include/x86/tdx/tdx.h       |  14 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  84 +++++
 .../testing/selftests/kvm/include/x86/ucall.h |   6 -
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  99 ++++--
 tools/testing/selftests/kvm/lib/x86/sev.c     |  16 -
 .../selftests/kvm/lib/x86/tdx/td_boot.S       |  60 ++++
 .../kvm/lib/x86/tdx/td_boot_offsets.c         |  21 ++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  93 +++++
 .../kvm/lib/x86/tdx/tdcall_offsets.c          |  16 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  23 ++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 330 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  46 ++-
 .../selftests/kvm/x86/sev_smoke_test.c        |  40 +--
 tools/testing/selftests/kvm/x86/tdx_vm_test.c |  33 ++
 25 files changed, 1056 insertions(+), 78 deletions(-)
 create mode 100644 tools/include/linux/kbuild.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

-- 
2.51.1.851.g4ebd6896fd-goog


