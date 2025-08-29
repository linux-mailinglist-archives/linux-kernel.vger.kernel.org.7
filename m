Return-Path: <linux-kernel+bounces-790877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BDB3AEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2624B1C271AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EFD374EA;
	Fri, 29 Aug 2025 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1vp0yqU"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEA4C9F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425985; cv=none; b=FdxPA/nfHAPqbmIXCtsMwJbKwAxjaGouFLi3PSGBlSmaFbZdDmj3mOK/DqqWwsi2CpXfURDR9vYIea2u4eUrHmrlHwHrn9FOGVVHKe96/QvH6HBxMkKDk4grxKRKgPxs06kvKvupjMG+fu9Am9X8UM9f4sYq2TR8wgv73HYbVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425985; c=relaxed/simple;
	bh=wOBgvXCRAiu/hoH9lp/TtNCi0CROexOvvzcS9prFsj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cm9LvAG6C8nPChb3PwgVALLg0rGn9wTcBS30XprNrhMpH9rqoEHcZ3IIt9mXBG7IzPdoSSvCd4nC9NLaLo81/+1EiEtwyKlGj/RROXZd38YTWc3DptI7lgErlr8gfhBa3L6RMDlzadnuCvZzMaxnKQY5ktczkBJBhnvQ6cFMKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1vp0yqU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so2145700a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756425983; x=1757030783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kN41JsVo/+Hu/VK2aKospmiW+UbLhaUfceiD5wkfXWs=;
        b=K1vp0yqUUiN/qr4DCsm5pByzKTi+rEbuhoPIr7t+74MbpeIYEZDF5FkhoCP8p70VXw
         2evsGbgOw+dtQXKM6d4cvPdNony8kgPnzcJcbEbzrXehJGSGXH8ehvJgHJU65CMRgHdS
         Wzy8e38BzoVJLsSNpS09Z9zjIJoi+PQhVY2TR8M/QGdgbDvs/RrJnL0A4+MxV109LSV6
         aj3KdWGV9ZtXv/VzshqLZbyvHEuU5X63YApev96A+G77WKL28iUs/QM5Ta6hJOaRPeiK
         uDH+05HzDV/onIqx2UvAu/5PB+d25dVuIJD+0Y6X7WAExE5uZz5QO/VgmwEQS2HNJpF1
         jnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756425983; x=1757030783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kN41JsVo/+Hu/VK2aKospmiW+UbLhaUfceiD5wkfXWs=;
        b=XuWRlORkIjtr8sbx/iKC41hGP4d55S/MMKOIUOk8B89jrDIDkYHUXO+Ej/q7puy4xk
         8Pek4XdCoMERQPiuE/BwU6ekSi6K06jje9xflvi2efSyJoKqwkNk/smFKLbxtXrG2+XG
         fSLK7SEEMDM5Vr7dhvrqs7OL9kgoN1Hhbf/Iq9E8z+Gr3X+cNf7j+1gU0n23+W0DJoY2
         mO9p9BwwLi9hbPwQhDTcBh1XIWXWFYdAblDJwh0tICHaDloCoks4ML2HcV9A2lH68zfN
         BoE9FbwybNIRiAIC0kFR7JmwX7MiS0zd+sjWEEmuiVwmLwezmBaaQgAXyTDTHnHuDznz
         RCKA==
X-Forwarded-Encrypted: i=1; AJvYcCV+DrPV/bz2dg1D6YWLDg3N//HboHfASfUnnWBbSF3lGzOhlnYdcr98Xxtmp/8jLiZwpPtSYhXUVI+aQP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqoc/GbgtdV0ve25bql+IlwrX8p4R0FOC3fmwWHW5EpW9lbBZ
	YEZ8k3edqUBAgq058a2Hme+ejX8Axgalo6lnlepTRoHDxb2GCWk0Ad1Sx75CIHUhpe4iJljusxP
	7JJr9jg==
X-Google-Smtp-Source: AGHT+IFvRGkDVD9A1RgamItKrcAi4g0yGHO3XYJeIxd/1I7Yw9nU5hV2wzRGP2NL4PULhLR+r74hxCnLI84=
X-Received: from pjbpm6.prod.google.com ([2002:a17:90b:3c46:b0:325:238b:5dc6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1591:b0:243:a21c:3730
 with SMTP id adf61e73a8af0-243a21c3b63mr10436147637.31.1756425983578; Thu, 28
 Aug 2025 17:06:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:01 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-2-seanjc@google.com>
Subject: [RFC PATCH v2 01/18] KVM: TDX: Drop PROVE_MMU=y sanity check on
 to-be-populated mappings
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop TDX's sanity check that an S-EPT mapping isn't zapped between creating
said mapping and doing TDH.MEM.PAGE.ADD, as the check is simultaneously
superfluous and incomplete.  Per commit 2608f1057601 ("KVM: x86/tdp_mmu:
Add a helper function to walk down the TDP MMU"), the justification for
introducing kvm_tdp_mmu_gpa_is_mapped() was to check that the target gfn
was pre-populated, with a link that points to this snippet:

 : > One small question:
 : >
 : > What if the memory region passed to KVM_TDX_INIT_MEM_REGION hasn't been pre-
 : > populated?  If we want to make KVM_TDX_INIT_MEM_REGION work with these regions,
 : > then we still need to do the real map.  Or we can make KVM_TDX_INIT_MEM_REGION
 : > return error when it finds the region hasn't been pre-populated?
 :
 : Return an error.  I don't love the idea of bleeding so many TDX details into
 : userspace, but I'm pretty sure that ship sailed a long, long time ago.

But that justification makes little sense for the final code, as simply
doing TDH.MEM.PAGE.ADD without a paranoid sanity check will return an error
if the S-EPT mapping is invalid (as evidenced by the code being guarded
with CONFIG_KVM_PROVE_MMU=y).

The sanity check is also incomplete in the sense that mmu_lock is dropped
between the check and TDH.MEM.PAGE.ADD, i.e. will only detect KVM bugs that
zap SPTEs in a very specific window.

Removing the sanity check will allow removing kvm_tdp_mmu_gpa_is_mapped(),
which has no business being exposed to vendor code.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6784aaaced87..71da245d160f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3175,20 +3175,6 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (ret < 0)
 		goto out;
 
-	/*
-	 * The private mem cannot be zapped after kvm_tdp_map_page()
-	 * because all paths are covered by slots_lock and the
-	 * filemap invalidate lock.  Check that they are indeed enough.
-	 */
-	if (IS_ENABLED(CONFIG_KVM_PROVE_MMU)) {
-		scoped_guard(read_lock, &kvm->mmu_lock) {
-			if (KVM_BUG_ON(!kvm_tdp_mmu_gpa_is_mapped(vcpu, gpa), kvm)) {
-				ret = -EIO;
-				goto out;
-			}
-		}
-	}
-
 	ret = 0;
 	err = tdh_mem_page_add(&kvm_tdx->td, gpa, pfn_to_page(pfn),
 			       src_page, &entry, &level_state);
-- 
2.51.0.318.gd7df087d1a-goog


