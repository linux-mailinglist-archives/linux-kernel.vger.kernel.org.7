Return-Path: <linux-kernel+bounces-879072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD1C22348
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B91804F4B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84711375759;
	Thu, 30 Oct 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4D8w0xNw"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4D375758
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855059; cv=none; b=hsHdssH4nbqC4EokkYy+btlANTTWy7B+bnfHCQmN/AQSuuIbZimtEJx9zD0ea/wX9WFAWWejYQjXzrnQzeFearaG76QPXRadYWz8sTKp8lTrVlsJ9c9qcTMvamLGCqmzfb/yEzrFW6iXw9x5u882ND9yleSPzSQnNH2WUf8i90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855059; c=relaxed/simple;
	bh=kotZ+hJUlfpAI0fz7usDYLNjU5vqssCEbgz3qGC9nmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FbM/7006v4CHGaO+SV667PnbGrAa8zm7qSDDwHISF5KKGH34GRqWCWnbIbtBOa92b5QrDPiuXizstbDki7AdHOmATygXmT/BmMqwNup+02vzas2c89azpSQ3JR+GhTXf1Wo6DAF1FBl16ngolkr52X9dGsgjAw2+HB55PyYLT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4D8w0xNw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34029b3dbfeso1711092a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855057; x=1762459857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8YASmmQaw2bp6ARedML0HqNnGQNivMGsg1DfU0cvX6Q=;
        b=4D8w0xNwqW0F6qU1u//NgQMhdmpW6OjNk1T8HYoimdx5sjIK0MJ/ks5deLG2Z1gXCx
         vZPpp5PdXxhc/WDN/nyNnyZ9DOKF/VW9Wlo24rxy+AmgEKWhQM5UIbuPsdxhLn/EfA9k
         Q91DwMiE0Pc5Q/G38qGvtY9Fpih0JO+2/M0uTI4Uo0wa6M6trdVjVPZPBdutsslUeUUS
         MXjv4xIBDMARt8KHCO9IWY74cN4wg2FXFvJGEOaqOCosBJIVVdcJfuwtNvRfrG2g3SXD
         qH392dTlM5Hll5IZfkzeDBBAqgHQrbJOPlFy8swovlo6pAOpjz5sa8kPUUKjuIhDiauk
         +Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855057; x=1762459857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YASmmQaw2bp6ARedML0HqNnGQNivMGsg1DfU0cvX6Q=;
        b=QIrc2GE6L6eHYBNypbfG5YfUAB3U3Jj2XWYmYUF73jOKHKd1yxl4xwXZK8jDiW6Stb
         kEg8TW8HeOGRdLOI5r7XL9DrU6xh0azM51Lh2XnOJKVfzdHfUTnODn6sgi7gnIOjoRCn
         3MbNAQlwhN4NEJrfA9tw6Vk+F7vHHFZA1vKaRGtL+cLRxEYDskLDvrk5qVFEVaBXAI6C
         E1ce1n2MJODTNpy0QaBo9Pgvdef+8oSwLXMtmy2X9jQAH916A6SXT4FT+ADANEBucIlQ
         vmKcMisrMWidTq2xhUMj6jvegztNkivoUwLPc4SOZkF4cUS4TpY/vPvmY8EUGOX8Vp6i
         f75w==
X-Forwarded-Encrypted: i=1; AJvYcCXoBbfEEmOn/3Ajr7Ccl2iKJItDn1vnLixpHhI9+kPvv5RrdHDn0k9SPbeF+y9MMwpR3K0SADHCB1F7LPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDVzwydJLD8jW0ggdVl1GUwTdQ8ukq7sGJ372JbOwPjJSbzY4
	pmteMCU1OpQnqvf3d6nMkP13cF1DrUa/Y9BIGqCkpeOAI4IF9K6azpbqG0Fe/jD18tie6yi9o4u
	NbUD4+A==
X-Google-Smtp-Source: AGHT+IEJ7RyLZ+kuNy3gvYryYSQgpwzE5exie7vcyQeCPqNyLi6NBzIMgPjXgsonnZ1/wfIIShZ4miOVTHA=
X-Received: from pjsf3.prod.google.com ([2002:a17:90a:6543:b0:33b:51fe:1a97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120c:b0:294:fc1d:9e0
 with SMTP id d9443c01a7336-2951a54d0afmr12621765ad.54.1761855056839; Thu, 30
 Oct 2025 13:10:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:46 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-24-seanjc@google.com>
Subject: [PATCH v4 23/28] KVM: TDX: Convert INIT_MEM_REGION and INIT_VCPU to
 "unlocked" vCPU ioctl
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Handle the KVM_TDX_INIT_MEM_REGION and KVM_TDX_INIT_VCPU vCPU sub-ioctls
in the unlocked variant, i.e. outside of vcpu->mutex, in anticipation of
taking kvm->lock along with all other vCPU mutexes, at which point the
sub-ioctls _must_ start without vcpu->mutex held.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/vmx/main.c            |  9 +++++++
 arch/x86/kvm/vmx/tdx.c             | 42 +++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 |  7 +++++
 6 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index fdf178443f85..de709fb5bd76 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -128,6 +128,7 @@ KVM_X86_OP(enable_smi_window)
 KVM_X86_OP_OPTIONAL(dev_get_attr)
 KVM_X86_OP_OPTIONAL(mem_enc_ioctl)
 KVM_X86_OP_OPTIONAL(vcpu_mem_enc_ioctl)
+KVM_X86_OP_OPTIONAL(vcpu_mem_enc_unlocked_ioctl)
 KVM_X86_OP_OPTIONAL(mem_enc_register_region)
 KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
 KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 87a5f5100b1d..2bfae1cfa514 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1914,6 +1914,7 @@ struct kvm_x86_ops {
 	int (*dev_get_attr)(u32 group, u64 attr, u64 *val);
 	int (*mem_enc_ioctl)(struct kvm *kvm, void __user *argp);
 	int (*vcpu_mem_enc_ioctl)(struct kvm_vcpu *vcpu, void __user *argp);
+	int (*vcpu_mem_enc_unlocked_ioctl)(struct kvm_vcpu *vcpu, void __user *argp);
 	int (*mem_enc_register_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*mem_enc_unregister_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*vm_copy_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 0eb2773b2ae2..a46ccd670785 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -831,6 +831,14 @@ static int vt_vcpu_mem_enc_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 	return tdx_vcpu_ioctl(vcpu, argp);
 }
 
+static int vt_vcpu_mem_enc_unlocked_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
+{
+	if (!is_td_vcpu(vcpu))
+		return -EINVAL;
+
+	return tdx_vcpu_unlocked_ioctl(vcpu, argp);
+}
+
 static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 				     bool is_private)
 {
@@ -1005,6 +1013,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.mem_enc_ioctl = vt_op_tdx_only(mem_enc_ioctl),
 	.vcpu_mem_enc_ioctl = vt_op_tdx_only(vcpu_mem_enc_ioctl),
+	.vcpu_mem_enc_unlocked_ioctl = vt_op_tdx_only(vcpu_mem_enc_unlocked_ioctl),
 
 	.gmem_max_mapping_level = vt_op_tdx_only(gmem_max_mapping_level)
 };
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 390c934562c1..d6f40a481487 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3171,6 +3171,42 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 	return ret;
 }
 
+int tdx_vcpu_unlocked_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
+{
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
+	struct kvm_tdx_cmd cmd;
+	int r;
+
+	r = tdx_get_cmd(argp, &cmd);
+	if (r)
+		return r;
+
+	if (!is_hkid_assigned(kvm_tdx) || kvm_tdx->state == TD_STATE_RUNNABLE)
+		return -EINVAL;
+
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
+
+	vcpu_load(vcpu);
+
+	switch (cmd.id) {
+	case KVM_TDX_INIT_MEM_REGION:
+		r = tdx_vcpu_init_mem_region(vcpu, &cmd);
+		break;
+	case KVM_TDX_INIT_VCPU:
+		r = tdx_vcpu_init(vcpu, &cmd);
+		break;
+	default:
+		r = -ENOIOCTLCMD;
+		break;
+	}
+
+	vcpu_put(vcpu);
+
+	mutex_unlock(&vcpu->mutex);
+	return r;
+}
+
 int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
@@ -3185,12 +3221,6 @@ int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 		return ret;
 
 	switch (cmd.id) {
-	case KVM_TDX_INIT_VCPU:
-		ret = tdx_vcpu_init(vcpu, &cmd);
-		break;
-	case KVM_TDX_INIT_MEM_REGION:
-		ret = tdx_vcpu_init_mem_region(vcpu, &cmd);
-		break;
 	case KVM_TDX_GET_CPUID:
 		ret = tdx_vcpu_get_cpuid(vcpu, &cmd);
 		break;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 77613a44cebf..d09abeac2b56 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -148,6 +148,7 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
 int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
+int tdx_vcpu_unlocked_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
 
 void tdx_flush_tlb_current(struct kvm_vcpu *vcpu);
 void tdx_flush_tlb_all(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b85cb213a336..593fccc9cf1c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7243,6 +7243,13 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 				  unsigned long arg)
 {
+	struct kvm_vcpu *vcpu = filp->private_data;
+	void __user *argp = (void __user *)arg;
+
+	if (ioctl == KVM_MEMORY_ENCRYPT_OP &&
+	    kvm_x86_ops.vcpu_mem_enc_unlocked_ioctl)
+		return kvm_x86_call(vcpu_mem_enc_unlocked_ioctl)(vcpu, argp);
+
 	return -ENOIOCTLCMD;
 }
 
-- 
2.51.1.930.gacf6e81ea2-goog


