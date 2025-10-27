Return-Path: <linux-kernel+bounces-871743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50546C0E305
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A751892BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10224309EF3;
	Mon, 27 Oct 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEe77FDh"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3B3064AA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573285; cv=none; b=F0b9ejGrPVg7XniaEpedKaeXnrIuKyMezQTsxSpiGjw1Cov27YU6tfvq28a9/PAiKLNj6tP93Zzvo9KoYI+Oq2azGxec/nwyy6qvdXs37zmal+BFebEFEko9Okm11IQ61j2ybcL6FnB37dZDsqk5s+Zut2/Qe8EnS4aCnRxTrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573285; c=relaxed/simple;
	bh=Cjh5/g2g/jA0t8pIW0Qr1oO+2rUFIay2nimYcNijtxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyHmaw4YlMjMde8Tnk2ukZtb3TN1+MMeTZU09At4UcUWkfcppNNa8P5zPAqJtIfkVbTypEssBzs+SatCKuIzek1IJr3E4NmsvK5b0lv6xdrwZBBZckOfaoguD8pQAg3O8m7tPfGQXukaWCWwbs+ur/Hxq1rinylKqPBVHcI5zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEe77FDh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so5840276a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573283; x=1762178083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYRuzhTmcuAouHjw8Rk9AXVRkzW/8jCaMjKPsnybwR4=;
        b=UEe77FDhBefI1TZyhPC+L7bujvwCmN9JFl5N/ynlvMW9Yta2uM1ParX99BgOL0/diF
         Pl9Zhjh/awViZmb01clgiupNu14ok8fjpri6B+shjdTsyvLi0T1aRrjvlgP5JfeqbVKZ
         w5wLTQTmVJDlVnOhJ49U3R9GkiXzmhz3t5vckp2ij/hezQNgftHwz6CwoWfFKxM/tzRa
         Hj2bmeCv7jLfviSk9y3Yi8fOlBDQ9mePfc3r0a5dCOjViRjMbDJ9Y09bRchkMLcarHkW
         5B9YD1aNRckoY9GlY41uRuTvBWkWZkrc8ZiO5L2OoeBcDe62qMhnpGj4ykw/3f0gg8zY
         CLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573283; x=1762178083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYRuzhTmcuAouHjw8Rk9AXVRkzW/8jCaMjKPsnybwR4=;
        b=P8OwvY89anS5B+AVBhiM3RPPpHS0e7k/ZI74dPP0oezx8rFeUCZ/U/lYDE2QGjWQEx
         9bZxN4KRgf4eX7OD/V10TFCHUi11rD4A663kduGuCXbItKyIP6pkW4wgqswqVS9Li0sH
         KwXdQMOwvWxI2a5ufewQU88N2drav85tvcUuxgvsa7koCqz4jUohaROK5nw2UHUD70E7
         LxoXcwrOardJBOOEFQBYdc0J1D4DLsAGdQj2+J0k8YMdperjibeimjj2J/dLVBenys0q
         4EdkPMQD98dxOSHFrt/AP7zWPsbvyVlYeosfuxlrk39U+olSdbOmruCsRA6l4UM0ECmT
         4XJA==
X-Gm-Message-State: AOJu0YxdhX+gm4kQW2yTJgYYbCVbPHMMTWmukefMytydXbtAqF/GinGF
	aLt8l/kkyVbX3WpiBWKQnV2n3lDlcZfy6Fmg2Zn8KJf8yRGY+9rQDM33/dTR9eXh
X-Gm-Gg: ASbGncu1RGBpCQbY9+VmHqWQUusNud+mEYdpiPZ6TCbKPDEhCJ1m/HO6j6+LGWz0Eyi
	4qB+mgIQdO8VG24n3VWpc9guSWG8iUDSDdLG74fuz7UMIU1fexCFw+r/FfCYMcHDHcdQT3NiHXy
	5p865KH48WpX+ocfhj2WT6J5jEU0CvFzKiUVaqj7xjehur12GYSLh7u6dGD3oP+YKbxj/8aBoD8
	9kWSUm3R8hkVsLS/c+fT7qJ9ngnoBvgDOxddejE/rpmsdkg3tnkIVZGy8f/G+yI7tLtUaxYuH/b
	k06RMUKitpopOZjKFn+2vlhsixtlcP9t/xIYHHx324OEz2ausor71kewTfceWnWX89TXGU38Y7A
	k6fz2PD1Xi7Ti8ni8pe2hWC4JQwp5nzyRx7nwj4UmxYqB85iIq4OMhPrFMqfN4aRBX9bcWrj/x/
	sJQvvrf+m+FWqi992E
X-Google-Smtp-Source: AGHT+IHwNYL6A4DZns7ec+5bESV0e3nM9DzapwGirzgHfVhHI6fBerJH30YECQ5BiM9K/Yykza1d3g==
X-Received: by 2002:a17:90b:5908:b0:33f:ee05:56e7 with SMTP id 98e67ed59e1d1-33fee0557f7mr10189589a91.16.1761573282951;
        Mon, 27 Oct 2025 06:54:42 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:41 -0700 (PDT)
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
Subject: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting verification and binary search
Date: Mon, 27 Oct 2025 21:54:23 +0800
Message-Id: <20251027135423.3098490-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027135423.3098490-1-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit implemented BTF sorting verification and binary
search algorithm in libbpf. This patch enables this functionality in
the kernel.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
v2->v3:
- Include btf_sort.c directly in btf.c to reduce function call overhead
---
 kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..df258815a6ca 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -33,6 +33,7 @@
 #include <net/sock.h>
 #include <net/xdp.h>
 #include "../tools/lib/bpf/relo_core.h"
+#include "../tools/lib/bpf/btf_sort.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
  * the data types of BPF program/map.  Hence, it basically focus
@@ -259,6 +260,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types; /* All named types in the sorted BTF instance */
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -527,6 +529,11 @@ static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 	       btf_type_is_var(t) || btf_type_is_typedef(t);
 }
 
+static u32 btf_start_id(const struct btf *btf)
+{
+	return btf->start_id + (btf->base_btf ? 0 : 1);
+}
+
 bool btf_is_vmlinux(const struct btf *btf)
 {
 	return btf->kernel_btf && !btf->base_btf;
@@ -546,22 +553,7 @@ u32 btf_nr_types(const struct btf *btf)
 
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
-	const struct btf_type *t;
-	const char *tname;
-	u32 i, total;
-
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
-
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
-	}
-
-	return -ENOENT;
+	return _btf_find_by_name_kind(btf, 1, name, kind);
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
@@ -6230,6 +6222,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf, 1);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6362,6 +6355,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		base_btf = vmlinux_btf;
 	}
 
+	btf_check_sorted(btf, btf_nr_types(base_btf));
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
@@ -9577,3 +9571,11 @@ bool btf_param_match_suffix(const struct btf *btf,
 	param_name += len - suffix_len;
 	return !strncmp(param_name, suffix, suffix_len);
 }
+
+/*
+ * btf_sort.c is included directly to avoid function call overhead
+ * when accessing BTF private data, as this file is shared between
+ * libbpf and kernel and may be called frequently (especially when
+ * funcgraph-args or func-args tracing options are enabled).
+ */
+#include "../../tools/lib/bpf/btf_sort.c"
-- 
2.34.1


