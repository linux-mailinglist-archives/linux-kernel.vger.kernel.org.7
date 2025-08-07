Return-Path: <linux-kernel+bounces-759462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCBB1DDCC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54A67AD71F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706E622D4C3;
	Thu,  7 Aug 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZjASWXR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50D1F8ACA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597799; cv=none; b=VltFTzoKJTThuTxUH5Y7KumCnIG77jTsWi+aiPIGgpAwFh9VjRyqFqjxlUfhysEo9Oz+XvF+Xi/HsgrdduoTGmN0cuaTRIUo/e1T4OMt0dsqkQUBYJUTlNbYGHESGYvO4hQ8jgOeC7hu5BRBMoWY4bJc/81Te1B+PVNi57GiFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597799; c=relaxed/simple;
	bh=yASUBRusiGzdMq/YeCCykURXl9hVmwjc23w0K0hPSu0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a6XsxgnHFqptht7wbtojeH7Xg6E3PyywlE9Z5KFirS5NvaJW9078SjixD6gda1KnVoiVsFIds3qPAAGpNUIawkBXhFfLoIW6FAs8rrH/4MCDrXFYdH5KZjPMas7CHEI8A+qt2rBCtEJ4NEqVsRgywenCDwDSqz3r4TKf82L5uv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZjASWXR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea10f801aso2807863a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597797; x=1755202597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WZ/m9Kbu13jtZAUbI+Mg2ry+b6VTpOUv0cwhaBFjFA=;
        b=aZjASWXRfFh2OCP6BrZVoINVwRUUWDgYcaqSiOfO/etUP55csezSgKxSNUasTCV1oG
         2v8rPsvJTGqxEjCRYqs7KqcEkpJ1RFUhCgdpOKdLwVwR4QqoXMIJG4k/tNRoW6byAK+/
         0E4ThtoNf6rje2KSnWmNW/XOotsgyBjwoeiT/R2CNswFES9dovdhb36X0fh3oWztcIuY
         +Xwa7P0BzpybJGrtHJ5CaKZ0UGIGN0N2W3kRTFhW95TIvCEclICvNGoAMDXmvt0Mh9f+
         mUMJx2D1i6QcGSyKkofbr+Z96MxiI4rIADL1u/WP227XsCOvYTBqvKkM1hCFZqKiCFgI
         8fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597797; x=1755202597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WZ/m9Kbu13jtZAUbI+Mg2ry+b6VTpOUv0cwhaBFjFA=;
        b=K5gm4n/cnEWfahKM6Z7AmAZEMPG9dl3DExOklFuXtJw8Dg9WCYtifT4LVQuqrEy6Du
         phTqgwrHh/+zVTnClmdhYXMEE/RQvsADu/xURA3U/nGEiKMj59cU2OTSwlveYAjRkXiI
         0KSXbZ+5B3ADbNjtzji7myYwfQtYvzpAxNEXC8yj1i9EDvEV+2u1sIu5Cg6d9RjaTHYO
         Y/vRT8u6fOtbN0tKE2aH5N2eze1XOmXplUUT8do3bO85f77pjiU7tYof50x4BYt9Jj9/
         MxXwlIa8uxp9IiCMzttgG6ReUB52pWgtWktY4pEIrSgLfClU/I8dh0WjrHFJpmGys+xK
         vi8A==
X-Gm-Message-State: AOJu0YxHjcdk/GbYm741+xvZjycUhEfOzbLSqGRMwBCALYbHwORbvx87
	iQsIbVT8AwXcocQvQlyV6nEXLl8CA8N1S27In6Qw4agaMVTIyjEATLYWh6/Cx0hhLrjpEdvrC8W
	BLA==
X-Google-Smtp-Source: AGHT+IHpADqdqKdhjerMQbSr6wlJfTJHV2fK9SOXtygg2SkRAMzS/cO72EzWOVz994gYkF0QX8/ZfuTYiQ==
X-Received: from pjqo21.prod.google.com ([2002:a17:90a:ac15:b0:312:1e70:e233])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e4b:b0:31e:ff94:3fa0
 with SMTP id 98e67ed59e1d1-321839e0210mr521940a91.6.1754597797490; Thu, 07
 Aug 2025 13:16:37 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:15:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-1-sagis@google.com>
Subject: [PATCH v8 00/30] TDX KVM selftests
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is v8 of the TDX selftests.

This series is based on v6.16

Aside from a rebase, this version includes a minor bug fix for
"KVM: selftests: Update kvm_init_vm_address_properties() for TDX" which
was called out in v6 by Ira Weiny.

Thanks,

Changes from v7:
- Rebased on top of v6.16
- Minor build error fix

Ackerley Tng (12):
  KVM: selftests: Add function to allow one-to-one GVA to GPA mappings
  KVM: selftests: Expose function that sets up sregs based on VM's mode
  KVM: selftests: Store initial stack address in struct kvm_vcpu
  KVM: selftests: Add vCPU descriptor table initialization utility
  KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
    attribute configuration
  KVM: selftests: TDX: Update load_td_memory_region() for VM memory
    backed by guest memfd
  KVM: selftests: Add functions to allow mapping as shared
  KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
  KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
  KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
  KVM: selftests: TDX: Add TDX UPM selftest
  KVM: selftests: TDX: Add TDX UPM selftests for implicit conversion

Erdem Aktas (3):
  KVM: selftests: Add helper functions to create TDX VMs
  KVM: selftests: TDX: Add TDX lifecycle test
  KVM: selftests: TDX: Add TDX HLT exit test

Isaku Yamahata (1):
  KVM: selftests: Update kvm_init_vm_address_properties() for TDX

Roger Wang (1):
  KVM: selftests: TDX: Add TDG.VP.INFO test

Ryan Afranji (2):
  KVM: selftests: TDX: Verify the behavior when host consumes a TD
    private memory
  KVM: selftests: TDX: Add shared memory test

Sagi Shahar (10):
  KVM: selftests: TDX: Add report_fatal_error test
  KVM: selftests: TDX: Adding test case for TDX port IO
  KVM: selftests: TDX: Add basic TDX CPUID test
  KVM: selftests: TDX: Add basic TDG.VP.VMCALL<GetTdVmCallInfo> test
  KVM: selftests: TDX: Add TDX IO writes test
  KVM: selftests: TDX: Add TDX IO reads test
  KVM: selftests: TDX: Add TDX MSR read/write tests
  KVM: selftests: TDX: Add TDX MMIO reads test
  KVM: selftests: TDX: Add TDX MMIO writes test
  KVM: selftests: TDX: Add TDX CPUID TDVMCALL test

Yan Zhao (1):
  KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD
    memslot

 tools/testing/selftests/kvm/Makefile.kvm      |    8 +
 .../testing/selftests/kvm/include/kvm_util.h  |   36 +
 .../selftests/kvm/include/x86/kvm_util_arch.h |    1 +
 .../selftests/kvm/include/x86/processor.h     |    2 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |   83 ++
 .../kvm/include/x86/tdx/td_boot_asm.h         |   16 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    |   54 +
 .../selftests/kvm/include/x86/tdx/tdx.h       |   67 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |   23 +
 .../selftests/kvm/include/x86/tdx/test_util.h |  133 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   74 +-
 .../testing/selftests/kvm/lib/x86/processor.c |   97 +-
 .../selftests/kvm/lib/x86/tdx/td_boot.S       |  100 ++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  163 +++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  243 ++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  643 +++++++++
 .../selftests/kvm/lib/x86/tdx/test_util.c     |  187 +++
 .../selftests/kvm/x86/tdx_shared_mem_test.c   |  129 ++
 .../testing/selftests/kvm/x86/tdx_upm_test.c  |  461 ++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 1254 +++++++++++++++++
 20 files changed, 3734 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/test_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_upm_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

-- 
2.51.0.rc0.155.g4a0f42376b-goog


