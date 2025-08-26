Return-Path: <linux-kernel+bounces-786778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433BB3694F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610F21C27A82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE235AAB0;
	Tue, 26 Aug 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="PDHCJ3IC"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E93568F7;
	Tue, 26 Aug 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217512; cv=none; b=gkg3iTt5o//kMltnGyZS0Paxq20KcMN89blN3kSvQ+EAUySgdN4FigIhLEINssMkq4HqiulvznPPpuoRjXKHBFNKmlR8g1L3FpV5YBioXd1HzAcOkjI8YZsNlwGyX6qXj63NiqsLmG69Xl9p1oLexvjvnTGrA7MlCu8VGtArFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217512; c=relaxed/simple;
	bh=DsnW8By3xCvnJB5XET1/aodofraOIN5lLc9umngP5jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVEM03hQ7HkUIVAAe+qn0zs8bXVACpPbH3qOQ4sfjRL++f3uM8Unj8+ADkYi7ZFzyhbr869t15GNhrfYuBDXab/osqnr7vfEquW2XCzN4hFeNS33diu4yuaylFQ8dn1kfLv9xlOl+n9VhGgG3V0wA0K2tvni2zviQuqT7wHNHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=PDHCJ3IC; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from aerhardt-tuxedo.fritz.box (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B6DBE2FC004D;
	Tue, 26 Aug 2025 16:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1756217506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lQcSL12EP/M4ZdFUlZ3UK5gIpHjO8N5WBKcGVg7afT8=;
	b=PDHCJ3ICzVVNVkYYzwvoHGuPevPAZE+JcycQeSM+47aJ0mq54zBUM8krPOmwkobP6sgyZ8
	pdftva1fi/7IqQnROwwb0WW2t+ITmgda/4yZqDiIlExImYgOh2GuWcxGBisiFZjUh4M9gJ
	5QXrnF5kSasxW6pL7cv/dxTPMgqWqy0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: aer@tuxedocomputers.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Christoffer Sandberg <cs@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Aaron Erhardt <aer@tuxedocomputers.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY
Date: Tue, 26 Aug 2025 16:10:54 +0200
Message-ID: <20250826141054.1201482-1-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Erhardt <aer@tuxedocomputers.com>

Add a PCI quirk to enable microphone detection on the headphone jack of
TongFang X6AR5xxY and X6FR5xxY devices.

Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 0323606b3d6d..85bb8c4d3b17 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7147,6 +7147,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x300f, "TongFang X6AR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x3019, "TongFang X6FR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
2.43.0


