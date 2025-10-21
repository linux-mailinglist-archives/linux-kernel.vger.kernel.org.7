Return-Path: <linux-kernel+bounces-862359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC0BF5149
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D465A3A7D52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6162882AF;
	Tue, 21 Oct 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9hVZa9A"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15632BE643
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032929; cv=none; b=frJ5VTfJOtHvMRgD4H97m0/aiQhtbM6A+dmptp8TOlL9GdcxXPz5QG3PdIxPIJboUVeeNcwHKXCL25GmjDgkiBFt3j5DXrJA4Pmi2v56QIheBVBboxV9TBFAu8Vvu0gCrCcpuMKAMLnJP6gTiavetsTkWZ9lOANk/+T+SwOAORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032929; c=relaxed/simple;
	bh=b1bunJvRMwHVDZOsTzIFfalAs34FSJTHmxHtOoMRcyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNbAcCs0sbGZFShDClUeMduTMb9ac4dIUYeFBTvchZcRuTy1j4XQuHHwkXaDVzfSxDjHL8QNaGCTeHoHbBEYq24rg2iRpyEqIYTtVl/z17/VoK7lNcJREFUqj9SzoDSG7TcYjZ/Ul6FrKd+52eOamJ0xxm2lBh+cksuZKFJ9pHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9hVZa9A; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761032920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+HGmEgjIusKwLuq4N4ktk6GF6BiFVs5iCdCBOce2dE=;
	b=Z9hVZa9ASBWP6zxAjwDcGhvEBiB5+aNiB2eqDPWPXp0dMMXWU2znE+k3JeD0Z7YJCvBI8k
	QCuywtfpBBRk2puijp01KLjhzcv2aQ7lbmmREGm2PnMt+s/3kbVmefPAK1FcQZY8ECxv3j
	NWsboke81jrfv57Fi9cVsvSDdaDXHMc=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 10/23] KVM: selftests: Stop using __virt_pg_map() directly in tests
Date: Tue, 21 Oct 2025 07:47:23 +0000
Message-ID: <20251021074736.1324328-11-yosry.ahmed@linux.dev>
In-Reply-To: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
References: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace __virt_pg_map() calls in tests by high-level equivalent
functions, removing some loops in the process.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 tools/testing/selftests/kvm/mmu_stress_test.c      | 6 ++----
 tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 6a437d2be9fa4..21c0f8e6552cd 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -361,11 +361,9 @@ int main(int argc, char *argv[])
 
 #ifdef __x86_64__
 		/* Identity map memory in the guest using 1gb pages. */
-		for (i = 0; i < slot_size; i += SZ_1G)
-			__virt_pg_map(vm, gpa + i, gpa + i, PG_LEVEL_1G);
+		virt_map_level(vm, gpa, gpa, slot_size, PG_LEVEL_1G);
 #else
-		for (i = 0; i < slot_size; i += vm->page_size)
-			virt_pg_map(vm, gpa + i, gpa + i);
+		virt_map(vm, gpa, gpa, slot_size >> vm->page_shift);
 #endif
 	}
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
index 077cd0ec3040e..a3b7ce1559812 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
@@ -621,7 +621,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < NTEST_PAGES; i++) {
 		pte = vm_get_page_table_entry(vm, data->test_pages + i * PAGE_SIZE);
 		gpa = addr_hva2gpa(vm, pte);
-		__virt_pg_map(vm, gva + PAGE_SIZE * i, gpa & PAGE_MASK, PG_LEVEL_4K);
+		virt_pg_map(vm, gva + PAGE_SIZE * i, gpa & PAGE_MASK);
 		data->test_pages_pte[i] = gva + (gpa & ~PAGE_MASK);
 	}
 
-- 
2.51.0.869.ge66316f041-goog


