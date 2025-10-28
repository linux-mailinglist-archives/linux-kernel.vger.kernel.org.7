Return-Path: <linux-kernel+bounces-873922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D27C15131
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B331A21C85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301433FE08;
	Tue, 28 Oct 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQRNNpfr"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705433DEE8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660258; cv=none; b=MedBnGf/8FFKxhiEMKMUCVFrEqfqXTCQG86uKuUiQqRPbHB8PzBcukZV9gdaTm4SMnKwuXCqZhnpQV/MbeVrCrIna02q/ikLyzEmg04OJDeINM/O3WlyzfL26iK6fMVj4Y/N7RPAgSVO1bOqahf604YMygw3x/jUqkjoKOCxcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660258; c=relaxed/simple;
	bh=P0q6MjSkVjsNV2grrn3T44FIUMkX9PSRxmfEJUTIUEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfPTUgEmtEh/BiiRQyTZGHW9uMdqvZKhuNEHalVJYNZv+Hou2o+DxQjsS3XwF07sPt8fTgoVb4UfIhFW48IfXpznHPWLmZ9bKBBFhNsx+HQqWBcvMpv+JR8RuVQiEgPkqzbdXoZjspIcrX+aYrmvgjyW0e4un6VXTmBww7NVA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQRNNpfr; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awA3itBKj19H7/d+bEsq6yy17boeItLnhliB54mswXw=;
	b=mQRNNpfrKBpzz1ab1nTDgyCoguSHCTkk95shXK3iNipGI04oEMEXi5IIHEPqlqy+SEmRpM
	qyRZZQYqvRsB5YE+THqhsZdE833GfIrCf6qfwNtQCy481oRQtt+89LTqZmnI4GWpd8q08w
	S9hcQ/U+3SEnqwhb2eichfz//vZJxFk=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 18/26] mm: zswap: prevent lruvec release in zswap_folio_swapin()
Date: Tue, 28 Oct 2025 21:58:31 +0800
Message-ID: <c85c86746a3103bac3657934a2655c1eb81ff290.1761658311.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in zswap_folio_swapin().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 5d0f8b13a958d..a341814468b95 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -664,8 +664,10 @@ void zswap_folio_swapin(struct folio *folio)
 	struct lruvec *lruvec;
 
 	if (folio) {
+		rcu_read_lock();
 		lruvec = folio_lruvec(folio);
 		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_disk_swapins);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.20.1


