Return-Path: <linux-kernel+bounces-895394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1ABC4DAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 553F74E99FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132E358D3E;
	Tue, 11 Nov 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="J6YgRveN"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B77358D13
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863725; cv=none; b=HPGxkwhiY7p/XMCXCR74bl8rqzRXIlhiC5hWeqw9glKJdAaCg9Cr9HIq/YfIf3AgYxa44avOZE0cynBCI7bxbGIHJZcUog8lflnuWMQuk4Tkz9zD7bV8WfUvaiIxhKPtNgxGeOZEh+dRTbjkw7czh+753Ekmp3+YlP41XEh1pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863725; c=relaxed/simple;
	bh=RG0PLxcFtQ5kK7m/s9u86wP/A2Wblx9BUtTVq2SWDk8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lCTLgOtJ8RtK3Q/KBuhjbAgBpx9Dw2gfBj4KVS6fIyP93eJoUfy3Az48Rbd8cZCfJF4hecenlyCX+26+yyh4eeLgx9lOvCsuwz7pO8WHyeulqqIom+I3+EtGh+0vON63sXAJdz7BBe+Q27ipky1nwqJZHLGgQOo5NFzjzDDkFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=J6YgRveN; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dTCgwwGpCsX1eoq9BlzwM04EmE962CsxPEITUwNKSpY=;
	b=J6YgRveNzqFh1OijyD9n24NyS5wX3sYcoofYldF+MsuOpCqDuNjonPgnfHkVRfK5TZbnnEkM9
	luBjahgjKnuU+fNk1mUfrLtYCCDjTBnYArIYgW9qgI3TsRUGRAGu2OwM21qGEImeE2wR8gDk+L8
	FRf+MNohA4c10IIkxUgvzXc=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d5QbL4XC5z1prlV;
	Tue, 11 Nov 2025 20:20:14 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3553E180B5A;
	Tue, 11 Nov 2025 20:21:54 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 20:21:51 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 20:21:51 +0800
From: Junhao He <hejunhao3@h-partners.com>
To: <suzuki.poulose@arm.com>, <james.clark@linaro.org>,
	<anshuman.khandual@arm.com>, <yeoreum.yun@arm.com>, <mike.leach@linaro.org>,
	<leo.yan@arm.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v4 0/3] Coresight TMC-ETR: refactor the tmc-etr mode and some cleanups
Date: Tue, 11 Nov 2025 20:21:46 +0800
Message-ID: <20251111122149.1981162-1-hejunhao3@h-partners.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn500004.china.huawei.com (7.202.194.145)

This patchset builds upon Yicong's previous patches [1].

Patch 2 introducing fix race issues found by using TMC-ETR.
Patch 1 & 3 introducing two cleanups found when debugging the issues.

[1] https://lore.kernel.org/linux-arm-kernel/20241202092419.11777-1-yangyicong@huawei.com/

---
Changes in v4:
 - a) Add comment at the context of set etr to sysfs mode.
 - b) Move the check on drvdata->read to the start of enable etr.
 - c) Add checks to prevent multiple sysfs processes from simultaneously
 competing to enable ETR.
 - d) Fix the issue with the guard used.
Link: https://lore.kernel.org/linux-arm-kernel/20250818080600.418425-1-hejunhao3@huawei.com/

---
Changes in v3:
 - Patches 1: Additional comment for tmc_drvdata::etr_mode. Update
 comment for tmc_drvdata::reading with Jonathan's Tag.
 - Patches 2: Replace scoped_guard with guard with Jonathan's Tag.
 - Patches 2: Fix spinlock to raw_spinlock, and refactor this code based
 on Leo's suggested solution.
 - Patches 3: change the size's type to ssize_t and use max_t to simplify
 the code with Leo's Tag.
Link: https://lore.kernel.org/linux-arm-kernel/20250620075412.952934-1-hejunhao3@huawei.com/

Changes in v2:
- Updated the commit of patch2.
- Rebase to v6.16-rc1

Junhao He (1):
  coresight: tmc: refactor the tmc-etr mode setting to avoid race
    conditions

Yicong Yang (2):
  coresight: tmc: Add missing doc including reading and etr_mode of
    struct tmc_drvdata
  coresight: tmc: Decouple the perf buffer allocation from sysfs mode

 .../hwtracing/coresight/coresight-tmc-etr.c   | 136 +++++++++---------
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 2 files changed, 66 insertions(+), 72 deletions(-)

-- 
2.33.0


