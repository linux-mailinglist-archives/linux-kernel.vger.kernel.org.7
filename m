Return-Path: <linux-kernel+bounces-728093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E72B0239B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15A217E4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D22F3644;
	Fri, 11 Jul 2025 18:27:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D152F362E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258478; cv=none; b=T6vt71gdbuDUvdXc6XwCHjkwSmAGVX6qkAQYpV+Lv4prj94s5OY7RfaCd3zPqerPcaadhkAuB1g+DzZnoLtHxrk+KSpDSYzTUwSnATZuKU5Ppm4b1N7IpK6eWkJF2EorHTqyhTN9RRvsvJkbgUo3K4X4ygF+j4uAilVrkzf2hWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258478; c=relaxed/simple;
	bh=4Aaavnz5mr7p1eBEK7VbBxW6aPSlpvWC7K/rOb8VjPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDX0waGeBrxOpc00O2ytX2clFyCdNRJ/nyCpFwVelAi0fECXIfuZv9MjGG8twY0d1GAVAsccHA9f+VKz0QzDb2j/b6lkdGIEzUs5ZtGHnl1MezRMmVtUs9HePMBQOszEyTrdFXwYksLvDFdeDLfkmM36Mq6AjLBA/39sVa/+iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC2E016F8;
	Fri, 11 Jul 2025 11:27:45 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCCF83F694;
	Fri, 11 Jul 2025 11:27:54 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	sudeep.holla@arm.com,
	Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>
Subject: [PATCH v3 0/3] cacheinfo: Set cache 'id' based on DT data
Date: Fri, 11 Jul 2025 18:27:40 +0000
Message-Id: <20250711182743.30141-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2?
 * Fixed a of node ref leak in patch 1.

---

This series adds support for cache-ids to device-tree systems.
These values are exposed to user-space via
/sys/devices/system/cpu/cpuX/cache/indexY/id
and are used to identify caches and their associated CPUs by kernel interfaces
such as resctrl.

Resctrl anticipates cache-ids are unique for a given cache level, but may
be sparse. See Documentation/filesystems/resctrl.rst's "Cache IDs" section.

Another user is PCIe's cache-steering hints, where an id provided by the
hardware would be needed. Today this expects a platform specific ACPI hook
the program that value into the PCIe root port registers. If DT platforms
are ever supported, it will likely need a kernel driver to convert the
user-space cache-id to whatever hardware value is needed.

This series generates a 32bit cache-id from the lowest CPU hardware id
of the CPU's associated with that cache. On arm64, CPU hardware ids may
be greater than 32bits, but can be swizzled into 32bits. An architecture
hook is provided to allow the architecture to swizzle the values into 32bits.

This series is based on v6.16-rc4, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/cacheinfo/v3

The MPAM driver that makes use of these can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.16-rc4

What is MPAM? Set your time-machine to 2020:
https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

[v2] lore.kernel.org/r/20250704173826.13025-1-james.morse@arm.com
[v1] lore.kernel.org/r/20250613130356.8080-1-james.morse@arm.com

Bugs welcome,
Thanks,

James Morse (2):
  cacheinfo: Add arch hook to compress CPU h/w id into 32 bits for
    cache-id
  arm64: cacheinfo: Provide helper to compress MPIDR value into u32

Rob Herring (1):
  cacheinfo: Set cache 'id' based on DT data

 arch/arm64/include/asm/cache.h | 17 ++++++++++++
 drivers/base/cacheinfo.c       | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

-- 
2.39.5


