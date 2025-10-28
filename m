Return-Path: <linux-kernel+bounces-874721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B34C16EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B0C3B4EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F23563D0;
	Tue, 28 Oct 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHk2Agy9"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DCA355027
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686464; cv=none; b=ocZSwwTSNna25MotRBYehboC3OQzZDVwXIxj49Gl47OhW/iRxRqH99EXPqD6k/YqoH196Awd70xdrqi2Z1v4CRZT9hGhQ1Z4wwvGQ8xnCTnD57nswUzNi3pd7VCWoAmYW+/QuLq5WNIfKw1tWU2TTeFE5s7n7GHTGVdAa4PheR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686464; c=relaxed/simple;
	bh=nEGfNmakvG/SJrWZlD9nSZUH+AMlCksOwOluH5NYAP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7MOTezUDybin9de/sc1/1Eay7wIaABxA4xF8CmukS0x4Z7BzDvV0uAYSUPTCC5M0Wu7WXiMGN3qs38Vwhpef7UhUMlD76bS8Py54F5ECTByX0n2IR/SqCQI+TYniibXTh5dOCMcBVz7vRsMO7ew+hiT8TVUuOINZCKv+oTTFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHk2Agy9; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-9447edc234fso1203446639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686461; x=1762291261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX5GVugwc+C6JrdMwZqI+sQGwgOrrPE6BL3d8gkbivU=;
        b=iHk2Agy9zj40Uf31mcDHKXO5AJ4tHfDnAXknJbX/Mj+iVtUxO23CRQgiN8HMXQMuiD
         LQMDI4ZpBgndun8af8CPJV/TeT37/OsLmss+FtwS5KlRS102s+ipZKy5Di8MWBys9QSh
         Kpxzme6Hy8W+mDpiFU5AhQg1dhhIgxuspGvB75d53eE2i4RDyFJK0LtSF/vvgdqOB3zA
         JG49KoIDvZrDSLxl487S0/5+aDB75l2HOaRcroSo6A3QpmsZ44AXCDss0csbSh+nwf+0
         cQIAuFfo9YGuwAgB/vHn245n2alGFIpX1Y3GyxS4q4wVqL4FJnYNkHcBR3U2jV4wHc7Q
         w3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686461; x=1762291261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX5GVugwc+C6JrdMwZqI+sQGwgOrrPE6BL3d8gkbivU=;
        b=O6Kb+qv9zFsl7LWQu1CNECadNOcvOL2L+Nm1qlCVGsa6c06PQDt+fu+qtbkZN7cxO9
         ieN+PgZBLhTAPARt9apmgo3FborqgZ+U1j7RjP9OfODzGo7SBtbPc9dFVh1qhnxPkxSm
         AKUefSiL3U2xxJZdqxL7tCWHpFTrWc55rFVpl3WdFPjGI2gA1u/v1C7BTpL06Sobb04C
         JZejIMyDQK8EPOKlyZldgrcGCdfm7xVSp2sv2/6MxcdhLyjU7l59jO3eUIuIku4bELCj
         GtpVHW/c7yDh3uSc1cSJpWca2ZxH/JEGz68fZSDb0vpXrIP1ZH3lPCHSL4SJoGyf30d6
         LGzg==
X-Gm-Message-State: AOJu0Yzeg2KBKXC5OqJBM2RLNb4A9KkyL6WeArskVXM6AUSWi9Lavq6D
	jWW6Ar30SPifE+WyuuGs6azidaPqWpycN6CEa9vfY8EjC3nZ9N/EuM+yTFXUP3lCTAVsqO8+8Zw
	cpQ==
X-Google-Smtp-Source: AGHT+IGAFvo/KKvEdFChEUwxqiCVhHew0LDSPHYl5/GxeXUOv2hI6CPOtlDXCHz1yE7r5C1l+LIYI7DprA==
X-Received: from iobjh17.prod.google.com ([2002:a05:6602:7191:b0:945:a321:1fc4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:718b:b0:93e:8bab:e17f
 with SMTP id ca18e2360f4ac-945c9865452mr118639039f.14.1761686461422; Tue, 28
 Oct 2025 14:21:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:32 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-7-sagis@google.com>
Subject: [PATCH v12 06/23] KVM: selftests: Expose segment definitons to
 assembly files
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

Move kernel segment definitions to a separate file which can be included
from assembly files.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor_asm.h        | 12 ++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c      |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h

diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
new file mode 100644
index 000000000000..7e5386a85ca8
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Used for storing defines used by both processor.c and assembly code.
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
+#define SELFTEST_KVM_PROCESSOR_ASM_H
+
+#define KERNEL_CS	0x8
+#define KERNEL_DS	0x10
+#define KERNEL_TSS	0x18
+
+#endif  // SELFTEST_KVM_PROCESSOR_ASM_H
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 519d60a3827c..5f75bd48623b 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "pmu.h"
 #include "processor.h"
+#include "processor_asm.h"
 #include "sev.h"
 #include "tdx/tdx_util.h"
 
@@ -15,10 +16,6 @@
 #define NUM_INTERRUPTS 256
 #endif
 
-#define KERNEL_CS	0x8
-#define KERNEL_DS	0x10
-#define KERNEL_TSS	0x18
-
 vm_vaddr_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
-- 
2.51.1.851.g4ebd6896fd-goog


