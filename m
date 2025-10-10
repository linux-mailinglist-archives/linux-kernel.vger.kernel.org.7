Return-Path: <linux-kernel+bounces-847662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFBBCB5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A673C818B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D643E1514E4;
	Fri, 10 Oct 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Pp7KMqCy"
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7860DDC5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060958; cv=none; b=mt5W9zH5zbsH6NQBkADvCMFd02uvBL+ozE37kRvMMt+PZc1UVEsNNI67if1u9C/Z4usrBxhdUR1p6BmGxe/iSrzLUpxM5T0HfFDAhJhNoOkfcoWEM2SNdaAzYHomn2rpsu2NmYJEDXsjTlbBrXox3ARt1cGZs5HXGTq1px6QR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060958; c=relaxed/simple;
	bh=34b1++mXtY0zR4TfJY1CiEAcda+FlEyiO4n61Y51gxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKnGVq+9JU1+wybvS6Tbyu6uFLqdPGZO0U4oFK5VB55oFkcwXWSOFtf5LU6rddtFby0C3dsa+wQir9rApLPkZNge5fpWrq4gCupkDNyc8R+XBrUYu+b1jYl7Wv1e5Kv25Yl4QPpkQ/fOrs4q9x7nei+3tRr6ArUtbiCaGjTCeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Pp7KMqCy; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cjV5M0HpRzvX8m
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:48:39 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NN7TKZpuTKou0cZq/X6oLAacTZkxb+JVQ09be3EeP1Y=;
	b=Pp7KMqCy5krUbStfoY2D5FQulDV63BZ8Kz/On8RQhlfFTbDGZBC4HRcY9Cg/FgW/D18pLD3JC
	+zuhrqtG4TKEvaHbsxTX3iq4KZOSkFy8ZvAiaNZgUhYYjfeXBzsSmzPYNQs9SySloyyeZcoibVr
	uBrVNdIHZFt7B+lvCAUXd/M=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cjV505TVDz1T4FX
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:48:20 +0800 (CST)
Received: from dggpemf500006.china.huawei.com (unknown [7.185.36.235])
	by mail.maildlp.com (Postfix) with ESMTPS id E89F21402C8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:48:57 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemf500006.china.huawei.com (7.185.36.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 09:48:57 +0800
From: Yang Shen <shenyang39@huawei.com>
To: <yangyicong@huawei.com>, <jonathan.cameron@huawei.com>,
	<fanghao11@huawei.com>, <shenyang39@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update HiSilicon PTT driver maintainer
Date: Fri, 10 Oct 2025 09:48:47 +0800
Message-ID: <20251010014847.2747140-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500006.china.huawei.com (7.185.36.235)

Add Yang Shen as the maintainer of the HiSilicon PTT driver,
replacing Yicong Yang.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a6f4ef1cca3..e9a40db0f368 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11278,8 +11278,8 @@ F:	drivers/perf/hisilicon
 F:	tools/perf/pmu-events/arch/arm64/hisilicon/
 
 HISILICON PTT DRIVER
-M:	Yicong Yang <yangyicong@hisilicon.com>
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Yang Shen <shenyang39@huawei.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
-- 
2.33.0


