Return-Path: <linux-kernel+bounces-823827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC3B8786F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056E81B27E89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53861254841;
	Fri, 19 Sep 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WexQMwAy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF924A043
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242720; cv=none; b=DatUf8uFnoXEdPs8vSseoZe/4h9Juf4Jcm28dN/SnFh4w/DUhUZVr7p1+pqIdnH6R8zmpnUm4T9idwXMFHwm78fgh8fEP+3vxPDZORjpMFFsoHYSgwZgVHKDUAKmFNxl2fZ0mq2oaaYrxB50hCp2UdpPLLcK+OAzlfAvJe0kxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242720; c=relaxed/simple;
	bh=n0lGTXdJXDqaN89mbd7Okod6ZlkW2k1r1YS8bLqSbb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N/yQnr+CP5ko77BEN68nLpyLyLXGDIolhwMDL0Z+WSIm1kfn0H7PuhzETntvc/Ap7yUtRS+N9HJCUwcz7EJlCV8D5nrY+KR0KETqvzfiEjxjPyaDMhS6hYuXugijuJKQiUd67YYCkCKpJqAoK3VHzWmvMvDIju5V1VGetGdiw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WexQMwAy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32edda89a37so1551546a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758242718; x=1758847518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jN6rhPeVGRVi73ZHie02xg4mhMvvpNhrGmG7Qp0E2dY=;
        b=WexQMwAy8wBZLZ8VtAcAYSuQUx8pqKIWKbQtX7zI71Ib7F3V3VILHAbkRO7Xn+FLOg
         52w+c5JTHiXU1WH8KZbIdMKUuj1CuSXSTf33itWt41/ysmGEWjjk4aZa8xMRmNUGJvY+
         E2M68ygh2Dw22hGu76gkJMEEZZ73LrvUy+ZgfN7lVZCQAFER7RBnskngmhNM3hMFkS/c
         CON3hmbBycUGh4RsD8PHhAWr7lPIN2jvn/VTx2u7K5avzvRSLQwnAIOcq8ROJ2DeLIv8
         rFhrIGshrFTiiHwWLZlI93s0YxZQ0F0AwqXH2ltkGoyO21r72pLvyz3IvoxAwdGFgEig
         6JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242718; x=1758847518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN6rhPeVGRVi73ZHie02xg4mhMvvpNhrGmG7Qp0E2dY=;
        b=aclt4CFJyo47aVghkwe2QvFZugazp8aC5MwmQMylV8BQOGfowr23OlJbAOi5qDtit5
         Yqks0Cb8+Dzk6Wd3tlGZoF5gF6TLHCloDOTc0ArH4P4J7Y8uAWtn+22M69aTUT+NiCyU
         cYnMlzP1zncrOSlq2Gp6NYsvqkY8h0r9nHqneTQ9OgVGZNyTkykDd19W7K3fH9v6pPvd
         ct6vYbSJZ9DQ1TrtQA13ZlazKyoOx8X4u6cVFas0mv2BjkZV7RwYF3vOn8Ks/4THuyWd
         7wwjTON0oRj7zyJw6kJmQQyapG4BTN8BCxS5/R6ZZYmryTQC7Pq+p26tKTwS4LAJCuY/
         dw7g==
X-Forwarded-Encrypted: i=1; AJvYcCWT/eTLWXPUhMJfnFXlBj9DsUo96lGrxmSX44h/2BgFpwLP4y7thyRAleX0cGXgoZXbAaOgUtWXT30pAJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkQOVeSVLB0D+tnI1J1D2T/NSPheJ8NItc/GZVCSUXXLWfE2Y
	bY/bHARFo1LzAdkEKGO0MTYP5PhwunHf24Fz2B/RXZrLx85t/WjXumOhchKsADqo08eNuUcZdyf
	AHzwQYg==
X-Google-Smtp-Source: AGHT+IHfM7qCYUHfiD5AV0H2ir90EI6DDUYjXYxQmhPxyE03eZSP5eh6GJQ146r0RZIYnzEhBfVolQcpFIk=
X-Received: from pjcl16.prod.google.com ([2002:a17:90a:3f10:b0:32e:cc38:a694])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b50:b0:32e:859:c79
 with SMTP id 98e67ed59e1d1-33097c2d656mr1882865a91.0.1758242718385; Thu, 18
 Sep 2025 17:45:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:45:09 -0700
In-Reply-To: <20250919004512.1359828-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919004512.1359828-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919004512.1359828-3-seanjc@google.com>
Subject: [PATCH v3 2/5] KVM: selftests: Track unavailable_mask for PMU events
 as 32-bit value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>, 
	dongsheng <dongsheng.x.zhang@intel.com>
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
index 8aaaf25b6111..cfeed0103341 100644
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
 
+	unavailable_mask = GENMASK(X86_PROPERTY_PMU_EVENTS_MASK.hi_bit,
+				   X86_PROPERTY_PMU_EVENTS_MASK.lo_bit);
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


