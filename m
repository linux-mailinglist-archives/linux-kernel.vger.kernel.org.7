Return-Path: <linux-kernel+bounces-740603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E968B0D652
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F161E54098B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B52E040F;
	Tue, 22 Jul 2025 09:52:01 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87C2DEA9D;
	Tue, 22 Jul 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177921; cv=none; b=hYhz7xVWEvYPBhDWyCMfispfPNxsEOwwp8WvIsRBpwf7zZzQO9/kYyvdR8zletm33ibThJvrAzQlk5JYSlL5jj7mqLcqvpaTxnv2Xj7kScFl0FSWzcsyJWArYYfODKHjCRMKr1BYpzd+OBRG59Us0DsE5tm6tzBMo0HA+jp/CDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177921; c=relaxed/simple;
	bh=PT53kWuiP2WqxLGSJ4oCc+1vLX6oy7vXbe/AGWMwlV8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBxewmbpX8fAkPIwRaeNyL7/oneioYHOsBRC8zgOVSPKq2apJc0OcHuae20SqyJazm2DX82ex0sbVtaNs95eH/cR8VvtqwZgl47LZIIjaGYW+8XtSzZ2bvsm28q51dKbk0CB7J1YMyAD1iOBSR2Yas6V3+N3OQE+DbolGlHzIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 17:51:56 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 22 Jul 2025 17:51:56 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v3 0/2] irqchip: aspeed: Add AST2700 INTC debugfs support and yaml update
Date: Tue, 22 Jul 2025 17:51:54 +0800
Message-ID: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This patch series adds device tree bindings and driver support for the
AST2700 SoC¡¦s two interrupt controllers (INTC0 and INTC1), along with
debugfs entries for runtime inspection of routing and register protection
status, and bindings example refine.

v3:
- aspeed,ast2700-intc.yaml
  - improve commit message description.
- irq-aspeed-intc.c
  - add platform driver for "aspeed,ast2700-intc0/1" compatible nodes.

v2:
- fix dt bindingcheck

Ryan Chen (2):
  dt-bindings: interrupt-controller: aspeed: Add parent node compatibles
    and refine documentation
  irqchip: aspeed: add debugfs support and AST2700 INTC0/INTC1
    routing/protection display

 .../aspeed,ast2700-intc.yaml                  | 158 ++++++++----
 drivers/irqchip/irq-aspeed-intc.c             | 238 ++++++++++++++++++
 2 files changed, 353 insertions(+), 43 deletions(-)

-- 
2.34.1


