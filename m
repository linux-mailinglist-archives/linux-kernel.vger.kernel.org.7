Return-Path: <linux-kernel+bounces-773629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 118DAB2A2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF4C4E2F71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81B31CA72;
	Mon, 18 Aug 2025 13:01:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B61F462D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522094; cv=none; b=uQ2fjrSgl1mtdCNpNBqdF8euUXpjTfO3rgPofLPl7W0YxTtUb1uBtaXNOKkWHmMoaYm1fDQ4SkTXTkufGlx6jL5BDPMzApJYqSF42CIqi1lkyO2y3rLbaOCCDwH4RwKWTqisR4yUfKy4s540JNGqqH7pTCTcncXTLm/1XgeBJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522094; c=relaxed/simple;
	bh=6rQ6pnAUwzRAUX1Dhsh33y23lqaMyZglDlokiaRV8+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2HjUo9s0egt8LuT/LvE2GGNa1Ozm8kVk64ohssQMlcIg0+ZvQHrttF5uuvx5UOjKT55Etj4dO0plyanTjGmtEmQw7FqjsuUp2H7JtTyBaxCsp4O4rbZXkvA9r0MdpupHS3N5cCc5gRHwKt84ODMS4hXofoFNwZU9B0wulGISZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1unzUD-0003t7-OR; Mon, 18 Aug 2025 15:01:17 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1unzUD-000uE2-0I;
	Mon, 18 Aug 2025 15:01:17 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1unzUD-005swT-04;
	Mon, 18 Aug 2025 15:01:17 +0200
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: [PATCH 0/2] ASoC: codecs: pcm1754: add pcm1754 dac driver
Date: Mon, 18 Aug 2025 15:01:06 +0200
Message-Id: <20250818-v6-12-topic-pcm1754-v1-0-e1dd189ea99a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABMko2gC/x3MQQqAIBBA0avErBtQybKuEi1inGoWlWhIEN09a
 fkW/z+QOAonGKoHImdJch4Fuq6AtvlYGcUXg1HGKqcd5ha1wesMQhho151t0NllNtR7S15BKUP
 kRe7/Ok7v+wE+sECvZQAAAA==
X-Change-ID: 20250818-v6-12-topic-pcm1754-85fa2c9d5cd0
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
Alvin Šipraga (1):
      ASoC: codecs: pcm1754: add pcm1754 dac driver

Stefan Kerkmann (1):
      ASoC: dt-bindings: ti,pcm1754: add binding documentation

 .../devicetree/bindings/sound/ti,pcm1754.yaml      |  54 ++++++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/pcm1754.c                         | 185 +++++++++++++++++++++
 4 files changed, 246 insertions(+)
---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20250818-v6-12-topic-pcm1754-85fa2c9d5cd0

Best regards,
-- 
Stefan Kerkmann <s.kerkmann@pengutronix.de>


