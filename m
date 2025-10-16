Return-Path: <linux-kernel+bounces-856708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBFABE4DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4F2188424E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF332B9B5;
	Thu, 16 Oct 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8Y5Jpwg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451232B993
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635823; cv=none; b=Nod39Whj2O0ifhnmBNEvtF18x+1QgQFpcj8mEZF1Ju8QhfQQ+oTKpzKdJXFhut5403HW4eSwWrUm/s4JANYVshVpvDGVrDgOyB3VzNB4VMgCDq+EHUHNiSA97Gt8cR9U7K5Rc3imNCu4Qg5gdZsKGNoPJmno+QAVDaKb0NM5kFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635823; c=relaxed/simple;
	bh=+k5e0Sea10S5Qat1scXRV+R+j3jkE6pkdq3dHOcJZR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fEsJA0sS/EpDNYcjvjngHO8Pt+K6wzfddMnnyxENEugFlhpdHk0rdrxWGQaV/tdARcdZ4gIFgXvZOX84lh+CM78khrD5ndwMKZoaoFlCxwXwu/FjZZ0E7PLdKSMqpdasuzggRRSb7vTWcuc1dTK2n2bYYaLtSVRoP/a3DtKTjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8Y5Jpwg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b646768eso1200483a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760635821; x=1761240621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zq1tgXWhdaEPjv5XRrUDfAt6UbT40u8GeEVyLVyfpR8=;
        b=j8Y5Jpwg6uf6ns4sm/5U8+D4OsCb9fGfs46cHyogS/ZAoWKDMqiUOVCfwZLrSzYXQG
         A+aeUCDAHyX8Z3jfc151lc8NkvcN2VqgP4k2R3C4pokzJ/JFG5MhupGAzzmEPB67Z32j
         qJpOfE74di3rsmehwT47i929IoHAZrc613s33NIRC3uGpocHSVPxY2HbmPP48nF+hYC3
         9nsxIBBB13JScL+MzqIecAb77w2Mr+3eDIZszmU8BlFduCoUGHYOkGlyRvpQ9sTh5pR1
         Emxq0aE2yRirJIpB5ScC6q4cKB4WRUbavFx3alP8b5pwKMjkoKq6apWdtFobCuembuc1
         l/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635821; x=1761240621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zq1tgXWhdaEPjv5XRrUDfAt6UbT40u8GeEVyLVyfpR8=;
        b=NxXiZQSpNx8SpQ7X0Ou6gZVwrZGpx/kLfrQ8LsXiSTSU2xV7vSd/IbTEctxtvU2RsY
         IpwzFvCxpb0rdooBsAcksvK2BM3Zm1Gd6HzxR6Ak5G+z2wy0cln8JJ4ij0AAor3vJpwI
         neDkNn8Ky/nsepfTZVA2vHrVYbRAaoBTAs5YFVQUEJBFWkhcgew2bTIhriwZwGG5gTQV
         QvtRrRWsPDZWymA7Q5ll4amB6tUzudMtWvJZxjd4XHJcmMiy3ojheYqlwfcYVgOd5Idv
         UNKygF/QOi1vFIa861Gi5idtY4Pu19Gcg2lxcFUa8YoHJ3QAHMJiilXmuS0x5nWNFhPx
         Cgaw==
X-Forwarded-Encrypted: i=1; AJvYcCU3sH5e76uG214EZj0sktx+Q2NT4HemdzSEe5yqYQP/nG+frfhPYKLDg3jrnEtgZA8GImnZzA9bkoBiL3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjdIIME7I4XcwXtiZl179ydwWyJ5D5x7FWE1x2e/MXs00RgWI
	eYNh4VQyzxl96jQRsoyvb3SMMRK3RyxzFcVyFggjb3eXnQOxlocvDgI0qyxExZ3fo2eMLrrzF+p
	YeB0tnA==
X-Google-Smtp-Source: AGHT+IEB/z+VBtg6OE+012RtMrAcNLRkjMeLsa6vSWEgt3UDRue4tkCjjeMMCGdXCD5ilhuA7eHznquW6sA=
X-Received: from pjzh17.prod.google.com ([2002:a17:90a:ea91:b0:32f:46d:993b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0e:b0:33b:c5de:6a4e
 with SMTP id 98e67ed59e1d1-33bcf853711mr677585a91.5.1760635821102; Thu, 16
 Oct 2025 10:30:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 10:28:48 -0700
In-Reply-To: <20251016172853.52451-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016172853.52451-8-seanjc@google.com>
Subject: [PATCH v13 07/12] KVM: selftests: Report stacktraces SIGBUS, SIGSEGV,
 SIGILL, and SIGFPE by default
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Register handlers for signals for all selftests that are likely happen due
to test (or kernel) bugs, and explicitly fail tests on unexpected signals
so that users get a stack trace, i.e. don't have to go spelunking to do
basic triage.

Register the handlers as early as possible, to catch as many unexpected
signals as possible, and also so that the common code doesn't clobber a
handler that's installed by test (or arch) code.

Tested-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8b60b767224b..0c3a6a40d1a9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2290,11 +2290,35 @@ __weak void kvm_selftest_arch_init(void)
 {
 }
 
+static void report_unexpected_signal(int signum)
+{
+#define KVM_CASE_SIGNUM(sig)					\
+	case sig: TEST_FAIL("Unexpected " #sig " (%d)\n", signum)
+
+	switch (signum) {
+	KVM_CASE_SIGNUM(SIGBUS);
+	KVM_CASE_SIGNUM(SIGSEGV);
+	KVM_CASE_SIGNUM(SIGILL);
+	KVM_CASE_SIGNUM(SIGFPE);
+	default:
+		TEST_FAIL("Unexpected signal %d\n", signum);
+	}
+}
+
 void __attribute((constructor)) kvm_selftest_init(void)
 {
+	struct sigaction sig_sa = {
+		.sa_handler = report_unexpected_signal,
+	};
+
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
 
+	sigaction(SIGBUS, &sig_sa, NULL);
+	sigaction(SIGSEGV, &sig_sa, NULL);
+	sigaction(SIGILL, &sig_sa, NULL);
+	sigaction(SIGFPE, &sig_sa, NULL);
+
 	guest_random_seed = last_guest_seed = random();
 	pr_info("Random seed: 0x%x\n", guest_random_seed);
 
-- 
2.51.0.858.gf9c4a03a3a-goog


