Return-Path: <linux-kernel+bounces-800060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D418DB432EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24AD582E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA6B28641E;
	Thu,  4 Sep 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaKJafZS"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAF2857F9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968901; cv=none; b=sQSSJvfOgJK1xtXgYmolrvpw9U4Tdyzz/5jDKE/C8R6UtG1knOjJ4ShPJ5ht/Kzm3dsT5ebCqnChe6JgOTsVID9FtM7KYpozTUOylsQRRN031hwj31fxmDP43pSlOENMO5m+4ytfk/SUP9MRw4duqYWTj40lLELDklhCTUgik2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968901; c=relaxed/simple;
	bh=/ZjwF0eb57MFfQ0u1/6Mn1Dzepvq+jsfOb0OYfST3cs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bS3B20PzcukHASY8871s3XVZkxHuprNuPuj0b9In0w8XwLb/auWtBI++WL0eTTgjlDTDOi+HQdnY5M3EcaN9UdDbIJ2t6OHTLqKroVnO7aYu2WZF2eV9zXEYfYW6nCrq3Ycm3DYQJmLzXK2yCf8S3dO0HG4HLX7eGXWzxp6ny9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaKJafZS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7724bca103dso681086b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968899; x=1757573699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHGYOIhg/J+dMYpL69zSQ+33zwU0B0JWFC+OU+r7YsU=;
        b=TaKJafZSVadJ3pcOzPQB2JFY78l9hjvUvAAL3oVBZVLrK79yYPFd9X6jq2pn+lEI/C
         ETZ52AR6X9lOyM0VtrTHT64VJHkczzjKj3A4TlRV4kcHvhdPNWhi+fNR6AHfK53ETrHb
         sFBB9DsqnxuFK/Uk3BY/2VwNXMRqgME7exNefMlHg0RVYiZjTm7mt05tXXAyDmwrbRBi
         T0Mz3wLOv/NfMTMJZWLkAvY/0uN34d+lz1fJ1h+iQdWwyM80aD6lwUMllhEZ+a28vO2p
         qWT/soHJvDA2v8xGDFn3RaUBIBdCGHgAHUYNOBz/1Ms4FtOtja+YO+1cRI8dOFB3J2tq
         2HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968899; x=1757573699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHGYOIhg/J+dMYpL69zSQ+33zwU0B0JWFC+OU+r7YsU=;
        b=TYOzq3Xtl0yzNFhhPlKSuTTP9dsQ5LytPUGoajaK26y9GWClurA/UNcnWg61gaXk4a
         a6JvDc5mmNKL68EUeDDQIFeZGdRY/4rY+vBCvxXUqoUGTG8rWeWrFOFr8KlItbQTo4jO
         +gxc06INmgErQJHYm9VAltpPsQbClUkpUQ0f9DLmerD72JHS+0o8SnfKbD+t34hCREUj
         m22OtcgXGy98rHLqci1j3lDZgPHmleMcZEJAru7nBcaYbWwnvC/hHYpQjI8aA+BZmRjQ
         /8vN6GrwAfBUeHrScFxHfDh7mjQDFg63GRku8tIB6L19LTAuqama2T/tP+O4/LsfJnFL
         ZiUg==
X-Gm-Message-State: AOJu0YzROHuXOZiLHrVBKXBsixZ0n9OP5Y+bzUGn6fpb6IXeRfTpvU4+
	lAKBZw4+E9Xskf4Yd688U7CIHb1jjuekkFftZmFEdgRRWSQgksDaWDfbGMYgg2NDr0Rl5M2xCR5
	fdQ==
X-Google-Smtp-Source: AGHT+IFvt4tNR/cPbIZfnDTcOZH10snlcQH3uYkOATnvhbTeDy0L0ItUv9BiEg/jI2hz3v5syTYuKkpAOw==
X-Received: from pfbiv14.prod.google.com ([2002:a05:6a00:66ce:b0:772:493d:275e])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230a:b0:76e:885a:c338
 with SMTP id d2e1a72fcca58-7723e3e5340mr17200087b3a.30.1756968898723; Wed, 03
 Sep 2025 23:54:58 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-1-sagis@google.com>
Subject: [PATCH v10 00/21] TDX KVM selftests
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

This is v10 of the TDX selftests.

This series is based on v6.17-rc4 and has a dependency on
"KVM: TDX: Force split irqchip for TDX at irqchip creation time" [1]

Changes from v9 [2]:
- Rebased on top of v6.17-rc4.
- Addressed the comments from v9.
- Removed special handling for split irqchip in the test code in favor
  for the kvm fix in [1].
- Removed outdated support for VM memory not backed by guest_memfd.
- Split "KVM: selftests: Hook TDX support to vm and vcpu creation" into
  4 separate patches.

[1] https://lore.kernel.org/lkml/20250904062007.622530-1-sagis@google.com/
[2] https://lore.kernel.org/lkml/20250821042915.3712925-1-sagis@google.com/

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

Sagi Shahar (15):
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
  KVM: selftests: Add wrapper for TDX MMIO from guest
  KVM: selftests: Add TDX lifecycle test

 tools/include/linux/kbuild.h                  |  18 +
 tools/testing/selftests/kvm/Makefile.kvm      |  32 ++
 .../selftests/kvm/include/x86/processor.h     |  35 ++
 .../selftests/kvm/include/x86/processor_asm.h |  12 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |  74 ++++
 .../kvm/include/x86/tdx/td_boot_asm.h         |  16 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  34 ++
 .../selftests/kvm/include/x86/tdx/tdx.h       |  14 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  86 +++++
 .../testing/selftests/kvm/include/x86/ucall.h |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  91 +++--
 .../selftests/kvm/lib/x86/tdx/td_boot.S       |  60 +++
 .../kvm/lib/x86/tdx/td_boot_offsets.c         |  21 ++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  93 +++++
 .../kvm/lib/x86/tdx/tdcall_offsets.c          |  16 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  23 ++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 354 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  45 ++-
 tools/testing/selftests/kvm/x86/tdx_vm_test.c |  31 ++
 20 files changed, 1032 insertions(+), 37 deletions(-)
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
2.51.0.338.gd7d06c2dae-goog


