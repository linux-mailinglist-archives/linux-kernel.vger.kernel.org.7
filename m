Return-Path: <linux-kernel+bounces-756881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288BB1BAAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5450626AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FF2BEC2A;
	Tue,  5 Aug 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BW51GNMW"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B42BE7A5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420754; cv=none; b=Lm23k36VkOQ2zAsE+K5FM7DVjMCZ2LrIdSgDW2gKfcxbaRJMbREB/1ucxN4ptLDOlya1cEbpZcKcERsDbQBeZmX4EP/5Zld2oQtb+c4nwmCroY0U/YcXcJcN2LJehBM8TxSb9tRDiYEtAqWvX5pWIhxyhxjs4bkSg1YLcwOD6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420754; c=relaxed/simple;
	bh=Kypk+/CIeqoZ/r5aB2dTj7/V8NMqnRxOmJHlZq0EdRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hwfe8xmSewb7XFIckTcY5ozG4bpR6aoD43+P49uQYH3m+X/HdlTOl0zuHjAcs/k+1pP+hNNDYUmqX8A2xatH9HCbqdF2XDaoNvjtTHwGFwNVTPg2X+K3xnw+Zob4ya4VAveHdi+N8kSpVnbNOPFGAe3r7HWgoki0gR9WjkGFTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BW51GNMW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b38fc4d8dbaso5741144a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420752; x=1755025552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fDzHgBJ4HosuuKeQovaY/hyA5EBdxNO5TIzhzBsDnxo=;
        b=BW51GNMWVH2YnQaW3EAEKBoEmp2xSsSuFdC1JyAmya3G5dvRygJX2mHw7svqqzWbgE
         6HV3QWdYCrlSq6I1vSmG2o7xnknLcj1YkTqTr/cNXB3V8B+OyYlI77MPqJZPf41Ka9wa
         xof8napwLg5sCt7w8nbQJvhjK+pd6oi8sxksS0V8r3PHoy/ME8c5iLnC1dCofLFEjhK0
         cD4NqM3A/2ZZzJoU3G9nE9AHAxIOGAuhjH4CGzAtIjDb7nvYq0PAKY9YTTTha5Q9TQ7H
         naVoZ4E3EAsvJilbDjInYGadF6E4XdB0QckCaaXA8fsJSYejV+MkBUKFjbkNjgP0GMPA
         vVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420752; x=1755025552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDzHgBJ4HosuuKeQovaY/hyA5EBdxNO5TIzhzBsDnxo=;
        b=uB0VmnUn1vZydHiH9Owyh+SBhLrjU53VEJcpFfxRLkQCrQgHG9qgTz1qo1zYyO5/hA
         DvRJAB/b97jNM0A+S6bTKnOcfNbKPQqVxJUaNoxHkproy9sRPaPoAnsn+exM2bz04BCA
         6oodpR4KWfLJl1a+W+mB3Lhjw2lQSa98f7OqPGO2O7CTcBjKxJlZYIJ3mcc+skWeWvHI
         HwRtkhjmYq0VEUMdADi2Z064aLoT8Ii/humbJcd8T8tbaRiQu3HMmpO99OprdkmXfuh5
         JJPIPZGYgylH/KmwKYRbClD4FAr63Zk3nVa3R7sMUCq4C7rDeLQBy38GueSvN5y95yfd
         rQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQHXFfL+bnih50spqv/VwH2ovasPXNxxxBzl5uEEWb06/1PWSAPTc+634hvMiaryGYKVYiK1v3spccgaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHy3BdsoHINr7RbDhhUv8FF0j1u6EspBxaDtC5E+SRNDidUa/q
	ynPkfnz0cGJw4h0uDR5oSf5dlkymPpU/d15tte36DMeKfFA5unhbFnfDjxMrlKyVzLwzegCDDiA
	70hC0Lg==
X-Google-Smtp-Source: AGHT+IFMZ78t6jlZ4Hg4XAsyFyrTTPw2ebUp6YO0LiIwWC4Id16cUZUsvZRcvyi7Iqfg/ZZ9YEb5MYML3L8=
X-Received: from pjbpa2.prod.google.com ([2002:a17:90b:2642:b0:311:7d77:229f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f85:b0:31f:3cfd:d334
 with SMTP id 98e67ed59e1d1-321161f06d3mr19905789a91.4.1754420752515; Tue, 05
 Aug 2025 12:05:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:21 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-14-seanjc@google.com>
Subject: [PATCH 13/18] KVM: x86/pmu: Open code pmc_event_is_allowed() in its callers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Open code pmc_event_is_allowed() in its callers, as kvm_pmu_trigger_event()
only needs to check the event filter (both global and local enables are
consulted outside of the loop).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e73c2a44028b..a495ab5d0556 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -491,12 +491,6 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 	return is_fixed_event_allowed(filter, pmc->idx);
 }
 
-static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
-{
-	return pmc_is_globally_enabled(pmc) && pmc_is_locally_enabled(pmc) &&
-	       check_pmu_event_filter(pmc);
-}
-
 static int reprogram_counter(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
@@ -507,7 +501,8 @@ static int reprogram_counter(struct kvm_pmc *pmc)
 
 	emulate_overflow = pmc_pause_counter(pmc);
 
-	if (!pmc_event_is_allowed(pmc))
+	if (!pmc_is_globally_enabled(pmc) || !pmc_is_locally_enabled(pmc) ||
+	    !check_pmu_event_filter(pmc))
 		return 0;
 
 	if (emulate_overflow)
@@ -974,7 +969,8 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 		return;
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
-		if (!pmc_event_is_allowed(pmc) || !cpl_is_matched(pmc))
+		if (!pmc_is_globally_enabled(pmc) || !pmc_is_locally_enabled(pmc) ||
+		    !check_pmu_event_filter(pmc) || !cpl_is_matched(pmc))
 			continue;
 
 		kvm_pmu_incr_counter(pmc);
-- 
2.50.1.565.gc32cd1483b-goog


