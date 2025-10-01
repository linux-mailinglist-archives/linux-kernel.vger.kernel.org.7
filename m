Return-Path: <linux-kernel+bounces-839157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113CBB0ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C55819C1ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A930CB50;
	Wed,  1 Oct 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l4eiNaMK"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AF30BBBC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330736; cv=none; b=OO1x3sXJFMqpVqKrjVIY6IzeGhGM9x64r1jndy1wjVOX4PqtIa8dCJY5QN9Jy8nnjKNyV+pkf3E1YFZrJAKozEP/mx/jN30GgtJbgcrOlXht6VVvwXN+nIDQmIixKqw2kgZzokRZur5o6Y2j7ipo8BEsOdV9YhHnDLCLCz2algE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330736; c=relaxed/simple;
	bh=mbOhnxuG8ulswfPMlF0N9ZTEVLzFWKgBEB2IUkzLVlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuFQcJtUSq3tmf4M9FOcNv/ZBMtBNGCJ+EGH7ZJEPEqKOVA7LEkSLWk2/JhF8O27b/8X/msyWq53A/4bLxVT0EjPA1Mz1gKnEjOdzKkKu2kPvbe6flRLfa0GYZ3bYNZHfang8HcMS5phg0X5FXz7rh0YHxuy5QQpkzW5JDK4wdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4eiNaMK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759330733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNK27Cs7fKo0r1Ea9VAB8EPPFw2zlK9HqEAKfMAfOo0=;
	b=l4eiNaMK6iUmhJHj7eLOZwGAtlj1AC4SL0RZ6zu/t2ZAjdfz03JSgGho/xxOZaOQ1j8ccz
	OcXSNQOIylmqKqmEHOahH/w2QUyUt8gPcckuuyavqaqnRYf7wpp5/nDwGq376Jv+G3Fou4
	ZP1lTqm4uGBMJCfZYeY3b300Z4zM5JI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 08/12] KVM: selftests: Use 'leaf' instead of hugepage to describe EPT entries
Date: Wed,  1 Oct 2025 14:58:12 +0000
Message-ID: <20251001145816.1414855-9-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-1-yosry.ahmed@linux.dev>
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yosry Ahmed <yosryahmed@google.com>

The assertions use 'hugepage' to describe a terminal EPT entry, but
'leaf' is more accruate as a PG_LEVEL_4K EPT entry is a leaf but not a
hugepage. The distincion will be useful in coming changes that will pass
the value around and 'leaf' is clearer than hugepage or page_size.

Leave the EPT bit named page_size to keep it conforming to the manual.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 tools/testing/selftests/kvm/lib/x86/vmx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 04c4b97bcd1e7..673756b27e903 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -380,15 +380,15 @@ static void nested_create_pte(struct kvm_vm *vm,
 			pte->address = vm_alloc_page_table(vm) >> vm->page_shift;
 	} else {
 		/*
-		 * Entry already present.  Assert that the caller doesn't want
-		 * a hugepage at this level, and that there isn't a hugepage at
-		 * this level.
+		 * Entry already present.  Assert that the caller doesn't want a
+		 * leaf entry at this level, and that there isn't a leaf entry
+		 * at this level.
 		 */
 		TEST_ASSERT(current_level != target_level,
-			    "Cannot create hugepage at level: %u, nested_paddr: 0x%lx",
+			    "Cannot create leaf entry at level: %u, nested_paddr: 0x%lx",
 			    current_level, nested_paddr);
 		TEST_ASSERT(!pte->page_size,
-			    "Cannot create page table at level: %u, nested_paddr: 0x%lx",
+			    "Leaf entry already exists at level: %u, nested_paddr: 0x%lx",
 			    current_level, nested_paddr);
 	}
 }
-- 
2.51.0.618.g983fd99d29-goog


