Return-Path: <linux-kernel+bounces-884836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B941C3147E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A14A46412B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C132ABD0;
	Tue,  4 Nov 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsyeWg5v"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A47329E5F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263660; cv=none; b=ZhvZeywIIe3Te1LrS7a1i154KHFAGXpgXI5mXQkfCZfhzKxHpI+PyD7AWgksNes0olLuPhNlF7adJxGIHrtCLbOMDKXfwnGV/LIpourAUvJxlXFvJrHIBckcC6EiQCVy7fdiBmb9B/L4jhL5WJN7Cp79TLOiWBfkRwAX5sYuOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263660; c=relaxed/simple;
	bh=O6TUJSSCk6Hrp9bJcJkRtQGi3MrZ6klrSIFDZ+Yqcj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKHYaeY3Gnd565tof1gKukN+TLoNN6bnnrEUzc5QKwj3OQ/0D444HFaQNgPGSpOWFTXouLuHHphFSAsCYk7lDUlq/vt5BYU86t/tXl/bM4ex+yysD2Mrh4zC5EoVbHXGDK7ObSNL1SwymH7/abYH+JTjwfHFeoG/J1uhd0ht1fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsyeWg5v; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340c680fe8cso2742104a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263658; x=1762868458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdH6dhdE/ct/5KpUEPIcc/WirZeO6VXg0US4f0SIffI=;
        b=dsyeWg5vESLqY1C4wf6DCQ7X2SnLnEJarGtvpuW90ZzO9DvG6Gb+dGTHcST3+aukXE
         mbrZHcutLkA2PMAfTDtWQqsRakc2aMA0XzofDw8I2plGkOQcVeRBrG4xrTG7nIuP6S+T
         vOfZMs2+e6vwaNowi/sJm6o5Tr9zqZm7npGtxFnMqrEFuDrMGuFYEuAgaiWlx/XvzTDO
         vw+SgTk9d+wxyP7VVWaSG8G7+TzsczYjBShbLvHyPt8QV+7M3c/Y9oPnL6oHyqmIeioM
         9GLyqQP4rPlwGgvgX1bluEQCL5632H8JPuXHeQY7He3K4c1GNk1yoenByUVSObwAxSiB
         1S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263658; x=1762868458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdH6dhdE/ct/5KpUEPIcc/WirZeO6VXg0US4f0SIffI=;
        b=cBGOaKbDyqIdNad47rppCkQXRRkRbZALNpIEjO+gjP2zpn8aTuC+Zcr2xgbaLaAbhi
         w27ahgC1XpbVWenMnIzY6w/mATN6EzRMTbUK8+HEPoiQWCXjFItsmrP8h4+4DYjGXtdT
         Sybi21/IYm0eHj2GAG4OUrTd4HYBky5IiCGx9rfV4u6fGwfNJ7ICL4JOTgqS82qj9+6r
         7p2uEN4INFYyayUtdqtyyvRq7PFKTsl51cjptBwSpTn/Z6FUAHjWmf+yLb7KfOM7og8h
         EAkQlsac87w+u9y7Nkv2ZBsHWFF/l41neI6F925LAJWIqMcETMWmimtDCaEw+/Bpcm8G
         Qf+g==
X-Gm-Message-State: AOJu0YyUJWCQOx4PSRROW5KY93XAmUX0fqRyfr1Mu1RXkCMd13OKmikf
	a5ETjPfD2tIBMuqqe2QmbVF5yGYYVba+ERCxKX4MuO7s+T21JvU5ca+E
X-Gm-Gg: ASbGncuK5PORowMlPJoBMC0XZZipMaOYEVgJmz0l70oo7w3WrBnq6VLUVEqF3YPK24m
	9CaUkf4Mre74dwyfdmqbYwki860gE29WTKJzh+biCbT/SvSMAPaaiIunLZ1UWyx5aqqcjm0HOpq
	HNtrylkfpP5yLjQLQf0uLxpRIQhBfDRrFdxAkkHBNQ+KvMRH6VoNzo8kY/8eLUuQ8Nf3VpYoaie
	Lr4mX0MXWcPQsU8U3Zjl+CgY3n+TgZv7vaLAJ64kQoqFL50ScRAwspwHNzRBahOHPprkaqx8pac
	iHnI/vP6BMG9dfZW7AAS2OuUaFIHD++lqN9zHg2iF8ceVdiYc4lTfHBYHAkFO/M6rJT+T2i+n/T
	Mje3l49ivT2M96SQFmdfxqBx5mQfiA5AouYpHCX5g6UA9oRJ7yuUR67x1mRS1kxtyjxhRrIIxpq
	kaTAe/u//QwqKbNN1+
X-Google-Smtp-Source: AGHT+IG4CexyTG0Va7f3enA8yUQx0oRFu4DeDd1sF7PSgO2tkGhxl3YEWxrzB4hWgbdaNFwN/l7fMw==
X-Received: by 2002:a17:90b:5104:b0:341:88c9:6eb2 with SMTP id 98e67ed59e1d1-34188c96eb7mr1911737a91.1.1762263658014;
        Tue, 04 Nov 2025 05:40:58 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:40:56 -0800 (PST)
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
Subject: [RFC PATCH v4 5/7] btf: Optimize type lookup with binary search
Date: Tue,  4 Nov 2025 21:40:31 +0800
Message-Id: <20251104134033.344807-6-dolinux.peng@gmail.com>
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

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/btf.c | 111 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..da35d8636b9b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types; /* exclude VOID for base BTF */
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	return false;
 }
 
+static int btf_start_id(const struct btf *btf)
+{
+	return btf->start_id + (btf->base_btf ? 0 : 1);
+}
+
 bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
@@ -544,24 +550,109 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
-s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+/* Find BTF types with matching names within the [left, right] index range.
+ * On success, updates *left and *right to the boundaries of the matching range
+ * and returns the leftmost matching index.
+ */
+static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const char *name,
+						s32 *left, s32 *right)
 {
 	const struct btf_type *t;
 	const char *tname;
-	u32 i, total;
+	s32 l, r, m, lmost, rmost;
+	int ret;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	/* found the leftmost btf_type that matches */
+	l = *left;
+	r = *right;
+	lmost = -1;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf_name_by_offset(btf, t->name_off);
+		ret = strcmp(tname, name);
+		if (ret < 0) {
+			l = m + 1;
+		} else {
+			if (ret == 0)
+				lmost = m;
+			r = m - 1;
+		}
+	}
 
+	if (lmost == -1)
+		return -ENOENT;
+
+	/* found the rightmost btf_type that matches */
+	l = lmost;
+	r = *right;
+	rmost = -1;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
 		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+		ret = strcmp(tname, name);
+		if (ret <= 0) {
+			if (ret == 0)
+				rmost = m;
+			l = m + 1;
+		} else {
+			r = m - 1;
+		}
 	}
 
-	return -ENOENT;
+	*left = lmost;
+	*right = rmost;
+	return lmost;
+}
+
+s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+{
+	const struct btf *base_btf = btf_base_btf(btf);;
+	const struct btf_type *t;
+	const char *tname;
+	int err = -ENOENT;
+
+	if (base_btf)
+		err = btf_find_by_name_kind(base_btf, name, kind);
+
+	if (err == -ENOENT) {
+		if (btf->nr_sorted_types) {
+			/* binary search */
+			s32 l, r;
+			int ret;
+
+			l = btf_start_id(btf);
+			r = l + btf->nr_sorted_types - 1;
+			ret = btf_find_by_name_kind_bsearch(btf, name, &l, &r);
+			if (ret < 0)
+				goto out;
+			/* found the leftmost btf_type that matches */
+			while (l <= r) {
+				t = btf_type_by_id(btf, l);
+				if (BTF_INFO_KIND(t->info) == kind)
+					return l;
+				l++;
+			}
+		} else {
+			/* linear search */
+			u32 i, total;
+
+			total = btf_nr_types(btf);
+			for (i = btf_start_id(btf); i < total; i++) {
+				t = btf_type_by_id(btf, i);
+				if (BTF_INFO_KIND(t->info) != kind)
+					continue;
+
+				tname = btf_name_by_offset(btf, t->name_off);
+				if (!strcmp(tname, name))
+					return i;
+			}
+		}
+	}
+
+out:
+	return err;
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
-- 
2.34.1


