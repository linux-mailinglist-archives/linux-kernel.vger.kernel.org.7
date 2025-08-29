Return-Path: <linux-kernel+bounces-790890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D07B3AEEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C0583378
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99969245005;
	Fri, 29 Aug 2025 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJJcdevi"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C4239E97
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426007; cv=none; b=PVQJlVWXaNZGyjDB07bNbbENscdDTPIix6h8m4k+xzBYHk59P21GArLGsiMjLZox1sEJ1UC8aNCO1zNBwwKtpvl1Jp6nMg6eLE6bJ+7tvi5WgdZfwCS5jnMKf/fj+K/C9eKwFlBekSCnmtBCeNFMu4AQ+ASbaebj7YQufbb3+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426007; c=relaxed/simple;
	bh=Jokid0DO/rV7NnsZCR0z+fHP5XwwBXdL/NPXkdhHIK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TimQB0WMwlINzMLLf57nuI4cQ4fsiKILk3uchY7BFJ27kyPKfWBUTaqAQo9EYiGNNs42aUbgsVDL+eKifZO6h6DJTVWzIkxpw0Y8TB2QKJ6umz7V7k8GQdV+iaOflD4TJNrsVCwf05rkweO9OtWlNHSM1u4NbK08S3nAQpeBk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJJcdevi; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c73924056so512167a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756426005; x=1757030805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=U7cQHpMeOyPtobGJP9EpNG+eqgAlak3ByWO0DfJC83o=;
        b=tJJcdevizseaGw4GX+6mb2XBsSb/79QNcKkntmuMIZRTuv29Zm8cflhsaG6jjzafhC
         8MtXhq5eSmGbY33bKTqsV5Fv0aqHkl1d2DS3C2+lbfKd+GBLsggt87aVa+XrKW1UmJYK
         e/Ij/fdaxQ12lC+pLcyBosYI8EP7CySAohBykfUDk95k/IMJvwz+CE9P3d6CU2nypxSJ
         QbBkUupx7BSRbdYIt0xRfL5xlw+yyiju+D8KK0yr2RidiqEXHG0dY8xImMsjFVzeLmTr
         yD3jS5y2UTTtsQsttPxguly7lWPOLGXaRePV989bjfQWnDLbXg4OOQ01YanbicuSM2IK
         lMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426005; x=1757030805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7cQHpMeOyPtobGJP9EpNG+eqgAlak3ByWO0DfJC83o=;
        b=EjgRuMb+6Bn8/L0Y34GJJVg8ngZW2jPmqJaNPiTff8QUgPEEwyJ80emVTzUiBZboMm
         q0lTRbBSqbYbiLepCCWud71yUKLRi9Cfg5y8EvOlELszP0OjDD6TkeMGJQil/raGngaD
         B2Jvi79F2GD/SmkbM1gHbYA2VLVTSd6KsP+1GMDCJeTWuLcMjh4/zboPBZ6SdJanM3Fe
         Zewp6G6lvKgqL+NOrvf/kYf/L8I0BrLxDjm5cJFEfCMp4Kh9FU2pB4AQpcx2tbJA49K5
         vJ0VJOEqOgIF9/EuU0hcqp7af2H1H7IEBpsEU3teyz0krz0+zloq+sS9LCTjC3M9iigC
         TmLw==
X-Forwarded-Encrypted: i=1; AJvYcCUIC2xhXLXIFLXL4TahIa/Vw4XXE4gAlH5FUVSjwkMTV5YmtjhlJdyidgGoh/qOlIiMcJJAcZTLdXD81zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1inGouiGgzeh1BlyWR773iwwTkGfOqnNlds6t4SgCF1AUM3z6
	pqF6FzYeCaLstiO70ZSRQGLXnVJJBlkE3hya9NLrOwkPWXDA14HVOJAI6dyI8NkwcNPuTN/qrG0
	i+KlZ0A==
X-Google-Smtp-Source: AGHT+IFUjUY1nfQcAvMaxHbMyGGpEn+Y2J7C9qldGHayAPHPs3JLhhD2fMtARg3auKDuKGakE4vLVFSBP0g=
X-Received: from pfbjo20.prod.google.com ([2002:a05:6a00:9094:b0:771:e6da:3861])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7347:b0:243:b190:d139
 with SMTP id adf61e73a8af0-243b190d746mr5814517637.39.1756426005459; Thu, 28
 Aug 2025 17:06:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:14 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-15-seanjc@google.com>
Subject: [RFC PATCH v2 14/18] KVM: TDX: Fold tdx_sept_zap_private_spte() into tdx_sept_remove_private_spte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Do TDH_MEM_RANGE_BLOCK directly in tdx_sept_remove_private_spte() instead
of using a one-off helper now that the nr_premapped tracking is gone.

Opportunistically drop the WARN on hugepages, which was dead code (see the
KVM_BUG_ON() in tdx_sept_remove_private_spte()).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 00c3dc376690..aa6d88629dae 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1682,33 +1682,6 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
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
@@ -1789,7 +1762,6 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
-	int ret;
 
 	/*
 	 * HKID is released after all private pages have been removed, and set
@@ -1803,9 +1775,18 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
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
2.51.0.318.gd7df087d1a-goog


