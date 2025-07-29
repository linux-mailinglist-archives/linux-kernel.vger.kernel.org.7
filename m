Return-Path: <linux-kernel+bounces-749848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2EB153A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4873B171C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A7A299937;
	Tue, 29 Jul 2025 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skk/bf9l"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F6298991
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817853; cv=none; b=qTQTQNHrXrMqOA2C+TciyvCoGCm0fdO8eox+xypGgQIPD8VLUA/+oNhh1a2yWBl2HBtDT5I2NgUH7H5nKYBWT5+qFU1N7/ZRRVzBjtax7l9wsiXi2mybl7d7eFMFxzfrDxppyQbQUE3PfuRGePOqTl5/1iuaPMzyP8SvpUvhx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817853; c=relaxed/simple;
	bh=/4hogQa763+Yru+B8uFoZGw0bD56NVRf4DWpvy0gbDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2PhMbAEisuvECURsRvDB2zn2wepbsfr8z+hVRttatSkI0OYnoPpfVX4B4NZ5JloDda+R2k+aMqYmbp/An7xGu7KDNMiBZOehVmc8gTMPWWOPMLuqUiNTpZx4m//xWl0qddaf6Q+LQDeexIsw+vWFL4fX61eEXpXZAoUualSs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skk/bf9l; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e33f7a58f6so944946885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817850; x=1754422650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=78rzCs5wryrNYhO305P66/dWltNV0BBuUlP5VrjuElY=;
        b=skk/bf9lzPqP1x8SJ9/9Kjs8reHlwA6MhB4juqhzuoBR9GpVBu7clrbq3rBY6jjNsK
         oUA7xynv8+LhvcBOtqiNi8exRtD27CHoF+iA//BKg0yn4LsshZwcaKHB38RoRIztlGiD
         HNOdJnaK45+JWWsTajmdQ9s+XKKSWy6Hj7V/SRKiNRPmkjaEc8MEskCuaxBiVDNvhsL0
         580qaz1p34xywiZDUVDi+NlKHdWKR9PP13EQvVOsF3cZdhWT7aPkB8UJRxeaexm1GgN3
         iY52Vb90ZQMgjWNGsel5tZwPggi0tlEGWefd/+WOM2nthFbDI7+Nz7AbMvUAJ4latFHP
         TqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817850; x=1754422650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78rzCs5wryrNYhO305P66/dWltNV0BBuUlP5VrjuElY=;
        b=Qh7WlC82aoruP3+MMkZZX8SuRBNNrPGtnuzOTnfzGu6AbFO8wED379/FoLnzAbjG+M
         R7ysak2CcyjxoOVwT54SEHQJHXMkLskNcq0tvLGvsepRKuFd8TUV3XLMNXj3kisghDLb
         zoE0Vm2gS7Nqce3gKbIAgltsc9XSqSQRZRmxyoXJDJeKYl/aopH2Y5kzKAI7lbMUcnow
         eYFs2N/lTNTy7Puoui7KvKeXhB7rpX+fz3qII6msLO+C/2GzRqA+cY9YKbkVLtWgUWjm
         2rSkHkOtN9XPsnkXnvUBlA1gcRV8mtxXSgCkR71CA1imVB91OSwUSX+GIGLTjTsOSWAL
         eL0A==
X-Forwarded-Encrypted: i=1; AJvYcCURUw2roZXgtY2RunnZuF34mg9G5hRuEqJTAlWHA6cZtIn5r9mE3A2e/OZwRU0x2c6+WvC+EczDGm9N9hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR17wVfQ5PSlE/bzbDLdPimRJSsp+u5sqk+9ZRBE8DY2u4jke
	o5jUMV37b/EFLhHt5lQVY1cfkUbdWmSAbTetgWMOYH1VaJPCtqTeIkugsFHd6Kz3jqhFhhmrmXv
	7YcYXP1G8pfhgSQ==
X-Google-Smtp-Source: AGHT+IEAbGfdfL/JeSj/QNivDbSUc7jd/zlcu+jeV8MtBFHncgWZqjaDWY9/m/krqd0ZJcolenCYgMNZ2HGpMQ==
X-Received: from qtbbc7.prod.google.com ([2002:a05:622a:1cc7:b0:4ab:a3a0:c3dc])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8b15:b0:7d4:4c48:d5b4 with SMTP id af79cd13be357-7e66f3b9ea4mr75650485a.56.1753817850191;
 Tue, 29 Jul 2025 12:37:30 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:44 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-7-marievic@google.com>
Subject: [PATCH 6/9] kunit: Enable direct registration of parameter arrays to
 a KUnit test
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

KUnit parameterized tests currently support two
primary methods for getting parameters:
1.  Defining custom logic within a `generate_params`
    function.
2.  Using the KUNIT_ARRAY_PARAM and KUNIT_ARRAY_PARAM_DESC
    macros with pre-defined static arrays.

These methods present limitations when dealing with
dynamically generated parameter arrays, or in scenarios
where populating parameters sequentially via
`generate_params` is inefficient or overly complex.

This patch addresses these limitations by adding a new
`params_data` field to `struct kunit`, of the type
`kunit_params`. The struct `kunit_params` is designed to
store the parameter array itself, along with essential metadata
including the parameter count, parameter size, and a
`get_description` function for providing custom descriptions
for individual parameters.

The `params_data` field can be populated by calling the new
`kunit_register_params_array` macro from within a
`param_init` function. By attaching the parameter array
directly to the parent kunit test instance, these parameters
can be iterated over in kunit_run_tests() behind the scenes.

This modification provides greater flexibility to the
KUnit framework, allowing testers to easily register and
utilize both dynamic and static parameter arrays.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++----
 lib/kunit/test.c     | 26 ++++++++++++++++++++-
 2 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 4ba65dc35710..9143f0e22323 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -245,7 +245,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)		\
 		{ .run_case = test_name, .name = #test_name,			\
-		  .generate_params = gen_params,				\
+		  .generate_params = (gen_params)				\
+		   ?: kunit_get_next_param_and_desc,				\
 		  .param_init = init, .param_exit = exit,			\
 		  .module_name = KBUILD_MODNAME}
 
@@ -294,6 +295,21 @@ struct kunit_suite_set {
 	struct kunit_suite * const *end;
 };
 
+/* Stores the pointer to the parameter array and its metadata. */
+struct kunit_params {
+	/*
+	 * Reference to the parameter array for the parameterized tests. This
+	 * is NULL if a parameter array wasn't directly passed to the
+	 * parent kunit struct via the kunit_register_params_array macro.
+	 */
+	const void *params;
+	/* Reference to a function that gets the description of a parameter. */
+	void (*get_description)(const void *param, char *desc);
+
+	int num_params;
+	size_t elem_size;
+};
+
 /**
  * struct kunit - represents a running instance of a test.
  *
@@ -302,12 +318,14 @@ struct kunit_suite_set {
  * @parent: for user to store data that they want to shared across
  *	    parameterized tests. Typically, the data is provided in
  *	    the param_init function (see &struct kunit_case).
+ * @params_data: for users to directly store the parameter array.
  *
  * Used to store information about the current context under which the test
  * is running. Most of this data is private and should only be accessed
- * indirectly via public functions; the two exceptions are @priv and @parent
- * which can be used by the test writer to store arbitrary data or data that is
- * available to all parameter test executions, respectively.
+ * indirectly via public functions. There are three exceptions to this: @priv,
+ * @parent, and @params_data. These members can be used by the test writer to
+ * store arbitrary data, data available to all parameter test executions, and
+ * the parameter array, respectively.
  */
 struct kunit {
 	void *priv;
@@ -316,6 +334,8 @@ struct kunit {
 	 * during parameterized testing.
 	 */
 	struct kunit *parent;
+	/* Stores the params array and all data related to it. */
+	struct kunit_params params_data;
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
@@ -386,6 +406,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
 struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
 		struct kunit_suite_set suite_set);
 
+const void *kunit_get_next_param_and_desc(struct kunit *test, const void *prev, char *desc);
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 int kunit_run_all_tests(void);
 #else
@@ -1735,6 +1757,30 @@ do {									       \
 		return NULL;									\
 	}
 
+/**
+ * kunit_register_params_array() - Register parameters for a KUnit test.
+ * @test: The KUnit test structure to which parameters will be added.
+ * @params_arr: An array of test parameters.
+ * @param_cnt: Number of parameters.
+ * @get_desc: A pointer to a function that generates a string description for
+ * a given parameter element.
+ *
+ * This macro initializes the @test's parameter array data, storing information
+ * including the parameter array, its count, the element size, and the parameter
+ * description function within `test->params_data`. KUnit's built-in
+ * `kunit_get_next_param_and_desc` function will automatically read this
+ * data when a custom `generate_params` function isn't provided.
+ */
+#define kunit_register_params_array(test, params_arr, param_cnt, get_desc)			\
+	do {											\
+		struct kunit *_test = (test);						\
+		const typeof((params_arr)[0]) * _params_ptr = &(params_arr)[0];			\
+		_test->params_data.params = _params_ptr;					\
+		_test->params_data.num_params = (param_cnt);					\
+		_test->params_data.elem_size = sizeof(*_params_ptr);				\
+		_test->params_data.get_description = (get_desc);				\
+	} while (0)
+
 // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f50ef82179c4..2f4b7087db3f 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -337,6 +337,13 @@ void __kunit_do_failed_assertion(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
 
+static void __kunit_init_params(struct kunit *test)
+{
+	test->params_data.params = NULL;
+	test->params_data.num_params = 0;
+	test->params_data.elem_size = 0;
+}
+
 void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log)
 {
 	spin_lock_init(&test->lock);
@@ -347,6 +354,7 @@ void kunit_init_test(struct kunit *test, const char *name, struct string_stream
 		string_stream_clear(log);
 	test->status = KUNIT_SUCCESS;
 	test->status_comment[0] = '\0';
+	__kunit_init_params(test);
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
@@ -641,6 +649,22 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
 	total->total += add.total;
 }
 
+const void *kunit_get_next_param_and_desc(struct kunit *test, const void *prev, char *desc)
+{
+	struct kunit_params *params_arr = &test->params_data;
+	const void *param;
+
+	if (test->param_index < params_arr->num_params) {
+		param = (char *)params_arr->params
+			+ test->param_index * params_arr->elem_size;
+
+		if (params_arr->get_description)
+			params_arr->get_description(param, desc);
+		return param;
+	}
+	return NULL;
+}
+
 static void __kunit_init_parent_test(struct kunit_case *test_case, struct kunit *test)
 {
 	if (test_case->param_init) {
@@ -687,7 +711,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Test marked as skip */
 			test.status = KUNIT_SKIPPED;
 			kunit_update_stats(&param_stats, test.status);
-		} else if (!test_case->generate_params) {
+		} else if (!test_case->generate_params && !test.params_data.params) {
 			/* Non-parameterised test. */
 			test_case->status = KUNIT_SKIPPED;
 			kunit_run_case_catch_errors(suite, test_case, &test);
-- 
2.50.1.552.g942d659e1b-goog


