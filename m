Return-Path: <linux-kernel+bounces-860497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C689BF0437
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B9B1891A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB72FC02E;
	Mon, 20 Oct 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIS5eU18"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693C2FC02F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953205; cv=none; b=Zg0ofNMGVZxNkxVqkuKwaItEOSpfZ1KOrsqZ/ow6LL5WXk7GnGftg9L5K4BK+5fTbIImXg7I02gt7LPCfMvGLJwjQsILUQvtu0qpgL/u2lABreUSO2J37InGWUdlTGnzogQ6IRaw/k7bGw75OLYUEG0WbMYhSGUSCXCA8BMvRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953205; c=relaxed/simple;
	bh=IjQMbN4uCocfVUDwL6EFxw7Rsgugh4x1pA9jRrVt/Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnO+/PzzBur1mv+DRmcRStGdjtLfeZShVaICuqknv9mI/aVRYmefYjKRn3uvdT7wNgBJjYNLo+exc5opSz5PWZsHeGWdAq8C0NJ7rTQAoir9fbYVePnhoIUuLGewj+7cMTY74+b8GhTWbvQ50ZLC7/i6AR6z1e6MsyuvccddnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIS5eU18; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33ba5fc3359so4166837a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953203; x=1761558003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbdHx55SiKCSzxbktDjMMd1XTHiIoKRKCPe02b30DtY=;
        b=iIS5eU1862GCrN+GBMRS3jh5jMZ8B0OuN3zFdi79yU5Un4Ns0DL/fPnYQ+dIQLgiGN
         TlTo4use5Uu3AoqTjaLML2+PCJA9Hp1wkJNZVieq/2jw10k8KvKYM7EPLw7+MoNK9BC9
         L4eL895ZfK6F4edmmKQx0OGn3LPOFn2JDL8TrGvFUz/TilEe6Bt5OA6kCMZc/11WYycI
         Y7kCpNs9OtEnLCc95QJ7cP3ztrvgG8yNQXw1hSBSagiqq+m3Ol0Y0VojWa7O4HrpMCVZ
         01WQrHoYzKINw8LxdylanYVcpydnQhfkwBHMJpeUhk3I8rf2zsFGalahrTl592WFY8Ml
         rArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953203; x=1761558003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbdHx55SiKCSzxbktDjMMd1XTHiIoKRKCPe02b30DtY=;
        b=Vc+KQJS+1MO+xfGE1Kxk6WkQywsfpL9rcIs+AMk+CzAIyoQ2qjxDnSv4Hl+dC2ES9J
         OQSFv/kHz7u92BZuUHPaQhKV68ucV/uojsMXqLZZKfzMU1kJw6//719I+MrLm2eEnCRP
         5V48CO9SYa13SxxWEiOOOQdq3YNSxidfXG4VdZr2MvQPxaizo/U8XuJbaquRkaTjnPot
         szMCNxGcFockAmeRTemLC4h8Nws86Y27BNGkjpM35oJh1rJQcrAZelWyxmCF+YU4qYjN
         YDDx74rXsQLlQLr/UJ1Ulf44+SBsRn0kVjvIJmBvr7RLa4swL1N+cX8HQWmYTPejbHZ3
         f/wA==
X-Gm-Message-State: AOJu0YzBcLfotnPoO61U77QbtwG2fV6Up4yLvrHzGgar1c3PdLE8ccYb
	0O7wf3LDznC6LwZMYC0VXQZcesb7ZjcEN+Q6NooxuWG8WPmhR03bEQPX
X-Gm-Gg: ASbGnctBKeQzvYXvx5+GQjRgOPDPADQuOGLJyOmTmO+fHZ959tB+2ybpx/7ejjEiLNW
	r3TxolPg+fVutoFgCQWn1cp9QF3b0aEjyg+LszirNKU4FMeOhB6syhcDU5AVSFr1RLAqIlnUJBm
	xafg+kpK+ueDubH0mrnF4lP5Uj4foaZL0qSDibuiF3WO4r8Vgw4QmIc5+OWiKc5h36fUqVLBM3i
	QGCvtpSj8RhOo6F4tnwlQLly/DXruMyTpOElzF1SJLN/1uADd4P5/Rcc3wYFx4dm12MAFCM27oa
	nhmqadFubc/udAeS6cyzX4527nTaCXBr65B3m+BPwaxv/uhnZe/Q/+2JkFk07EBtWtGVvEXmquD
	nKR4HVC6msYaxxxM1ggEWJlJZ1Uhgntg71JwS4TCDqVIp8zoK840P8+EyfyatlTkpgjeRXt0GDl
	M9sxn7OV0Wtgsz7PK1
X-Google-Smtp-Source: AGHT+IEef+qwgEeNZVUN3VcFN6oO7HlMYKL9/C161d0EvJAlwLbLhLAwqNLQboqPu0GGG05sCHS84Q==
X-Received: by 2002:a17:90b:3d8a:b0:338:3156:fc43 with SMTP id 98e67ed59e1d1-33bcf8740f8mr16528326a91.11.1760953203119;
        Mon, 20 Oct 2025 02:40:03 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:40:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/5] selftests/bpf: add tests for BTF deduplication and sorting
Date: Mon, 20 Oct 2025 17:39:40 +0800
Message-Id: <20251020093941.548058-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020093941.548058-1-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that BTF deduplication and sorting functionality works correctly

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 171 +++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..244f9d535bc2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -8022,6 +8022,177 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
 	},
 },
+{
+	.descr = "dedup_sort: strings deduplication",
+	.input = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
+			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 64, 8),
+			BTF_TYPE_INT_ENC(NAME_NTH(3), BTF_INT_SIGNED, 0, 32, 4),
+			BTF_TYPE_INT_ENC(NAME_NTH(4), BTF_INT_SIGNED, 0, 64, 8),
+			BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, 32, 4),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0long int\0int\0long int\0int"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
+			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 64, 8),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0long int"),
+	},
+	.opts = {
+		.sort_by_kind_name = true,
+	},
+},
+{
+	.descr = "dedup_sort: func/func_arg/var tags",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* static int t */
+			BTF_VAR_ENC(NAME_NTH(1), 1, 0),			/* [2] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
+			BTF_FUNC_ENC(NAME_NTH(4), 3),			/* [4] */
+			/* tag -> t */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [6] */
+			/* tag -> func */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [8] */
+			/* tag -> func arg a1 */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [10] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_FUNC_ENC(NAME_NTH(4), 7),			/* [1] */
+			BTF_VAR_ENC(NAME_NTH(1), 6, 0),			/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),		/* [5] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [6] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [7] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 6),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 6),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
+	},
+	.opts = {
+		.sort_by_kind_name = true,
+	},
+},
+{
+	.descr = "dedup_sort: func/func_param tags",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [4] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 4),			/* [5] */
+			/* tag -> f: tag1, tag2 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, -1),		/* [7] */
+			/* tag -> f/a2: tag1, tag2 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, 1),		/* [9] */
+			/* tag -> f: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 5, -1),		/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 5, -1),		/* [11] */
+			/* tag -> f/a2: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 5, 1),		/* [12] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 5, 1),		/* [13] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_FUNC_ENC(NAME_NTH(3), 9),			/* [1] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),		/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),		/* [7] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [8] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [9] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 8),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 8),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
+	},
+	.opts = {
+		.sort_by_kind_name = true,
+	},
+},
+{
+	.descr = "dedup_sort: struct/struct_member tags",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [2] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [3] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
+			/* tag -> t: tag1, tag2 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			/* tag -> t/m2: tag1, tag2 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, 1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, 1),		/* [7] */
+			/* tag -> t: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, -1),		/* [9] */
+			/* tag -> t/m2: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),		/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, 1),		/* [11] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [1] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 8, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 8, 32),
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),		/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),		/* [7] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [8] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.opts = {
+		.sort_by_kind_name = true,
+	},
+},
 };
 
 static int btf_type_size(const struct btf_type *t)
-- 
2.34.1


