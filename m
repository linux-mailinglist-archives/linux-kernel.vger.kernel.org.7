Return-Path: <linux-kernel+bounces-778942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C426B2ECF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C967D188712C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22442ECE9E;
	Thu, 21 Aug 2025 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O52GhE5q"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587542EBDDC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750592; cv=none; b=eznw9bNBw4RbHfvGGTjnDnPovYj19MwXHQNLTE0G4Q88ar8jqwY21hQrTswFqSl0tGOiV6AVOyrSIsygAiN+wP3n5jZy03T3GJhSZESv6DtOT4w0yH4Y+mZmqdEmCro1hY3MwiPLuzSj/1PbhjGaNkPVXF9WBethwrHo9G2AYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750592; c=relaxed/simple;
	bh=YfCKtl1oYUHFl63/I/l0XnKZWiM4Uj8GywSB9cp0jjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAkriMbrTRE5Uu6g7lfMtw6jutfmO1oqZP8Egj9Q1MeCrPJcYT1R3zHa6/QHkOayprQKNkBfEhVfEDHEg9JYOWd9F53zgakeGchnJ0Qe9R0DzEKMaAVQLdIRhVP42nMtn6pvlLdk8JN3xv5Q7oDQ3RZDtdhtAFSMqr3zjAEcQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O52GhE5q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174bdce2so465128a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750589; x=1756355389; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=17hgKbvgVoShstlAaX3KPF4mBrZKhgeiLGz5GZxS0HI=;
        b=O52GhE5qK4AMD2GXcRnwmN5F4wVV5RohZRhH5L1ughC0WR6OrXZddN64EFUx8ZZvoZ
         jmgvqnlyqsXJuQBzpXeDyKxu1AYglzOfdnuJBsfZxzDFSSgodPJaydfnPNMXc9KLcdmN
         33wQLkl8Pfx3UwUNj15M+9/7RFyoRXdn3UOPNl9CZWjYUqt41+7Xik/R5Rl3bCMlvnuE
         NYX9S6RSgLfouq4gL81jmg5BjNu2jJTE83wPx2r+gJ6And613amn9Q3M52GGYjaXkVeZ
         tfaqRVepyXmH04DlPtKXZ9ZXYDQvMSs9lTEx4KbkDTx0KXePqNAEag7pSp+2kOibeobI
         MS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750589; x=1756355389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17hgKbvgVoShstlAaX3KPF4mBrZKhgeiLGz5GZxS0HI=;
        b=g05or8FOF/CvpN9kUQ4ObWFrGPVzm2Z1D2e2ck2fmG4WpVV0awcRkCPT8xyxv2Xtpk
         oIcJWX4pl387NRIZXRHVAuuKZngCsPRYN3DM0I6ldSGEOhwF2WOFHsqRp4WwAlNsgMMI
         cNSJENr4E134j26L/bwcSEjBqB8KE3pFHNgRMS1YT3vtmlyuAOlX950Z7+z+sJb+lTmR
         Xt3xXtl8WDnCMsTjSYrekJJ0x7NVvwPCc7OxhSN5cHLsQjdSJe+ZCDz4oMwAPtCZRex/
         tiCKyryerzqJBYnDo7StCOKzzgHKL5acQDVIE2MGXXzS1ayJXvwOYET7KpMPq3k77X4q
         6BaA==
X-Gm-Message-State: AOJu0Yw+dcshflZoIIYmb6mNcVsWsgMJyO/bsXTOQzzxkxvgcuETVN+z
	Um00CWayfHmksM30M0aLwqC6Ocb3xfLjT9E6gcquALe5Pi/P7H8u8cGGTQc8M6dLTNsupEU1PiC
	WHg==
X-Google-Smtp-Source: AGHT+IGF5a5kRZmxUiR0v1iGU7vvhEaAdIOjYi1z34R/ceiLYsiE+HhRHvw9xVKXOykbRjsvm8/UnJbeaw==
X-Received: from pgbl17.prod.google.com ([2002:a63:5711:0:b0:b47:9d0:bf72])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0c:b0:240:101c:4428
 with SMTP id adf61e73a8af0-243308364d2mr1563120637.10.1755750589607; Wed, 20
 Aug 2025 21:29:49 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:10 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-18-sagis@google.com>
Subject: [PATCH v9 17/19] KVM: selftests: Add wrapper for TDX MMIO from guest
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

Add utility function to issue MMIO TDCALL from TDX guests.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/tdx/tdx.h       | 14 ++++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1f541c0d4fe1..8d1aaebd746e 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -35,6 +35,7 @@ LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
 LIBKVM_x86 += lib/x86/tdx/tdcall.S
+LIBKVM_x86 += lib/x86/tdx/tdx.c
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
new file mode 100644
index 000000000000..22b096402998
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_TDX_H
+#define SELFTESTS_TDX_TDX_H
+
+#include <stdint.h>
+
+/* MMIO direction */
+#define MMIO_READ	0
+#define MMIO_WRITE	1
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					     uint64_t data_in);
+
+#endif // SELFTESTS_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
new file mode 100644
index 000000000000..12df30ac1ceb
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+
+#define TDG_VP_VMCALL 0
+
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO	48
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					     uint64_t data_in)
+{
+	struct tdx_tdcall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = MMIO_WRITE,
+		.r14 = address,
+		.r15 = data_in,
+	};
+
+	return __tdx_tdcall(&args, 0);
+}
-- 
2.51.0.rc1.193.gad69d77794-goog


