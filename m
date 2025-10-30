Return-Path: <linux-kernel+bounces-879066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D834C222F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE48188F917
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057AB393DD4;
	Thu, 30 Oct 2025 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcQq5mPi"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3C3855A8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855045; cv=none; b=JDgpUGx5ZWSsei25Ulh+2EktOHvDvPgc0KVaeLtoJ8zebNtdcTrQdTNpibDiO6YDYbKPxI1MF/zfHGXfyy0MaanXtf1QEkTVc1rzl5TpPvySZ7cMRU+b9KDjnI0M6lxtshwuhblgkT2eO8inInS1zwTl6aTdJs38i16BEDyx8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855045; c=relaxed/simple;
	bh=chQz73w4sDaVm3u9kl7kGYcKIA2cugXbhH5x61ROvUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BA8bmB637VhVIAG98Q/ZkiTQy03qbrDi0Y6uTtbk2eMLD3A7hdk4hcU6euQEMyfR5YOEn7n8GSzCThTEhMrTFrQQgDthVRXRSSbseE8yHIstpUYT5Rq/U9bb6GUQNngPonuX8+YMc6Y/cxLpeL/vZbOf8T9/rmRlPnCKEkFhD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcQq5mPi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3408d2c733cso57748a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855043; x=1762459843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NXaPi3MoPrN4063cnb5uQMVDinJuo4gq6tPJoc7Otx0=;
        b=rcQq5mPiZuYrNEL1J06D+UkT/6HNu/oL/xIr99L4t7Z0WktHRMxh6SJZmCpYW/Gage
         WsxEka/8w6+WhKHUsv+ViDYtnLl+S94QHPlm+nBpatt12spLdgMB4pPgfCfWQPaBEXnh
         Gp3M4VyzbqUGTPu8zpdG+ZeeynBU9WrGAmz44PIvCPwzRdShJWbvWwTZdSOdXuBPKwc7
         T1bCDoR6BQp946WTzo8slPrb+FTUm+Kclf/NWgpoAyXE1NGpqhn22QZKk9seUTp4GZDh
         fDMm1avFqkXZsBna+AeW04CoyGgWlYSwYTyUt2xCOiaQYUT6yCmQw2McLohW3hEHqGkX
         ZqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855043; x=1762459843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXaPi3MoPrN4063cnb5uQMVDinJuo4gq6tPJoc7Otx0=;
        b=HKEGh9q1d9p82UpTjcG01TE69vKB5zeaSHWB8MFtFygOBrDj+C7BHDcW14/Ha735S/
         KCDBpQbdyON+o/DXOZJ6uBTKLTpcUYpQOg6NHsil+CCTb9peiwORC+b6CBbq+mxEOKUF
         fXM1uHQFfh0oWTvwawNGFKgGgAJMD1wk+ZqvIqIhtrCIbU1fXWSiH2YgN6m8cy5MO3c+
         fkEh86Zpoqn8qwoSiNUKNOQ0EXrlFxa3k4R2yp7SlJ6yY1DxfbO0EeSLnVto6VuKoORI
         qiZJgrnhZMhwqetqGdQ2AYH4aM2Dj/I0BwBQGZU1ZfPo6Gu2Imx43LC3g3H0FtfKznsj
         nbEg==
X-Forwarded-Encrypted: i=1; AJvYcCU99QBufLNNs/GwhdLQ3tNislr28+jUy1vbvoPZYDPuyXPd+gam875rnobiQjRD1kcG3a9oiO4GfO3tMYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkXo22A/v+Uj9xcW6OBnXPsalkqMepOsdl1bIiTbCVXOhoCCP
	N22TV342CV8x2bSza+WzymLl5ALJ4FDskXSSyGnn9SSMCzGjw6d11fBqKOJCWausASOCMT8BkRG
	wKY7G2w==
X-Google-Smtp-Source: AGHT+IEb/219Cf+wyRyoeh6pXELuzrJXroky0oVjoU6kkNSExiZe/MRoYQlDKXB9iGMeGWIkzSQ16EMgROI=
X-Received: from plrs24.prod.google.com ([2002:a17:902:b198:b0:269:b6ad:8899])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cf:b0:293:b97:c30b
 with SMTP id d9443c01a7336-2951a3a6519mr12248475ad.9.1761855043356; Thu, 30
 Oct 2025 13:10:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:40 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-18-seanjc@google.com>
Subject: [PATCH v4 17/28] KVM: TDX: Fold tdx_sept_zap_private_spte() into tdx_sept_remove_private_spte()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Do TDH_MEM_RANGE_BLOCK directly in tdx_sept_remove_private_spte() instead
of using a one-off helper now that the nr_premapped tracking is gone.

Opportunistically drop the WARN on hugepages, which was dead code (see the
KVM_BUG_ON() in tdx_sept_remove_private_spte()).

No functional change intended.

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index cfdf8d262756..260b569309cf 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1683,33 +1683,6 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
-static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, struct page *page)
-{
-	int tdx_level = pg_level_to_tdx_sept_level(level);
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	gpa_t gpa = gfn_to_gpa(gfn) & KVM_HPAGE_MASK(level);
-	u64 err, entry, level_state;
-
-	/* For now large page isn't supported yet. */
-	WARN_ON_ONCE(level != PG_LEVEL_4K);
-
-	err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
-
-	if (unlikely(tdx_operand_busy(err))) {
-		/* After no vCPUs enter, the second retry is expected to succeed */
-		tdx_no_vcpus_enter_start(kvm);
-		err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
-		tdx_no_vcpus_enter_stop(kvm);
-	}
-
-	if (KVM_BUG_ON(err, kvm)) {
-		pr_tdx_error_2(TDH_MEM_RANGE_BLOCK, err, entry, level_state);
-		return -EIO;
-	}
-	return 1;
-}
-
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
  * tdh_mem_track() is the only caller that increases TD epoch. An increase in
@@ -1790,7 +1763,6 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
-	int ret;
 
 	/*
 	 * HKID is released after all private pages have been removed, and set
@@ -1804,9 +1776,18 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
 		return;
 
-	ret = tdx_sept_zap_private_spte(kvm, gfn, level, page);
-	if (ret <= 0)
+	err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
+	if (unlikely(tdx_operand_busy(err))) {
+		/* After no vCPUs enter, the second retry is expected to succeed */
+		tdx_no_vcpus_enter_start(kvm);
+		err = tdh_mem_range_block(&kvm_tdx->td, gpa, tdx_level, &entry, &level_state);
+		tdx_no_vcpus_enter_stop(kvm);
+	}
+
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error_2(TDH_MEM_RANGE_BLOCK, err, entry, level_state);
 		return;
+	}
 
 	/*
 	 * TDX requires TLB tracking before dropping private page.  Do
-- 
2.51.1.930.gacf6e81ea2-goog


