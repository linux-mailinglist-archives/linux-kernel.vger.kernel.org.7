Return-Path: <linux-kernel+bounces-871756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB5C0E446
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD8C64FB397
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6472BEFEF;
	Mon, 27 Oct 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nTHj0Gv6"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DD2C0265
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573778; cv=none; b=Xw6JUS8Xd3Sis0jpjqakz5rcATW3l+Pjhc8MvUzslOgMvkcVxfeqijGA4cpLelHzNPH4Wi0gjAJw/7uAWtvYeptNFT4rbrAXOudmzAadHYFHcWy5Zz6KnQ2c8bM7PNmGeMGy/CVvcZxySoOZum/iTNL5PWwvLdLwCiA2wsHxnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573778; c=relaxed/simple;
	bh=ZdgVPMepOJok5hDkKhI0H2GiYXaHtJZ3hU8XQmcY7LI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrI9N4wPrILqKJ+I0cWJYfC4UJl4lPgE6PXrFzEBojTgVKqxdiyVFXJi0gylfZ/1g+RdevLWzyi7881Jet5GL2tebg7V/k6mh+Gd9AXLlede7VP3cuRGFU2sAD9yC2zDwRxFkEbxoZ5Qq0Z2prg9B0oy8dWrSmyNbwG/iTAzMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nTHj0Gv6; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TzkRKGIlc/o7rNaRSYplFXt4cJ/hxYcmoSd6y1EVT/k=;
	b=nTHj0Gv6+IcxCkuZdK9h/iEIQRi17XLgdPrh7V51tZICYs0XWXNokqVeqOt7buhl8SDjmVpGS
	2DuJLZExrPlHl727O16LKWBFuUSSOO1ijmc7KmcOFifJOOIohsSx+urM+QNf0ZR/4DzokFwYgSw
	v+g1wZuqAker4THd971VXEM=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cwFZ82bMFzmV6g;
	Mon, 27 Oct 2025 22:02:24 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 1654F1402C6;
	Mon, 27 Oct 2025 22:02:52 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 22:02:51 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<jannh@google.com>, <pfalcato@suse.de>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [RFC PATCH 0/3] mm: PTEs batch optimization in mincore and mremap
Date: Mon, 27 Oct 2025 22:03:12 +0800
Message-ID: <20251027140315.907864-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500012.china.huawei.com (7.185.36.8)

This first patch extract a new interface named can_pte_batch_count()
from folio_pte_batch_flags() for pte batch. Thew new interface avoids
folio access, and counts more pte, not just limited to entries mapped
within a single folio. Caller need pass a range within a single VMA
and a single page and it detect consecutive (present) PTEs that map
consecutive pages. The 2th and 3rd patches use can_pte_batch_count()
do pte batch.

Zhang Qilong (3):
  mm: Introduce can_pte_batch_count() for PTEs batch optimization.
  mm/mincore: Use can_pte_batch_count() in mincore_pte_range() for pte
    batch mincore_pte_range()
  mm/mremap: Use can_pte_batch_count() instead of folio_pte_batch() for
    pte batch

 mm/internal.h | 76 +++++++++++++++++++++++++++++++++++++++------------
 mm/mincore.c  | 10 ++-----
 mm/mremap.c   | 16 ++---------
 3 files changed, 64 insertions(+), 38 deletions(-)

-- 
2.43.0


