Return-Path: <linux-kernel+bounces-899226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A003C5721E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 583C934D5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19E33B973;
	Thu, 13 Nov 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekL7KdFa"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DF2D7813
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032519; cv=none; b=jbWeqGSDyiOcxNhv6AKMPsqCLSRkl5vd6z1ntWs6F4QMRXRfOv0NmTJgui+lHvV996Ot2ppBKVERCM1dGqirGfkzb6MzcbXuAjgRYcPvOrM8RQxbIy/oxBeVoT6AK6SCdyMiFXEXByYBAQvBI+GZfaUMjKCy+ngTYqGVZssvtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032519; c=relaxed/simple;
	bh=ZDIjKrxNRsNKjDHyHEBYoPmLkLVi1miMphnKseqdm2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEJkG3AsCtgYj3NAQZfBTfCWA5osMX4DUDyk8tYbzKpmIf0APgYwofYS9E2/asvSB7xZ/kd7KzTmPOvE9VB8+RvDrW87/UcBLmJoWHnP17e4qLKx+ykgUoLxzAj4wgt4nqQUeqc9y3KQo+UR9o0B4RRv4t5sSqNiqLSfaxiHAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekL7KdFa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so14594005e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032515; x=1763637315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=ekL7KdFacIWNCU+Z7idSzNL5LXSB0isrLFrrCBfQoBIp9HIr6hcNxzf4TM29pfhvei
         IAB4tfNEYTqtYmURIMYZ2HmYFiGVzhaIp6owckjsGs/RRPkdGDYXwdOgC29BDDBqql7X
         Csft1dSvkN3q7siWtYZ7ZrSco2mtoS0knTnMLlvBCu5HUu849q9PzLWKGRdLtJUB00n/
         PKD/NGskl3JaPeBqVH5ROVBFEgy/xIB/4wrvP8YaguHq2Ag2qmggEYFEo1q3ETsxQxdU
         ViyPNDHlqJRUz7PasJ0uPaiR3o8tWeN2FkTCJ98GQEsAyyM3FXmceop/ZFXk6Q2ei/dm
         TWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032515; x=1763637315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=mbtvmLPfcobXD/zzehmAEBzYfn5mY3cUFZwvzuspGT6AOCTCztXYTBCPJy7SXkvVaz
         1BSVL/ZpHuAyPHaEwcR+xFodVZQWXjpnZL9vmfPIuMXR62uZhOc7lPNYfqNO+ZffS7sj
         vlSuWW/FChAW1SFK5Q73H2KcV4vTIcYVovgxdCGheFzEVOuIkQm5KseHPTMcXrDbw3rg
         /BAoHYuJEZKuFTHtDhtYsmC6gvh68QLy84buB//29BLjpY3nnZoZvfy7PTiT0yHMy9Ay
         ld2nQS0RCUVLmc7zh8z7hj5uPQAUadjVCKYZpnkjRYKou0SqIeejwUsv4jqwH46QpVpo
         jeew==
X-Forwarded-Encrypted: i=1; AJvYcCXDU+D2yw1emBeGH4jt3WZLJK3xPJI3Uv25qARy8H+RF4OGpBachVBzG+fsEDYD4pzhoCMCE2VEqwVnK14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cyTkv9ekwRhbKPxPAsdwx+TAnq+0sXD9ZXnPTiPMZi7l7lv9
	g1v67z0YnIO1r6PXImKj/WdkT+AqUIP/Q3GCClM6mCsRn/6Pfnsg3hkb
X-Gm-Gg: ASbGnculJi7/utQXebBlaqC9ODasFIxkz4RTn0u0uL05EzNtklq90t++Sbnhrluxue6
	KJkxzJTjXtVry06t3cyLbXnBht1s+b06TwRzi17530bpeQC41dMqt4gp9eWT0RYjT8TBpL4HbMl
	vLJR/1KJGRBwNhHBgvobKahuYKsaXkpGSmfWBaUQJ5oicIwMDUq7R34uTsTrTn+QJIWW91+8II9
	oaeOIQ64xxufRlkPHSQVoLVr8eRskhf50mqKGzv2s/LUPNuYc7ib5WtgUHzUjH1Au5NuixY3nFV
	ddMLVKIwTYY0PYC7NxMbY4zc05ancO/TQ6yCMDIpEdZNQbNXq1gJjeoKAVYmtL162Ep9QV4vJus
	fL16w4vZJXQdW/z5v8zdMejcsaIhJ3G7Ha0ZAdX4G+V58zTdndm82AaG4ZDt/4IBBVhMJGnGSo3
	jwvO5tIvWMfgBJ
X-Google-Smtp-Source: AGHT+IEXbGLWZEjRrYrXvD5qQyxHy/qVaSW5hVRb4W7YjSQHnlUr1eV81RIDEqWn4jjaLy1xF5bxNA==
X-Received: by 2002:a05:600c:285:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4778bcdb884mr18553865e9.9.1763032515217;
        Thu, 13 Nov 2025 03:15:15 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm17739825e9.12.2025.11.13.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:15:14 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v3 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Thu, 13 Nov 2025 12:14:06 +0100
Message-ID: <6aa4391604ee79ee7c9805906a7340ce60ff8a0c.1763024337.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763024337.git.paul.houssel@orange.com>
References: <cover.1763024337.git.paul.houssel@orange.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several ./test_progs tests:
    1.  btf/dedup:recursive typedef ensures that deduplication no
	longer fails on recursive typedefs.
    2.  btf/dedup:typedef ensures that typedefs are deduplicated correctly
	just as they were before this patch.

Signed-off-by: Paul Houssel <paul.houssel@orange.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..054ecb6b1e9f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7495,6 +7495,71 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
 	},
 },
+{
+	.descr = "dedup: recursive typedef",
+	/*
+	 * This test simulates a recursive typedef, which in GO is defined as such:
+	 *
+	 *   type Foo func() Foo
+	 *
+	 * In BTF terms, this is represented as a TYPEDEF referencing
+	 * a FUNC_PROTO that returns the same TYPEDEF.
+	 */
+	.input = {
+		.raw_types = {
+			/*
+			 * [1] typedef Foo -> func() Foo
+			 * [2] func_proto() -> Foo
+			 * [3] typedef Foo -> func() Foo
+			 * [4] func_proto() -> Foo
+			 */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 4),	/* [3] */
+			BTF_FUNC_PROTO_ENC(3, 0),		/* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0Foo"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0Foo"),
+	},
+},
+{
+	.descr = "dedup: typedef",
+    /*
+     * // CU 1:
+     * typedef int foo;
+     *
+     * // CU 2:
+     * typedef int foo;
+     */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			/* CU 2 */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [3] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 3),		/* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo"),
+	},
+},
 {
 	.descr = "dedup: typedef tags",
 	.input = {
-- 
2.51.0


