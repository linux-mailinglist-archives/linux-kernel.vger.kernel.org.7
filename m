Return-Path: <linux-kernel+bounces-780300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB51B30031
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C38AA26AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C42E0923;
	Thu, 21 Aug 2025 16:32:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C32DEA72
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793928; cv=none; b=S9vJiCW+xGGfDyyMd1zJpnMgZj6XPcl/yxv7bKEsCFtS7SHaI9ZgZi/JGP4jgEsmpdW6l18brhNaREMyt4xOdEpOqlM/+hFRvsCYEMadQRmWx0IB9lBqJTLMe9SPtH5gtamYUQ6Wl9UsMMa+GWYXUoWHrKDQS74gCfeDyp8QDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793928; c=relaxed/simple;
	bh=tAfVxwRPvahk2ZkXdPSsjANI+nDUKTHt6qSKiUko3uE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fzl7PA44grwrIh/2b6V8tD1oBsWzVrbLjfXA5zuzT7MMC3ghCNhJl3RFCm9q9GMpzymkv21jbReQhRBMKqzdAgAlhNpVbhbA7dSttOw84MNzuNzLR+NfVnFKyis1WPS/Uhdf5EmBgxnI1MPJHHptnISQsQvsuIHU///MOBolHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1up8Cj-0004O7-Hd; Thu, 21 Aug 2025 18:31:57 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v3 0/4] Add ext. port vbus handling for onboard-dev
Date: Thu, 21 Aug 2025 18:31:54 +0200
Message-Id: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpJp2gC/x3MQQrDIBAAwK+EPXdBTSLSr5QeNLtp96JBWwmIf
 4/kOJdpUDgLF3hODTJXKZLiwPyYYPv6+GEUGgajzKqc0Vgtaou/dMiG/xIwxZB8JiSuGBwtpMl
 55SyM4ci8y3nvr3fvF+o1iTZtAAAA
X-Change-ID: 20250821-v6-16-topic-usb-onboard-dev-b8d4d1d8a086
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

the purpose of this series is to make it possible to switch the vbus of
the downstream ports of an onboard-dev hub via ext. host controlled
regulators.

Changelog:
v3:
- fix dt-bindings issues

v2:
- Link: https://lore.kernel.org/all/20250327172803.3404615-1-m.felsch@pengutronix.de/
- fix compile time errors in case the module builds

v1:
- Link: https://lore.kernel.org/all/20240807-b4-v6-10-topic-usb-onboard-dev-v1-0-f33ce21353c9@pengutronix.de/

---
Marco Felsch (4):
      usb: port: track the disabled state
      usb: hub: add infrastructure to pass onboard_dev port features
      dt-bindings: usb: microchip,usb2514: add support for port vbus-supply
      usb: misc: onboard_dev: add ext-vbus-supply handling

 .../devicetree/bindings/usb/microchip,usb2514.yaml |  6 ++
 drivers/usb/core/hub.c                             | 55 ++++++++++++-
 drivers/usb/core/hub.h                             |  4 +
 drivers/usb/core/port.c                            |  6 ++
 drivers/usb/misc/onboard_usb_dev.c                 | 95 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h                 |  3 +
 include/linux/usb.h                                |  3 +
 7 files changed, 170 insertions(+), 2 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250821-v6-16-topic-usb-onboard-dev-b8d4d1d8a086

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


