Return-Path: <linux-kernel+bounces-665359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF2AC682A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DAC7A29FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3727A47E;
	Wed, 28 May 2025 11:10:58 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F76217F36
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430658; cv=none; b=GfezqQDlnEQ+PLC1wiGNZ1AbbAJzzEqU+Ny/VfFXoC4ofwufoyAk+6J6mC8AxLAXBqaJBOmXDObS7iWaSITAdY3qVqXNr/kCYlcfmaTCDu+dno/HCcfxpf3RY3xhu3JfbWa4FKk31sggP8g/AHJSbhZTcDwAtDn7MFhHWZPueUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430658; c=relaxed/simple;
	bh=5VNQNJstimj/ysbI3W1CYC1Bg0MkbRJ3HgtLUNEwnOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JaIkAgSV/SB25qBo5tGBVEFQYLJxEdnHqoRhp+xodcXhrFD8/AhiZKeU4R/Lt5fRLFywCDPgw4P4CjP/iFGYuM5XPFvo52Mf17yxj8VyiESozFpK9qgIHcTgL+ZwJf/HvncxLA3vVXb5piqPZusjb6/TB5tpfnW1sVgHkCqn67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202505281910420840;
        Wed, 28 May 2025 19:10:42 +0800
Received: from vbox.home.langchao.com (10.94.6.79) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 28 May 2025 19:10:41 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <sj@kernel.org>
CC: <david@redhat.com>, <mhocko@kernel.org>, <zhengqi.arch@bytedance.com>,
	<shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>, wangchuanguo
	<wangchuanguo@inspur.com>
Subject: [PATCH 0/2] add a knob to control whether to use other nodes at the same tier of the target node in DAMON
Date: Wed, 28 May 2025 19:10:36 +0800
Message-ID: <20250528111038.18378-1-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
tUid: 20255281910424c625d6493f53ede3c45385c75923c87
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In DAMON's migrate_hot and migrate_cold features, the code was
intended to migrate pages ​​only to the node specified by target_nid​​.
However, during testing, it was observed that memory allocation
and migration could occur on ​​any nodes​​, which is a BUG.
The first patch in this PR fix this issue.

A use_nodes_of_tier file has been added under the directory /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/
to control whether to ​​use other nodes in the same tier as
the target node​​ for migration.

wangchuanguo (2):
  mm: migrate: restore the nmask after successfully allocating on the 
    target node
  mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes

 include/linux/damon.h        |  9 ++++++++-
 include/linux/memory-tiers.h |  5 +++++
 mm/damon/core.c              |  6 ++++--
 mm/damon/lru_sort.c          |  3 ++-
 mm/damon/paddr.c             | 19 ++++++++++++-------
 mm/damon/reclaim.c           |  3 ++-
 mm/damon/sysfs-schemes.c     | 31 ++++++++++++++++++++++++++++++-
 mm/memory-tiers.c            | 13 +++++++++++++
 mm/vmscan.c                  |  2 +-
 samples/damon/mtier.c        |  3 ++-
 samples/damon/prcl.c         |  3 ++-
 11 files changed, 81 insertions(+), 16 deletions(-)

-- 
2.39.3


