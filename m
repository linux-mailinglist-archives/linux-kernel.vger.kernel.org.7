Return-Path: <linux-kernel+bounces-818588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C06BB593AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691C04E2094
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27A2EA17F;
	Tue, 16 Sep 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JYGvdWVU"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38860303C87
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018260; cv=none; b=GLV0Q/+uNR08J522JLSFNB1z0HET+qUpnHH5r3ae1x/PTELtdntIjFkMn7YUPm9vimI8vZIUl3rYVmGQxeocQUbOfE29+y2S1z3L92REkhys96PxZsqyaqhX+dTZ+Sz5/IGFoI0MWtzmPAir8XW3xHE+DkzQgnHAhmb5a5iEFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018260; c=relaxed/simple;
	bh=UU/Il9qgUqeyEMGZumr+Zlcvwvbdz3o+XMKlW396uVY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kELu+OhZxZAmYknGzIym+wanwgnIA635Fev+677bVNXvYxZmlDohS5aynnIwjufkXQq/yM9d2Su3ZgtaS/z7Yx8Gw5yzH0TQ9ng2EzFW7nmHm4f6gmJmWB76iDc+JV7LAk1TQzthqxKnvIiTBiQ9qlArJMWlZDR8y5lFuD7U3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JYGvdWVU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 353DE1A0C11;
	Tue, 16 Sep 2025 10:24:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 096F26061E;
	Tue, 16 Sep 2025 10:24:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15D78102F16D4;
	Tue, 16 Sep 2025 12:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758018253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4KzDfp80Dzw2CTpAAfNCIAbjQ4ZVlMxWuyH9CtD5l14=;
	b=JYGvdWVU3yZsRdAlkLHmu8xkLWvKSaUXtFBeQmU7FDgFL+LHfEPMfrtbbn3jd+t4fL435U
	4OcypYk8D1VCrUyk6WWODX4GCJ9gD+XM0ksCbw6bLTognSaQyfbSzDjYUYuWqA/nuq0KUQ
	BTq2ato1jRfE7eN/98NzIjkxn9P0/gnV4cPNiWeoQ6T69YGGbkhA1zR6tKYagi80nNT9bG
	MGBmHJtYRDfvLSknK4tUZOdDX1YN+B/T4VqnT2U3FlH3uSxrsP5hDL87Ngta+0K64GOm38
	myv3meHgL3qyQ3PnbEIUx7hTgXKcvWvPC1QhpAvUoQY7vNOw8evh2vMCckWLFg==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH 0/4] Add support for the LTM8054 voltage regulator
Date: Tue, 16 Sep 2025 12:24:05 +0200
Message-Id: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMY6yWgC/x3MQQqAIBBA0avErBNUtKKrRAuxsQbKYowIxLsnL
 d/i/wwJmTDB2GRgfCjRGStU24DfXFxR0FINWmorez2I/T4GaY1YmB5koZQPzvRGyc5CjS7GQO8
 /nOZSPhbOHExgAAAA
X-Change-ID: 20250728-ltm8054-driver-11cfa4741065
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This series adds initial support of the Linear Technology LTM8054 voltage
regulator. The driver supports a fixed voltage and a tunable output current
limit using a DAC-controlled pin.

I'd say that the only unusual part of this series is the usage of the IIO
consumer API in a regulator driver. I think this makes sense here, since
the regulator driver has to access a DAC to read/set the output current
limit.

Since the regulator driver writes microvolts and the IIO consumer API takes
millivolts, the reads and writes to the CTL DAC have to be scaled by a
factor of 1000. Scaled reads are already supported in IIO, but scaled
writes are not, which is why I've implemented them in patch 2/4.

Please let me know what you think.

Thanks,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Romain Gantois (4):
      regulator: dt-bindings: Add Linear Technology LTM8054 regulator
      iio: add processed write API
      regulator: Support the LTM8054 voltage regulator
      regulator: ltm8054: Support output current limit control

 .../bindings/regulator/lltc,ltm8054.yaml           |  77 +++++++
 MAINTAINERS                                        |   6 +
 drivers/iio/inkern.c                               |  99 +++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/ltm8054-regulator.c              | 229 +++++++++++++++++++++
 include/linux/iio/consumer.h                       |  17 ++
 7 files changed, 438 insertions(+)
---
base-commit: f87c2b34768828c4ff535ba7d50dd938838caab9
change-id: 20250728-ltm8054-driver-11cfa4741065

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


