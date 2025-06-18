Return-Path: <linux-kernel+bounces-691269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A8ADE26E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B4417C0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 04:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55960217F23;
	Wed, 18 Jun 2025 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3HiNoPEr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6921146B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220678; cv=none; b=VSh0RX10OCb7fp9WinhXyHN1PC+/fG0ZJu1W/ED8IOSSxce5uPZk6tWnCjkrU78SC9NUxROuPppsGK6C+zJCnGxLFSfxhNxLAIQYceRmYmx0LTjblSVL3hQKVasSM4YWupq2+n9qKGfqR+1yAg4lqza+wT5AaND5l28B/OmYYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220678; c=relaxed/simple;
	bh=NPz0+9NZChr+FABsJMTAuN25yJ2sI7tDtR2Lkd4QSco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqWfKQN4xRYjunRyntZZdYZMzC+qflJhvxBdtkLzSxX1ti/e/kOZmVKyxlkw6IDRhcJdm1+uurD+oxcZnTCGIIjfDOJXP/k+PcdU8p4VtwOeL8YcjZpD8mOajTuTy0x9BCa6Hyc17IUhoCY9J4DKgFj/0JKbVPW5dgfh9NfZd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3HiNoPEr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so5248175a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 21:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750220676; x=1750825476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crtc37yj3I5HY0sOOY/Hc9qKBpXKt+15nfqytsnjM48=;
        b=3HiNoPErfo7kydQaNjYH+735LMmei2TZUHSQcMwl8H8YOCupVnC5Y3QGo66IOXwSra
         xO67bvOk7Nz/6AWdeORFdzlVKwYQtLQqFOuAh5fhFA4tZAjblAyhLD0CqDBqruCha7ia
         sqZDCCf/sqMF443ANY8anWsVnEU3S6FOcS2WU5U2VAbnKAPYpYI2YEGGttbkYO7oMHvw
         KQswzSS5LhJhrzjGl3cBXlBgNcce/6u1+FDdOH+9bs9KmCiA6rNZQYGQK41+ITk03o4m
         /C5v+NFcGQwhPApvZ892WmB4qqI7Gg4F6stzBEi5HSz3wF5+tYl5dasALWW/IDGU68UF
         LG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220676; x=1750825476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Crtc37yj3I5HY0sOOY/Hc9qKBpXKt+15nfqytsnjM48=;
        b=CKVAjbjt9kWwI4s1UJO7jUhAYHkG0oxf2fZWf7KVUfhQ9fLmlxvFfm8I9cbytV4Tuu
         W17FzoZo3MCoBYCgd2dvM37zZhUmRwbLYoZjaiaXhxBbyiEHb0lhi8Ux9rGiepsoqqC9
         per9cSahfJsjidl9OPfNMZojXb/J/2zXPwEYN1uU/tuXI2suHrHtWUMqXbeWpS0wIX/E
         0icvLL6hEBgoblQuiay6FsH8TlyKlvKxw/CfjdEmq8U4KiLR/WM7/et1v7Qo+NrQVcc7
         Gpo7Am9270C/VRNq/kuMmU9IHB40+fWKC3b7SNzkJftX5lpOtPs9KNxhcJkHTHKi5Q9o
         Apsw==
X-Forwarded-Encrypted: i=1; AJvYcCUyKxbdRTd4/hRd86ug8HmZ3FG8dz3MsdgzUjAjGRvf3RCchA8KQeyosHniHPIuceX03H0RJVncIoUWrfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcLZnL9tUetWR9S7PoRKUFIKp4FAyW3UDzvJPlRLworQHixmo
	kOVXCqHCi7qFuTq2YJP/hPLuHDLgpk+yqGZqhUXq9m0RgAUcEDp517xJcy/Bd1Q6maApfFvVIUB
	Nk2XJ2oGMtlRLexTOyXRY4A==
X-Google-Smtp-Source: AGHT+IECQVYtJtqccD2ckXzkUCRtEGI61f7empdw5CPtw8UB73TqbA6HTmrTRxT/T52yNYKeR/onnUx3D5hsOmVD
X-Received: from pjbsl11.prod.google.com ([2002:a17:90b:2e0b:b0:312:1dae:6bf0])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5245:b0:311:ff02:3fcc with SMTP id 98e67ed59e1d1-313f1c03409mr27710648a91.14.1750220676391;
 Tue, 17 Jun 2025 21:24:36 -0700 (PDT)
Date: Wed, 18 Jun 2025 04:24:15 +0000
In-Reply-To: <20250618042424.330664-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618042424.330664-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618042424.330664-7-jthoughton@google.com>
Subject: [PATCH v3 06/15] KVM: arm64: Add support for KVM userfault exits
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	James Houghton <jthoughton@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Anish Moorthy <amoorthy@google.com>, Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

To support KVM userfault exits with arm64:

1. Force mappings to be 4K while KVM_MEM_USERFAULT is enabled.
2. Return -EFAULT when kvm_do_userfault() reports that the page is
   userfault (or that reading the bitmap failed).

kvm_arch_commit_memory_region() was written assuming that, for
KVM_MR_FLAGS_ONLY changes, KVM_MEM_LOG_DIRTY_PAGES must be being
toggled. This is no longer the case, so adjust the logic appropriately.

Signed-off-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0c209f2e1c7b2..d75a6685d6842 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1548,7 +1548,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * logging_active is guaranteed to never be true for VM_PFNMAP
 	 * memslots.
 	 */
-	if (logging_active) {
+	if (logging_active || is_protected_kvm_enabled() ||
+	    kvm_is_userfault_memslot(memslot)) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
@@ -1637,6 +1638,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
+	if (kvm_do_userfault(vcpu, &fault))
+		return -EFAULT;
+
 	pfn = __kvm_faultin_pfn(memslot, fault.gfn, fault.write ? FOLL_WRITE : 0,
 				&writable, &page);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
@@ -2134,15 +2138,19 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	bool log_dirty_pages = new && new->flags & KVM_MEM_LOG_DIRTY_PAGES;
+	u32 old_flags = old ? old->flags : 0;
+	u32 new_flags = new ? new->flags : 0;
+
+	/* Nothing to do if not toggling dirty logging. */
+	if (!((old_flags ^ new_flags) & KVM_MEM_LOG_DIRTY_PAGES))
+		return;
 
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be tracked while the
 	 * memory slot is write protected.
 	 */
-	if (log_dirty_pages) {
-
+	if (new_flags & KVM_MEM_LOG_DIRTY_PAGES) {
 		if (change == KVM_MR_DELETE)
 			return;
 
-- 
2.50.0.rc2.692.g299adb8693-goog


