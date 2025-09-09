Return-Path: <linux-kernel+bounces-806993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC4B49EA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3554517AD6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3531E7C12;
	Tue,  9 Sep 2025 01:22:10 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480572634
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380930; cv=none; b=phqm0MUNPVE4pkl9UwHFyKIU7YWbK2/FWiiEmA0LbHEPu28u9x0dN1P9qprQEuh8JqI0oJzZ7g9Ct47ou4yUamn92pUHMHB34VV/YHsP9a4UCnDqK0wI/AJnQQOVp9nRoPlSBMWnASgx9P5AwnZVrfqIri+1XFDWHPKBJPTAiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380930; c=relaxed/simple;
	bh=u1KV1C/hcS+AVE8HX+enyQC5WbRPFCDy5DjQFCPXEK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kf/hTXWDSQaV0zmuPD2tS2NbEsxMf/huZnd9TvrPya6C/V0/9uIYk3yxNIwRYkRgIgTQeK2NLWpoiwjlsPruX0Tuxt/IaNihTmBFY00ZsdCqJdVun7D83qt47tffHKfDx+Xi2U9dqWWCHpolYkmUXWasky0PuRUGtPl546HGCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509090921522911;
        Tue, 09 Sep 2025 09:21:52 +0800
Received: from PC00024056.home.langchao.com (10.94.13.207) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 9 Sep 2025 09:21:52 +0800
From: cuishiwei <cuishw@inspur.com>
To: <akpm@linux-foundation.org>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <hannes@cmpxchg.org>
CC: <weixugc@google.com>, <david@redhat.com>, <zhengqi.arch@bytedance.com>,
	<shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, cuishiwei <cuishw@inspur.com>
Subject: [PATCH] disable demotion during memory reclamation
Date: Tue, 9 Sep 2025 09:21:41 +0800
Message-ID: <20250909012141.1467-1-cuishw@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202590909215269e944241ffdc39a63df3b45123fc775
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

When a memory cgroup exceeds its memory limit, the system reclaims
its cold memory.However, if /sys/kernel/mm/numa/demotion_enabled is
set to 1, memory on fast memory nodes will also be demoted to slow 
memory nodes.

This demotion contradicts the goal of reclaiming cold memory within
the memcg.At this point, demoting cold memory from fast to slow nodes
is pointless;it doesn't reduce the memcg's memory usage. Therefore, 
we should set no_demotion when reclaiming memory in a memcg.

Signed-off-by: cuishiwei <cuishw@inspur.com>
---
 mm/vmscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ca9e1cd3cd68..1edf618a3604 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6706,6 +6706,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.no_demotion = 1,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
-- 
2.43.0


