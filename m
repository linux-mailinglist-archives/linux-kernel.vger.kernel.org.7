Return-Path: <linux-kernel+bounces-771887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1FB28C90
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4740117618B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A828A1DF;
	Sat, 16 Aug 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTLLz9dT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD511289816
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755337559; cv=none; b=lcoL9DH/InrIrF8dVncia1l13v23atx0g7IVm16JfCV3DsWvG8avPDVjBYNzvQkWtorctSPp8qdlO/jn5EoDXiAkXX5tRp9H7St+yk39xxTpML7N6mFA8RlRQbcrCr3nZOoK1Aq2pNwi09Ki2lnYP2R444Vr5D/0qhquclr8SLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755337559; c=relaxed/simple;
	bh=D9E1Sdc+bFrheEgUcIxJpALM3s/yzTgSbrMLVCO/2mg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=odmNcBJx4c2piuhbekqG85hXK2fDJcOgwNsRuyRdpQxPncJKmMBrRc/0Hd+ZqoPI4GcYGG+bcnN+jcNeBQiuANuMrJKsqwijJAHOrEJLbmU03oXcAOSOsdPTI4uCkn4JssGumKNoJ81xCVQ3vIi6IxDHhkvnstYAxxYnVi/R6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTLLz9dT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174c667aso2229788a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755337557; x=1755942357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uZHGYUzDoUC6aImN9JZ3dd5lPuQ3tp3WIMsPX/nZ5KI=;
        b=OTLLz9dTvjUAwVKfREA1bwjXNbQGLAZ4ghjmTRtizH3TCgh96aWRnWjQfQWfvzKuo/
         94qrKvFxphyvLGr80aRDspyo3Og11IN4qVMc4sc0AF1cr0cjk6YGM7mTwwONV+x8sBwb
         7joYpopUlw6vS0vNHkKde1ZSh9EBdGhOy4dvM1tWXbJFqP8cYA6L9p9G3Y0Di3H/V8wp
         u2xNCBuyw8HCmB2ftbX2CBVnpM14RM3mciA5MFttskzzxzPU2wP+4IsdXYxSImow1TPc
         6PfwSkrG4VI9eTzs7vT8Ech72Ncpk0SBkHKDsbeI3vEKqF8TEMQuDnUzp/nJkNDhypHM
         692A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755337557; x=1755942357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZHGYUzDoUC6aImN9JZ3dd5lPuQ3tp3WIMsPX/nZ5KI=;
        b=lmNooclLEyQMyXeLpZqXftEwdxAvlQejfIp0mfrqMCWXLlab+m0b1NlW0NZtu4B+tw
         RlnYS9oFhR92qgLlRVHwljPbxMKIoYmUuKBlPQICU+ZCqRVbFUDI2TzJY5MuKiAaoy8Y
         Enm3g9EYSX0PTd+Os3bFlPJ7OQOn3lDpshEfKm+LRRdugbQ4ZkO9vnNKCO6USyIuMQGo
         D1ljb4MG9uI3zCnjXmvaNX0rXi3S2JOORNySoOumy9enHIjhcaqkB/q3jzo4E15ZiAxy
         jlD0ZDboK3NDezDgYE78e82WImOvrwuIK0mYMjiMDMLm0v7SW2HnKlq5p3BKrXctp3Xj
         84Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXAEjUlfovxqJBymBz5feyF7l3dk5Fh5lzpR3+y6zBTxT/+A2lk5BQoIU8rGGHlzar7yUrv6qxFbOrg950=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8Zl+EZOQ++v6ZrUNIItWhoiQcvLQlIDXzJab0vaJ1aLoInID
	adErszo52o8njF5EvcU3rkA8f/wWnjzlfpS3M0xWWrUnOGlEbsOGNDjERyJXI9ItYHSjpJElGva
	eR9eR7Br5wWmXjg==
X-Google-Smtp-Source: AGHT+IHDPVPEatlxcF4io1U5PXBqiRWFqj78UBNij14JEJ5PCzJdGppshbMzlIiK12O5f7T/RLdVgFYw9kNljQ==
X-Received: from plblg11.prod.google.com ([2002:a17:902:fb8b:b0:240:3c5f:99d8])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:230a:b0:23f:cf96:3072 with SMTP id d9443c01a7336-2446d8c5dddmr73728925ad.26.1755337557083;
 Sat, 16 Aug 2025 02:45:57 -0700 (PDT)
Date: Sat, 16 Aug 2025 17:45:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250816094528.3560222-2-davidgow@google.com>
Subject: [PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST
 by default.
From: David Gow <davidgow@google.com>
To: Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

The new irq KUnit tests fail on some architectures (notably PowerPC and
32-bit ARM), as the request_irq() call fails due to the
ARCH_IRQ_INIT_FLAGS containing IRQ_NOREQUEST, yielding the following
errors:
[10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq_test.c:88
[10:17:45]     Expected ret == 0, but
[10:17:45]         ret == -22 (0xffffffffffffffea)
[10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq_test.c:90
[10:17:45]     Expected desc->depth == 0, but
[10:17:45]         desc->depth == 1 (0x1)
[10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq_test.c:93
[10:17:45]     Expected desc->depth == 1, but
[10:17:45]         desc->depth == 2 (0x2)

If we clear IRQ_NOREQUEST from the desc, these tests now pass on arm and
powerpc.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/irq/irq_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index a75abebed7f2..e220e7b2fc18 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -54,6 +54,9 @@ static void irq_disable_depth_test(struct kunit *test)
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -81,6 +84,9 @@ static void irq_free_disabled_test(struct kunit *test)
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -120,6 +126,9 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	data = irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
 
@@ -180,6 +189,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	data = irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
 
-- 
2.51.0.rc1.167.g924127e9c0-goog


