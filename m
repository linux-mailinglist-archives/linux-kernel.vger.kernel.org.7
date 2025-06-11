Return-Path: <linux-kernel+bounces-680515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF03AD4660
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 01:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818B43A8050
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 23:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10B2728D4;
	Tue, 10 Jun 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ds+ZHTUt"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE026E71D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596308; cv=none; b=qjB/dE2IeVgbKo/WLBZecF2NkDEGN6uAMuZJOPpPU5YfvXDjljhye7WRsSsjiTFLQBYzqMX52cVIeniULcBZHHDhuSp3YSzLEbx3DYkzivl+qORb07amlcFYWZcoxjPUL2QpK9vwDTQokwGUsBL0ylTYzdwIInyknrG6nKwc04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596308; c=relaxed/simple;
	bh=P1pYBfHF2a5ydPVAMJU32CoMov4t0z22YxjWawa50TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTk3f9GLYrQViezGlzuH1A83W4rMDTswLdeyP/B1OOeX7b5OP4dX9/GXvzXXqGkRejMuQ140BBtJw7hzKMbl1jDPjnk6jHySD0DS0uDWOcvZEV+f1FN3b0IBULtYZkoaUWy+GPXwCqCr/2+pXlku3998TJD2n6GWpLsQyf1mjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ds+ZHTUt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso220242a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749596306; x=1750201106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UBsTjzl7rWzHa9vyXcqPpj89ZJOq4S35hhetc8s+5dU=;
        b=ds+ZHTUtMyMk/xnGPftiRFCc+hVPZENikG0M6ZoQfT/vB0Ni/N+K70NQ3pt7XuWgJw
         3JxLyqpVcs1cFbF42loiCSjwxOtXVy+lcnsAL41dnGzPBTsDKR/mq4eR2XXhJI2Trq8A
         6OsNY1BN1v+UPPHdouQCxZXxsWcj5IA4Iw90vAggOASIiFH8lDP901+uJsWkEVE0vJTg
         GO4aZ7jFXYHVevhlfMPCw6jJKJ1ATphtuwFpdFGojYeYEiSrdgNJ5FCl8E2mX4y9+F44
         CzZ23oxB+zrS1cewyxsyUUYUt7e5tUFxlV5kaY0bCWkVMm8LeQZRfrWm2oVdnsaYj2xu
         ExIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749596306; x=1750201106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBsTjzl7rWzHa9vyXcqPpj89ZJOq4S35hhetc8s+5dU=;
        b=nTmM9DXIwzQCKp/6n1tEFmByxTKQQkz3b1wFzjtgJNF2omVm5IuuQ162/olsAsCjox
         yV1I9uGX6Q32COwBYXWHDimUp0vn/VRE4XwjjjsP5jatZqQTrK3J1MaQ+e+c7qTIAeyP
         DJ5hAzT+QbWBePhd+l/pzH7Sx4Ovog1xRmSdnryVJYFAko4I8GRrugfIOW9ef2dkdVAL
         ocovj8A8bgB1yi4M+vJpOylb8YI4eYcGC+C+tx2eMLckza7sidpqvdnmjgQaeP3S3mCQ
         Y/Iy/gcWQiu5nGBkVAjI3mQnde62/W7y8YTmJM/oJLINP51R1JvwmsvOfzb2/o85nHFV
         /m+w==
X-Forwarded-Encrypted: i=1; AJvYcCUu7hdgQbhMb0yjqJz+QJzo01sao9+as03OiNakE8T3qOh3ZKzbNa8eNshK42/G+bv73Dt6cM/tGOd0yq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgHJBSKdPmyXFQDDXVRSY/pDT+ZztMzOvvnNiTyPjhbbTbQIM
	7NhuvfU61wyMULHHvBF/FTMgNGY0HNYopT0mzVWDRttlVNTgzN1L78S4ODrj+jAoevcxjF4q7lL
	BwBz+Ng==
X-Google-Smtp-Source: AGHT+IHIEeDEmRbbQzBBL26ejUGuQhwpUOlD0o9JSQhXoZ81alSjpxx8PrzXd+pLsmbSkXNxRqBchUhv5vM=
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:312:ea08:fa64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d410:b0:312:e73e:cded
 with SMTP id 98e67ed59e1d1-313af99193bmr1323185a91.16.1749596306408; Tue, 10
 Jun 2025 15:58:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 15:57:32 -0700
In-Reply-To: <20250610225737.156318-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610225737.156318-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250610225737.156318-28-seanjc@google.com>
Subject: [PATCH v2 27/32] KVM: nSVM: Access MSRPM in 4-byte chunks only for
 merging L0 and L1 bitmaps
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Francesco Lavra <francescolavra.fl@gmail.com>, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

Access the MSRPM using u32/4-byte chunks (and appropriately adjusted
offsets) only when merging L0 and L1 bitmaps as part of emulating VMRUN.
The only reason to batch accesses to MSRPMs is to avoid the overhead of
uaccess operations (e.g. STAC/CLAC and bounds checks) when reading L1's
bitmap pointed at by vmcb12.  For all other uses, either per-bit accesses
are more than fast enough (no uaccess), or KVM is only accessing a single
bit (nested_svm_exit_handled_msr()) and so there's nothing to batch.

In addition to (hopefully) documenting the uniqueness of the merging code,
restricting chunked access to _just_ the merging code will allow for
increasing the chunk size (to unsigned long) with minimal risk.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 52 ++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f9bda148273e..fb0ac87df00a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -197,29 +197,6 @@ void recalc_intercepts(struct vcpu_svm *svm)
 static int nested_svm_msrpm_merge_offsets[6] __ro_after_init;
 static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
 
-static const u32 msrpm_ranges[] = {0, 0xc0000000, 0xc0010000};
-
-static u32 svm_msrpm_offset(u32 msr)
-{
-	u32 offset;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(msrpm_ranges); i++) {
-		if (msr < msrpm_ranges[i] ||
-		    msr >= msrpm_ranges[i] + SVM_MSRS_PER_RANGE)
-			continue;
-
-		offset  = (msr - msrpm_ranges[i]) / SVM_MSRS_PER_BYTE;
-		offset += (i * SVM_MSRPM_BYTES_PER_RANGE);  /* add range offset */
-
-		/* Now we have the u8 offset - but need the u32 offset */
-		return offset / 4;
-	}
-
-	/* MSR not in any range */
-	return MSR_INVALID;
-}
-
 int __init nested_svm_init_msrpm_merge_offsets(void)
 {
 	static const u32 merge_msrs[] __initconst = {
@@ -246,11 +223,18 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 	int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(merge_msrs); i++) {
-		u32 offset = svm_msrpm_offset(merge_msrs[i]);
+		u32 bit_nr = svm_msrpm_bit_nr(merge_msrs[i]);
+		u32 offset;
 
-		if (WARN_ON(offset == MSR_INVALID))
+		if (WARN_ON(bit_nr == MSR_INVALID))
 			return -EIO;
 
+		/*
+		 * Merging is done in 32-bit chunks to reduce the number of
+		 * accesses to L1's bitmap.
+		 */
+		offset = bit_nr / BITS_PER_BYTE / sizeof(u32);
+
 		for (j = 0; j < nested_svm_nr_msrpm_merge_offsets; j++) {
 			if (nested_svm_msrpm_merge_offsets[j] == offset)
 				break;
@@ -1369,26 +1353,26 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 {
-	u32 offset, msr, value;
-	int write, mask;
+	gpa_t base = svm->nested.ctl.msrpm_base_pa;
+	u32 msr, bit_nr;
+	u8 value, mask;
+	int write;
 
 	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
 		return NESTED_EXIT_HOST;
 
 	msr    = svm->vcpu.arch.regs[VCPU_REGS_RCX];
-	offset = svm_msrpm_offset(msr);
+	bit_nr = svm_msrpm_bit_nr(msr);
 	write  = svm->vmcb->control.exit_info_1 & 1;
-	mask   = 1 << ((2 * (msr & 0xf)) + write);
 
-	if (offset == MSR_INVALID)
+	if (bit_nr == MSR_INVALID)
 		return NESTED_EXIT_DONE;
 
-	/* Offset is in 32 bit units but need in 8 bit units */
-	offset *= 4;
-
-	if (kvm_vcpu_read_guest(&svm->vcpu, svm->nested.ctl.msrpm_base_pa + offset, &value, 4))
+	if (kvm_vcpu_read_guest(&svm->vcpu, base + bit_nr / BITS_PER_BYTE,
+				&value, sizeof(value)))
 		return NESTED_EXIT_DONE;
 
+	mask = BIT(write) << (bit_nr & (BITS_PER_BYTE - 1));
 	return (value & mask) ? NESTED_EXIT_DONE : NESTED_EXIT_HOST;
 }
 
-- 
2.50.0.rc0.642.g800a2b2222-goog


