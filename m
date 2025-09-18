Return-Path: <linux-kernel+bounces-822165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1CB8332E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC43722A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BAA2E5D17;
	Thu, 18 Sep 2025 06:49:30 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8F2E427C;
	Thu, 18 Sep 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178170; cv=none; b=sUW+PrBPQR+YyQKTnCwPdL5/jXgXdyKXu2keQp3g2zqOuJGru9io7RDzGK9/TzTxyjutPOc/tAE4S3Z9i4Szx6JC4KEiu6C7etTMgIHyimO0KrEVMRknoTw0poOSr9yMSd4zDD+Gv+dNxcH6ImlNE3ANUldxNnNUIpTRiHvcixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178170; c=relaxed/simple;
	bh=XBAuU3SFJiAYeAp6r5akTSGa5THpegd77PNHa3Oz1RM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVl3ftDo1Onw7MXHJMLyBM8cg730uZNVxvoDIbzGGwsPtWa0oS1WpVtuNotOzZ/kGaIfKlnZ3NFqymd+Au9CSyAHe6uljsQETATrp+j3Q7gqK/inUuB4OgcZwU1hdIWgEXxnT0RX8/Dnp/QdY1OfcWMuryNPakMmVXKDupcmmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 14:49:19 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 14:49:19 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add Aspeed AST2700 ehci support
Date: Thu, 18 Sep 2025 14:49:17 +0800
Message-ID: <20250918064919.224927-1-ryan_chen@aspeedtech.com>
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

Ryan Chen (2):
  dt-bindings: usb: ehci: Add Aspeed AST2700 compatible
  usb: ehci: Add Aspeed AST2700 support

 .../devicetree/bindings/usb/generic-ehci.yaml |  1 +
 drivers/usb/host/ehci-platform.c              | 26 +++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.34.1


