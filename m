Return-Path: <linux-kernel+bounces-895765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CCC4ED6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BC118C26A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E2369994;
	Tue, 11 Nov 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRLciHpY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B626E146
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875948; cv=none; b=mCjl690K5Hd6UVJNAsMzvZ8lEol21O1FJYg42ARfV+JE16bTjYcnbKZP4InfAGoGgQYKH/vpHtm3XYYc2e0ILXkxzclSOVKcnT4HAiluziYmKz2nWDwvcLao8MsbyFMOr2xspEKjkzuEA/r0+HdTcfDSsVVuZqkbqRFysudEcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875948; c=relaxed/simple;
	bh=yd84n8VJ2AqccGgReruEJ8scVcPeApNi1qKo7OD/Izc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOkquLYCOQja45sr8gQi8wSTBdogAPVdzpXJ3diTXhMgERn8hToiEFaVipCakDe856uryQMFkNsHORg3Eom7vUH3+H2aRVaIK0xCIO1xmrFfqpbacY6TTV6xrzSNdO7aky5L93gUedwsuWXFOxhtz/NwFhHg901P8DRLIcaIfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRLciHpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CF9C4CEFB;
	Tue, 11 Nov 2025 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875947;
	bh=yd84n8VJ2AqccGgReruEJ8scVcPeApNi1qKo7OD/Izc=;
	h=From:To:Cc:Subject:Date:From;
	b=QRLciHpY16lx4ROLHLdBSAxkpRhles14ZiOQwaqMee9hg+vLKEmR1YtgMOvhX3tJI
	 bYOxtCEkL1qRR3RAvhw+nnADC8LuLRro4TV6R/rNl+OlUXmr6uTlA2fGQJrJhM4IUs
	 l/xUvd+FEIrImjQr1nQ5cpmXjNVeqp0qZ+nJofQFeI0kO4tHmZEqs8ycjnfqw8jJpw
	 TEB2eQhDOReyre3PskfT1Po9Z8qHlbgwp1f1Ppas9qTsZD+HKO6EkpvllQCbbvrBsi
	 97MwGFb1Ak461NkuDmKmBjOD0X1SgBpIFxY/55g2Tqxs4X/OJQFV9rjKsiMhGQevZE
	 YJGwXVDaC++Qw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIqZ3-000000000S7-132D;
	Tue, 11 Nov 2025 16:45:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] clocksource/drivers/stm32-lp: Drop unused module alias
Date: Tue, 11 Nov 2025 16:45:16 +0100
Message-ID: <20251111154516.1698-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver cannot be built as a module so drop the unused platform
module alias.

Note that platform aliases are not needed for OF probing should it ever
become possible to build the driver as a module.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/timer-stm32-lp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index c2a699f5c1dd..3d804128c765 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -289,5 +289,4 @@ static struct platform_driver stm32_clkevent_lp_driver = {
 };
 module_platform_driver(stm32_clkevent_lp_driver);
 
-MODULE_ALIAS("platform:stm32-lptimer-timer");
 MODULE_DESCRIPTION("STMicroelectronics STM32 clockevent low power driver");
-- 
2.51.0


