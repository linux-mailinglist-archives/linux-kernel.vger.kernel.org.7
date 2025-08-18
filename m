Return-Path: <linux-kernel+bounces-774491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A24B2B2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9811B22F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC726A0C6;
	Mon, 18 Aug 2025 20:50:09 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F327222584;
	Mon, 18 Aug 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550209; cv=none; b=dGS2mEwY132T2BGAJ3Oemw+ORLeFtwOI/IpUzVbNpi3Vnx6Ltq2G8XRZxDM3fpC2WtB/ogmkdE31cljNnuClyebpzQ9mVbW/YB9or4Rn8YL7VnQQYLkEQ/XYx9ffL3DZ4uRGvO29kEqeEXSJMZk9qOofsNnbMvOWmBh7KvvF+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550209; c=relaxed/simple;
	bh=kzI1ji97StoZqXSmUTpzmElG3fr9N3s8DOq5wMv6AH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jmloLg6RLWusWa63w8rk9o9JLCjh0JNXpADPc072NNbSnMv2cz1pJdNxnisASWzEWXHgoLtD7BrpI9Y796dkQu1GYk3lUa4ztDJhWuTd12qyJQgrAcqu9nEO3cGQz/8Qh3QHBtptyArFvycre/mVxOSfmnwfCTeIkbY5+7Rog4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id CB93923384;
	Mon, 18 Aug 2025 23:42:47 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	kovalev@altlinux.org
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14
Date: Mon, 18 Aug 2025 23:42:43 +0300
Message-Id: <20250818204243.247297-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a PCI quirk to enable microphone input on the headphone jack on
the ASUS Zenbook 14 UM3406HA laptop.

This model uses an ALC294 codec with CS35L41 amplifiers over I2C,
and the existing fixup for it did not enable the headset microphone.
A new fix is introduced to get the mic working while keeping the
amplifier settings correct.

Fixes: 61cbc08fdb04 ("ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/hda/codecs/realtek/alc269.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index db8e6352b9425..6c78a286172c5 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3579,6 +3579,7 @@ enum {
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 	ALC294_FIXUP_ASUS_MIC,
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
+	ALC294_FIXUP_ASUS_I2C_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
@@ -4889,6 +4890,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_I2C_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a19020 }, /* use as headset mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_2
+	},
 	[ALC294_FIXUP_ASUS_SPK] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -6730,7 +6740,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1b13, "ASUS U41SV/GA403U", ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1b93, "ASUS G614JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1043, 0x1c03, "ASUS UM3406HA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1c03, "ASUS UM3406HA", ALC294_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c33, "ASUS UX5304MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c43, "ASUS UX8406MA", ALC245_FIXUP_CS35L41_SPI_2),
-- 
2.50.1


