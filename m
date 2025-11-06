Return-Path: <linux-kernel+bounces-888577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE14C3B300
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45E4188B598
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0027330338;
	Thu,  6 Nov 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTjErpzD"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FF3321CE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435234; cv=none; b=eETaub6zzEe/pGoRU1X0wYrXWJfJF7FwCUNKfv+cIIRt9vgr0WBYZTwynSua8g8J8yRrXqeyRrEuHS7vDiWT6A0QzDZU8nu4iT81x0sBg/hFyuOsJplSPoCXH/leUGLtWGd4pX+Xk1orRkEQXss/PHUMM2aMU44Zxm+r/3Mm+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435234; c=relaxed/simple;
	bh=9IIrVWj4EOAFacobzgV9OdSZQ7IU230SlMHy8PsLO8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCtkIZtu6U2ZajtHFHETPAmFMKziFbt7+gLAhmpw/uaCCwa+QmrjovzeJB1NZ7Bu3YLdGcx1SCCBcx3NwBFRu0pCaJbZ4J3znKCor0tTOgYIQor+b3kGs5u62fONnuYIuvDPIPyX3PL6QH4RdvVZky4fVB/s/QpQvAhme34kWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTjErpzD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ba599137cf7so859132a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435231; x=1763040031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpLkwEVaZQ31ymQfuOb0WcKoTYd7LV9JMIguVBgQh3c=;
        b=RTjErpzDzneMzIhtVkTSCyy5q1v6TCxqD1w1JHSQZfDN55zUTjrsXOBGQ/XeRLSDNd
         yL3AU8Dc+xDs1Q83JJVwvuVwg4K0KvgyDt9rqAo2OrTffYeDx9L1P4ttYR8YwEiiO2K7
         mH0icQSrgQqPp8KL+l35eZpGgTdMeccfMq3Ld/LTiWPljo4p43fz4lPLdnuKgHa20E3U
         5sNSJHFOhwN6tyVKLZXo4bw0jS7Ho4AszmJQk27mzrvnynsATRzcS5Rb8h80ek2Xjh5w
         LF0P1RRIvjJIh9/9AniXHIPxT4DxI01ImSXkBN2SGD2Bi9omH/GRwISgXLBGyaqVrG02
         CmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435231; x=1763040031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpLkwEVaZQ31ymQfuOb0WcKoTYd7LV9JMIguVBgQh3c=;
        b=RXBW/h8HIT+feo3e09G2Y+rQHi5KqdrmamW7ZXmTTf570h5liVCfZx7Gnqb5FqHezs
         lizTVGOoyJD+ETgcw9U5nuwRlXrGq12Ms1XD06PeceKR29KP5jqJXrR7HRMfpRmsvKvC
         bS7mgAg/kxbhTCK8T+hIovlPpzvsnVbrzzp/LHS36RFF+qAmllP2qY/ZKLYhDR+a9ZrE
         FVsvOHJ4UvmJ2PwCNzDQ6Xs6A+k1/L51Mz+n69dyM8JHnPM6M461CCmP2coCUgck7xZH
         e8nGr1ypvQkxOs5ihVYih511QhY9/O6YK0KR8afGgQ8LNy/v0Pv3hbgTIYhUrgIgx6rx
         oqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0llX0nIeh/sVsfXTeGEKxzmryuPCdD6Qq84wpaJlaB1SZMnGhIOKBOqf0DPvL3Au6NFddsud/72Ouo1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+1ZPu7qZBJNEbPTBG5bTi4hDC9uqFhdfRJJdlyh4vdFR4M4Q
	FPXlsLpDjlY8nxznFIShA1HTUe/qZaQH+2FT+mgJHwgqxKp2I7ywmp6y
X-Gm-Gg: ASbGncvryZjcLC2EL6W1FnVl6jZeEuoHJtqU3bnAPU0khIt1IfwZFF6bT0+xv+5AU3/
	qI4EuJ4GlKrRvbiP4YQRWFTNz2wDV5D5/fK3+34f6Fx8kBtPcVhWQJAv174ymXC330UWWl39E79
	Ws4fHwaM6GopVtYKcxImt9t3uSpXeiBihor7NF+58k1DywqNi4y+z1+RYweUVxMd85k6iHFA/kP
	0sQV9HmyK5z8onL21nI/lwyJHe3Ms6eGmMarA6oKe9Y7HOULRD1+GO/nMFoHgk318fMOlR8DkAp
	ju/zgYs2OEp5LwlSUNfAiBbHUfhC2c6abHPISFRbOWnKfqhXUGSoGJ8GuhKIrYDEvjXjcCCj4Xt
	pchjaJU+K5bmyE3KJlm5/et81tRxRc4C3w2MYC1ur/7JDlU0KWJOZN1L+BVXB1wLI3crDZqTe5I
	4qni3NG+V8GXsS+kPu
X-Google-Smtp-Source: AGHT+IH8xXHumIVLMZrCxwSH55ZPpWyKAGLDtEe4kXor9petOsUVlk2TDe4v5DrC1SE3U/hEmx1AMw==
X-Received: by 2002:a17:90b:3812:b0:341:8ae5:fde5 with SMTP id 98e67ed59e1d1-341a6dc4bdemr8230717a91.18.1762435231258;
        Thu, 06 Nov 2025 05:20:31 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:30 -0800 (PST)
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
Subject: [PATCH v5 4/7] libbpf: Implement lazy sorting validation for binary search optimization
Date: Thu,  6 Nov 2025 21:19:53 +0800
Message-Id: <20251106131956.1222864-5-dolinux.peng@gmail.com>
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

This patch adds lazy validation of BTF type ordering to determine if types
are sorted by name. The check is performed on first access and cached,
enabling efficient binary search for sorted BTF while maintaining linear
search fallback for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index be092892c4ae..56e555c43712 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -911,6 +911,73 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
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
+	int i, k = 0, n, nr_sorted_types;
+
+	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
+		goto out;
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		goto out;
+
+	nr_sorted_types = 0;
+	n = btf__type_cnt(btf) - 1;
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			goto out;
+		t = btf_type_by_id(btf, i);
+		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
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
@@ -970,7 +1037,7 @@ static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
 		start_id = btf->start_id;
 	}
 
-	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
+	if (btf_check_sorted((struct btf *)btf)) {
 		/* binary search */
 		__s32 end_id;
 		bool skip_first;
-- 
2.34.1


