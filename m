Return-Path: <linux-kernel+bounces-749975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBDB15586
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968DE3A360F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3EF2BDC34;
	Tue, 29 Jul 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tr+kgpcp"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C429B795
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829743; cv=none; b=cVoNReszZgcbKCJLiJLnHNJ7Vfq2/TNevwNyu72vRaB3SQ4lWPoX7yIsFgBgf8ct9e13j6qfGzGHDXv0cSyR63LqQLtpmwUfQ/02EOYz4i3gkmDL/FrDabJ0OhfR14QZRtVRJNfBzN4D7Uqz9ca4YpMDyqUZZYqcBoiEMxRJBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829743; c=relaxed/simple;
	bh=5XaLz6TgyathNJqnhdFXTkNHqph5QPuoYA9YQ+u2AWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TOT50RDgHhiPZwR+INOA3fG4KYa20W46hmX07u7R0urW4HjcvbGqDQbAFEdp+D/HvkJ3KcAM4G4u/cyGw2eWCDoJwP21PgXFyRk0OztHdklL0k9QZ9eVhNr8+7TcgJ5jtqJkZERG+xN1oPjsaI6cj0jOoz/B9fMZzK3Q8OjvMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tr+kgpcp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so5723717a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753829742; x=1754434542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jzYeQ19SvsGHPOnRphF4Uobk/zE+UGMKVRi+nf13iRw=;
        b=Tr+kgpcpBNFLBAcgmWavkod0FfN2JvTQIfSFbeHwO47iF5hixJxEkzJeEc5JFEl3hh
         r4jaXchvJKfqappSVFhqoThP997pOP0L0KS/90xYeH0rPtCsmC6D8hHHLrWlcVWQEQbh
         88Z0mlaAuE6AN/n5hMDJYQ8xAz3tDzHBQmvyKOcBJc1KNHQRAmwIbzlZhYYVsHPDiJ5q
         CGoGMwA5nOYl5/IchONPu9iqJuGCrNHGZyRRmHj7vmaM0v/rjas83w7DEedlNccC/LqN
         h/yK9SW7oa052kNfJXygic5g/yRBvAHCWN3nQz6pgdpI2adyECGgorjab+JAq5S5BHHd
         4hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753829742; x=1754434542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzYeQ19SvsGHPOnRphF4Uobk/zE+UGMKVRi+nf13iRw=;
        b=rd5LEL2zQZZzatalw7Pg0g/hu2vYBArMO/up2VJmq66JTar8kMrJEF9DxpUfE+XSf5
         1fLHC0cnRPud4jrs4LkK4I+HPY2AvIFHONzRrusFoXWGpMJIaJcQZ7UOkKrsXHBnAXg+
         DkrU0dfxW138PFMCCU8pm9IWw3AriJx7I3gLQOst61FA0Zm10K23bcP0ZpSxREI+bhDf
         snoBqH2gEJyco5+ndEKnbnIK/vxrMjqcSw79X9MCoFo/17972dwJXgtHpljUHVrw4C+/
         U3hES7bxGEj54YhCKaYVhvLqd5+16Yse4LRrAOx0z/XYDASyjU+8JYPiZjNsClI2WW1O
         zVcA==
X-Forwarded-Encrypted: i=1; AJvYcCWD/wANPRjbYEp5fToCFBnoVQaY3GTW/ZH83s0//8DI+xwmxOFLeL2bGAPu6rEgSP7myjnDNtaB4a5NzDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefyXkEyiwBemv3G4WbrD4SXi6eKfVvvlnaky19L5P+dd6lcW0
	VRCxP2solM48qBUQOF+UwJ4Iinxq2/c4ZqTK2ELskvUBoc+FxeNWQLYbKU3iyzNQ8rKJHk/8vvE
	E3lfdeQ==
X-Google-Smtp-Source: AGHT+IFn2WAK9ukizMY0dgeyzampJaEckC2xblRT2k3Bk2uKavbOCAt+9mg9yLDOobFQoDGRUwGnRmEVCVE=
X-Received: from pjoa9.prod.google.com ([2002:a17:90a:8c09:b0:31e:fac4:4723])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc1:b0:31c:36f5:d95
 with SMTP id 98e67ed59e1d1-31f5de2f372mr1596778a91.2.1753829741953; Tue, 29
 Jul 2025 15:55:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 15:54:38 -0700
In-Reply-To: <20250729225455.670324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729225455.670324-8-seanjc@google.com>
Subject: [PATCH v17 07/24] KVM: Fix comments that refer to slots_lock
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

From: Fuad Tabba <tabba@google.com>

Fix comments so that they refer to slots_lock instead of slots_locks
(remove trailing s).

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c5e0a898652..5c25b03d3d50 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -860,7 +860,7 @@ struct kvm {
 	struct notifier_block pm_notifier;
 #endif
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	/* Protected by slots_locks (for writes) and RCU (for reads) */
+	/* Protected by slots_lock (for writes) and RCU (for reads) */
 	struct xarray mem_attr_array;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 25a94eed75fd..aa86dfd757db 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -331,7 +331,7 @@ void kvm_flush_remote_tlbs_memslot(struct kvm *kvm,
 	 * All current use cases for flushing the TLBs for a specific memslot
 	 * are related to dirty logging, and many do the TLB flush out of
 	 * mmu_lock. The interaction between the various operations on memslot
-	 * must be serialized by slots_locks to ensure the TLB flush from one
+	 * must be serialized by slots_lock to ensure the TLB flush from one
 	 * operation is observed by any other operation on the same memslot.
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-- 
2.50.1.552.g942d659e1b-goog


