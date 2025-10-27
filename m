Return-Path: <linux-kernel+bounces-871742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1EC0E383
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A08BE4FE426
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9159F3090C2;
	Mon, 27 Oct 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls/pWkuR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12B3081CD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573281; cv=none; b=Rp/ExVhRPHb94fA8TBoNgJZDMerAONEFHMN8N+oYpO2ZLxIU6pCDppOxKc5lNmGVE3Ph2jvy8j/P5sLhjtZ0axJ01lsFvsFk/b9jvNwPy/u1VsZ+iRlxPCxb09O5z/0Kv8KHaye0d74Pe9gOyhrQL03t9m/B3VLBl+kHMyYZNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573281; c=relaxed/simple;
	bh=a2vWknJBLfGI/zn/aoQrvNPJmduxdpV0+V2L95agYGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQMIT3N778TRNT+qKUytU99A15k1f3KWqyjxs298R/aIDk6E9jckHXjQpzopdSSZON9qOS23WcnRZH99xDty+cBVQoIkDpUsvUYWL9jI+hkczDLLUWVuaWjvTQCWNjtpNe8Lh0RgLS103U51IdmZOCu/1RlzLn+AY+eVjdhNWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls/pWkuR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78125ed4052so5594907b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573279; x=1762178079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PULKnB7zB8mjvxqnQKYFYWmpI5jL7Y4AmR36CypPlxc=;
        b=ls/pWkuRZfztTsMi4aUO50AvMIAijbkkP/kRisxGBVOsHTaPaJHH9LBkTp631SuEmU
         pHCpY3gPUjve8lYVxW4intZyqtm7mkWoEWO8FxA9aNkHC6wqdI2FMuJkyKer29au5QDN
         4SHlTPUaZbbIPfnV4iwa7+KrARyzFUKxDOy+ewPM1laabpdbUELYr0DH8YBRGJ0cQAjp
         8mVBH/+wz0nv2PY25+3TsEOwJr5lXoP/p+9iCr3C3d57TSwxhd7lP+08pDd2yB5/d9BZ
         AdJWgMEPCve6xsZiSYZiGcdem43CffR+DlBGdT/a4mrESScxyL9wjleQAyNX0oWucQor
         N9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573279; x=1762178079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PULKnB7zB8mjvxqnQKYFYWmpI5jL7Y4AmR36CypPlxc=;
        b=ayWYSDPgP/7zUTZjSkGXjj5RbP3EkVEiMjr0020xTQ0ftktiUc6Mn+JUAXGKcs0Dng
         pag12dFS5XU+Gd0vb9Aa0Q4rc2+1nXGEkk73LMoyHFOyFwO5uoheSBboIuHHaJogl76t
         YSvqScfhy5XwHzi/gmMMjh034pp2I8VKh+jCe9ztKerVcyOrYjbIPJQImVwkkvWXFqZY
         2h1kBymz3xdY0eUxdVATJSAX3CsMQg7bgplWxk6QQR+N0MCyCUetDI7sBHueCaxo1cP1
         SDvww73exTST6UC7K4/v8rresXUkN913otmq2duT2/DdPSRs7xYBuA6epERz/fysgOVH
         SCCQ==
X-Gm-Message-State: AOJu0Yy8Pi72v0LiBf9QL3j5SXZoqmjMAC/Asv20o78sMtsknzLEBSrb
	I6Ja+XkqOKQCFDprXGkP+SdHzxhvFR/C9xgQgff7BD3h+GCDSIWj5E9YERn6hESy
X-Gm-Gg: ASbGncvhb89BihQ8AovlBXGynmwjAcAqag86PajJymMy4kr/ckhD1SrP8bR6xyWfIct
	fCoiXH/MbILGJD71+h4kclnptQ0kSM5G3DWm/qYZ6sRq/IzcjjE4ANvcN/jpqdDLKH00xTXYTNX
	PI0Z5a7Hyf0xZcDKyJQWF3VhkqI9tiGhQ6l07AQKmc/ky6FU1P+zbJI1CJ8Wx39RylFSoZN5oZi
	pHico4RPz7miTRlIuaszv3qPvztrXk/+kL/ovNRDuREKyUliqDwlf5KGBYmeEoULOTn2e2ImdQc
	FpVuz0ThVFmPQ6emnzbH4u1SR5AxV72AXiBiV8+TN3mrc5ir4qICfFGjlcmUT4sOVu5wpc5ka1F
	dCpb3+B3ROB+e6Ok7ZVjKoP/pGraOpIoT6JuA+GKZn0s63QV5+w/a6yJyYfpujqwB0ICTQi3Fh2
	ZoIDbli640QUZECUKXbpVuxqgvHDQ=
X-Google-Smtp-Source: AGHT+IFnV9PyudavkwUaPZ+kQ2ILlWTFIEiZjdh7kZ2svze02eKMLqOGH6tVrMcgIL5JQBCMaj65Ug==
X-Received: by 2002:a05:6a20:918c:b0:33d:5411:261b with SMTP id adf61e73a8af0-33d54112630mr16917813637.26.1761573279427;
        Mon, 27 Oct 2025 06:54:39 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:38 -0700 (PDT)
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
Subject: [RFC PATCH v3 2/3] selftests/bpf: add tests for BTF type permutation
Date: Mon, 27 Oct 2025 21:54:22 +0800
Message-Id: <20251027135423.3098490-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027135423.3098490-1-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that BTF type permutation functionality works correctly.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 109 ++++++++++++++++---
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..0688449613d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6935,14 +6935,18 @@ struct btf_raw_data {
 	__u32 str_sec_size;
 };
 
-struct btf_dedup_test {
+struct btf_dedup_permute_test {
 	const char *descr;
 	struct btf_raw_data input;
 	struct btf_raw_data expect;
-	struct btf_dedup_opts opts;
+	bool permute;
+	struct btf_dedup_opts dedup_opts;
+	struct btf_permute_opts permute_opts;
 };
 
-static struct btf_dedup_test dedup_tests[] = {
+static __u32 permute_ids_sort_by_kind_name[] = {3, 4, 5, 8, 11, 14, 6, 9, 12, 15, 7, 10, 13, 16, 1, 2};
+
+static struct btf_dedup_permute_test dedup_permute_tests[] = {
 
 {
 	.descr = "dedup: unused strings filtering",
@@ -7105,7 +7109,7 @@ static struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0s\0x"),
 	},
-	.opts = {
+	.dedup_opts = {
 		.force_collisions = true, /* force hash collisions */
 	},
 },
@@ -7151,7 +7155,7 @@ static struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0s\0x"),
 	},
-	.opts = {
+	.dedup_opts = {
 		.force_collisions = true, /* force hash collisions */
 	},
 },
@@ -7354,7 +7358,7 @@ static struct btf_dedup_test dedup_tests[] = {
 		},
 		BTF_STR_SEC("\0.bss\0t"),
 	},
-	.opts = {
+	.dedup_opts = {
 		.force_collisions = true
 	},
 },
@@ -8022,6 +8026,72 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
 	},
 },
+{
+	.descr = "permute: func/func_param/struct/struct_member tags",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
+			/* struct t {int m1; int m2;} */
+			BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),		/* [4] */
+				BTF_MEMBER_ENC(NAME_NTH(5), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(6), 1, 32),
+			/* tag -> f: tag1, tag2, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 3, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 3, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 3, -1),		/* [7] */
+			/* tag -> f/a2: tag1, tag2, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 3, 1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 3, 1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 3, 1),		/* [10] */
+			/* tag -> t: tag1, tag2, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 4, -1),		/* [11] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 4, -1),		/* [12] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 4, -1),		/* [13] */
+			/* tag -> t/m2: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 4, 1),		/* [14] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 4, 1),		/* [15] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 4, 1),		/* [16] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_FUNC_ENC(NAME_NTH(3), 16),			/* [1] */
+			BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),		/* [2] */
+				BTF_MEMBER_ENC(NAME_NTH(5), 15, 0),
+				BTF_MEMBER_ENC(NAME_NTH(6), 15, 32),
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 1, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 1,  1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(7), 2,  1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 1, -1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 1,  1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 2, -1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(8), 2,  1),		/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 1, -1),		/* [11] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 1,  1),		/* [12] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 2, -1),		/* [13] */
+			BTF_DECL_TAG_ENC(NAME_NTH(9), 2,  1),		/* [14] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [15] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [16] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 15),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 15),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.permute = true,
+	.permute_opts = {
+		.ids = permute_ids_sort_by_kind_name,
+	},
+},
 };
 
 static int btf_type_size(const struct btf_type *t)
@@ -8078,9 +8148,9 @@ static void dump_btf_strings(const char *strs, __u32 len)
 	}
 }
 
-static void do_test_dedup(unsigned int test_num)
+static void do_test_dedup_permute(unsigned int test_num)
 {
-	struct btf_dedup_test *test = &dedup_tests[test_num - 1];
+	struct btf_dedup_permute_test *test = &dedup_permute_tests[test_num - 1];
 	__u32 test_nr_types, expect_nr_types, test_btf_size, expect_btf_size;
 	const struct btf_header *test_hdr, *expect_hdr;
 	struct btf *test_btf = NULL, *expect_btf = NULL;
@@ -8124,11 +8194,20 @@ static void do_test_dedup(unsigned int test_num)
 		goto done;
 	}
 
-	test->opts.sz = sizeof(test->opts);
-	err = btf__dedup(test_btf, &test->opts);
-	if (CHECK(err, "btf_dedup failed errno:%d", err)) {
-		err = -1;
-		goto done;
+	if (test->permute) {
+		test->permute_opts.sz = sizeof(test->permute_opts);
+		err = btf__permute(test_btf, &test->permute_opts);
+		if (CHECK(err, "btf_permute failed errno:%d", err)) {
+			err = -1;
+			goto done;
+		}
+	} else {
+		test->dedup_opts.sz = sizeof(test->dedup_opts);
+		err = btf__dedup(test_btf, &test->dedup_opts);
+		if (CHECK(err, "btf_dedup failed errno:%d", err)) {
+			err = -1;
+			goto done;
+		}
 	}
 
 	test_btf_data = btf__raw_data(test_btf, &test_btf_size);
@@ -8249,7 +8328,7 @@ void test_btf(void)
 		do_test_file(i);
 	for (i = 1; i <= ARRAY_SIZE(info_raw_tests); i++)
 		do_test_info_raw(i);
-	for (i = 1; i <= ARRAY_SIZE(dedup_tests); i++)
-		do_test_dedup(i);
+	for (i = 1; i <= ARRAY_SIZE(dedup_permute_tests); i++)
+		do_test_dedup_permute(i);
 	test_pprint();
 }
-- 
2.34.1


