Return-Path: <linux-kernel+bounces-843994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43528BC0CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78A13B9C16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BB2D47F4;
	Tue,  7 Oct 2025 08:58:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BF2D5921
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827505; cv=none; b=QOj0dSbsB+4zXX8NKQWiPQyWcMhNQd7+L+TbWjCzyY6P9HGxk4IDW2Ki7uMy74u1M2v+P9P2oOv8TiKF79q2Syd3wBo2bITHT7Fkcl81ndcqQPRgTFoV3kFm2mAGNIonpnnKc51+99vrbUgGzdfAvHfXXO3odu67BICX/bWOuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827505; c=relaxed/simple;
	bh=IrvxxkLwFABk4TiFDKEMMLnWLEBmHz3iXRRFiwaGMuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ltLFgw8cjx49snW+MGMBIBHHQtsnTK+27leZbfZ0+2qK7rWjic7Q8kvX+LR5inV1+cVbxqOtBg201Mcm9+LFTlPjKQDaSNRVgFtWYItNEzTQ5OrLIimIz739FRsdrnebEt+w41lko7AHemII826N4QWdRX9ocox+kf/KVoJTxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1v63WM-0007XY-Fy; Tue, 07 Oct 2025 10:58:10 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v4 0/3] LED: Add basic LP5860 LED matrix driver
Date: Tue, 07 Oct 2025 10:58:01 +0200
Message-Id: <20251007-v6-14-topic-ti-lp5860-v4-0-967758069b60@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrW5GgC/3XNQWrDMBCF4asErTtBGkmWlFXvEbqwpXEyUGwju
 yIh+O6VQyCL1sv/wXzzEDNlplmcDg+RqfDM41DDfBxEvLbDhYBTbYESrUQVoDSgDCzjxBEWhu/
 J+kZCj7Y1vmswuiDq7ZSp59vTPX/VvvK8jPn+fFPUtr5ElDtiUSDBoHemS9FZpT8nGi4/Sx4Hv
 h0TiY0t+KZsRXYorJRDitH3rWmT+5fSbyootUfpSukgnfbUh+TUH2pd11+nHCUfVQEAAA==
X-Change-ID: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steffen Trumtrar <kernel@pengutronix.de>, Pavel Machek <pavel@kernel.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The lp5860 is a LED matrix driver with 18 constant current sinks and 11
scan switches which allows controlling up to 196 LED dots.

This series adds just the basic support for the device on the SPI bus.
It is also possible to use it on I2C. The interface can be
switched/selected via an interface select pin.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v4:
- move to drivers/leds/rgb
- fix some upper/lowercase
- use ATTRIBUTE_GROUPS macro
- unwrap some lines
- Link to v3: https://lore.kernel.org/r/20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de

Changes in v3:
- fix c-styling errors
- rename functions/defines/variables
- split out ABI documentation
- rename [rgb]_current* to [rgb]_global_brightness*
- rework multi-led probing
- Link to v2: https://lore.kernel.org/r/20250514-v6-14-topic-ti-lp5860-v2-0-72ecc8fa4ad7@pengutronix.de

Changes in v2:
- add open and short detection
- add ABI documentation
- fix devicetree binding (maxItems/minItems)
- fix commit message to imperative mood
- minor cleanup
- Link to v1: https://lore.kernel.org/r/20250220-v6-14-topic-ti-lp5860-v1-0-42874bdc7513@pengutronix.de

---
Steffen Trumtrar (3):
      dt-bindings: leds: add lp5860 LED controller
      leds: add support for TI LP5860 LED driver chip
      Documentation: ABI: add lp5860 led matrix controller

 Documentation/ABI/testing/sysfs-class-spi-lp5860   |  23 ++
 .../devicetree/bindings/leds/leds-lp5860.yaml      | 111 ++++++++
 drivers/leds/rgb/Kconfig                           |  27 ++
 drivers/leds/rgb/Makefile                          |   2 +
 drivers/leds/rgb/leds-lp5860-core.c                | 222 +++++++++++++++
 drivers/leds/rgb/leds-lp5860-spi.c                 |  89 ++++++
 include/linux/platform_data/leds-lp5860.h          | 305 +++++++++++++++++++++
 7 files changed, 779 insertions(+)
---
base-commit: a32cf8a562e776ee75d4fa9432719e855d70fc03
change-id: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


