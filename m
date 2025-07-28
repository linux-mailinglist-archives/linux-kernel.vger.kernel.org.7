Return-Path: <linux-kernel+bounces-748452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C01B14174
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC83E3B4F20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38827780C;
	Mon, 28 Jul 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hMVvXTu"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97B275B0A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725217; cv=none; b=gzwwuOVb8nY/IT85Yh6eUfcDp8p/nN0l1jXrmFjg9w/7kj5EB0wDPw/qsuGDaDWQOj7ylG5O7S3HZPu6mMKB4X36pRdhAS5yqSNYJNnfllUpENqMHUDI5gsHOVBJzQM723U5V0En+9yTNj63HA6Tm8NHWqzPv+qTwuAnqBg+f/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725217; c=relaxed/simple;
	bh=nRn9Dsf3QfyBnEBl4Hr7BBBiduTa1EIYJ+DzHW4mP0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NPSClTe/KY9V1iJZLYzkDdiLcZq7ilxqYMk005EkyNTJ7teWNjPgeTc9FgmqwqCM7GhzjY3r+/AbQ7TAmz/Bda9wltarvjo/uyj7VQKySWahevEB86LrDYT6R/lb4ZVc4IYQ6bST/OT0BayrC+i/HLaHDQPXyYjwl5NbbuiygSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hMVvXTu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b785aee904so902993f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725214; x=1754330014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBRRf2ok05qV4V10RyprFxOV/7isNWPsP0/960vxN5o=;
        b=2hMVvXTuAG1x5j6qktF+zVhxIYT7edX8WOGYNCTS18FCz09r4LDaXJS7f7sPdA5e30
         joNzWN4EBcGzvK//DWKy+68qPn1tyqI7/4gZnDobEKRUWpEwJNmPnnypnCFaAtSRRdLX
         6aXefiUmxy+ZOmWftb9hMkTcWk8tR2I0VVkHYSpKR9ohcn2CBXVou7eAy6IUqT1taPO7
         rCdtzZ/U+iiHlC6zvEPMYFVFXbfsozJqGP1Cvz7xjsIeK1nUKoKqT+W/OgkC2nht+U4P
         sO4rnm93CJgyYXqs09LU0yBi+VsLpa4WyGKaqmTYkGygxAJFwDcbMiOM0siBVIrjsJqQ
         SK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725214; x=1754330014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBRRf2ok05qV4V10RyprFxOV/7isNWPsP0/960vxN5o=;
        b=rf7rYZ4TSN//EPQ/cLVJaxGGG03DoOQmlMnDg5UTMNcUZ/EctDrahcNOL69KGVps1c
         h0NLprz8quPGU5kq4Uc4+Adai6FT7PLbGo7ZvdAreLetX/H7I1L1Fz+mC+LgNyqoc6VS
         7FCcfmdJEG7/NlhzhmljiAGD9mcch54udvAVT2iiYqFV0UyXfx1+LbBoC1Sem0kPcAa0
         AJ2aYfOV1Scyb3Bwn7R53TmSz4BXeRkS3T9gS3vpMzWG2HWUr6Snhd8PVe7zUwkm9Rpa
         ePwiAGvP7VXeqAo3vg7+uEpugwTARPwjVJPqiHUq4DSy5MNxZhfmxk2jUlmgRmiGvdBv
         FB/g==
X-Gm-Message-State: AOJu0YwiUd7Nk5hxyRTKhJN7gv3idXoG2RnI1R4V08T3Y6WpVl3sRnOj
	aH+T/2H35uIXiWS9oU2eqmCucf5jE+S/kenjg6cLFlgxQvtnvq3jkrL5xkUGM5Xg9KZRokRgu8D
	o2lR33/qrEaJ34IigL9Vym/tBwoWRJjUkDarbKz9vDDlPd3H0daAnU9hpv6o0pxl90VXWS2fazf
	VRMkjfEhk6mBnQ2yogwTv0XrqwJPdtH8TyzAUXYM6tPp522T1S6ASbBTc=
X-Google-Smtp-Source: AGHT+IEdo5UmQraGXTZJ9gCaHcWtxJIv/tFc5vNP8HwnzGiRANkg0buplE/XnYHC6sojxb0f1IZVCz/ntN1JZg==
X-Received: from wmbji2.prod.google.com ([2002:a05:600c:a342:b0:456:214c:845d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:290d:b0:3b5:f93a:bcc with SMTP id ffacd0b85a97d-3b77675be5amr9578336f8f.35.1753725213520;
 Mon, 28 Jul 2025 10:53:33 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:50 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-4-smostafa@google.com>
Subject: [PATCH v3 03/29] KVM: arm64: pkvm: Add pkvm_time_get()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a function to return time in us.

This can be used from IOMMU drivers while waiting for conditions as
for SMMUv3 TLB invalidation waiting for sync.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  2 ++
 arch/arm64/kvm/hyp/nvhe/setup.c        |  4 ++++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c     | 33 ++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index ce31d3b73603..6c19691720cd 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -87,4 +87,6 @@ bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code);
 void kvm_init_pvm_id_regs(struct kvm_vcpu *vcpu);
 int kvm_check_pvm_sysreg_table(void);
 
+int pkvm_timer_init(void);
+u64 pkvm_time_get(void);
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index a48d3f5a5afb..ee6435473204 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -304,6 +304,10 @@ void __noreturn __pkvm_init_finalise(void)
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
+	ret = pkvm_timer_init();
+	if (ret)
+		goto out;
+
 	ret = fix_host_ownership();
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
index ff176f4ce7de..e166cd5a56b8 100644
--- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -11,6 +11,10 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+#include <nvhe/pkvm.h>
+
+static u32 timer_freq;
+
 void __kvm_timer_set_cntvoff(u64 cntvoff)
 {
 	write_sysreg(cntvoff, cntvoff_el2);
@@ -68,3 +72,32 @@ void __timer_enable_traps(struct kvm_vcpu *vcpu)
 
 	sysreg_clear_set(cnthctl_el2, clr, set);
 }
+
+static u64 pkvm_ticks_get(void)
+{
+	return __arch_counter_get_cntvct();
+}
+
+#define SEC_TO_US 1000000
+
+int pkvm_timer_init(void)
+{
+	timer_freq = read_sysreg(cntfrq_el0);
+	/*
+	 * TODO: The highest privileged level is supposed to initialize this
+	 * register. But on some systems (which?), this information is only
+	 * contained in the device-tree, so we'll need to find it out some other
+	 * way.
+	 */
+	if (!timer_freq || timer_freq < SEC_TO_US)
+		return -ENODEV;
+	return 0;
+}
+
+#define pkvm_time_ticks_to_us(ticks) ((u64)(ticks) * SEC_TO_US / timer_freq)
+
+/* Return time in us. */
+u64 pkvm_time_get(void)
+{
+	return pkvm_time_ticks_to_us(pkvm_ticks_get());
+}
-- 
2.50.1.552.g942d659e1b-goog


