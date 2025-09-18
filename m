Return-Path: <linux-kernel+bounces-790894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADBDB3AEF4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E09A172395
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7341625FA2C;
	Fri, 29 Aug 2025 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iN8DUsPd"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2025C6FF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426015; cv=none; b=P3Vw6HC3uPA9+L83AWvnJbZxlvSDQ29al/KS8ke7ylSEY4KzVcnMvXS3niZEgaC74DPDtglC7bdWVEBv9C97f8ka8rOkAY8fhfLSM/N6oGR7z/EK6ji2E2yzxRsQYW2G5U8nqkxsQWa+BvhdCeLqaJhZog13eedFDBVWPVwq2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426015; c=relaxed/simple;
	bh=f7lHMZ8qJpaqmwv29QAX2RMeTqQVMVNV4EYMHS+5iLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LqBck1p7KBy+vkzUAR73PYRnWNnsqEx8H5w6KHrT7nkp0R0zCXsPRuM8qhsVOcIs5nhKPfgnHLLSJqxQMsbeXv2U29bb1wgNMEDlN3cRJqCwxmpUBmFyhCm4ui6hnFiVxnsUs76q+0Y+OT5R7tWuClkmnbLSc3l0loPiZMpmQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iN8DUsPd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1372795b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756426012; x=1757030812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UOslP8m3lu4+oiJ697IMjpcaNHz3/4VIfEbOPXSKr7o=;
        b=iN8DUsPdbZ7mO3yl/EoO210QIlp3eCEDZVo+jYSUjCDvzYiR3vQ+K/L3qmOyCfekQc
         EeUXISMgucH7kaP17ZFLcPX79k5MU9v6WOqwEPtSadJrqiX4fA3gW661pH9VVCBWw7HC
         PdNMf2A0uRP1F5Dyg7bgUQXaPygeOuqmxV9PvRkO5psPw849MzQV/iP2MAy6lx/9uBOV
         sF0FNIkWtxPWdapOdSEZiwXuv/fmGDAP15tvgvhFbph4hqTllrcF9LH+aqfBBcOBvPR+
         gqF5/ekHYQU1+CLbSK0H9H/jlubfFhy0nd2/taG792kyPauNQMDXyknqDOmuMIybZ/9q
         T3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426012; x=1757030812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOslP8m3lu4+oiJ697IMjpcaNHz3/4VIfEbOPXSKr7o=;
        b=m3YuDHlC3psvwrIN393qBVCju3yPjBLXCCVy6ztFW3HxXx+H6OuYnDJOUvX7kxY5uf
         gGLafKp1bjIYMrsezcQDi64434heM5IQuThrrkao5goZ3mkNTwqP+RWxim7xCFwwRLZb
         15Tk0xOzSbrSa2hCck3dDj+3tknHx+5z80QimX57jcfqsM+WnPOGhXAAM38vTM2jRvrQ
         O712s8yr6tPv+W+mektuRA38bSaYq5q/ANLtY0SE0nUbcJhjlruYjFR+h/DdWV93FiO8
         uxgb+ArPaW0JWZeJCuTR7wg/O5D/cUIdL5JYj1NZns3PZewfqrbZbxUMpp20rxooIOiW
         jkZA==
X-Forwarded-Encrypted: i=1; AJvYcCWxLRhLhYURu6zbRgIahpa16Bx3VWUTSNQbfsFbdWz5B2dD3Y0xHuXThLY27Z66nueNJkVKLDyUoVik5vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JZCiMkrt8MBiDzrYuVpEGmZofOF2nJFx6TdStaOLkvXzn6wc
	Y+fSpe65ipHgWfDgr+zznx1QEP+NsF4tvaCSe1mutBupM+D02E1aiSkiujqrHhMD01a2r/7w+Nn
	4CYXDaQ==
X-Google-Smtp-Source: AGHT+IGzyu2K+Q3S0JyMe3DS6644rOW4vURK+W47x0/xR9XONWf8AM78cfPpCJTbVijPrA+3JwtyO448ezo=
X-Received: from pfbhg23.prod.google.com ([2002:a05:6a00:8617:b0:76e:313a:6f90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:181e:b0:772:921:e32b
 with SMTP id d2e1a72fcca58-77209220d75mr10908984b3a.25.1756426012474; Thu, 28
 Aug 2025 17:06:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:18 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-19-seanjc@google.com>
Subject: [RFC PATCH v2 18/18] KVM: TDX: Add macro to retry SEAMCALLs when
 forcing vCPUs out of guest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a macro to handle kicking vCPUs out of the guest and retrying
SEAMCALLs on -EBUSY instead of providing small helpers to be used by each
SEAMCALL.  Wrapping the SEAMCALLs in a macro makes it a little harder to
tease out which SEAMCALL is being made, but significantly reduces the
amount of copy+paste code and makes it all but impossible to leave an
elevated wait_for_sept_zap.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 72 ++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index aa740eeb1c2a..d6c9defad9cd 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -313,25 +313,24 @@ static void tdx_clear_page(struct page *page)
 	__mb();
 }
 
-static void tdx_no_vcpus_enter_start(struct kvm *kvm)
-{
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	WRITE_ONCE(kvm_tdx->wait_for_sept_zap, true);
-
-	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
-}
-
-static void tdx_no_vcpus_enter_stop(struct kvm *kvm)
-{
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	WRITE_ONCE(kvm_tdx->wait_for_sept_zap, false);
-}
+#define tdh_do_no_vcpus(tdh_func, kvm, args...)					\
+({										\
+	struct kvm_tdx *__kvm_tdx = to_kvm_tdx(kvm);				\
+	u64 __err;								\
+										\
+	lockdep_assert_held_write(&kvm->mmu_lock);				\
+										\
+	__err = tdh_func(args);							\
+	if (unlikely(tdx_operand_busy(__err))) {				\
+		WRITE_ONCE(__kvm_tdx->wait_for_sept_zap, true);			\
+		kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);	\
+										\
+		__err = tdh_func(args);						\
+										\
+		WRITE_ONCE(__kvm_tdx->wait_for_sept_zap, false);		\
+	}									\
+	__err;									\
+})
 
 /* TDH.PHYMEM.PAGE.RECLAIM is allowed only when destroying the TD. */
 static int __tdx_reclaim_page(struct page *page)
@@ -1714,14 +1713,7 @@ static void tdx_track(struct kvm *kvm)
 	if (unlikely(kvm_tdx->state != TD_STATE_RUNNABLE))
 		return;
 
-	err = tdh_mem_track(&kvm_tdx->td);
-	if (unlikely(tdx_operand_busy(err))) {
-		/* After no vCPUs enter, the second retry is expected to succeed */
-		tdx_no_vcpus_enter_start(kvm);
-		err = tdh_mem_track(&kvm_tdx->td);
-		tdx_no_vcpus_enter_stop(kvm);
-	}
-
+	err = tdh_do_no_vcpus(tdh_mem_track, kvm, &kvm_tdx->td);
 	TDX_BUG_ON(err, TDH_MEM_TRACK, kvm);
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
@@ -1773,14 +1765,8 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
 		return;
 
-	err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
-	if (unlikely(tdx_operand_busy(err))) {
-		/* After no vCPUs enter, the second retry is expected to succeed */
-		tdx_no_vcpus_enter_start(kvm);
-		err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
-		tdx_no_vcpus_enter_stop(kvm);
-	}
-
+	err = tdh_do_no_vcpus(tdh_mem_range_block, kvm, &kvm_tdx->td, gpa,
+			      tdx_level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_RANGE_BLOCK, entry, level_state, kvm))
 		return;
 
@@ -1795,20 +1781,8 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	 * with other vcpu sept operation.
 	 * Race with TDH.VP.ENTER due to (0-step mitigation) and Guest TDCALLs.
 	 */
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
+	err = tdh_do_no_vcpus(tdh_mem_page_remove, kvm, &kvm_tdx->td, gpa,
+			      tdx_level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
 		return;
 
-- 
2.51.0.318.gd7df087d1a-goog


