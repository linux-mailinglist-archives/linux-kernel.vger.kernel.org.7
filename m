Return-Path: <linux-kernel+bounces-884834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D3C3146F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0FCF4FA910
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBA32939C;
	Tue,  4 Nov 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPGPL81c"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C7329C74
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263657; cv=none; b=MV2Ru8SeYT2eUSKza/jgrbX0B0uUYJYpETDK/j8W28+GDkBpFxa37hp9EgDYfghaoHvhpwRL9Qa8ZUPmhDOGMMhEnuJt9iHWK4/tU+admiFBCjMofMkZcd4MIZWGX4dkwdbgsEnlSEzkfZCGywLqrNew1Oy0CYzpedTGrZeqkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263657; c=relaxed/simple;
	bh=sxhDvggn+kURFLHnP4sKqmyF/xkAhbHmgqNm1FXnJ04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLGb5P5XPZpHBPtD57BZBsUoZsk2+HzCpMKsK7oVnUkZpFcrIq+cyQXzpXNG+G8kxHSqP+3pcfJAOXRJ7pmZ0eHG5KNhci1QxFNKsmoQlENPdcT5hhjUVMcq6LMCkf61+ZhqE6C+ge/U2CuaVv5c4+roE4pZJ++XhEePG+E47p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPGPL81c; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3912701a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263654; x=1762868454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szWsdlIxdc1yPzeQJecGUmp1yECxwvwFo0ocAR3RlqM=;
        b=QPGPL81cbuiy+9SiLxmDtznC56agh7ujp0MiqXt42qkDiRmOtWUfJ45bXPYKl9ADqf
         AOaeY/IM9pth1h1LM7geGaRm0DMdy98V4+j2m7700BFSodq9cvL2SLkwKm/nyfoZJdLu
         oQh7RwL20ZI28en42FA1eTMhFXYTeK0Vr5wyQCkg00baInGa7gK5bqIWbzpI+YVZz/7s
         6xAAtxFhhkThy0pHTeeJDZxWYB/VR4IxtQL+gIXLwEX4srjSCtg2RK9+2mCI5YRiBaFS
         1a0FqVia99MblNzzXyq/sQvOjF5AXGhro04oYtThWBPdrH1KiBlyIOjDfc8m8mgsVRFJ
         ocXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263654; x=1762868454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szWsdlIxdc1yPzeQJecGUmp1yECxwvwFo0ocAR3RlqM=;
        b=v5Mg0MfzGNc2t6gr7YTxRekbD9K4yGWoXHoV7izwPAr3r0EHJKu20cX7fz2bZcRjZD
         A/goaS2pgLOwYVNKAkgMYYcSwBkAIwS93zNiVVm1VxU6uFqBK9JEY0hkhFvhELdfacPT
         EMM/P2Itllxbc+poUvNkzEQGzhynvxMwot1jakKJfPF9ZYdC8dgxr1EWwUpbHW6Z+pJx
         AoVbDDU5Y3nsJ2rlrZ29p/x1lHxSREsZYKqepQ6JPthcNDL/bdotq/yl9VeKhwaYaTvw
         hJr+ie+x85HjfdWSf/W8BgPSKSDJgCT2/S5/x+js6Q/ULQYtBcltiUpDCPdpJbs6sQG0
         7i+g==
X-Gm-Message-State: AOJu0Yzt/aTIc3O8sDj8FSfHt/7URqk6Oi6N/ze1PVmRGk//6nCz6SHL
	1PQFojVy89cTxJeKxaft9QspueMYhqiPBy8oBaDbba5P3qL4RHQ1pwo9
X-Gm-Gg: ASbGncsrOpwAu1uBeVt6xVZGGkwbtH9g4tcW7cziP73bvAZafcNYiSWJ58i2X9Zqm3f
	RoaiVOaVgmFIRLLtwdUHTw7ZXPtFX8wurL3+0SptJwc30Y234ErD8DGrgrWy1Bv8bheYdNB8bSH
	K5muIbF4strdeVs/gK/A+v5LdOs2Zz3ENnTlvCEqezN+OX5nv4eMDIWtEqIaqzczyWEeV3FVPid
	7dVBrDCKILVT6mPHHwP4v9BQom9IN/oqmXswi4o2ezBNmYo5e6Y4k6cAkhu/UtOzli91xuLpw23
	1Vq6JDcxXzdNtWBmGzwfqXUiyl0JPGAJ/8PDy+tv3ThbKPdnAcYjF6KtuEsVaReUSx2xBJRExZL
	tolQcJQaNxOSC2dCPOikQDXGo0sEuucGAZZthTHYhf8kFnbTiqyQoPVLxukHhGtciJdurB5iskw
	NNktiJ4KIF2zj3DQ2rNBbnutFkHPE=
X-Google-Smtp-Source: AGHT+IEqF1jp4cNM46whY+LqclZi/gWKtV/lCipaPe3oBTE3vhRYzKy2GK56YTcG8sUGG+WVznMFEw==
X-Received: by 2002:a05:6a20:3d8e:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-348cbda9bc9mr22112291637.34.1762263654453;
        Tue, 04 Nov 2025 05:40:54 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:53 -0800 (PST)
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
Subject: [RFC PATCH v4 4/7] libbpf: Implement lazy sorting validation for binary search optimization
Date: Tue,  4 Nov 2025 21:40:30 +0800
Message-Id: <20251104134033.344807-5-dolinux.peng@gmail.com>
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

This patch adds lazy validation of BTF type ordering to determine if types
are sorted by name. The check is performed on first access and cached,
enabling efficient binary search for sorted BTF while maintaining linear
search fallback for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5af14304409c..0ee00cec5c05 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -26,6 +26,10 @@
 
 #define BTF_MAX_NR_TYPES 0x7fffffffU
 #define BTF_MAX_STR_OFFSET 0x7fffffffU
+/* sort verification occurs lazily upon first btf_find_type_by_name_kind()
+ * call
+ */
+#define BTF_NEED_SORT_CHECK ((__u32)-1)
 
 static struct btf_type btf_void;
 
@@ -96,6 +100,10 @@ struct btf {
 	 *   - doesn't include special [0] void type;
 	 *   - for split BTF counts number of sorted and named types added on
 	 *     top of base BTF.
+	 *   - BTF_NEED_SORT_CHECK value indicates sort validation will be performed
+	 *     on first call to btf_find_type_by_name_kind.
+	 *   - zero value indicates applied sorting check with unsorted BTF or no
+	 *     named types.
 	 */
 	__u32 nr_sorted_types;
 	/* if not NULL, points to the base BTF on top of which the current
@@ -903,8 +911,67 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-/*
- * Find BTF types with matching names within the [left, right] index range.
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+	bool anon_a, anon_b;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	anon_a = str_is_empty(na);
+	anon_b = str_is_empty(nb);
+
+	if (anon_a && !anon_b)
+		return 1;
+	if (!anon_a && anon_b)
+		return -1;
+	if (anon_a && anon_b)
+		return 0;
+
+	return strcmp(na, nb);
+}
+
+/* Verifies BTF type ordering by name and counts named types.
+ *
+ * Checks that types are sorted in ascending order with named types
+ * before anonymous ones. If verified, sets nr_sorted_types to the
+ * number of named types.
+ */
+static void btf_check_sorted(struct btf *btf, int start_id)
+{
+	const struct btf_type *t;
+	int i, n, nr_sorted_types;
+
+	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
+		return;
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		return;
+
+	nr_sorted_types = 0;
+	n = btf__type_cnt(btf);
+	for (n--, i = start_id; i < n; i++) {
+		int k = i + 1;
+
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+		t = btf_type_by_id(btf, k);
+		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, start_id);
+	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+		nr_sorted_types++;
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+}
+
+/* Find BTF types with matching names within the [left, right] index range.
  * On success, updates *left and *right to the boundaries of the matching range
  * and returns the leftmost matching index.
  */
@@ -978,6 +1045,8 @@ static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
 	}
 
 	if (err == -ENOENT) {
+		btf_check_sorted((struct btf *)btf, btf->start_id);
+
 		if (btf->nr_sorted_types) {
 			/* binary search */
 			__s32 l, r;
@@ -1102,6 +1171,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->fd = -1;
 	btf->ptr_sz = sizeof(void *);
 	btf->swapped_endian = false;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1153,6 +1223,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -1811,6 +1882,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
-- 
2.34.1


