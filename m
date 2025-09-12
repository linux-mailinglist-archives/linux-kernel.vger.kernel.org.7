Return-Path: <linux-kernel+bounces-814908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC63B55A44
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76BE3BFA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F122E7652;
	Fri, 12 Sep 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWN+JRe1"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FCC2E6CB1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719473; cv=none; b=dUbaC6W6Mb8UAa0ixBYt5RWev+BYIQFeRfezs2N1NvrWpAgFNzzkhrd8AeobZV60iB8pNusWLgBrokUf5+YxDy5eTdt1lEDcm62dnhpVM+OUI07234XlrffDRuOTUTkAi1+Iuf2c4q8f7GWK/wcPrG1a/rEUWEiL8dZxEZaVBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719473; c=relaxed/simple;
	bh=eyeGzyB6mK8cqaplsUFqyS5an9QDaDUBST0i3cQldH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hOPxSDbE8iDZw7QfoeGi8MkFWY5wK1nXY4CftI9Zd3WTMwnkt6R835NY5tvK6jSPKDHBblSy5XXikcJOZyjASWmfKxUryxdfYtuj9csMoZBLxno6ODM0Vh7vgxIUsEHCrToY8AYf5/mJsXpRs2XmJjHkGcm9Rgqjb4V/LPXELFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWN+JRe1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso3626307a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719471; x=1758324271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2XRylLheuxpKgGPAxOiSFjud1uy6JuPsOzlOavkClSw=;
        b=CWN+JRe1op/4Af2lP/5JU0SCkXwYVtN1vtD2uM3kpt4LAdqxYEKMjfmq2LZ42dUmHL
         QxIi9H0iqz2umyUWzMSA2KuUH+LfX1H8prWtGfPFS9xbwJ9GyMb4M51plx5GQFn991Ee
         uMC4sHV4vb3e0YepDVvCQ7owew68/KABpmZkBvLaXMYvdPxemmFdIpedNWxOhsOTv853
         XVyURKBs8C67vLTuJGYo7UVHv0V97TAWKGDiBEL5hb9EybVIV2HHjQT4nmTeVawCq95H
         IEa9hK5wlyEAIB4XBAIgWGxT97IjV28EuMmd8S+0RPg8nBr6X4fWqcdFNNZnLxqjizmI
         FXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719471; x=1758324271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XRylLheuxpKgGPAxOiSFjud1uy6JuPsOzlOavkClSw=;
        b=vyJEUxnNcKb2n4fpd9W06pj6FhKmWqkhksckGC6RwTp5lPZlXRHpHfDdunXcMZsvus
         lc84SAxYZGbVwa5KeR/CdpPG/GHK4cESbqLYboXizcvEkXRMfiNAkLySpHt4fJYtBSwJ
         jvJi7GG8HAIsC2U/LLkORDKAmMbiCvXFDxjfb0WEFA5xdx4GYp4N+AXqQa+VwvSntgZg
         LZpevBLIcBvdISBYjTHih2mv/peSH9DKQftImmTOsSLQTHGSi2HGoDg8s8xZyaUOPoyp
         X730/NWcs/iiUN9DTaZsVdbZV0c1BtRlTqggfiOiDaAxXk/hzyQ1CbD+WPU09QO8mVlg
         iXNw==
X-Forwarded-Encrypted: i=1; AJvYcCVkUnVthRsScwS74c8L7uAlu/Gs9PahqrAwo+3RVZ0yxAuriF729htiv3xf9gy5kNQ2Gko8lsDwh6JIOTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFKZSQV7uDfo3WIfT95btAQo8yQby3n9QlWOtgC+6XnFzUaNX
	yFc+ydkPQjx+VCWYgs+FgzxjKfHR+a1ok8zOB26qpwm9/l9eBEfZqGWgVGRo5D/Q4+N0z5j/YJn
	0VGCafQ==
X-Google-Smtp-Source: AGHT+IExCQxf0WOm0sYlLsbevWbvyRx83pzBXQJeDoWAQv7RGz/QPTJwxZ5IUngHXrO2VX388sfppatfXXo=
X-Received: from pjm5.prod.google.com ([2002:a17:90b:2fc5:b0:31e:a094:a39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8c:b0:314:2cd2:595d
 with SMTP id 98e67ed59e1d1-32de4b9ee5fmr5279110a91.8.1757719471302; Fri, 12
 Sep 2025 16:24:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:15 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-38-seanjc@google.com>
Subject: [PATCH v15 37/41] KVM: selftests: Extend MSRs test to validate vCPUs
 without supported features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a third vCPUs to the MSRs test that runs with all features disabled in
the vCPU's CPUID model, to verify that KVM does the right thing with
respect to emulating accesses to MSRs that shouldn't exist.  Use the same
VM to verify that KVM is honoring the vCPU model, e.g. isn't looking at
per-VM state when emulating MSR accesses.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/msrs_test.c | 28 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index 095d49d07235..98892467438c 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -254,12 +254,17 @@ static void test_msrs(void)
 		MSR_TEST(MSR_IA32_PL3_SSP, canonical_val, canonical_val | 1, SHSTK),
 	};
 
+	const struct kvm_x86_cpu_feature feat_none = X86_FEATURE_NONE;
+	const struct kvm_x86_cpu_feature feat_lm = X86_FEATURE_LM;
+
 	/*
-	 * Create two vCPUs, but run them on the same task, to validate KVM's
+	 * Create three vCPUs, but run them on the same task, to validate KVM's
 	 * context switching of MSR state.  Don't pin the task to a pCPU to
-	 * also validate KVM's handling of cross-pCPU migration.
+	 * also validate KVM's handling of cross-pCPU migration.  Use the full
+	 * set of features for the first two vCPUs, but clear all features in
+	 * third vCPU in order to test both positive and negative paths.
 	 */
-	const int NR_VCPUS = 2;
+	const int NR_VCPUS = 3;
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
 
@@ -271,6 +276,23 @@ static void test_msrs(void)
 
 	sync_global_to_guest(vm, msrs);
 
+	/*
+	 * Clear features in the "unsupported features" vCPU.  This needs to be
+	 * done before the first vCPU run as KVM's ABI is that guest CPUID is
+	 * immutable once the vCPU has been run.
+	 */
+	for (idx = 0; idx < ARRAY_SIZE(__msrs); idx++) {
+		/*
+		 * Don't clear LM; selftests are 64-bit only, and KVM doesn't
+		 * honor LM=0 for MSRs that are supposed to exist if and only
+		 * if the vCPU is a 64-bit model.  Ditto for NONE; clearing a
+		 * fake feature flag will result in false failures.
+		 */
+		if (memcmp(&msrs[idx].feature, &feat_lm, sizeof(feat_lm)) &&
+		    memcmp(&msrs[idx].feature, &feat_none, sizeof(feat_none)))
+			vcpu_clear_cpuid_feature(vcpus[2], msrs[idx].feature);
+	}
+
 	for (idx = 0; idx < ARRAY_SIZE(__msrs); idx++) {
 		sync_global_to_guest(vm, idx);
 
-- 
2.51.0.384.g4c02a37b29-goog


