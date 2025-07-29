Return-Path: <linux-kernel+bounces-749845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1BB1539F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5A18A7C41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F626159E;
	Tue, 29 Jul 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCzHZ1yO"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C92571AC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817844; cv=none; b=X9NBNiawQH4314WqENAayjea/17VdRSXSWOxUBw693zpsjqy+5yxM/3RYIzWR/c5x82/hveY61kh6ywWxT6utBkXBfxSa8a0fzXt8SOOJ25jJpLEW6L9YL5dk/7unWBQ/SRifJkqc+p8pxpUzo2nnwfqOydpLp9d1Ki9QwRubXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817844; c=relaxed/simple;
	bh=NsAsE0K6XtC838sAhCEDbzWc2+LZjzuI5QUtOwwrrho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6CmUfk1fTRKURCUIbWIdW5A3s0sfYi/ONnIwnkRMo5uC6QNXFQ7megwvpp+TZkGZKDYC1zhRjQ1AjzWi1B3mq7ahRAIbpGLseWKSUVHvT/G8BjuCI1kNVBPJ9XElk0WjlDmHplN5FZAXZkwqf3HGGs6kfMgUTL+IRX5m3mSlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCzHZ1yO; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ab3b89760bso136621021cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817842; x=1754422642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOeFclXy3T+mxjPs2r95qUwInGd9f34oaUC//E5T6EQ=;
        b=nCzHZ1yO7T9pJ3wHabAWFYM2HubXgRW+CvhcwQqefvDfuW7qBSOx2ibOfMEslKbDeS
         C3iX9VAHET8CsN45MogiazT94f+j8Kon7jAHjSrrW51U35bWkMasqFlrPJLd4xtEnTkZ
         3z3RprfOqf51uJWLFG/IOTPsPAqivW2DjZpr7MvqXfwaJoJUHLUes2m9WGXhQWeRBk7J
         8yUgRIbNrx3htvxL7vnCgu7ArPtJwrGL8fy+zbnNLSv+8BRbfFCEwJC321KDKOJgtW6I
         LvZnnmexDPfIEk2BjA4h31ocVw+il3WTe4vF6yfeFYjTpklX61RRBQGoI5U9nu6N8YM0
         hddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817842; x=1754422642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOeFclXy3T+mxjPs2r95qUwInGd9f34oaUC//E5T6EQ=;
        b=V+l5/NnKHE7f42uku7lPtz1/CptJEn2ChFKMVkw+kUUHIpiB0C/j79ZLwCoR5Au34o
         TAv1GPjwW89kiAYXEUWvyznKW9hcqYvqFDQNw6uB7J2brDB3asmm4Oa2Fan51Wop3TMm
         GgJZZktGX8Nx8EZo7YvqxKs1BqwknfMj1k9ErJcRNEczi4N3LFEjxj8Ykp6bWA+nhAnR
         6/g1CxtCY3qzcsNxauadkFt8rUgFslrGgoyhNAAp5CN5H31QBdigUuegBycIHcNiyiZy
         5IQAAIS+dhqfvCTIRI6a1SeC1nWdCu3WjZzIOcdRrUdfAGgcH75xueJrtrQimSpQf+na
         TRhw==
X-Forwarded-Encrypted: i=1; AJvYcCWGnz+Umaux1mnx4TYWRsOJT9CfqNCViO4zY87BQgJkBb+Y6bpnzkJ64f4kbIiQ/f+Jq5wbJs7cVIr/1QE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79vGKaccFyxJWuWcZiTGGIt3Jj9QLXKCYoUfg5YH9CEBAPkW1
	6bsaAyTFZqQcpuEFaqIrnDXHNvig8APUGHxCFkNwcAuPCdBHayC0zFuC5+I8Na6BvdQF3bO0Ltp
	sxM2xyIi2Z5+sGg==
X-Google-Smtp-Source: AGHT+IGMUSrZqdOskeosr+igUyfuxaNIUOfIiK4baHfY/+3YYV3woVzpXvK0qcFaE6oy2EYskMsu3hBqN2Ggaw==
X-Received: from qtbfh7.prod.google.com ([2002:a05:622a:5887:b0:4ab:b3a4:9650])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1906:b0:4ab:6a4c:83a2 with SMTP id d75a77b69052e-4aedbc5d048mr14740211cf.39.1753817842099;
 Tue, 29 Jul 2025 12:37:22 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:41 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-4-marievic@google.com>
Subject: [PATCH 3/9] kunit: Pass additional context to generate_params for
 parameterized testing
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

To enable more complex parameterized test scenarios,
the `generate_params` function sometimes needs additional
context beyond just the previously generated parameter.
This patch modifies the `generate_params` function signature
to include an extra `struct kunit *test` argument, giving
users access to the parent kunit test's context when
generating subsequent parameters.

The `struct kunit *test` argument was added as the first parameter
to the function signature as it aligns with the convention
of other KUnit functions that accept `struct kunit *test` first.
This also mirrors the "this" or "self" reference found
in object-oriented programming languages.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/test.h | 9 ++++++---
 lib/kunit/test.c     | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d8dac7efd745..4ba65dc35710 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -128,7 +128,8 @@ struct kunit_attributes {
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
-	const void* (*generate_params)(const void *prev, char *desc);
+	const void* (*generate_params)(struct kunit *test,
+				       const void *prev, char *desc);
 	struct kunit_attributes attr;
 
 	/*
@@ -1701,7 +1702,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
@@ -1722,7 +1724,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d80b5990d85d..f50ef82179c4 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -696,7 +696,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
-			curr_param = test_case->generate_params(NULL, param_desc);
+			curr_param = test_case->generate_params(&test, NULL, param_desc);
 			test_case->status = KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
@@ -727,7 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 				/* Get next param. */
 				param_desc[0] = '\0';
-				curr_param = test_case->generate_params(curr_param, param_desc);
+				curr_param = test_case->generate_params(&test, curr_param,
+									param_desc);
 			}
 		}
 
-- 
2.50.1.552.g942d659e1b-goog


