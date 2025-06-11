Return-Path: <linux-kernel+bounces-680499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC46AD463E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 01:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0063F7ABFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A22D1925;
	Tue, 10 Jun 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpx/hRvF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DD2C033E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596281; cv=none; b=fbU/UX04MeDrsAavwFG2Qg5y65t+Kas370+zZjVgZkzVwQu3qsx2I9yIRVHpMYEO89LNJ/ckulTom7w8Ofmeb/L/nA7Pd4Yl9iKbtW2wjDqJMB6EPGjhM8cwtEdlCRXiL2rgtk9Bekkhdt8pmeNp2lo0DysD3ZxiQSpWRaXnffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596281; c=relaxed/simple;
	bh=u7ao0TawB1pV1RTkqXHN83QLL0kwnu6scuJaSuoaBNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h076bNlXthWLB5/k4t1LjFPcmhMt4T5gr5qzLqHwM7IiBP70ZvoaOBNtjCFA7n995LmxPU+NU2jjNdkZMO2sY07cN+tP6DTPwNwnpoXGXX0D6Mzn0bHt5kFSybA6GTepquuK5jjxStxcZHieTC2hMDGc7y+OuGImwDh714etzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpx/hRvF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313b0a63c41so277721a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749596279; x=1750201079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UVDXF6a7sOgIhFQt3MLbDFl5pIZm0l+0Idj2IILtrzY=;
        b=gpx/hRvFsae357L6RpXWzvtZi/A/6JqxacXlEJ5K88CBs9RrikubznRnNzrqwyAoax
         LJ1kCoNxvySPV0gLPiel3aqOmHNU1Qed7BY3K/j9PX9KxCvJfKqvGyuWevf0QpR18f1O
         NN0x4Ho9nPwgxDhclHsWHnely04heXlrroTy5sR2CTOjSDkW2S8SesoG8LQrhyfZ6NOO
         YnbzOoIb05uKuMmLkxgDJH1a0YNFXyEgoh/6/OMlv7GGu5jHqA8oX+LudsCTmrFPeLf2
         gOfDgENHs35juHxKwMO8KMmKyD0sVBIGp7Xqd3n6eVKjVJJXa5mZqb973t7pUWbkhCyF
         0hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749596279; x=1750201079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVDXF6a7sOgIhFQt3MLbDFl5pIZm0l+0Idj2IILtrzY=;
        b=ETtq2fpktrLte4FTi395YgO8qphs1wGeSTUC8ump6/1gf1LiAYNiKL9x1A6Ui7EYyW
         7pl3Wu4HSfqmuAkMGr3ORpGqRzkTaY/7RaROUy8UL2ZyMd8KLVeryLsHYhWyDsP/jm6T
         uQ/nBO8Oj6saZWVn/bDnxOyhuIqaPliry/OlrQ1mYt2JZEB210VXTLs4KPg7Rd5Tm7a3
         lOmGmDQ1khFEFu+gadXM6LA2swe6K86B50F0Ac69w8NC+3f8x8/9PygsuyixzZG/HErc
         YlV0sCRQb6nsNtHU/z4lGPDNpVCgPQoWACPCROa+Psn3XYe1voSKVF9RkBhK7yF/fytc
         KnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBIzcos05T8cQo557gDllCTCbgdG4FpOr7GPYVjj4qwWoaiZC0TEQ/2983q6e7LQxwF/wfc/lVev0Xmm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvUFbPIO8eCSEeJoQ1yHJom6srv9HP6iiJvBAmXM8zGPLwPyk
	IhljlpcAgiVqL6f7AHB3T3aSMp3GZFwr4tkHnKFS/8ybzqEo4zGUdaFESdfeD2D0vagk3uamOS+
	y3hwC5w==
X-Google-Smtp-Source: AGHT+IEBB5qg4eF+njRYf5RTY0JBIXsh0Zdyp1xUstMWNbx4/qCCAE8F1Nkixuo4IMyOZPDpzoaRlI32Ak0=
X-Received: from pjbsr5.prod.google.com ([2002:a17:90b:4e85:b0:313:17cf:434f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d647:b0:311:ad7f:329f
 with SMTP id 98e67ed59e1d1-313af231f38mr1524868a91.31.1749596279620; Tue, 10
 Jun 2025 15:57:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 15:57:16 -0700
In-Reply-To: <20250610225737.156318-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610225737.156318-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250610225737.156318-12-seanjc@google.com>
Subject: [PATCH v2 11/32] KVM: nSVM: Omit SEV-ES specific passthrough MSRs
 from L0+L1 bitmap merge
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Francesco Lavra <francescolavra.fl@gmail.com>, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

Don't merge bitmaps on nested VMRUN for MSRs that KVM passes through only
for SEV-ES guests.  KVM doesn't support nested virtualization for SEV-ES,
and likely never will.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 666469e11602..360dbd80a728 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -194,7 +194,7 @@ void recalc_intercepts(struct vcpu_svm *svm)
  * Hardcode the capacity of the array based on the maximum number of _offsets_.
  * MSRs are batched together, so there are fewer offsets than MSRs.
  */
-static int nested_svm_msrpm_merge_offsets[9] __ro_after_init;
+static int nested_svm_msrpm_merge_offsets[6] __ro_after_init;
 static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
 
 int __init nested_svm_init_msrpm_merge_offsets(void)
@@ -219,13 +219,6 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		MSR_IA32_LASTBRANCHTOIP,
 		MSR_IA32_LASTINTFROMIP,
 		MSR_IA32_LASTINTTOIP,
-
-		MSR_IA32_DEBUGCTLMSR,
-		MSR_IA32_XSS,
-		MSR_EFER,
-		MSR_IA32_CR_PAT,
-		MSR_AMD64_SEV_ES_GHCB,
-		MSR_TSC_AUX,
 	};
 	int i, j;
 
-- 
2.50.0.rc0.642.g800a2b2222-goog


