Return-Path: <linux-kernel+bounces-869468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70632C07F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671A94030EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098B2C3268;
	Fri, 24 Oct 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bf9JyU84"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462992D3212
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335388; cv=none; b=k1SgQlm0J25/dgi/f4DrBp0tSarqWWiQKJ3dYaHiWTHchfkLu+n60f8S2eHkdQr/9TiYwWUuXCHGjkEIazcrkzz0Qi3jfnWs4QcqxlxuKhQfRzmdONLvemSNb2qSTUVTfiW9o8/7hy1sQye72CEkq1hY0snExYZvAWoB9OqC9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335388; c=relaxed/simple;
	bh=q6WXN/g/vZdHIGuGo25oA9ZyJR19gqZ7QVt+uudtNuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUr5C8s/jWz/lXdCrqE0MFuFS/RIgVQsU1jxeVuxAw+R+INen8p9Tp2prbQk6Ls28kq1LrtFe9k/FAJrBi1PF0lUGfkVkZcAooYxQhFQR6KU3BKV4TXl6kpyWqPmRVeTJ6L++fyHEdWzboGv8hdVyx7RO1bioJrMw3lPhvAU0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bf9JyU84; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761335384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egwTkK7S1Ygl+Ixphf3Iag59BjjN0yBTItSy9/vEdn4=;
	b=Bf9JyU84iJEeAA/pjzwGzCMJ5/TUKvfupRuTRRWjmXyVmnN7WeEnRzU5LzKcDN9qWKiRzt
	NXfCN32/v091GRzc8tljm0HXTvLrfp8+N2rrUg6ueWoyzRoaGs8tTy09LZz6GGuT/HD3WS
	Si3heYHmMezDb2Vbzj+EkOTPT3urNgg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [kvm-unit-tests 3/7] x86/svm: Add FEP helpers for SVM tests
Date: Fri, 24 Oct 2025 19:49:21 +0000
Message-ID: <20251024194925.3201933-4-yosry.ahmed@linux.dev>
In-Reply-To: <20251024194925.3201933-1-yosry.ahmed@linux.dev>
References: <20251024194925.3201933-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yosry Ahmed <yosryahmed@google.com>

Add helpers to check if FEP is enabled to use as supported() callbacks
in SVM tests for the emulator. Also add a macro that executes an
assembly instruction conditionally with FEP, which will make writing
SVM tests that run with and without FEP more convenient.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 lib/x86/desc.h | 8 ++++++++
 x86/svm.c      | 5 +++++
 x86/svm.h      | 1 +
 3 files changed, 14 insertions(+)

diff --git a/lib/x86/desc.h b/lib/x86/desc.h
index 68f38f3d..06c8be65 100644
--- a/lib/x86/desc.h
+++ b/lib/x86/desc.h
@@ -284,6 +284,14 @@ extern unsigned long get_gdt_entry_limit(gdt_entry_t *entry);
 #define asm_fep_safe(insn, inputs...)				\
 	__asm_safe_out1(KVM_FEP, insn,, inputs)
 
+#define asm_conditional_fep_safe(fep, insn, inputs...)			\
+({									\
+	if (fep)							\
+		asm_fep_safe(insn, inputs);				\
+	else								\
+		asm_safe(insn, inputs);					\
+})
+
 #define __asm_safe_out1(fep, insn, output, inputs...)			\
 ({									\
 	asm volatile(__ASM_TRY(fep, "1f")				\
diff --git a/x86/svm.c b/x86/svm.c
index e715e270..035367a1 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -53,6 +53,11 @@ bool default_supported(void)
 	return true;
 }
 
+bool fep_supported(void)
+{
+	return is_fep_available;
+}
+
 bool vgif_supported(void)
 {
 	return this_cpu_has(X86_FEATURE_VGIF);
diff --git a/x86/svm.h b/x86/svm.h
index c1dd84af..264583a6 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -417,6 +417,7 @@ u64 *npt_get_pdpe(u64 address);
 u64 *npt_get_pml4e(void);
 bool smp_supported(void);
 bool default_supported(void);
+bool fep_supported(void);
 bool vgif_supported(void);
 bool lbrv_supported(void);
 bool tsc_scale_supported(void);
-- 
2.51.1.821.gb6fe4d2222-goog


