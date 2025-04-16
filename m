Return-Path: <linux-kernel+bounces-607542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792AA907AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2864F4477F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B53720D4E9;
	Wed, 16 Apr 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35vYyYP5"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19072080DC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817217; cv=none; b=u9KiE69o+RxEGXHG9g9GZV6FSKv2f/4RFdJJmYIMknjD8YIfQxCztlgjnMkR25AcvLfpenkzVJc3XYL14xcSu3ev5wdcWGlVXlRHU2pIhgBwH8Iish0JhMoWBTvmqFymKFJvu9GnnJoT47pkmh7HzMvoKR3ZYZwcGJ4IK7q/zls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817217; c=relaxed/simple;
	bh=+tI4PEfGQfafoe0FcQqYYwv3iwkEbI6CYxC3OLOKiy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZlmVvxk0WlXWTZwFpm/zpphLsyAuE32bs80TaLfzhgJwAjLXi/dlFRa+Te1Ucp5W8ERSQUIKZ89YpUWyWgdNNxnviAuNa/cLgsT5Lp+NM95pOI2ubFM0KA5WpPkG2z1yBR8+sOEVtZ2sKltLRzt21gOoCRWnqq8SefKLPKIG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35vYyYP5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e5d9682f53so5918890a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744817213; x=1745422013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzD2f0rxQ0+kK+W36kLcNjO+gtstze2fsnlGYTmtJfM=;
        b=35vYyYP5L6+sw3b90ckhDCjI6k+3M2oTHD60jf5nVTL4GVAiLv1VGrXBkKVYFAtQ0p
         xEb4hLrUJ7OrYvQnLPUDdBm1JFmJHYinbJYGOLwEpfk6sZwcYN2NahrjYj1/p+/OUvqd
         bxHxNZ8li9q/SrhFLJwcPIKq40fNheD+mjakPgFHevoPDbZI269034wQMSXO/U0jiuB+
         H0SQpgpOEO7hcVofzHm9suMlnuew6otZv0hYAqWmGcY+cAh5xkgo1vqPihVaBV+HqGZl
         HI5KyM9TVt5nmoxskWvmPdzHfuK8MRJHwIpSO1BtbV9A3wpSSa4Z3iSjXu7u4CIX/fNT
         yAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817213; x=1745422013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzD2f0rxQ0+kK+W36kLcNjO+gtstze2fsnlGYTmtJfM=;
        b=k07qRKhju12jZj6HcU0Tjh9S4ZNYFLeDfruMyVF221NU9uha1+mTdKBjchwYBrMXYW
         8DDwUIyqQqH9tgTSZKO172mrjDqmWkV1i/B+4NKiLkqHrQzZ/9cpT0eMGOPd5W7q15w/
         MKgBNrtbEqjF+Xyd3AAoo0YQpkXUC/bUVgOlIAKngOnnygEWwW2L/WN2OEcCQp+vqBTd
         HoV68sB+v5hD1c7CDn+TV89mGj2kN6PGwfcPmV9VlPXRy4E+R9k/qdg1zfxwXgp+9YYO
         Kd2CRXXypaoY+zZG9BygfJNbJWfVVUSspOOR76TUiz27pym2dNH+9rvO8kEo5JgS74TD
         B/8A==
X-Forwarded-Encrypted: i=1; AJvYcCViOrnc22u6S8mWEFVvoshNx8hwkWptxXnCZ+mlUQJhzB8Nw15BvJJqYe0qjaxJndKkmgDQPaGJI65lvRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyli3tsM8lrLvnvutlIKOa66Wu3YXf1OtuFw3FM51jPcKyKKoA5
	MgA5Nt5eZ3UGlFHRlKu1mHWuQAL2FSLqO1swIDzhX5/dsMyNA/chuMhoJCaNOF2GzILoriI9f5Z
	nbPcD8w==
X-Google-Smtp-Source: AGHT+IHeDz4onV1W2s/vfCOCzAITZ8Cgy1MgbHMQ8Bx0jNC7ijt2U2LknXq2pGOSmZDw3fZM7GLT6soOihnk
X-Received: from edsu15.prod.google.com ([2002:aa7:d98f:0:b0:5f4:ade4:88fd])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35c2:b0:5e5:bbd5:676a
 with SMTP id 4fb4d7f45d1cf-5f4b75b2ce3mr1715528a12.22.1744817213096; Wed, 16
 Apr 2025 08:26:53 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:26:41 +0000
In-Reply-To: <20250416152648.2982950-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416152648.2982950-1-qperret@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416152648.2982950-2-qperret@google.com>
Subject: [PATCH v2 1/7] KVM: arm64: Track SVE state in the hypervisor vcpu structure
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Fuad Tabba <tabba@google.com>, 
	Quentin Perret <qperret@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Fuad Tabba <tabba@google.com>

When dealing with a guest with SVE enabled, make sure the host SVE
state is pinned at EL2 S1, and that the hypervisor vCPU state is
correctly initialised (and then unpinned on teardown).

Co-authored-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h  | 12 ++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |  4 ---
 arch/arm64/kvm/hyp/nvhe/pkvm.c     | 47 ++++++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e98cfe7855a6..931011b68819 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -971,20 +971,22 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
 
-#define vcpu_sve_state_size(vcpu) ({					\
+#define sve_state_size_from_vl(sve_max_vl) ({				\
 	size_t __size_ret;						\
-	unsigned int __vcpu_vq;						\
+	unsigned int __vq;						\
 									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+	if (WARN_ON(!sve_vl_valid(sve_max_vl))) {			\
 		__size_ret = 0;						\
 	} else {							\
-		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
-		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
+		__vq = sve_vq_from_vl(sve_max_vl);			\
+		__size_ret = SVE_SIG_REGS_SIZE(__vq);			\
 	}								\
 									\
 	__size_ret;							\
 })
 
+#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
+
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
 				 KVM_GUESTDBG_USE_HW | \
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2c37680d954c..59db9606e6e1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -123,10 +123,6 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
-	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
-	/* Limit guest vector length to the maximum supported by the host.  */
-	hyp_vcpu->vcpu.arch.sve_max_vl	= min(host_vcpu->arch.sve_max_vl, kvm_host_sve_max_vl);
-
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWI | HCR_TWE);
 	hyp_vcpu->vcpu.arch.hcr_el2 |= READ_ONCE(host_vcpu->arch.hcr_el2) &
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 5a335a51deca..338505cb0171 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -372,6 +372,18 @@ static void unpin_host_vcpu(struct kvm_vcpu *host_vcpu)
 		hyp_unpin_shared_mem(host_vcpu, host_vcpu + 1);
 }
 
+static void unpin_host_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
+{
+	void *sve_state;
+
+	if (!vcpu_has_feature(&hyp_vcpu->vcpu, KVM_ARM_VCPU_SVE))
+		return;
+
+	sve_state = kern_hyp_va(hyp_vcpu->vcpu.arch.sve_state);
+	hyp_unpin_shared_mem(sve_state,
+			     sve_state + vcpu_sve_state_size(&hyp_vcpu->vcpu));
+}
+
 static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
 			     unsigned int nr_vcpus)
 {
@@ -384,6 +396,7 @@ static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
 			continue;
 
 		unpin_host_vcpu(hyp_vcpu->host_vcpu);
+		unpin_host_sve_state(hyp_vcpu);
 	}
 }
 
@@ -398,12 +411,40 @@ static void init_pkvm_hyp_vm(struct kvm *host_kvm, struct pkvm_hyp_vm *hyp_vm,
 	pkvm_init_features_from_host(hyp_vm, host_kvm);
 }
 
-static void pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *host_vcpu)
+static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *host_vcpu)
 {
 	struct kvm_vcpu *vcpu = &hyp_vcpu->vcpu;
+	unsigned int sve_max_vl;
+	size_t sve_state_size;
+	void *sve_state;
+	int ret = 0;
 
-	if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
+	if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE)) {
 		vcpu_clear_flag(vcpu, VCPU_SVE_FINALIZED);
+		return 0;
+	}
+
+	/* Limit guest vector length to the maximum supported by the host. */
+	sve_max_vl = min(READ_ONCE(host_vcpu->arch.sve_max_vl), kvm_host_sve_max_vl);
+	sve_state_size = sve_state_size_from_vl(sve_max_vl);
+	sve_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sve_state));
+
+	if (!sve_state || !sve_state_size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = hyp_pin_shared_mem(sve_state, sve_state + sve_state_size);
+	if (ret)
+		goto err;
+
+	vcpu->arch.sve_state = sve_state;
+	vcpu->arch.sve_max_vl = sve_max_vl;
+
+	return 0;
+err:
+	clear_bit(KVM_ARM_VCPU_SVE, vcpu->kvm->arch.vcpu_features);
+	return ret;
 }
 
 static int init_pkvm_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu,
@@ -432,7 +473,7 @@ static int init_pkvm_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu,
 	if (ret)
 		goto done;
 
-	pkvm_vcpu_init_sve(hyp_vcpu, host_vcpu);
+	ret = pkvm_vcpu_init_sve(hyp_vcpu, host_vcpu);
 done:
 	if (ret)
 		unpin_host_vcpu(host_vcpu);
-- 
2.49.0.604.gff1f9ca942-goog


