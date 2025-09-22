Return-Path: <linux-kernel+bounces-826633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E2B8F00D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB01189B828
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63443221D92;
	Mon, 22 Sep 2025 05:20:55 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6962A1C7;
	Mon, 22 Sep 2025 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518455; cv=none; b=G1DOnTAcVtDaAgqret/pSLHN3ygme2fZesM70oK3h2lQmGjC/rMS/jwgIl8WLd4JC0DppNw+8u9gkjF6oqXHjG1vmomBds7PN9hUeusiIPZTWVc1Qf+LJm6/h40AaZXE+fjckH0yTJ6DDRCcKn54w8NfmbH1r33OCrt7fNGVRt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518455; c=relaxed/simple;
	bh=ZH5AsAhuGQ1uxUSfAoXaCvGaqKTKQZDOvMHz3sQR5IQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CkFj9H6xEBwuyccEiluUibjk/mcMfiQBZjkpSjG8YNhmCrOq0utaeK8vhHiWhseat6k8U7g0ywtG8DFDrfcj/1fVSD7sjQID81SWFKoSx1LIwWdcaO2OPimAjPuK1ncB7p9yawVw2AMpjvXG7m5G7AYuPjX0TUYLfOI1bi9JV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 22 Sep
 2025 13:20:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 22 Sep 2025 13:20:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] Add Aspeed AST2700 uhci support
Date: Mon, 22 Sep 2025 13:20:41 +0800
Message-ID: <20250922052045.2421480-1-ryan_chen@aspeedtech.com>
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

v4:
- usb-uhci.yaml
 - fix errors 'make dt_binding_check'
- uhci-platform.c
 - remove IS_ERR_OR_NULL(uhci->rsts) check, due to reset_control_assert
   will return 0, when uhci->rsts is null.
 - use dma_mask_32 as default, and just add aspeed,ast2700-uhci for dma_64.

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
 drivers/usb/host/uhci-platform.c              | 31 ++++++++++++++++---
 3 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.34.1


