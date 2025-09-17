Return-Path: <linux-kernel+bounces-819841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D4B7EF19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A67B8B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1E1E260A;
	Wed, 17 Sep 2025 01:18:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722635947
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071891; cv=none; b=uXzd5qBOlgx7ibB/PdSZ+yv+uadxoMZfHciILfbw05x0//YVAh8YjtiX7U9VwpZhwnflqFMp8e3TwonYAQVm2cY/RV2wFsoZSdpWOxFtTwiIDFxJyc0RyTTGTiyzzyMVH1A/oEyLfMxG6BFkVvAeBdU3O9/tbs6g5wnMxhkb9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071891; c=relaxed/simple;
	bh=caMCpgQWQD+y0iBmSs7jbTFl18542RchJgEgnH61wbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FnlcbVgZszb5KXHx4NV91TT7yW27LGz9xX8DPytKUoMAFFFLZ5xrpgMGgROOTbQKGPIpL3B0NOHpxL7jvO3IRimOWzxdI/C2/Q8O1O9yT3d8w93uhW/1UTUeiBz45jZ5Oq5ExA7E4nkcvZLJGKF1oJ63SKHC4T8ZIpqJGJgds9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cRLVN47byz14Mdd;
	Wed, 17 Sep 2025 09:17:48 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id CAE541402E9;
	Wed, 17 Sep 2025 09:18:04 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 09:18:04 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>
Subject: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers
Date: Wed, 17 Sep 2025 09:17:59 +0800
Message-ID: <20250917011759.2228019-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Since Chenxiang has left HiSilicon, Barry and I will jointly
maintain this module.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6206963efbf..512bc67aa02c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7218,7 +7218,8 @@ F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h
 
 DMA MAPPING BENCHMARK
-M:	Xiang Chen <chenxiang66@hisilicon.com>
+M:	Barry Song <baohua@kernel.org>
+M:	Qinxin Xia <xiaqinxin@huawei.com>
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
-- 
2.33.0


