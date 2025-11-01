Return-Path: <linux-kernel+bounces-881048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47715C274CE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88831422697
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542423B62B;
	Sat,  1 Nov 2025 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D9E/bU3H"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB7223DD5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957920; cv=none; b=HCH/sKt6kDXXguXK9tMd9ORE4EIF4AC5pmTaQQXhjbAPlKX8F9A0JIqZpo4WNGp0xozXkM8v6T6MuojJ7hD9/RXFs1QtBzfNcaIErr921wZCfypriWkKhcAVXTNOGL2JOdG9z8AbFnvEUw/AyOOBd2U/2rCkpInkwZdry+2LQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957920; c=relaxed/simple;
	bh=GobNp8G3Ev64l8yEWW4+TcrOQJ0KYKgHNjJ650ShNLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nScdKFqhyTWJIxcqHKkiUfvv+w9tPMnIPQ+vWl1cb2HVxwXzcZ+qfzZpkQOJNj48Kha5hs+KVGMmQ+D3wLQ3/a9CcolG/gQAyiu6L5/SXZxDbcHKtxqVMaFm8DWYNJN1N3ho61p2cnl4PWALf+aDTwud/xeYOkNPgOeaAUKApto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D9E/bU3H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7CEC94E4144A;
	Sat,  1 Nov 2025 00:45:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 541596070B;
	Sat,  1 Nov 2025 00:45:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 714351181ABB0;
	Sat,  1 Nov 2025 01:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761957915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9O6YhW97T7eOntyjEzyP3IadqCae0DdHScd0olQJcs8=;
	b=D9E/bU3HKp7S33VJgVZJJmODBSAty3I8mpo9/hPz5ga4i79ZkBr1oR44RuSr1bpo/gHany
	nDNbjwBaoR0JG2v35CEAc+KYm3l8cNfE2WejkncCAIQZUZoenmggZYrOkgVQhPsVmTQjtA
	srbKryRJyAqVj8m7KJ/Sv/HSjSJwSnca6zbUsrbDUsJ8Jkj5XsqM8vsy/PcPMzGI91jWLz
	p14YfA19KAVjroOl6AODmLaufI8Hsia2FBe1+TjhgGjyrFdP1miKVrym6TEboulOeLEHYM
	QR8YoTmaJBF26DmGepNchaqpJ9mi7JqJ2rkaYDWJ3FnLWl2qv0NXSLtcU92dmw==
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Sat, 01 Nov 2025 01:45:09 +0100
Subject: [PATCH 07/11] rtc: rv8803: stop setting max_user_freq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-max_user_freq-v1-7-c9a274fd6883@bootlin.com>
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
 drivers/rtc/rtc-rv8803.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 1327251e527c..4e9e04cbec89 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -738,8 +738,6 @@ static int rv8803_probe(struct i2c_client *client)
 
 	devm_rtc_nvmem_register(rv8803->rtc, &nvmem_cfg);
 
-	rv8803->rtc->max_user_freq = 1;
-
 	return 0;
 }
 

-- 
2.51.1


