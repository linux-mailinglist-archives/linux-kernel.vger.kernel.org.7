Return-Path: <linux-kernel+bounces-749850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F7B153AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0747A216F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01A29A30D;
	Tue, 29 Jul 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHs/BXPr"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE9299A96
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817857; cv=none; b=q65QaMOyManCRLHHfp+jyZYdFE7Oug5540wY4W6so53LQTEALvoI99vjPRQjsbUDBq/kZMMDdVeITZ2VciUM3EZdlTFv9xJ2SOkPWo3JujEvQmjXUa9vCYmQ/kXeCowqGuVqSTKZlfvIdcatkNzOq0fO1bUqREl/bKd5ytiX8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817857; c=relaxed/simple;
	bh=6ilMk+F5c7wyxtpff0pQTwucr5SOAegMwv+/+h5MTtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HrhMjwVPwFGbt3LuEqCkx8ImbgwmBZHlHMBByEijfywEcE8pq8p2jbPyp9kUIoEwnLSuE43o2V6RAM7ac2FX/IrgkttWhkVBwxAcX2GHq8uPc8P6jWeNQVIxPAOda+nV9KXpto4uRe+OJLOpN2LxmTY0Jt2b8g3URYjGw4XLd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHs/BXPr; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-478f78ff9beso213278631cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817855; x=1754422655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqlb+4Olh1TwsUKHNBaNVmipEQokIfwNy2zQhwsaeKw=;
        b=BHs/BXPrzcm4fuI1NQrOQoW7UC2x2EAA2p+YVTO0vF6VMqQPb09NwKySMNlGTxO7kl
         6WOi9rbVJ8NmlpdZwreHILpdfa/Ms3pslzF1xrkJbT4NpbrQYfg219e4mX1781vo3kxR
         JAx+VLwNrBRIOIyxBztpVQnE1d60ujMWCrA7kgPXirNKkmi8oMoEKXbcMRRDw7d091YE
         rzbUCopgtP0Z84GSGgCBb5hMGGXdRQfxXweJj9somFaDxrDq64n807rn68UNe+pPtzkD
         wLtqe9E/4B1J8GsUPAElmTZFqifOQzt078YWPOzAfqYi3Gkh9cYQKZLaRGSGd636/mUU
         6MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817855; x=1754422655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqlb+4Olh1TwsUKHNBaNVmipEQokIfwNy2zQhwsaeKw=;
        b=AILXtzmt4TGJpmPaiIvZPzpKju+ED2KB275s/mNtyGb/sT8bvKj1qn6pXHOlcWi5HG
         BkjyIX8OUMgQVtFEg8PwSdH+nFqUmjAgB6x7bIaKGZukWLWMghSQXczviHCwYyowE5hR
         J4o893VL/WJqypOaYw8TGkdUAaeOjZgCXTh19nXtwTsXXUtN6jgMJyT0iq9JwLf6nrbC
         XWf/uN2D6aetYAnp9aK3xDDEI2Df+vD8yPuhb7861THkePGOF9JqryUiYDTt5KJ6U5/h
         U2Z8pvD726coJtdlbLKdXUlY+UTn+9ERva3apZw5z8vBmjwPv99x5eRlIw4JJ0XRZeSj
         TYOw==
X-Forwarded-Encrypted: i=1; AJvYcCUIf/btPBRckNnvoLgfuEVtILqK73eoh6c57IErjuW8tmdi4TUp7XSA1DYkP5NeiZNqDEGZC4zmlOEQPPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIE+zmiFTfmUw+dTQhQWxfrjlHWekeKKFCj+yLmUzl1lyvilo
	RTneu7nRXdxq/yVkmAKmABTazh0v7GCR6tQTcXo2IdNKU4IZj08HYmPvqUu1UzBskMp7IDkJRCk
	EwRNejBLtwlK9Xg==
X-Google-Smtp-Source: AGHT+IFR27oKs2zCkDtQSep4WwYS5IRJ7UhNV1P5uHsuK/x9zfXEMRZqniNBaaI394PfZErJdlbmGWKHOIGAkQ==
X-Received: from qtbcm22.prod.google.com ([2002:a05:622a:2516:b0:4ab:3fb5:ddd8])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fd3:0:b0:4ab:63b9:9bf4 with SMTP id d75a77b69052e-4aedb98b2bfmr15053941cf.1.1753817854822;
 Tue, 29 Jul 2025 12:37:34 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:46 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-9-marievic@google.com>
Subject: [PATCH 8/9] kunit: Add example parameterized test with direct dynamic
 parameter array setup
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce `example_params_test_with_init_dynamic_arr`. This new
KUnit test demonstrates directly assigning a dynamic parameter
array using the `kunit_register_params_array` macro. It highlights the
use of `param_init` and `param_exit` for proper initialization and
cleanup, and their registration to the test with
`KUNIT_CASE_PARAM_WITH_INIT`.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 lib/kunit/kunit-example-test.c | 95 ++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 5bf559e243f6..3ab121d81bf6 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -387,6 +387,98 @@ static void example_params_test_with_init(struct kunit *test)
 	kunit_put_resource(res);
 }
 
+/*
+ * Helper function to create a parameter array of Fibonacci numbers. This example
+ * highlights a parameter generation scenario that is:
+ * 1. Not feasible to fully pre-generate at compile time.
+ * 2. Challenging to implement with a standard 'generate_params' function,
+ * as it typically only provides the immediately 'prev' parameter, while
+ * Fibonacci requires access to two preceding values for calculation.
+ */
+static void *make_fibonacci_params(int seq_size)
+{
+	int *seq;
+
+	if (seq_size <= 0)
+		return NULL;
+
+	seq = kmalloc_array(seq_size, sizeof(int), GFP_KERNEL);
+
+	if (!seq)
+		return NULL;
+
+	if (seq_size >= 1)
+		seq[0] = 0;
+	if (seq_size >= 2)
+		seq[1] = 1;
+	for (int i = 2; i < seq_size; i++)
+		seq[i] = seq[i - 1] + seq[i - 2];
+	return seq;
+}
+
+/*
+ * This is an example of a function that provides a description for each of the
+ * parameters.
+ */
+static void example_param_dynamic_arr_get_desc(const void *p, char *desc)
+{
+	const int *fib_num = p;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "fibonacci param: %d", *fib_num);
+}
+
+/*
+ * Example of a parameterized test init function that registers a dynamic array.
+ */
+static int example_param_init_dynamic_arr(struct kunit *test)
+{
+	int seq_size = 6;
+	int *fibonacci_params = make_fibonacci_params(seq_size);
+
+	if (!fibonacci_params)
+		return -ENOMEM;
+
+	/*
+	 * Passes the dynamic parameter array information to the parent struct kunit.
+	 * The array and its metadata will be stored in test->parent->params_data.
+	 * The array itself will be located in params_data.params.
+	 */
+	kunit_register_params_array(test, fibonacci_params, seq_size,
+				    example_param_dynamic_arr_get_desc);
+	return 0;
+}
+
+/**
+ * Function to clean up the parameterized test's parent kunit struct if
+ * there were custom allocations.
+ */
+static void example_param_exit_dynamic_arr(struct kunit *test)
+{
+	/*
+	 * We allocated this array, so we need to free it.
+	 * Since the parent parameter instance is passed here,
+	 * we can directly access the array via `test->params_data.params`
+	 * instead of `test->parent->params_data.params`.
+	 */
+	kfree(test->params_data.params);
+}
+
+/*
+ * Example of test that uses the registered dynamic array to perform assertions
+ * and expectations.
+ */
+static void example_params_test_with_init_dynamic_arr(struct kunit *test)
+{
+	const int *param = test->param_value;
+	int param_val;
+
+	/* By design, param pointer will not be NULL. */
+	KUNIT_ASSERT_NOT_NULL(test, param);
+
+	param_val = *param;
+	KUNIT_EXPECT_EQ(test, param_val - param_val, 0);
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -408,6 +500,9 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, NULL,
 				   example_param_init, NULL),
+	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init_dynamic_arr, NULL,
+				   example_param_init_dynamic_arr,
+				   example_param_exit_dynamic_arr),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
 };
-- 
2.50.1.552.g942d659e1b-goog


