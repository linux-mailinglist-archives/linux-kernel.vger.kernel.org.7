Return-Path: <linux-kernel+bounces-779964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53BB2FB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935DD16BBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AD1A9FAD;
	Thu, 21 Aug 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LO31eZ33"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEE2EC573
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784496; cv=none; b=jm1yQiEUnyrlR+3aGJsq9Q5YGIUOAxP9dbtMcFMjgIWL5igvijLCnZCTbH+CtMmRs0q5ga42iJ9osLItO6LkA/VHLbgWspF5f8y+AJsUKHBlNZYKS8+2/VPIXR3efBAIVEXikB8WFZUygYQm0yLkCf/T+XXRX9gk3XibET1RWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784496; c=relaxed/simple;
	bh=FRZ/dkTH5e7JEyicr5rKwYSZwT6g3H9r7TNIOOAYgss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1+fXSZWhW1LhwsLdDZauy4U7tlj7A9x4R3xMh2aWLElVKYvAlEyLcrMgI4ATeC2bQm21je7adNvvEoanvOBXfOipViq4BeT6MXgBJWos0i+4WXAPU6ZRt/c3GymoPkifTNcXhjWG8yALMfco77dmJSnpKztcg2jID7z0aID56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LO31eZ33; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60221fso2342778b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755784494; x=1756389294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpTFpmF3LpyMWsoi7YRVPJftCPsO+iVXO+bA6kJHgfU=;
        b=LO31eZ33Rx4MStqcRWDOLK/mE63EmxOKBKoNkGWRctXY1mzyW5mpdQKBsRUpNQEnMv
         zM1PgD/II8xYkUJYKxCq9asq7NNHiimsbwsH9vkC8cCXrIdNNPeMObMA7E731OcuHMfj
         fUp175K3AQzvGBAN0KcIbnbG+ls3NCfSOylHWyAQd8irgzCxCmyYYrHRErcHaSl9VPdQ
         4VMjyhY6wEiHuGQFEKe7XptDCA6MisyI+Rl5pPa1nKs2MG+jCOsO2zdTuuCWhmLcDZch
         Ps4sOYFESuQ09hGhbRL7raRMmYh+AXUncKQ6Uww/mFFiWvZ8V1g66nuxCtZZHKKdsibT
         DvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784494; x=1756389294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpTFpmF3LpyMWsoi7YRVPJftCPsO+iVXO+bA6kJHgfU=;
        b=Kx8bjvfWzd9RCE1VTKSpnBNWQkKt3i+puOBknwNsvLFnz5e3tAPeWNdRDrk+D2LqIL
         b54WTA4N8hmFViXyRTMdj/WuQglpy0om7kytMSihocbwxWHSrYadrN+DRr5cwI4g1UVk
         MQvCesLwYGdEYAjcA4ICnkc9Svk16jtwcmgpyT7jJqxtHYeJTrKuMum22iONLjGNw3lm
         A8uxkq4INrjJUaaFDG5ie1rjroa7sRt5Zh9OyAZMQsIE0u3YzRvuXRwTiz0pC2dsYBnS
         xK4qRJB79UDUwMxVkRu3zAED01Kt6LflxWuJ2eSyTsys3JxCZ7xwPE5TmrJTTE9rMJuf
         DF2w==
X-Forwarded-Encrypted: i=1; AJvYcCXFaSTzTh5JKH4YXyCjn2USrr+CTN00gzunpmzN/M9ZgkUUcUWOuMdP5HSLuvGfAxBNNCPP+75Udza2iGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Y4U/VYObRwWhTeboNkysRQpDqrQ3g19MxMWiADGVMzUkKDCl
	hSzzNCqfELyf32uAhEjwd4Vct46gJWwzszjldvaSf55XJc+bKFGlA6uc23cwDhFZ+5lRLJM5eZy
	FAjlrwwUB/dmXdA==
X-Google-Smtp-Source: AGHT+IGJEX7ZclUuZ2o8JPzaPgxqgSiOjHKYAc6KuCEwQ4l/jHJHNh6xVmvyFffzu/3E1KDZ2EtRfnXg3G6H5Q==
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:76b:c859:e832])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5493:b0:23f:fd87:427c with SMTP id adf61e73a8af0-243307cb3b7mr3418114637.18.1755784494062;
 Thu, 21 Aug 2025 06:54:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:54:45 +0800
In-Reply-To: <20250821135447.1618942-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821135447.1618942-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821135447.1618942-2-davidgow@google.com>
Subject: [PATCH v2 2/2] kunit: Only output a test plan if we're using kunit_array_gen_params
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, intel-xe@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In 6a2a027e254b ("kunit: Enable direct registration of parameter arrays to a KUnit test"),
we now output a test plan for parameterised tests which use parameter
arrays. This uses the size of the array (via the ARRAY_SIZE macro) to
determine the number of subtests, which otherwise was indeterminate.

However some tests (particularly xe_pci.check_platform_gt_count) use
their own gen_params function which further filters the array, resulting
in the test plan being inaccurate (and hence kunit.py failing).

For now, only print the test plan line if the gen_params function is the
provided kunit_array_gen_params. Unfortunately, this catches a lot of
tests which would work, but at least makes sure we don't regress
anything until we can rework how some of these macros function.

Fixes: 6a2a027e254b ("kunit: Enable direct registration of parameter arrays to a KUnit test")
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20250819073434.1411114-2-davidgow@google.com/

(The change was in patch 1.)

---
 lib/kunit/test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b661407ad0a3..bb66ea1a3eac 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -732,10 +732,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "# Subtest: %s", test_case->name);
-			if (test.params_array.params)
+			if (test.params_array.params &&
+			    test_case->generate_params == kunit_array_gen_params) {
 				kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT
 					  KUNIT_SUBTEST_INDENT "1..%zd\n",
 					  test.params_array.num_params);
+			}
 
 			while (curr_param) {
 				struct kunit param_test = {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


