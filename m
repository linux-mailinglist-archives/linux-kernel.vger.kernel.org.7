Return-Path: <linux-kernel+bounces-825243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED0B8B657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C99C7BC892
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CCD2D837B;
	Fri, 19 Sep 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJfewO3r"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DC2D6E47
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318423; cv=none; b=lqzxYZ6n4Z00lfBWS6URhMHN0XUNclQBPnmgbR5MY1bppzqJ215ZZee1d3keVxP1WhSXCqkbIefjJX1+AAhQwoU+j6lv5deBc9aYiZU0DmrGNQwAXaIcfg6tfVYZ+hne7LmOYOlv6oeka8OTDBQw2jVnuLzgYTs2yrwlSnzUQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318423; c=relaxed/simple;
	bh=16+x8gKJYWU9PYPg12a5fTjyXHOpIBczokp606QGwBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flYUjnCdbpzmkLDiRMCvg3pRXXt+JYf0kp5D5cm7pX/46t3N9z6DbDA2oegCvEL3hXmu4teOnuadW4aJR6rrO/wvHtehtaJq7pj1x0o/Tyr1B5jjBNTph9F4e4oGRWX4FZLyDVUqQdwgIqDeZeCMxXGxPAlpO5eAmxF4aa4/Hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJfewO3r; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so3862482a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758318421; x=1758923221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9ANuRULzY4faq2GOHvJW0TGZ7gQes2um2QVNplpGbWs=;
        b=BJfewO3rA/GkMv7hzPsZG6HnsDiZRM2kUGdXs1T5HbDUDSDEgnaN+yBntxKwR8MLr7
         g89xmNJC5ISCN18VA3/EZE3Fvu5Dtsp2rjl9fLL2tHXVm1PsG8wpHsUtWN6mWrltUder
         dY1nGop5ZRiyhND/MHRBslORlNROR3R8DxxcZWzv63jg+CjARMrrM0UX3GLDGw1E/nah
         caFHNePwc5SH3apBvvulMDW7Pihaq86MU/qLhpyh301NtCbRQLr8QldoPoNboQQhLYZP
         qN1pTxneWt8qNEIORsJIedL0PQCCWpYBlKRTU3vMmzPWmn5ek+wdYVHgEh5Oqr5/JbEc
         GjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318421; x=1758923221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ANuRULzY4faq2GOHvJW0TGZ7gQes2um2QVNplpGbWs=;
        b=dtGAHfX6l7SaVaFdExeVdGyyoBRPyOxBtaenHt0CpMMHPqc1MQ1TyrGXS+dZ+GjSnl
         tZi7/eHVyKffcis4AgHIplL/eW/ePpDtFLDOK5HYMi8sCLpYPdMTvr8vO/kiGkIEkGgY
         JbVvllWVX78yQQJXo8FCEXQLDYAYq4qLku2AJ17YLVSzk5iEGEQjHIjhBI4Qfio7vvRV
         2t3m1xR+51A5QdEi3sLKBo78SWB2s0e/jUzXIbCs2+8VQjCMxLod2dlxEOHSkb49Jsy3
         dNbrUzRGxqR9doCsJwK5be6ORdavbeILprlwmgtiEzEIufTxW4zETWUzufcyEuDDtllm
         L4PA==
X-Forwarded-Encrypted: i=1; AJvYcCWupTeYXG67z64NmGZAZmpwWvrUPuk3cyPiGATaLNEQZzN4y81H/51y1lbxIPIJ2h7uYf4EEisSZ13nZNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUdPgQDtiVmAsMuQnOB1JaqLVEEtrhuytud6RgxCAC1F/CrBuJ
	4MDN2p6n+IW5HlxMOB5y12jtwe47iNzc8iinpiGxOVlWxAKgnHosI7cMTYw/LFhTBmBLH0WjSp6
	0CRoOCw==
X-Google-Smtp-Source: AGHT+IECEzK6py9UKSvGOhiFnbTb21+x8SjItwwWnT94IjQkhtLba5KAfNspRMad77h4qi2L8OkhpZfG2/Y=
X-Received: from pjx11.prod.google.com ([2002:a17:90b:568b:b0:32b:6136:95b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f84:b0:32d:f352:f75c
 with SMTP id 98e67ed59e1d1-33097ff63f6mr5260952a91.13.1758318420821; Fri, 19
 Sep 2025 14:47:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:46:46 -0700
In-Reply-To: <20250919214648.1585683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919214648.1585683-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919214648.1585683-4-seanjc@google.com>
Subject: [PATCH v4 3/5] KVM: selftests: Reduce number of "unavailable PMU
 events" combos tested
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"

Reduce the number of combinations of unavailable PMU events masks that are
testing by the PMU counters test.  In reality, testing every possible
combination isn't all that interesting, and certainly not worth the tens
of seconds (or worse, minutes) of runtime.  Fully testing the N^2 space
will be especially problematic in the near future, as 5! new arch events
are on their way.

Use alternating bit patterns (and 0 and -1u) in the hopes that _if_ there
is ever a KVM bug, it's not something horribly convoluted that shows up
only with a super specific pattern/value.

Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/pmu_counters_test.c     | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 1ef038c4c73f..c6987a9b65bf 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -577,6 +577,26 @@ static void test_intel_counters(void)
 		PMU_CAP_FW_WRITES,
 	};
 
+	/*
+	 * To keep the total runtime reasonable, test only a handful of select,
+	 * semi-arbitrary values for the mask of unavailable PMU events.  Test
+	 * 0 (all events available) and all ones (no events available) as well
+	 * as alternating bit sequencues, e.g. to detect if KVM is checking the
+	 * wrong bit(s).
+	 */
+	const uint32_t unavailable_masks[] = {
+		0x0,
+		0xffffffffu,
+		0xaaaaaaaau,
+		0x55555555u,
+		0xf0f0f0f0u,
+		0x0f0f0f0fu,
+		0xa0a0a0a0u,
+		0x0a0a0a0au,
+		0x50505050u,
+		0x05050505u,
+	};
+
 	/*
 	 * Test up to PMU v5, which is the current maximum version defined by
 	 * Intel, i.e. is the last version that is guaranteed to be backwards
@@ -614,16 +634,7 @@ static void test_intel_counters(void)
 
 			pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
 				v, perf_caps[i]);
-			/*
-			 * To keep the total runtime reasonable, test every
-			 * possible non-zero, non-reserved bitmap combination
-			 * only with the native PMU version and the full bit
-			 * vector length.
-			 */
-			if (v == pmu_version) {
-				for (k = 1; k < (BIT(NR_INTEL_ARCH_EVENTS) - 1); k++)
-					test_arch_events(v, perf_caps[i], NR_INTEL_ARCH_EVENTS, k);
-			}
+
 			/*
 			 * Test single bits for all PMU version and lengths up
 			 * the number of events +1 (to verify KVM doesn't do
@@ -632,11 +643,8 @@ static void test_intel_counters(void)
 			 * ones i.e. all events being available and unavailable.
 			 */
 			for (j = 0; j <= NR_INTEL_ARCH_EVENTS + 1; j++) {
-				test_arch_events(v, perf_caps[i], j, 0);
-				test_arch_events(v, perf_caps[i], j, -1u);
-
-				for (k = 0; k < NR_INTEL_ARCH_EVENTS; k++)
-					test_arch_events(v, perf_caps[i], j, BIT(k));
+				for (k = 1; k < ARRAY_SIZE(unavailable_masks); k++)
+					test_arch_events(v, perf_caps[i], j, unavailable_masks[k]);
 			}
 
 			pr_info("Testing GP counters, PMU version %u, perf_caps = %lx\n",
-- 
2.51.0.470.ga7dc726c21-goog


