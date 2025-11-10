Return-Path: <linux-kernel+bounces-892424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B80C45102
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 213904E6368
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758292E8E16;
	Mon, 10 Nov 2025 06:14:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00A227B9F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762755277; cv=none; b=tqvvja0JWt6nvNlpzBn7MrcZDDUrXyDEj+ZT5ihNFru4rQX1l+p1zvCIjdnkgHcn4dU9FPS13z7U2NU7JTyIf3GOXX+tfLrGyLwh/gcDsCtBwWMoJ6QzBlE9yX2/eVUXwzHiATj/Y5qsPy9ZcV2VD+jFrO3wc/OROdGWdw0jzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762755277; c=relaxed/simple;
	bh=L8/CpPKWWPySrKx02hV6jeIMbMHbHQsXvc4oCZUOP6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVQkg6wS/c2kbjZs+wdH6M9LcBwJw+kGK0ADpUd40FyV70z9yeFM6IfbkQWU+Vpb0g8A+We1zRbZVb+uX1T/zWxeBUfhB6GmWKkSeLTxOAuPF3ier77E75Xos4APTYBETynLl4Sdah5EQK36d+PQEEYcf0opXkEhGV0hrRz/DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vILAL-0002LY-G6; Mon, 10 Nov 2025 07:14:13 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vILAK-007y73-2O;
	Mon, 10 Nov 2025 07:14:12 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vILAK-000000032sn-2p8V;
	Mon, 10 Nov 2025 07:14:12 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 0/2] iio: adc: Add support for TI ADS131M0x ADCs
Date: Mon, 10 Nov 2025 07:14:07 +0100
Message-ID: <20251110061409.726028-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series adds support for the Texas Instruments ADS131M0x family of
24-bit, simultaneous-sampling ADCs. The first patch introduces the
DeviceTree binding, and the second adds the driver itself.

These devices are not compatible with the ADS131E0x series despite the
similar naming.

David Jander (1):
  iio: adc: Add TI ADS131M0x ADC driver

Oleksij Rempel (1):
  bindings: iio: adc: Add bindings for TI ADS131M0x ADCs

 .../bindings/iio/adc/ti,ads131m02.yaml        |  220 ++++
 drivers/iio/adc/Kconfig                       |   10 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ti-ads131m02.c                | 1063 +++++++++++++++++
 4 files changed, 1294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
 create mode 100644 drivers/iio/adc/ti-ads131m02.c

--
2.47.3


