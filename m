Return-Path: <linux-kernel+bounces-897358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EEFC52A19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1999534DD99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507FA27E7EC;
	Wed, 12 Nov 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5w+yE4d"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83D1F4176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956780; cv=none; b=OFIB9NBh4ADQKx0BGgY5tIEkzy3aiZpNFCBq/iv/1Wk5xxqP/fSaKWYPaC9jLgIVtfdJJpHnofJoSqVKmBrWM3eq0QO3sAuDvZ02A/T/djkU5gxlmdL5iTSM+lFPsFhzvf6DLQSjRiKyyS639At/eOEfctnEQNIG+VsxCkxWxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956780; c=relaxed/simple;
	bh=pVP2OILUU+1rzWIBbsAl/6YtKwi9rPRCel6NowAfs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuPG5hYh5W3lBAPyD9ZjClv7m7RRybukunWkFl/I5YPmrGcck2aDef2z+C85W/1QFn2KKHQGa2STL80ZteyUxqs6BxqJaaprG2A+kGQwpY9NXqGSuqGEdmG/8Ws9m4jrTnv13Dpov4vxqRHx/GVHuFjlrkFiko7sizF/uHtfXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5w+yE4d; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso724157f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956777; x=1763561577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/iGYxZtLORX3ELbLt9jFe4ep67d1sKTixtTlZRLqY0=;
        b=T5w+yE4dv6WzPr49oYvFbx6sySmsxGSB3B0Qbk4nQ2iXQcTVwvIyzXUoisE+/TLziq
         TJVaIpGg2MbmfBQe30SmDez0fy42VSR8vs0HewNTfCLOh5eigM301YfCkS2UeG204nu2
         06weNRsHhJ7lOHlcdEWPg/rF7BbGfX7y8t3UxipFzhB4UsvlYcQwLfP8ZRpyNaJ1GLVZ
         I7NgmN0W9ZyzMfChyFfVqFdgvcdHYNj0KBhKw1xXfFAOMDeOqGmBQQW/6PQChHxtgVEp
         wC51XPZ7P9xdRJ321g9P8g/VhRB6EcfCs+OuWSO+HZU8newRbhtALUAxQuCVR+DAYWK6
         T4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956777; x=1763561577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/iGYxZtLORX3ELbLt9jFe4ep67d1sKTixtTlZRLqY0=;
        b=VcwXTP/1GxtUbyh2uKcXIXrzf+xgAcREHmLbDLyrfshfzQ47XcIUfTETQR3CJ+Vg10
         NAvD+ym9RLqy0B50G19v2xzEdtTXP49qNLDQZTJoczO7b3PuxEQZbiWxk9lKA9g5XUPZ
         OdW/pjsZPq2GoUyr/ObOzXE5ReEfklr57LAAbR0EQcCj6ZzTY4ww5fh9E00zpe9RXE9L
         jMpMn77dPL4fqQcVrpZ6af+noX2QzQTwCiX19L2V6NxMQnG+CJ3cVYGxaw5Koc8at1nU
         E3OdZ7NXc0sgcP3CWAEEyGWqjlRj1/IAcPTQmYSL/d9EGoqbT9XgkddeW9sCGbRuxZzT
         6tsA==
X-Forwarded-Encrypted: i=1; AJvYcCXZDRMvAH7YMyw36vHFeb4WwP+tpZz2obMIs4qvkrdGwYes66b0hr3EgZ+pIG9OyOVatceHKMIaj3GFW7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqnBshIZJAQQSYmx2NMdc8M88uWyh+pXj7wFT/gwyRAqbHqaie
	JnLkefRjYCiT42I/Yo23+99ihxbUAXTisLO/NZ186URjaRXxM3/ZGSLy
X-Gm-Gg: ASbGncvjhbcfLG4RGCzSF82PslPIItFIZm8nxgkHxvrkCF3uV2rZsnq5VNsMBnaXULb
	DLBlOgDPmi57as1YwqarfUhAX0YaPaCyfY+2LBpkPRYUZPj3nXIbBGi4STrVWYNmQVlYS5PGV6l
	1ZBAvrOBRSZT1H89eURi+7m+dHU+GRYndpiAj7ZWqYAfrHkynFkm5YJ1VSoJyMxqFF/8If3Vt/z
	jmISUZVWeM6wWXUqrEQlU6uUheRFgacJQsp0oyc96elMP/BtMOgXb6lbx9W0Pw8r4IcKOKPz1Bt
	2zpeFK8tm2wQetythToa+CG/Wr23skKZ7bm6QuP21a/JISMA6A1coWDd4B4WckI654veQkJ+sFS
	HR1FRKS4oZwgtxDqAY5EegVVLIk8EIJjcz4ky7gkOUbPZoRPk7O06BhuiWonBB7JfN9mBfNYobZ
	uDd8lm5eFlf/Sp
X-Google-Smtp-Source: AGHT+IGYNoOTXnre/4ceRR7yKQ/OoOBBVZ7Ao+Bo2jO9uF7B6Yz0Tq6gekxjquRjIP2nqgGKT+RdVQ==
X-Received: by 2002:a05:6000:4210:b0:429:d66b:508f with SMTP id ffacd0b85a97d-42b4bdb03a9mr2990959f8f.30.1762956777196;
        Wed, 12 Nov 2025 06:12:57 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm28303603f8f.2.2025.11.12.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:12:56 -0800 (PST)
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
Subject: [PATCH v2 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Wed, 12 Nov 2025 15:11:34 +0100
Message-ID: <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762956564.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
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
 tools/testing/selftests/bpf/prog_tests/btf.c | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..a19db159475a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7495,6 +7495,67 @@ static struct btf_dedup_test dedup_tests[] = {
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
+			 */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
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


