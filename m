Return-Path: <linux-kernel+bounces-875618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5FC19712
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598B8465A39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E8330B38;
	Wed, 29 Oct 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="apECCSAo"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0ED2F7AAF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730774; cv=none; b=AzGovidSk6C1BapKGzjCYt3MyGoWCG7yltZF60+/mYDmCZp75yiaBZPyRGZVDJOW7nJVSdfzbppwor7NPrb5pnfy7ngHASMEH5wjD5n7yrAJrOddODxAAZX2NioFfuqCJk7W+KKDoQv3h4KY3yTHpHnAkk67a40EZGiLHV1hG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730774; c=relaxed/simple;
	bh=oWm8NScouvxF5B/V1+dR8MbMfDQed3wk8wbeRwacjAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyUh0ch7zAfZubAF+k+XnlWeD677oLItB1nXgWa4J+tpfWdfpZkcA9h/FsjsK3STmTaYFmDjwcHkeTXJnocySZfIxyVCmuLFud4K/J8yA5SfVhTIaa5mSwaxooMtbXzZT9U/9k58Dk2wXQTaM8lJNWc293Pp5dxyPOlXx6pAsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=apECCSAo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9F804E413C6;
	Wed, 29 Oct 2025 09:39:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC42B606E8;
	Wed, 29 Oct 2025 09:39:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6729A117F19D2;
	Wed, 29 Oct 2025 10:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761730768; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZSi6XucA1aEFKt7ZDjzWrgNyD/I168aK/er1u55pXSo=;
	b=apECCSAoB56fkwTJja52tXiAbgjamZ94tvXJ3ROh39wUtUqiyLeXe2X2ljeEhMiZ3/BVEX
	wYPbCt826krf7df7b0eIH9JBQ58vLcDiXtWF90KUuuMEKGsq0u2EN33WL/9SR5eKSw3Osg
	q0j3HbgvwQrSBtCNzTtD4kIRtMl+7Vt3yJUvFMdUbAGGAI2eTHdCcumslj3F8mxLjcR21z
	ghWJmKR1Zw1xQu43ZychpRGbUOCPWiC58guOfpVmJbTqJSAc3gsI5K+UC0opD+EiCx7r4b
	C6TMEkaf5yexjYCCElaMclw+L6c61QxbrxQCpvqE6Rm0cnCm5IgWwpNRdLJ2Tg==
From: Herve Codina <herve.codina@bootlin.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 0/4] Add support for an external Master Clock in the Cirrus CS4271 codec
Date: Wed, 29 Oct 2025 10:39:16 +0100
Message-ID: <20251029093921.624088-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Cirrus CS4271 codec can have its Master Clock provided by an
external clock when no crystal is used.

This series adds support for this external Master clock.

The first patch in the series is not related to the clock but fixes an
issue related to module loading and MODULE_DEVICE_TABLE() due to a
driver split between i2c part and spi part.

The next patch fixes regulator handling in component_probe() error path.

The last two patches document the Master clock in the binding and
implement this clock handling in the existing driver.

Best regards,
Hervé

Changes v1 -> v2
  v1: https://lore.kernel.org/lkml/20251016130340.1442090-1-herve.codina@bootlin.com/

  - Patch 1:
    Add missing MODULE_DEVICE_TABLE(spi, ...) in spi part.

  - Patch 2 (new in v2)
    Disable regulators in component_probe() error path

  - Patch 3 (2 in v1)
    Add 'Reviewed-by: Krzysztof Kozlowski'

  - Patch 4 (3 in v1):
    Remove fsleep() call.
    Disable/enable the clock at suspend/resume.
    Remove the reset line assertion on errors (not needed).

Herve Codina (4):
  ASoC: cs4271: Fix cs4271 I2C and SPI drivers automatic module loading
  ASoC: cs4271: Disable regulators in component_probe() error path
  ASoC: dt-bindings: cirrus,cs4271: Document mclk clock
  ASoC: cs4271: Add support for the external mclk

 .../bindings/sound/cirrus,cs4271.yaml         | 10 +++++
 sound/soc/codecs/cs4271-i2c.c                 |  6 +++
 sound/soc/codecs/cs4271-spi.c                 | 13 ++++++
 sound/soc/codecs/cs4271.c                     | 42 +++++++++++++------
 sound/soc/codecs/cs4271.h                     |  1 -
 5 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.51.0


