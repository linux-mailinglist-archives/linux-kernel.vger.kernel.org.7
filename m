Return-Path: <linux-kernel+bounces-674351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73020ACEDCD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB22188A939
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66E224B03;
	Thu,  5 Jun 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFxvB3m/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4848218AD1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119828; cv=none; b=MebMZ1FU0kU/fr7t2Lhhnf79pn5mTT474mbA2VHPpz2WJ6tq9RsZ7ROXUMD6HclaArkuXmXfm+0lGKw9o2Zcc3H+Zqy8Em/MZWZTxcBmMmvdFUTWO37VzbySbic58WGrolCO+gl8/J1Ciuo6y0C9Xd6dVKsXRSUYL7gxLIW9eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119828; c=relaxed/simple;
	bh=KbwWFQ1kTo+qRw1U/gTjGAckXKWUWt6XmW7dlBGCSqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDskZpN9UBZFiEN2DKPzmQC07UKbBSQBZC5AomOJv/AGzx6LdgK+zhS6lI8qrX98KwzzpNtJHTpOQfpQUaeUxH61d5z4P7p9SfqT218C/XxdiAhsQpuRJX4PCTYTwuVE4F3ChVFaJETpyMGgevAH0OI1/JrHWjDBHrIqYMDPEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFxvB3m/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amWbxwyASZoUP07CpGcLTUSUvzxbgFk3ulFVLl61SIw=;
	b=UFxvB3m/NmZFQ4HCFPecHfmIpmoMLhnv+SFZIVy+/t+Z/9yLA88T0Be5ee99ubrXV1jv07
	lFtYxtvOXnJbZ3LGm1tqjJnQy88BSB8yEzGKk18fHOUXNeYQgmBZPBe94A3o0p1YqhIj+F
	BwzoZsDgK7Yd78q0ud+blzYtDaSWYWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-xwc6wXazN0yhvWpmIKBvtQ-1; Thu, 05 Jun 2025 06:37:04 -0400
X-MC-Unique: xwc6wXazN0yhvWpmIKBvtQ-1
X-Mimecast-MFC-AGG-ID: xwc6wXazN0yhvWpmIKBvtQ_1749119823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451dda846a0so5894075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 03:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119823; x=1749724623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amWbxwyASZoUP07CpGcLTUSUvzxbgFk3ulFVLl61SIw=;
        b=Bq9fWWP6bGf5jqC1o5Ong3HWu1cwton5tEKZy3mZbChgRAup+adbzT7ups4aPYW9jI
         xeHLVOYxhOLMglgA89OlJVHAos7OnH0cU+U8mFmWQGR9U0x4vr15OejE8g7C+6G63+6j
         2wYPu1mfbwkz5y5PdVQVmQq60N79rjMrM1f+C4tixNC2x/t1NueorEs2i+kyHJqH+vjm
         veSiz/0D8ZOnaAcH7me/c/2L2uwcnwndc7jcTLNVdJNBK7IA7NR/1b3OldFDMnDx3dgB
         +zFJP76cmRPbU8B76cQvjLjjNRV7VvOEOm+Oq0Xd93uTDrGKtrkil8HnIK5LYuTqAmcC
         dNUA==
X-Forwarded-Encrypted: i=1; AJvYcCWRVrEMcRB2V8gHqYjKLzEFsCCapr5hvUgVzLYnlzJe295PlTf5pjwvl9394JvAxeCXSU2RpHfl/WPJRdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhve1Roe+qLC1jWXZucP06lr+6uuKCyB+JKC24uD/lQDLrO/nr
	epDcPxI9g1eoP4UwucJRsqZHHxtBzfbTc5Bg8d8SMU5aeGR6KRnjXstz9HY0HzdGF/bVZ7CeXih
	0vss4N8/LUxbz5xWkAtZWM7hnxm8WDzgexKkEff8rpMn79FrJ5Zqym1ISrUbcFT0Nfw==
X-Gm-Gg: ASbGnctCoe6YVe4tRPUA5amg9R0L5eXvVST45zJlMJKNuAF5BI5JeZC3rX3bAKZUGvB
	N16iuMkX6zogU4+KlLr+y4ZbFfA8JGnlMga5VpuBrbxG/amr0BDbIVH1I1DZuAZOIOH4bXKfiig
	n/nmY5u8QCHoj8Ez5qPI86Qs6L+0dnU2hPmQ5hAzPjr+V6RgsJmXRhk40rVczxIrZvb1MKs8uF/
	1FvqYwMNevbGdaxJqw/JMqXimHRBzidImfs4hI1KpYq2p1OrllHdKf104VIqM7nXuD1d1PFmB/y
	q1zGMalf8QfladuY+2pV3b5nwH7nRC0OGx6HuJH6mSSVRaynMc1QfVaR+FfL5T9pfRfifCN3LA=
	=
X-Received: by 2002:a05:600c:3b2a:b0:450:d5c8:29ae with SMTP id 5b1f17b1804b1-451f0a72e7bmr51415285e9.1.1749119823021;
        Thu, 05 Jun 2025 03:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmtZcZkRv3ekScQM6gx63V+kNA53R9LzjK0Zl5xkWmfvukrEiqxBs91K876Y3Lvx+XWubrwg==
X-Received: by 2002:a05:600c:3b2a:b0:450:d5c8:29ae with SMTP id 5b1f17b1804b1-451f0a72e7bmr51414985e9.1.1749119822583;
        Thu, 05 Jun 2025 03:37:02 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm14105175e9.2.2025.06.05.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:37:02 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 4/4] KVM: arm64: selftests: arch_timer_edge_cases - determine effective counter width
Date: Thu,  5 Jun 2025 12:36:13 +0200
Message-ID: <20250605103613.14544-5-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_timer_edge_cases uses ~0 as the maximum counter value, however there's
no architectural guarantee that this is valid.

Figure out the effective counter width based on the effective frequency
like it's done by the kernel.

This also serves as a workaround for AC03_CPU_14 that led to the
following assertion failure on ampere-one machines:

==== Test Assertion Failure ====
  arm64/arch_timer_edge_cases.c:169: timer_condition == istatus
  pid=11236 tid=11236 errno=4 - Interrupted system call
     1  0x0000000000404ce7: test_run at arch_timer_edge_cases.c:938
     2  0x0000000000401ebb: main at arch_timer_edge_cases.c:1053
     3  0x0000ffff9fa8625b: ?? ??:0
     4  0x0000ffff9fa8633b: ?? ??:0
     5  0x0000000000401fef: _start at ??:?
  0x1 != 0x0 (timer_condition != istatus)

Note that the following subtest only worked since the counter initialized
with CVAL_MAX would instantly overflow (which is no longer the case):

	test_set_cnt_after_cval_no_irq(timer, 0, DEF_CNT, CVAL_MAX, sm);

To fix this we could swap CVAL_MAX for 0 here but since that is already
done by test_move_counters_behind_timers() let's remove that subtest.

Link: https://lore.kernel.org/kvmarm/ac1de1d2-ef2b-d439-dc48-8615e121b07b@redhat.com
Link: https://amperecomputing.com/assets/AmpereOne_Developer_ER_v0_80_20240823_28945022f4.pdf
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 .../kvm/arm64/arch_timer_edge_cases.c         | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index be8bbedc933b..b4d22b3ab7cc 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -22,7 +22,8 @@
 #include "gic.h"
 #include "vgic.h"
 
-static const uint64_t CVAL_MAX = ~0ULL;
+/* Depends on counter width. */
+static uint64_t CVAL_MAX;
 /* tval is a signed 32-bit int. */
 static const int32_t TVAL_MAX = INT32_MAX;
 static const int32_t TVAL_MIN = INT32_MIN;
@@ -30,8 +31,8 @@ static const int32_t TVAL_MIN = INT32_MIN;
 /* After how much time we say there is no IRQ. */
 static const uint32_t TIMEOUT_NO_IRQ_US = 50000;
 
-/* A nice counter value to use as the starting one for most tests. */
-static const uint64_t DEF_CNT = (CVAL_MAX / 2);
+/* Counter value to use as the starting one for most tests. Set to CVAL_MAX/2 */
+static uint64_t DEF_CNT;
 
 /* Number of runs. */
 static const uint32_t NR_TEST_ITERS_DEF = 5;
@@ -732,12 +733,6 @@ static void test_move_counters_ahead_of_timers(enum arch_timer timer)
 		test_set_cnt_after_tval(timer, 0, tval, (uint64_t) tval + 1,
 					wm);
 	}
-
-	for (i = 0; i < ARRAY_SIZE(sleep_method); i++) {
-		sleep_method_t sm = sleep_method[i];
-
-		test_set_cnt_after_cval_no_irq(timer, 0, DEF_CNT, CVAL_MAX, sm);
-	}
 }
 
 /*
@@ -975,6 +970,8 @@ static void test_vm_create(struct kvm_vm **vm, struct kvm_vcpu **vcpu,
 	test_init_timer_irq(*vm, *vcpu);
 	vgic_v3_setup(*vm, 1, 64);
 	sync_global_to_guest(*vm, test_args);
+	sync_global_to_guest(*vm, CVAL_MAX);
+	sync_global_to_guest(*vm, DEF_CNT);
 }
 
 static void test_print_help(char *name)
@@ -1035,6 +1032,17 @@ static bool parse_args(int argc, char *argv[])
 	return false;
 }
 
+static void set_counter_defaults(void)
+{
+	const uint64_t MIN_ROLLOVER_SECS = 40ULL * 365 * 24 * 3600;
+	uint64_t freq = read_sysreg(CNTFRQ_EL0);
+	uint64_t width = ilog2(MIN_ROLLOVER_SECS * freq);
+
+	width = clamp(width, 56, 64);
+	CVAL_MAX = GENMASK_ULL(width - 1, 0);
+	DEF_CNT = CVAL_MAX / 2;
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
@@ -1047,6 +1055,7 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 
 	sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
+	set_counter_defaults();
 
 	if (test_args.test_virtual) {
 		test_vm_create(&vm, &vcpu, VIRTUAL);
-- 
2.49.0


