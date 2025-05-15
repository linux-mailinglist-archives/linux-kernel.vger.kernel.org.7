Return-Path: <linux-kernel+bounces-649145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E094EAB80CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AF81B60975
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706C29824B;
	Thu, 15 May 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETvrG/hz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8B298244;
	Thu, 15 May 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297779; cv=none; b=lgpvn5QjlQch+5dV898WUgC1ghLsb/uJnislI8P8kuNF1RNTHFlU8eJHpqGqSHzljdeDvphanEdvMRuPQstRS3zN70YgMLX3IH5ldLIVUOak0nljMZlQL1nsPANAZPPqXYWMYD7LzbkPcOhn2t0OLiOwDs1Gk3wtCkuGLksVAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297779; c=relaxed/simple;
	bh=KkrCkIrNoINcDGVsoaeXs/3WVDpp0D897mQKNrzpRZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifHngiHJP1Pi0JSNSvSK2a5m2lYlkfdte4wxdZVvDqIBjctssLAQJkhJGutEfj8mgIWKZhrOB1eSiI5wVasWtdAjnmXyCF0JLWMBK5erJijOUvnGrKxInTshFlxe3YRH98HCCMd2mJGuAgRBKo8/E5gYoxhiprqyorq62UZMxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETvrG/hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2058DC4CEEF;
	Thu, 15 May 2025 08:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747297778;
	bh=KkrCkIrNoINcDGVsoaeXs/3WVDpp0D897mQKNrzpRZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETvrG/hz9wfXOG7XhzO/I5ViijNzRSFbFfj6k7H+ypXSQdLJADGod9d3SPn1RXFG4
	 94fqO+dRDfEU98rCaybUi4tRO9D9iYDmcFbIoJNXOYsmftNgeLXvKGZJMnrAQxxe0q
	 iLXXW10XJ19wWsNDF02kHJS1t55mp0JxmkIRYhTMAqmMJLJA2iadFnoI+wah55YK8K
	 ydffAV4/AQ3MTtw9Yy9LhxU7ZI5wWKPJXn2y8AQ7/x17atg/UWyfbMvKuliE7dRVX7
	 SkQ+viAPnw/D4MEykj/uHmx2YXPvfdfHinJEZIm7iHIHOV37hlXXSFFw7p+nMk8N6t
	 C7lfO5diKuaiw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bettyzhou@google.com,
	ynaffit@google.com,
	tkjos@google.com,
	jacek.anaszewski@gmail.com
Subject: [PATCH v2 3/5] leds: led-test: Provide test for registration with missing devicename
Date: Thu, 15 May 2025 09:28:02 +0100
Message-ID: <20250515082830.800798-4-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <20250515082830.800798-1-lee@kernel.org>
References: <20250515082830.800798-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Insist on legacy (non-DT) registration and omit the devicename, which
should fail with an invalid argument error.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/led-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/leds/led-test.c b/drivers/leds/led-test.c
index 760c393f5c5d..d378c905546b 100644
--- a/drivers/leds/led-test.c
+++ b/drivers/leds/led-test.c
@@ -108,10 +108,26 @@ static void led_test_class_init_data_missing_default_label(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 }
 
+static void led_test_class_init_data_missing_devicename(struct kunit *test)
+{
+	struct led_test_ddata *ddata = test->priv;
+	struct led_classdev *cdev = &ddata->cdev;
+	struct device *dev = ddata->dev;
+	int ret;
+
+	struct led_init_data init_data = {
+		.default_label = "led-test-label",
+	};
+
+	ret = devm_led_classdev_register_ext(dev, cdev, &init_data);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
 static struct kunit_case led_test_cases[] = {
 	KUNIT_CASE(led_test_class_register),
 	KUNIT_CASE(led_test_class_add_lookup_and_get),
 	KUNIT_CASE(led_test_class_init_data_missing_default_label),
+	KUNIT_CASE(led_test_class_init_data_missing_devicename),
 	{ }
 };
 
-- 
2.49.0.1101.gccaa498523-goog


