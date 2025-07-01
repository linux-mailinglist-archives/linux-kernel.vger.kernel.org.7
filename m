Return-Path: <linux-kernel+bounces-711203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA18AEF792
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA8D16D4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E4283689;
	Tue,  1 Jul 2025 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Gh2oMzmq"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63A283128;
	Tue,  1 Jul 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370652; cv=none; b=Aa9LtSM5cj2a6PoT0aZwoyiPpjSNukUf942bSwL/i8SPIj7ywuvjf0l6l2VLRsqzkezB2LPYRo1F3od715B6QA/vTIP5tWhWVHBLbN5OuFXsFUz76OR3vJ83cUzaZsDjDyODEHHdDI0yJ6zxC4xSeKglVFUg7fctxgAnlstrmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370652; c=relaxed/simple;
	bh=6FJ0+qzy8kGCwdfloTTbqs+b10xzGGPR1Y78CzrKzO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOm7Dc4+SSECSNlFvUlcCKPVZji1tvIIRw811qa55Y9W1MUjEl7+GvkP+r76WKYtQs+o+uHpSpFBtcjCoBGl1ajTT4kZ1N+WauNmJqLUAKS29bSXUQNV1I4pnXlNT02CUAAjXKt+H+SCvKbC8WVcwfnJATsIuxFVqbTY5+b0wLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Gh2oMzmq; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEED6103972AB;
	Tue,  1 Jul 2025 13:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751370647; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZjpXei11sZqko3mrnHeBKkfQuI9xs36ulJ4JU6z/E6s=;
	b=Gh2oMzmqzw0HGKxgkR5rHtXpI+TuvYbd//kIvUM1VjTNVPYGHI7fWNKEwHQmeWnVNmAuGa
	b8MXJLBruc3tXV7CPkiz5ddorjqzGMcxEs4kQ38roq1Esli94hAIq7ysWqH2G79m95ib23
	oY9D87L4E83at1aztXspfphJxlpvAruSQPlDUyfBqtgHSRVy478lZQByOsBR2H3HoMencj
	be5dbpK2bmCMHBJPNPwkgsORM/94H7rNCho7Mw0IaxUWzz7PaQo26wOySnLsaRnJdsMmHO
	HANfPzNBIW/M+HeluknGJYLnTP+MXEpwZGqeecgoNldY5dKpEcTTGA+9HmMwGg==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v14 12/12] ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW to support MTIP L2 switch
Date: Tue,  1 Jul 2025 13:49:57 +0200
Message-Id: <20250701114957.2492486-13-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701114957.2492486-1-lukma@denx.de>
References: <20250701114957.2492486-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch enables support for More Than IP L2 switch available on some
imx28[7] devices.

Moreover, it also enables CONFIG_SWITCHDEV and CONFIG_BRIDGE required
by this driver for correct operation.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
Changes for v4:
- New patch

Changes for v5:
- Apply this patch on top of patch, which updates mxs_defconfig to
  v6.15-rc1
- Add more verbose commit message with explanation why SWITCHDEV and
  BRIDGE must be enabled as well

Changes for v6:
- None

Changes for v7:
- None

Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
- None

Changes for v12:
- None

Changes for v13:
- None

Changes for v14:
- None
---
 arch/arm/configs/mxs_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b1a31cb914c8..ef4556222274 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -34,6 +34,8 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
+CONFIG_BRIDGE=y
+CONFIG_NET_SWITCHDEV=y
 CONFIG_CAN=m
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
@@ -52,6 +54,7 @@ CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+CONFIG_FEC_MTIP_L2SW=y
 CONFIG_ENC28J60=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
-- 
2.39.5


