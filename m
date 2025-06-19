Return-Path: <linux-kernel+bounces-694610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C110FAE0E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 22:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AABB4A2A37
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8628DF39;
	Thu, 19 Jun 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmxbdvok"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2128D8E5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363566; cv=none; b=exlokfRXlYUfirB3UsYc8ISHe56MTB2TK9WQpDazzQt7MiE/Rh1zqhavYPttJx3kFSVD/LNlMziVeCpah611SxDNMflc5PLoFvA2+7HJPiJcOjRN5DX72h7MOnFUfkAauRJZu+dTvnUj98Ba6AuuiSTrjO7qhZACom5lMsBY1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363566; c=relaxed/simple;
	bh=Tfp6gAZi43PgXDWt03VJuzciXXNPSM+sNASdp1HmgFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qj4ogRsi2iqacQnV293wiTFQ6vORk8wEfukn8Pm6OIX98eU6zbg5uaP2RPUjloFakimoqHv9pN7AmXVcl4OMf39lBC15cWWBxTzGvXPnwNcDttVWrjnDE5CfNEOmvp+ckM5YLGDk/v4iZE+iSRHmxZP54Aio4vgM/xhqyC4fxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmxbdvok; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750363552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M/g9Vf6hGrZ0hKeM12773wdkTtg+QQVjZhEkToI9s24=;
	b=vmxbdvok0oeIu97UhN4ME1QvM59me5wXNZCvXxVOLMEyru5H2xj63UFPBnjg7S260w2yeM
	L2bT/Q5tVHE8qNB+5LOuztv+X02i+Qyj72yK6m6qhK+5QW0jvnCiqNPJ0bH6oakg+TEBn5
	z5wsdIUGSpiCEB95IaI/p4j5Q/DTsmQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH net 0/4] net: axienet: Fix deferred probe loop
Date: Thu, 19 Jun 2025 16:05:33 -0400
Message-Id: <20250619200537.260017-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Upon further investigation, the EPROBE_DEFER loop outlined in [1] can
occur even without the PCS subsystem, as described in patch 4/4. The
second patch is a general fix, and could be applied even without the
auxdev conversion.

[1] https://lore.kernel.org/all/20250610183459.3395328-1-sean.anderson@linux.dev/


Sean Anderson (4):
  auxiliary: Allow empty id
  net: axienet: Fix resource release ordering
  net: axienet: Rearrange lifetime functions
  net: axienet: Split into MAC and MDIO drivers

 drivers/base/auxiliary.c                      |   6 +-
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 391 +++++++++---------
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c |  32 +-
 include/linux/auxiliary_bus.h                 |   4 +-
 5 files changed, 234 insertions(+), 200 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


