Return-Path: <linux-kernel+bounces-756884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA9B1BAB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3226B720259
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838629ACFD;
	Tue,  5 Aug 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHvibVWH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E02BF3F3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420760; cv=none; b=BrciVHrcqonY6bJnGRWMUQvRVXoPhwjw95xdP+CYiqzpT98Dtt9+oHPCTtnAL9eL08VwbE6CmOi4J2creexrekBIwSKSEkWqzeVtoRO6jREhSMXvlSpwjgznG/SDP6dIXgFP4DzdmN3h8tqDv9BsZ0euYXsBSPpNJ1Sb5D8VKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420760; c=relaxed/simple;
	bh=psR4I+ufoU1UhwaQI/3V99Tsfg4a+RYPNxW/6rK3XCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CPrisVB41sHi2xIbGnzErKg8uWtHxfgMZpRExMBdG+D7jNxIz5C11ugnTkg6kVdVY+35XLQWe5W2CKjCCtQU0ZF+t7M3xjwb0/qJrXPZzD+SYL9Yp+44QtZpLLWj05w3rzU5PX64h5G3yX0197HXCt/wAGNV21D3Cq7yHRxJZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHvibVWH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31eec17b5acso5935150a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420759; x=1755025559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fLHs8RygRrQALNjclLr7Le+Q1ExkVvDCVfxeia7/R9A=;
        b=BHvibVWH2qGtT8e/EATDkj92rZiu/diVQdVrdpQ/JZ42ePuvIpEfLGm7F4WEOscr9o
         DSWdVUOoT67XuIA5q6hzq4P4XfTBzzfQl4nelbgRvEG+fjBWaHbwzvlBkVGjf+BGGKjx
         QuuCJHC93Hl7uwb68O0tymVLda0NSRdY4FY9F7BHqQ8Kkpjgydn0W0AvH0p1I9Iu6rKG
         yVsg9r6Nk8TRsVcvyOG0let7NhDdD5RN1FXGMqabQ5WzifPD0H5zRzoycQOYZCU1smyp
         B7OU5/oOAnZkQM1SQDp+ehSxNgIBuq6+XmKt8B6MLy3vor38CSy3hOl1qERvb8p6wPUK
         UBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420759; x=1755025559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLHs8RygRrQALNjclLr7Le+Q1ExkVvDCVfxeia7/R9A=;
        b=Y9nSH+WvUalPdTkl0ppR00ec8LE8kF5eWrBwg08LcYY3lE0y31M36wpdzICdqhWT0a
         G1OyBwm43Uk00J174zbFg4Eca7JbxxEX8zrQZceFnOMC+tsDHNzzVIPNq9tJns+QIk/N
         3kQTdbWrrqfbpdiUdeexCzqZDWsgdjtuzAkpxB5UyVUhBZERK5jQZGFGKWhru3K4/KaW
         NtJYT147xI2RkghHiD+8GskMx7V8jUC58TGwWLnWXBxe2GcnMuCIHVOlzqxTYGoppI7r
         H+0yUvQp3BE43DXXR1VZnv8I8Nl89jjZMSw7z2THY40txjetIBM/oSMTxNdBud3ewvIn
         k/+w==
X-Forwarded-Encrypted: i=1; AJvYcCUTNaUczRmvubAY/z9iD51wUEw+XdTrz+fS6OroT5HpU6697htbz+i3EzJE1Nt8IuDLwKUhTl2/ytdY3zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5X9qEsxBukFRkoPkMVqIdmTTvLPStc0dl4PPjFbg2Me2XqJCB
	NOAi/YUBV/12umHOjt4qeoloPaVGlcvzWd5FfFKL6gSzL3SLHWSdJxVe1aoguTRF/kL81Ep3p3B
	Yate+TQ==
X-Google-Smtp-Source: AGHT+IHhRzbfPkZZCi4sJ+HYHlO8wPFG7lfHkjOAeauEAzcP+gDuNgftd87bIo4kHYo6mkitvsEho/wi4LQ=
X-Received: from pjxx5.prod.google.com ([2002:a17:90b:58c5:b0:31f:b2f:aeed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4f:b0:31f:30a6:56ff
 with SMTP id 98e67ed59e1d1-321162a204fmr20394494a91.19.1754420758726; Tue, 05
 Aug 2025 12:05:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:24 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-17-seanjc@google.com>
Subject: [PATCH 16/18] KVM: x86/pmu: Rename check_pmu_event_filter() to pmc_is_event_allowed()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Rename check_pmu_event_filter() to make its polarity more obvious, and to
connect the dots to is_gp_event_allowed() and is_fixed_event_allowed().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 422af7734846..e75671b6e88c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -476,7 +476,7 @@ static bool is_fixed_event_allowed(struct kvm_x86_pmu_event_filter *filter,
 	return true;
 }
 
-static bool check_pmu_event_filter(struct kvm_pmc *pmc)
+static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
 {
 	struct kvm_x86_pmu_event_filter *filter;
 	struct kvm *kvm = pmc->vcpu->kvm;
@@ -502,7 +502,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
 	emulate_overflow = pmc_pause_counter(pmc);
 
 	if (!pmc_is_globally_enabled(pmc) || !pmc_is_locally_enabled(pmc) ||
-	    !check_pmu_event_filter(pmc))
+	    !pmc_is_event_allowed(pmc))
 		return 0;
 
 	if (emulate_overflow)
@@ -969,7 +969,7 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 		return;
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
-		if (!check_pmu_event_filter(pmc) || !cpl_is_matched(pmc))
+		if (!pmc_is_event_allowed(pmc) || !cpl_is_matched(pmc))
 			continue;
 
 		kvm_pmu_incr_counter(pmc);
-- 
2.50.1.565.gc32cd1483b-goog


