Return-Path: <linux-kernel+bounces-787409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99FB375D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52531B677F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636251F03FB;
	Wed, 27 Aug 2025 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cnehlumx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A91DFD9A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253136; cv=none; b=kkS0xhah+zG/huAyXdeQkwp522Nf4XlaIzxIj0OwNy2qRGPzKOIDiOiNb3qjfP1iUYUw9aiAXTwyf/tphVvU7OkyruEZCwE8nRlw8mwCfPRgoR2n403xkFiCnNmCGb6n9YEscjdR2yD3p9Kv/5nLfsXSWPW8lDtMemAahbHLNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253136; c=relaxed/simple;
	bh=cqqucMYtivTxgJ2yWtjMcM5NpaFOO1MES3223ug0X4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=khBteVXUS/2GyYo8MlYp7DLcveURfCT/j9ODQS1wlXSxCy5MoBeSOSbaba84wF28Qw2BveSB+Fbu6mfVXJQQxxTp3Q4Vp2uiX8fAzkfSUQ0jxxF1aly+jUsLS2bTeZBCN1PdUAQRv4izDLe8vg/smjTS257YiqjrhItARY7G8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cnehlumx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32771335ce6so68259a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253135; x=1756857935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oGCmox8NCxkTSpPUlLKTfWHUVoiysl+0iyU32s+8vBE=;
        b=Cnehlumx5usGz9bDM7tH+A9BsThIbDUwO9/e6cwD6Sd48sx1Sv8jqgKm0aSrTlfVPF
         TS1T7PcgcInnBxA1EKivFEdk4+nUXBUuQq2xzvKr+XcKpZ1rcUxpm5GA+ks96mOj1ky0
         SlmnBke0dt2bqy+2vLPd+5V0EF1TmeH8ZYFAzKxgddP4+I1ybNnYaNDKZdx8qKLAYbRJ
         6rzidg/0wvS2Txyzv9P9yfxbLKJobKv82pfANzJS34vvDSt+mVp2gqDbyTvltjGq76Pz
         2/gbhzUkP7Kz7I/HizUZ9pOPZ99B4l/70uoOvSVcBqvHPDuKuSTykzOdkufU5DVyhw+H
         ms7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253135; x=1756857935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGCmox8NCxkTSpPUlLKTfWHUVoiysl+0iyU32s+8vBE=;
        b=W0M4cO7oexujzkp6p2i1RQ8gvdYilnMYH6HDKG9kwD2IqgaCLbElWJUQpufrEcqPqD
         hPoDHFQMNnPgBO9eX4Y7h7hSSYgQXHpIlKMN4eEeeFQM6s0bCB2IdteXLS40WHyTiEyR
         93TVlajhbcHM7ccX8NLVxjs2wYH6xs7oRRre0S0v0KvD4suKmc6kVK34phalsy3cJ7hy
         cYg7/FvXdfYYOU8pFa99bG37bbyx117aN8Gp75RFQs426gD1TE6Y+Kn+fmlO/YctKJa7
         0gLynvARm4cPjF2YWfIeigNpEwmluKj7BK65Ef6y2vq2foT9i3FxK+phiXgCQvqfXD5I
         /a4w==
X-Forwarded-Encrypted: i=1; AJvYcCVn4Ly9Lr6O/AKyBwIzVQPXtxhMqaW1Nr+d8ciaJX8C9F81Tn1868Hp4iBveI7aOBk0SB8S4AL94gA9PWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywplb5bxSWFCfjxxvxIo7ERPX/yLNSphceh5UQQGRE6TR0iG6Z2
	tptDWMuRmgfWguXGpcZj2HOq/CXAnEbkkutkE2t/JSNlFviFwZtHEw7U8mvOnTQjoszsJTK1FAy
	Jx1K4tg==
X-Google-Smtp-Source: AGHT+IEYma5Tgh82jGLGfJfLfmhoqHyeRAhaK0BUFIBNQaa0nt6VPuBWzXcFJlUAx1BFZPkgbXKo0snHV+0=
X-Received: from pjd5.prod.google.com ([2002:a17:90b:54c5:b0:325:8ff:2ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5787:b0:30a:4874:5397
 with SMTP id 98e67ed59e1d1-32515ef215amr21922120a91.9.1756253134805; Tue, 26
 Aug 2025 17:05:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 Aug 2025 17:05:16 -0700
In-Reply-To: <20250827000522.4022426-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827000522.4022426-7-seanjc@google.com>
Subject: [RFC PATCH 06/12] KVM: TDX: Return -EIO, not -EINVAL, on a
 KVM_BUG_ON() condition
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

Return -EIO when a KVM_BUG_ON() is tripped, as KVM's ABI is to return -EIO
when a VM has been killed due to a KVM bug, not -EINVAL.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 9fb6e5f02cc9..ef4ffcad131f 100644
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
2.51.0.268.g9569e192d0-goog


