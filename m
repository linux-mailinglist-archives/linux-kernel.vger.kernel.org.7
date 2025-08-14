Return-Path: <linux-kernel+bounces-768687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8AB2642C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 190ED4E575C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50A2F2905;
	Thu, 14 Aug 2025 11:25:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FD2BE05B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170717; cv=none; b=YRUJiutVTgS1K3OSuszOT8Mld740/+86RMMdD/B8c9H0eopKArQxQqbBwbkFFuQzSKIHlCAcUi24K3IgG3j7FdwMeWXFIb0oiJ7n8FQAKphkZ7ZeLbM4gxNqi7zbLOuL50cl1NUOL1C0TWnOyNexuwtNKFtNlvHIZKhbwWqhmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170717; c=relaxed/simple;
	bh=HIbPfI7MosuAtrJ6SPWOMg2a7lN+JJmYXKdE9eq83pw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIzJN5ixwpqlx4Bzaa9PceEiHn3208e93PBn3Q65x9wnnA8toXMUDtweH3zbhzbktUy9nR28FT4lHQGx7n3pVCEf7guN3GASqExS5ybjEMT29nPbXCFQeOzfaPq+j7bCYoEp10WAHNd26u+MfKhl8KL5oe2pGA07Jcs64qMCXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c2jTv0DdRzdcJS;
	Thu, 14 Aug 2025 19:20:51 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F0A0180B51;
	Thu, 14 Aug 2025 19:25:11 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 19:25:11 +0800
Received: from huawei.com (10.175.112.208) by kwepemq200012.china.huawei.com
 (7.202.194.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 19:25:10 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<tglx@linutronix.de>, <saravanak@google.com>, <robh@kernel.org>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>, <wangwensheng4@huawei.com>
Subject: [PATCH 0/3] Fix issues for device probe
Date: Thu, 14 Aug 2025 19:10:20 +0800
Message-ID: <20250814111023.2693-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200012.china.huawei.com (7.202.194.183)

The sbsa-gwdt device sometimes doesn't probe on my board after the
kernel updated from 5.10 to 6.6. And even when the watchdog probe
eventually, it a bit later than that in 5.10 kernel, approximately
10 seconds after sbsa_gwdt.ko loaded.

The first issue is fixed in the first patch.
The second issue is fixed in the following two patches, but I'm not
sure whether this is properly.

Wang Wensheng (3):
  driver core: Fix concurrent problem of deferred_probe_extend_timeout()
  driver core: Introduce fw_devlink_relax_consumers helper
  irqchip/mbigen: Use fw_devlink_relax_consumers() helper

 drivers/base/core.c          | 22 ++++++++++++++++++++++
 drivers/base/dd.c            |  2 ++
 drivers/irqchip/irq-mbigen.c |  2 ++
 include/linux/device.h       |  1 +
 4 files changed, 27 insertions(+)

-- 
2.22.0


