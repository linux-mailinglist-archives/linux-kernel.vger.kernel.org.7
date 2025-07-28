Return-Path: <linux-kernel+bounces-748451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44CBB14175
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA402169B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52F227602F;
	Mon, 28 Jul 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KaMe3nUj"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9292727F6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725216; cv=none; b=D0G6Ee5S6edHL7223hAFMYYyJFb+kC0gw1p1SSxal3ikMvSsKo0QdCmZj68j7vMjYUPVyX69esGmMSaV0VSga/e6BC3ZgPIEzPtV9AVphg1x1uw5aK5eWmo3wSqg+Lr0oYJkvMbZPs9MEcgKiD0kQADIujUMs/JcSQmidMdRjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725216; c=relaxed/simple;
	bh=hP1ezwqITfAGTxjXJCCUqo8/yzlLtMVaX1yiItE74oY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EvhMgRGug2YsC1W1zMwDGGhUFGpheQyA8R2PQYXigQneFoZrnZHYV5xIHysiuldgbmFop+IoijZPUazNeQcsPDBytJsaX8S7YPCUf0kVNP8h2ExesPY7ctW/4TiJHL8t4CcDUCkNkMALf2wX7azBF38FICfREA0LIWCDZLC8Zfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KaMe3nUj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-456175dba68so28132265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725212; x=1754330012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTlCwgzIOF5QQeq25ycyuKVefVmukIB/XqIN+TFnUGg=;
        b=KaMe3nUjdj9q9xpRUq/bTDk7JK9CuiJpSuBep/PB1076wdt0e7mUKGpN3Sn1DGqZAR
         6HyLFtOQiIvJQ7yxdnAvut5VI+zS2oreVCZqktXy2NvTvVeDdnZA9DV1qDbeRTkQMb9w
         rrGDUnDpA+3m7vOVuAJ6nHMvw9vIfT6l7FeuWGPX6+czJpBaQ2YEYpP4Bu3gA8fJkcT2
         0diCxo4Xmrh6l3Icmdclqa72D0s9osJHNIA9F3K0L7ZCi/SEGLv0TbLA/ye6+agDy7+R
         cGWcXOPpP8gPNQQCmC2nLFzMwJYF21ojyaqKywasnKj4vcJJP4YvL1MSeShvADWA9PsR
         jcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725212; x=1754330012;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LTlCwgzIOF5QQeq25ycyuKVefVmukIB/XqIN+TFnUGg=;
        b=s250pk0XDWHgIA0s8G7WZU+FEMngxaHsJyZpyqDCB16VGHdzdFiC5HIJi5eiI45iyT
         6G5tZdP9zjI1Lu4yI5LD5v2frcHNI/KU+x4zgwhhS79Of5LM7bdHtplgN8PABVovEiUD
         Ss2h6Fk7OxzNXFt7M2vzsfrEP+ehmxFOPyTyFIgHZ1bpY08w1wEVqAkBx9LpIS1WcAfR
         oe2/mVf8is8h4/EfhRumzyHEMNMYj9ZC+mL8AwjKhuWLfmT1d/uG0ntYr1D6bdnxN5oM
         ToPpSnK4fDxk24ZGf5CsV+Rl+f9IS+TMRE4UVgNws/y1Y/yODxyJVreHd4ud+dj7GEAn
         G/KA==
X-Gm-Message-State: AOJu0Yzk/jcdQ81zd7XtAaMmEiFavrEzBDXrv/zDnoTybYc7ZOzMc+Zr
	qxX3IGgrqCK2/1TWBfW0EI8370g1aH1S+ZZKjIQk53D7cUtAB3usxHoo8uf1X6N+Kaeg/0VRWiI
	TR3QjCMfELL/1Wyr26mdMFGhPwLnCQ2F9bybzKdFGW517EpzZlCPyjS1ACJSs4HNOZ+/3mXX7yf
	tOdYldxjREDV5igISE+E3YGQVeD5Kusn26HVYJjFEFHtfAuqd/ZvgWxWc=
X-Google-Smtp-Source: AGHT+IFCITa28zMUxk5yrbhT5rLbfbzrHT5VY8BBjpTdvUFIiWEDdOt68tV9XBv1JfmpoFATXqpljTOFgxfv6g==
X-Received: from wmbhj25.prod.google.com ([2002:a05:600c:5299:b0:456:1824:5884])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8218:b0:456:10a8:ff7 with SMTP id 5b1f17b1804b1-4587655b79cmr98218285e9.28.1753725212532;
 Mon, 28 Jul 2025 10:53:32 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:49 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-3-smostafa@google.com>
Subject: [PATCH v3 02/29] KVM: arm64: Donate MMIO to the hypervisor
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a function to donate MMIO to the hypervisor so IOMMU hypervisor
drivers can use that to protect the MMIO of IOMMU.
The initial attempt to implement this was to have a new flag to
"___pkvm_host_donate_hyp" to accept MMIO. However that had many problems,
it was quite intrusive for host/hyp to check/set page state to make it
aware of MMIO and to encode the state in the page table in that case.
Which is called in paths that can be sensitive to performance (FFA, VMs..)

As donating MMIO is very rare, and we don=E2=80=99t need to encode the full=
 state,
it=E2=80=99s reasonable to have a separate function to do this.
It will init the host s2 page table with an invalid leaf with the owner ID
to prevent the host from mapping the page on faults.

Also, prevent kvm_pgtable_stage2_unmap() from removing owner ID from
stage-2 PTEs, as this can be triggered from recycle logic under memory
pressure. There is no code relying on this, as all ownership changes is
done via kvm_pgtable_stage2_set_owner()

For error path in IOMMU drivers, add a function to donate MMIO back
from hyp to host.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 64 +++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c                  |  9 +--
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm=
/hyp/include/nvhe/mem_protect.h
index 52d7ee91e18c..98e173da0f9b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -37,6 +37,8 @@ int __pkvm_host_share_hyp(u64 pfn);
 int __pkvm_host_unshare_hyp(u64 pfn);
 int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
 int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot p=
rot);
+int __pkvm_host_donate_hyp_mmio(u64 pfn);
+int __pkvm_hyp_donate_host_mmio(u64 pfn);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvh=
e/mem_protect.c
index 861e448183fd..c9a15ef6b18d 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -799,6 +799,70 @@ int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enu=
m kvm_pgtable_prot prot)
 	return ret;
 }
=20
+int __pkvm_host_donate_hyp_mmio(u64 pfn)
+{
+	u64 phys =3D hyp_pfn_to_phys(pfn);
+	void *virt =3D __hyp_va(phys);
+	int ret;
+	kvm_pte_t pte;
+
+	host_lock_component();
+	hyp_lock_component();
+
+	ret =3D kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, NULL);
+	if (ret)
+		goto unlock;
+
+	if (pte && !kvm_pte_valid(pte)) {
+		ret =3D -EPERM;
+		goto unlock;
+	}
+
+	ret =3D kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, NULL);
+	if (ret)
+		goto unlock;
+	if (pte) {
+		ret =3D -EBUSY;
+		goto unlock;
+	}
+
+	ret =3D pkvm_create_mappings_locked(virt, virt + PAGE_SIZE, PAGE_HYP_DEVI=
CE);
+	if (ret)
+		goto unlock;
+	/*
+	 * We set HYP as the owner of the MMIO pages in the host stage-2, for:
+	 * - host aborts: host_stage2_adjust_range() would fail for invalid non z=
ero PTEs.
+	 * - recycle under memory pressure: host_stage2_unmap_dev_all() would cal=
l
+	 *   kvm_pgtable_stage2_unmap() which will not clear non zero invalid pte=
s (counted).
+	 * - other MMIO donation: Would fail as we check that the PTE is valid or=
 empty.
+	 */
+	WARN_ON(host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt, phys=
,
+				PAGE_SIZE, &host_s2_pool, PKVM_ID_HYP));
+unlock:
+	hyp_unlock_component();
+	host_unlock_component();
+
+	return ret;
+}
+
+int __pkvm_hyp_donate_host_mmio(u64 pfn)
+{
+	u64 phys =3D hyp_pfn_to_phys(pfn);
+	u64 virt =3D (u64)__hyp_va(phys);
+	size_t size =3D PAGE_SIZE;
+
+	host_lock_component();
+	hyp_lock_component();
+
+	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) !=3D size);
+	WARN_ON(host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt, phys=
,
+				PAGE_SIZE, &host_s2_pool, PKVM_ID_HOST));
+	hyp_unlock_component();
+	host_unlock_component();
+
+	return 0;
+}
+
 int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 {
 	return ___pkvm_host_donate_hyp(pfn, nr_pages, PAGE_HYP);
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c351b4abd5db..ba06b0c21d5a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1095,13 +1095,8 @@ static int stage2_unmap_walker(const struct kvm_pgta=
ble_visit_ctx *ctx,
 	kvm_pte_t *childp =3D NULL;
 	bool need_flush =3D false;
=20
-	if (!kvm_pte_valid(ctx->old)) {
-		if (stage2_pte_is_counted(ctx->old)) {
-			kvm_clear_pte(ctx->ptep);
-			mm_ops->put_page(ctx->ptep);
-		}
-		return 0;
-	}
+	if (!kvm_pte_valid(ctx->old))
+		return stage2_pte_is_counted(ctx->old) ? -EPERM : 0;
=20
 	if (kvm_pte_table(ctx->old, ctx->level)) {
 		childp =3D kvm_pte_follow(ctx->old, mm_ops);
--=20
2.50.1.552.g942d659e1b-goog


