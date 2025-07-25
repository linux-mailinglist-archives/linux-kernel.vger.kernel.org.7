Return-Path: <linux-kernel+bounces-745912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FDB1205A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E511C87184
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC05230BC3;
	Fri, 25 Jul 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="GPa00Nq/";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="FrVbgU2F"
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666388F4A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455086; cv=none; b=oB8z+gO1n7d93umm99pwn4iqYXOez18sTzg6HDyIoFGXq49FUdMl/WbslcFvAxxeYFYewYjPZQYenD3ZWrtXtwver+qTXu2mHCy3F9ylJoIMlss8nr1+v+QLAY6KNLFNlwrlhjq3VNT8BTUFHuhEsNqUkWnRHXtw4iB1f0PSyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455086; c=relaxed/simple;
	bh=woIP6dtlEzDY0l3M0VQ4FGnewBR2yOUwHMm735zXzLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpeTwzbeThWdxgi0ekMsF7mW1t4MxKyKwKpSA7HImGSMJblGEdCHu/2O94yTjCVUMCE3jbh5myXs0v36qc8TAw+xrNmvgDPl3+wDvQhxwwenB+Fz3HEloEVjuPUu97kRAhZKJfj/5lPQiKxLax87jq5lAJ3QDf6rwp0QXHNR8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=GPa00Nq/; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=FrVbgU2F; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753455081; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=GPa00Nq/XvonWa0HDOSoQoPYe+ckf3Kb6ebsmLeFzynlWVvxZ9ADN4KS7UOdMD/NY3x7R
 QCBENdDDtg47GyLNleYMZ0S06SBvI9XCHo1wgztSZHVn7njznlcDz6kTbLqwhO9eDkpH+3e
 WT7Pnr2LjkZTce1wQ9HmJQwxH1UMmrRoOjvpQfxLkhkRrsSMxXIwvWhlnkGOtrHUzMjfwbK
 riPMnxlGC2/ECXDZ3medYU5B/FOtUWV+naPbsaVtgcG2CXhxyrzmIDey5szkuksJk2y5LQL
 +RNxsehH73Y023yOYLR7LlXp05Vrr59I2h6rDQjNRTZmY2WXuQQROeByORuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753455081; h=from : subject :
 to : message-id : date;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=FrVbgU2FMyTDo5HyCBIoxTfske/gJgrC9NpEb72cl1R+kYCpTCOwM3WTDcHJDSxRhd5q3
 p9bMRmxhhWAKit2DLUrZrbaaRrbUyEdWDTZyHaAsNnqg80WBPxySp/nU6miN0Dqe0Cvw7ME
 V88f38zDs1DU3XCjwbdAr5j8nLiUw3kpSdyx7gQCwnKxlPY8LJm2KamOD1U3NwYQzshRD8J
 buSNzoevq7s/A5bxX2IKcvOCSi/K9h6se9CyR7mjvHdMsGvHR6J5+cJEo3puLNVJVTryWcS
 yWYtu8m8ey5NajECKKoKCy712rWxCZWtoK/i41vjJ3SQrEbTymbx3rjpdXmA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufJlS-4o5NDgrj2KV-jQC2;
	Fri, 25 Jul 2025 14:51:15 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 17:49:12 +0300
Message-ID: <20250725144911.49708-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s1IhQhYw_2
X-smtpcorp-track: PLJ5nGETBrB1.ovqtNTgR2Wz1.IB1yTwPUOJs

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r1xxx Laptop. The LED behaviour works
as intended.

v2:
- adapt the HD-audio code changes and rebase on for-next branch of tiwai/sound.git
- link to v1: https://lore.kernel.org/linux-sound/20250724210756.61453-2-edip@medip.dev/

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 05019fa73..33ef08d25 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6580,6 +6580,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.50.1


