Return-Path: <linux-kernel+bounces-776541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76FB2CEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F82A6794
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE13469FD;
	Tue, 19 Aug 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byvFxikl"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76731AF26
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640348; cv=none; b=sI3wP9OImOf6toVZWpX6fyH1NZevD8N+9IrsMguEE+9a2ZHqggsNvEDx6OLqhSyPdkHWty7JVyLA1nR6Q4tg0xXakWVQd0Msk3quLferJbYRAovCoe77Oxj2W7BzA4qcqeFrkE7bIiIgjPBk0WJ/OIcf3exErgIa4cK8AwGrO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640348; c=relaxed/simple;
	bh=BD3OB//GZsI6wyE5tIICFFT0lSi+PCLS/mLJZoc5JA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRp7ZMPX9yxV9RnM0yiZugGA/42AEzxBxNGVo9WnIZPsBGNhvnk9yKBDQk1vUfOXn76gzPiNGYiKzdZZDeOitVZ9IWnV7/7opCHAn3UtbbElIAOMJGFOOY60GTZUuxCm5resd0N01LO86kEaMV7kw8a2cRPjuZs/OkhKn0y2eN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byvFxikl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso24417035e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640345; x=1756245145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVz3Y9VpnYE4PVj2+x4ppZYRh/7u9Tfs4/CSD5zsJnw=;
        b=byvFxikl7obK3H6zXDdaCSQX4hZYNsPQzRY2X9OAHET7S58sM9wW3/WCLbHaej3wd3
         ksZSDjVTZPSl2mwKrK+kNJQv7MFzx2dPi3/C4G0rPVq4+T98YlqV8Usl9WGxhUkNYjpA
         Hy7fk4qboTGlS2lnKCycYGovm+Jj4CZ/Hli/mRYUNulxD7RdNG4HnRUqkircgYxaH3Up
         Wa+mmPhkztTqiCqIq6wLUWHi5HQDDtiXlmV9TvtFtc232g7lnMvijUy2Bf6qQc937K92
         7YrFryiPoa87w0w26lgS/MTyhsDpWpH/mIJd9zQMMVDZbnfPV7Z3oxEtDAYqZohC8DV6
         mXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640345; x=1756245145;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVz3Y9VpnYE4PVj2+x4ppZYRh/7u9Tfs4/CSD5zsJnw=;
        b=KXCmFkCoDHbXLB62yEep1K4ODFMrNmIGzFbcVfomt2qOSS8Vd2dXmgWxLn4JcLPOiO
         FqA5JCZif9aTHmTznkfu6Oifru8N5D4GpQFO5+m1LcYJIfsgIvXGbNxZq5NdXGOrS95x
         HH3u4MW/9e2+MbUDCXAVz5xkOJc6UDmUCZvd9rbbNp6ydbN1BbgfzDjqkBsniD0ded3R
         m/XgJC6Dn70nMy6fc5MQpr/BjpmMylazoXikg16DBtDOvgbKQw8krh4VZ3a4ltx1zzw4
         xeQU+G7Uwm+RKnNLs1Hm7cmi6EF2nUFdUL66Ihi6ADTRn489ed0DtvytOQi8YCwHLW4T
         1vFQ==
X-Gm-Message-State: AOJu0YxFdPo4OMBPYLbSdsYLlf5VK2ibR6V2xtbRqHcsnzoC1HbUsM03
	PMpTWnNTvVoFpSvlhRwnLaPxu+jxchr9ksnsEoaIX223SqAkt6+igIphMxZ2FAP2nH4Kg7vxoBg
	7WbTK1w1EXgzUH5NHLl/6kIGRu0Ubb2shBng4F/cX/ZxdJtNU0rymTwacpO/lpn6DSDkXBmfgLz
	GFuSJ38iguXJvAWAp0wK3fAe/ZWOY203fxo3qdGe4eso4hIwNqCWAGdOk=
X-Google-Smtp-Source: AGHT+IE7z3JoHU46VhERaG2rUhWS+WRB2JYInik0I1QmJUrgMcHdJZz9Xytw3QMikJfteQ5I/RRwqWO+5o1F0Q==
X-Received: from wmbem12.prod.google.com ([2002:a05:600c:820c:b0:458:c0cd:291c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f0c:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-45b4798a7bdmr3379925e9.7.1755640344849;
 Tue, 19 Aug 2025 14:52:24 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:30 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-3-smostafa@google.com>
Subject: [PATCH v4 02/28] KVM: arm64: Donate MMIO to the hypervisor
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
2.51.0.rc1.167.g924127e9c0-goog


