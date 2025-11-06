Return-Path: <linux-kernel+bounces-888579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4364AC3B399
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D24428014
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A41333733;
	Thu,  6 Nov 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP4Weuxz"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D574332916
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435240; cv=none; b=bccryM1L48X4f4lvJH58/p6/h7gI9VMP+5usHnm5atXXKKlExuBzA6FYaCL/RH5e0TTQ18Exu6RMLzPep5mYcR4RUY1kriA7WkW9/EfoQeu5r24JDMYCOOSyDnITscDusIZoKuUcIXG99z1Y4aE7h39XNnpHlePsbw+YsVwi/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435240; c=relaxed/simple;
	bh=/oZgc5EZQ0oqNKRJlEKYw6rWHvpsXgnnWABDSIU5hdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP1G2J3fwEDq9H5QVTS7xc4wdWdvukk8kDvVMlB4q5aBl8RyoQk37iXwk5CV5O5xtvJlM2Owul9xTiKfHVLDL90aBrPgqD0zfaNbc681JsT9Guwdu9ObtKBr9EAFUMvjUzw3kdI9CRVsPxOftx8FSDBBjgvH0GD+WFYTlsO4mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP4Weuxz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso965603b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435238; x=1763040038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgFobqwTDCy/M0FzLCDbAJgfJuKUpynhUI9wDqv4IFk=;
        b=fP4Weuxzzc5ghHkGZgCdmZU3ZOa2/PFr5IruKjJPDxHS+QDBurApmMSWGsuf5su7oC
         Og1CSuyDR3UEvWRjVnQHkfCB7CfoHsuRiP3Ne4KMdNxWPfkTYlPEXzfNcxHn9+Ncm3PN
         da66Tl05YXaJi3cFLTjpJLrApBv2qP5aGTymCkMlVJ/krPIdQL7guK0GO55E3wB3lst8
         np56ciNydDhTPkEhPQAqHqT9x8Z9Yy3aAa1iUpX4u3VYSumCk3aDOpJ8FuWdVVIQv75j
         HprxJDf6VYe59rajnaKPv7pObdKy5SZSjtgcZlgdD50ovPEapx9xorqfFRiCUtTHJso8
         e+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435238; x=1763040038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgFobqwTDCy/M0FzLCDbAJgfJuKUpynhUI9wDqv4IFk=;
        b=DcYTT1fqUDDbmnoe+xvHj7F3yezZeTry1q4YdeCdaYJ3mqlnLA3Gn9+PUOjp3SV2+o
         MExOrc1eMnWNZixkPyMIaPweYaT1arA4PplyBd5vXk9jofODM8orlw7Oby3fZ6HhiRGE
         fEbOs+vYtTm3IJmMdm61i0BIYnn9hETCMVtHGFxbSPXNaXz/Byb5Kf/f4o0QzC0Xhyxo
         ilGQk/tHpLHtaUoEG0bSszAdwJ4Wv4FH/6R8z0kwSyum33OjpNFgengYMdw78+TkmRhh
         u2bXKETb+/2kQ/5Fl02cyEsuX1h07nL5IOzDj7XYQ3gx//eDSesKjCml37tCryq1hgXQ
         mpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2QqAbsJ9OdG6HjayVsakvL+nuXcvvU7JnG97ENVnbd0LAOIsjOuHbgpp26958Xj1dhSK6iQsMO+Yh1UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEawOkEGd9jMPLFmDAIJeT/n79bqozSADgTs2NlaDdgetjfWt
	fWNKNE7DaD66jhBprj5I/jT1pkkI+4Z9UE9KTOfvsGaU8IoKNupT1Fdl
X-Gm-Gg: ASbGncv0POi0z6kofMCEj613EKfbzoXULwPaLCR5lxJDo7raqRB0q8mYKKZOWEuu0yO
	HCh0C4Z63YTcOqBXu4EYIKnd8lN9QnwRmF65uS1Qna6zEksn6l5O7zyB218zHNjEAoU/IhEuFbD
	0L59qvULgwi0qOF+78H/2ZirPYRClKtSJI/9jzXQOV360SPD8SwTxCsFIdmEzNYwxiZRcYJNp67
	tFrvS9lpNVj0F9UnZtQ7sHXgEH/WykhYF8NYeFXQGv3Xk5rks23epNtl2dkJ6DJK/u7ctuQFPm1
	ElrVg1yx3GOMy/Hbp50gp5kCDqxPtumiGAHxx01/+9DZ7ZVjuKhfgOMHVn/tgTeb+SJWMAvX3Gl
	kcLNtxRGfi9jdK6hJ64Ik4Peoo3K+7N6Hvj5WfBlGwg26HN1k8k0KWP+VomQo3rKF8Niuq6aFWX
	qMLp+XttuPgZB7vk3V
X-Google-Smtp-Source: AGHT+IGmChUlKr4zR+bh7ahXgtDaj2BWrn64VpiXcCg95goTFuCvcJ8ABcPCYkwKgODrux1uBreeEw==
X-Received: by 2002:a05:6a20:6a0f:b0:34f:1c92:769 with SMTP id adf61e73a8af0-34f83b0e78cmr9394651637.16.1762435238328;
        Thu, 06 Nov 2025 05:20:38 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:37 -0800 (PST)
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
Subject: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
Date: Thu,  6 Nov 2025 21:19:55 +0800
Message-Id: <20251106131956.1222864-7-dolinux.peng@gmail.com>
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

Implement lazy validation of BTF type ordering to enable efficient
binary search for sorted BTF while maintaining linear search fallback
for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/btf.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 66cb739a0598..33c327d3cac3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
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
+/* Verifies that BTF types are sorted in ascending order according to their
+ * names, with named types appearing before anonymous types. If the ordering
+ * is correct, counts the number of named types and updates the BTF object's
+ * nr_sorted_types field.
+ *
+ * Return: true if types are properly sorted, false otherwise
+ */
+static bool btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, n, k = 0, nr_sorted_types;
+
+	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
+		goto out;
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		goto out;
+
+	nr_sorted_types = 0;
+	n = btf_nr_types(btf) - 1;
+	for (i = btf_start_id(btf); i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			goto out;
+
+		t = btf_type_by_id(btf, i);
+		if (t->name_off)
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (t->name_off)
+		nr_sorted_types++;
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+
+out:
+	return btf->nr_sorted_types > 0;
+}
+
 /* Performs binary search within specified type ID range to find the leftmost
  * BTF type matching the given name. The search assumes types are sorted by
  * name in lexicographical order within the specified range.
@@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 			goto out;
 	}
 
-	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
+	if (btf_check_sorted((struct btf *)btf)) {
 		/* binary search */
 		bool skip_first;
 		s32 start_id, end_id;;
-- 
2.34.1


