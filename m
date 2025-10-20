Return-Path: <linux-kernel+bounces-861354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E48BF281D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE8394EC21C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E032F74C;
	Mon, 20 Oct 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nDiye4FY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A7330322
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978811; cv=none; b=DhkvdGSvQbt8kvZuMq4qtJ09rKN6+N8GGENWcsgV8jdeZty57VN9agmfkcdyz6lc9JIPMGzX4BTXgdcn0vAAG65NX90CR/eOcO+3hi8VgXFewnW1KJNE+5BGMCKV0yhzju340MkI7ktflrKEKUauB59f6KBjCNWMprugdmrsrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978811; c=relaxed/simple;
	bh=aePpf2hEql1qfdG3M5ylZaVHF0AGBqfwF+1CHFlgt6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdEJhR6QCGmyIOrg2mWHsbQ/ExVDTJ3WIDxc9g8iIicM9k6zVjX8GyzzlYG33QPHAm5eyouoZ8Wn3WLI1jIACW1nuPi7R8yGje2PW8wZCYu02yaZCFtPy8Bhz87JEhCjbpA3vmaOLlxtGaL3nRppvDQzVKvi8w3SrpIBmZwQfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nDiye4FY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEyL06pmQ86osgNWjo4Zb1J+CW0SUTbpdgIL0oBMIEE=;
	b=nDiye4FYbJB03BthBlTXPaV/oZeta74ZUU+b5zq1vYXDOQJFICAAM61oR6by55aLu9lvcK
	V96Gk4T7K8E9CjqhWf8EGbGwplf9kzY2ONn+0QHk6EJGkIjoM1iBq/7BTD1PtcpnXiYWj8
	JeRQQOxPLUWRQCe+NTf4DmIzKSgaGCI=
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
Subject: [PATCH bpf v2 3/4] bpf: Fix possible memleak when updating local storage maps with BPF_F_LOCK
Date: Tue, 21 Oct 2025 00:46:07 +0800
Message-ID: <20251020164608.20536-4-leon.hwang@linux.dev>
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

When updating local storage maps with BPF_F_LOCK, the special fields
were not freed after being replaced. This could cause memory referenced
by BPF_KPTR_{REF,PERCPU} fields to leak.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_local_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54da..2b7bd47e99b33 100644
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
-- 
2.51.0


