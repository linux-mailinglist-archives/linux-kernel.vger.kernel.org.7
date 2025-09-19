Return-Path: <linux-kernel+bounces-825242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95842B8B64D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA17C7BC0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A92D6E4E;
	Fri, 19 Sep 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkLxB4of"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79D2D542B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318421; cv=none; b=esasVMvoo1CZ7ndB5uIzSFk1ufzvaD+cidIIY37eTllLdSTN2RI9YMPn6MbxcE2u8Cu2qHn+MYVqZ7Ael+BAjRZbXfTvm+i4ci++LlHveNJXYmm9pq5qDsoJDr2oha7tfUHtkjkUUy6xjiMzv/G0cE+ijhg2fUUjNQy6SgHzLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318421; c=relaxed/simple;
	bh=NddpnuKAkAmk4MRD6KjS6LY4WcUZVoPMjThIO83KgT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dffAksLk/wiya9PHes5CWTGxJiFCfDUMBdfoRFoBRqIi4BdsA8c7o9fM6W3yyl1Ks4yAzOluthfveLOkSEBhlafwIQicp2ZKpOYprtHRFWPZSsUvwmoeWVVU9hJAErO5+tKUaXXwxSeC3lhzXoMU7CR96tiuCJBuWoHDQuPJ/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkLxB4of; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so3862463a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758318419; x=1758923219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AhTNYhBvmR83TcB5Eza06EfqGOvKS3T4kCXPtcIUOWM=;
        b=TkLxB4ofmQOsDqn0LXiFVo5v+KcSpVBC2XV+lSBV7xeTJn7wlORuDVyp8OaKLwy4Rv
         u/0nwJYDSZemjDMA3NNfuw2czThn24miTqX0vnyx+eJ5Zg+AXtYqJ6xmcaIrLvlKUPHd
         cizt6EEO82sduV/fhOhdkcEvSjOi2a57AicdKHvtLxUV8Hm8cM/PwXnSiN3iz4BBAolj
         rVBXAE490Y8deTjAKRnBU7l4BBAzizSnLDatF+qL7NnVSTxn+c4em/unvF+68If0Nc7j
         mcxkw11T9uEgpHp5MAlK6MdVMvGuzhqu2qn5dYhAZNGcRaROR2ZQtzxhNSjj37p7Ncvg
         83vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318419; x=1758923219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhTNYhBvmR83TcB5Eza06EfqGOvKS3T4kCXPtcIUOWM=;
        b=aGGECFK8LSO58xCPsIYjd6ugWXG/LUVrgX/G2+7QAVeImW9oNhfs7AuVga3B8f5yK0
         6o2+Y8V+nd8aHvYOu4FgvZU0kb3YGDlMea85UMvsL3iFLg23aZWemeIUqwQre98jWqnM
         0VVLJZI+ML7Z6/vMAxx4IIELxYyP0sWhBM5H6cC1UeXufgbtR9lADzoYol52sm2C5Fkw
         S3Hbx+W7Qif7biCZln5mZ+uhRQY0H7hDQRuYwULEwuRCe1ZW6WXDqoyi/Jjywu6OUvdl
         qtiAXmm2meTyLpzBwEJ1/YdgeaFEeA9ptoJVcZ4FNmJ2mJTyJPtIZw+J4xtUJufw5QCM
         m0YA==
X-Forwarded-Encrypted: i=1; AJvYcCV+SR7WpxPE9xC+lC3UoI86pZYbAueLs2FxUpzo7kuXsR/7fu4iPncQi52427rZCK6PGrARMeC0kfoW+vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyheeA/zjC6W5HbNsKlWVdFGP7wSyX6kzpeFfK90wokU/9SQG
	vYcfR+nNBbX4B2JS+03/tFPAKM0pA77J8U0lrersrSHsWVObdw6VX5GYwKMLIfIt5shoLdFjw9H
	kycnqkg==
X-Google-Smtp-Source: AGHT+IHmKkAcRujSaa/deGElAZSnSbNr626XHKP7okVTyvwJsPrhF/HPMRr/4yIOYDoc1jwhfznVT0Y/13E=
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:32e:c4a9:abe0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d604:b0:32e:4849:78b
 with SMTP id 98e67ed59e1d1-33097ff67b9mr6075438a91.16.1758318419110; Fri, 19
 Sep 2025 14:46:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:46:45 -0700
In-Reply-To: <20250919214648.1585683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919214648.1585683-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919214648.1585683-3-seanjc@google.com>
Subject: [PATCH v4 2/5] KVM: selftests: Track unavailable_mask for PMU events
 as 32-bit value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"

Track the mask of "unavailable" PMU events as a 32-bit value.  While bits
31:9 are currently reserved, silently truncating those bits is unnecessary
and asking for missed coverage.  To avoid running afoul of the sanity check
in vcpu_set_cpuid_property(), explicitly adjust the mask based on the
non-reserved bits as reported by KVM's supported CPUID.

Opportunistically update the "all ones" testcase to pass -1u instead of
0xff.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/pmu_counters_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 8aaaf25b6111..1ef038c4c73f 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -311,7 +311,7 @@ static void guest_test_arch_events(void)
 }
 
 static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
-			     uint8_t length, uint8_t unavailable_mask)
+			     uint8_t length, uint32_t unavailable_mask)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -320,6 +320,9 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
 	if (!pmu_version)
 		return;
 
+	unavailable_mask &= GENMASK(X86_PROPERTY_PMU_EVENTS_MASK.hi_bit,
+				    X86_PROPERTY_PMU_EVENTS_MASK.lo_bit);
+
 	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
 					 pmu_version, perf_capabilities);
 
@@ -630,7 +633,7 @@ static void test_intel_counters(void)
 			 */
 			for (j = 0; j <= NR_INTEL_ARCH_EVENTS + 1; j++) {
 				test_arch_events(v, perf_caps[i], j, 0);
-				test_arch_events(v, perf_caps[i], j, 0xff);
+				test_arch_events(v, perf_caps[i], j, -1u);
 
 				for (k = 0; k < NR_INTEL_ARCH_EVENTS; k++)
 					test_arch_events(v, perf_caps[i], j, BIT(k));
-- 
2.51.0.470.ga7dc726c21-goog


