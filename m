Return-Path: <linux-kernel+bounces-787412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A88B375DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3091B6798A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17498217704;
	Wed, 27 Aug 2025 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cucoU5+S"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3394201113
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253140; cv=none; b=mSD9v/DgdQ6xbEA3wvTwDQyzURqTsJQr17bmSRk1u/E3xtx0pD40xDAbx60CWR+WH/Qz7J2UYKAIkzRVyYVGBiWEy6IHeEmBNk2fV625jyaoWs4hwVmGJTppU3YhfI/XNFCEUw70D9Zrq/x1R1aaUTz+T3YoAHZ9kUiSzE4gR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253140; c=relaxed/simple;
	bh=p5u10Bzkcywp/4GKkqpJgCa4qZjbXShDD0LksyC8ZDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mh/RqWKh7KADbuywe9rKxfs4ZYPVbKny6lXC+krblDvgHpSZQFAGnBfzwIra5M9XAAAoroZ/eBNUJKPOi8PhZ3L6nbjPMkJi+MxOpGw9ASvsrlGlTQdWbkgWkN7S3k3HQbxU2yqm+g+1pps59S+N8sMnPc43GWuHm/mlSEPcHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cucoU5+S; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3276575ae5bso551088a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253138; x=1756857938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7ErZgDOXv/jSDGCKcnbfir/yGG7t/FklW7bhCH57Uhk=;
        b=cucoU5+SFu/ZdcVSHz68vba8Z38GgiaIFjDjahNnLpXJ9nmDJt9cKDzv32/QtwJrqu
         gXyhd+lHgdUL3PDkYhrWEd8OiaRRFGwulUivuyolW79DO+nqNI59kumtm4TkLI3atfBj
         o+xdPVAoIZXubfGltnjgRV8qnLZnXCZXM7OFvhgYOTrNeKhdJGgNZdbrgck/29oKLcg2
         4RHG9d6tt4qAUHgWYXuYHwmKZYYw3/3AjWCsh+D/YdKdzat1ODznoEZSbNRiXxWeTQRB
         ONs7IqvBLH2DrEtXulni3TdrL810cVGj2T7uJjTlisle3J+iL45608TkkQxU67bVQ9Im
         KzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253138; x=1756857938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ErZgDOXv/jSDGCKcnbfir/yGG7t/FklW7bhCH57Uhk=;
        b=LaLTHHUTjxhsSIL7HZWzh8DtWBRStclYDPW6aHFUPZHGhYX6zRh36H4fmfcMSNqYJd
         2cypS/OtcPSJdkTj5cgQXkEtbluoaQiJUo7blgpdkQcD0yo3vEnwUxNGo6ZU8Smp7x7J
         f3iuKDPh2alGeWtn8117N7ah15nKtqVCsKJur5AyZ+9VUKSPKE4Zgjfh5V3kh4scJhjQ
         ykEosF/VFXXXXJ2x28G7sMBTY/ULM8/tevleq+4H0FlDQi2y65UcgE+5qfcCp9gOioum
         oqmkcj9VrCeArFgspuTY78hfNVplXi8QbtJos/Bsk5equPXJNsGUkWbp4MGpZpoaIBEK
         QTTw==
X-Forwarded-Encrypted: i=1; AJvYcCWYrX+G89/sODesi9dfuNaZAPeLHBDI9dAZmkANRaZCFRttrUFwylf9TInxF+Gqvmao5O1nzJ/WUiZxWEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5hnVwZDudCCalTW9gIoELE4Qh/36JmCXzFONjDugzsCYaEj6
	61PPchHeIofte0pNUHFqyncv+sStXpF2J32moRbNTDGdhwdK4Tc6cU/9ikCvZudhzq8xxWeRRs0
	+o1NdIw==
X-Google-Smtp-Source: AGHT+IHOit1CgdGOtEwyoWNstM/rY5EyZOJUqw3pif7druLduvP2SLwxlmjzkU+xmrbDuQykH2FtGTD0ZlE=
X-Received: from pjbsp3.prod.google.com ([2002:a17:90b:52c3:b0:31f:61fc:b283])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8f:b0:327:41c8:8840
 with SMTP id 98e67ed59e1d1-32741c8899emr6039622a91.37.1756253138478; Tue, 26
 Aug 2025 17:05:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 Aug 2025 17:05:18 -0700
In-Reply-To: <20250827000522.4022426-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827000522.4022426-9-seanjc@google.com>
Subject: [RFC PATCH 08/12] KVM: TDX: Use atomic64_dec_return() instead of a
 poor equivalent
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use atomic64_dec_return() when decrementing the number of "pre-mapped"
S-EPT pages to ensure that the count can't go negative without KVM
noticing.  In theory, checking for '0' and then decrementing in a separate
operation could miss a 0=>-1 transition.  In practice, such a condition is
impossible because nr_premapped is protected by slots_lock, i.e. doesn't
actually need to be an atomic (that wart will be addressed shortly).

Don't bother trying to keep the count non-negative, as the KVM_BUG_ON()
ensures the VM is dead, i.e. there's no point in trying to limp along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 88079e2d45fb..b7559ea1e353 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1774,10 +1774,9 @@ static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
 		tdx_no_vcpus_enter_stop(kvm);
 	}
 	if (tdx_is_sept_zap_err_due_to_premap(kvm_tdx, err, entry, level)) {
-		if (KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm))
+		if (KVM_BUG_ON(atomic64_dec_return(&kvm_tdx->nr_premapped) < 0, kvm))
 			return -EIO;
 
-		atomic64_dec(&kvm_tdx->nr_premapped);
 		return 0;
 	}
 
@@ -3162,8 +3161,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 		goto out;
 	}
 
-	if (!KVM_BUG_ON(!atomic64_read(&kvm_tdx->nr_premapped), kvm))
-		atomic64_dec(&kvm_tdx->nr_premapped);
+	KVM_BUG_ON(atomic64_dec_return(&kvm_tdx->nr_premapped) < 0, kvm);
 
 	if (arg->flags & KVM_TDX_MEASURE_MEMORY_REGION) {
 		for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
-- 
2.51.0.268.g9569e192d0-goog


