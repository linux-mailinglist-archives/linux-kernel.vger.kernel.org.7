Return-Path: <linux-kernel+bounces-832975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D84BA0DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29B77BF357
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482831D73F;
	Thu, 25 Sep 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phqyScAG"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D431BCB5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821361; cv=none; b=NBXIYLLE9yZHomCLLTYAl5fVAa2mW9+pbd6IbLI3gqrzkqruz6S+FOnxIHfjjQ+AQQS5eh8xE5qKecsVbbOCd+0/qyVYZnt4Hqaz93uGFjm9kS4sGsc2vOeF+yw5GNs6Sdch8oVCOVIhAPi+JgtQ/tSmxMP1DcV4axlujovQRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821361; c=relaxed/simple;
	bh=kyNUo03VHcUtqgem5Ure2zDndq9TR63HAvb7v0MESQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uz1M2Cyc93/gV8ZtJhsahfQFFcmR772TghLSH59fx+KrZX0ABSz6cIOJKxi8l9kbVZ4Pr59uUsfCuryeZ8dA5fWSSvbl9O/HhX3/glb3GYy6oJSzcRl4/2X7rT7oYkw+jsjK6NpN1LP1OksDdnxN6oZuWBjJSP8IA+B6KtdoBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phqyScAG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso824955b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821359; x=1759426159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MAW67C+26Du9WD+afvdTUdsrfWFPaXzJwetR1H+pT8=;
        b=phqyScAGkUBL9wXzNie4OEXIrmTcV42jIoB6IEB0Sq1H+T0wUvuThPoMB6GJYM5Tab
         x+dvPcOT7vIGFdraHA2cylqsnLeCORas9YDvcC57qDiSVl/WXRFfky5yup6rT4vAmuzD
         u23tLucbiGZQKi9e+eDw2tjKh1BCzxHU754xw6Fr9Cmv20LAFlMCh76mu+VxA30USd4n
         PXx1PtblsY2rHhVGKkjRUyf7w81o9/j05AWMXQZltuxd65DuJQ8z/aG27SLBVA0zgMSx
         Mizz/VALe6ZbjB1WxImhRP8QJ/E3J0ay86Indn/NGTov7RgoSi9UgNdWe6jELyRY0yXu
         cHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821359; x=1759426159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MAW67C+26Du9WD+afvdTUdsrfWFPaXzJwetR1H+pT8=;
        b=l4AP5ye2akIsY4x8SIGt7r4/lyklFPEs/8hUtSWxTxxaVQhxkEosZOQu3Ax6pA9Uf3
         h+qR72NFiaxeRG0uYBsum7SdFYXsQAU6meaCk+fGTPaf5dpW6fAmeKQpItkG5bG6JaUF
         XiXb8o3zBv+aaYLCqZxdLXCiqocC8Bw/34Es/M/2zus+G41F4so6lmSuXuRjUaj/VF8P
         7aUFjDaqaTBSl4YTZI160Gx9MWO82596iBg9ED+aIi54dbmuh3rlFz2hRnb9AgtkAfQI
         4Gp/KIsnN0+VMp0xxw/nJw3IPS1HIplUFFlTOJK3ixWB8B3vkXcQFfaJ5CpyrP2R8ye+
         Y1Bw==
X-Gm-Message-State: AOJu0Yx6z64Ja88QN0CrAFQ5FR3JdIiuPcfRjLIHgLPHtypF04+FKFTO
	KLQ2wc7qnxjT/iHcUUFpLRMl+F6wrOQmY82MW6KhdlavXE3zO5qM2ehATlB59o3EDVF7Rx0iJit
	Glw==
X-Google-Smtp-Source: AGHT+IGwUeh3R66fQdhA9+GehJSHKHpxVELu+AiwXNl9uAO8pVVzXP1LD+WHAVUHsIgABaveFX8UT5GZaw==
X-Received: from pfbk26.prod.google.com ([2002:a05:6a00:b01a:b0:77f:5efe:2d71])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8895:0:b0:77f:449f:66b0
 with SMTP id d2e1a72fcca58-780fcee0494mr5488295b3a.32.1758821359006; Thu, 25
 Sep 2025 10:29:19 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:40 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-13-sagis@google.com>
Subject: [PATCH v11 12/21] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Make sure that all the attributes enabled by the test are reported as
supported by the TDX module.

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 7a622b4810b1..2551b3eac8f8 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -231,6 +231,18 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
 	free(tdx_cap);
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* Make sure all the attributes are reported as supported */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+
+	free(tdx_cap);
+}
+
 void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 {
 	struct kvm_tdx_init_vm *init_vm;
@@ -250,6 +262,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
-- 
2.51.0.536.g15c5d4f767-goog


