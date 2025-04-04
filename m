Return-Path: <linux-kernel+bounces-589288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA8A7C472
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 22:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A6F3BF346
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFD225761;
	Fri,  4 Apr 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qe3qkxU4"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2121E0B2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795615; cv=none; b=KjKuy//7le8a/7bkQl1PHKDAt0hD64WfXE3aUeKpZMjiP9P6Q+kFfTVjNMkULeojjjq/CdNC6+4JyygmCjAgSIDHGylVBIDg9XOt9Eo8e6yQyIS4wV7c7vVOy1zVNFfyjAvCwATTdIzkbt6W3+YVp4WFsPvCTW5OBAT2HQrCS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795615; c=relaxed/simple;
	bh=5nhNidq5kKCw8cPZzC/2EhhNf9DP5bsK6q2EHVi+AUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYeUfHGOJE6YViq1p6WnGsULEC77oi7l3pGKrqcLfz0XfF/JO27ivwkhMfWURWF8h92ViCLyENEm6hHoELemYDbEF66eISU5c4Gsc+rPQOg2gC7R5TL14eT5kiRVqpCUHMgFPj6dZHsUBznd1d1xPzjnAZMB7lsPjHdEFwOhXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qe3qkxU4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c89461d1so3576552b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795613; x=1744400413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6CjC9nxAlVYVI0vNC7khUHTwDmf+yRrkIu6OvCEfg=;
        b=qe3qkxU4whFzZfvuVAUo68SzHiPxCNb1tSZP0UHpTxHI53jqfQ2vmfuwFi1cp0vJRw
         yt212uHXGS7Nh6OGVE2GRQetvbv/uc8koH7TvAuF6xyS4gn+D6lIN7pJFj8HcWJni/GQ
         oslqDAgbbI79V4bkPsvcSgsy8cy+5xc39tWc80+TfhG5mi5f/G3scCRW173+l1TIhEYU
         G6YGPynDrPmZK/xiLJOUmJpIQF/av8FJW1V9SoS9wt1vT8Vo+DOowW9Ke53GX0fxho6F
         UCF0PlYHx3i0HdDjVlk3N+zC2wfvVYh97sP8dDtESWkpWeoEdNQ3BPjx2cV55SbgINqX
         jL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795613; x=1744400413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R6CjC9nxAlVYVI0vNC7khUHTwDmf+yRrkIu6OvCEfg=;
        b=T9fva8VHNugOdN/B+RAKwc/0IDTSrPRNm/0T9Ei7w2qk5SYuzkEo8RfXoGJkiDKnGv
         opj3/mv3b9XyoTGrgR3c157hJliFXmGCRKjNlWtN2RUHxb08rfaov97p8VEmKaD/Esqi
         o+zLZy4w7Qg1loz1rB3nxRUjc0d4VycDDbYYtdFs/vsOmDwI6ItjO+0nM03BaqOaQLz6
         3wGWTF2Gom0nmELnLK5QUPd4owc2+yVQJQEQ9f2DWsFhMXaiiz72rDDbRZq3AzaHkjM2
         P9paW/Oy2IDG6yEeUGmbVteBkdGsAIb6hplJ/D1K1mdkf0RSrC1HDjqUWy7wV5OBOZ1U
         TK4g==
X-Forwarded-Encrypted: i=1; AJvYcCXnzRx3HiD4CHh/40bRuxwXC5gjXBFPemG1YDbehzieQRHjIfVO8cjbtWMBoRNpkinWOZypcD85440uHRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbuz0fy63edjwM1Sze7uUgpIcQyZdyuyltkbymW/O/Ew8O9S3u
	B3gO8UTZKhYBjsaP/KcbBD31W7ZLFtzl5ZFLh5IlFpYq3gnq75duXdXA/7ZOzdOzfP2xaxKLGvh
	nTw==
X-Google-Smtp-Source: AGHT+IE1EIppngaCdboWmAsyGLdJBGl6DmfjRI9oduZtmRDlzdb3XCSaEM1nhSyczDVhV3HThe+yTT0lId8=
X-Received: from pfblm21.prod.google.com ([2002:a05:6a00:3c95:b0:739:45ba:a49a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4606:b0:736:592e:795f
 with SMTP id d2e1a72fcca58-739e6ff6b02mr4668862b3a.9.1743795612853; Fri, 04
 Apr 2025 12:40:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:30 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-16-seanjc@google.com>
Subject: [PATCH 15/67] KVM: SVM: Drop vcpu_svm's pointless avic_backing_page field
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop vcpu_svm's avic_backing_page pointer and instead grab the physical
address of KVM's vAPIC page directly from the source.  Getting a physical
address from a kernel virtual address is not an expensive operation, and
getting the physical address from a struct page is *more* expensive for
CONFIG_SPARSEMEM=y kernels.  Regardless, none of the paths that consume
the address are hot paths, i.e. shaving cycles is not a priority.

Eliminating the "cache" means KVM doesn't have to worry about the cache
being invalid, which will simplify a future fix when dealing with vCPU IDs
that are too big.

WARN if KVM attempts to allocate a vCPU's AVIC backing page without an
in-kernel local APIC.  avic_init_vcpu() bails early if the APIC is not
in-kernel, and KVM disallows enabling an in-kernel APIC after vCPUs have
been created, i.e. it should be impossible to reach
avic_init_backing_page() without the vAPIC being allocated.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++----
 arch/x86/kvm/svm/svm.h  | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index a1f4a08d35f5..c8ba2ce4cfd8 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -245,7 +245,7 @@ int avic_vm_init(struct kvm *kvm)
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
 {
-	return __sme_set(page_to_phys(svm->avic_backing_page));
+	return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
@@ -290,7 +290,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	    (id > X2AVIC_MAX_PHYSICAL_ID))
 		return -EINVAL;
 
-	if (!vcpu->arch.apic->regs)
+	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
 	if (kvm_apicv_activated(vcpu->kvm)) {
@@ -307,8 +307,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	svm->avic_backing_page = virt_to_page(vcpu->arch.apic->regs);
-
 	/* Setting AVIC backing page address in the phy APIC ID table */
 	entry = avic_get_physical_id_entry(vcpu, id);
 	if (!entry)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 294d5594c724..1cc4e145577c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -301,7 +301,6 @@ struct vcpu_svm {
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-	struct page *avic_backing_page;
 	u64 *avic_physical_id_cache;
 
 	/*
-- 
2.49.0.504.g3bcea36a83-goog


