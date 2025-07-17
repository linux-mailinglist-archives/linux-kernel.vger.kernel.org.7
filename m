Return-Path: <linux-kernel+bounces-735239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814CB08CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39DB7ABB92
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A52BD004;
	Thu, 17 Jul 2025 12:18:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDF2BD03C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754680; cv=none; b=N7BDua3a1VrzjwI6qY5cUR1iW5cB6hUtlbiKiEAvhocLD3qCTijIBlC2/K0bfSVU/288o064lbf2kJ53IhA72xXwI3YtsuGlearZEgcb8ndcaxIhh859Cz+RFgn7b2a/0yXdQ5nqfyhesJ9fV3moB99bwU6PQUJO25yioF+9YBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754680; c=relaxed/simple;
	bh=ndmxXjzqfLlNN9SZH4tEsLmBgGx/xxp4Tt9LUR5ymcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3J//np3jXvUvsJBIPyl0+t3NoICC56hkv/JMe3UDjnxiKNDBOCT3SnS/8JB9R9ZblnRv0L67w3GZn3dQvgsXleue3LvFWO/VK9rBfRSID3bBizQHIEyJL3vd81L5Bu/AOpuOc7Tyk9pZFqc8JHxdg+u7yzI0vLTmGL303icWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bjWzt4C4jz2Cfsl;
	Thu, 17 Jul 2025 20:13:46 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A4B81400D4;
	Thu, 17 Jul 2025 20:17:54 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 20:17:53 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 20:17:53 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hejunhao3@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH v5 0/2] drivers/perf: hisi: Add support for HiSilicon NOC and MN PMU driver
Date: Thu, 17 Jul 2025 20:17:25 +0800
Message-ID: <20250717121727.61057-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemq200018.china.huawei.com (7.202.195.108)

From: Yicong Yang <yangyicong@hisilicon.com>

Add support for two new Uncore PMUs to monitor the events of the system bus
(by NoC PMU) and the DVM operations (by MN PMU).

Change since v4:
- Rename ovflow_status to .overflow_status with Jonathan's Tag, thanks!
Link: https://lore.kernel.org/linux-arm-kernel/20250717074138.39903-1-yangyicong@huawei.com/

Change since v3:
- Use ACPI driver data to retrieve the hardware capabilities
Link: https://lore.kernel.org/linux-arm-kernel/20250619125557.57372-1-yangyicong@huawei.com/

Junhao He (1):
  drivers/perf: hisi: Add support for HiSilicon MN PMU driver

Yicong Yang (1):
  drivers/perf: hisi: Add support for HiSilicon NoC PMU

 Documentation/admin-guide/perf/hisi-pmu.rst  |  11 +
 drivers/perf/hisilicon/Makefile              |   3 +-
 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c  | 411 +++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c | 443 +++++++++++++++++++
 4 files changed, 867 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

-- 
2.24.0


