Return-Path: <linux-kernel+bounces-754700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DBBB19B22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2DE176B97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9A226863;
	Mon,  4 Aug 2025 05:39:57 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FD4685;
	Mon,  4 Aug 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285997; cv=none; b=Nvf5oblFNKqLsHwJS+MSSl4iZlrWrCUxK0r1NvEvxgYZCBAuNHzu21CD7z0NDxVQYPYRADQyfcg9sC/kMUYcwGWnWAwObbGDyt3blxcvWEpKauyoOfaIX9igyBVwXBExR6sW1RHRLYHksgIWm3OL0Na4+juria+12gtyWHKCu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285997; c=relaxed/simple;
	bh=bhfHogJ8k+Oh4dZKGTCy3obIk3sq1GLgq405nsEW8qI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZLFOfyuMaB+ZQxsNbwwUv96eZyOwByaAupeF3n3P6Zs4R1wWR5T6TjRxkiYohJA2/kPyTTOMdzs8pYHJOR01xGc3EkuZsyLyORveW8vh4a9hFB9RkIg+klU7/z23wSGASjPJhRDhK6G0tbF9BNrH0RB4V1e4uXPBwElZAj4e2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 13:34:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 4 Aug 2025 13:34:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] irqchip: Add support for Aspeed AST2700 SCU interrupt controller
Date: Mon, 4 Aug 2025 13:34:43 +0800
Message-ID: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the SCU (System Control Unit) interrupt
controllers found in the Aspeed AST2700 SoC.

The AST2700 integrates multiple SCU interrupt groups, architecturally
similar to those in the AST2600, but using split registers for interrupt
enable (IER) and interrupt status (ISR), whereas AST2600 uses combined
registers.

Ryan Chen (2):
  dt-bindings: interrupt-controller: aspeed: add AST2700 SCU IC
    compatibles
  irqchip/aspeed-scu-ic: Add support for AST2700 SCU interrupt
    controllers

 .../aspeed,ast2500-scu-ic.yaml                |   6 +-
 drivers/irqchip/irq-aspeed-scu-ic.c           | 240 ++++++++++++++----
 2 files changed, 200 insertions(+), 46 deletions(-)

-- 
2.34.1


