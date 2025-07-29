Return-Path: <linux-kernel+bounces-749979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF46B1558D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970983A462F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713652BF3F3;
	Tue, 29 Jul 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyBx3AGF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959A2BEC33
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829750; cv=none; b=A6SFvnhNI6U1nivows7SQuy6ubEe2FjAZsjcQKYZ6zQcid9HOE5eAVG1JxDU6SS+IC/4tVJG1pI8LO4qqmJOmktHF+zaUMjtOFjPeW0S/C5tAtNauACtGaje4I/RlMsP+D0lzL5VqLfXoNbjppfW6AeTzhtasso0vqN/thKvy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829750; c=relaxed/simple;
	bh=p3Az0/PEO9NNy7K/7GF+xs37R1p++sp7PEiKQeGgy/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwVHXHBRv8gycwGLBIBep4c5ATZ4KGgSVxZxVZo9j7zJllURfD9hp0D3U97XPfaBNAUWJbwKBBtFojkeWbWFxeQN3cTVzizI5eqt9ae5uYOHZWqYcxu4nhZmW9a5Aki05qT8Wa9Gi3WcqWhzS7RqzeeR7zQuIoml+UmP/UEDMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyBx3AGF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31eac278794so3523835a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753829749; x=1754434549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4HY+eQdd/nLDovMCXUcK3sJZavohA3et9/rmOJ7S8mw=;
        b=EyBx3AGFGUtXozsPzKgq9a/i6DfblJAQd4eImMYYaiLwkEKLAXCQM4aQHbq5TsKiOE
         W3qtcDLCIP4MWG3sIUPeOa/UgMGWFDgNv7nzdldl8UNEbg3fYXtvpa5GBLu0z59uwNNR
         GozKKpM0VDHrkI5d/OKSN4Tb5gB45il0fR0YZXaGercxBgci79tanLcqPCDH3BRLhtXG
         YpzXviHPGzMmPbC/R3ySCZYoQE3CHaqRa5IxVmpmxQbWFBll+1FFi4NBkmt58q5xWbO3
         Iq/9G31lXcbCz19R5R4nAuu7RYdiJwhBNJgA9FcdN6NkdK7t/A1gM0huorGZ9RYXa+oV
         SKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753829749; x=1754434549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HY+eQdd/nLDovMCXUcK3sJZavohA3et9/rmOJ7S8mw=;
        b=KBBBVndKRHIk+3TMMA2A38kAq7q7+oTjPDWLt50XnyEFV6vBIjoRw5j4mBhihYqUhI
         wkB3aLesWRQlTwh95ETgTyVuNRvx2SHDWhX/ooSe7jCoDqvwFzZeavu6TEM2gUWJyNJl
         3FuNfyDfdp1xcwOjKt2lu6jwggXshUksq5LSuVoMqfLgHfkez9XThfmB0WN49xG4V0kq
         vgAQ/oXS7if9xPdVWrnr9p65yQoWcuv80lIh13QyBoGzDca9ZZ6XIJ6oi9f7q+IUUlUe
         PTbMJa0wHzNl8Z+YtNgD5EqIK4kqeIUq3Vuu76celYHOiBD1z2CgQsJqyrlO0PYpaleD
         jK2g==
X-Forwarded-Encrypted: i=1; AJvYcCVQdQrJxYBFeX/pNgcGTfAoM008wUcLjNOIJhEiZ7sDPkZyhVCpokMMv350gmFaLwa9lYOk0BcjzoWTKfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt31Ma1aFO9/fRj5t0m/6/gK1OusIcX/kopbwAvQhoUiLjutou
	KFPQgqw2AIH1aRZkkTAgAIdUi24QewkBDzmbrpMuxLUrmyLEfGHTJbOaHOlq5pMik2tmX3kYy6f
	qJZs0iw==
X-Google-Smtp-Source: AGHT+IFhotmaClkAB7rg0QKOA9E4cmIDk69xmBeYfpjr1LTJA+UVvMJehEkVmJzu9WDpMq0oubFS0TPkvpU=
X-Received: from pjxx8.prod.google.com ([2002:a17:90b:58c8:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:47:b0:31f:42cd:690d
 with SMTP id 98e67ed59e1d1-31f5dd9e0d8mr1649821a91.13.1753829748835; Tue, 29
 Jul 2025 15:55:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 15:54:42 -0700
In-Reply-To: <20250729225455.670324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729225455.670324-12-seanjc@google.com>
Subject: [PATCH v17 11/24] KVM: guest_memfd: Track guest_memfd mmap support in memslot
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

Add a new internal flag, KVM_MEMSLOT_GMEM_ONLY, to the top half of
memslot->flags (which makes it strictly for KVM's internal use). This
flag tracks when a guest_memfd-backed memory slot supports host
userspace mmap operations, which implies that all memory, not just
private memory for CoCo VMs, is consumed through guest_memfd: "gmem
only".

This optimization avoids repeatedly checking the underlying guest_memfd
file for mmap support, which would otherwise require taking and
releasing a reference on the file for each check. By caching this
information directly in the memslot, we reduce overhead and simplify the
logic involved in handling guest_memfd-backed pages for host mappings.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 11 ++++++++++-
 virt/kvm/guest_memfd.c   |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 26bad600f9fa..8b47891adca1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -54,7 +54,8 @@
  * used in kvm, other bits are visible for userspace which are defined in
  * include/uapi/linux/kvm.h.
  */
-#define KVM_MEMSLOT_INVALID	(1UL << 16)
+#define KVM_MEMSLOT_INVALID			(1UL << 16)
+#define KVM_MEMSLOT_GMEM_ONLY			(1UL << 17)
 
 /*
  * Bit 63 of the memslot generation number is an "update in-progress flag",
@@ -2490,6 +2491,14 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
 }
 
+static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
+{
+	if (!IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		return false;
+
+	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
+}
+
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 67e7cd7210ef..d5b445548af4 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -578,6 +578,8 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 */
 	WRITE_ONCE(slot->gmem.file, file);
 	slot->gmem.pgoff = start;
+	if (kvm_gmem_supports_mmap(inode))
+		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
 	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
 	filemap_invalidate_unlock(inode->i_mapping);
-- 
2.50.1.552.g942d659e1b-goog


