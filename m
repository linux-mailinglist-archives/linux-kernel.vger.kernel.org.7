Return-Path: <linux-kernel+bounces-722428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E64AAFDA6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA85189AEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922F23535C;
	Tue,  8 Jul 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="BVOu1HOE"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCED14883F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012257; cv=none; b=lNikRjq2uBEfSkyueNxJglEqVQMmSfXzFbCdI89OxkROzkq/XAtYaZXWfmXnPt2zsjfaSx8fWzG0AnhndrM5Uv9jD/y58J1M1uDrFxitkX4gDxR44+qCWArgJrofDfHh7jo3KgmjprKPjGBw3O4RMGE7oSp2Pd3a6uUQW9+JwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012257; c=relaxed/simple;
	bh=T1pYAcpD4QD5aNKYoNzNjzWClNCiJm5FqrilVScTEPo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UwwoQTK4kXBtWWW35QB8Oq66DbAaFlHmuTgM/x0crpRZrrWDbON9vGYsIkwQzQg6Rfs8T+LN9WNuC59C8J5M0b/djCm+8heLulxK9waCIBJgndZ9ZZ0lwfDHOYRjHt6Lh+kqueQtb//Woig1/Y8yeMSIldZKQgodKArRXpvrO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=BVOu1HOE; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 7799 invoked from network); 9 Jul 2025 00:04:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752012247; bh=/Ziyoc6OWfBD4Ber22ISCAG5cMVClEJJdMXo55uffz4=;
          h=From:To:Subject;
          b=BVOu1HOEHwN9oqxm64pZbA/fwotlzky4SavZdUIVoyfbQxxctjjt/jr0GtMv+SVF/
           boVnLuBQZrSMerk9rWxDUGpSKAjdmOq7qQzaMkJuxciNge9NPquP/EHVjXmouKxYWi
           UrHfy4PQKUh5ddrzWLWu2wPcruMxhOIegmH4YZDSsaDx+q4NMNGn17priedPlQ0MU1
           DisTBZg5JkjLWrFWzCEc1SCqz5HjZGZrPcP21qNJFsbNeGCdxGOJCSyqaKlOsTIiMS
           4gNdF6UgctLlGlAoTKCdFOojPGjp9OcgyThg2WTctA7DC1w7OLldbKQp/fVZAK6ldH
           uZo1aTmAiuofA==
Received: from 83.24.138.239.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.138.239])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 9 Jul 2025 00:04:07 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	s.hauer@pengutronix.de,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/3] Add thermal sensors support for MT7981
Date: Wed,  9 Jul 2025 00:04:02 +0200
Message-Id: <20250708220405.1072393-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c47a9be9f1745f53a3fc4eba447605ae
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [ocM0]                               

This patch adds support for the temperature sensor in the MT7981 SoC.
This sensor is exactly the same as the one in the MT7986.

CHanges in v3:
 - added fallback in bindings

Changes in v2:
 - added fallback to an existing compatible string
 - removed second patch as obsolete

Aleksander Jan Bajkowski (3):
  dt-bindings: iio: adc: Add support for MT7981
  dt-bindings: thermal: mediatek: add falback compatible string for
    MT7981 and MT8516
  arm64: dts: mediatek: add thermal sensor support on mt7981

 .../iio/adc/mediatek,mt2701-auxadc.yaml       |  4 +++
 .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++------
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 31 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 11 deletions(-)

-- 
2.39.5


