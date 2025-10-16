Return-Path: <linux-kernel+bounces-856317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83646BE3D81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE56188D336
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979462DFF18;
	Thu, 16 Oct 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fkSWMqHi"
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC07186284
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623349; cv=none; b=RMcUY/qXoxukmK7MKkI6ZTYbW3pKicLQvmg+hY3QEM1xxBFfxtcsQRO9mZ+8M80pOlUxpET006w9i+v42emG6SznryU7UTpliMVC/tRZnd0D9U1RDqTWX4pDJpiE6Lpczh9InGI/O+diyEajPNVWkC3bljO1/+AlVymgtzD51eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623349; c=relaxed/simple;
	bh=eZTc0v+n4Ua79esR/aVwyPQTbVR5jty9LbpzOItjq/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqfyLCjV8IFnu99tHZCxPaRPOD6atn6rwrwOO865YajVEuos4+w//YLbnbqHxl+JiHymp0uRQiPlLgPDve87sbmtsL5vdx68k29dFp8AHVOkaXnvMHHfABaCZEXgI44kPHpBX0bFrv41TZ/xINsScrhacgmr7RLtbeF+krYLFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fkSWMqHi; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=olaNr81UT3i0XgE7r39ZIOMvOjEJR62WYdjIOT7ahzU=;
	b=fkSWMqHiDBDAH7Mt9zDgehSnE9WBou3iEPzz+XFM/xtmJrLnN65EzekUOZXGZzOkITDZzkEGt
	QxdoquzGoWQBuVv3tz2+BY0gy04kXzEDqwT36tOboaep4za9bN0CtwFKBm+kjPEtiRPsdoORVQ4
	A15p9HG/dvEEFtIzqObSjgQ=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cnV4n3sHrzKm5G;
	Thu, 16 Oct 2025 22:02:01 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 709011A0188;
	Thu, 16 Oct 2025 22:02:22 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 22:02:21 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
CC: <will@kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [PATCH RESEND] mm/memory-failure: not select MEMORY_ISOLATION
Date: Thu, 16 Oct 2025 22:02:18 +0800
Message-ID: <20251016140218.15579-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
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


