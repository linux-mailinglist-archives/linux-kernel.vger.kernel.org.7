Return-Path: <linux-kernel+bounces-856397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7CBE40D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA83E4FEF06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B452345749;
	Thu, 16 Oct 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UA6xoxc+"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27263451AA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626748; cv=none; b=lPeT/MkWt7og/EghJoKUDgRvtZ8PUjfwXBTMlgynULW7PQrtpup7ipR4cm6Xo7QuHZy+Q9HV9u2qX2W+mkPQL2oob5c+A50bSTZX9dJys+YtiUWD78MAc9oUdxZSVFr6V89vZnNUjh8FDpLsoxp0Ikh/RxJU8u04tsj0kXsy19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626748; c=relaxed/simple;
	bh=PneJOE+5GCYSbec2t+KA/fNgWOJ8risb7FcysszoFm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRXBAI0nYmECUUOEmq0pdfNMlgI4bd6Et6sxk0BZdMZmlZQ6jUDwaMUqFjOB02DFDYNjG0dOjpN4ZSy949FbQ1EcY9C1Q4Q8bbveuPYc4YKmzQZAcLWS1QWpPczbMZFAgJ7d9OR4+KcyKYzZzFc7GP1di1U8TriUrpKcDcJBFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UA6xoxc+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760626744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwHz9CW1U502JagQ/hh1ku1vzSqD4BJw+Md0Gzmq1Os=;
	b=UA6xoxc+91GeGnZ+Nja+24l36DO1adYaZ99rFECUslw/50K6U5wS3yVyywjawkVNNjhI9Q
	TQacrFxob6XKkHBjbobMY3xmJORv26rpYiUbFrAAnmxJuNazAar6oGbF4AfFrmMdgfsrLv
	Nian2FWrRxP1jV3wLql2jFCw5NaTs6I=
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
Subject: [PATCH bpf 2/3] bpf: Fix possible memleak when updating hash maps with BPF_F_LOCK
Date: Thu, 16 Oct 2025 22:58:00 +0800
Message-ID: <20251016145801.47552-3-leon.hwang@linux.dev>
In-Reply-To: <20251016145801.47552-1-leon.hwang@linux.dev>
References: <20251016145801.47552-1-leon.hwang@linux.dev>
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


