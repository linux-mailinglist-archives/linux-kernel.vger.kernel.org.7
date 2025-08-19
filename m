Return-Path: <linux-kernel+bounces-776540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8AB2CEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD7B1C26D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151083451C8;
	Tue, 19 Aug 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdU005YG"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110031194A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640347; cv=none; b=XFB3Xx+dw7Yx6TAzf1Y6/1VbFHTs0rf+CaplSVJJGc6zpVNiZIk6wyEOnPCfedF6/khhA3e03YDk39Qu7lGA4z36fvQ3m1k85bZNpw/BtlzvpwrfGBu3ahujr/uwpKYROcU7KQaEpjg6k4v/kYH9HTeNDUn0noPoYiEAVfkSiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640347; c=relaxed/simple;
	bh=1DQlyjp3Ypyw67ZtM4RckxS+tfIALxj62mzUclwfeTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dMYYK+l8z+UaG3SQILD6Kha3Ct9cbaM3320q2Z8GpyvT0w2Q5BfdAqBaAtZel/IRPP1ix5Ws2yV+lLnew/6aC7/mVGNIgx6a+01n7wJ/0ZpL5pmN8D4qI8fXv9X5kk08AIq0oUZyzmVDFuvJTcdM1HDNNaMQqorsNh+qEJj+2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdU005YG; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9e4146aa2so3250074f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640344; x=1756245144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioxZ9+DNy86koGENgFZw7NoVqbAVt0aWywoB+DgYjJQ=;
        b=jdU005YGA9PDzDLNZCOWr7PRvYKlVSlmUsEoIVQgZMRtwIM9Ku9beF3Nti8u14C5a9
         w58FznsppJT9vP3FRupRcuU2F/Hu+QHwZeZDbRM7GFI4B1kvHktCOU1fic5EhBOd26+o
         sotNmJODGgTkWZrKpC8lz2+Jd1Dc51GMxrKTIGH4bgilcLxq5Uq3LJ387CApwt8XxO3q
         TY3NlMuLLrHoP8E1P18LFyCK6tZ2aevlPrYK1WE/A16VWaIfIRiLNXtC39qNkrb1ibz2
         F2XAuhfMsdobklh9MEEMcTp5M98z5y8ZcITn2j68Oa1E2bC/BtIy0UaBs5jliZyhVwms
         m86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640344; x=1756245144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioxZ9+DNy86koGENgFZw7NoVqbAVt0aWywoB+DgYjJQ=;
        b=JeT3s+ZvOiYziHMGcJqA6gKw6+Th08VmLzBNLMNQMyLgvr9EU71tYH/vHZSw6bgnRX
         Q7pB3Q5e+q8DCIwBGA8zCcEkRDwkOsGqWY/pg60OeDud2IreyQ6JVkvnEkmniajTRCfk
         pLPZwt5UPM5pCSLu8jSL+9M3VTteEyZLRIAsxVq4J8c9CmF8JfqinXR11gIqrH7aaC4E
         DIK6CkBnKo5r12MriP1awbMsbHyGzIiUVXv8DXxK5aPKNipE2lUDbS/J/Rdp2OFy9FMv
         qp7PQ7FBJGqWBqJznydHtyq1etB4bcFmUrORHFJveePbCUlFCddc9Ydd/p/lVJW9e1TR
         QA2w==
X-Gm-Message-State: AOJu0YymvtcDTVwdyn0VyLQHTRItkuqAz5CGwkEWrDej5hX/ZJtm4nIm
	jrJ8YVqyZViBCjAzsmiNxQKU53uRtnfSsPd7TJdDfTQ7q8W/r/YaK19T6MmN8GuM288SYVvoIY1
	mupd2Sid18PSHoRcVHEw5JWcIixgQQHbQj6rUU/YTY9JrOAGnG4pRlFp1YPG8pJGaYXjDwnVvMz
	xUuA3t8+ZOZuAgCklOKaa0lX6OplB1GZEscSPl2JqdlsyGhgA0oTgofxw=
X-Google-Smtp-Source: AGHT+IEHXpWg/f+rEUO60O9qrX4vZsfY84WtfBBV4+NcwjtcLonZ2Ky7JZEiBzijF5XkyOmNGYqUgyc+J4F+Sw==
X-Received: from wmbfa5.prod.google.com ([2002:a05:600c:5185:b0:45a:2855:e836])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:438a:b0:3b7:b3f2:f8c3 with SMTP id ffacd0b85a97d-3c32ecce5bfmr288271f8f.57.1755640344145;
 Tue, 19 Aug 2025 14:52:24 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:29 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-2-smostafa@google.com>
Subject: [PATCH v4 01/28] KVM: arm64: Add a new function to donate memory with prot
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
2.51.0.rc1.167.g924127e9c0-goog


