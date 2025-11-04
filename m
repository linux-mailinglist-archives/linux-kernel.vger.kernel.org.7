Return-Path: <linux-kernel+bounces-884838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C0C3143F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBB34E251
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE132BF40;
	Tue,  4 Nov 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqtc6ou5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1932B9B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263667; cv=none; b=Gj/l1ag1UACLumq8weFdMMJIL1B4ix2q5D+w57y9M6A0HqK/tb2d8UwJzlbXn9tm0Q1bk+1WKihSJRIWe6+zdQYGQg0m/uRAMntbabvsuxyzorReOO1w3CH4X+6EBBCx0CGvV3nLF02i+G1LfFNriModWOqSrn4Zs8w6OMyo8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263667; c=relaxed/simple;
	bh=c1bDDCyExUmNe1HF4xwKZu77IBXLl0MUsBE8BWwSkww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u21JxQ/XKxbBi1jrQbtG8dKlRWytjYN+dRKg8fgCsUYf0Uo+ibNdpVSqB2FOWBMMlD10jaBTK8zXjjlft+zGThE6EOP4HwZYdMlWJcGTaXEi/mPFDN9i0sGckD8BEbf3zctFn0Oi9LemHFHG8OXUklDkJg9KApHJfsCM06ya/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqtc6ou5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-294df925292so50419715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263665; x=1762868465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zWSUJxMIOmC96LC4qtuVXdDyNI1GHx9xUdNCaZaj6k=;
        b=Jqtc6ou5Z2t/2zpzuQ1Tz/XOcuWqGA4VI1n8miVIwGuGBOJHnqSSmLNvDVA6dbA58v
         9d0QnjZjJ6t/aitMvzyRloK2i0VRFbx1uYFopzOnx3IMQOt4cBdFphGbwvbNQYzZlOFz
         jSyGR8LSSmjLXMZbylH783zxxU8D53yBgV9QxGuqbx9/1b5l1qSdB/ucnqnYWboT+ZZb
         14p/seKKyY/6DdFbSQKHMT46uEv3guj+gkAYvIDxYQ3S5qDqJvBLo2iN5yLtV4i4NNY2
         Rqb9XnREiq6cQlMwtiUEwlay3d+Q6KA/Z4aL+GbI+frpaaV8K3EHnprvgutF9UD+8FS9
         A3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263665; x=1762868465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zWSUJxMIOmC96LC4qtuVXdDyNI1GHx9xUdNCaZaj6k=;
        b=M7lRH6aDbnS6ObDT3GN++eS9UyM9bM0UFc3KNkd2vzQ8Fqak3vitrFf2xL2T03DK7z
         KGvWnTrl8jd+QD0ZY22tl86ywSQ+f/WGiECb0e1jXHM43hlvJI4iDEL6hIsFdQnvKGv3
         qooVIUAEd5a4JuqhPmPyRCEQDra8ffhZAOfQVPVkA8dkO9qUqwhSqNI+BTz0pZlX00xu
         Eu3DOdXqZxNeCSCVSzfDelYTDMxi961GZZ/uygZv/Qw3jGQH0+1A33X1Rj7Vc3QZrWhd
         tGL+DoOeAfYvgc5r90C5SL9ZWLsHiCbesaYn8Q6x8PzpX+J60whhLBZY+tJ/qnoIjbPd
         +fLQ==
X-Gm-Message-State: AOJu0YwlbiZrQrooktkvxmcrheZZR2U6YbhvENoM/5NLAP8rmTi/CS9L
	c/v6R8nAIYixAbu+f2F0rlx9qmfE6tPmyqT1QcX3lUouRYV+BBJlGTSj
X-Gm-Gg: ASbGncsrUyqGtdMN/9hzkqMILmPoX1nOExDncgS31Iw6Y3GYGaGAMJauFxoyRSO60Ez
	l0EbdwpW2YSWyJ5yU0af6nYMMh30nRQrvIZM68mFK/N186oKi9h7X+/YjzSA7+XNmHyNGVvtfXm
	YS56lQfOFQdWde5FDpEuftlz7P6ihxHPenTPlpAb/SgR7bGBGbqnGG4+pfbcdqdfW6h86WyM4IU
	DHP/g5mAk0dvmgfpWy6zN4myYWmUXdLZQfzeRZRIee9TBCsw4SF3WU21jNCg0Nr/XwBHGpZoAKx
	bZ9veAHUa3FRwJKlWfrusC+9gHhTpZFJ5PhNwLrZsHknI9WzAaPCbko5zOCmjSv8+vJ/EeEd3IV
	HZcO/yZWYFZABo78tsMQuChjx5umUnR0XtP9EqsoEYXj1jTalPYkzME0HABM/l8wMdGjfY1pBjd
	5j5hcjYHM9YvTFYFZKgf7C3UMQAcA=
X-Google-Smtp-Source: AGHT+IFWF62hNdotUyJIPELOStgUzmKw7yokMkoh5O48MpCq4zaNJbwqAYZ/JVQjN9FFQ3u/A6ecug==
X-Received: by 2002:a17:902:f542:b0:295:4d50:aab8 with SMTP id d9443c01a7336-2954d50ac7bmr166644705ad.24.1762263665091;
        Tue, 04 Nov 2025 05:41:05 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:41:04 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v4 7/7] selftests/bpf: Add test cases for btf__permute functionality
Date: Tue,  4 Nov 2025 21:40:33 +0800
Message-Id: <20251104134033.344807-8-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104134033.344807-1-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch introduces test cases for the btf__permute function to ensure
it works correctly with both base BTF and split BTF scenarios.

The test suite includes:
- test_permute_base: Validates permutation on standalone BTF
- test_permute_split: Tests permutation on split BTF with base dependencies

Each test verifies that type IDs are correctly rearranged and type
references are properly updated after permutation operations.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..2692cef627ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Xiaomi */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+/* ensure btf__permute work as expected with base_btf */
+static void test_permute_base(void)
+{
+	struct btf *btf;
+	__u32 permute_ids[6];
+	int err;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_ptr(btf, 1);				/* [2] ptr to int */
+	btf__add_struct(btf, "s1", 4);			/* [3] struct s1 { */
+	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
+							/* } */
+	btf__add_struct(btf, "s2", 4);			/* [4] struct s2 { */
+	btf__add_field(btf, "m", 1, 0, 0);		/*       int m; */
+							/* } */
+	btf__add_func_proto(btf, 1);			/* [5] int (*)(int *p); */
+	btf__add_func_param(btf, "p", 2);
+	btf__add_func(btf, "f", BTF_FUNC_STATIC, 5);	/* [6] int f(int *p); */
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] FUNC 'f' type_id=5 linkage=static");
+
+	permute_ids[0] = 4; /* struct s2 */
+	permute_ids[1] = 3; /* struct s1 */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	permute_ids[3] = 1; /* int */
+	permute_ids[4] = 6; /* int f(int *p) */
+	permute_ids[5] = 2; /* ptr to int */
+	err = btf__permute(btf, permute_ids, NULL);
+	if (!ASSERT_OK(err, "btf__permute"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[2] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=6",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[5] FUNC 'f' type_id=3 linkage=static",
+		"[6] PTR '(anon)' type_id=4");
+
+done:
+	btf__free(btf);
+}
+
+/* ensure btf__permute work as expected with split_btf */
+static void test_permute_split(void)
+{
+	struct btf *split_btf = NULL, *base_btf = NULL;
+	__u32 permute_ids[4];
+	int err;
+
+	base_btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(base_btf, "empty_main_btf"))
+		return;
+
+	btf__add_int(base_btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_ptr(base_btf, 1);				/* [2] ptr to int */
+	VALIDATE_RAW_BTF(
+		base_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+	split_btf = btf__new_empty_split(base_btf);
+	if (!ASSERT_OK_PTR(split_btf, "empty_split_btf"))
+		goto cleanup;
+	btf__add_struct(split_btf, "s1", 4);			/* [3] struct s1 { */
+	btf__add_field(split_btf, "m", 1, 0, 0);		/*   int m; */
+								/* } */
+	btf__add_struct(split_btf, "s2", 4);			/* [4] struct s2 { */
+	btf__add_field(split_btf, "m", 1, 0, 0);		/*   int m; */
+								/* } */
+	btf__add_func_proto(split_btf, 1);			/* [5] int (*)(int p); */
+	btf__add_func_param(split_btf, "p", 2);
+	btf__add_func(split_btf, "f", BTF_FUNC_STATIC, 5);	/* [6] int f(int *p); */
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[4] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] FUNC 'f' type_id=5 linkage=static");
+
+	permute_ids[0] = 6; /* int f(int *p) */
+	permute_ids[1] = 3; /* struct s1 */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	permute_ids[3] = 4; /* struct s2 */
+	err = btf__permute(split_btf, permute_ids, NULL);
+	if (!ASSERT_OK(err, "btf__permute"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		split_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC 'f' type_id=5 linkage=static",
+		"[4] STRUCT 's1' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0",
+		"[5] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p' type_id=2",
+		"[6] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=1 bits_offset=0");
+
+cleanup:
+	btf__free(split_btf);
+	btf__free(base_btf);
+}
+
+void test_btf_permute(void)
+{
+	if (test__start_subtest("permute_base"))
+		test_permute_base();
+	if (test__start_subtest("permute_split"))
+		test_permute_split();
+}
-- 
2.34.1


