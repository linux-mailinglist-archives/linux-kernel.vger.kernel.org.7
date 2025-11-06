Return-Path: <linux-kernel+bounces-888574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82DC3B3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F2B3B212B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6822328B55;
	Thu,  6 Nov 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+Yy114T"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8132F76F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435223; cv=none; b=qgkvD06gWUqC3IYoj+Af7/vcYjqKmcCDpUQ1ectEpI6qKHlGu+deuVRmMNUrVFa/os7cvEawUaEg9nFTujdfhlzvuxNJr9yjgc80+tjpHUTqrTYDWNqFVcmKu0spHpwR/YsNErQ4Ydea0M8VMQI6Z1528IZlbI9IU91cqmzfKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435223; c=relaxed/simple;
	bh=/C7lP1Yq/5ogUMjkgaXSCCkh4BcomIYuobmhyRXlXAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GL1eud0afkqCAGxtn4qeAZ+7OQ9wadQWmeMvpitt6qm8wCXewGSjblQoaBpLADhdrHhgpwptKm/PwuSqGPeW4ae767BbLzGaiQ33vyfN3nusBnm5mtdP/V5UoCtr+zqwyVR1YPe6K1iEU+1n3S5nS46cVHJBOi8Z66sr7r7QCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+Yy114T; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso996397a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435220; x=1763040020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmRxjb3TYj5YoPOI2P5uBjXYSAdjGF3zYPhjRb8AdXU=;
        b=G+Yy114T7D/+7G3pukGkxBhrifshlWR8Jbj0HHBo7W6BjvxNmaS6N1eyRCa4gb/wJe
         uwNAvIKccqQcXdzi3FxzTYlSaH9dsirxL2Cl/XK/uNHPZMmX0NaP6day0PEpjG7gAzWo
         2hOgO1tKSm10O+eFJ8eOWtHgk6XJf035h5Pl0+BgbLJ0aJa5sn49AVvS8KSjhbs4HfJQ
         n4xSzZVX4T3mTCaWOSMHq2NCr48H5Irc3WXc0GmyhvJHgybXwWHv2opJNegxIfj2Xt9t
         wuBDTTscvwIJ4DQiR8h6na+Y4FNVUgfdZgepbt2sRt84oZN78tv1RevQikUPKk4G1O/D
         17QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435220; x=1763040020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmRxjb3TYj5YoPOI2P5uBjXYSAdjGF3zYPhjRb8AdXU=;
        b=i1wOUxHql44rGj5QXGBnc28hFa29C1XUowtv4jN4Zx+ot7DsJbMBHMvWlOZVQzAA5o
         abzMsaIc96jm0Y/42TZ88MLVT9TZ2I8dsO76d+30+N/Wq99aXSTwyV9yLlYscn/ea0jd
         DNLg22NUkg66udDXKffHLHFnjg0ymrEGVwDRs4ZBCE1BCX3iu4uXPoxPHE+1AU+KJ9Jg
         yn/Giq8L9M7M9DX8KhQQ4Re7i9RA9Jh2nYlh8cUwrpPqiUSYA+LuL7kPo5kCxYkMrGJy
         31QdP5VdTboT2UCgtBTZ5oI4HbIAnlHR2KkDoXYmtVTESh9fL+0HaU0qC59s0QXn3yVo
         CJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4FB38WrX7NXERka9naghdWYkJiyEPow4tplKFw2x/quOxCDMw1wfRukLIMYISNyz/9N6douaEE9Uxx3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfbl4KR3Q+Tnpm96azRx/vIdWb8JBtHtWDaoOlcEm+qTfZsY7
	wniDCIIDrAmVXSSCaJVLw/wAQDfq5E6o7BspgmXTm2so9d/qGOf7XJm9
X-Gm-Gg: ASbGnctqL/u83+DE5766A7VNRBUi57tgGpHVHMTFqFVtuCKCakNKqN6scdZ6lfqwxIs
	98pEhXwqvbQNNf0OK4CoRJ2jSOQysBJFPsI2vFThccSTe/5wemYwYhdQUlUOqV/k9RaV9UJcWbX
	AL1NeZUEA1ZOX1amQU94L6bV34lN4gufO5IlDk8n6bBHkz1eLaWlmqVPogtW6+RGrt/tqEWxdJD
	0kP1W6VklJREb/VmzbVXWYLEfrxipRKS9+Shzqvb8ytWlDoGr5nY2XGbIL3/hji/lI4v2I806pS
	1nEUwgWPxIxQ+rinNNVYr2NtrOX0pUGI19J357/WCwMmBO98JsyzIUzRSuia80hDvf7Hk1saaG7
	msBvc5MGS7B7zXpW0kmkHE+6U5BAitiVuZo547DoskT5TbqcQk5OEBdK2AHLTH1CDPNWu8lPHYf
	ppHPR818+LwajM93Sk
X-Google-Smtp-Source: AGHT+IGVdYS7PgIVP1pHCtuED1Z22PNW48lpWxrAamOrC3ebNLKDkO1COF/nQxHRmrAxURN7NQuBSQ==
X-Received: by 2002:a17:90b:5250:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-341a6c00d22mr10400975a91.7.1762435220286;
        Thu, 06 Nov 2025 05:20:20 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm1914869a91.21.2025.11.06.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:20:19 -0800 (PST)
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
Subject: [PATCH v5 1/7] libbpf: Extract BTF type remapping logic into helper function
Date: Thu,  6 Nov 2025 21:19:50 +0800
Message-Id: <20251106131956.1222864-2-dolinux.peng@gmail.com>
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

Refactor btf_dedup_remap_types() by extracting its core logic into a new
btf_remap_types() helper function. This eliminates code duplication
and improves modularity while maintaining the same functionality.

The new function encapsulates iteration over BTF types and BTF ext
sections, accepting a callback for flexible type ID remapping. This
makes the type remapping logic more maintainable and reusable.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c | 63 +++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..0c1dab8a199a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *btf_ext, enum btf_endianness endian)
 	return 0;
 }
 
+static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ext,
+			   type_id_visit_fn visit, void *ctx)
+{
+	int i, r;
+
+	for (i = 0; i < btf->nr_types; i++) {
+		struct btf_type *t = btf_type_by_id(btf, btf->start_id + i);
+		struct btf_field_iter it;
+		__u32 *type_id;
+
+		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+		if (r)
+			return r;
+
+		while ((type_id = btf_field_iter_next(&it))) {
+			r = visit(type_id, ctx);
+			if (r)
+				return r;
+		}
+	}
+
+	if (!btf_ext)
+		return 0;
+
+	r = btf_ext_visit_type_ids(btf_ext, visit, ctx);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 struct btf_dedup;
 
 static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts);
@@ -5320,37 +5351,7 @@ static int btf_dedup_remap_type_id(__u32 *type_id, void *ctx)
  */
 static int btf_dedup_remap_types(struct btf_dedup *d)
 {
-	int i, r;
-
-	for (i = 0; i < d->btf->nr_types; i++) {
-		struct btf_type *t = btf_type_by_id(d->btf, d->btf->start_id + i);
-		struct btf_field_iter it;
-		__u32 *type_id;
-
-		r = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
-		if (r)
-			return r;
-
-		while ((type_id = btf_field_iter_next(&it))) {
-			__u32 resolved_id, new_id;
-
-			resolved_id = resolve_type_id(d, *type_id);
-			new_id = d->hypot_map[resolved_id];
-			if (new_id > BTF_MAX_NR_TYPES)
-				return -EINVAL;
-
-			*type_id = new_id;
-		}
-	}
-
-	if (!d->btf_ext)
-		return 0;
-
-	r = btf_ext_visit_type_ids(d->btf_ext, btf_dedup_remap_type_id, d);
-	if (r)
-		return r;
-
-	return 0;
+	return btf_remap_types(d->btf, d->btf_ext, btf_dedup_remap_type_id, d);
 }
 
 /*
-- 
2.34.1


