Return-Path: <linux-kernel+bounces-680493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E522AD4634
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 00:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155FD16DD08
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20C29B8DB;
	Tue, 10 Jun 2025 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjdvhBMM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80593299A93
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596272; cv=none; b=goDPYh7LZ+iWhBKiGPus1A5SFYLixSQaYeJxsd+t++yjKOwLSO1KN55WRx7yLXPEf3mxwagWfTgU6YGAy99v/MwQA10ZCojrNbTdDrHjVzwqfY68G31wxBQ0rXIwcK54hRwwnbLhPYZnNv3KgOr3sZ+J2JWcWIw0yx0Fisrs1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596272; c=relaxed/simple;
	bh=s3xp6iS4ZBZd5UZyOrWqH8rAHwq2L7PdkpewI9eTv2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d7ok3Yksp2ysNWJT0wPGqDbVC1c39I9Lsz2Aq8UqUzHX4SJw/A9yawMDigZZ2sWmMiZh57e1wcGoDf9eaDc2wOgjm6fGNSBoIh1paXqgWtMa1pW1UMnwdnQWza0CUcRhJLHKhJFCk0q9ewL47/lv6/kyfipWjOe80utnnHsvDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjdvhBMM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73bfc657aefso4186926b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749596270; x=1750201070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VeQp8JRtyaBnYt1A8Mx+0eX8s8JcdFqHSgK3iz36nVo=;
        b=DjdvhBMM2d2P6G30Mppcd8ehlGofyPDJRu2rTVBUI/6Rrho0t/AGw8jQYTTXT7kWz4
         1BnYL3/xPDllgjPrTDwP6/8UBOy7FV0J+COpDiWWzSbbQ6uO+YLjvOERmpYwYEk69KZJ
         iGmAfvVFC6hWVs6OEZVKDw5IM411LnoI7X/P2lhFyAbxWWXBaC3pqRzOicyE6P7A3hmj
         LR+/9vI8rqvsKxSamC4OWYij85QHloCGW03xKI9X07WGO+Gn2N/Ds7TNOeNC8HKd7DEb
         VVb2qoqxPIGBnaMKNchzt/rmH6AACynYMvRyglMi/gySUtDkyW2Y9u4+gx7FC4ONCgSD
         wzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749596270; x=1750201070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeQp8JRtyaBnYt1A8Mx+0eX8s8JcdFqHSgK3iz36nVo=;
        b=OUT01hXN8XXnsmk8C3IuuxVZGO5/SS3SzG4oRM+aYFBYTQhDIkkTZ2I8WvbgAiMaJ6
         qNmUWeS/zhnPzZr/cMkvjtb0EtHH6Wj5dgYo7px7RGhYOxXFoklFBGtuVIso9cMIudt2
         2YT+Sqrphh6AzAPwEKLSX9R2yB4eWo2Y9RiKVsZxCrl9AIxMWfVVT9wVrQ7xhN4RT6K8
         N+bH4zwv7PFLf+wZwZcru6g1A9CQUKGPgNM1BWuhnKzi+UAUZ85z1uaEBllIxTwIFqhM
         N6xQ4NLHfSjTtsgBNWu76wLHNZ7qvFXwQEkqfF4NYcxfhzRyW1z8AYRw8A7d44EgPQsV
         PKcw==
X-Forwarded-Encrypted: i=1; AJvYcCWIvNHrV/Sq4zadj1kJdiOKAq5Ksd3kRu+ZiV8+5nmHKNSP6+2K1owXCg8UxSQp7l3tCDPnyyGRLQNrjOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4uMnvZl8LmjLRKN/NmexLe9AhS+JMF+/9TF3Q6XYlSl1Vj3G
	55mei6DvGNB7wT4DiLjcMesMqKPVxBJArC9Vadv2mlYcWa58zfAc7y67l5XpFJ+C26SakT3xcVh
	p7QcB2w==
X-Google-Smtp-Source: AGHT+IEqdKNLiP0HdlL9Ic9oob9D/qJdDHA9+2AATPraaJ+WfW+T6d7Afm3PVQMoJ3XAQ5JBpgKotymy5x4=
X-Received: from pgbdl11.prod.google.com ([2002:a05:6a02:d0b:b0:b2d:249f:ea07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7347:b0:1f5:51d5:9ef3
 with SMTP id adf61e73a8af0-21f8672695bmr1838091637.20.1749596269811; Tue, 10
 Jun 2025 15:57:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 15:57:10 -0700
In-Reply-To: <20250610225737.156318-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610225737.156318-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250610225737.156318-6-seanjc@google.com>
Subject: [PATCH v2 05/32] KVM: SVM: Use ARRAY_SIZE() to iterate over direct_access_msrs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Francesco Lavra <francescolavra.fl@gmail.com>, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop the unnecessary and dangerous value-terminated behavior of
direct_access_msrs, and simply iterate over the actual size of the array.
The use in svm_set_x2apic_msr_interception() is especially sketchy, as it
relies on unused capacity being zero-initialized, and '0' being outside
the range of x2APIC MSRs.

To ensure the array and shadow_msr_intercept stay synchronized, simply
assert that their sizes are identical (note the six 64-bit-only MSRs).

Note, direct_access_msrs will soon be removed entirely; keeping the assert
synchronized with the array isn't expected to be along-term maintenance
burden.

Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 18 +++++++++++-------
 arch/x86/kvm/svm/svm.h |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0c71efc99208..c75977ca600b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -86,7 +86,7 @@ static DEFINE_PER_CPU(u64, current_tsc_ratio);
 static const struct svm_direct_access_msrs {
 	u32 index;   /* Index of the MSR */
 	bool always; /* True if intercept is initially cleared */
-} direct_access_msrs[MAX_DIRECT_ACCESS_MSRS] = {
+} direct_access_msrs[] = {
 	{ .index = MSR_STAR,				.always = true  },
 	{ .index = MSR_IA32_SYSENTER_CS,		.always = true  },
 	{ .index = MSR_IA32_SYSENTER_EIP,		.always = false },
@@ -144,9 +144,12 @@ static const struct svm_direct_access_msrs {
 	{ .index = X2APIC_MSR(APIC_TMICT),		.always = false },
 	{ .index = X2APIC_MSR(APIC_TMCCT),		.always = false },
 	{ .index = X2APIC_MSR(APIC_TDCR),		.always = false },
-	{ .index = MSR_INVALID,				.always = false },
 };
 
+static_assert(ARRAY_SIZE(direct_access_msrs) ==
+	      MAX_DIRECT_ACCESS_MSRS - 6 * !IS_ENABLED(CONFIG_X86_64));
+#undef MAX_DIRECT_ACCESS_MSRS
+
 /*
  * These 2 parameters are used to config the controls for Pause-Loop Exiting:
  * pause_filter_count: On processors that support Pause filtering(indicated
@@ -767,9 +770,10 @@ static int direct_access_msr_slot(u32 msr)
 {
 	u32 i;
 
-	for (i = 0; direct_access_msrs[i].index != MSR_INVALID; i++)
+	for (i = 0; i < ARRAY_SIZE(direct_access_msrs); i++) {
 		if (direct_access_msrs[i].index == msr)
 			return i;
+	}
 
 	return -ENOENT;
 }
@@ -891,7 +895,7 @@ void svm_vcpu_init_msrpm(struct kvm_vcpu *vcpu, u32 *msrpm)
 {
 	int i;
 
-	for (i = 0; direct_access_msrs[i].index != MSR_INVALID; i++) {
+	for (i = 0; i < ARRAY_SIZE(direct_access_msrs); i++) {
 		if (!direct_access_msrs[i].always)
 			continue;
 		set_msr_interception(vcpu, msrpm, direct_access_msrs[i].index, 1, 1);
@@ -908,7 +912,7 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool intercept)
 	if (!x2avic_enabled)
 		return;
 
-	for (i = 0; i < MAX_DIRECT_ACCESS_MSRS; i++) {
+	for (i = 0; i < ARRAY_SIZE(direct_access_msrs); i++) {
 		int index = direct_access_msrs[i].index;
 
 		if ((index < APIC_BASE_MSR) ||
@@ -936,7 +940,7 @@ static void svm_msr_filter_changed(struct kvm_vcpu *vcpu)
 	 * will automatically get filtered through the MSR filter, so we are
 	 * back in sync after this.
 	 */
-	for (i = 0; direct_access_msrs[i].index != MSR_INVALID; i++) {
+	for (i = 0; i < ARRAY_SIZE(direct_access_msrs); i++) {
 		u32 msr = direct_access_msrs[i].index;
 		u32 read = test_bit(i, svm->shadow_msr_intercept.read);
 		u32 write = test_bit(i, svm->shadow_msr_intercept.write);
@@ -974,7 +978,7 @@ static __init int init_msrpm_offsets(void)
 
 	memset(msrpm_offsets, 0xff, sizeof(msrpm_offsets));
 
-	for (i = 0; direct_access_msrs[i].index != MSR_INVALID; i++) {
+	for (i = 0; i < ARRAY_SIZE(direct_access_msrs); i++) {
 		u32 offset;
 
 		offset = svm_msrpm_offset(direct_access_msrs[i].index);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e6f3c6a153a0..f1e466a10219 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -44,7 +44,7 @@ static inline struct page *__sme_pa_to_page(unsigned long pa)
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
-#define MAX_DIRECT_ACCESS_MSRS	48
+#define MAX_DIRECT_ACCESS_MSRS	47
 #define MSRPM_OFFSETS	32
 extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
-- 
2.50.0.rc0.642.g800a2b2222-goog


