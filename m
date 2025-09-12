Return-Path: <linux-kernel+bounces-814871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5EAB559FB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5770B1C27BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75C92874F1;
	Fri, 12 Sep 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2Hq5nYv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4D2848A4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719410; cv=none; b=oumWMwtImMxfQWjPzxONQNco6g39IVkAC49G191pDLrpI33VfmJn3qREBimEnsuC7AIpdN3fjD1ek20P+BJxhqxeRuLhIz6y0CsVFGrJGk/3jrEoz5Ap3iJunE1Y+Kn8ASwjf4WTW1i6AOc7ywmb1WMvo+2b3E2P4oRi5+iqtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719410; c=relaxed/simple;
	bh=r7keHhPSl/ZsINgiku4qxCsoIZDRWPCly3Ia9CUnCtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUIeLTCpn2EwMcH9hHMKqu2s3FvGOrgxcraSjMMQBBSp6PEe2gfHtd8jyo1xIGVOrkQQz/qC7VjrAb+w4hF3J2pVll7MMon3ZmMNZNm0GQQSEqU5FWsUwRjMOKjiXjFRTyY6FOBaGpl1UobpktC0c5CbYV8PLqjJktM9PGpXYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2Hq5nYv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25d449089e8so22390895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719407; x=1758324207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2aufua2/8jN63zHyNl5OPd1VmsqwIgjY1xs28jVoYjg=;
        b=g2Hq5nYvywDPeEOIn39Iar5Z3v5QwMY2Gl+ZWnQUgvyk/JS2udb+Zywb/oWL1O5iN3
         cyOQQ9ylLUW/UYgok63vrra0JpDSmF35Tsq4YoNe2Hg16gU76DjxB4VYBPfIoMoFBwTJ
         8MKMCDMfQhnkV2pwNwTTR/AUPERDdvvfPvpJXynMAzAQK9o1eejWS75f66rdOz5SJbKA
         86OagnMcMJt4L8mMNG676gK5RLPCJ/9DPzxJOevxL5fViwbkZJ2qVN60Oy4hJZk3J/sq
         MvnCk3VWFW+hfhTfDtgWMBQKER/iPZClH2JYRxnYgERtx4qkYqlzFHuyun6lr8Xgkx69
         XLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719407; x=1758324207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aufua2/8jN63zHyNl5OPd1VmsqwIgjY1xs28jVoYjg=;
        b=j5KR+TkAFP8sIvMpvD+0oi9hClF15oL9GXpxzSbzVl82YMXeEgiApmoV6O8LW3LGGQ
         uxy20jjtyFz42vgKgV4QsiCkfrNp3nwQ963HyzAzvkqbkbS9I6UMmBfnQB7zO/wvTJyj
         zsOcnNIGQH8AyXw1rjYHFWisDJTBe27XL8KRO9WCg9cT7L5Ym3UpyPvD6baoZe0XIPbv
         3bLrReXwTjA/uUwN7JAomep5WaV3TzT5EYjlR2PpPZG8RSPR/5VWqw4nCUTy74bZg3Zh
         n3hCek3LODSaW0SJj9RntKv7ndMU/Y6C9y0QLAX75PyvOJchx9NRJBRmG2sTsV8/mX77
         dgxA==
X-Forwarded-Encrypted: i=1; AJvYcCXfNDt54WQ+R4mjZ4aZrlYDEtTnSa671ED+x2CEh8lpwH6O6WFbGOlTLdJZNZV40Qsuox3t4MJMzrIiAZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWpR/08yhgU2RFRVWqOq8Z92nr1w603df8C8XlNg3WsEi1e+A
	bGOHyu7mg6iwDfjQfbsHASl5XzCaYM+p5Xtn7K94YCjv0jVfz85tbHeOuraoUZb3tdpZFO/E21x
	gZZC5Hw==
X-Google-Smtp-Source: AGHT+IHHzgbw/XBQzAtCVBlNqG134UP+Hxy4J40on9uJ3r+AzCZzk5i/NZAmxAjojr+hxUYoGtUH6MD3BAA=
X-Received: from plbmu15.prod.google.com ([2002:a17:903:b4f:b0:25c:9927:b204])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc47:b0:246:570:2d9a
 with SMTP id d9443c01a7336-25d286014e7mr57345885ad.59.1757719406796; Fri, 12
 Sep 2025 16:23:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:39 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-2-seanjc@google.com>
Subject: [PATCH v15 01/41] KVM: SEV: Rename kvm_ghcb_get_sw_exit_code() to kvm_get_cached_sw_exit_code()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_ghcb_get_sw_exit_code() to kvm_get_cached_sw_exit_code() to make
it clear that KVM is getting the cached value, not reading directly from
the guest-controlled GHCB.  More importantly, vacating
kvm_ghcb_get_sw_exit_code() will allow adding a KVM-specific macro-built
kvm_ghcb_get_##field() helper to read values from the GHCB.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2fdd2e478a97..fe8d148b76c0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3216,7 +3216,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 		kvfree(svm->sev_es.ghcb_sa);
 }
 
-static u64 kvm_ghcb_get_sw_exit_code(struct vmcb_control_area *control)
+static u64 kvm_get_cached_sw_exit_code(struct vmcb_control_area *control)
 {
 	return (((u64)control->exit_code_hi) << 32) | control->exit_code;
 }
@@ -3242,7 +3242,7 @@ static void dump_ghcb(struct vcpu_svm *svm)
 	 */
 	pr_err("GHCB (GPA=%016llx) snapshot:\n", svm->vmcb->control.ghcb_gpa);
 	pr_err("%-20s%016llx is_valid: %u\n", "sw_exit_code",
-	       kvm_ghcb_get_sw_exit_code(control), kvm_ghcb_sw_exit_code_is_valid(svm));
+	       kvm_get_cached_sw_exit_code(control), kvm_ghcb_sw_exit_code_is_valid(svm));
 	pr_err("%-20s%016llx is_valid: %u\n", "sw_exit_info_1",
 	       control->exit_info_1, kvm_ghcb_sw_exit_info_1_is_valid(svm));
 	pr_err("%-20s%016llx is_valid: %u\n", "sw_exit_info_2",
@@ -3331,7 +3331,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	 * Retrieve the exit code now even though it may not be marked valid
 	 * as it could help with debugging.
 	 */
-	exit_code = kvm_ghcb_get_sw_exit_code(control);
+	exit_code = kvm_get_cached_sw_exit_code(control);
 
 	/* Only GHCB Usage code 0 is supported */
 	if (svm->sev_es.ghcb->ghcb_usage) {
@@ -4336,7 +4336,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 	svm_vmgexit_success(svm, 0);
 
-	exit_code = kvm_ghcb_get_sw_exit_code(control);
+	exit_code = kvm_get_cached_sw_exit_code(control);
 	switch (exit_code) {
 	case SVM_VMGEXIT_MMIO_READ:
 		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
-- 
2.51.0.384.g4c02a37b29-goog


