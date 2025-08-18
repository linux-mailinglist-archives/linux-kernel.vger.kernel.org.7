Return-Path: <linux-kernel+bounces-774392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EDB2B1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00C7620721
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3A275841;
	Mon, 18 Aug 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H2JFo/uC"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8633451B4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545297; cv=none; b=BVNleoApZ/eR5rZykN9XaLENvzkAiRFqEg/otRbTQEGTimBFpYjiAfLONS3sp+NT2BNYuCXNTynDTP0R/3P5ihDMJBTAhcQKAo7JdDjKp3Ku1gH3rZzQAiWgqhE8c3Dtri9KUgKvPwgCDiY0XLLh17Xe30LE9WP77C0xX4NzMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545297; c=relaxed/simple;
	bh=4kPBijlkC81NpSBNY16J9lTeuReJQ4QC+ZA54UN4Ivw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVczWP+kowYJXuORuKGCmQ1qVl5FwBxqrbf3ROP6bc/Jf6Et1ok1ShT+Ko2n8hOYvWLqnL0WxID8Z1/6cxpT4axTLdGk/SU2PIedvzk2t26KDqj6vg+LWdoeCD8ETK2Nl/qduhzKlM+kCsGVyBD7kWmEwKFv2OeQTRzStGDP3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H2JFo/uC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f3edd4so32115585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545295; x=1756150095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDkO8DX6+gukHF5Z8lyQnQSH3eHYqp3lwAde0IjMu1I=;
        b=H2JFo/uCoCnmrfv1e6wCfBYjwzAPQPL5cW+zybZgztuDxeAQwCm0IhtQ/RPle+TUbk
         5zp/gunaecgq+zKM4Te6c0F24ybf25JK5t7FNpPjTcUytWJJ3J9OgTVa0D5U+lMvxm6Z
         y1nbJTObp+rlKebEvqc++3XpBVYtUl3hBML3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545295; x=1756150095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDkO8DX6+gukHF5Z8lyQnQSH3eHYqp3lwAde0IjMu1I=;
        b=NYSI2rIAaatafiLknCJizLc5GjIk6VXgFiZTgkUIukA5DbsbKRDbwvbp5W2iHQZ8P3
         1AAiEaXX3D3cDuJidUk545kQv09/jsp9IuLXpGShSlDbIvJJ3HgNnv6kAztN9f7YXrD4
         kuJEuj5d7x86wX1YxTk4z4RnV7iYzztEJ34y82NH1/1CZMyvfQvjtt8Y/b0q4DYojbiH
         LQZqRsIFaRJ3+7Bs0/P3FRTWN8cwirf+0Lxq3MWeKAkmaxoPmn5CBX1RNugpj0TccQXn
         6kSCSdPyDkoQOT8wuC3pHTfb2KCAWxlWTYc4EGM0I7pdKFbzy8PYEAkAEWFYupvvehaA
         bqug==
X-Forwarded-Encrypted: i=1; AJvYcCW+CeqXoV/3DeBxkyEF/uFnhpODXG9llDZpPo6JpHGnSsVN/0Ry8mEpCvx3EMHDedXK5diUmtqS67l81Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1TedWKBCp1hOkCXKzfdfZL68ntqb3vknRi03CJaEOVbWlWvb
	yh9MlaU8T+EARtvd0PR3dx42w1CrU0fsqVZ5+4MRjU9U5vUAoR7Mmy8IUiycGZBC3FQ8Su9v0mZ
	nBWI=
X-Gm-Gg: ASbGncu4MlkzrbjpO65c20fQEXA3DY14jvysmsHYiztU2mMt8NmeFlJTkgJt+x+vori
	nFZrRhN6neWKw64AQiASO6D8X+s3C+09pGeF3BT9SCtmvlg7d4zYqrRjvjXtTrFJfUfxtSEBiKB
	HxnzivnlRjhXHrsgfnMG4bCBed9pKqoYUx4c3MVZvB6/d86c+HA1qhJNiVb2T0JeJzCWoFxdX7L
	WOykvYBfqMPSfZIruR39Rfacp/3WsqhUQt6v+A9DSY8dT1kXoj3LtW0nJwb0GhhNlkDxCehzUKb
	faXmnZTRGmliRrQG7ThzirDf7j+/CZsH6CVHp+/LGB0ZIon7+y+gcwacIdeeOCjr6pXcA/uXwXP
	b3nx3Q5unxu8Uo7aMEhijs7H5zi1fwv+HN0xeka843Mtprq6xIpgnCieqRMPb
X-Google-Smtp-Source: AGHT+IG3TNGIvEz2Dr2rbFdB/HwzWGf1/A9Z4HgPI7eTSXIPxa6gjJoMYtoglKZgfOWHv9+CcDwODA==
X-Received: by 2002:a17:903:1c9:b0:240:6766:ac01 with SMTP id d9443c01a7336-2446d6f0386mr191138865ad.2.1755545294960;
        Mon, 18 Aug 2025 12:28:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2446d513c19sm87709645ad.93.2025.08.18.12.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:14 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/6] genirq/test: Fail early if we can't request an IRQ
Date: Mon, 18 Aug 2025 12:27:40 -0700
Message-ID: <20250818192800.621408-4-briannorris@chromium.org>
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

Requesting the IRQ is part of basic setup of the test. If it fails, most
of the subsequent tests are likely to fail, and the output gets noisy.
Use "assert" to fail early.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/irq/irq_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index f8f4532c2805..56baeb5041d6 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -71,7 +71,7 @@ static void irq_disable_depth_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
 
@@ -95,7 +95,7 @@ static void irq_free_disabled_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
 
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
 
@@ -106,7 +106,7 @@ static void irq_free_disabled_test(struct kunit *test)
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
 
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
 
 	free_irq(virq, NULL);
@@ -134,7 +134,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
 
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
@@ -191,7 +191,7 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
 
 	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
-- 
2.51.0.rc1.167.g924127e9c0-goog


