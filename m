Return-Path: <linux-kernel+bounces-773121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F343DB29BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C96B16786B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9432F39BC;
	Mon, 18 Aug 2025 08:06:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86A288C38
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504384; cv=none; b=f8HMFqjru/vVK4XEEBe/Egl7xqedhNF8UvhBKCim4hHTCSc1FIdLE77fUI4dRwW+wwiMax2b7pG2CfhoaXifZzDzi8NufY/IrR7j8sgFUKBwVTkKUq+WwYw4fNz3cpNvu00xvEWm4OVTXUbQ85CUI+2gdi7cLYsOUGvevQVS3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504384; c=relaxed/simple;
	bh=/AkEceZlLzNlJ13rHiVqYnTKV0Sb32bw7+p4r1Dj4Ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCbaaroPM+zy8U2Q91xqJ5fvXvpd0THfBvKmR1ORT3qhyYJkmk+f6Up9QUtzX9RgPI4rN/f+7lkIKsTYoBw5xuXAn9O23SWhpArD4nGnI15NRem8k8IHIKsUKJkIrBwtufIOdSCHq1kQjqF3LiMrgrBbX/a0dMRvE98CQJDXkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c54tD1Bh8z2CgG7;
	Mon, 18 Aug 2025 16:01:40 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 051621400CB;
	Mon, 18 Aug 2025 16:06:02 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 16:06:01 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 16:06:01 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <suzuki.poulose@arm.com>, <james.clark@arm.com>,
	<anshuman.khandual@arm.com>, <leo.yan@arm.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v3 0/3] Coresight TMC-ETR some bugfixes and cleanups
Date: Mon, 18 Aug 2025 16:05:57 +0800
Message-ID: <20250818080600.418425-1-hejunhao3@huawei.com>
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

Introducing fix two race issues found by using TMC-ETR and CATU, Two
cleanups found when debugging the issues.

[1] https://lore.kernel.org/linux-arm-kernel/20241202092419.11777-1-yangyicong@huawei.com/

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

 .../hwtracing/coresight/coresight-tmc-etr.c   | 110 ++++++++----------
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 2 files changed, 53 insertions(+), 59 deletions(-)

-- 
2.33.0


