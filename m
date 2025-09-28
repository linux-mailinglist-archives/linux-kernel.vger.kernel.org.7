Return-Path: <linux-kernel+bounces-835171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F15BA66F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7600B189A0DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C072550DD;
	Sun, 28 Sep 2025 03:24:19 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5413A86C;
	Sun, 28 Sep 2025 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759029859; cv=none; b=gCn3gW1ieuSY9pd7yjxL9IXThRO6b/Pu94SEN74kYSGT6+5eZVAr8t1kYaol7iFWROTAxNEXSoYn5XztT0k2CFzfyAZ6L6S7xnkcmQnjoi3Zxyu6vmbxPXuAvFIbDZ4RZQlrXII4beE9Zcvtg2X2brMcURP6aAdvuBUoV6UZ4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759029859; c=relaxed/simple;
	bh=fXWIhwLv4hKpybTOVGv/npLVWZ8qkRWZcnby1MvkMuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HjCKfrpcpiaFKjziJNwdZiqmh8b+b3Afc5QwjNHbBB29lhIbXBe73Nn5LkoiBAxkvQY98MiiOIYvFUpWwTEtLL9+TGD0nFOMFwRLUqkg3OupKd4340XR16tcZXK/VVgDGzppJeUgW/0IlGS4tsbjZOyHarMHQofbNNqU578N9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 28 Sep
 2025 11:24:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 28 Sep 2025 11:24:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add Aspeed AST2700 ehci support
Date: Sun, 28 Sep 2025 11:24:05 +0800
Message-ID: <20250928032407.27764-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series adds support for the EHCI controller found in Aspeed's
new AST2700 SoC.

v3:
-ehci-platform.c
 - Using dma_mask_64 as a local flag rather than modifying the global
   defaults, to avoid unintended side effects when multiple devices probe.

v2:
-ehci-platform.c
 - remove ehci_ast2700_platform replace by of_device_id data for
   dma_mask_64.

Ryan Chen (2):
  dt-bindings: usb: ehci: Add Aspeed AST2700 compatible
  usb: ehci: Add Aspeed AST2700 support

 .../devicetree/bindings/usb/generic-ehci.yaml     |  1 +
 drivers/usb/host/ehci-platform.c                  | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.34.1


