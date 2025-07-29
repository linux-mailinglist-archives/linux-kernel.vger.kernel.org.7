Return-Path: <linux-kernel+bounces-749981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBF2B15597
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36F17A5400
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AB2C1798;
	Tue, 29 Jul 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBjqTmid"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34D2C08DA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829757; cv=none; b=hiVzHKW1EuLO4GnFyFka7dWWeqtf3/tniI656daDgiQJyKvttHQO+Ui5fhvsnhKlvcNP9aU/H282WV6/B5bumV+PeiJoTpVPWrEh4lLhJOJYAG1oM2KIMEJ+Y/kvjxTfbk22tRXccd99gbWdwHji4KaudOktT3VyBzObMT/XX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829757; c=relaxed/simple;
	bh=kT4TPh6b6a+599yVr48tLtWPsbJrSQilKhWv9nX31KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QvhZkS8c5HdDddnMs1UFgrDnKt5YO/7pnLXKz7ce60RESiV6d0ZWVMyXbzTWRLutZ+dnrENjmAukRZWbISLlSu0fIz2BJ4gyxOCrZjR4E2t9wwl7A14tHpTWmFGqHwSFlBozUnE7MflW3/R2bsJys6Zqmi5Vuk1YLyBYGg+1BTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBjqTmid; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0e0c573531so4462239a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753829754; x=1754434554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ktkS4XskSt/ldoD432h3UVfIavH2avWaXTLdCBUmGII=;
        b=gBjqTmidzRqH2Q1k26ImAVp2G1O4kIip+tGFhkj0DKMctmQYyjXvCvwWcJrVQVEOkb
         x3IZKToHtcZ7N3oqcyqXn3McQ5mj9qzrOxz8k63bqlm3HSwG05dvYOagk0TGfASj6WnY
         TIsPT3EIE3p2Ig0Iq22GpgBz///STDrtJk8Qi9TbJkPTBnmv5VG7URWQ91QdhDtA5ynB
         K9SoOGRRoPH/6RyASqC9h11V1Jjd27JBb1mCfh2ym5YcCBvcI+Ie9ZK+amqQ5bNBJ9Wo
         cICZk0Fb4U9pci2+dAvktupjtnKGUqGu1tEJVo2U2/skno/LM6CGjwdG1IANlwS62GmU
         +4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753829754; x=1754434554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktkS4XskSt/ldoD432h3UVfIavH2avWaXTLdCBUmGII=;
        b=pN/GqlHzoI64AuTl741qAC2l3wp1UkmEDB/JnImLeELeyDlvs9IvWEbSylTr5qRu3a
         IdTGmChoiVXYwpnciUCovmsnWM8+a8ujgtXyny452ojsLg7Mwye+8UHgSNZ9+aknOb83
         sQH3uFXt8m4D1vpXoRnRxHJ/A1DgQfZvtM7RFt5eNg0F5ZnaV55m0NFF3zZ8anuU7C96
         rhruK2Wc+37/F+k0MSAKnwpSayifK8ySBOtzBknXYjgnAXblJhzLIvar6FUu5MhzHY9g
         GJzHB7eUls/WRCrYet/Yjm9Tlp19l7qCnvaxTDC6y/KMb3cJN9fEqxYwtec/i92JTigd
         +bXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRb/Pvt/sGjRwiCr2iV0QG0BgkkuKjwb8wJ1/Qog2MnXvufTVA8/9VLaVwWR2mcxYj/3fBh2/M3uqBg5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MBKlCBNWkZB1HLN+aiqVykoDkTd6lYi1xOxH0bmg0srxVSII
	Xo9t8ZJYThGkymqtx9NQvPP+3Sn+3XkUiqeUKcGkUrwTyXDRM2yKaIutIdQkbLEHn7I6DMnvXhJ
	C9YWXZA==
X-Google-Smtp-Source: AGHT+IF1LeGDZhIWjFUGooq7VUSMoBrDEWnqlrxEZEjVnkOZOM3/aPj5utdyv/03YLi7nQKPITTKBEyZftA=
X-Received: from pgbdp2.prod.google.com ([2002:a05:6a02:f02:b0:b3f:2e87:230b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c90:b0:232:93c2:8851
 with SMTP id adf61e73a8af0-23dc0d5e0b5mr1613137637.18.1753829753942; Tue, 29
 Jul 2025 15:55:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 15:54:44 -0700
In-Reply-To: <20250729225455.670324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729225455.670324-14-seanjc@google.com>
Subject: [PATCH v17 13/24] KVM: x86/mmu: Hoist guest_memfd max level/order
 helpers "up" in mmu.c
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_max_level_for_order() and kvm_max_private_mapping_level() up in
mmu.c so that they can be used by __kvm_mmu_max_mapping_level().

Opportunistically drop the "inline" from kvm_max_level_for_order().

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 72 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b735611e8fcd..20dd9f64156e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3285,6 +3285,42 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	return level;
 }
 
+static u8 kvm_max_level_for_order(int order)
+{
+	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
+
+	KVM_MMU_WARN_ON(order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
+			order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
+			order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
+
+	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
+		return PG_LEVEL_1G;
+
+	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
+		return PG_LEVEL_2M;
+
+	return PG_LEVEL_4K;
+}
+
+static u8 kvm_max_private_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
+					u8 max_level, int gmem_order)
+{
+	u8 req_max_level;
+
+	if (max_level == PG_LEVEL_4K)
+		return PG_LEVEL_4K;
+
+	max_level = min(kvm_max_level_for_order(gmem_order), max_level);
+	if (max_level == PG_LEVEL_4K)
+		return PG_LEVEL_4K;
+
+	req_max_level = kvm_x86_call(gmem_max_mapping_level)(kvm, pfn);
+	if (req_max_level)
+		max_level = min(max_level, req_max_level);
+
+	return max_level;
+}
+
 static int __kvm_mmu_max_mapping_level(struct kvm *kvm,
 				       const struct kvm_memory_slot *slot,
 				       gfn_t gfn, int max_level, bool is_private)
@@ -4503,42 +4539,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		vcpu->stat.pf_fixed++;
 }
 
-static inline u8 kvm_max_level_for_order(int order)
-{
-	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
-
-	KVM_MMU_WARN_ON(order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G) &&
-			order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M) &&
-			order != KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K));
-
-	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
-		return PG_LEVEL_1G;
-
-	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
-		return PG_LEVEL_2M;
-
-	return PG_LEVEL_4K;
-}
-
-static u8 kvm_max_private_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
-					u8 max_level, int gmem_order)
-{
-	u8 req_max_level;
-
-	if (max_level == PG_LEVEL_4K)
-		return PG_LEVEL_4K;
-
-	max_level = min(kvm_max_level_for_order(gmem_order), max_level);
-	if (max_level == PG_LEVEL_4K)
-		return PG_LEVEL_4K;
-
-	req_max_level = kvm_x86_call(gmem_max_mapping_level)(kvm, pfn);
-	if (req_max_level)
-		max_level = min(max_level, req_max_level);
-
-	return max_level;
-}
-
 static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 				      struct kvm_page_fault *fault, int r)
 {
-- 
2.50.1.552.g942d659e1b-goog


