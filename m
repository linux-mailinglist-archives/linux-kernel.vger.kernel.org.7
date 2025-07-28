Return-Path: <linux-kernel+bounces-748450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AAEB14173
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A73E7AE746
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A516275845;
	Mon, 28 Jul 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwbsQBI1"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DB2701BD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725214; cv=none; b=QI6ADyTO4rcjxWu0/xz7ckwz3l+NAcZVZgg8482b3OJA14cnYzzPD3a4OlVvjPBJRxRH3Kurc9O7f1CwhpWbnD+NCqCNvJE5l/W/bivS7xVJEmZBc9qWihIfBwgX6dqsvuMxu5tNIXKfXRbRM/4yIr+RcfPZsjiSHX47MBQe8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725214; c=relaxed/simple;
	bh=J1SjK0vWeBplkdbTTJcUjjcnej2Z63ZcY6P/gYDg268=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lTCsUQLC6V/QKmdKU+KIIWG/ju7GA2Xc/J3v1KqdweUxoZI/OTnKpf0Dq1AWdCXz5XEm0U4E86aGkm/j6KhafF0l091jH0Vx9MXcU3OFF7fxLSgCWDRLF+8LJzvyc6lxENt4yZ3/J96d8QL21mDhznOn6+VZvO8eCiHhOa12dNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwbsQBI1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4538f375e86so36587105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725212; x=1754330012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeRx7vP/138KQFxr0SX14a6MVSvUsa68vsZQFRiGNJw=;
        b=vwbsQBI1wTLJl88mvM4eAFukYWnyT/ci/OJuNqHc+t7kiYgxkC/1GCbvLc4Rb0Oig9
         2oXHfvJjnBFB8m/pETenqHVmGHVaGl9go8a6HYpxOPHs853chFbEVYZnAf88I6kOOVpk
         YMJnCvEXwfc/FKjNMg7QXgUEchR7WOGkKTyHbuX4l/ao01SIGYwakP9Sh2TjSQv2JMTM
         Np26U6OWkYnokyiM6b8V/q3GBBAZSR/IsjSsgY5L+GGfJxaWiY+lI6SgtkNRYY5jVV6Q
         8tY8amms/Ne9HO1q0Tq7cWMyGQ2S463taFuv2CdhuYDuYj10OUWzpN0KE+8ES0o2k04V
         BVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725212; x=1754330012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeRx7vP/138KQFxr0SX14a6MVSvUsa68vsZQFRiGNJw=;
        b=FQ6qYYbsYVllGCeUGZOFu672kcBW+w9oKXqJ/ohoqKa2ykHUtRAKtMKIHQ2YodQcjQ
         nJ/ub8n4OV9faL4QpcdSBvPHu1tIPnAnEqA5GIig/ry+1OXChcgJNL4p33sfuV57qiZa
         rjPqI1C8f86kPmlKX5W1eVZsFyWkXdv4x/uyFgGeYtNHB14llwP23VchAvDU9Yx5YWZZ
         MKmYZLGbUTN4wOmsIMuRA+f2OPzC4HpYpaOHD0IkbGutOPyREP5L+sgWbY+9vWlgKtvY
         OmgRL3ylif2Gtn7DQ3M4WgPE6Yeo7v5kat29EDw/BZRWfSpRK6Y8twcqy8bUIXKTPKuD
         fc5A==
X-Gm-Message-State: AOJu0YxITXcKC6wMNLcHzBi38kR+QoSYssfT+IV/me+P/jVlskGP7ULk
	VeVh2HxqSm/2IPVmArRyEd91MW7Y0gQc1bfbcyjKwimbw9JuxAOw03e196ljOYW93iihMoVGf8g
	hFbwhVF0Q5M8JHff9NW7mUtfW+T20HkwNcXO6hP81P8JmJKvRaSAk5qp8W+Cy0RM0au3+K3SkcM
	yCx8aEfPQ834R2r7SblrVSsRnt8FXg2we38YrBXobbcQU1UpEUzV+TM8k=
X-Google-Smtp-Source: AGHT+IE1QKRH8xd41th/Qwnod5XKPsVgVqg7Mv68PdXhnIKZKddzbjKbt+QRa+9zTDVfDxi6tBL2YQdZsrDI2Q==
X-Received: from wmsp14.prod.google.com ([2002:a05:600c:1d8e:b0:456:c7c:3165])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138c:b0:456:58e:318e with SMTP id 5b1f17b1804b1-458852534ecmr52353185e9.30.1753725211674;
 Mon, 28 Jul 2025 10:53:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:48 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-2-smostafa@google.com>
Subject: [PATCH v3 01/29] KVM: arm64: Add a new function to donate memory with prot
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Soon, IOMMU drivers running in the hypervisor might interact with
non-coherent devices, so it needs a mechanism to map memory as
non cacheable.
Add ___pkvm_host_donate_hyp() which accepts a new argument for prot,
so the driver can add KVM_PGTABLE_PROT_NORMAL_NC.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 5f9d56754e39..52d7ee91e18c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -36,6 +36,7 @@ int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
 int __pkvm_host_unshare_hyp(u64 pfn);
 int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
+int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 8957734d6183..861e448183fd 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -769,13 +769,15 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 	return ret;
 }
 
-int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
+int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
 	u64 size = PAGE_SIZE * nr_pages;
 	void *virt = __hyp_va(phys);
 	int ret;
 
+	WARN_ON(prot & KVM_PGTABLE_PROT_X);
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -787,7 +789,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 		goto unlock;
 
 	__hyp_set_page_state_range(phys, size, PKVM_PAGE_OWNED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
+	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
 	WARN_ON(host_stage2_set_owner_locked(phys, size, PKVM_ID_HYP));
 
 unlock:
@@ -797,6 +799,11 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	return ret;
 }
 
+int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
+{
+	return ___pkvm_host_donate_hyp(pfn, nr_pages, PAGE_HYP);
+}
+
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-- 
2.50.1.552.g942d659e1b-goog


