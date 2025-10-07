Return-Path: <linux-kernel+bounces-843996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E755BC0CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13BAB4E29A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6282D7DC8;
	Tue,  7 Oct 2025 08:58:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306092D7386
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827507; cv=none; b=RTBos/tGPYzcj+igEJ2/TsaSpk2tYbvfEfl091Owkri1Om3VWO12C+CNF6s41Re8sZNEnnrKkWm48C0pgEywnyXiqWrpsWpLXvYF7k80GGZCtKFY1n+B9LlvlAv1cWH7Or4fmOhq3KyPtnOy1xiufG2t5i4fG4HXjxkqJxhTAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827507; c=relaxed/simple;
	bh=s3kbGH2m7tYAq0Ru+MGjztJlEXICfIdT9WzMkCBCWFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1SHGz0ZEd1h4moDs175m5Pc1AGKzvhMygy2oqzGAKojcDSq2YnpncRTE9JyRxWLAtmhtJyVn3CTRYWwG+ZhlDbo4Lz+I+Utk0es9rAMzFaX1zZ8BxtoLHuSSgcHtP+c01Ospwzm2kPnJCuL8JjXyKKBj0vNj8M8R81kEGwYe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1v63WO-0007XY-Km; Tue, 07 Oct 2025 10:58:12 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 07 Oct 2025 10:58:04 +0200
Subject: [PATCH v4 3/3] Documentation: ABI: add lp5860 led matrix
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-v6-14-topic-ti-lp5860-v4-3-967758069b60@pengutronix.de>
References: <20251007-v6-14-topic-ti-lp5860-v4-0-967758069b60@pengutronix.de>
In-Reply-To: <20251007-v6-14-topic-ti-lp5860-v4-0-967758069b60@pengutronix.de>
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

The lp5860 is an LED matrix controller that can be connected to SPI or I2C.
It supports setting the maximum brightness of the three basic
colors (R,G,B) with a global value.

To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/ABI/testing/sysfs-class-spi-lp5860 | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-spi-lp5860 b/Documentation/ABI/testing/sysfs-class-spi-lp5860
new file mode 100644
index 0000000000000000000000000000000000000000..80b22a9d6642100a25efbf658cfed8604150baa5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-lp5860
@@ -0,0 +1,23 @@
+What:           /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/b_global_brightness_set
+Date:           July 2025
+KernelVersion:  6.16
+Contact:        Steffen Trumtrar <kernel@pengutronix.de>
+Description:
+	Contains and sets the global brightness for the B color group.
+	Can be adjusted in 128 steps from 0% to 100% of the maximum brightness.
+
+What:           /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/g_global_brightness_set
+Date:           July 2025
+KernelVersion:  6.16
+Contact:        Steffen Trumtrar <kernel@pengutronix.de>
+Description:
+	Contains and sets the global brightness for the G color group.
+	Can be adjusted in 128 steps from 0% to 100% of the maximum brightness.
+
+What:           /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/r_global_brightness_set
+Date:           July 2025
+KernelVersion:  6.16
+Contact:        Steffen Trumtrar <kernel@pengutronix.de>
+Description:
+	Contains and sets the global brightness for the R color group.
+	Can be adjusted in 128 steps from 0% to 100% of the maximum brightness.

-- 
2.49.0


