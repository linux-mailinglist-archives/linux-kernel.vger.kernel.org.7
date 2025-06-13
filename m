Return-Path: <linux-kernel+bounces-686275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CDAD9559
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 21:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1FE1E4B30
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AF2EA469;
	Fri, 13 Jun 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UJwAMhc"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A32E88BB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842093; cv=none; b=u+bHeP750IcMf808hSUjugFQ6c+V940zTk7E8uDfYArOCs9kRMpYN6vuPIItpnmPJev9YFHB/3dVnb3N8bTB1+QMqcXVJbMEiDGqNBvMEQhSR0znMBZsVYNz+dxBIQoQMfIfqzv6jKSu2l6u5FpZxn2PHsMoS9Gg/F5fhQVVhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842093; c=relaxed/simple;
	bh=p5mVv2Pn2uoXBdPztpidNAvEhFnz01TXj3tCpH3ztA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=biJMr8cI9LPTGUUYJX+3ZBwSiCy91O4ZjRz/u7jAnmPU88NhIFd0mDNLv71BFeGQUaLZO9/pRaACwtMnBfZIc/wKLElf/ovAwOmzSqROAczAm7aZ8JyfEyfe5cSzXchatp+xCiZSembmdj3POvDrSAHXj2Xy7cM4hvfaDOOvJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UJwAMhc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7462aff55bfso1856323b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842091; x=1750446891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxHBtKGYFXqL/z5tygWlXIcu0CsriDSTXmUMupVW9L4=;
        b=0UJwAMhcajYHqz519rNcB9dKPDD3ya+V0QcUzqWKvmEr9w9ME1eIM4vLeriNUhSD70
         /B2qXRExMN+yWZ2H1uCPmyfAhKgVLeBevDATocTcTAkbLGd3ZhjYXnF1d52rjbb6OsoM
         HO1Ue+nPP6Dal37ocZh+TdyPBcOD/Rm4HiegYBnnD0nkwLU6Nwdecrm1OfwSgr6FuooN
         xkvhA935bmp7i6h7ul/LgTQaS2CXslCtuc+mEuERYg7GK7Y29RSX1pvW1UMZUGgNoIPl
         jFK0BughxkmTZ3IyNoeFOx/TBFwf5KlWt6GxNoetpttxI78jGPkYLvVYGQpPiXNzGmSr
         fvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842091; x=1750446891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxHBtKGYFXqL/z5tygWlXIcu0CsriDSTXmUMupVW9L4=;
        b=LRqacUoEoN8jVCBFpKFNrYvQ/IfH/90pbQF+HaDn1FE+ayZrz+z9j2fBr2Fa0YizDG
         tu0DFyXr2rHxcHNcDJwtqjnR0568fzDdzXtwn3pbTwvgJsTxGQQoi6MizFGNsUhxYq4v
         PTMNpGYtJ8OW7JDdvT77nuLGa9eEkgOp/O7hiOC41wKKZJ8BBsBkYYYev3PIySpnORlV
         TdFEMJhuSobe1K5PT76o/l7kHhB+Yy3SumNj9tPcfRbdff4HcIqqFjXJxPFe/h3s0udf
         TQixBoJDOZcVqwT0JCv3DYObXEq6zE1Gxt7tPb9PFnKf0wwJKhtvh3S6Oyd5F8CvtnhK
         L1+Q==
X-Gm-Message-State: AOJu0Yz9roYEX3U/imoszpkhZsFUrqYVcVIODjgjgkDs/bfDjpreGoy9
	hUH7/3LJuiJwrleg99p4FWTwBQEeyCCoXL7k7ID6CNU7uELubgXiEsX5BTfR2oZH/9/R4++NX8f
	IIQ==
X-Google-Smtp-Source: AGHT+IF9SjxAJ1+SnSalJ4CJc1016/+azFzl4bh2ehvVkOztXbbhEGQS0jSxCgxjTy3Ydq+j8SkNUNlZdg==
X-Received: from pfjc11.prod.google.com ([2002:a05:6a00:8b:b0:746:2e25:5c93])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:852:b0:736:a540:c9ad
 with SMTP id d2e1a72fcca58-7489cfca938mr735078b3a.20.1749842091283; Fri, 13
 Jun 2025 12:14:51 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:53 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-27-sagis@google.com>
Subject: [PATCH v7 26/30] KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Add support for TDG.MEM.PAGE.ACCEPT that the guest uses to accept
a pending private page, previously added by TDH.MEM.PAGE.AUG or after
conversion using the KVM_SET_MEMORY_ATTRIBUTES ioctl().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h | 2 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c     | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 88f3571df16f..53637159fa12 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -7,6 +7,7 @@
 #include "kvm_util.h"
 
 #define TDG_VP_INFO 1
+#define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_MAP_GPA 0x10001
@@ -40,5 +41,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index bae84c34c19e..a51ab7511936 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -3,6 +3,7 @@
 #include <linux/kvm_para.h>
 #include <string.h>
 
+#include "processor.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
@@ -215,3 +216,9 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
 		*data_out = args.r11;
 	return ret;
 }
+
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
+{
+	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, (gpa & PAGE_MASK) | level,
+				 0, 0, 0, NULL);
+}
-- 
2.50.0.rc2.692.g299adb8693-goog


