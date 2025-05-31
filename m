Return-Path: <linux-kernel+bounces-668986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F5AC99D7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E453A82B5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 07:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE74E2367C9;
	Sat, 31 May 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUluujMm"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD69221D9C
	for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748676045; cv=none; b=b9aAJOvy8hkbu6P8vKrDx5/ALNG7u3Z1eVZ9yHQ4vju0p5LtzdvW/1Lys5RgvR6CVSypJA/84VFBqIpDdaP+lr5Gyer85trgsrcdFDsbC9ulUnKuarRkkruB3HyMoNzTk1Sr1Z2Hj9rfFu4VuMp/QM1wzfgRvUYx4RrolWMy3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748676045; c=relaxed/simple;
	bh=JYRAtjfbQbexez6DzLbAn++nRbKQ2hLy6stSmzX5WLw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g9QNkL/EN0CGaJ9fCgAXnnA6hdPkVPUoPueLRU0tyP7M1cx0EdgjERs8ja5QXz5GQKU9AkBubeIMJZdYllWLIAgxhEzssTbi3Fgeawo1vuuGtwzCXcZDVVoRtZ3As+CLgVEH5yhUomr0yYX6K0o3QDimxyBPhBK3gObSZfTs/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUluujMm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e4fe0c08so1884532a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748676042; x=1749280842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FnpYXBCDsrO3XrowDX8lwOY6h9hDw7KEtyfape8Lgkc=;
        b=IUluujMmTLr8Lq8RlCtUgVfdVgTBLaMQzTYCj9VYWhcNbscOLZ1S7+8tryRkTlCZ8E
         YptDDkif4WfHRUW52JPvdzMZW0XV9M+Z6HhDKA/FbZHkxx8Rd2kCqMy6aYj3U4G7ZI25
         GKAdEzsNxrgZU1tu3o+Ohl6ApzIFhKQrjag+Q9ZfiFIbzqzHSsaLkyENWDapINW0MDP+
         aZqtGoexVFUjYm/moLw9WZ1yAy86X0R2VR17WuJyUKMbq1OZq16easU2yLfMLnienoOT
         YYe6El9mPSUBfV0r4AH6+6VHZJBbI9Ce2JTGqiUcl60vDeCEWCTMTgoZBnMKAESeF/5W
         Ze5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748676042; x=1749280842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnpYXBCDsrO3XrowDX8lwOY6h9hDw7KEtyfape8Lgkc=;
        b=GBgU8h6RnHqIbEuwpXDCou7GWQgwNGZ5fExGCupUh115hBf5OZ3BrsluE2d2j6lK6J
         tUkvLvycAk5x2CB7iO4bcXZ9N+94D3D7V7Yce1cn7TuOzu0Yj6MydMYtlKHs/gdNG3Bx
         QXn4gHPmXHtte1SrVDFNFG8OM6kRvwz9FMql8ymF3J7MiGtUgHYK0UNs6FPwZ0xWybU1
         q2KsUvi0u9EXTP7U6N9N2AeUkP6TUYttn1ZESX68loLPL2RE4sQnoQJ3DQ7487XnapjA
         FJn7J+S8ds8PE0EaRNTq28IHxeezoYYDvI/eHHIL4oPBRTseIv7NPpNx7pIp2NZ1q4mA
         Keew==
X-Forwarded-Encrypted: i=1; AJvYcCWSXTJr3nKiMwfXNmKij41IX9AQjKCtffzRLzeMLIRAYLaSgwTD4Ex1jfI1aTXxWEzmEC7oKfhHqgHF6TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFroT+CvAaJzMTbPEs0n7r0UGps7VO7ju0EiNL4GgDrkrZ1JB3
	UuboPDBarnGB3FECD10OB2t9aa3mZEsRQdlwCZRpPAt92R21J9EVHWudxeg1omvmkGQZdorOCM6
	b89lYr6h1YRWkAC8A4HgKvg==
X-Google-Smtp-Source: AGHT+IHqVzQuAfCWZJ0i2lpECpuI8J7A8UURukqTUlT7ZQYqAtCFnDsazLTEp9TfImh5iMxGbxg/BVnItcPMlt13
X-Received: from pllq23.prod.google.com ([2002:a17:902:7897:b0:234:8a16:9a5])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf0a:b0:224:26fd:82e5 with SMTP id d9443c01a7336-23529b4637emr102706605ad.48.1748676042608;
 Sat, 31 May 2025 00:20:42 -0700 (PDT)
Date: Sat, 31 May 2025 00:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250531072031.2263491-1-blakejones@google.com>
Subject: [PATCH] libbpf: add support for printing BTF character arrays as strings
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

The BTF dumper code currently displays arrays of characters as just that -
arrays, with each character formatted individually. Sometimes this is what
makes sense, but it's nice to be able to treat that array as a string.

This change adds a special case to the btf_dump functionality to allow
arrays of single-byte integer values to be printed as character strings.
Characters for which isprint() returns false are printed as hex-escaped
values. This is enabled when the new ".print_strings" is set to 1 in the
btf_dump_type_data_opts structure.

As an example, here's what it looks like to dump the string "hello" using
a few different field values for btf_dump_type_data_opts (.compact = 1):

- .print_strings = 0, .skip_names = 0:  (char[6])['h','e','l','l','o',]
- .print_strings = 0, .skip_names = 1:  ['h','e','l','l','o',]
- .print_strings = 1, .skip_names = 0:  (char[6])"hello"
- .print_strings = 1, .skip_names = 1:  "hello"

Here's the string "h\xff", dumped with .compact = 1 and .skip_names = 1:

- .print_strings = 0:  ['h',-1,]
- .print_strings = 1:  "h\xff"

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/lib/bpf/btf.h                           |   3 +-
 tools/lib/bpf/btf_dump.c                      |  51 ++++++++-
 .../selftests/bpf/prog_tests/btf_dump.c       | 102 ++++++++++++++++++
 3 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4392451d634b..be8e8e26d245 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
 	bool compact;		/* no newlines/indentation */
 	bool skip_names;	/* skip member/type names */
 	bool emit_zeroes;	/* show 0-valued fields */
+	bool print_strings;	/* print char arrays as strings */
 	size_t :0;
 };
-#define btf_dump_type_data_opts__last_field emit_zeroes
+#define btf_dump_type_data_opts__last_field print_strings
 
 LIBBPF_API int
 btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 460c3e57fadb..a07dd5accdd8 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -75,6 +75,7 @@ struct btf_dump_data {
 	bool is_array_member;
 	bool is_array_terminated;
 	bool is_array_char;
+	bool print_strings;
 };
 
 struct btf_dump {
@@ -2028,6 +2029,50 @@ static int btf_dump_var_data(struct btf_dump *d,
 	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
 }
 
+static int btf_dump_string_data(struct btf_dump *d,
+				const struct btf_type *t,
+				__u32 id,
+				const void *data)
+{
+	const struct btf_array *array = btf_array(t);
+	__u32 i;
+
+	if (!btf_is_int(skip_mods_and_typedefs(d->btf, array->type, NULL)) ||
+	    btf__resolve_size(d->btf, array->type) != 1 ||
+	    !d->typed_dump->print_strings) {
+		pr_warn("unexpected %s() call for array type %u\n",
+			__func__, array->type);
+		return -EINVAL;
+	}
+
+	btf_dump_data_pfx(d);
+	btf_dump_printf(d, "\"");
+
+	for (i = 0; i < array->nelems; i++, data++) {
+		char c;
+
+		if (data >= d->typed_dump->data_end)
+			return -E2BIG;
+
+		c = *(char *)data;
+		if (c == '\0') {
+			/* When printing character arrays as strings, NUL bytes
+			 * are always treated as string terminators; they are
+			 * never printed.
+			 */
+			break;
+		}
+		if (isprint(c))
+			btf_dump_printf(d, "%c", c);
+		else
+			btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
+	}
+
+	btf_dump_printf(d, "\"");
+
+	return 0;
+}
+
 static int btf_dump_array_data(struct btf_dump *d,
 			       const struct btf_type *t,
 			       __u32 id,
@@ -2055,8 +2100,11 @@ static int btf_dump_array_data(struct btf_dump *d,
 		 * char arrays, so if size is 1 and element is
 		 * printable as a char, we'll do that.
 		 */
-		if (elem_size == 1)
+		if (elem_size == 1) {
+			if (d->typed_dump->print_strings)
+				return btf_dump_string_data(d, t, id, data);
 			d->typed_dump->is_array_char = true;
+		}
 	}
 
 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2544,6 +2592,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
+	d->typed_dump->print_strings = OPTS_GET(opts, print_strings, false);
 
 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index c0a776feec23..70e51943f148 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -879,6 +879,106 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 			  "static int bpf_cgrp_storage_busy = (int)2", 2);
 }
 
+/*
+ * String-like types are generally not named, so they need to be
+ * found this way rather than via btf__find_by_name().
+ */
+static int find_char_array_type(struct btf *btf, int nelems)
+{
+	const int nr_types = btf__type_cnt(btf);
+	const int char_type = btf__find_by_name(btf, "char");
+
+	for (int i = 1; i < nr_types; i++) {
+		const struct btf_type *t;
+		const struct btf_array *at;
+
+		t = btf__type_by_id(btf, i);
+		if (btf_kind(t) != BTF_KIND_ARRAY)
+			continue;
+
+		at = btf_array(t);
+		if (at->nelems == nelems && at->type == char_type)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+static int btf_dump_string_data(struct btf *btf, struct btf_dump *d,
+				char *str, struct btf_dump_type_data_opts *opts,
+				char *ptr, size_t ptr_sz,
+				const char *expected_val)
+{
+	char name[64];
+	size_t type_sz;
+	int type_id;
+	int ret = 0;
+
+	snprintf(name, sizeof(name), "char[%zu]", ptr_sz);
+	type_id = find_char_array_type(btf, ptr_sz);
+	if (!ASSERT_GE(type_id, 0, "find type id"))
+		return -ENOENT;
+	type_sz = btf__resolve_size(btf, type_id);
+	str[0] = '\0';
+	ret = btf_dump__dump_type_data(d, type_id, ptr, ptr_sz, opts);
+	if (type_sz <= ptr_sz) {
+		if (!ASSERT_EQ(ret, type_sz, "failed/unexpected type_sz"))
+			return -EINVAL;
+	} else {
+		if (!ASSERT_EQ(ret, -E2BIG, "failed to return -E2BIG"))
+			return -EINVAL;
+	}
+	if (!ASSERT_STREQ(str, expected_val, "ensure expected/actual match"))
+		return -EFAULT;
+	return 0;
+}
+
+static void test_btf_dump_string_data(struct btf *btf, struct btf_dump *d,
+				      char *str)
+{
+	DECLARE_LIBBPF_OPTS(btf_dump_type_data_opts, opts);
+
+	opts.compact = true;
+	opts.emit_zeroes = false;
+	opts.print_strings = true;
+
+	opts.skip_names = false;
+	btf_dump_string_data(btf, d, str, &opts, "foo", 4,
+		"(char[4])\"foo\"");
+
+	opts.skip_names = true;
+	btf_dump_string_data(btf, d, str, &opts, "foo", 4,
+		"\"foo\"");
+
+	/* This should have no effect. */
+	opts.emit_zeroes = false;
+	btf_dump_string_data(btf, d, str, &opts, "foo", 4,
+		"\"foo\"");
+
+	/* This should have no effect. */
+	opts.compact = false;
+	btf_dump_string_data(btf, d, str, &opts, "foo", 4,
+		"\"foo\"");
+
+	/* Non-printable characters come out as hex. */
+	btf_dump_string_data(btf, d, str, &opts, "fo\xff", 4,
+		"\"fo\\xff\"");
+	btf_dump_string_data(btf, d, str, &opts, "fo\x7", 4,
+		"\"fo\\x07\"");
+
+	/* Should get printed properly even though there's no NUL. */
+	char food[4] = { 'f', 'o', 'o', 'd' };
+
+	btf_dump_string_data(btf, d, str, &opts, food, 4,
+		"\"food\"");
+
+	/* The embedded NUL should terminate the string. */
+	char embed[4] = { 'f', 'o', '\0', 'd' };
+
+	btf_dump_string_data(btf, d, str, &opts, embed, 4,
+		"\"fo\"");
+}
+
 static void test_btf_datasec(struct btf *btf, struct btf_dump *d, char *str,
 			     const char *name, const char *expected_val,
 			     void *data, size_t data_sz)
@@ -970,6 +1070,8 @@ void test_btf_dump() {
 		test_btf_dump_struct_data(btf, d, str);
 	if (test__start_subtest("btf_dump: var_data"))
 		test_btf_dump_var_data(btf, d, str);
+	if (test__start_subtest("btf_dump: string_data"))
+		test_btf_dump_string_data(btf, d, str);
 	btf_dump__free(d);
 	btf__free(btf);
 
-- 
2.49.0.1204.g71687c7c1d-goog


