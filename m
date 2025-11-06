Return-Path: <linux-kernel+bounces-888580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA3C3B315
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C1E1893001
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489232E722;
	Thu,  6 Nov 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7tChW0o"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDAC33373D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435244; cv=none; b=h3jqJSaUX8AvEL6Lpq+Lc8iPsWo+LFDkhaFxGNM3t0Z/PFU37lq+k8jDVRphzuh5h3RsMAFOoO0IUgBscIpiAj49WedYqKzzya+a+pj/jzPiZd+rKLT3d9cd4xOx6HMc/7vnDJtGUu1TwknOvlbVHOUW+BRs1dpeKU1vAEckf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435244; c=relaxed/simple;
	bh=kXTsduKxLo9uHmoNu6IW7eKc1GQZJpGYrGZWrIBc2AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbP0jETB2tyUjJ6ynVs2isTn44jA2F+KSsmMBfKadkj9O4+sXUTOvxv5jsvxgd9+X9G9qAjvatZO79fQeNF6JAZGarC9A7fZYujo4FXyVsXzGoyL0Jx0EsH93YPdzqy9QXFpZBrsM/rNdl/LtzkdkiqED9YvPV1aStrb49zorpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7tChW0o; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340ba29d518so713291a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435242; x=1763040042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbhqg+u2xhmrkRGLtmWVa4WGYDJR8aV9FcUmNybsdgM=;
        b=V7tChW0or7DHazekqe4Q4C541ArAOidzl94ATtmmzChhZHDMP9R1SwYjFXFE2Bq0cs
         qpSTRLwaVPObFR/cv5/UFjkfhVGgVhDYP2vk6F+Nqr/TO0KRUYOrr3HjX8XLXSd1k6sf
         jtQbzvW/SkefMCTXGGkg95cC5TGdGFR8BMeHMl83hu8/TtdQuusziYYrE5D3kYsxi6Qs
         M41tp+HZ1+higKmg51+71x352fDbBhhipTRhUGLbis+9AP06dL587xFlJkZHaXG+ZSH9
         wDl1hms/wdUuwksYN8FzZ1S8thKzPjBlwmkBLV3RWE1InDExTST1LLrBcDrxXAQcaxsg
         nmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435242; x=1763040042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbhqg+u2xhmrkRGLtmWVa4WGYDJR8aV9FcUmNybsdgM=;
        b=vaRS5l+O5BLj9+Rrg9Hv0U+n/o0osX1qsbpTGKyEmjGtPktD2ZamMv6dwNJLpZC26x
         glzBProxbWuAeBwyw5SjbvJdnazVqrxilEqFojtHIDGau2nGSVxju2eToyi4pxcr8epv
         L+8XYy6LmKO6SDBp3WQShc6AeBt0OKmhrkoW1911w4QhHicUYodperrosdGx9uYVMTj2
         nW5GjgcM5l8wyhw09iBwVfBwW/kOJrRZkIU4t/XmTjWjYx5BQoxBwwCTLO2YEFCtWuh0
         WPHRwpi4SLPnsQAy+csFfhuj4K1j9zHBn4/6Gbr1yonR1oouZMicMLtv/7scERjM/Y+c
         xbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL5jYBuTMJrsMZwW+/k4N1ZfX2X18U/d05XS39wiDagQErnK0RTuiomPUFRHkdm2vDefmiPYKwcmY30WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5fbGugfXISCsTDeRG9PJaxfEClq9BFu7Ein9ej6HoPc57prA
	AC5nPCu4kYOQ0En0OkFsODQ4zBB3f27MhqdgWLUvgy1m+TU2dAmM6ME0
X-Gm-Gg: ASbGncss0xQ8RyYQyUvraqEOjEhORgB7X+wrtY+utBKFS8ujPdKkynaxcyCGbjkkYGD
	C9EIrX4CLuxbxC0esCncVMI+z4+B+RFRGIu3sgPWnjnvCv+8CyQ+i3AWS5eCT/85lQPLZm3mtVx
	4TlKmEO5/MeFALdrEnDd+POAev7VxvTYFBTe0pg5vrIkdUZvKY/TFTlfYRuMtJdtwdg9X8N2EX6
	zunMG7a9iri3NnXg4LhDqwJMbAWWvOc7uzItG/G7xQq3b734qel2O3Omuej0nNYa1FEfEcvffkb
	BlvjcIY8vKhkezbZhuznSOi3StxxJ8Rz6KU6YqOCFml/HiqigWGjXsyKpLpycMC0kNLv5zdTleM
	izIUQPdh+/gbPmg8oQBAYkKS0pbJjXKnqAdD3/6LKa3une1DuR3sYk0hA/u/UUHmP8FROdbLNQf
	mFCcuczakUSImwfAoVWC9I+8CYNk0=
X-Google-Smtp-Source: AGHT+IFHVedB9NmBgtn6+nlw/N4zptK11GvUsLCXCmsB8fjmD3DGYnva+eMZrhOmWymj8Dw6tJk+tg==
X-Received: by 2002:a17:90b:1c07:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-341a6c4516cmr8047408a91.9.1762435241884;
        Thu, 06 Nov 2025 05:20:41 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:40 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH v5 7/7] selftests/bpf: Add test cases for btf__permute functionality
Date: Thu,  6 Nov 2025 21:19:56 +0800
Message-Id: <20251106131956.1222864-8-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106131956.1222864-1-dolinux.peng@gmail.com>
References: <20251106131956.1222864-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch introduces test cases for the btf__permute function to ensure
it works correctly with both base BTF and split BTF scenarios.

The test suite includes:
- test_permute_base: Validates permutation on base BTF
- test_permute_split: Tests permutation on split BTF
- test_permute_drop_base: Validates type dropping on base BTF
- test_permute_drop_split: Tests type dropping on split BTF

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 279 ++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
new file mode 100644
index 000000000000..edab03742598
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Xiaomi */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+/* Ensure btf__permute work as expected with base_btf */
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
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_base"))
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
+/* Ensure btf__permute work as expected with split_btf */
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
+	err = btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_ids), NULL);
+	if (!ASSERT_OK(err, "btf__permute_split"))
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
+/* Verify btf__permute function drops types correctly with base_btf */
+static void test_permute_drop_base(void)
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
+	permute_ids[1] = 2; /* ptr to int */
+	permute_ids[2] = 5; /* int (*)(int *p) */
+	permute_ids[3] = 1; /* int */
+	err = btf__permute(btf, permute_ids, 4, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_base"))
+		goto done;
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] STRUCT 's2' size=4 vlen=1\n"
+		"\t'm' type_id=4 bits_offset=0",
+		"[2] PTR '(anon)' type_id=4",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1\n"
+		"\t'p' type_id=2",
+		"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+
+	permute_ids[0] = 4; /* struct s2 */
+	permute_ids[1] = 5; /* int (*)(int *p) */
+	permute_ids[2] = 1; /* int */
+	err = btf__permute(btf, permute_ids, 3, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_drop_base_fail"))
+		goto done;
+
+done:
+	btf__free(btf);
+}
+
+/* Verify btf__permute function drops types correctly with split_btf */
+static void test_permute_drop_split(void)
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
+	err = btf__permute(split_btf, permute_ids, 3, NULL);
+	if (!ASSERT_OK(err, "btf__permute_drop_split"))
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
+		"\t'p' type_id=2");
+
+	permute_ids[0] = 6; /* int f(int *p) */
+	permute_ids[1] = 3; /* struct s1 */
+	err = btf__permute(split_btf, permute_ids, 2, NULL);
+	if (!ASSERT_ERR(err, "btf__permute_drop_split_fail"))
+		goto cleanup;
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
+	if (test__start_subtest("permute_drop_base"))
+		test_permute_drop_base();
+	if (test__start_subtest("permute_drop_split"))
+		test_permute_drop_split();
+}
-- 
2.34.1


