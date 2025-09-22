Return-Path: <linux-kernel+bounces-826540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7CB8EC0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CFD18981C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83812836F;
	Mon, 22 Sep 2025 02:15:10 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC90347DD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507310; cv=none; b=c5v4yKT6ZGj+korBclN5DXzfmjVoW39RFjeS9wkF4I8+J/vFzz4px7JiB2WynhRiJI0uFQvohnAMADL8bDuEfhjwH25bGcFe7463+jQxEuVzit9Pi6yw0WUXFtkAAT/RJf79UnEl4YFu6s+qlmxhS3niJ+4HnEKtDLyBIM70iGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507310; c=relaxed/simple;
	bh=Gbce8Q9ziKq1oP44Cb6BeRoPcmU2y9EJdOS0nMf5FcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeEXz+gJZuqU3krD4ECOSPoDyLUAA3Gf4fDb0kBgOzVEoFuwC6lIf1J7Kg7xFzWac6hROS1xPLziXPv0yTvdvbTyJaS4fZ+ssXp1XEuabM76R4kdRVH0Vj6FLUsMkH/V7rm7D+2nEo0c9zYGv0doKCpBbAz7nYWIf2NppBrjRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cVRQk377Jz2CgD2;
	Mon, 22 Sep 2025 10:10:22 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id E560118001B;
	Mon, 22 Sep 2025 10:14:59 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 10:14:59 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>, <nathan@kernel.org>,
	<ebiggers@kernel.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
	<kees@kernel.org>, <dave@vasilevsky.ca>, <peterz@infradead.org>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [RFC PATCH 2/2] ARM: memory-failure: not select RAS and MEMORY_ISOLATION
Date: Mon, 22 Sep 2025 10:14:53 +0800
Message-ID: <20250922021453.3939-2-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922021453.3939-1-xieyuanbin1@huawei.com>
References: <20250922021453.3939-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

For memory-failure on ARM, these features do not seem necessary.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 mm/Kconfig          | 4 ++--
 mm/memory-failure.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 034a1662d8c1..22eefc4747d5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -742,22 +742,22 @@ config DEFAULT_MMAP_MIN_ADDR
 	  This value can be changed after boot using the
 	  /proc/sys/vm/mmap_min_addr tunable.
 
 config ARCH_SUPPORTS_MEMORY_FAILURE
 	bool
 
 config MEMORY_FAILURE
 	depends on MMU
 	depends on ARCH_SUPPORTS_MEMORY_FAILURE
 	bool "Enable recovery from hardware memory errors"
-	select MEMORY_ISOLATION
-	select RAS
+	select MEMORY_ISOLATION if !ARM
+	select RAS if !ARM
 	help
 	  Enables code to recover from some memory failures on systems
 	  with MCA recovery. This allows a system to continue running
 	  even when some of its memory has uncorrected errors. This requires
 	  special hardware support and typically ECC memory.
 
 config HWPOISON_INJECT
 	tristate "HWPoison pages injector"
 	depends on MEMORY_FAILURE && DEBUG_KERNEL && PROC_FS
 	select PROC_PAGE_MONITOR
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a24806bb8e82..83b77caf41a1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1271,21 +1271,23 @@ static void update_per_node_mf_stats(unsigned long pfn,
 	++mf_stats->total;
 }
 
 /*
  * "Dirty/Clean" indication is not 100% accurate due to the possibility of
  * setting PG_dirty outside page lock. See also comment above set_page_dirty().
  */
 static int action_result(unsigned long pfn, enum mf_action_page_type type,
 			 enum mf_result result)
 {
+#ifdef CONFIG_RAS
 	trace_memory_failure_event(pfn, type, result);
+#endif
 
 	if (type != MF_MSG_ALREADY_POISONED) {
 		num_poisoned_pages_inc(pfn);
 		update_per_node_mf_stats(pfn, result);
 	}
 
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 
 	return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
-- 
2.48.1


