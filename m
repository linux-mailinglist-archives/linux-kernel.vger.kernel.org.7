Return-Path: <linux-kernel+bounces-829357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095FB96E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0719C1DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30083328560;
	Tue, 23 Sep 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPSo4mPx"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21364A8F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646314; cv=none; b=Zq2a9i4SQ7G4O1lk/UcqnueSNDWUpbMmEo4H/AcUuxEUi5yw4VGfypqjuTWDFIxK1DTd0jP0oXl/oT4gMuXavPTndX2/BICF0fKVXO3WiqF+t++Cr407XoA6Qq27ZqZvHMwcpVIYyew638LZQR6hte2aXfdJqvJefRWUaZGFSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646314; c=relaxed/simple;
	bh=QxaQ7JYmW6SoppxdzNqff99uc2GQFsWJ8bkLHSqAb3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ey09L40iyvVd/9a2mDCXcIS37isyDp8cjRJk+Ua/QANXTAU3tP4kvhZPlvvC3ruZWWH2zNHHsIDsFrT/JzsXGkc68OaLkwRJd5alZCVmI/L0jhN+q9S+L7riWic4lmQnyZu+DfGejkThHvSvEVDD3VOcKNA1HmOJ+RzfFJBxFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPSo4mPx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244570600a1so979575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758646312; x=1759251112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ttBHw83mBBKei73n8M/BNwMGiua/BJVn53tHa2ocQk=;
        b=LPSo4mPxcQBmLX2AxfdVcoMChvv9qDL2eJYwQwycq+jojs8BLMYioEl7A0s1AzStOU
         d1TmKNfAHQxRHqOvcz899ft7JxAUkbqrwEEfAIP5wLseIZ0nbMAnmjoU1/vDzA8SsRgw
         FXVivT3g/rMK4pNlgzwuJWfgdDeizVh7Kakt2kDYR7IZTVCA+8selkmCxunsWoYhUjCL
         iJHBrbGMGceLDcB1Gfr4urQ77S9lftua0Q6YKPixXhEVwBtlmKLT4Bk0+UxX4tXIccPO
         oKMDOTvBERghPev+LEq+5UlYv75KZC3C0bARozsGDukQCUl+Vqm6nUwDZQ51DZbbqp3t
         jA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758646312; x=1759251112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ttBHw83mBBKei73n8M/BNwMGiua/BJVn53tHa2ocQk=;
        b=AgAdL73Iw8gv28dmWmSmbgRtMguNbs4uIOuVKckz+vtSXnmIPyOw5JaKuBDATgFPAW
         Bo5zKkJZqE4RfXfM/gqv65eUK1usIlxcPHXHFPGoAYAUc2q4cKhVT310QgfFEfQPmaEM
         jKS7reNDnpHKz6Nur4CmqEVmT8OclztoL3hmwDPGYa2gFWMlCkHT1wtkPem9zmwtqojF
         15QN9LBKInmPXkTFnRrmLEir4CZDq3fkXO5lpsrPRv7yAeplCdVVHogVFBbQ0U837lWr
         A2NzhSvjN4tjVYp8l8XHXmzbWIMBIUu57x8has/Z42YGPAA2Ob6Jl5yF4miHeVhbE3Si
         nwqg==
X-Forwarded-Encrypted: i=1; AJvYcCXUsAxVoLQHZ1ib3uuItyjtZHVBV6QWkIm2lzgYWbAUNwPFcxKmDUxhTCEgBWwRzs/1JUB7yIey4fKr0gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LtV8YSgbDpUX3y3nvoOnn6I62mFkp6/oaRsq2X12JT8s/7hV
	E9ZfJk3FzCxDBuusBZwJCeoe0U8NQDIMFwIqapqB9FOOOLCbqlQ3xxrqRdTmZiMrRllEsS5VePl
	n3m4dSg==
X-Google-Smtp-Source: AGHT+IErnPS2OUnE/M9s+uEMA4ws/sYHBVcLuOlMX+nidzjdFfhtmVnknKhA38KDZ5Q4wlGtCqW08/b9loo=
X-Received: from pjp3.prod.google.com ([2002:a17:90b:55c3:b0:327:dc48:1406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c04:b0:266:57f7:25f5
 with SMTP id d9443c01a7336-27cd6c9dec5mr45739465ad.7.1758646312450; Tue, 23
 Sep 2025 09:51:52 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:51:50 -0700
In-Reply-To: <aNJUPjdRoqtiXYp+@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-46-seanjc@google.com>
 <aNJUPjdRoqtiXYp+@intel.com>
Message-ID: <aNLQJu-1YZ7GYybw@google.com>
Subject: Re: [PATCH v16 45/51] KVM: selftests: Add an MSR test to exercise
 guest/host and read/write
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 23, 2025, Chao Gao wrote:
> On Fri, Sep 19, 2025 at 03:32:52PM -0700, Sean Christopherson wrote:
> >+		/*
> >+		 * TSC_AUX is supported if RDTSCP *or* RDPID is supported.  Add
> >+		 * entries for each features so that TSC_AUX doesn't exists for
> >+		 * the "unsupported" vCPU, and obviously to test both cases.
> >+		 */
> >+		MSR_TEST2(MSR_TSC_AUX, 0x12345678, canonical_val, RDTSCP, RDPID),
> >+		MSR_TEST2(MSR_TSC_AUX, 0x12345678, canonical_val, RDPID, RDTSCP),
> 
> At first glance, it's unclear to me why canonical_val is invalid for
> MSR_TSC_AUX, especially since it is valid for a few other MSRs in this
> test. Should we add a note to the above comment? e.g.,
> 
> canonical_val is invalid for MSR_TSC_AUX because its high 32 bits must be 0.

Yeah, I was being lazy.  To-be-tested, but I'll squash this:

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index 9285cf51ef75..345a39030a0a 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -48,6 +48,13 @@ struct kvm_msr {
  */
 static const u64 canonical_val = 0x123456789000ull;
 
+/*
+ * Arbitrary value with bits set in every byte, but not all bits set.  This is
+ * also a non-canonical value, but that's coincidental (any 64-bit value with
+ * an alternating 0s/1s pattern will be non-canonical).
+ */
+static const u64 u64_val = 0xaaaa5555aaaa5555ull;
+
 #define MSR_TEST_CANONICAL(msr, feat)                                  \
        __MSR_TEST(msr, #msr, canonical_val, NONCANONICAL, 0, feat)
 
@@ -247,8 +254,8 @@ static void test_msrs(void)
                 * entries for each features so that TSC_AUX doesn't exists for
                 * the "unsupported" vCPU, and obviously to test both cases.
                 */
-               MSR_TEST2(MSR_TSC_AUX, 0x12345678, canonical_val, RDTSCP, RDPID),
-               MSR_TEST2(MSR_TSC_AUX, 0x12345678, canonical_val, RDPID, RDTSCP),
+               MSR_TEST2(MSR_TSC_AUX, 0x12345678, u64_val, RDTSCP, RDPID),
+               MSR_TEST2(MSR_TSC_AUX, 0x12345678, u64_val, RDPID, RDTSCP),
 
                MSR_TEST(MSR_IA32_SYSENTER_CS, 0x1234, 0, NONE),
                /*

