Return-Path: <linux-kernel+bounces-778925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D6B2ECC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FBF7BB190
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B902BEC31;
	Thu, 21 Aug 2025 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/1svZ9X"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34912853EE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750566; cv=none; b=GBqoP6IozIp/pbJ6p7m/3NGZFDISW4QuGBMaaDJH1z99F4b93i3FSrfNLgLlL3Hb7ZLjkPqlsaNh0VnMqah1ZxVH0dVv6h2u9HP22YhtRxlgJJ4f3ItDP6AnIK58yka7IuPKDOjSs9fm/sBpp3SDjo+8n/jJdnd1VEYNqAu/iyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750566; c=relaxed/simple;
	bh=dmN78qg5cbgbGCKRfqQkb52ZSXtrXOPJTRl6xUs1h/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VWh13FiLDiBH45gDzEtpWj4bjH3ccr+XFVrT5h9CvLHyFi7BXbGRMNrHsLxfHoy7we/eJNz6aqQamZT7yjLaTNO8dNOz+ksqXDJ8CY1P1rEizi9rZDxL4MwR+az1p7+NPDGrB1eIWXoOVpzTTPvc8DaK8NPvRsLd2eAbqkO4AKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/1svZ9X; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bf571bso1408934a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750564; x=1756355364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GVjkTCOD4gDiIblKP/dCZA+QRUFV7DqhokRzAxHGxAM=;
        b=l/1svZ9XXZ0fg/Oq9NBXrlmDcvuIEFyzizwps2AIVeOtPAJSYozFggnp5KlruZ+d7O
         YKe4NwdDvZ5g+cCp+N0S6G+RjRIMxd+xFK8KkbHT0XFRMnnfxLqPUHJqUBNAYUNvg2qw
         X4g4Wv11ufGlUJojtpi+pXiMGE/6FC0hzGT8wqipZsN/H4g6YmXEwRqzuq7FNBjFy+EO
         NLaniusJ9nNweSE/sqIdmR8TWU2KMIVcamKfHLuKEPwvyT18v3t5iKdPzwOEVFxynprD
         9D4ilwgP9wJ1yjj9YKwxRL3dCu7Z31tpVRTNXYqf3SDqcsFfS+PP3/W0uK14vkCgVK9a
         f1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750564; x=1756355364;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVjkTCOD4gDiIblKP/dCZA+QRUFV7DqhokRzAxHGxAM=;
        b=XBhIhH6aJlUFQwCVpqC6cczbsIG8LNzF8IhrWTL9B7fWUZG8W5qv7VMtgRFwblrmQP
         GxfsZgllqiPhNgJ0fN0DdBy87R4YJhqv5EhPxp7HYo0f+bjdjN489GiFGfDz57WA4Z4+
         NQVo9CwKxjeZn2G/Uu5brquNekq2ql43o624c6w+HM41lgoY1FuqzEhJjx7vns/vaJhB
         mImdNKQqgtM4WwP+8g4kDEH4vSa0pTyeZUypbUE+gvl4I2e0aPpB8exEUrf9N9LhT1iD
         ELjIT/Nmk+o4PfWLC57aq1XN0swahNvft3QihH52wpMQMWV1SuTZRUpHzqzNnRKyK5vs
         9H8g==
X-Gm-Message-State: AOJu0Yxi68ZUBPguMlDrZkl8GOaEIO1HmaimodhsYgGYJNzTUBhbICXq
	9Tv5zaHMHhF7tuPbNc1GrEcOSuRNEHfRk0aINAMDoOOE/2AicLBpjlqGZu5Wrtemizm3kB8n20I
	MRw==
X-Google-Smtp-Source: AGHT+IFK+h3lJ3T9qDq2Uo5ZnKX2BipAjFJmgGGsy9orGKqxdcyukDrKhLT+fPv1Vqg4iTzcH0qXIlwcAA==
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:31f:1707:80f6])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134f:b0:31e:ec58:62e2
 with SMTP id 98e67ed59e1d1-324ed114fb9mr1604548a91.19.1755750564017; Wed, 20
 Aug 2025 21:29:24 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-1-sagis@google.com>
Subject: [PATCH v9 00/19] TDX KVM selftests
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

This is v9 of the TDX selftests.

Thanks everyone for the thorough review on v8 [1]. I tried addressing
all the comments. I'm terribly sorry if I missed something.

The original v8 series [1] was split to make reviewing the test framework
changes easier. This series includes the original patches up to the TDX
lifecycle test which is the first TDX selftest in the series.

This series is based on v6.17-rc2

Changes from v8:
- Rebased on top of v6.17-rc2
- Drop several patches which are no longer needed now that TDX support
  is integrated into the common flow.
- Split several patches to make reviewing easier.
- Massive refactor compared to v8 to pull TDX special handling into
  __vm_create() and vm_vcpu_add() instead of creating separate functions
  for TDX.
- Use kbuild to expose values from c to assembly code.
- Move setup of the reset vectors to c code as suggested by Sean.
- Drop redundant cpuid masking functions which are no longer necessary.
- Initialize TDX protected pages one at a time instead of allocating
  large chinks of memory.
- Add UCALL support for TDX to align with the rest of the selftests.
- Minor fixes to kselftest_harness.h and virt_map() that were identified
  as part of this work.

[1] https://lore.kernel.org/lkml/20250807201628.1185915-1-sagis@google.com/

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

Sagi Shahar (13):
  KVM: selftests: Include overflow.h instead of redefining
    is_signed_type()
  KVM: selftests: Allocate pgd in virt_map() as necessary
  KVM: selftests: Expose functions to get default sregs values
  KVM: selftests: Expose function to allocate guest vCPU stack
  KVM: selftests: Expose segment definitons to assembly files
  KVM: selftests: Add kbuild definitons
  KVM: selftests: Define structs to pass parameters to TDX boot code
  KVM: selftests: Set up TDX boot code region
  KVM: selftests: Set up TDX boot parameters region
  KVM: selftests: Add helper to initialize TDX VM
  KVM: selftests: Hook TDX support to vm and vcpu creation
  KVM: selftests: Add wrapper for TDX MMIO from guest
  KVM: selftests: Add TDX lifecycle test

 tools/include/linux/kbuild.h                  |  18 +
 tools/testing/selftests/kselftest_harness.h   |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  32 ++
 .../selftests/kvm/include/x86/processor.h     |   8 +
 .../selftests/kvm/include/x86/processor_asm.h |  12 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |  81 ++++
 .../kvm/include/x86/tdx/td_boot_asm.h         |  16 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  34 ++
 .../selftests/kvm/include/x86/tdx/tdx.h       |  14 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  86 ++++
 .../testing/selftests/kvm/include/x86/ucall.h |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  25 +-
 .../testing/selftests/kvm/lib/x86/processor.c | 122 ++++--
 .../selftests/kvm/lib/x86/tdx/td_boot.S       |  60 +++
 .../kvm/lib/x86/tdx/td_boot_offsets.c         |  21 +
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  93 +++++
 .../kvm/lib/x86/tdx/tdcall_offsets.c          |  16 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  22 +
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 391 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  45 +-
 tools/testing/selftests/kvm/x86/tdx_vm_test.c |  31 ++
 21 files changed, 1095 insertions(+), 39 deletions(-)
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
2.51.0.rc1.193.gad69d77794-goog


