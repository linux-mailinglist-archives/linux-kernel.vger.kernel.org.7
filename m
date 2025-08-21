Return-Path: <linux-kernel+bounces-780679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE34B307EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D7C1D4038D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A326B2C0292;
	Thu, 21 Aug 2025 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esaOrxLd"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B42E92DC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810054; cv=none; b=aZVNMWK/SuE/Nsy/qE1reLUQ7Uso0OQySDweBulvZ+DZfqhs5m7CEYB2jmD+pbI4Li7umP8dq9hcHmyzVwjspvWIUv+3s+rdNdsTgE10lpVSVyUmhprBh5dAgjWECu7fHFjNJgv1vLSv9VSB7mlzeLRJkbGZxzNUbzci0hCwHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810054; c=relaxed/simple;
	bh=H8VFs2vZlQmG1JGjKINVH+XiNDz8nXmxoTY7lDJ7m5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQWX1DjHgVv+75BRLBTLJVZ0VEWPKbQPms7RSNFelGoxp9fb0XAnjNB84u3jICXbN0gB2a4Qeoo/l5nDCpjbMzpln4ZSQrCJl2EjWtwMazOQi5al9jxFPWxEhDnulLStJcI/W/5xWoF00H9fvxvko4BA24I8oOqtceuX43+p8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=esaOrxLd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2461c537540so8457135ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810052; x=1756414852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X5D34uO9hhnDzIV0eQsNJj+iG1O4AZl7/xnqUAlhc2A=;
        b=esaOrxLd7BOO1sxSHQo/kDOfUMwgoHJEws1X3UJa9Siy4pq3VxH7W6cRbq1uEDpMZ9
         ApP9Iwkyn97TiEtI2FsqTBHm0rlzqjIsO8kd8ji8H7hW4IwhY/X/Uics01XB/6TD62JW
         Ob74D8dKA8yC9I07tL1NYqPgVLttlF7aNRZ7mYJ/PsazHWLgY9gA1BQ3R1qwwmUAaefS
         +RyGpMr80xkp56HCFiOE6JHvRdGpHbGoCVeD5HMVKUlsTfHTuzIgQrVwpuwc4G7bu9xQ
         y9Im3K2fYEnqf1540gjAHbv9Bm5XHA3K7562+bCJTL+U0HmQcmCtECmB3tXUTK5b9KGM
         5erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810052; x=1756414852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5D34uO9hhnDzIV0eQsNJj+iG1O4AZl7/xnqUAlhc2A=;
        b=HKkSLcrj0ZI6bWKphbTDTfsMWBpwekNMrNryMCeb5541by8G2St2kQaXcJH4LXH+7l
         DjF7TYFMZWrAgWgN/BT9OiH5ZxHfDkbEqNgJYdtOvXTIGuRLnkevd5X0YZVKK2+z4Nvt
         +KvA5yd90ImWCNIP4IIiGGKZYlE7S5iLgmJytQWGytqXKBwP76KCOCdIgrglOWGJL3bn
         D/kADj/8yGpoN/N8Y6dcWTBRU0rKLbE9PBV9Bhc2xymdUnZEzvkD27YrFG5QGb+wzseA
         gMJRgne7ZLU1JSiJXW7PQK6Px2JfrcB3mOZZ7Dr41ghkudYDNX1HaLWVYVAKss/yjI/Q
         gtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBFEJ9nMm4FBINm4BksWhATFHkSpA1bSkqfQqczLEudI5GafHqyMwwfxa2Lg8hsAbErZ9AcA26iZIfXtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygy4arU9fKnydJj1EENDFMlDPKUnVvy/jjhxEPBC4UQYPZD1pt
	bB4Bf/wGEfjkLdNjbSxBoBJWjV27pzsficJZh5iB9aWGelB2mCrqZT78w1b8BMy9gKtEQrYXoWk
	Y/wXSZw==
X-Google-Smtp-Source: AGHT+IGd2anZ06gtV+U6bVFsbbPnzA1ZdvlYu/bGmJdbd8hlQ/26jHjvFuQxiH/8Yk00e7KNqc/bTBAWfHw=
X-Received: from pjbsd14.prod.google.com ([2002:a17:90b:514e:b0:321:78e7:57fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da92:b0:246:2e9c:3400
 with SMTP id d9443c01a7336-2462ee5917fmr11005625ad.16.1755810052479; Thu, 21
 Aug 2025 14:00:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:30 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-5-seanjc@google.com>
Subject: [RFC PATCH 04/16] KVM: arm64: Use guard(srcu) in kvm_handle_guest_abort()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a guard() to acquire/release SRCU when handling guest aborts to
simplify the code a bit.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index de028471b9eb..49ce6bf623f7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1930,7 +1930,6 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 {
 	unsigned long esr;
 	phys_addr_t fault_ipa; /* The address we faulted on */
-	int ret, idx;
 
 	/* Synchronous External Abort? */
 	if (kvm_vcpu_abt_issea(vcpu)) {
@@ -1984,12 +1983,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		return -EFAULT;
 	}
 
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	guard(srcu)(&vcpu->kvm->srcu);
 
-	ret = __kvm_handle_guest_abort(vcpu, fault_ipa, esr);
-
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
-	return ret;
+	return __kvm_handle_guest_abort(vcpu, fault_ipa, esr);
 }
 
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
-- 
2.51.0.261.g7ce5a0a67e-goog


