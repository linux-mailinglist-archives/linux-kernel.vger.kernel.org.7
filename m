Return-Path: <linux-kernel+bounces-823935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A6DB87C35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FFF4E4B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15145264A9D;
	Fri, 19 Sep 2025 02:57:18 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2970258EE5;
	Fri, 19 Sep 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250637; cv=none; b=F5eG81oG4c6Ja0MDbmiZO3GBhBV5UDTCDfv95Y2f0IvKIIdQWzPFCk7F+eR2MTG0U5hFGSWTMGRChe9TdeslwIIQXh8bryeqHBR4NvN1LK8lLGezWZYSIxf1EQ+pIZtQiWhCEBWh3zZNjee/AbfCxgozz16cd+sdC7hlR1caJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250637; c=relaxed/simple;
	bh=yarhNUzH32uXxlfba0jvY1Z89DAEn2vSHci7xqu+dWM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7rpLeyfRl+Pepub1C5H5UDH2I6Y5HuU8SxW5CF8+OjJv7vhYh+VGX9tuGBehbKru59Fre7j2eIN+jXVXl8/5PviiELbqX2ApQstL7Wf5tvEaFHfgVrLS3//5F2AIcPk5bm7Xkjy8DyonQi4D70RhH2pkac0Fwe32T8bLL4qORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 10:57:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 10:57:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Add Aspeed AST2700 uhci support
Date: Fri, 19 Sep 2025 10:57:08 +0800
Message-ID: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the UHCI controller found on the
Aspeed AST2700 SoC.

Compared to earlier SoCs (AST2400/2500/2600), AST2700 UHCI:
 - requires a reset line to be deasserted before use
 - supports 64-bit DMA addressing

This series updates the bindings and platform driver accordingly.

v3:
- uhci-platform.c
 - add reset_control_assert in uhci_hcd_platform_remove.

v2:
- usb-uhci.yaml
 - add required resets for aspeed,ast2700-uhci
- uhci-platform.c
 - change the err_clk before err_reset.

Ryan Chen (4):
  dt-bindings: usb: uhci: Add reset property
  usb: uhci: Add reset control support
  dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
  usb: uhci: Add Aspeed AST2700 support

 .../devicetree/bindings/usb/usb-uhci.yaml     | 13 ++++++++
 drivers/usb/host/uhci-hcd.h                   |  1 +
 drivers/usb/host/uhci-platform.c              | 33 +++++++++++++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.34.1


