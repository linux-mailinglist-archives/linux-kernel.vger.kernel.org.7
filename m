Return-Path: <linux-kernel+bounces-779952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD5AB2FB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B76B6568D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221D24DCF7;
	Thu, 21 Aug 2025 13:50:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7E233714
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784257; cv=none; b=agcAZ83fV9UCS12siBsoODBqmLljIbAVEWUVGoxpLaVHEgiDASp89o2E3Rgrcnzatfev5Mts9zvSRmFaFOJz2Bbxe9fRyyF7qoOTSuu0ydNvAwZUBpYOSekoI2HZWnwTZhCW7dYJHv+DFj071iJjA1djzBPGMrsJLgW04XlW9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784257; c=relaxed/simple;
	bh=wfMrZ2Vpvp7qvM3/QbnApGT2OJbGdjuq0WK9km2NSXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ARakIrJ1G3n4Hpt/YGdGEm9QOJ2qRkPyEXduAYuSHOOsltw3pev1AgSvnn7Ww8M+89Y+N+9k3HOAe5f5+WY4TpX/TZFC1C4Qa6aePzdWQM/RyAmy8T1+4h+kQfNvuddaIBoHTXNjcHKwuE+zZoUzPO7vKEA2vsSEoe0495ChqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c74NR0SqVzPpKf;
	Thu, 21 Aug 2025 21:46:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 03B27180087;
	Thu, 21 Aug 2025 21:50:51 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 21:50:50 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 21:50:49 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <robin.murphy@arm.com>, <yangyicong@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<wangyushan12@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v2 0/9] Updates of HiSilicon Uncore L3C PMU
Date: Thu, 21 Aug 2025 21:50:40 +0800
Message-ID: <20250821135049.2010220-1-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Support new version of L3C PMU, which supports extended events space
which can be controlled in up to 2 extra address spaces with separate
overflow interrupts.  The layout of the control/event registers are kept
the same.  The extended events with original ones together cover the
monitoring job of all transactions on L3C.

That's said, the driver supports finer granual statistics of L3 cache
with separated and dedicated PMUs, and a new operand `ext` to give a
hint of to which part should perf counting command be delivered.

The extended events is specified with `ext=[1|2]` option for the driver
to distinguish:

perf stat -e hisi_sccl0_l3c0_0/event=<event_id>,ext=<ext>/

Currently only event option using config bit [7, 0]. There's still
plenty unused space. Make ext using config [16, 17] and reserve
bit [15, 8] for event option for future extension.

With the capability of extra counters, number of counters for HiSilicon
uncore PMU could reach up to 24, the usedmap is extended accordingly.

The hw_perf_event::event_base is initialized to the base MMIO address
of the event and will be used for later control, overflow handling and
counts readout.

We still make use of the Uncore PMU framework for handling the events
and interrupt migration on CPU hotplug. The framework's cpuhp callback
will handle the event migration and interrupt migration of orginial
event, if PMU supports extended events then the interrupt of extended
events is migrated to the same CPU choosed by the framework.

A new HID of HISI0215 is used for this version of L3C PMU.

Some necessary refactor is included, allowing the framework to cope with
the new version of driver.

Depends-on: drivers/perf: hisi: Add support for HiSilicon NOC and MN PMU driver
Depends-on: Message-ID: <20250717121727.61057-1-yangyicong@huawei.com>

---

Changes:

v1 -> v2:
  - Don't call disable_irq() and simply return success when there is no
    CPU available for irq migration.
  - Documentation patch split.
  - Fix of a few other issues etc. per Jonathan.

Yicong Yang (7):
  drivers/perf: hisi: Relax the event ID check in the framework
  drivers/perf: hisi: Export hisi_uncore_pmu_isr()
  drivers/perf: hisi: Simplify the probe process of each L3C PMU version
  drivers/perf: hisi: Extract the event filter check of L3C PMU
  drivers/perf: hisi: Extend the field of tt_core
  drivers/perf: hisi: Refactor the event configuration of L3C PMU
  drivers/perf: hisi: Add support for L3C PMU v3

Yushan Wang (2):
  Documentation: hisi-pmu: Fix of minor format error
  Documentation: hisi-pmu: Add introduction to HiSilicon

 Documentation/admin-guide/perf/hisi-pmu.rst  |  43 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 520 +++++++++++++++----
 drivers/perf/hisilicon/hisi_uncore_pmu.c     |   5 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h     |   6 +-
 4 files changed, 477 insertions(+), 97 deletions(-)

-- 
2.33.0


