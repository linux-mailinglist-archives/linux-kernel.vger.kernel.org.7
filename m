Return-Path: <linux-kernel+bounces-898702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFCC55CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C48E34E1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C2302165;
	Thu, 13 Nov 2025 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/2TzuNm"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F42FF16E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011511; cv=none; b=s8maxJXfwAZSnEk5Bg1jeyq1u48jMH7ZkzgYfQp0GmypFauBuzni4SgYeoOt3IchZWKECxVGjmTHnC5KHN9pqLddwDOQGA1Tl5GOCQnJhdcVjfgkvu6vq/q79k1OG1pRo2hq9B2ZuFFboocrRE9UZ0Uij2nkGyBPFazVSpn6eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011511; c=relaxed/simple;
	bh=w/PDH8oJeD6dMpuJ8r5XsK3/Zk2LCzp9EjWC0515E8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+ssDH2At2nndT6Znv5V0QMO2e8544lJEmiCNawlKewgorhnNvO2ItshHly4nvNIJbF1XuQm3hb7P69DrpVhXYOt5o72fp2gc2eAHyWGkRiupvS3pO0IRxZrgKyWmRgMMdCxhnVcGCt/oiKQasqGsOfcd6JyT73fPSyBVEo7hxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/2TzuNm; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-43330d77c3aso23322435ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763011509; x=1763616309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9SgCCzfx7hqB2TFCbu/gbrkrcw0YcG+BnpWWFTO5/g=;
        b=l/2TzuNmS9lN2R1VBYZW10nynAVIXUxKDKRpblZllRntOR2hzxAJKpFtOJOZk9IVOi
         wG/r1wRu79R+wrDDS5c948GJqol8Kt2gKcb71YQnrHn6pqwdQBr5G5u+wBrF46pxDb3b
         mvVw0Il/P8pKnNS3ob6oJ+UyTwEFk6S0S8m87Rx0LcuXA45xjABPRtDWc9K6/ziMqmUF
         GC4Q/LdCdPFRE6JP7Eq1leryXwz7GJu9tafdV+iMdaUcSXwZ3uOWu/ulWtZmk+BIAubY
         ZQOWCpm4gauz7KT+B5VgMy4YzRVMqb3sjuzcC8UhtH8f3tJPu3+WetPzr4Rl8taB5Ow6
         PM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763011509; x=1763616309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9SgCCzfx7hqB2TFCbu/gbrkrcw0YcG+BnpWWFTO5/g=;
        b=rn5PLmZpnUOO5CcSMQS55GDczN6q5+aTx5t8Oz/SCo4YPjPCjldit/KWmdPdwkVBag
         +skEI0Y6ey9aiEO2FrroKWXREq5D51LlVXRwj3j1JsAmIWQPQwV4n32hWQTjhQ45G5op
         t9RS6cprtVM1N4yDWDOwcQ/45ZGk3CPokM0ERHr2JLcmdRjut7ZSV/Lj8vhqwmDk2GqR
         6/aYAJe8CutiQ1VvL7MWpAzW+IL2b+Xe6I8v7jP739f0tfmpxX7DsueajiNSO6tmupxa
         PN4dM/qIe1XYA5ePWeSvhUdh3CFWB0ur8bF20bj1crxD17ot01X0Fn3aTCqXEa/lU3c6
         gX2g==
X-Forwarded-Encrypted: i=1; AJvYcCVkD4fS+0iHG6UlqW+Bu1Q83PfL7LOhLJHAHGdddtzA4X5ItmbgJoCoEmV8/8fwXO0oz3t9n7Hqp6sA9Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99JSVa/2z1UyRVJZlr9dgkl3VG7HdUZo2o0o+ptaq5LWtXEer
	J8uKbdU7sZcBr7BVhrvvmRPmbI/g0MFJn2AA/ftGQFnbNEtRW4JfjISHkJIkLEoiOvXgZsBIX0V
	7vdRZtZ4nnQ==
X-Google-Smtp-Source: AGHT+IEyJSyJIvlGRNrSoUOGgfcAkjKY1WyU5H5l7T8c0BR5P21QqG7oUV9JZZVGF8o1Ck1Nj4/ZN1JRw7Lq
X-Received: from ilbbk5.prod.google.com ([2002:a05:6e02:3285:b0:433:76d7:5d39])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:190e:b0:433:7310:f5bf
 with SMTP id e9e14a558f8ab-43473daeab5mr67314545ab.22.1763011509204; Wed, 12
 Nov 2025 21:25:09 -0800 (PST)
Date: Thu, 13 Nov 2025 05:24:50 +0000
In-Reply-To: <20251113052452.975081-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113052452.975081-1-rananta@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113052452.975081-2-rananta@google.com>
Subject: [PATCH 1/3] KVM: arm64: Only drop references on empty tables in stage2_free_walker
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Oliver Upton <oliver.upton@linux.dev>

A subsequent change to the way KVM frees stage-2s will invoke the free
walker on sub-ranges of the VM's IPA space, meaning there's potential
for only partially visiting a table's PTEs.

Split the leaf and table visitors and only drop references on a table
when the page count reaches 1, implying there are no valid PTEs that
need to be visited. Invalidate the table PTE to avoid traversing the
stale reference.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/hyp/pgtable.c | 38 ++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c351b4abd5dbf..6d6a23f7dedb6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1535,20 +1535,46 @@ size_t kvm_pgtable_stage2_pgd_size(u64 vtcr)
 	return kvm_pgd_pages(ia_bits, start_level) * PAGE_SIZE;
 }
 
-static int stage2_free_walker(const struct kvm_pgtable_visit_ctx *ctx,
-			      enum kvm_pgtable_walk_flags visit)
+static int stage2_free_leaf(const struct kvm_pgtable_visit_ctx *ctx)
 {
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
 
-	if (!stage2_pte_is_counted(ctx->old))
+	mm_ops->put_page(ctx->ptep);
+	return 0;
+}
+
+static int stage2_free_table_post(const struct kvm_pgtable_visit_ctx *ctx)
+{
+	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
+	kvm_pte_t *childp = kvm_pte_follow(ctx->old, mm_ops);
+
+	if (mm_ops->page_count(childp) != 1)
 		return 0;
 
+	/*
+	 * Drop references and clear the now stale PTE to avoid rewalking the
+	 * freed page table.
+	 */
 	mm_ops->put_page(ctx->ptep);
+	mm_ops->put_page(childp);
+	kvm_clear_pte(ctx->ptep);
+	return 0;
+}
 
-	if (kvm_pte_table(ctx->old, ctx->level))
-		mm_ops->put_page(kvm_pte_follow(ctx->old, mm_ops));
+static int stage2_free_walker(const struct kvm_pgtable_visit_ctx *ctx,
+			      enum kvm_pgtable_walk_flags visit)
+{
+	if (!stage2_pte_is_counted(ctx->old))
+		return 0;
 
-	return 0;
+	switch (visit) {
+	case KVM_PGTABLE_WALK_LEAF:
+		return stage2_free_leaf(ctx);
+	case KVM_PGTABLE_WALK_TABLE_POST:
+		return stage2_free_table_post(ctx);
+	default:
+		return -EINVAL;
+	}
 }
 
 void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
-- 
2.51.2.1041.gc1ab5b90ca-goog


