Return-Path: <linux-kernel+bounces-782597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C0B3228F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12F43A4C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFF2D0C94;
	Fri, 22 Aug 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bcXKEibR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A422C158E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889314; cv=none; b=WSu8GXuAHS98+mpYS17ZOg1cX9XCV2+jfpqyKgGBSxxlkYNnXy32HktTugL8T6iv93pPIcZLG6zTRimbbLaEOWXcKqyiRqacixQB/bRHf2Gun92QLI7BzwPdDnTMsfXglSlNDPn1B7wRjuNJZJtXhLQ5b2SHrVn9t6KFnWzCl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889314; c=relaxed/simple;
	bh=s8o27wutxxP824eD7n2DJmP4a/bKEEeG15vJQ/GWeAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1FLtJHwmnuILBlrETKEvu7X5jJrV+2Aw9nylpeVGUneDfu9TH8jGwfa8fjfmk6//n2gMzhPfIMD+if6NxC3n1huJ9qeZRmVbZrGkZkcqvaBUsjgxjOetE2vtq61Wy87RPTuAnuWDaGm3AxQi9q+tyAmkSKSLC/Hdv0ZGJNp39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bcXKEibR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7702fc617e9so1080266b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889312; x=1756494112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P5K3mPltz8r7A6bRlNvjhmzHKYbAkNrG3FC1k+yO8g=;
        b=bcXKEibR/TOW4qQhkN0k+oygixYmrzSTkzdnmuD9scGEhlHTz/h5mL29tYvcCyM7uj
         4jiHB6F4M4wOoQ2Dl9rH0+mfZQRbP1Mest9WJLjv1jOCFgbuwldCWY/2vt0lYOL8HNF4
         4mS8tCBvR74HwqU0gk0wrdYKJkRZxGjXtMa08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889312; x=1756494112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P5K3mPltz8r7A6bRlNvjhmzHKYbAkNrG3FC1k+yO8g=;
        b=YpJCcK4AdNoGJFXm9llIjRq66/3E5Gy8oXdJSvvu9f62JzUO6DU3HdC3eEbs/YCn6K
         IxxoUC4DcC07bT/Q4U9e62zHJeM07+2xQ7nIBbAw9Shwpzy0ojNrGtVeCMU1f/yVErbw
         dCzRQ5enH+7q+NYH/yKrwm1em0brWLYXtik/QAWGuA3R13IoQ38w9739hTTyQgPhkac2
         +ungcYf5HpgtsatkV9NoS7W3m+j1u5TLduSt7Fm7lJ20n8RQfZuSMT4Rgb/noxrMKK0y
         eIydevGZpjrRCWFWEEzX+f25UZV9rGMugX0At8US/vh1YA+f9+XLKl4wvaM0Foh/zmep
         SAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxObgZauBNdbjSzMr6lQ79TarxLSPLY+h+HPMiKaAA63kEqADZogHa0+O47kHEWhNzG426MEkuFJGa8lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLp7qj6cPIBP5p8q0MEUYYXWHksmyd7BZ5qwJDBAJUyPLrqd9
	dT/jV634oLoUCvRjoq0wHqh8eqJcURSOvDUoK/BIJHBDJCW8v3LZVTu5qYaAscph+A==
X-Gm-Gg: ASbGncsYt4qBCajeJnauX6VP1gNO6hIRMu+Nxy5wtLJt6hfQn5VCvDFZORDl6mJ0uKD
	Q4LDRWSEIEMAYQaGXFJqNzk/Hq0JUXIMQhQCo4YiGZ7Jt9im7rvY45rLtsnPUy4V66/yjUIIWeh
	ClE5trVDYwxziE94nCDpMUy1ajQ9psXC9UYUVFOPM5rsHcrRSC3i8sDPnOGgggZC5Fvvg9BfYCT
	4QHrO0FczCsG+a+sWL/+UF6g1zOx9237I9ufAvT4mjYP6nj6HZ9lm8tQgRHNlMN9Zbl2cLYQxZF
	EiQC2NMoWKE/R8JBdceb3Dtmbixl/7jpNZgOpSrF4uoemA0WLd94M4jln72Y6331c2WXz/lZAFN
	aMeagCFTVarwj2uhhsS+HhOThTb7Flc1IceWCHAXjvglzyFyBqN2kFHgsrxQ=
X-Google-Smtp-Source: AGHT+IEyL7CtRorFuyVMJrXwp1XmudkMytMaot7DDilcf3dCUoF43F6oklAUdmg5o84LFLbzCjs4pA==
X-Received: by 2002:a17:902:e888:b0:240:a54e:21a0 with SMTP id d9443c01a7336-2462ee13154mr57026715ad.19.1755889311840;
        Fri, 22 Aug 2025 12:01:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-246688801bdsm3186255ad.123.2025.08.22.12.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/6] genirq/test: Factor out fake-virq setup
Date: Fri, 22 Aug 2025 11:59:03 -0700
Message-ID: <20250822190140.2154646-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
In-Reply-To: <20250822190140.2154646-1-briannorris@chromium.org>
References: <20250822190140.2154646-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to repeat a few things in tests. Factor out the creation of fake
IRQs.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---

(no changes since v1)

 kernel/irq/irq_test.c | 45 +++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index e220e7b2fc18..f8f4532c2805 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -41,15 +41,15 @@ static struct irq_chip fake_irq_chip = {
 	.flags          = IRQCHIP_SKIP_SET_WAKE,
 };
 
-static void irq_disable_depth_test(struct kunit *test)
+static int irq_test_setup_fake_irq(struct kunit *test, struct irq_affinity_desc *affd)
 {
 	struct irq_desc *desc;
-	int virq, ret;
+	int virq;
 
-	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, affd);
 	KUNIT_ASSERT_GE(test, virq, 0);
 
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
 
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
@@ -57,6 +57,19 @@ static void irq_disable_depth_test(struct kunit *test)
 	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
 	irq_settings_clr_norequest(desc);
 
+	return virq;
+}
+
+static void irq_disable_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq = irq_test_setup_fake_irq(test, NULL);
+
+	desc = irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -76,17 +89,11 @@ static void irq_free_disabled_test(struct kunit *test)
 	struct irq_desc *desc;
 	int virq, ret;
 
-	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	virq = irq_test_setup_fake_irq(test, NULL);
 
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
-	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
-	irq_settings_clr_norequest(desc);
-
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -118,17 +125,11 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	if (!IS_ENABLED(CONFIG_SMP))
 		kunit_skip(test, "requires CONFIG_SMP for managed shutdown");
 
-	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	virq = irq_test_setup_fake_irq(test, &affinity);
 
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
-	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
-	irq_settings_clr_norequest(desc);
-
 	data = irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
 
@@ -181,17 +182,11 @@ static void irq_cpuhotplug_test(struct kunit *test)
 
 	cpumask_copy(&affinity.mask, cpumask_of(1));
 
-	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
+	virq = irq_test_setup_fake_irq(test, &affinity);
 
 	desc = irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
-	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
-	irq_settings_clr_norequest(desc);
-
 	data = irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


