Return-Path: <linux-kernel+bounces-824907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6A1B8A71D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC643B50E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414B31D738;
	Fri, 19 Sep 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8GYnsw5"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAB270553
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297339; cv=none; b=u1vWql2afX05QMjE/f32Z/0LRpFdwV2JFw4YQndWAGPiRtja78T2Sb5brjOiYSaZ/lVCZTEJ+RxmbabhoPHWAS3u+LWnA908ufj8ae+RjEd+fafTF8GjAeA8hnbVYlaVFPPXoFt92rn7jkPYEVA5sdscZLvdbtAf6urZzhq+q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297339; c=relaxed/simple;
	bh=q+ltlpOidKXc+Gs5FbxaUoBvp/0NlBvUil7jiGSbDrA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vCfSLtWzZaM5kQ/e2zBmOgMzQ4dUnBrRXE9SNnS3y2Nb1vcLJmmpk5/gbP3YQQhs/fAcJd6zeZ1yTSUCOgWNT1kudL8EwBK0jxxzzbPRBInfWjIEZl0wsku9EnRFm7xPdt7eQRdWehUGbXhbF6fss4Tmq4GwdHiykNAMj2sWN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8GYnsw5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso12218015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758297336; x=1758902136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FOKSGqynaN2anerij2SkIETe5RaqqxOUKLRkUOiDZeU=;
        b=X8GYnsw5uJlDKS7gXwNHlXmCVLIWTlyCAiXzLGNZmislSeNLJ3rErQcn7cREeAfBpB
         1AbX2XY94BunKVodmHqtpLmt2XnYXSeuZoO8zOXoHbkii3vU/UJVkN3gSx3We0A5QE/8
         tiUC8Zpf0cgek/pDvC8ug6EpLc6x3Hfq3Feh+rAHclQHO+X5pXnth5kXuQY84EyRcibQ
         pF6jhJ5HTleodtuDTCS/xepn4RLCIzwwM4os7v+LRxWNY8t/WO8ciE6UyAd5H83s2YiM
         av/W5Q1MhGOtuCAnRRwt8XB+wZ0GCHxr2/IzjoZGSoOlxrj5PxyGTS2hvYt6MtptdFsj
         dJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297336; x=1758902136;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOKSGqynaN2anerij2SkIETe5RaqqxOUKLRkUOiDZeU=;
        b=TTH0lyshEcn2RlSZDcTjWDdlmj75+thECtQNS2OM3bMtanuKUNTm0N3q/a6Zv3ENk6
         eUbSzpAiSZ/FRzOv/IgL0QkycwaFXeDCujJnhhUUOJKRiIZkMAL47hhpYkwHiWQa+DmP
         nYgw19czQSkphumFOdvs+wKR85tboWYpoxK25oHr3T56fm8c9AjpdBPdDIMnlM76QyoH
         m96ltbP+GGAT6osMpdAWdzsg24R4Fv+DTvIr7YpzOdNimhkYKW9243/H0VQ+Ob/9y0L6
         GSwrQ6rCKPQ/hjmv8DEfFdFYCohuPgdUreLcvM/WIz0bbYJVxpLCUFVYVw5nhRVolceX
         LN0w==
X-Forwarded-Encrypted: i=1; AJvYcCWRoBxz/nBkySe1+Ws8t8SKAOfWqPpSB8pCNgvEVflp+pHudLK8NtxF181MOij0PysnGPF08SKU/141iRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnV710rbcP5ObWsYRBm8Rzr0jcAbmeTl8Gy8WJvCzireoGITn
	xDqfgmBGx37d5HqIQz+X817NZaQz5wKwpObxFF5eMCdNctaJDL2DbCiukXEqhCEQcCpiGE2Lub/
	UjQpUP84VfeMJDELttTDEmg==
X-Google-Smtp-Source: AGHT+IEUFCbcLzkaHmj5mVgMPnutmJZ9S4AToUJFiYuLUhCLRphe53uMI81/4ePc9pYVhpGPJ8joXqow1Xo/ILf8
X-Received: from wmbei25.prod.google.com ([2002:a05:600c:3f19:b0:45b:6337:ab6b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4748:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-467f2242a87mr36001815e9.23.1758297336691;
 Fri, 19 Sep 2025 08:55:36 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:50:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919155056.2648137-1-vdonnefort@google.com>
Subject: [PATCH v2] KVM: arm64: Check range args for pKVM mem transitions
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, sebastianene@google.com, keirf@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

There's currently no verification for host issued ranges in most of the
pKVM memory transitions. The subsequent end boundary might therefore be
subject to overflow and could evade the later checks.

Close this loophole with an additional check_range_args() check on a per
public function basis.

host_unshare_guest transition is already protected via
__check_host_shared_guest(), while assert_host_shared_guest() callers
are already ignoring host checks.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

---

 v1 -> v2:
   - Also check for (nr_pages * PAGE_SIZE) overflow. (Quentin)
   - Rename to check_range_args().

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 8957734d6183..65fcd2148f59 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -712,6 +712,14 @@ static int __guest_check_page_state_range(struct pkvm_hyp_vm *vm, u64 addr,
 	return check_page_state_range(&vm->pgt, addr, size, &d);
 }
 
+static bool check_range_args(u64 start, u64 nr_pages, u64 *size)
+{
+	if (check_mul_overflow(nr_pages, PAGE_SIZE, size))
+		return false;
+
+	return start < (start + *size);
+}
+
 int __pkvm_host_share_hyp(u64 pfn)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
@@ -772,10 +780,13 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-	u64 size = PAGE_SIZE * nr_pages;
 	void *virt = __hyp_va(phys);
+	u64 size;
 	int ret;
 
+	if (!check_range_args(phys, nr_pages, &size))
+		return -EINVAL;
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -800,10 +811,13 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-	u64 size = PAGE_SIZE * nr_pages;
 	u64 virt = (u64)__hyp_va(phys);
+	u64 size;
 	int ret;
 
+	if (!check_range_args(phys, nr_pages, &size))
+		return -EINVAL;
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -884,9 +898,12 @@ void hyp_unpin_shared_mem(void *from, void *to)
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-	u64 size = PAGE_SIZE * nr_pages;
+	u64 size;
 	int ret;
 
+	if (!check_range_args(phys, nr_pages, &size))
+		return -EINVAL;
+
 	host_lock_component();
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (!ret)
@@ -899,9 +916,12 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-	u64 size = PAGE_SIZE * nr_pages;
+	u64 size;
 	int ret;
 
+	if (!check_range_args(phys, nr_pages, &size))
+		return -EINVAL;
+
 	host_lock_component();
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (!ret)
@@ -945,6 +965,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 	if (prot & ~KVM_PGTABLE_PROT_RWX)
 		return -EINVAL;
 
+	if (!check_range_args(phys, nr_pages, &size))
+		return -EINVAL;
+
 	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
 	if (ret)
 		return ret;

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
-- 
2.51.0.470.ga7dc726c21-goog


