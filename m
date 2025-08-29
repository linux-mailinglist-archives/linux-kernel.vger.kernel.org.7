Return-Path: <linux-kernel+bounces-790886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E50B3AEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CFB7AE108
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0388322256F;
	Fri, 29 Aug 2025 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWNrXZTC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A367217716
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426002; cv=none; b=ZjXzBqsjb861zPNwx/bgcshnnOj83AvfShBwTrPUsdkFyAZjK6gEuL9HEGW+AMfoQyGJhGM2erH7eUBUTQiQkloasr4RuDXQVQDGLJTWuGVP+rtSj+gUXjbGcKaNSRgMjQcrf08agGbZBN3e3+FQc7DWdPy2+Aaf5JZtcQ25ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426002; c=relaxed/simple;
	bh=gyZpzdfigGs09+ImBbJAsRRHU5xktCFn0Yw4iaqicyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAD5gstW920EieLdFGG9aCWauDH+TLd0SEtDgd0CKmLauFBjJeLDDcruymAIYifP3ajSl0vCRA5u30sCVQbKqTp/YI6mfA+W7t8XUbA0UiT97TRQggkW3cF9tNl9CHquim0GxmosR9YeGtgGOFNA/uGvbc6vF+XqCwRq9wl9FA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWNrXZTC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3276575ae5eso1598871a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756425999; x=1757030799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwIMlaifmPTtVhzroBYxRLA8wwFTYLN4Sjt92uj7DWY=;
        b=iWNrXZTC+uVaaFU5eSNGiMo0IzTNPcS0L0iY8hZaoiECryVm2Fb1XWas14NZKUsBEz
         vcmHqQJ3MegEnZaP318JkRdsKWGoSLVIxvu7DJaEpTirImAZXgdX+RRpQJ+QHgFcCdwb
         7Xr/BUnezzapGgp/cwDCZ+oJ8ZFGffg+bKRh0UH4Y/whrNgi5H2q7NlI1LHNmsZApVhl
         VO4VbsnycnuqMgJ3TrgGkCn5vit9DAqQC4ImI5BoVxHbfg6guWV3bK9592HtOdnXz1YA
         GSjP3IT8g4vsbvn5asAFPvYJqbfWbDxM+aJJDZqo1XISUKLl6QXcUBb8xaY5JNqC9t11
         jBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756425999; x=1757030799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwIMlaifmPTtVhzroBYxRLA8wwFTYLN4Sjt92uj7DWY=;
        b=k7DHZqY1jUHjX2b4jgER2GY5XrN5R7QqOKKd/XZsz9j+fk4S06dCprTOGDyaiPgYLB
         Oys/Y9J5wfmxAKXmSsrIlJX6v/ML9iB6uO/506MdB5Yo8itnFObhkj1aQEJiGK0d+AOZ
         LsfvbsKb3nHRnSnhq7hW/Nb9ArZP0zrRSBsCeTkvNHc4e8tSAQMK80VuaQdtPrnzpETN
         oIherFcIPVEW41TFihb+XSiYAhxgrXTOBZP7hiZSIcyjgXCorOVsmS8dRkUmPbphhk9B
         ZmkUsCpO/UOTJxeqwMLpm52eYCZLwbluimdTnHS1Vefep1H2XWHUNYNd1B1dRzNjIXNV
         g8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXTFmlj7lITXbWPXuKqPQuTIqNoJaZPl7eIGEILiQoZHevyfLSk6umEO1rq2TsH2h/lHronzOKxTnkc5sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jtZ8NbYsf3G86RBFx5skoL7+kQmW5hSK2JCM4bjWoyjNt2B/
	DRkeYA1ESZSkJdd9SzNYfpcFRl+hYPeO0EvcfjPODtl0GuX3Sghw7Dz5CmdxHrMwra7ztA7we5E
	9Pq2wtg==
X-Google-Smtp-Source: AGHT+IF5M1lm57K1T4cESxSZmN/2EWRqfoLHHHsMaumxyGGp3Yd/18q0BTU+oBYQUA0CJrPoD1MkMyVS590=
X-Received: from pjbcz5.prod.google.com ([2002:a17:90a:d445:b0:327:50fa:eff9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c06:b0:327:e59d:2cc2
 with SMTP id 98e67ed59e1d1-327e59d2f16mr639721a91.10.1756425998989; Thu, 28
 Aug 2025 17:06:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:10 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-11-seanjc@google.com>
Subject: [RFC PATCH v2 10/18] KVM: TDX: Use atomic64_dec_return() instead of a
 poor equivalent
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Use atomic64_dec_return() when decrementing the number of "pre-mapped"
S-EPT pages to ensure that the count can't go negative without KVM
noticing.  In theory, checking for '0' and then decrementing in a separate
operation could miss a 0=>-1 transition.  In practice, such a condition is
impossible because nr_premapped is protected by slots_lock, i.e. doesn't
actually need to be an atomic (that wart will be addressed shortly).

Don't bother trying to keep the count non-negative, as the KVM_BUG_ON()
ensures the VM is dead, i.e. there's no point in trying to limp along.

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index cafd618ca43c..fe0815d542e3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1725,10 +1725,9 @@ static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
 		tdx_no_vcpus_enter_stop(kvm);
 	}
 	if (tdx_is_sept_zap_err_due_to_premap(kvm_tdx, err, entry, level)) {
-		if (KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm))
+		if (KVM_BUG_ON(atomic64_dec_return(&kvm_tdx->nr_premapped) < 0, kvm))
 			return -EIO;
 
-		atomic64_dec(&kvm_tdx->nr_premapped);
 		return 0;
 	}
 
@@ -3151,8 +3150,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 		goto out;
 	}
 
-	if (!KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm))
-		atomic64_dec(&kvm_tdx->nr_premapped);
+	KVM_BUG_ON(atomic64_dec_return(&kvm_tdx->nr_premapped) < 0, kvm);
 
 	if (arg->flags & KVM_TDX_MEASURE_MEMORY_REGION) {
 		for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
-- 
2.51.0.318.gd7df087d1a-goog


