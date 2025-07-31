Return-Path: <linux-kernel+bounces-752613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E4B17800
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258D27B1A49
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2D26A1D9;
	Thu, 31 Jul 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwA0u8Bv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC609263F38
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996812; cv=none; b=X8bBtYj2FbwmyonN9+gAJdlrr2EL6Jx81nIyVwe671W5WjhuI6wV543I8arJGsodUKPooe9r4XLzwpiVa9LrRMJ5i5GM77y/XvZKbWvtKjKoXZpTWUGmKK7DWbfAfy8ndLoYxMgWsV4svEVETkCKt+Qfo2G3zD6XqOFg1zCsbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996812; c=relaxed/simple;
	bh=fEO5flYiBAmmrUTW30Vl0BFDykqnaU/ipG51NplHMZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DrTuSKoUe7crkWot0O8OyjiODNkBBvjupuU67D4bEwqz8PW+TfRkFkwvsIBnZlksDyuIJkN5wHAPpi1EkoonC1avB4NftePzVQSman2iCHyIw2vqJ/pumyRMFzDmbpu2fmPI8e5Eolx9K7sU+2efT7zJPN86Z5a7OYEOY0Ifytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwA0u8Bv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31edd69d754so182158a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753996809; x=1754601609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qNS6IJrJZV1lITbvwt6t07h5m493TGqR/NU0h0LQEg=;
        b=IwA0u8Bv2BjRha8fTY+anX5K4JH08WQ2p++FJm0pKA9+0vBEt6yuh5aqO9HvxgBwwD
         OlLvOM2vqI448fWe0gMoGzlRR2moGhxMdvLU7kBqrGTbqlHmbTB6vdi17wGXjAsA7XUK
         ZF7OVIyZRE/LkGRbWzUHVc/2f2EIWgZlTjsVQXGbz88r8Mr1Ewa6Yh71e0bOB00NAAfV
         Wvz8KqCM/ufuupGYQ5pHnY9Y+NUp2spzMSRJXUJ0ZOGtkFufT173/hfUsKT7co9+ye4R
         CSN7vkY0LpBPM/HpuTF1KvSDACfT3lOZmDwP5UrO7hKWq2SOwwdDF5ZZ4LZOaztbTgUn
         W1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996809; x=1754601609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qNS6IJrJZV1lITbvwt6t07h5m493TGqR/NU0h0LQEg=;
        b=W8MfdMrBwZOFqu75/p5yHVdyvDCZ853nnp3hDwsb0/FSQNzZVkmDxiTsOQ/c/epjDz
         sQlFQZfBJGshGSn06AaR7wYsNxzhdjfLQ1PScF84D59go94uN1/qCb0ivxieY4RmnIum
         3xGFalqYbJ29n9TG6xhZw5MD3O53lv8DH0LoTv0Qy4MSxUTeE1A5fbmM5g1Zojenp198
         4ge3nReZNBiXg2Z1tYlkQktNZ1ME7qHggpikpyu5EWNdoJB4Od7Rr7jbTM8VkHz4Ihx6
         hXRbNgQAvL2l/Ov5kFQ3W6SuoN/ZQlJWpxg+RWr+GJf4Vsl4717Hxv4zkJz+HdJSE6gs
         IsZA==
X-Forwarded-Encrypted: i=1; AJvYcCX4X7iclZ6p2nFcyCZWeNWNY+6hvYZdq8euqAJQt+I+uJE43DVBBQteDduAtyHlx8ooVcVvhlGrS6U8wXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEu/GNFEU0cpYhBd05UjYjK+xVKBlKB43P6L8Jns5p7WmF9e6
	VRhwcy31mkKOpxoiiASpPS0NC6WQQjBE4333VwqhGhqeyuslQzP1r7zRL7VVSvHWdbdDKuz/7lP
	zCiwsFbZhKifvrA==
X-Google-Smtp-Source: AGHT+IGi3W8REoNKT4VRn0WWKc9QG1YF4F8owx+E1JqaZjpyHJlhcdTCOBswIo9sfFOEAW14j8Fh6YM2HTafvw==
X-Received: from pjpo9.prod.google.com ([2002:a17:90a:9f89:b0:31e:d618:a29c])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d8f:b0:311:a314:c2d1 with SMTP id 98e67ed59e1d1-31f5dd6fd1bmr12129421a91.6.1753996809220;
 Thu, 31 Jul 2025 14:20:09 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:20:01 +0000
In-Reply-To: <20250731212004.1437336-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731212004.1437336-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731212004.1437336-2-jiaqiyan@google.com>
Subject: [PATCH v1 1/4] KVM: arm64: Allow userspace to inject external
 instruction abort
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rananta@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Raghavendra Rao Ananta <rananta@google.com>

When guest causes synchronous instruction external abort, VMM may
need to inject instruction abort to guest. However, KVM_SET_VCPU_EVENTS
currently only allows injecting external data aborts.

Extend the KVM_SET_VCPU_EVENTS ioctl to allow userspace injecting
instruction abort into the guest.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/uapi/asm/kvm.h |  3 ++-
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/guest.c            | 15 ++++++++++-----
 include/uapi/linux/kvm.h          |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ed5f3892674c7..643e8c4825451 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -184,8 +184,9 @@ struct kvm_vcpu_events {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
+		__u8 ext_iabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[5];
+		__u8 pad[4];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7a1a8210ff918..3d86d0ae7898b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -315,6 +315,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_IRQ_LINE_LAYOUT_2:
 	case KVM_CAP_ARM_NISV_TO_USER:
 	case KVM_CAP_ARM_INJECT_EXT_DABT:
+	case KVM_CAP_ARM_INJECT_EXT_IABT:
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 16ba5e9ac86c3..d3c7b5015f20e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -826,9 +826,9 @@ int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 		events->exception.serror_esr = vcpu_get_vsesr(vcpu);
 
 	/*
-	 * We never return a pending ext_dabt here because we deliver it to
-	 * the virtual CPU directly when setting the event and it's no longer
-	 * 'pending' at this point.
+	 * We never return a pending ext_dabt or ext_iabt here because we
+	 * deliver it to the virtual CPU directly when setting the event
+	 * and it's no longer 'pending' at this point.
 	 */
 
 	return 0;
@@ -853,16 +853,21 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 	bool serror_pending = events->exception.serror_pending;
 	bool has_esr = events->exception.serror_has_esr;
 	bool ext_dabt_pending = events->exception.ext_dabt_pending;
+	bool ext_iabt_pending = events->exception.ext_iabt_pending;
 	u64 esr = events->exception.serror_esr;
 	int ret = 0;
 
+	/* DABT and IABT cannot happen at the same time. */
+	if (ext_dabt_pending && ext_iabt_pending)
+		return -EINVAL;
 	/*
 	 * Immediately commit the pending SEA to the vCPU's architectural
 	 * state which is necessary since we do not return a pending SEA
 	 * to userspace via KVM_GET_VCPU_EVENTS.
 	 */
-	if (ext_dabt_pending) {
-		ret = kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+	if (ext_dabt_pending || ext_iabt_pending) {
+		ret = kvm_inject_sea(vcpu, ext_iabt_pending,
+				     kvm_vcpu_get_hfar(vcpu));
 		commit_pending_events(vcpu);
 	}
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e4e566ff348b0..a7b047f95887c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -957,6 +957,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
+#define KVM_CAP_ARM_INJECT_EXT_IABT 245
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1.565.gc32cd1483b-goog


