Return-Path: <linux-kernel+bounces-732523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D234B0681A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805345665BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB612C15B5;
	Tue, 15 Jul 2025 20:49:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D12C08AB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612564; cv=none; b=mBz7fhkdC4hkvHi+5QRFgDmQp4VUi39i02S/nEcEXUSjsKOkSlxHazARhcq9mb3VYUpPT56ZZKff9GNSjz2fjK0XEhVP0jCnG/T3NHAMwBIhzSbcvEftTmMltNPmkmgBLFtrFV2aDX2fWWyRqb1MsTw/TOYoCStyII9Nam7d/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612564; c=relaxed/simple;
	bh=lhJpN07PiYdEWqK0NiB89r9JuspR5OV+4EbzgNtHfe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gO5vtYSE8yJ1AcIp/vfhIouhcxIAQ+N1bD6wfgKfcXlBjXSbU7MHBLnOxrnMKx9zyXh94vs32nxEkfbf0+YzmZm2SluzB7OTFUGKuCglVsDPV3L5ROcsY+NJ8CA+lcOdc7UMnt8orxnyQm0HTKJQiWTPANpT2Dzb0XfQMUdBc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1ubmaI-0008KV-Bz; Tue, 15 Jul 2025 22:49:06 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/4] ina238: Improvements and INA228 support
Date: Tue, 15 Jul 2025 22:48:59 +0200
Message-Id: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALu+dmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3cy8RCMjC92UlCRTU1ODlOQkI2MloOKCotS0zAqwQdGxtbUA6ly
 zkFgAAAA=
X-Change-ID: 20250715-ina228-ddb5550dcb23
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=lhJpN07PiYdEWqK0NiB89r9JuspR5OV+4EbzgNtHfe8=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsgo27c/3vBTk7PiJI7ZXLMWSgjd0BaZwRF0NIMtPEC+Q
 F/lU6pJRykLgxgHg6yYIkusmpyCkLH/dbNKu1iYOaxMIEMYuDgFYCKXCxj+8IoJLTVdtt1/g3Ls
 6RTVNz9n7nyzfJu4x1zmSSeWc+6W+cTIsKOxsbpD7cDP0oz45a/+TQucHrW45OrN80yiX57fcSo
 8yAYA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series includes:
 - Whitespace fixes
 - Add labels to voltage inputs
 - Support INA228 ultra-precise power monitor

Tested on the INA228 chips on a TI TMDS62LEVM.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Jonas Rebmann (4):
      hwmon: ina238: Fix inconsistent whitespace
      hwmon: ina238: Add label support for voltage inputs
      dt-bindings: Add INA228 to ina2xx devicetree bindings
      hwmon: ina238: Add support for INA228

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   2 +
 drivers/hwmon/ina238.c                             | 155 ++++++++++++++++++---
 2 files changed, 135 insertions(+), 22 deletions(-)
---
base-commit: 27b297ca04813623d8df2f79d141d51e0856810c
change-id: 20250715-ina228-ddb5550dcb23

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


