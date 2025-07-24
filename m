Return-Path: <linux-kernel+bounces-743894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BBB10514
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F371CC80D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40EA274FED;
	Thu, 24 Jul 2025 08:56:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57EE27467A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347367; cv=none; b=shuZaMDp7iy7JrVS8dFkVn3ib0bucFYPKHthZUnGxBi/BJgTyhtkrUyni99IPxv9xlh08iyK0nusQPtJaoXnfqAIpHjVywVUjzKu4gxjmFJB9T9mjcPsqbU2iR+iGAHaEdLM2tGkdOuT7UvfueJyJccGmdqs6j40I5pA6EiCn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347367; c=relaxed/simple;
	bh=+tjmMrnVCoqetz3ZoVPtvqyjhAuvuYHo81EAyz+VDj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DNdLnfTJreDWwY/TQe1eBVGP6snYYGG/Qz4w1PFOFwg7QI2OJTKlsi8xLLn84AS6qZmILAgVP791HWWvoZ2Lvg9JGkL9zpYa1PMb8X2TXCVKcXKEF+cyKVgEyWTENGV1cBJIDhK+iPMrOFK5BDmEO0BhgJ+w1mJXRxiiMKMmMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bnlFG0YlTzQwPF;
	Thu, 24 Jul 2025 16:54:58 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id DF92F180B60;
	Thu, 24 Jul 2025 16:56:01 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 16:56:01 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, <xiaqinxin@huawei.com>
Subject: [PATCH 0/2] dma-mapping: benchmark: modify the dma_map_benchmark directory
Date: Thu, 24 Jul 2025 16:55:58 +0800
Message-ID: <20250724085600.4101321-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
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

This series moves the dma_map_benchmark utility out of the selftests
directory and fixes an ABI regression introduced in an earlier change.
No functional behaviour of the benchmark itself is changed.

Qinxin Xia (2):
  tools/dma: move dma_map_benchmark from selftests to tools/dma
  dma-mapping: benchmark: Add padding to ensure uABI remained consistent

 include/linux/map_benchmark.h                     |  1 +
 tools/Makefile                                    | 13 +++++++------
 tools/dma/Makefile                                | 15 +++++++++++++++
 tools/{testing/selftests => }/dma/config          |  0
 .../selftests => }/dma/dma_map_benchmark.c        |  0
 tools/testing/selftests/dma/Makefile              |  7 -------
 6 files changed, 23 insertions(+), 13 deletions(-)
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (100%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

-- 
2.33.0


