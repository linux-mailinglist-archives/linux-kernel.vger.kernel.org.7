Return-Path: <linux-kernel+bounces-778938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF793B2ECF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB36E5E82B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FEF2EB5D9;
	Thu, 21 Aug 2025 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xs8hNWM/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C912EAB89
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750586; cv=none; b=hKhOkmV3EKWhAW1Elp9DrmvTgSAHDDatWGwYz4OqZD5+4OYtJ+ApfQsdcTOXUQkOoxU1raVcgwUZfRqkIamoxfxcqt6UVrJQB5IDQhUyM97MfpAeGDaTy4Fi2xQtn5GU2N5qeUZXPrySZj8N0zWySBFQhUHPtJxsC390bwYZXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750586; c=relaxed/simple;
	bh=8LW9fPqlqltwsHHnngmKu/oedqkqhCGSJV7BughN2D8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jg69qWN0BrRfO62ByC6o869rz1TRy2jYOWKJqFWAefxQwlURrKIf+H9LbWEHOV/tJlemRzXZy7dy3PClTkAHHqwRzOQffaJXnCTQMZ1xhW1ibQI0oCDHIpz2KVKgPkPZ9TkrPj8BJHJH/hKoMw+iWpyVaUVdVdhu2lyYNjrARhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xs8hNWM/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471757d82fso462987a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750584; x=1756355384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0v8Xhqku7JbLYSzHfxNxFV/zNuQzZHa6ydPXR+w0a3o=;
        b=Xs8hNWM/wbZOpxKY2rua9bKgcOvvGUATzpLjyBXCipood0F923RUDdzy3y4NKMpYGs
         NlEzcblJ7v/cOhmmGIWzN7bpxKdUWgcEiE7/EXeV971Wmi1bWnxKwq7RpzZikyjF0LX9
         I6Auj6Eb03Iic5LNBLXeg/7knEz2tTvHbKIQ+2TW4imekMVnv7xs5Jhd+QiCpylC5VvF
         +x7Si4aq0/+HxHj3m9daV+v526hPdYz9093Pxdi7vH34WesGp4+baHBTxgVOd/H2s8SI
         t5re4iOvxptjb2B4gTp4V4R48BEOxnUlB9BZV+h/BV2k+vBACTZGK4Hp791Yepa5Fqnm
         UX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750584; x=1756355384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v8Xhqku7JbLYSzHfxNxFV/zNuQzZHa6ydPXR+w0a3o=;
        b=AaBIMjWOXOxdk7rKXfImgcJzED6FdMYAT9y9/sBDf7ZJtE6Scz1v/VkCL2jcEUXkX0
         Noyxj85emOSAB2yYDanPEZASqbG5wsWak+CiIq/kQMQvf0PwUMDETk7FxkpRmLnVucbT
         /ShaVbIwJhhuRtJx3sjEueaZ/QicUUReO9R5lCJtUKienKZTRGImIghkClKatel1YYFO
         UQsDoyx31oOPYQtBfhYBpQIGRhTXIncuD1+Qk/kGYoEfzwTbf31oG+98igMcoYXJE/MK
         I6EO77tSrAJI2ALyYA7tUimJ79ZypxC2LDtqj0CUkvbFSYmdAanLJZugMDvgPIU3St++
         U/Uw==
X-Gm-Message-State: AOJu0YwZdfAG3E2P0Z2cY0C8fZQFBk2FHrBVmXN+gab8nHnlTf0LSpPY
	sTnT1Q02JYzKvo4sC50TxOnfh6CGtskNK2C89Rtmvz9uhNKp0vzPYLsEOf0topcvE9nn8PJNDkz
	5Tg==
X-Google-Smtp-Source: AGHT+IHoYEwP7EzZ53USD2mIjc5qGUC3k55bBLYh38dEin6rSVJ2mTGlfcHpGpSYs073s+UjtI+o0y1iHQ==
X-Received: from pjbli15.prod.google.com ([2002:a17:90b:48cf:b0:31f:1a3e:fe3b])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca7:b0:243:755:58ae
 with SMTP id adf61e73a8af0-24330acb929mr1268174637.47.1755750583705; Wed, 20
 Aug 2025 21:29:43 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:06 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-14-sagis@google.com>
Subject: [PATCH v9 13/19] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
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

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 3869756a5641..d8eab99d9333 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -232,6 +232,21 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
 	free(tdx_cap);
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* TDX spec: any bits 0 in supported_attrs must be 0 in attributes */
+	TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
+
+	/* TDX spec: any bits 1 in attributes must be 1 in supported_attrs */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+
+	free(tdx_cap);
+}
+
 void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 {
 	struct kvm_tdx_init_vm *init_vm;
@@ -251,6 +266,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
-- 
2.51.0.rc1.193.gad69d77794-goog


