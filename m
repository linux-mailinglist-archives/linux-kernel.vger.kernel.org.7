Return-Path: <linux-kernel+bounces-816266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFAB571B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897343A70AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0D2D739B;
	Mon, 15 Sep 2025 07:39:36 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222702D23BD;
	Mon, 15 Sep 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921976; cv=none; b=Z4IpS7jPGiejmN1TgCMJNwXWtJGVca/Q9io7+Tn9FZvnVjZ77ZlL3rnJGgwZm+pBjiWg16ZT94Tiz8atuPBTH8bk/IoUR6+D84/Tj0SUjTQM54y4nui9RJ0CQE+aNX/tFl5rL3lu5QodLK/9MR2huWN9laqL+1mCKE7p77diqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921976; c=relaxed/simple;
	bh=pJUMi9CBgVizV0CeN3q/a16QPGTUOyQqDnvy4l24BTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q5nekak6vzLb25qxPjs0inVp+vnVdqOfPfodM01PBR/u/AW9E3eN1Tdl18pGBQD9XjzyZEuj9B9ppD3XxnAhFB44H1OqBTaiCnG99Al4VS7HSylvL36COOpfnqJDD3vpptXWRlCM5LyyezdBWXCHQjXT8F//DxcFO6rxn56b15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 15 Sep
 2025 15:39:26 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 15 Sep 2025 15:39:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add Aspeed AST2700 uhci support
Date: Mon, 15 Sep 2025 15:39:22 +0800
Message-ID: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
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

Ryan Chen (4):
  dt-bindings: usb: uhci: Add reset property
  usb: uhci: Add reset control support
  dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
  usb: uhci: Add Aspeed AST2700 support

 .../devicetree/bindings/usb/usb-uhci.yaml     |  4 +++
 drivers/usb/host/uhci-hcd.h                   |  1 +
 drivers/usb/host/uhci-platform.c              | 34 +++++++++++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.34.1


