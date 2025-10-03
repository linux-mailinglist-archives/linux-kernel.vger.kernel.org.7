Return-Path: <linux-kernel+bounces-841157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B8BB65E1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CA9B4EB8CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88828C841;
	Fri,  3 Oct 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yui/FdC/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CE29C351
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483779; cv=none; b=GFYOc97m1K00HrqY/C83k+F9zJ8cC9vSxyefbCQ2WpsMwOFnJuwCWzUE2tsctNQ+f2ZXxZKHp0ePB37rNXvOLx4NNeKhfC6DRTsBJ6neFHuh5cw4uXH5aNS/7DFJoaZWFsMHee6qUIUmLEYgTqd4nd/Yk0+zFF4DYFlpzgzO3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483779; c=relaxed/simple;
	bh=+vdEmMVTHZadaETHiL90NT3fUNKGtrfQcPtzSKVtkLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wya7JnF2r6WkN/aMfLyf5P6YsqVKKQK6AJ37NKtZXhoLrh3Xx7nyIeNw96h5RFL+ZeH9RjknBnFMJwktJnXYXNllXBIAKvRItLtrz1JQ709HcA6BMzLN5D5BcWVrzzOi8IIPBWHJqgUdqEkRdYBN0FFnAvnfhsMSwzO5UWJRWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yui/FdC/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso18612535e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483775; x=1760088575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrdVcJnH0ez8wntENTM0uG2XQe2LXopmlQUtIl/gs2g=;
        b=yui/FdC/d8hgGYvQPlc1DfSmXawI1bxx08nHGYm2+n8ZWgG5qg1W535jwmx/1W25B0
         pSwnkCE2fS4TxpTHiyhIs/4CW4jXiq1BofZzs81sG2a75ZZF/KGXYNlbxh9OFxoBboSC
         ATNJR9s7K8ohq3LhjthY7BI5RRnrcX+jdYPNmNgggU7YVcO8QRPn5c+RWFxoKHARs4EZ
         vSJoO/53S5XkRmH6jz2I/ttZE/lVToeB62ziIKFbNf5HXLWqinJIKy+r+JyPEGOickyg
         EgnMJzMv8i7uJafMX8H15SnCNrfIs12n1jYSmb4+kPW3+PT9ZgK83Fm5qm6vz5gU73DE
         7UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483775; x=1760088575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrdVcJnH0ez8wntENTM0uG2XQe2LXopmlQUtIl/gs2g=;
        b=Vb4/WZ0w0WHjLenge5cxGZXu51pMDuQXIzkosOXgqY7OdSJiWwUS6EeZJjmxWDskDj
         t0lQEKuu1maLEbOPjjsOZtDeWU2oYkKAJCNZzQP5pWnhm2P56/neq3/knUNMngWaWccm
         NABwrfwTcQcOaUKKyaEdjKT9O0OOLSwfgOHqGo478gEC95Wo/pHHCeSmHk7GxhgLFvph
         3MhRQmEYXlG36r8pqMXwpjDDWqyDCGno8RYWTTGxNSem0uh6AZJMEZPeB6YAD0o4cFpg
         /Ng5E3MUNMCRnuSGUNeHUvgUU246oAJdqSypFU/Wh45UfUC5nV26qxuS/D+eKm5bEuaq
         TiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiqhqfum/QFr2sAPQEOtQrhZ5vO1uFUzRcaC0sBFDdS1bNMBfzENq+h1TIrNq3yO/ZgN+igdG7yHuzCPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZSZ5C/g/h4m31ozjPBKV+axeO6FQtM2ks7zVqvJWa7lK45uu
	1YCBB2JiVt96teG81C4YouQsybG4TVdTeQtV4Juq51FCOFDs34ic1dN0Ppc+0J20HD77zFJcs1y
	ZPmU8
X-Gm-Gg: ASbGncvcocMBl/CcR7aPGqkGWmUqnOsUULi742Zz4dLXlziwsjs/HufxofKBAZ0GhUo
	jWOnknE05/XIOXF21us66669b+kFkoyNHgosqpm+Z4rEy6oa3zGVoDFByb9WyG+7D4qq9UBIWbL
	7vsR5RdazTzQgMuuaDSzGs4XR7Cpt9ASUs+UI+uzXxthPMh8eQpldSOmAmcx0RbY7JhGzXeEtu9
	k3RBdkrUW5WjD6L3B2gHOSFyU6krNjGKXnrwV3kyUFxh0emNFKlYbCANBwSL4qL8et0p7ndXlIw
	1f7pxmXaQogYfcorwZu6tsXwzMdRucN8i69b/+it9xIntSm1dtzxhFv08K3yjsqIvJPg8WRrC0z
	H6SciRh+5vol2Au4MC6rez+BbIoKV6sWaK1PXJB4aOYik4t3jIlfUFjQY
X-Google-Smtp-Source: AGHT+IG6tX4ZZBiVIKE1UgKL2V7cxAUZvSbg/e0yGhSGsaSkg/4tX6nLO26JEwdqDcT0Cju2Zjht+w==
X-Received: by 2002:a05:600c:354a:b0:46e:1a07:7bd5 with SMTP id 5b1f17b1804b1-46e7114e5aamr15201675e9.29.1759483775243;
        Fri, 03 Oct 2025 02:29:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e72359e2bsm23175955e9.13.2025.10.03.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:29:34 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:29:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PM: runtime: Fix error checking for
 kunit_device_register()
Message-ID: <aN-Xe4lgox1cCAaR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kunit_device_register() function never returns NULL, it returns
error pointers.  Update the assertions to use
KUNIT_ASSERT_NOT_ERR_OR_NULL() instead of checking for NULL.

Fixes: 7f7acd193ba8 ("PM: runtime: Add basic kunit tests for API contracts")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/base/power/runtime-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index eca9885e807d..477feca804c7 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -14,7 +14,7 @@ static void pm_runtime_depth_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 
@@ -32,7 +32,7 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
@@ -70,7 +70,7 @@ static void pm_runtime_idle_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 
@@ -91,7 +91,7 @@ static void pm_runtime_disabled_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	/* Never called pm_runtime_enable() */
 	KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
@@ -131,7 +131,7 @@ static void pm_runtime_error_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
@@ -214,7 +214,7 @@ static void pm_runtime_probe_active_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	KUNIT_EXPECT_TRUE(test, pm_runtime_status_suspended(dev));
 
-- 
2.51.0


