Return-Path: <linux-kernel+bounces-878533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8DFC20EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459B01AA0DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF58363BAA;
	Thu, 30 Oct 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JBT6OLyq"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013A2E8B94
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837954; cv=none; b=NvVoT0PHykaAozVO/y75BVWjwBdJZyvvBQvc6+BV7NZEw/mr1IiTxcd+ZIrf2TVIhh2xXfSpYTxForAOxuksspNQGbL2yMUMNp7VJLl6D0jXvnlN0H9TL+VLsAiPlCaWC5z5H2GeXF9xmhWW0ao9bQqOeV1aTf3zIDMvHw5O5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837954; c=relaxed/simple;
	bh=H67r4w88zlU1921c5/QKXr/Bl4R9EUxsrk8OaJ2KI6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2IRJG80NnQBftIXS7z4rYZLpalif6ykiJYnSlJBjYli8TGpsRuk0VI5IenFnOiHTAO5ROGnXNMpFWXqyEw6c1riKFuOcCXCXp/1v01ZBBuoZP5bRIDgs0XbVh3VtavbNfXosUqCk7GC1GjTIV4s5oWxHnNE7707dcg518epv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JBT6OLyq; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7kvFPkRp/dS2L9NbQ/G23ovFdfU8KUNzcqgDlTrqmc=;
	b=JBT6OLyqL/vjHQhB6jtxJDzNTE1FP1PeS5UnxvFwIl7EaUSmVKzh9h09dHQL0NCPRSEQ8+
	8lEqZu9afpy6z4KXEi6UorfSsTNWtr4rENMf0yMHu5CIecHIECXppb0xPvg3tF3GU9OJhz
	gTB1PyBGAgxbBKtDbz96eXkOorJRoWM=
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
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 3/4] bpf: Free special fields when update local storage maps with BPF_F_LOCK
Date: Thu, 30 Oct 2025 23:24:50 +0800
Message-ID: <20251030152451.62778-4-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-1-leon.hwang@linux.dev>
References: <20251030152451.62778-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating local storage maps with BPF_F_LOCK on the fast path, the
special fields were not freed after being replaced. This could cause
memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
map gets freed.

Similarly, on the other path, the old sdata's special fields were never
freed when BPF_F_LOCK was specified, causing the same issue.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_local_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54da..9f447530f9564 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
+			bpf_obj_free_fields(smap->map.record, old_sdata->data);
 			return old_sdata;
 		}
 	}
@@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
 		copy_map_value_locked(&smap->map, old_sdata->data, value,
 				      false);
+		bpf_obj_free_fields(smap->map.record, old_sdata->data);
 		selem = SELEM(old_sdata);
 		goto unlock;
 	}
-- 
2.51.1


