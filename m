Return-Path: <linux-kernel+bounces-800079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC647B43320
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C832583082
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F012BD037;
	Thu,  4 Sep 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBsuYiJP"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF52857EA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968934; cv=none; b=Sckn+923bihIcptL9WwZgbSOOT9Qhp5JxGK5fJTviSLC79AEoyygLjQ7frq2BwNVlbLWaulKDsChzJ3mSgT1WDMvDJKXWtMSiaTGblxuEQZURmbXyrWxFRNDraPwOgTpgxlhsxqo164v22d+kWXNGloQeY6ii+r+FVUhC/bOm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968934; c=relaxed/simple;
	bh=hzGFMgxPgiU24vsXArlIv7U3vM7g+M9P+mccb58lX9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NqKE6QFlryNaNvJAnNOAMxD81T2UcDTpOv57hyK8FOZiwGz4J5eVf3HHpzs9EPXx+QeW+CXEMZ7Ad4QXKrPrNUGVmvS1YwjjE41gfOYRyHqt0/qU7xQtdcB2xHsoFFodcJfnYUIJzPsYxpOktqAp7ePPaVoXvfJB1a85P8QeGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBsuYiJP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248eec89618so9992505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968932; x=1757573732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UX1Rmgz0kZ8N5Zzn+bY2xvvNkdxwsBMWh8MtnA4+GY=;
        b=PBsuYiJPs/FlU73o4wvXk1Qiinadd/TO9BnIqyeZi0DEwdqtZuLYE4B4C+G6rXir4H
         67c5581E9i5K0rxCWGaF93UoPDpw42INO0cjTOZxuLOt1ncVyEx0suRzS/GCHo60wpgO
         XXxncRe+K+migRVsLQX7aEz+0Y8b3AY9Eg/358g2t+CL68f+Mii04kbBiZpOKueP08fV
         MCNJI0P+KYMarxlJCkY0vb6CkCJtMBp57shgO46qFxaHprhvWyLTgqog4oTtvGR6f+pC
         0q0oEM0kZCSsdAQZqULXICtf2pkWZDFrmdMWGpQZW82qko+EpyPpXo+QQjIQQCarFesq
         6URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968932; x=1757573732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UX1Rmgz0kZ8N5Zzn+bY2xvvNkdxwsBMWh8MtnA4+GY=;
        b=uOSxzfoKFqFo5AMHE3TGLmIN9GBYHNpmOlk2Yiz5o4QyvZa5RN1FAok/awwfbJgzIl
         IOedgnTmXXl5ovMzkUXmkKcK5XYy8iABrHzegbfwbgxgkKi6otXvhD4e1dQqY8mnZW6W
         Dh7UY6UbfGzDOJDb5JL2qxBNG6JQYpN6O4B+OwZei4PM4dj9ohwtovaiY8E03rX+zVFW
         tM9SmiC3Jf3NW/bv6/gqes92jTnMPyKbEdQ3M8Xlk329xF9KxNnM8qVtA0nG9We1pZm7
         wog7FIZ3gGYP2WYRJ1xZa3Z5eiVOUeYfatdxGB53D0UVwoTa7dZ6sqhVsYuJPajenv/D
         9dgg==
X-Gm-Message-State: AOJu0YwJaujOj9SpFnYfpcCh/bEKhwUkYj+99jDuQ9z2BNLsFC8u+pcP
	PDSC9L8MQE0uL2b+3QCxqd2ztQec/mnjW6OBQQuHz/g3HfAg2txzRy4BUMVhZIzvEQ2gJpaHD6C
	sdQ==
X-Google-Smtp-Source: AGHT+IHOlHSl+cTZyC4uq0Q+4FX/lDRZCbT49C2vuUwUTLFpr3fu9v9q9yWaZlGTC0/nL8JeHBMtiOebmw==
X-Received: from plat5.prod.google.com ([2002:a17:902:e1c5:b0:24a:f8cf:c06a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce03:b0:248:cd0b:3454
 with SMTP id d9443c01a7336-24944873445mr201786195ad.9.1756968932344; Wed, 03
 Sep 2025 23:55:32 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:49 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-20-sagis@google.com>
Subject: [PATCH v10 19/21] KVM: selftests: Add wrapper for TDX MMIO from guest
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
 .../selftests/kvm/include/x86/tdx/tdx.h       | 14 +++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 23 +++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2d4fd68984a0..1a73e08c8437 100644
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
index 000000000000..f9c1acd5b30c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -0,0 +1,23 @@
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
+		.r10 = TDG_VP_VMCALL,
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
2.51.0.338.gd7d06c2dae-goog


