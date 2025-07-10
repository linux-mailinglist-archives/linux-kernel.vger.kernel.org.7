Return-Path: <linux-kernel+bounces-724788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BFAFF6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09ED5852E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97527FB15;
	Thu, 10 Jul 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b="n+Njsxc6"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C3824A3;
	Thu, 10 Jul 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115360; cv=none; b=KYW9ZoBvcJ7+ChppUEY901sHfFZPoDCb7rT3G7pyvUXKY2Brmkk+iPhgZO9BqPnCZuQm1dHxWNkm7+/tyjxH4d9FOzZ2kp/Lelac7clb0jDHLJia+8oyzoyTGTTozrkAj7634K83dKsmqs6pQ7gj4CeHBZBr5xsZrih4lNqJHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115360; c=relaxed/simple;
	bh=decLF4ryDzjQb5GPqB3kXj+yiJyVIn9WhIbk/QEXMt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5wXNo+ZUskfoGdk4jpGvG1djQ5NZClGOv+JlWnj8IfWDRnP4kH1DaN/AgDnOd8o3gF+/oi5TpMW1XHxddL46XnGVayd9nRpSvtyEQzWr5ykHnWimkVsiZco9Gd4WNDIEgxsJjGPNwiSjpXGUqQPvzXIwo/sT8ivKKvWAzlzBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com; spf=pass smtp.mailfrom=lab126.com; dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b=n+Njsxc6; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1752115358; x=1783651358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k/JkFDUEEvCJB0Q7R+nhA1YH1qvEqWEUh6x5/D78kGM=;
  b=n+Njsxc6ziRpQVjkRMvHB3/P0pQStBBIbvqRA9/X+GfXxqCgqedlg4NQ
   ckyBufS9fxvCOIriDWjvcLULmeobcs/TR73hpOGwxnULzNHLMCdrDc/aI
   eIn90qfwBU15P7Fcjh3ZZd6SqY1VXzuw2OEOOr5tRaGPj8i5TBUYkCHet
   xMmmLhHGCj7bkw5IIb9FJ8XfvU/gMF1qy1UlSH1Bg9XYvXISZug/fTzO+
   Vvc0O8X0TK6GV48rdLi5LPq/0NWrdZLO6MjgWT9d4SmUWE37ZUrHQ88d0
   BsKEnUasQ241I7o0TzzL8Q5z+AEchmPVJ7rMDz1wcWUaKo5WVz6MewS/t
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,299,1744070400"; 
   d="scan'208";a="217757191"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:42:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:2059]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.102:2525] with esmtp (Farcaster)
 id 0ba25972-6b97-43c7-be3f-b83544113701; Thu, 10 Jul 2025 02:42:37 +0000 (UTC)
X-Farcaster-Flow-ID: 0ba25972-6b97-43c7-be3f-b83544113701
Received: from EX19D007UWB001.ant.amazon.com (10.13.138.75) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 02:42:37 +0000
Received: from u1cb251c9c70150.ant.amazon.com (10.68.99.17) by
 EX19D007UWB001.ant.amazon.com (10.13.138.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 02:42:37 +0000
From: Karthik Poduval <kpoduval@lab126.com>
To: <jyxiong@amazon.com>, <miguel.lopes@synopsys.com>, <anishkmr@amazon.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: Karthik Poduval <kpoduval@lab126.com>
Subject: [PATCH v2 0/2] Synopsys DW DPHY Driver
Date: Wed, 9 Jul 2025 19:42:19 -0700
Message-ID: <cover.1752106239.git.kpoduval@lab126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D007UWB001.ant.amazon.com (10.13.138.75)

v2: fix dt_binding_check errors

Karthik Poduval (2):
  phy: dw-dphy-rx: Add Synopsys DesignWare D-PHY RX
  phy: dw-dphy-rx: Add dt bindings for Synopsys MIPI D-PHY RX

 .../bindings/phy/snps,dw-dphy-rx.yaml         |  44 ++
 MAINTAINERS                                   |   7 +
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-dw-dphy.c                     | 575 ++++++++++++++++++
 5 files changed, 638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
 create mode 100644 drivers/phy/phy-dw-dphy.c

-- 
2.43.0


