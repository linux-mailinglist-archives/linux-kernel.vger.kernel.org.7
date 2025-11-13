Return-Path: <linux-kernel+bounces-899351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08533C5776C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C12534F3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7732434FF76;
	Thu, 13 Nov 2025 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM28zDVD"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1034F261
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037630; cv=none; b=BpobdL+LNAiuhAtOWR5w1K60pIHkFsRL6CiuG0FXDaGXC2VIXEjzD9PhLAfSF1KqvcF801cqmNlxvTAaQ1+9wXq50VAtMWMYFxwuJ/j4V+0LQiYit42ncsoIOxoP2tfK7gclvnBRcSYDNO0Q6/Na4boom4acgxWLw4RLnEQ2yPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037630; c=relaxed/simple;
	bh=ZDIjKrxNRsNKjDHyHEBYoPmLkLVi1miMphnKseqdm2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRemEy9qbq8xXTilWwCv99Ojm9G7x/Dzi5IDYSu5kFtS3RftLqsXjmMWFCwO8mBsMuzGED41eymd3lAHdhOn9or+TwSSSsIMu0ErKUSIFkOLUPwvgCWYFf80licmiwLcliQIvDGkqdNRcliWI/JCdj4Bt4UmrXP8mWwzKCPu89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM28zDVD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso543435f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037627; x=1763642427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=PM28zDVDce/GS0oF5Z085lkACZLsnDDdLwESuUTD4Pl3O2qB4z06jXIZd8aT0OVH5t
         7pl06Je3UXw6k7hqGunUJvNBMKrLWjZThhX7Y/1wVDp2AbOKMr+SLFYd4y2jvfatkmVk
         bOJgo2p+S+LEwhNkclVUmAAk5LrCeYeqvL1GpQTVcBKsBiW3+af/KjsUZpKYhc1U7ARE
         DjQ8I/6lt8tXTJT0u9INEEEvl7wwbpQBefvfhD5i541ytYq6nLVPt7HW2ScbweCrLwBy
         R4PTlDTYWgJ1y7RalE5S6UkwsJ4GvrTkIvCDwtE3J9PBELEf7DmSc95Kr65d3iqFn2XM
         qlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037627; x=1763642427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=dDaL5j3QfqFTWUUrruR5U9t3o7f3onRjTrL5Jip+U1Mg2Nl2G6LQZQdIAvkRz9fWza
         hEcLWfJoFZZFJ4IqdHNlabnO/rHW9szSaKJN4/uycrFAkppmmASWbyWw+Xw6PuGvYq8Z
         yeyRnYiky25aGo132m4fU52t4l78KWM2sFDW2ZOS/8SqdIWinBr3fgzXXZe6oT7zV3Ud
         DBDoe+os4IkaCeouJ7ont8ZLBufVn2PfsgKXWw+Ey1ocTqdRsa/+yy3nCzc9fMyOvnIp
         BlBhGpWnHkPdJ6YH/5slJ7rxvTvdikhdKUKXYkwoWFmkn2q0gtPwvVP34t79HN/weMw1
         HL/w==
X-Forwarded-Encrypted: i=1; AJvYcCURa4VOpzRU8kQdzsnxNVVyqD9Dz48avDxpsqNI85/OxlXd6lqUZZ/uYUDLJYY/va9qN6lc2mHKDz6L6h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUNYULg3a4Thy5Crx28TnF5dnOveNtcRZ0IMSz7jcVAlWSAyc
	6JIpoAecBxs1E0GM+QJUtsTPKZJGaTB52c2h2LpC4JOCR9U7DDoL8Fho
X-Gm-Gg: ASbGnctAhG85HVhLCCqT7329jkjNmehK309LjuPMoes29crK0HDFMw0ejeo4c4Tyq6N
	f85TnlL4kAli2XPcRvfjSiPiiIl08heScitVXnj2QrqKLqk7E6F+lfeBfhJ3X86BrEaGcOLn3ex
	lFAMdnjqgIXUy3Z/CqJJT79RiD6XGTMGfNux/doRnJ0ESbm+PMw/7AwJkCAFasP8k/IdHNQ2qnw
	TT1KtslOeUmYiuoYY+H1XzGxiHMoFXwKT2nnMWKT8sp/9MGZM0D8frlSEbOmd/LEibalTO5r7Co
	8KbdLa49ECWaNlilJjlvxnZgxZJlbGPFQ9+GTXKThiQ3D8dVO0GqXzJrnAJxnnYwSj+nt1lzx2G
	Ik2poDoPbLNZH+tDNiGYrmCHuv9hP/dFgfJp0zNvwGFlAk5BJms/exOxUHk2JBuQsx6w4jq4PrZ
	yiUcUdAYOEss8oNURbgUz7ZGI=
X-Google-Smtp-Source: AGHT+IFMEpMMezmvxEMs766MRgjBKcLvtdSkSskQxUa3/4U12S0a20TELgCjrLTK7nBypapkTU9dgQ==
X-Received: by 2002:a05:6000:2f86:b0:42b:43b4:2870 with SMTP id ffacd0b85a97d-42b4bb91d32mr6647570f8f.26.1763037627088;
        Thu, 13 Nov 2025 04:40:27 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm3697140f8f.24.2025.11.13.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:40:26 -0800 (PST)
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
Subject: [PATCH v4 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Thu, 13 Nov 2025 13:39:51 +0100
Message-ID: <9fac2f744089f6090257d4c881914b79f6cd6c6a.1763037045.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
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


