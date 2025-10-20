Return-Path: <linux-kernel+bounces-861353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7FBF280B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04815189F427
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0232ED58;
	Mon, 20 Oct 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCVWWE4u"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBA32F763
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978806; cv=none; b=lX6vJhvXUcuJNX9jEXQwi7pm3xKOrOxSiwxCL7kUUMiIOPhNQGCzpYdFZdfyuqqtRDMFiaGaeVdTNUmbyZxSLuHcsFn4Ou7Grjd3sQ5Jce4LBLLy93LzXaGMwVGE2T8Mmq7VbcVeJXH9NQz4eYt/qGAQVBJCDjZu8uL75CBHFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978806; c=relaxed/simple;
	bh=PneJOE+5GCYSbec2t+KA/fNgWOJ8risb7FcysszoFm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcQtlPukwt17edwV9sFkpSLiPhNIAv6EOOT1RjoUT3TP4xMo/+ud7ZsFSRPufWyYmxRJIFAqF29JbxqBU7I1LbLNixUtUTXtTJIff5D/IzjVT96Gfs0e5b4WgeXkYpCVnTFOaiv5aTwPBwnlxIlb2Dz9hfIjwuCoENeVKlJwvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tCVWWE4u; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwHz9CW1U502JagQ/hh1ku1vzSqD4BJw+Md0Gzmq1Os=;
	b=tCVWWE4uuG/c1IeqfQkRh3CkxXRrP+0Fn/yxRhtaicnop/ymuIa+p3xjR2XJCQ7RR9qG90
	r0ljq0Tun9MvlHhJh+Syhx8Zr1HSRX8fjXAdt8AfnjeJ5fRqSVvD8nwxDxwBMhX0Kzpssr
	CzChVFo0KPvKUZ4xAhaRH9Mb11W+JSY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v2 2/4] bpf: Fix possible memleak when updating hash maps with BPF_F_LOCK
Date: Tue, 21 Oct 2025 00:46:06 +0800
Message-ID: <20251020164608.20536-3-leon.hwang@linux.dev>
In-Reply-To: <20251020164608.20536-1-leon.hwang@linux.dev>
References: <20251020164608.20536-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating hash maps with BPF_F_LOCK, the special fields were not
freed after being replaced. This could cause memory referenced by
BPF_KPTR_{REF,PERCPU} fields to leak.

Fix this by calling 'check_and_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 26308adc9ccb3..65009ea3e9379 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1124,6 +1124,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map,
 					      htab_elem_value(l_old, key_size),
 					      value, false);
+			check_and_free_fields(htab, l_old);
 			return 0;
 		}
 		/* fall through, grab the bucket lock and lookup again.
@@ -1152,6 +1153,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		copy_map_value_locked(map,
 				      htab_elem_value(l_old, key_size),
 				      value, false);
+		check_and_free_fields(htab, l_old);
 		ret = 0;
 		goto err;
 	}
-- 
2.51.0


