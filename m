Return-Path: <linux-kernel+bounces-856713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5CBE4DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0C794F8805
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3834F46D;
	Thu, 16 Oct 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l41+waih"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559303431F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635831; cv=none; b=c0vzA+s+vavLmSSUYfDrTqH+jPathNk8/dlONE0VhgMEEx0pgmG8bgVqmLC1OIwvMJlPizYNwOMC5FhyIHzqOU+b8/LMMoudmdVy2e2kxicTBqXnPPJKToUiuXeNH5UT7Zoo/MEXGTlnMBZnAavH5kqoJWpmThVIKBL7Hrc//u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635831; c=relaxed/simple;
	bh=u73IkWxovHfIqFa1WeugdviVlKOG53gOaetPwlyyztU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NRTiprH/FG2xjxlfhcmvQ3gqnFUM+8W0xhu2zfxzy8Z9zN3tFo64E6AceYuL0Bt2auzWGkTkcjXDUzRokrrHg/8K6hPBm5+sOUEkwoxUr6Htee80ZgpsYpXntq6BG6v4JDQko48ONgpgsRuLox8MHRhNQFyWKgWWBrznBs/uphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l41+waih; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso1569184a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760635829; x=1761240629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hVBqs1fBWLjUqhKekNBXs2j0fRJmcNGrbmsvLjXeKrQ=;
        b=l41+waihuLTGtQNanwUNjhCuRxkZ3+g4RHJUpXsuNF66JXDSDFLirRAffRqPLKh+8n
         undGXyArwk7vBbUulc9lUPCFIjqedupCtRNwtY4kFF+AScEWT4wYWc56Dh8CiA23P5Wl
         rK+yNE/zrFx4lpAbLZaRjAbostWFNoaTTyphDGopvTe0G+a0ppjKOC6FE6XID50SJkOk
         nS7+GicXjfA9TraLlg0zgh+plotiBHZqcL3wGallJCFfBshgqBNyLXY1y7Ne4gd47pz8
         cwX5TWZe9oScoxZcVXOPPqtdOuTrMp09yaHcJKC/aJVuQlFMQ9na7izAYaTJTveg8yTQ
         xAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635829; x=1761240629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVBqs1fBWLjUqhKekNBXs2j0fRJmcNGrbmsvLjXeKrQ=;
        b=OZ9Etam5aWDB0v2I8h8WJsswUdQIIRaCmlV+cGPtZdLcERy4MRA3MkDaO1783Kkmnz
         MfskMh7ymBq/X8zovtmglioMRI2yADad6cWEVb9wSvieqEc9N9HFJGtdJj/Gim463O3n
         9bZE7va5oEpl2lxXCm1xHnxenwRvPjtBjCZDCbm9KFj4cinAiqG4y7jy6EKjZYO4mWsv
         OgX+ZAq1GVU63HUKRVVhkweeGcqMBag0vm/1A5UQvIhk/bHfS09epv4q5+w9ByS2HE4U
         KGnL7O3rstYA4z4YBAJPOJwjZt0w/h+oOFyEVpiGw7l3Y4q2mR8VlYolhdTki8DQu3QC
         5AXA==
X-Forwarded-Encrypted: i=1; AJvYcCVpDvGsYfZrrRYEGdvxYl/cttdUfMNOCkwqpJFVzGet7pYZ7SU6DSWz3DO6qzjtnIyISzud0VKEZh668pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3uwtHehSUXJdBNjQhuXh7W6o3L3bOcFL/yCvu4LSsAf0IUNQ
	bI23n6YB0JmsQ5boKKL6okiN28nvegpKtey/eq1cNYsQG6TUDIqyCcFlxNYj7hZbZEbMJWzq2Zh
	GIAD0tg==
X-Google-Smtp-Source: AGHT+IGe2t05unDim4uDryBf0T+QferPUXjPaV2LK4Nd4NgexnAWeTiux+wqiz6ZgBu9e+7IBbrnySiYCWM=
X-Received: from pja6.prod.google.com ([2002:a17:90b:5486:b0:33b:51fe:1a79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2590:b0:2e0:9b1a:640a
 with SMTP id adf61e73a8af0-334a8485506mr977560637.3.1760635829602; Thu, 16
 Oct 2025 10:30:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 10:28:53 -0700
In-Reply-To: <20251016172853.52451-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016172853.52451-13-seanjc@google.com>
Subject: [PATCH v13 12/12] KVM: guest_memfd: Add gmem_inode.flags field
 instead of using i_private
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Track a guest_memfd instance's flags in gmem_inode instead of burying them
in i_private.  Burning an extra 8 bytes per inode is well worth the added
clarity provided by explicit tracking.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 4463643bd0a2..20f6e7fab58d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -30,6 +30,8 @@ struct gmem_file {
 struct gmem_inode {
 	struct shared_policy policy;
 	struct inode vfs_inode;
+
+	u64 flags;
 };
 
 static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
@@ -154,7 +156,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 
 static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
 {
-	if ((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED)
+	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
 		return KVM_FILTER_SHARED;
 
 	return KVM_FILTER_PRIVATE;
@@ -385,9 +387,7 @@ static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
 
 static bool kvm_gmem_supports_mmap(struct inode *inode)
 {
-	const u64 flags = (u64)inode->i_private;
-
-	return flags & GUEST_MEMFD_FLAG_MMAP;
+	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
 }
 
 static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
@@ -399,7 +399,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;
 
-	if (!((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED))
+	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
 		return VM_FAULT_SIGBUS;
 
 	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
@@ -588,7 +588,6 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fops;
 	}
 
-	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
 	inode->i_mode |= S_IFREG;
@@ -598,6 +597,8 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	/* Unmovable mappings are supposed to be marked unevictable as well. */
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
 
+	GMEM_I(inode)->flags = flags;
+
 	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
@@ -917,6 +918,8 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	mpol_shared_policy_init(&gi->policy, NULL);
+
+	gi->flags = 0;
 	return &gi->vfs_inode;
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


