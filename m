Return-Path: <linux-kernel+bounces-874729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F359C16F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A55B4FE895
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B9358D10;
	Tue, 28 Oct 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEpEtK42"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA49357A31
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686472; cv=none; b=bzhIuhur7i7gm2AgXmlNzAuxcLlTAzMm9fb85h+t4LlF9J/8CSf3bOROMSPGy2SYm8UZSl8B0mowsHtym4tXKcn34V9BUy1eDwxzs7C4gfAcSGsnM0W4lTkuqki/JYAMwMxrK7BBkRI8KD84ZOurUHlzT6NYE31Wl+mt/JiEJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686472; c=relaxed/simple;
	bh=Beg5l5GnzctCJzgamlm3q3eIKOOQS9dc/q2TB/QjYmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+qCKuTsIdncUlkTd7jExDRaRAuck70NumLXElnd/ThSRuYCaM1bTF0dyq9vX48zOkbbrBRneJ1u0csjdtqNaIlfYjj9fXtP2PXETfpgm1m+lKSGmeYJeIx5hq4P3PY2JiVYrpM1/EBHj77aTzwQ6W/g9qjjX5jTu3qIKNns5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEpEtK42; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-940f9efd090so2079336939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686468; x=1762291268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqk3ap2s1j8LuUHJMTA+8RH7bEkzoQ7jFIzEsK1w1ok=;
        b=DEpEtK42Arm29HypAab/BnkUq0Xs+bs6W3zLUJwz8FkooJI5FKswlGWpl2LQh0cZcy
         Yg4hF1Rph6E43CAZ58WMVCQ3RwOJU/qZpqP9+a3nu3+/2PLPAZ9+keDqwpPyIu0dGtKh
         +JO/RYvjQ3SIuVLYk6rlGLWtTa0rFJVsClxOskeYGwt4bjG+CgbIrzbpGhn+6MH4f25Q
         +bq/d0oVrVvafJXdSjCIJ+qurrwJFvk3o3LFOvTmuQB6uMgVmJRsLDwOgBpQcbZqlX9M
         NxyrFGFWTPeUZif27tzpNGNbb5SveymPo9saH/+ZThvJDExbOQ7rbZhFYrWUBWtQtbBn
         oA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686468; x=1762291268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqk3ap2s1j8LuUHJMTA+8RH7bEkzoQ7jFIzEsK1w1ok=;
        b=k/QKk0ngUZkpRvwuf29vlTO1D+JCCSw5Y6dh83pF412BuHdnUiksPjFZNrMj0AyMzv
         0KEJzQIKM1WSm46ry4NrY6tmxzTmjLfGdvoUTeWraaA81wWl6gw+Cfu89P+TBG1raUtN
         cq0Qz/N6vWd9dVR2QIXUbwSaxGIA/m2dyXLtciX6w0p84pnCYu7elKA3PXykgCxKLUof
         UTeEqFZo5L+PSfp4FD1IR+NuTziBom/UHXc8TSe4PhOvfmkjjWOS9yhAXhOZ1uom8+uJ
         1NusEV+MAfvA4YGpGXM67sUAFkkqQ0M9KrzMM9ktoQEFbKDxIqm6+VunLxHGQBqfPn/X
         ZPJw==
X-Gm-Message-State: AOJu0YxyxfaLE9WrUpByNThi/a50SU6TW0AmiW6Wyg0QGelqKCh2L/z0
	Sq51bZe1paOdH41VRgL6Z3jvegD2VKWTIiIYWoDxKfdY4HApswwHKe8ay1Gb4ojLTj014eF4wAR
	+6g==
X-Google-Smtp-Source: AGHT+IGP1JAiIsh896FE5wlZg5zutyX7tNi20B033WUKmmsMam0fKRXd2ZWfh/OEDsGDBnIKNMeiTc5PvQ==
X-Received: from iov16.prod.google.com ([2002:a05:6602:7510:b0:8d2:d755:be95])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:3f85:b0:945:a27c:ab2a
 with SMTP id ca18e2360f4ac-945c986cc06mr128542839f.13.1761686467984; Tue, 28
 Oct 2025 14:21:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:39 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-14-sagis@google.com>
Subject: [PATCH v12 13/23] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
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
2.51.1.851.g4ebd6896fd-goog


