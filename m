Return-Path: <linux-kernel+bounces-768919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A52B267F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A33A24251
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6590302CCC;
	Thu, 14 Aug 2025 13:35:34 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBA3002D7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178534; cv=none; b=kD79tytyVu4vjAXpoSrbiFWqNUvafY+1h5ZIK+HJNW3x1Ss8qf/2AmQwSFQZd5wPntezMiG2YqCrJIG1psllw+G7KuCyQKp/AuAmc5uQOJ8CmfSqRcyCRLoNNbAhkyivcyH+ntY2dhjHaJYdjYebUnP/uAXY+7Pi5s0nOe6yxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178534; c=relaxed/simple;
	bh=tTg/BQQb/MEndZCoCqp6+iXly8N6eGsXGeHjX1FeH54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haQuzJSQWwkF6srD0wU1UOPUorVh81mhiZmdQ3s7rOGM+eCq/tH+B7SU0lU4IsAI9wo+mKDZTPHDmvs4h+b5aYTZFIrX/U7xGiKQuVS/s4EtQ+E8B99Eq5/ozRVaAfYCbG7FNOjlumSYQVLdQ1wzWwxH3WCm0nFUgPyxSHrM6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c2mQ81ny6z2Dc0V;
	Thu, 14 Aug 2025 21:32:48 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 70B4B1401F4;
	Thu, 14 Aug 2025 21:35:29 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 21:35:28 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>
Subject: [PATCH 2/2] MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers
Date: Thu, 14 Aug 2025 21:35:27 +0800
Message-ID: <20250814133527.2679261-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250814133527.2679261-1-xiaqinxin@huawei.com>
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Since Chenxiang has left HiSilicon, Barry and I will jointly
maintain this module.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5f17a58ffee..21e623b53a7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7219,10 +7219,11 @@ F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h
 
 DMA MAPPING BENCHMARK
-M:	Xiang Chen <chenxiang66@hisilicon.com>
+M:	Barry Song <baohua@kernel.org>
+M:	Qinxin Xia <xiaqinxin@huawei.com>
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
-F:	tools/testing/selftests/dma/
+F:	tools/dma/
 
 DMA MAPPING HELPERS
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
-- 
2.33.0


