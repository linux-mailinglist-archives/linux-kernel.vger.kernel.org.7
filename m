Return-Path: <linux-kernel+bounces-778937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE9B2ECE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41246189976C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC22EB5A9;
	Thu, 21 Aug 2025 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1oS4jmV"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C582EA732
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750584; cv=none; b=AClBmVhEq296f/deaFK8RH8ZxWeXdh1/Ax4JxvQvPoGIbiVlUBkKrjyg2ondzK27xerP7SvZUGNxz+rO4MQ1ENf6nmdfjozQ/3AiQhRrH9j0Qv5v0KLFRDnen1d6dZotSOCS+MC2VjiutGkW6bqtIRnrK3HptxFwxSelXST3040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750584; c=relaxed/simple;
	bh=lkWYI2eQ0TehZPSXSZi03dGPvv9GRnxw4MX+39Qfpbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ub1fnrv3Kl9kNDJxFjgHg3TxhywFZkAM/qcW8GZXm7AO5cVu1xsavDTY86RsiNWauf0+HwzSUuBkvDZ4xr3bXKWFy9Bb7Rg/IL/wf1+sy/9Z0MH88O3LuEbU4/2nigfmYQJX/Gyr02tyHrIlDplph0Wr/p/va8vgcWm3RIMjI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1oS4jmV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eaecf8dso560247b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750582; x=1756355382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDeNE5iAonDlUL7Pct+6ZOd+K+xrGXc16uekd91Q/5I=;
        b=Q1oS4jmVFg3KQV17ZJLIs5HkEQiNvO4PtV++LKtWOsdEioGYw99zV9jnDTgyD3u9Lw
         ddB0dNsRA6ta6p8BzeRZKzo0Go1TnCl7ca4/7Y/SVBr8HXjQEZsspewCWjDM7HQJ4Qsi
         vmvpwHeiYMLsyipQg0WiZ7smGYo1M0VsYqXhO8UK0XbfWvytp4UVxIgyF+XYg+oXrB9F
         gmDQsz8M30tmZnEUFasfTfOPNmAKx2LiA9kr8Ynn2h6noE4k/O3W63Plu7o3LxP0uW5L
         N6D4jNAPVqRKI0rAOoRUwhMdl87ZBSmisl1mvVsf++3xWDiregVaZ0SP0zpBe9hiszNF
         0IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750582; x=1756355382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDeNE5iAonDlUL7Pct+6ZOd+K+xrGXc16uekd91Q/5I=;
        b=GoMp04fGaudnuEidWBW63pDuT/iwjYpCEI2CEHHlI4E0vDif9IHga7gPu9AkRQ9FF7
         wceK+2BPy6slB+F96H9jiItUCylTqqwUE8LKgGZKR1xG5Ag48NwxEyOwMHMam3KOoQ3c
         bd5MRPymsKrPU7+fUDvPtTldEkk6geHJGi0A8n4klNjqWek5hTrCfeClH98QdW/3hYkw
         vkYIwQmF/ogh1mLHBLALXO7XdJZ1KmvSyXSnGHiTEHJMiPBdORST0jW6S4deU1jX4cIn
         T9Qtn5jqMYR0rd6LLG0gMx+yvoGSy1LPzo+F6Ni53Dp/2P7/etMi9d++xPWOPQSEPDKd
         cruQ==
X-Gm-Message-State: AOJu0Yx9BUriuaeOJX5rVT18fFZGZY49JWB10k/L+GeW+Q8zcPzw+VUs
	3wPNDvPTtfI+ruxthByfEPxowXfaTF4PoqGaueubiHRGQbvnFTt573iGgHWWt90IzTsThs0V6q6
	xXQ==
X-Google-Smtp-Source: AGHT+IHKRDJjcyAhzLb1tn5Uvi6wgzpSkDCOSrOrbDP+zZSi1YfnWwimSTZGf4qDx95GmmmvgAD4Y+Orjw==
X-Received: from pfbdi1.prod.google.com ([2002:a05:6a00:4801:b0:76b:eff0:e9b7])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8a:b0:76e:885a:c33e
 with SMTP id d2e1a72fcca58-76ea32708d5mr1139526b3a.28.1755750582085; Wed, 20
 Aug 2025 21:29:42 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:05 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-13-sagis@google.com>
Subject: [PATCH v9 12/19] KVM: selftests: Add helper to initialize TDX VM
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

KVM_TDX_INIT_VM needs to be called after KVM_CREATE_VM and before
creating any VCPUs, thus before KVM_SET_CPUID2. KVM_TDX_INIT_VM accepts
the CPUID values directly.

Since KVM_GET_CPUID2 can't be used at this point, calculate the CPUID
values manually by using kvm_get_supported_cpuid() and filter the
returned CPUIDs against the supported CPUID values read from the TDX
module.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  54 +++++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 132 ++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index dafdc7e46abe..a2509959c7ce 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,6 +11,60 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+/*
+ * TDX ioctls
+ */
+
+#define __vm_tdx_vm_ioctl(vm, cmd, metadata, arg)			\
+({									\
+	int r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (uint32_t)(metadata),				\
+		.data = (uint64_t)(arg),				\
+	} };								\
+									\
+	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define vm_tdx_vm_ioctl(vm, cmd, flags, arg)				\
+({									\
+	int ret = __vm_tdx_vm_ioctl(vm, cmd, flags, arg);		\
+									\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
+})
+
+#define __vm_tdx_vcpu_ioctl(vcpu, cmd, metadata, arg)			\
+({									\
+	int r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (uint32_t)(metadata),				\
+		.data = (uint64_t)(arg),				\
+	} };								\
+									\
+	r = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define vm_tdx_vcpu_ioctl(vcpu, cmd, flags, arg)			\
+({									\
+	int ret = __vm_tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
+									\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);	\
+})
+
+void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes);
+
 void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
 void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus);
 void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 52dc25e0cce4..3869756a5641 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -125,3 +125,135 @@ void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 
 	vcpu_params->guest_code = (uint64_t)guest_code;
 }
+
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+	int nr_cpuid_configs = 4;
+	int rc = -1;
+	int i;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
+					   sizeof(tdx_cap->cpuid) +
+					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
+		TEST_ASSERT(tdx_cap,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
+			    nr_cpuid_configs);
+
+		tdx_cap->cpuid.nent = nr_cpuid_configs;
+		rc = __vm_tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno == E2BIG);
+
+	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: supported_attrs: 0x%016llx\n"
+		 "tdx_cap: supported_xfam 0x%016llx\n",
+		 tdx_cap->supported_attrs, tdx_cap->supported_xfam);
+
+	for (i = 0; i < tdx_cap->cpuid.nent; i++) {
+		const struct kvm_cpuid_entry2 *config = &tdx_cap->cpuid.entries[i];
+
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			 i, config->function, config->index,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
+static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
+						      uint32_t leaf, uint32_t sub_leaf)
+{
+	struct kvm_cpuid_entry2 *config;
+	uint32_t i;
+
+	for (i = 0; i < cap->cpuid.nent; i++) {
+		config = &cap->cpuid.entries[i];
+
+		if (config->function == leaf && config->index == sub_leaf)
+			return config;
+	}
+
+	return NULL;
+}
+
+/*
+ * Filter CPUID based on TDX supported capabilities
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   cpuid_data - CPUID fileds to filter
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * For each CPUID leaf, filter out non-supported bits based on the capabilities reported
+ * by the TDX module
+ */
+static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
+				struct kvm_cpuid2 *cpuid_data)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+	struct kvm_cpuid_entry2 *config;
+	struct kvm_cpuid_entry2 *e;
+	int i;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	i = 0;
+	while (i < cpuid_data->nent) {
+		e = cpuid_data->entries + i;
+		config = tdx_find_cpuid_config(tdx_cap, e->function, e->index);
+
+		if (!config) {
+			int left = cpuid_data->nent - i - 1;
+
+			if (left > 0)
+				memmove(cpuid_data->entries + i,
+					cpuid_data->entries + i + 1,
+					sizeof(*cpuid_data->entries) * left);
+			cpuid_data->nent--;
+			continue;
+		}
+
+		e->eax &= config->eax;
+		e->ebx &= config->ebx;
+		e->ecx &= config->ecx;
+		e->edx &= config->edx;
+
+		i++;
+	}
+
+	free(tdx_cap);
+}
+
+void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_init_vm *init_vm;
+	const struct kvm_cpuid2 *tmp;
+	struct kvm_cpuid2 *cpuid;
+
+	tmp = kvm_get_supported_cpuid();
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
+	vm_tdx_filter_cpuid(vm, cpuid);
+
+	init_vm = calloc(1, sizeof(*init_vm) +
+			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
+	TEST_ASSERT(init_vm, "init_vm allocation failed");
+
+	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
+	free(cpuid);
+
+	init_vm->attributes = attributes;
+
+	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
+
+	free(init_vm);
+}
-- 
2.51.0.rc1.193.gad69d77794-goog


