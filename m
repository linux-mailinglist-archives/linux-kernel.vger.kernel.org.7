Return-Path: <linux-kernel+bounces-881050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A559C274C2
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C41887908
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC2C1FA178;
	Sat,  1 Nov 2025 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ymqvfxk3"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2322FE15
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957922; cv=none; b=L4CDVBUICypDjR/aDC4Gxoy9qJ8rsXHcML73YURrbRM7OjpOv6BFLJX3Dxhrag4bg36ti02nnAbhJ/gdGHwDjDz77MBPA9jEBwEyNPK8qaDg3vR+Eib6drm6FZ52v0v+UW/pTAeSwQVW3mNz2IWwFmPmBOmLYPN5dRlNJMMCJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957922; c=relaxed/simple;
	bh=Fv2Q+Pc3Cbz9NsFabzY3O6hrENIlZ1AR/am3rMC1pOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsVsKbRdvJYGb0Y8twxinv4KXcRjL38qg0hq/zk7z6kGcuLhpASZr4xXB/tpoGxyX0BLAAeUVM262fK+AW1/7Qp4vDd71IC0P8s6akg2jLfDypkZUBZr8ct/WEWvdXkyRvO7MREdMzTaSCybCEtVxWSQuuhtcwZ4hB708PaWpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ymqvfxk3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC2DEC0E966;
	Sat,  1 Nov 2025 00:44:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 716296070B;
	Sat,  1 Nov 2025 00:45:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 578C01181ABD2;
	Sat,  1 Nov 2025 01:45:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761957916; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9ISPyZ2sYo5mkihKAAgI3YiQvJpREmCo2BpCfHsdfhg=;
	b=ymqvfxk33OYlO+xtgyrWu79Qgx8oXy/9ZGzbRxSJNXCADP0Xw7E6/rVfS4aAhflyTqOHkr
	xXpPCQUHdwk4LItydVCVP8naOCTzKgzKOGbh7dnVY4ZRjX5ae5uYHjLMb2IsQukNS2kU8h
	iY7Ikvt1FVpTxSZHnXZvGlXIqRqSY/k/HO3EQe4FR4PthMSdFalAEm8e3jnPyBiRIcmzux
	gyKGOH7BFkDrPq6Hhhjn2dhJlNr4+c0uYykLxYR3V4jRttmAp8EnuXDaHMR2BkW4Kk25Sj
	SkLBhVTId9vLO3fBlXMG220WT8U2td9kvwz/La+VK/+MRyyQVnBtcsIIP3q7NQ==
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Sat, 01 Nov 2025 01:45:10 +0100
Subject: [PATCH 08/11] rtc: rx6110: stop setting max_user_freq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-max_user_freq-v1-8-c9a274fd6883@bootlin.com>
References: <20251101-max_user_freq-v1-0-c9a274fd6883@bootlin.com>
In-Reply-To: <20251101-max_user_freq-v1-0-c9a274fd6883@bootlin.com>
To: Joshua Kinard <linux@kumba.dev>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

max_user_freq has not been related to the hardware RTC since commit
6610e0893b8b ("RTC: Rework RTC code to use timerqueue for events"). Stop
setting it from individual driver to avoid confusing new contributors.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx6110.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 7c423d672adb..07bf35ac8d79 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -324,8 +324,6 @@ static int rx6110_probe(struct rx6110_data *rx6110, struct device *dev)
 	if (err)
 		return err;
 
-	rx6110->rtc->max_user_freq = 1;
-
 	return 0;
 }
 

-- 
2.51.1


