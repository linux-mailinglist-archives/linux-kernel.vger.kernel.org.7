Return-Path: <linux-kernel+bounces-827430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B372AB91BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3A17AA454
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA426E143;
	Mon, 22 Sep 2025 14:36:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BF61FFE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551788; cv=none; b=ZhQzBb8yoirfMj/eeQ4iUpymz4Tnef8fhAimpM9wzSf1txj3e3unojOrziY7yN74tRNA0nQfy4aNYoaW2rEEhHbx9diXpcrTTVj7HG1iM9iUDUtZCl9HSbgRPc+Jik6MPp7Jr68YRCnV8qKNe4UiynvyoxK5m4emLDG5dgrWUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551788; c=relaxed/simple;
	bh=AefBvn/guChXgGQ9hFGiKx8ZZ9063GkJqlEevE9LrUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZJgWpCZtRrriYppPwbkmb0SehnIJ+iv5hE8JkGaNx99tozOMxxWIlmxDJ3ObfXapxVjpNmBBn/HESYbO0jN586magK+t9CclRmR2kj2WF9BKQ4cHhxtFrdtnWYgTREqam5PNGRzh66j3zYKtmQeDiwLPYthkG3sjAHG0Wj8DF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cVlvv1gfCz1R9SW;
	Mon, 22 Sep 2025 22:33:15 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B2911800B2;
	Mon, 22 Sep 2025 22:36:23 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 22:36:22 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
CC: <will@kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/memory-failure: not select MEMORY_ISOLATION
Date: Mon, 22 Sep 2025 22:36:18 +0800
Message-ID: <20250922143618.48640-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

We added that "select MEMORY_ISOLATION" in commit ee6f509c3274 ("mm:
factor out memory isolate functions").
However, in commit add05cecef80 ("mm: soft-offline: don't free target
page in successful page migration") we remove the need for it,
where we removed the calls to set_migratetype_isolate() etc.

What CONFIG_MEMORY_FAILURE soft-offline support wants is migrate_pages()
support. But that comes with CONFIG_MIGRATION.
And isolate_folio_to_list() has nothing to do with CONFIG_MEMORY_ISOLATION.

Therefore, we can remove "select MEMORY_ISOLATION" of MEMORY_FAILURE.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 034a1662d8c1..0e26f4fc8717 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -742,21 +742,20 @@ config DEFAULT_MMAP_MIN_ADDR
 	  This value can be changed after boot using the
 	  /proc/sys/vm/mmap_min_addr tunable.
 
 config ARCH_SUPPORTS_MEMORY_FAILURE
 	bool
 
 config MEMORY_FAILURE
 	depends on MMU
 	depends on ARCH_SUPPORTS_MEMORY_FAILURE
 	bool "Enable recovery from hardware memory errors"
-	select MEMORY_ISOLATION
 	select RAS
 	help
 	  Enables code to recover from some memory failures on systems
 	  with MCA recovery. This allows a system to continue running
 	  even when some of its memory has uncorrected errors. This requires
 	  special hardware support and typically ECC memory.
 
 config HWPOISON_INJECT
 	tristate "HWPoison pages injector"
 	depends on MEMORY_FAILURE && DEBUG_KERNEL && PROC_FS
-- 
2.48.1


