Return-Path: <linux-kernel+bounces-890661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A3C409B1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D566560E1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74982E1C7B;
	Fri,  7 Nov 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZuKBncC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297102F0C45
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529684; cv=none; b=lkD/waPQdX32Ts2M7ViyfGojFN0hZZ5rORWlU0cDu3Rko+MvjMZcjEGBkoiJs6kO7G7RILtd2m80v3ugYNdrpxdZ9obaCG5MKXZFQw29vWaFF+x/hEirulGnzbo1B7CcyLaemn7d99GXwm48vCThdnf0XbnTp7wzJndrBc1EFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529684; c=relaxed/simple;
	bh=sS1mO9mVY+n0upVSqMY2+JLIYxv51EtgKKHOtGgsa0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwuAC1Vxf2vYwwKGUlGKJ8quLYDTLpW2uYcsYd8Hh5iX03f1DsLbR5Ig3GC8bswi4DaEYVB9NgPdi6GjXu6uibiuJf1SmhmzTeQc57bleeDC6ZcACs4Z+sfgzQ2nA0UvY3Z2yMyq8CL0EPwy17Oc40+pVaumsbGbduTMwTNrgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZuKBncC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429bcddad32so640628f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529680; x=1763134480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEZVeIp0039U3hcjQwmnwBxA9uxTpd6QC1RB9S7+CrU=;
        b=UZuKBncCypL+jKCMPscr3E2i4iQJNYuIWpjai0EQJmKJEfbzQbgNX0pa6KjVKl7zt8
         Obd8nckaYFlhQI81UFFDJlchJTz49BAz66gtTewc5FdRbQHXqovFQIlrBzstKbxW3usA
         0fX4aSoR7G0GP8xdNLs6xO8gAqyA4zdoxlaWwEZwE3gWWeCKdO0YVdZWp5Fj+xVYtGSk
         rqafRnMHmvHO6/oJRIGV6J9C1ejaL3U7Kjwebcf0zA7w+0fHxE+e5QT7p5HDwz4fP5w8
         KSD7PZWOy1gNjJLRUclXeQaYH5OeLD1CANuzh2uIZ/siUav8oYb10MHsJeQEFGt3u9aC
         ZEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529680; x=1763134480;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEZVeIp0039U3hcjQwmnwBxA9uxTpd6QC1RB9S7+CrU=;
        b=Q3Guk2xLmPIDv8bOu7yQCnZ7S8sOfXjahVwfQ0et33V9YDLEgQMJloYKBupN+Ogx0b
         kmpd20m/5GgZHQIPbULlTcu3LpWDSvDnJe1jHu+37VWt7Zn3+yr44psCJHUApiWPUOGJ
         y4YsRMCy3QslBOoadC8iVT73Eobppj11gTiikeCUSvUlhiMUwx5RDdgDFfUTewV/R0Yw
         zGv2vVJmTIaVWIh0ZyBRzwpPS/ETLwJGap+t8TpA4Fhx2rGZyObRdpG3SSgIBUMk/zfh
         fUY6ytpZa3dmXZQzjV6g+g5qebQNGDhlL1cYPsjMoYULbso53SEsxkLyRX1aH8Xlvj4p
         PfrA==
X-Forwarded-Encrypted: i=1; AJvYcCUCaFx/sOboy/KXLNIE0+TGfl6sw8GfGJMCNB3ly4V1KYUZb/w3IdBVLMzbtN/fO2uFU8deOyypqYMYrCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvt1zc5iXxzURmg0MrcWO/aGHAklIzTQ1+A/a79XYCQZ4F1H8
	84KHAYi6hl757mNuiwvM5PXKLDzWK8jcMHDqzNF59fOKDgcyrAqfM/Vy
X-Gm-Gg: ASbGncuGs40hF9lKo9fbfJW/A1P/eKyRmY1jvBkzWNlm8FHNFohi5NJVuZeCID+1VJn
	jXykDEI28+oEs0Ra3XS7+5hox4Y93zz7RerooQ6xXUkoJr5gi7/PqbGdnWF5sahaFCLLmuQ3OuY
	ZEggcNxdASA+djSq0xiflZ9hzQM5ko3fhyv1qG1DGzUA/aqcIF+sidF87egJOJcfEq6/0d4QHtp
	ZQOtp5nKqR+UEwyr4uKcbj5cKKjhXsi3RlT68fNWQxKiboQwU3UjRwfIz7QngIb1XozcRwJQ+LZ
	CcLRL5feQrQul0LF6/hT+parNqbWwSP65py78mvvKVPJThhT6rUl4S1OpDY44tIGbRzgdI2tYOW
	EqXZqVWz752fZcVRDt6Jk2PIlSSMglzuZnHE2iDWZn58Cc0TgsY/1S2NG11jqUiLeDNAlsbd8rq
	lZrFd8tWt0jCzIL7VT4qi5mjH/ZLxs4b2BDjiy1wzhad3NQfXsYw2v8qdlCD1k/UUtYX+7
X-Google-Smtp-Source: AGHT+IHhupneGIhhYLefCar228DT2G/CyJxPNnAcGQ7Z0TOciv/vnELQt/uV6goIQtVqRKCfPLfsfQ==
X-Received: by 2002:a05:6000:2303:b0:429:f050:adbb with SMTP id ffacd0b85a97d-42ae58898c7mr3366126f8f.26.1762529680187;
        Fri, 07 Nov 2025 07:34:40 -0800 (PST)
Received: from yd-B55TXL3.. (2a01cb09e0629b811add4a5ce9a2296d.ipv6.abo.wanadoo.fr. [2a01:cb09:e062:9b81:1add:4a5c:e9a2:296d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm6308130f8f.5.2025.11.07.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:34:39 -0800 (PST)
From: paulhoussel2@gmail.com
To: paulhoussel2@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Houssel <paul.houssel@orange.com>,
	Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>
Subject: [PATCH] libbpf: fix BTF dedup to support recursive typedef definitions
Date: Fri,  7 Nov 2025 16:34:08 +0100
Message-ID: <20251107153408.159342-1-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: paulhoussel2@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Houssel <paul.houssel@orange.com>

Handle recursive typedefs in BTF deduplication

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_ref_type() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
Signed-off-by: Paul Houssel <paul.houssel@orange.com>

---
The issue was originally observed when attempting to encode BTF for
Kubernetes binaries (kubectl, kubeadm):

$ git clone --depth 1 https://github.com/kubernetes/kubernetes
$ cd ./kubernetes
$ make kubeadm DBG=1
$ pahole --btf_encode_detached=kubeadm.btf _output/bin/kubeadm
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

The root cause lies in recursive type definitions that cannot exist
in C but are valid in Go.

program.go:

"package main

type Foo func() Foo

func main() {
	bar()
}

func bar() Foo {
	return nil
}"

Building and encoding this program with pahole triggers the same
deduplication failure:

$ go build -gcflags "all=-N -l" ./program.go
$ pahole --btf_encode_detached=program.btf program
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

As noted in the comment of btf_dedup_ref_type(), the deduplication
logic previously assumed recursion only occurs through structs or
unions:

"[...] there is no danger of encountering cycles because in C type
system the only way to form type cycle is through struct/union, so
any chain of reference types, even those taking part in a type
cycle, will inevitably reach struct/union at some point."

However, Go allows such recursion through typedef-like constructs
(function types, aliases), requiring a special case for
BTF_KIND_TYPEDEF.

This patch introduces that special handling, ensuring pahole can
handle Go-generated BTFs while maintaining compatibility with
existing C workflows.
---
 tools/lib/bpf/btf.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..239f52115c53 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3408,6 +3408,7 @@ static int btf_dedup_prep(struct btf_dedup *d);
 static int btf_dedup_strings(struct btf_dedup *d);
 static int btf_dedup_prim_types(struct btf_dedup *d);
 static int btf_dedup_struct_types(struct btf_dedup *d);
+static int btf_dedup_typedef_types(struct btf_dedup *d);
 static int btf_dedup_ref_types(struct btf_dedup *d);
 static int btf_dedup_resolve_fwds(struct btf_dedup *d);
 static int btf_dedup_compact_types(struct btf_dedup *d);
@@ -3590,6 +3591,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 		pr_debug("btf_dedup_struct_types failed: %s\n", errstr(err));
 		goto done;
 	}
+	err = btf_dedup_typedef_types(d);
+	if (err < 0) {
+		pr_debug("btf_dedup_typedef_types failed: %s\n", errstr(err));
+		goto done;
+	}
 	err = btf_dedup_resolve_fwds(d);
 	if (err < 0) {
 		pr_debug("btf_dedup_resolve_fwds failed: %s\n", errstr(err));
@@ -3901,6 +3907,20 @@ static int btf_dedup_strings(struct btf_dedup *d)
 	return err;
 }
 
+/*
+ * Calculate type signature hash of TYPEDEF, ignoring referenced type IDs,
+ * as referenced type IDs equivalence is established separately during type
+ * graph equivalence check algorithm.
+ */
+static long btf_hash_typedef(struct btf_type *t)
+{
+	long h;
+
+	h = hash_combine(0, t->name_off);
+	h = hash_combine(h, t->info);
+	return h;
+}
+
 static long btf_hash_common(struct btf_type *t)
 {
 	long h;
@@ -3918,6 +3938,13 @@ static bool btf_equal_common(struct btf_type *t1, struct btf_type *t2)
 	       t1->size == t2->size;
 }
 
+/* Check structural compatibility of two TYPEDEF. */
+static bool btf_equal_typedef(struct btf_type *t1, struct btf_type *t2)
+{
+	return t1->name_off == t2->name_off &&
+	       t1->info == t2->info;
+}
+
 /* Calculate type signature hash of INT or TAG. */
 static long btf_hash_int_decl_tag(struct btf_type *t)
 {
@@ -4936,10 +4963,77 @@ static int btf_dedup_struct_types(struct btf_dedup *d)
 	return 0;
 }
 
+/*
+ * Deduplicate typedef types.
+ *
+ * Similar as for struct/union types, for each typedef type its type
+ * signature hash is calculated, taking into account type's name
+ * and its size, but ignoring type ID's referenced from fields,
+ * because they might not be deduped completely until after
+ * reference types deduplication phase.
+ */
+static int btf_dedup_typedef_type(struct btf_dedup *d, __u32 type_id)
+{
+	struct btf_type *cand_type, *t;
+	struct hashmap_entry *hash_entry;
+	/* if we don't find equivalent type, then we are canonical */
+	__u32 new_id = type_id;
+	__u16 kind;
+	long h;
+
+	if (d->map[type_id] <= BTF_MAX_NR_TYPES)
+		return 0;
+
+	t = btf_type_by_id(d->btf, type_id);
+	kind = btf_kind(t);
+
+	if (kind != BTF_KIND_TYPEDEF)
+		return 0;
+	h = btf_hash_typedef(t);
+	for_each_dedup_cand(d, hash_entry, h) {
+		__u32 cand_id = hash_entry->value;
+		int eq;
+
+		cand_type = btf_type_by_id(d->btf, cand_id);
+		if (!btf_equal_typedef(t, cand_type))
+			continue;
+
+		btf_dedup_clear_hypot_map(d);
+		eq = btf_dedup_is_equiv(d, type_id, cand_id);
+		if (eq < 0)
+			return eq;
+		if (!eq)
+			continue;
+		btf_dedup_merge_hypot_map(d);
+		if (d->hypot_adjust_canon) /* not really equivalent */
+			continue;
+		new_id = cand_id;
+		break;
+	}
+
+	d->map[type_id] = new_id;
+	if (type_id == new_id && btf_dedup_table_add(d, h, type_id))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int btf_dedup_typedef_types(struct btf_dedup *d)
+{
+	int i, err;
+
+	for (i = 0; i < d->btf->nr_types; i++) {
+		err = btf_dedup_typedef_type(d, d->btf->start_id + i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * Deduplicate reference type.
  *
- * Once all primitive and struct/union types got deduplicated, we can easily
+ * Once all primitive, struct/union and typedef types got deduplicated, we can easily
  * deduplicate all other (reference) BTF types. This is done in two steps:
  *
  * 1. Resolve all referenced type IDs into their canonical type IDs. This
@@ -4982,7 +5076,6 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_PTR:
-	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_TYPE_TAG:
 		ref_type_id = btf_dedup_ref_type(d, t->type);
-- 
2.43.0


