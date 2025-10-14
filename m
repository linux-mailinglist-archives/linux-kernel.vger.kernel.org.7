Return-Path: <linux-kernel+bounces-852088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EEBD8232
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DEA40381C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BC230E849;
	Tue, 14 Oct 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FkHSsady"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0425E221703
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429949; cv=none; b=DhFpDB2ErU9eju2QN3JCDNMgJlJSqygD8eXcfxnCWQbbN3wRY9g552mR/NWdW6X3bBjzj7PYSwh0RUzyhaBHfi2sye4w/lt/pKWIIILVzOjxGl/pqvVPBEDsdZrsdL9z5iw+xuU6+mq/HmFJv7nStahXfylj4J2zb4PuO2LIRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429949; c=relaxed/simple;
	bh=5cIEkvD66wUiCSVdcWfq5ALXLU9c6pv/L9dXSGGjuDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnNNdvvw+qcZ68oMx6kyLOySXgEcKC1M+7V3X1TlkIC1iS3Y806up/jj3gG/Gg74Z3Nk6eUkCXT2NeEMVxmgId6AX/VQzrGS264MZcCwm6nuUpxTSAji1VOjSHOyHSdv5NcC884Fwc/pWUo8TgI4UtZuBnA4BszUaoBKccqUTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FkHSsady; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760429941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5OeyEYLseuiwt3LveByP/Aul19aE1+Npt1dW+qDVh4s=;
	b=FkHSsadyvJojzqrbq8TTDnPtANwM1U4aJvbeB8PGG7xSL1OG+S10cFC3JQ/I+4CPU1b4dj
	fMCiIHrDn1lhOe4rn/ZvqM3aMM+MT+LfhiyhRc16/SmQrP6ICeEzV70wfXAbWYC/TJ9Jk3
	pz+a6RoB7tLMgqx6ViN4sYT/hqSDRs0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm/vmscan: Add retry logic for cgroups with memory.low in kswapd
Date: Tue, 14 Oct 2025 16:18:49 +0800
Message-ID: <20251014081850.65379-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We can set memory.low for cgroups as a soft protection limit. When the
kernel cannot reclaim any pages from other cgroups, it retries reclaim
while ignoring the memory.low protection of the skipped cgroups.

Currently, this retry logic only works in direct reclaim path, but is
missing in the kswapd asynchronous reclaim. Typically, a cgroup may
contain some cold pages that could be reclaimed even when memory.low is
set.

This change adds retry logic to kswapd: if the first reclaim attempt fails
to reclaim any pages and some cgroups were skipped due to memory.low
protection, kswapd will perform a second reclaim pass ignoring memory.low
restrictions.

This ensures more consistent reclaim behavior between direct reclaim and
kswapd. By allowing kswapd to reclaim more proactively from protected
cgroups under global memory pressure, this optimization can help reduce
the occurrence of direct reclaim, which is more disruptive to application
performance.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 mm/vmscan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c80fcae7f2a1..231c66fcdfd8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7147,6 +7147,13 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		goto restart;
 	}
 
+	/* Restart if we skipped the memory low event */
+	if (sc.memcg_low_skipped && !sc.memcg_low_reclaim &&
+	    sc.priority < 1) {
+		sc.memcg_low_reclaim = 1;
+		goto restart;
+	}
+
 	if (!sc.nr_reclaimed)
 		atomic_inc(&pgdat->kswapd_failures);
 
-- 
2.43.0


