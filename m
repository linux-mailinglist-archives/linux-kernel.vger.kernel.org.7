Return-Path: <linux-kernel+bounces-780676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87985B307FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02BDB060B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ED729E10F;
	Thu, 21 Aug 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Bq1+19S"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790D2BEC4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810051; cv=none; b=RKjFTvsqaNcjYr5g9hgvD7dhnMVq29cdkt1Lqr6Q7vpPcxgluUIbOBeuKsUK7DYnvxGZQE4wQhu1TYkWspve7nLsVhA6o5V7smdymho6LtIUn5cawZiW5K9Guo0pEWwPPqxCZl2eGDuqKBqSy3tL7Vr1dcqho2WUPKCqHVYv9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810051; c=relaxed/simple;
	bh=XIPH6D7OK9e9Nk/anEV/qb0UKnQEM3J9OnJTOv3j/hE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cLcEzM5wR4A7ILwhB8RtvSTuP4efsORnoWdMGmGmdhP67AEepzaAqNGX/OaLM+bnhXrvB1X9JHuedYDLU+oXsRDLx+jfD+i9udPwE5G74M/MQTHYiySroIIs/JjAan2CnwzWTJV7GKdgmPbm/X6W1n4DIbIfNxTkOsylXI6xuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Bq1+19S; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471757d82fso1136197a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810047; x=1756414847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=etQsx3Bjkyo2W+FnvyouolCpcLbOwVVqYYIcKcKxQxw=;
        b=1Bq1+19S7B0g7Z8tXChURM2aaVaMo7V7FhDA80qNCeTXIsXVfFxjSfij3UUv6Nopft
         15t79HeHGtWA58KEbSYT9/xBvhMQdbWNdYYipX41UiMBWocl40n1vEd9BoPOi1RIyzvf
         rC6mzoC8v2H41eejVDHUr6gztiZHK96qBqvnGuk57YnN3ICyxtNTsOrzVc2EBQvx1MRA
         tUxxL95D15aMDvT0TmkkPKXeKRdk9EtQVuOxlMnrhtuQnkBvbj8sIvipH23CfR03Ge2C
         3quEw9r+Qg2zzwDCF3abGfYV/28wycdmZ0yu51mh0yMqycqBb/zK9RtDBjn0xZyIGMMU
         TEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810047; x=1756414847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etQsx3Bjkyo2W+FnvyouolCpcLbOwVVqYYIcKcKxQxw=;
        b=daCcYtufD/iATvYvPHYGO4uoVeK+2hYDkthajvmmSxGCAxlxJh6481w2qLZBTjVwjl
         NYi1J3jfmtnVCbyCLpYZx3vqC4BS0gtihp0aAM6x5Ec40zJPLT0SuUH1cqfdAM4tl4KT
         yFrnhakMpUW1JNzDIhvXShgv6AmxbT1BP+q5NTQscRKGpcjsHi7ET+r1+YWrPtE45t/5
         QmteLu0UqH63Hm46yUInrccujyjHc9mb3RRQLuvNTspeIe+GDyTQZsjHEBcTjra1f7Ky
         JKKsqVRXBoND53mISNwEq/oLAy5etbDS5+VnL1MIs2kemZXStkzxzd1wqOeOtQ11T1oe
         HreQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDNuaF7nTHTUc8EsTpzufdG31dGXB71MTYPo9HvHc8uMeF/YYRv9hlZpvwEv1PWuZX8owOLObaOV/c7Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDhbQg/vpwJVPKyYNUbXKgaotgWs3RgpPP3BLeYypyQ1C5OKf
	EeIUAD7XikMCCBJyT+Q2sWc4DshE6J9O8SMbQv0850AX7iH/om8ZkDDZagwaSqszZgSXeEY7cQY
	X+yJLFg==
X-Google-Smtp-Source: AGHT+IG+AbHEFENih72v8s75m7PziM02RS9Hkp0sUk/+ACGLaOQo6n0X4YmQa5UYgK3E6VY5WcrGDki7bAU=
X-Received: from pfqn26.prod.google.com ([2002:aa7:985a:0:b0:76b:b0c5:347c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2446:b0:243:755:58b8
 with SMTP id adf61e73a8af0-24340d9268cmr736072637.57.1755810047367; Thu, 21
 Aug 2025 14:00:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:27 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-2-seanjc@google.com>
Subject: [RFC PATCH 01/16] KVM: arm64: Drop nested "esr" to eliminate variable shadowing
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop a local "esr" variable in kvm_handle_guest_abort() that's used as a
very temporary scratch variable when injecting nested stage-2 faults, to
avoid creating a shadow of the function's overall "esr", which holds the
original state provided by hardware.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1c78864767c5..dc3aa58e2ea5 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1904,19 +1904,15 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	 */
 	if (kvm_is_nested_s2_mmu(vcpu->kvm,vcpu->arch.hw_mmu) &&
 	    vcpu->arch.hw_mmu->nested_stage2_enabled) {
-		u32 esr;
-
 		ret = kvm_walk_nested_s2(vcpu, fault_ipa, &nested_trans);
 		if (ret) {
-			esr = kvm_s2_trans_esr(&nested_trans);
-			kvm_inject_s2_fault(vcpu, esr);
+			kvm_inject_s2_fault(vcpu, kvm_s2_trans_esr(&nested_trans));
 			goto out_unlock;
 		}
 
 		ret = kvm_s2_handle_perm_fault(vcpu, &nested_trans);
 		if (ret) {
-			esr = kvm_s2_trans_esr(&nested_trans);
-			kvm_inject_s2_fault(vcpu, esr);
+			kvm_inject_s2_fault(vcpu, kvm_s2_trans_esr(&nested_trans));
 			goto out_unlock;
 		}
 
-- 
2.51.0.261.g7ce5a0a67e-goog


