Return-Path: <linux-kernel+bounces-790882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E97B3AED3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98D317AD21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC81C5D6A;
	Fri, 29 Aug 2025 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCd7pOGw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB131A9F80
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425994; cv=none; b=SRPcp7P8vGYUoPZXipjfwibCIGRtDHXs5v9opA7Qr5v8GSDXYC+Ub5t41kzFHksLA5/q5OxG9YnF6B5qYC0vtwp/ZVUKAOREqYLJFY9Gnx6S6bHoQiDRT2cjADv2XJcX56jrmSjTir3Uq0QxQHGKZu3QoEr+wZtQ+UIIuW5PK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425994; c=relaxed/simple;
	bh=guMBlrm/rcFiyVpqt0hr4LlDYx3tQGzdjshtf5uFvKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ay67DMK8nDldLWXha4jHh7NVuqMXfm4Gx82ajQemCaSWcU4bB5ia0xFJmKgCD6wcRPXuLzgLTw9eIP9YE/x6QBRaLGthkM4t1C7hUGUtNVRhGHlvh13DegqXDVq+87oWRHCkkwDikllEJkZwAV7fHymCsRgm4LmM7bHQf60h3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yCd7pOGw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-771e4a8b533so1434123b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756425992; x=1757030792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pc+C5r9UxosSdMvNvv24ZE703L5ZdmGhUK9UzcuK6dE=;
        b=yCd7pOGwWQVHc3T8jDXWjaOQEvGvz2haegZuBWqdzMNHUqizvtOYi9EmzkRDU4U0lH
         bvzfB7EwvnCSzREPtP4YRB8DHa20BeDiQBtkhbAzJem1hMh9xAGpqgWAJJ+a3XyjNhpr
         Abc6IPZAKoJOQdiJkdiNPsNz0i09/ArKyYPT3UP1mBAIvzJyXJKbxP0pFVDPE2ZSghIP
         IZj0hZ1jpafRXfBBHtSfPHz0WORJBs5i1RTs051wIFQ22mWQRUy69sTP7YLM3Zak/nP6
         WlWdiC1gBCOCmPHodNFHqfn6bRfLmA19SvKX0v7u8zz9yNZvwceIcyTW5j67fWeBxdHE
         i9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756425992; x=1757030792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pc+C5r9UxosSdMvNvv24ZE703L5ZdmGhUK9UzcuK6dE=;
        b=CgWjWgnNaXcsSpMKFyRDG9U0EmF4huFElZmZXt+0FOB2/DSJCsm2njMYio//Df3Ajp
         J/PgJUWKUC58qcxfZ5ATJbsK0c7t+0KpddzAHrtt+7aXsWz4d55JBHrdPq6BHhCjgqxT
         ZuUAmra9yQpPzAlpj8uAQ+0cD2mN7Vs+5ZIVaI7JjZnlMrpSiVQ5R/QxpWYXLwOSodFP
         SQkJ0U5R5+BNR8FNn1NLl66CSyn05dl0A5byTjvSAguEHg1tClmBoEbH3htQtSq+kV3e
         8wvG5uh+AQsyKbUm32BG+zVOQwzzU5g+p+IPSwzHoGh1PvQea3ow/WwLXwiB6F+lOqW4
         oaRA==
X-Forwarded-Encrypted: i=1; AJvYcCWGZ2Ac/QY6KULl3g8loJigQbsfYjn7vxjZoUsJF09+VYVgeHoPgi25mVADU7Y9QEnDtXu6kpKr4F0aXWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUEF/21W2WCogzNuEmU0Zd7lONCEKMMwqKPa6p+8gLqa2JbC/
	ibYd3fq4ZnZ0NSItoU8FMs00E0SZlZ24jF+o1ui3z6M9X0kagX3MkfKF2EbNKxwxUX/bnySsVLO
	4/y+ZCg==
X-Google-Smtp-Source: AGHT+IGsQEGpqIkG4palZicWIZvUBh20hOQat16whhSvJD3x6nNIGewZDiu5LE2a2PmQKQicnX6o2AzYyqk=
X-Received: from pfbca20.prod.google.com ([2002:a05:6a00:4194:b0:76c:4298:869f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:88b:b0:749:bc7:1577
 with SMTP id d2e1a72fcca58-7702fa4f67emr31500813b3a.9.1756425992004; Thu, 28
 Aug 2025 17:06:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:06 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-7-seanjc@google.com>
Subject: [RFC PATCH v2 06/18] KVM: TDX: Return -EIO, not -EINVAL, on a
 KVM_BUG_ON() condition
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Return -EIO when a KVM_BUG_ON() is tripped, as KVM's ABI is to return -EIO
when a VM has been killed due to a KVM bug, not -EINVAL.  Note, many (all?)
of the affected paths never propagate the error code to userspace, i.e.
this is about internal consistency more than anything else.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f24f8635b433..50a9d81dad53 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1624,7 +1624,7 @@ static int tdx_mem_page_record_premap_cnt(struct kvm *kvm, gfn_t gfn,
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 
 	if (KVM_BUG_ON(kvm->arch.pre_fault_allowed, kvm))
-		return -EINVAL;
+		return -EIO;
 
 	/* nr_premapped will be decreased when tdh_mem_page_add() is called. */
 	atomic64_inc(&kvm_tdx->nr_premapped);
@@ -1638,7 +1638,7 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
-		return -EINVAL;
+		return -EIO;
 
 	/*
 	 * Read 'pre_fault_allowed' before 'kvm_tdx->state'; see matching
@@ -1661,10 +1661,10 @@ static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
 
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
-		return -EINVAL;
+		return -EIO;
 
 	if (KVM_BUG_ON(!is_hkid_assigned(kvm_tdx), kvm))
-		return -EINVAL;
+		return -EIO;
 
 	/*
 	 * When zapping private page, write lock is held. So no race condition
@@ -1849,7 +1849,7 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
 	 * and slot move/deletion.
 	 */
 	if (KVM_BUG_ON(is_hkid_assigned(kvm_tdx), kvm))
-		return -EINVAL;
+		return -EIO;
 
 	/*
 	 * The HKID assigned to this TD was already freed and cache was
@@ -1870,7 +1870,7 @@ static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	 * there can't be anything populated in the private EPT.
 	 */
 	if (KVM_BUG_ON(!is_hkid_assigned(to_kvm_tdx(kvm)), kvm))
-		return -EINVAL;
+		return -EIO;
 
 	ret = tdx_sept_zap_private_spte(kvm, gfn, level, page);
 	if (ret <= 0)
-- 
2.51.0.318.gd7df087d1a-goog


