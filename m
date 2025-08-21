Return-Path: <linux-kernel+bounces-778930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CFEB2ECE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0444B17BA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73C02E8E03;
	Thu, 21 Aug 2025 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ostrz5e6"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C892E8B77
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750573; cv=none; b=I7I0tFp1wDxVc3QUhgW9vJK4fCi0ZwdbQQgEgyE6oBiXhM8u35fRGj9Vcz7CLEcMR0MfhtnP9/yB5eqFfM8piYqAIb6fb/oiN400R3lhunmkOD1XCQix4j/KsV7xIrz0EUbw1ZGVeeNS62wOE9HBeex7eOya60AocRKLFKnQcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750573; c=relaxed/simple;
	bh=tr/kYasvhaM7kVMspgyv9tdsJx7ARbBqJCQJSG2OYi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P1zgSxcOxBB5uhW5PCWhIzhOJ2zzJZY9AQPrZPSM/3Ai0d5v9mVcdMuiGN4SF9yzrd69e3CBXox6mo5QFiMMbx6PAAxnIh5BJta4axcYip/lTEgOXl681IiqUOWPa30t7mXj8LNuAnN/2kFXdL+OcAnJg+8BfWEbyu0WAPhkVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ostrz5e6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47253319b8so383122a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750571; x=1756355371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNhncePcfevR9BqJj7luu3cgXc4QyqZzLOry8PLvlQ=;
        b=Ostrz5e69/1I4BGr7xqfykKD8DXxoNG4gstXZp9p0ewTu/PZRZhtav5GrBUSLDlzy6
         f06I5SvLSvU3WrkWskdL6bGqBwikz7TeSRIgvmB+FfJaWRagK+HsK/3UkdAfeHuH0nVp
         XNuqnO+sLK4wS7NL7z2P+zoODGHb/iICOu0XzbyeFkR6fWRXeOC9PhnZDZR669CNNN2v
         DVrvMR3DDbE7VPSxzsF+YmbxCpdOo/PFpN7PTomyHNyBQLKaYvcagFifVTGiTZzq15uo
         gwMnreUyuuXlUFvU3wNkwGeo7mdmDxkMToEmr5ABdO1TqIFT3HTTGS2qhv28LZAp4pJj
         t62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750571; x=1756355371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNhncePcfevR9BqJj7luu3cgXc4QyqZzLOry8PLvlQ=;
        b=WkQ2hDacghCciVJxxsWueD5bcnJwuaofEOVm/T14tDtMDq4Z+rj8baYmjhKImM/wyU
         ZRLFiu3dFTbUW0uw1w4sAUuPEpurWsFDsQrJbbiCeLMdfLt2g/9MuyswE0sjRseFPzyS
         dQM8oCwjCjZo3CPB4ILyy5mfne0J56VhProNSp3cSvY3ZwDxwUqjjlchknQgpLKwEszV
         QEQYryls3VgECOiJDjFHKwFWx2+pBwj63J33BgkdCkdxOdn1cPXvfk5qXxNVveeNi/1N
         1HUslaulkcyvanIqhSWMDB539jfD1kmZsS/+SrfEZOtPphbfh/3Y6pW72n0vImonF2to
         9Ocw==
X-Gm-Message-State: AOJu0Ywc4nP70ZOTUIO2WOmVX2QTXxdEpsUqabvtIpPwsyPmjf891L6C
	RnNQG/+0LjTpkBZdmxoQ+uVIVyicL0Q3Cd11zS1CgRPf7XYONQEvlbBQ84bggI28l7kspCNEZCr
	N2A==
X-Google-Smtp-Source: AGHT+IFHt8bMa7jB5MANhdG47UreNFuDH8fmYAoZds65ocGLlqKumuv8qls/N0mgvNCEDLrPY4SlSjc9EQ==
X-Received: from pjyp4.prod.google.com ([2002:a17:90a:e704:b0:321:6924:af9a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68b:b0:240:2145:e51f
 with SMTP id d9443c01a7336-245febe11dcmr17946895ad.3.1755750571576; Wed, 20
 Aug 2025 21:29:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:58 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-6-sagis@google.com>
Subject: [PATCH v9 05/19] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Isaku Yamahata <isaku.yamahata@intel.com>

Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
similar to SEV.

TDX sets the shared bit based on the guest physical address width and
currently supports 48 and 52 widths.

Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 ++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
new file mode 100644
index 000000000000..286d5e3c24b1
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_TDX_UTIL_H
+#define SELFTESTS_TDX_TDX_UTIL_H
+
+#include <stdbool.h>
+
+#include "kvm_util.h"
+
+static inline bool is_tdx_vm(struct kvm_vm *vm)
+{
+	return vm->type == KVM_X86_TDX_VM;
+}
+
+#endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 1eae92957456..6dbf40cbbc2a 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "sev.h"
+#include "tdx/tdx_util.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -1190,12 +1191,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
+	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
+
+	vm->arch.sev_fd = -1;
+
 	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
-	} else {
-		vm->arch.sev_fd = -1;
+	} else if (is_tdx_vm(vm)) {
+		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
+			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
+		vm->arch.s_bit = 1ULL << (gpa_bits - 1);
+		vm->gpa_tag_mask = vm->arch.s_bit;
 	}
 }
 
-- 
2.51.0.rc1.193.gad69d77794-goog


