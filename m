Return-Path: <linux-kernel+bounces-884837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A090CC31481
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D084E464722
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04F32B9A9;
	Tue,  4 Nov 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfS5D4fc"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AA329385
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263663; cv=none; b=ClDVqEFatxLtG5k/geQcV0NOUQNEmfurPoWA8Xqkfu5a+2tTMI5/5yRj5JH3dXCiNwrxXJdrStMnMozoFZ739CZU97wZG7ypUJOJaW9G3Bcb9314xISfGwjewRZCivOjMay8TxHKmM7FBevNcuyUhVC2nZwWUXFu9ovB/whSYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263663; c=relaxed/simple;
	bh=YhPYNJZFXEH3DqLl890OXpoNt5wtfd9zUXgWwSlWmnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNORkpAHg2CCZcDsEJ7tqd6ar6knyNYjYd5zTd1Wzy5YgZQeyw1O7oW8AV7YOx/oEDOhsdzLhVq7xa9YKNqYZHmk5NfzQyOsG6FEVglaaPypZzw3afzBhm7hBXwULTrwtrd4gjiC8jwBgoV2WsjppPyJgEs5zHf4ylYek5FqIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfS5D4fc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso6889486b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263661; x=1762868461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyvKaozorZTBSzeG44mKs2zUGk0qFaFKA//27+I4xKM=;
        b=dfS5D4fcrgyqiSQdidiGLa61QLnTQsQJeSHCbxDYhtkwtYJnXOSxXPnJX0ECNB6tbZ
         kMpQ317Wz0ZxvhitZSXAQmFlJBMz2gQCKbtE2yckAXrqr/pkGhB8CRLe3m3hsgM3roD/
         A9K6QWYkR0LhPm3/DAgY4VtleMVpxKImBPuiP15gXsoHiQesJdMMdSEM97xSuHhG6+qY
         Ie1D9u5XNh1a1WB5gLDKNh18Fb1uDhD1rpyI+tfI53H80gouXd7CGxC4+rIK3k/XHtPe
         Nh2lo4morJo3d/sXdtpC9gF8LrEjvLNMy89Iw6K+dUy2psRKyMIeAwdp9zDxRSi71vO5
         UDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263661; x=1762868461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyvKaozorZTBSzeG44mKs2zUGk0qFaFKA//27+I4xKM=;
        b=HPfnLHHnkAZthBlZOEBo61eprSAtw3V1f/ivXDqKgsIKQ45G7BxvngF3gWHHNPXMjr
         62gHeAzDEfCVhKSAo9KrMxVDhRwRcIohfxsmEG+c55TocjVSmMD01ZgFxlO5Nx7qH8N4
         mjicl9w2tdS5pArywSYtd0dvRgx3fXLFKm9O/Pbt0C3R/cut3GWv3AeqRIZbNQcGX7r7
         f2/KfrcgBtsaovB+ZFmORYgRKG5Y8CLDzXAUQYEP1yXEqoKziyhuhNrPsZPeuaNdqpcf
         yFVExZqr4iqnbCTux4a6+QkdwTY8FfPfeTiPZwcC+UKmrps3fPFvRLbH64cHlZ72kwJi
         10Aw==
X-Gm-Message-State: AOJu0YzySDpf+CAAB7kwJ/LyKmUd1+FHO/T9seFDxUY7G2GI8cUdUZNt
	ufGCalQDRqmOEGKaAqUqZbbbMkhtlUWjmmXu3YHbcgqMDEUyEk67OwIH
X-Gm-Gg: ASbGncsN7ddq3DZvlDTnScMjUQvQRSpJ5sKcisR22Ra1g3btG+Ysy2pCva8U1qLXmqJ
	E/AWX/jR+cmSN5dwsA9jwfhZlJyvtHKbhT9us9re5sAdWVsBC+apY7/S0ARU5/P7xZ47aH5qfzv
	/mx5rt+m2PUfWI92aCi2/9zzCSzm7glBRrLDQC5DsF/9onjeRZbqDrBOqkFmHuEnG9X5ypegH6d
	WlXhc5j5a09XiNWePkibW46PpYIQVpHIUUfVPvQDK0CYy+JbPmbLmRvGG+X6LU1iT5sPT1PpDp1
	uAk9pKiS6Zsb/DH+WmZZvWEKc24sXxVG8qiWnVYD8K95Ky+EHuhm0KslFoVpK11AbpnFbr7z4PH
	zsZ+jeHBqxtUK0DnZ+JIlygtpRi9ZEtMzLiFb6ZUWZSxZFDWncBJuSKVmXLPLdmVslhSk6+G2or
	s1KO2fRTZZbzihSLYB
X-Google-Smtp-Source: AGHT+IH3DRVhPlh4emSZg1dm1+iTAic5V+qWeWDSQkHbTRONigJBsNgybx0L0pzSSZX0CG6cHLsNRg==
X-Received: by 2002:a05:6a20:728a:b0:340:f36d:6b03 with SMTP id adf61e73a8af0-348ca15b031mr19019665637.9.1762263661522;
        Tue, 04 Nov 2025 05:41:01 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:41:00 -0800 (PST)
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
Subject: [RFC PATCH v4 6/7] btf: Add lazy sorting validation for binary search
Date: Tue,  4 Nov 2025 21:40:32 +0800
Message-Id: <20251104134033.344807-7-dolinux.peng@gmail.com>
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

Implement lazy validation of BTF type ordering to enable efficient
binary search for sorted BTF while maintaining linear search fallback
for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/btf.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index da35d8636b9b..c76d77fd30a7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -192,6 +192,8 @@
  */
 #define BTF_MAX_SIZE (16 * 1024 * 1024)
 
+#define BTF_NEED_SORT_CHECK ((u32)-1)
+
 #define for_each_member_from(i, from, struct_type, member)		\
 	for (i = from, member = btf_type_member(struct_type) + from;	\
 	     i < btf_type_vlen(struct_type);				\
@@ -550,6 +552,65 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	if (!ta->name_off && tb->name_off)
+		return 1;
+	if (ta->name_off && !tb->name_off)
+		return -1;
+	if (!ta->name_off && !tb->name_off)
+		return 0;
+
+	na = btf_name_by_offset(btf, ta->name_off);
+	nb = btf_name_by_offset(btf, tb->name_off);
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
+
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		return;
+
+	nr_sorted_types = 0;
+	n = btf_nr_types(btf);
+	for (n--, i = start_id; i < n; i++) {
+		int k = i + 1;
+
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+
+		t = btf_type_by_id(btf, k);
+		if (t->name_off)
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, start_id);
+	if (t->name_off)
+		nr_sorted_types++;
+
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+}
+
 /* Find BTF types with matching names within the [left, right] index range.
  * On success, updates *left and *right to the boundaries of the matching range
  * and returns the leftmost matching index.
@@ -617,6 +678,8 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 		err = btf_find_by_name_kind(base_btf, name, kind);
 
 	if (err == -ENOENT) {
+		btf_check_sorted((struct btf *)btf, btf_start_id(btf));
+
 		if (btf->nr_sorted_types) {
 			/* binary search */
 			s32 l, r;
@@ -5882,6 +5945,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6301,6 +6365,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6418,6 +6483,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


