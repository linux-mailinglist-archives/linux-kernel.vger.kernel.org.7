Return-Path: <linux-kernel+bounces-734941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56FB0888E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432491642D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688B286D7F;
	Thu, 17 Jul 2025 08:58:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9E1D7E42
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742687; cv=none; b=WKakW3P/vfV22c6oriWY1EPTSncJPSV2/s+kpg3pPFAErcZlRL9d/RyDJoaxRISGTpMHl/4XY7WMOcQW+vHulaIiaBUV0WJc16MOFUaP6TT6yFN5BCoOO2lEt+VZcr8X2HYm7qs2yiMuPOKV0JnVnxQWFpENI75GnKhwKj29mtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742687; c=relaxed/simple;
	bh=PcGlg3g4OHbwQuXD/Jy1QGzzClUEtuHHQOibxC5oTMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PgbWNCD2DK0PmZY7p3F4PuxLdziZsyJLxvlipCRE1w0eIP0WyQdSsvgBd2g2bNNby2W3e+9L59HQDuHPDgh/c9cecOey6zPxbcAeXDVeRqwfR0Jjchq3CO6nCDN0vsKNbLlw75WHyyfWyvp0o8aX1E+Fn9TzdMOBVIs93RPVZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bjRcl54b7ztSbT;
	Thu, 17 Jul 2025 16:56:55 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id C5A2B140259;
	Thu, 17 Jul 2025 16:58:00 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemg100017.china.huawei.com
 (7.202.181.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Jul
 2025 16:58:00 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <rppt@kernel.org>, <ardb@kernel.org>
CC: <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: ignore nomap memory during mirror init
Date: Thu, 17 Jul 2025 16:57:23 +0800
Message-ID: <20250717085723.1875462-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg100017.china.huawei.com (7.202.181.58)

When memory mirroring is enabled, the BIOS may reserve memory regions
at the start of the physical address space without the MR flag. This will
lead to zone_movable_pfn to be updated to the start of these reserved
regions, resulting in subsequent mirrored memory being ignored.

Here is the log with efi=debug enabled:
  efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
  efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
  efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
  efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
...
  efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]

Since this kind of memory can not be used by kernel. ignore nomap memory to fix
this issue.

Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f2944748f526..1c36518f0fe4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -405,7 +405,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		}
 
 		for_each_mem_region(r) {
-			if (memblock_is_mirror(r))
+			if (memblock_is_mirror(r) || memblock_is_nomap(r))
 				continue;
 
 			nid = memblock_get_region_node(r);
-- 
2.43.0


