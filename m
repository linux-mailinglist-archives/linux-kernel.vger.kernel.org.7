Return-Path: <linux-kernel+bounces-774391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C29B2B19F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D447AF222
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613B4274FD7;
	Mon, 18 Aug 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lytxawdF"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937A273803
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545295; cv=none; b=WO8rH5CYYkhR1unJk9G5OJPPeDL7OJ/KZl1cFQjcFN6uk2k0TIb8sgHuq61EhuEUcYqzfGvvKSJs1Ky0qgRWI5zXRwM7mrMXSmGrU+g37Pnbxf6dm+myVLlsfYMUiVuNctMDxzWv3jN97rmMaQQgc47ez4TPzT+us2igIEJtA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545295; c=relaxed/simple;
	bh=VCkEMcoNoMwv4mRKUx7SCnl6r7yOkb5KDdHWBarni5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcM3b2+q3PqpZsTHKe4ZJpY+jXaF8oKYYwpOE7RqLZ87s6IRusTBb+PpcA5YZK8DLkLQU4yFJjsRqCJsyA3HYh1FvBUVRBwRQ/+MiFRESFnzfly4NyzrQPM+2Q2qajbxDiZdDVhTqZRPt79+YLX1aiWpWxGBzd4zL/pKx2Pls9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lytxawdF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4746fd4793so1160612a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545293; x=1756150093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmUFyq7ul3dR2ebMA31ZpslE+HfQcyB/bqxP5tTBNZs=;
        b=lytxawdF4p/hDHyQNzwpsreaa+nUEUdXdkZutWVzdSfB11wioEcoxZTKGVvzklCvff
         8La3O/aCqhmYCDzA1kxCIgIiOj12tBeyDBiTqUx/gybLgBMPMNrz3In65BvNMunYwGzx
         s3Dywi36TGUpVzP2VpwE2Ljo30RYL7iw0F+o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545293; x=1756150093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmUFyq7ul3dR2ebMA31ZpslE+HfQcyB/bqxP5tTBNZs=;
        b=RA77SaUBdYfgqAMH1ifDEzri1sgUq3Fkhz5CqkiFpibV9m5DTaM+JHidEuXFznMwJB
         dwe+7LX1ypZSv8ko0UWx8pM7cB1eNBqoI5aZZ3PK4nGrjXSNVXdG7k/7y1zhOnTzuhxi
         RitX1kjeSrN/IAu5d8IBHYwW3k54x4TShpfxdqU0t04ov0jX65YQf63xHIRkfXkShVql
         cqkLwITzC1B9QFnouwtZzXXfPySTo+yll6y7eEkRRMacRQW70w/InqN2J1AjqjGFuzL/
         4okUjRth8Ai1UbDimGEQobCktFy7o/toC6Tft7I7a32n0/hfjWj6VW1/lHxeZtMcnv85
         7eXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcepxy26ZV9wzcVndaOKx+lzhN2tIdsnG6VGXcWsyPqo7GOfO4H7TQIQNPoIEKZf1uKvB4NDRA3mXMEnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/22DF7uZGIBr1X+HvkJLYyepeRJRnffgDTLFx5r2yUigsHIk
	kwcWn0npA5oQPU3ezAEBVvDEZEEuomeSg6p3UCke5R6a/iVF9Tj12E5oH0TlGmXZEg==
X-Gm-Gg: ASbGncu6AwrCNS1SXzMXCAUtidfM8Uu50J6Ea80c1OGAaam5UzrrbmAsoLUgrtAV2dD
	k8PNd2bwZNguyRrguNs34oJFUPk63ZM5D0GxZJRN1b8bkUqacK/m1cw2rSI+VZ2qwqbAR2kkEXs
	xMzbyX4jHtvKlFxwRhW+zcWFk+LPyLCqODSPdD3XBWGe9Ls1lKZDSjTp6dx0KpOlFTrs6/Pme/v
	FW6dOjjH7BxAs14J+1PxmYD8r/5fgAHsxYwTt1ZPXLT7VoLijc0VFPesxEqPOLpD8iKsXl5cACx
	M7KQdN0RLBZ2jQyP29/4N/pIeC9PIyb5pBUbB31zxZvq3/GzR7ezLHTLa4iV5JLO54UxirU8P58
	uDJZZdhLnRVm6NUtig22TIhUTnQEqxpnafSOfVoztaA8hyfnljKq4njsgMHXW
X-Google-Smtp-Source: AGHT+IFT0GFuq9msexYfYdFrpC2Zjye2ADTrcVGUuz8yhhr8LDG29upmo2w3AwENFXT1lwPc05IYxg==
X-Received: by 2002:a17:90b:3cc5:b0:31f:762c:bc40 with SMTP id 98e67ed59e1d1-3245e59151fmr99420a91.16.1755545293364;
        Mon, 18 Aug 2025 12:28:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b472d794a4fsm8795257a12.57.2025.08.18.12.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:12 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/6] genirq/test: Factor out fake-virq setup
Date: Mon, 18 Aug 2025 12:27:39 -0700
Message-ID: <20250818192800.621408-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250818192800.621408-1-briannorris@chromium.org>
References: <20250818192800.621408-1-briannorris@chromium.org>
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
---

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
2.51.0.rc1.167.g924127e9c0-goog


