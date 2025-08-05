Return-Path: <linux-kernel+bounces-756674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10DB1B7A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1151894D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB827EC80;
	Tue,  5 Aug 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9QuLMVW"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC224205E2F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408125; cv=none; b=oNJ1w2Jv9qGJ/ZC+ilHnc4bh9Ajr2XPwv0rXs6cdWYWaNUz5S74q2XP2zkeeBH0OftD/l7/ubqkZlTaVA1uQIMZak7VkPHEZmVaV37THCmA2b/+7a08FD0OTl6vWjuyAIqs4KezsURibeEIUC0GWcUKitlLKxeuiJsLhb7OM6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408125; c=relaxed/simple;
	bh=1LZLRxen7XVz3f4G9KzqMJVM6McTLyvGI1WIMA9s9n4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TWvri6FPreyxQJCGQax6y+AqF8aSuxngiv76HweiTcvDH9x5DPS/2EwfGcAjg43lv2hoOxdxH+Fqqqrm83QdmtV2R5Vfx672guGRbYPjid0K8FvhXk+E7tZ2V4DAQ9C07bhl/W4H7PejGdTDDsEsh01om+yHIcY9oIuvncYpzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9QuLMVW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y5cgNoeJdpoM4VQYvEYC5EosBRNndPbA0Cc9v1Wuchs=;
	b=j9QuLMVWNdNp8fd20wM7ipE8AXgk2H2WC2QLVVLF1CsNmsIriCxjnzFuiB1wfzSeK3WsDK
	iEInsfRhVUTAT/D2aaTAkija6ws6ieD0Rw06ZYf8XwUisHb8oM8WV65w6Uxg/3piu7LjT9
	T1yJmG8kkphlJixzWR/kWl9Bss7NbqM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 0/7] net: axienet: Fix deferred probe loop
Date: Tue,  5 Aug 2025 11:34:49 -0400
Message-Id: <20250805153456.1313661-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix a deferred-probe loop by splitting the MAC and MDIO functionality
into separate drivers. Please refer to the last patch for an extended
look at the problem this series is attempting to solve.

This is a rather large fix for a rather rare bug, so I have sent it
for net-next. The first patch is a smaller fix, however, and could go
via net.

Changes in v4:
- Fix documentation for axienet_mdio_enable
- Fix platform_driver_register in exit

Changes in v3:
- Use ioread32/iowrite32 directly in MDIO
- Use MDIO bus device in prints
- Use device variable to probe
- Rework to use a separate axienet_common structure, as netdevs cannot
  be reused once registered.
- Use ida_alloc for aux id

Changes in v2:
- Fix building as a module
- Expand commit message with much more info on the problem and possible
  solutions

Sean Anderson (7):
  net: axienet: Fix resource release ordering
  net: axienet: Use ioread32/iowrite32 directly
  net: axienet: Use MDIO bus device in prints
  net: axienet: Simplify axienet_mdio_setup
  net: axienet: Use device variable in probe
  net: axienet: Rearrange lifetime functions
  net: axienet: Split into MAC and MDIO drivers

 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  45 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 383 +++++++++++-------
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 158 ++++----
 4 files changed, 350 insertions(+), 237 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


