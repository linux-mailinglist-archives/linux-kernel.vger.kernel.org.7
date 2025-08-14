Return-Path: <linux-kernel+bounces-768918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F753B267F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F9A23C39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB930277D;
	Thu, 14 Aug 2025 13:35:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467722FF657
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178533; cv=none; b=lRoJIMgDijIqn1B8ppHlj20AV0CWLNaVBIVc+6kukofqo/EtiJtfuMIi3k1Io2Lt3Yz7wU82E5KTKJaGUWO9VQgpAPc5ODvCdW7U75lXVffWM8KCRHfu5Rq+tdpGTH1qie7xOCA9baSmx2kvL8rMr1CuAWRpDteBqA/aglBZbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178533; c=relaxed/simple;
	bh=kUakl09XaL+thYgeiZ5VVC8cJ6DUOzP9caEp50JQw08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EaFPCj8Mco2zDJW4Qw934ffumYkKtO4jYNUElYIcME4EsiiqvdpDBlJSyFizAHVQBrpx3ANg863nEUe5Cvd2eUZ8SVixta5/G31BHcd6okWT/Dd+69Ga0C3zbVFBd1oKQvSqcxJxoJuJEcgRVmDBJggmZRuqdwvol+SSgZ+tVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2mS43cMNztTL9;
	Thu, 14 Aug 2025 21:34:28 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 777FB140156;
	Thu, 14 Aug 2025 21:35:28 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 21:35:27 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>
Subject: [PATCH 0/2] move dma_map_benchmark from selftests to tools/dma
Date: Thu, 14 Aug 2025 21:35:25 +0800
Message-ID: <20250814133527.2679261-1-xiaqinxin@huawei.com>
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

Move dma_map_benchmark from selftest/dma to tools/dma directory
and update the maintainer list.

Qinxin Xia (2):
  tools/dma: move dma_map_benchmark from selftests to tools/dma
  MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers

 MAINTAINERS                                     |  5 +++--
 tools/Makefile                                  | 13 +++++++------
 tools/dma/Makefile                              | 17 +++++++++++++++++
 tools/{testing/selftests => }/dma/config        |  0
 .../selftests => }/dma/dma_map_benchmark.c      |  0
 tools/testing/selftests/dma/Makefile            |  7 -------
 6 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (100%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

-- 
2.33.0


