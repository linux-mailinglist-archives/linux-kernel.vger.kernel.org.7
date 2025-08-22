Return-Path: <linux-kernel+bounces-782598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C32B32291
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42325648CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9862D12F5;
	Fri, 22 Aug 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QF6T6KQJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C52D0C75
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889315; cv=none; b=bEPiX3s81nnx1HP9Loi3tSZ31oGpAvSr1CnLxA2Q1qEOHuLHIe1SYGctHr0KPPhLqZ0xEJVA2u0UAltX5C8dVXGsHtGhniZRXgJP37/DlEhCtqB9O7mHUIiWtersxrUNN6r5Gw582vq//L49EEWBJLceeUTzrYrocOZ62HnVW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889315; c=relaxed/simple;
	bh=cWxJVSCR6Z5YpDq7Nb824hJk5EnRMEes73DhMMFvzTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmJkjsMI27hUOglxLGZRn4ZcQj+XWO636wKAin3rK3DsiY0/I9phgTIWpZ3qV97Ep4BIqiKlIKa2tlBxpG8BrpQj66xrIuFPRF6RjCakLYSZi75I3Pcoaahjfzcc46G2drZZtB7yzvjOiyaNa9GjSgkdiStplzfzSlKZEOtznFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QF6T6KQJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso2327839b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889314; x=1756494114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JBmJP/TLWjJ8U7y1ITV3vUcgsR6oiKteW9+ZGeDW40=;
        b=QF6T6KQJYWo4pKAAkJ/Fu3+kaz1iYauZz6IJ+nuMQ/F96tUeFzG9hmNiNca7+1QDBb
         UxVrcHK6VPla6gc3Vu7LP0D2FIRTFphJEw0sXYLOfXj9WazEGQe7kjpK3z5ZSSYRBEI1
         Et4ItcBQ8aKRZuwGZaryd9RjjKLkwH4ZQO2W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889314; x=1756494114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JBmJP/TLWjJ8U7y1ITV3vUcgsR6oiKteW9+ZGeDW40=;
        b=ovo3Mwx1jkShzW5VsUWLzm1sY62CGrwuPZFAgtNM6lgJgFWolMjoNyEagQ4fy4a4PE
         +gi0Ea8OLuftjBOsvXUgF6TDeeocPs6m15zQlIRcix0Zwbn0+kGrOVSugf9dguDEUK4T
         ICwMK9A1Q0OmMKL57z+IrPQv4nIM9+T+Kv04zHWqhEsOz+bMIBnRSdWxHSMupCjwARyk
         KGMLac86e1smg01SeOQQzqo7QaJv7gdoM5paAbC2IR87W9T1+z832ACEc7Rm9LQIHChe
         PQpbiEagigDqh9mv/t79etcxud0yBvHvATR1pPa6Kn5FAUN1l58WE8cocDXKU6CrBxY5
         BfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUit4BmXop/u1UfAGhqcaZsWhha98YPHS++v5MQ5ct8VxyB75K6Jc/hJBLtP3MWAqQpuMNZImni1Q5axQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfR3dU6EPvx6rFbOqzTArBj2o/XBodD8ttARWX6ZJBHa7Lits
	Q3qIZUxvTFnzb0/khlywadx41lA5y6CTWZzVy9BWmqmjXq3l58z2/79lF3Sp+HSkvw==
X-Gm-Gg: ASbGncu33fUDlsSPFWEglJoDEqNnXS0GpKxMyoUNuzlAMjqpITuNWtwkq5n7lgV715F
	ssY2jmKduWlsZ+8hI1TlU8a65l/E9lEr4ybtWZ5nrQtWqNXvO+hIjFYazPGKSdZtjjWvwkyOqCU
	V5Q30ETpcHMa1PwKmOTlZl8C9NWAt9y6wZQxmkCYEzPPt+BZEu9Wz6pOnPDuI9zoZtFKrkcFxk8
	/3yzpvBwaGNGawu1ANHuWYVvceZPMVPW4TrzcAiB2Vu1EAcuaVSpTi5FCVjtGijLN+0oEdkdILA
	eY1/2K9KzL3gOGffFAp6iaahWKoIlMDCN+hQiZec4uE+rgpDldxPmHxHnaDJJcqUH3I+vLO9Bvv
	T59WWV1b0KKPL7HPcXJl8c6kE0D5zZQ8g+7H8HQ0zoer2sUlJpSJNzcnCy4E=
X-Google-Smtp-Source: AGHT+IEYMj43iQarvl5ZATwez4b8yP9DJINCX4H7ZcT6d/vhB9KinVjiExt4tW5yIdovYyH/SKo4PQ==
X-Received: by 2002:a05:6a20:2449:b0:239:a3b:33e5 with SMTP id adf61e73a8af0-24340d91844mr6212979637.39.1755889313625;
        Fri, 22 Aug 2025 12:01:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254aa4fa20sm537789a91.17.2025.08.22.12.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:52 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/6] genirq/test: Fail early if we can't request an IRQ
Date: Fri, 22 Aug 2025 11:59:04 -0700
Message-ID: <20250822190140.2154646-4-briannorris@chromium.org>
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

Requesting the IRQ is part of basic setup of the test. If it fails, most
of the subsequent tests are likely to fail, and the output gets noisy.
Use "assert" to fail early.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---

(no changes since v1)

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
2.51.0.rc2.233.g662b1ed5c5-goog


