Return-Path: <linux-kernel+bounces-790883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E018B3AED5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B613F1C81831
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AA1C28E;
	Fri, 29 Aug 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfJcURXE"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65971D61BB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425996; cv=none; b=hjovnYuhA4d3DGWYYmd1KiAAce0M1xGFQhT29+KBCFyaFY1xWEvTxx4NjducwcoGfSmzF90z9/s2Cy/LgZtpEhUrK0pGvV2A8GkuafoR/ajtLayAGm1JEP5hlWPiMOw/J/qYgiVmpNuGA3/wOluXXLSTteJaxV4MbJqSUDKGITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425996; c=relaxed/simple;
	bh=r/3zHVEQRVjjS59stLqVm327G9mTH4dmq7IdLAwoFjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFDSv7vnfPvcZwEgawPSoX1sZtlVEvJ+BcJVXjgMq01xiUqYqQlcNE6mKVYdFEEWLWNrisGjoUq1HK3gFcBPtfq/mkF/INM7viL8R8VFxBw7KilxS9ljWwKBT7EEX92oZTWjRK5KVgOQMqLRlUlUAq70IHZO6mNrD4vpQafFZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfJcURXE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47173a00e8so1188296a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756425994; x=1757030794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zLX9mH2pJ6CieCfe/KZk+xGWiI2ikAnsCO1rb0udaH8=;
        b=rfJcURXEEL7zRWgs4vsrAWmUFw721T3oB7HrjzCmFXDOl1Bwod4vXNvsoPiFnvmu5y
         XF6hyzhOlAte71+iSwcjdLbglpGyrb5dmrwPZpvLJavO0oGJd1pNutM44SOUVKlWjG8v
         Usqt3pa2Hpq6MNaRuiCIV4nLHw26bGJfa2uhs4zXJXD2q11rSO9HfyogtHbcz65FlRyq
         74tJLRny0J5hIG1mh2wpdU1m22LU4tLL+nwbX6gR80/X9xZa9mxl9EKZJxii8qcE0kP1
         5Hwk5W/I89v9bXJVBkarLzk+EAV/iwkRGBb9nc/eKaAJaWq4GWwV/Ybgf/ztY0zQf2ZF
         8JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756425994; x=1757030794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLX9mH2pJ6CieCfe/KZk+xGWiI2ikAnsCO1rb0udaH8=;
        b=mmXswPhvWrTcv5hDt9MdBctIZTnRv1uQNoO5pyC767x1dupltovaJZl3wbdONEZyD2
         Ow0/aUjiF06pyvouUt5g3dsQroZTGZUJHEuPVbIswGZHGbRfTNVhCtRVRcvKHJNMXKlB
         49Gzj8gXrSkSpJiN3bsNwt9oZ1KkIuij+7VZRqAPXqXm8hNCnMddtWrDQ0ZxYt8N/zTh
         GQvmS5S3TW/v/JsKVXbZbMlYCX9670yse5ZbzbOJ0cKx/6g3EfWPNY10edAqgE7q57bE
         0Y04JKEIGVkpzLwyMTR+nObqpPTmxWySNB+kcXLj9EeRq9abp/KAm1OifYvf1Ep1GLyN
         48NA==
X-Forwarded-Encrypted: i=1; AJvYcCX3VcLAoFIDvwJuDghUqZwGNxepaYH/DQcFfLEBZn6onjv237VfOX/GLmzTMgEIw5ThyQRJkQ1hHYfNEC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSC6jjcxVB/Fet73eRdcpekboxsFvcBgLkTey/oRoCyRTHh6j
	QzKlvGrLc9L81F6Gws645dL+y+hhfyBcAGW0et1aojB3MSbgauuAqU5/h8+SX2Y+5gbirPvOjli
	KI3o4yw==
X-Google-Smtp-Source: AGHT+IFYNfjkckW49CdVPG0lAwBRb8biFN/AaTS3cgVRThu+320Td61aGs0d05hkOzNiLg/kzzdXrDa63Mc=
X-Received: from plbmg12.prod.google.com ([2002:a17:903:348c:b0:248:d665:58c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2286:b0:248:75da:f791
 with SMTP id d9443c01a7336-24875dafd03mr143314385ad.47.1756425993908; Thu, 28
 Aug 2025 17:06:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:07 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-8-seanjc@google.com>
Subject: [RFC PATCH v2 07/18] KVM: TDX: Fold tdx_sept_drop_private_spte() into tdx_sept_remove_private_spte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold tdx_sept_drop_private_spte() into tdx_sept_remove_private_spte() to
avoid having to differnatiate between "zap", "drop", and "remove", and to
eliminate dead code due to redundant checks, e.g. on an HKID being
assigned.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 90 +++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 50a9d81dad53..8cb6a2627eb2 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1651,55 +1651,6 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 	return tdx_mem_page_record_premap_cnt(kvm, gfn, level, pfn);
 }
 
-static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
-				      enum pg_level level, struct page *page)
-{
-	int tdx_level = pg_level_to_tdx_sept_level(level);
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	gpa_t gpa = gfn_to_gpa(gfn);
-	u64 err, entry, level_state;
-
-	/* TODO: handle large pages. */
-	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
-		return -EIO;
-
-	if (KVM_BUG_ON(!is_hkid_assigned(kvm_tdx), kvm))
-		return -EIO;
-
-	/*
-	 * When zapping private page, write lock is held. So no race condition
-	 * with other vcpu sept operation.
-	 * Race with TDH.VP.ENTER due to (0-step mitigation) and Guest TDCALLs.
-	 */
-	err = tdh_mem_page_remove(&kvm_tdx->td, gpa, tdx_level, &entry,
-				  &level_state);
-
-	if (unlikely(tdx_operand_busy(err))) {
-		/*
-		 * The second retry is expected to succeed after kicking off all
-		 * other vCPUs and prevent them from invoking TDH.VP.ENTER.
-		 */
-		tdx_no_vcpus_enter_start(kvm);
-		err = tdh_mem_page_remove(&kvm_tdx->td, gpa, tdx_level, &entry,
-					  &level_state);
-		tdx_no_vcpus_enter_stop(kvm);
-	}
-
-	if (KVM_BUG_ON(err, kvm)) {
-		pr_tdx_error_2(TDH_MEM_PAGE_REMOVE, err, entry, level_state);
-		return -EIO;
-	}
-
-	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
-
-	if (KVM_BUG_ON(err, kvm)) {
-		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err);
-		return -EIO;
-	}
-	tdx_clear_page(page);
-	return 0;
-}
-
 static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, void *private_spt)
 {
@@ -1861,7 +1812,11 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
 static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 					enum pg_level level, kvm_pfn_t pfn)
 {
+	int tdx_level = pg_level_to_tdx_sept_level(level);
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	struct page *page = pfn_to_page(pfn);
+	gpa_t gpa = gfn_to_gpa(gfn);
+	u64 err, entry, level_state;
 	int ret;
 
 	/*
@@ -1872,6 +1827,10 @@ static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (KVM_BUG_ON(!is_hkid_assigned(to_kvm_tdx(kvm)), kvm))
 		return -EIO;
 
+	/* TODO: handle large pages. */
+	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
+		return -EIO;
+
 	ret = tdx_sept_zap_private_spte(kvm, gfn, level, page);
 	if (ret <= 0)
 		return ret;
@@ -1882,7 +1841,38 @@ static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	 */
 	tdx_track(kvm);
 
-	return tdx_sept_drop_private_spte(kvm, gfn, level, page);
+	/*
+	 * When zapping private page, write lock is held. So no race condition
+	 * with other vcpu sept operation.
+	 * Race with TDH.VP.ENTER due to (0-step mitigation) and Guest TDCALLs.
+	 */
+	err = tdh_mem_page_remove(&kvm_tdx->td, gpa, tdx_level, &entry,
+				  &level_state);
+
+	if (unlikely(tdx_operand_busy(err))) {
+		/*
+		 * The second retry is expected to succeed after kicking off all
+		 * other vCPUs and prevent them from invoking TDH.VP.ENTER.
+		 */
+		tdx_no_vcpus_enter_start(kvm);
+		err = tdh_mem_page_remove(&kvm_tdx->td, gpa, tdx_level, &entry,
+					  &level_state);
+		tdx_no_vcpus_enter_stop(kvm);
+	}
+
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error_2(TDH_MEM_PAGE_REMOVE, err, entry, level_state);
+		return -EIO;
+	}
+
+	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err);
+		return -EIO;
+	}
+
+	tdx_clear_page(page);
+	return 0;
 }
 
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
-- 
2.51.0.318.gd7df087d1a-goog


