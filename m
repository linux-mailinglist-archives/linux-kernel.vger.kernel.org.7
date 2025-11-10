Return-Path: <linux-kernel+bounces-894307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C63C49B94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE934A660
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB802F744B;
	Mon, 10 Nov 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Txz1v+Iv"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C141B0413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816824; cv=none; b=oaiX3DxZ7KeyC5ePIXfqC0YOFeuWMPSYBLRIdxho9a2ztUB/EVNyfM7F+T+iK+/7wFXNbKFYo/gu0oC80qY2cHbpmXkOI5OaLBq51GA0wsDPCxTW0sauS5HnD3DP11BtJuHR35nJLq4Hpbmct4qc2TJDPzHBYcghhSOQLRLTkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816824; c=relaxed/simple;
	bh=pwAJ1XSRI5zPuxCcsq/6z3JI0WvSW7Nvf9d0r8v7JN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW5cKHoXLBrEwj0TG1DeudyJ5BHNP0MwsWDVYnWCTCKUMtu+hgue0RxvkU8f0eF1xosdvwSjtbxmcFMQTPwuWwSwtHS3SkP6Lxpg3WqRjpv3ky8ZDJkmtFB4gg2+5vLLWFHkSBx7dKRofEf/6BXOA3BREleP0GK8u39l03QOQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Txz1v+Iv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762816818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hjnGKgt3w9/pB/cswaD8pehI2RAflAw/BUPrIWTcUcI=;
	b=Txz1v+IvOSQC0AVE5RL+lbiRoJXfy9JWLKyNM2SbMcL2mNzkxa6GfZja0hFiYL5iZEmXAm
	/jcEY762YjQ2dl6QWZ5hTUTfs186asirIiJWp9poY5RmDvEQ8TpiUG4LfPPzW/X4Ma1UNM
	65eK+ujABEKNeQ3UwZ5PgPW5c8yW/zE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Date: Mon, 10 Nov 2025 15:20:04 -0800
Message-ID: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg stats are safe against irq (and nmi) context and thus does not
require disabling irqs. However for some stats which are also maintained
at node level, it is using irq unsafe interface and thus requiring the
users to still disables irqs or use interfaces which explicitly disables
irqs. Let's move memcg code to use irq safe node level stats function
which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
(all major ones), so there will not be any performance penalty for its
usage.

Shakeel Butt (4):
  memcg: use mod_node_page_state to update stats
  memcg: remove __mod_lruvec_kmem_state
  memcg: remove __mod_lruvec_state
  memcg: remove __lruvec_stat_mod_folio

 include/linux/memcontrol.h | 28 ++++------------------
 include/linux/mm_inline.h  |  2 +-
 include/linux/vmstat.h     | 48 ++------------------------------------
 mm/filemap.c               | 20 ++++++++--------
 mm/huge_memory.c           |  4 ++--
 mm/khugepaged.c            |  8 +++----
 mm/memcontrol.c            | 20 ++++++++--------
 mm/migrate.c               | 20 ++++++++--------
 mm/page-writeback.c        |  2 +-
 mm/rmap.c                  |  4 ++--
 mm/shmem.c                 |  6 ++---
 mm/vmscan.c                |  4 ++--
 mm/workingset.c            |  2 +-
 13 files changed, 53 insertions(+), 115 deletions(-)

-- 
2.47.3


