Return-Path: <linux-kernel+bounces-815390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2124B563A6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C8C17E5BB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196302C0F64;
	Sat, 13 Sep 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b="GYKBAfj/"
Received: from mail.inboxia.org (mail.inboxia.org [95.217.72.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767E281358;
	Sat, 13 Sep 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.72.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757804074; cv=none; b=tlUIUcvS8AM1lApzlLGcbIFxEZoDQsX2z4i60rwh0nmNPH9azWDgj4psl4fFOBd2DxXcT7gRBZX28X09+u6SUSkG6zQoOcVpUuk5OrW8+wzSmNAkarCsyYHKf9kxMcAHXmeVBVuBj7KZ2+9I1c3mLVSvDH0WoKzN9HiyBk1JwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757804074; c=relaxed/simple;
	bh=Ov+iY87a4T6MxIJwaQ7aBlIVZMr67tRxz1XZAtFSe4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJ/FC+ywAko4VIDfwEMDp6okTENxreptEHVJDTNFfWGpVuqpyCRQjHllE8tFWpYXpOCGkr3+lVX8DK2utgPRbe8yvGZN6fGHSqakYoOdFqvhd1tTxwq36Cnay76yrsrNQC7ugeHGvyPxxixmHNhQ5Qd/ukmmE8EP5Dd1C9DWJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org; spf=pass smtp.mailfrom=inboxia.org; dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b=GYKBAfj/; arc=none smtp.client-ip=95.217.72.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inboxia.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFBC061664F9;
	Sat, 13 Sep 2025 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inboxia.org; s=dkim;
	t=1757804069; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=TtJUKcztkL0EXNkAHTxW0ZztC2IDBAoAmsySOvYQcCM=;
	b=GYKBAfj/cuYNdOfAd2KE2KB15xNMyyGmU2z5XDnucJBJovXnmsnE9SAcJeomoxotLEleE7
	t/WcqP8x8mcz9msjycpccuvbvysLFXku/bo9dsEt6uwNCp6FqBDOlJi4jEXKIx+QxxfdNE
	96nQji/yem74FztXEtQWHnfpKX/VoZ8A05XbgWN4IuaOT3svBt0TVxi9e4obIrNhyNDkvD
	R5W1aU2KbzBqKM7hpRmF2wyqBw7obLoFk+1skqyyQYelbUsywthxGQWeXfq2jJc9+BQq8R
	2fXrXv8DJ2rf0C13rjwZ9fVqaakeybqQv9/x8No7WffXykhmkkbwK3vJaHp3sA==
From: Bou-Saan Che <yungmeat@inboxia.org>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Bou-Saan Che <yungmeat@inboxia.org>
Subject: [PATCH] ALSA: hda/realtek: Fix volume adjustment issue on Lenovo Thinkbook 13x Gen 4
Date: Sun, 14 Sep 2025 01:53:44 +0300
Message-ID: <20250913225344.12822-1-yungmeat@inboxia.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch fixes the volume adjustment issue on this laptop by applying
the necessary quirk configuration for the Realtek ALC287 codec.

The issue was caused by incorrect configuration in the driver,
which prevented proper volume control on certain systems.

Signed-off-by: Bou-Saan Che <yungmeat@inboxia.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2627e2f49316..1981e3374b3e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11346,8 +11346,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x17aa, 0x38c7, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
-	SND_PCI_QUIRK(0x17aa, 0x38c8, "Thinkbook 13x Gen 4", ALC287_FIXUP_CS35L41_I2C_4),
+	SND_PCI_QUIRK(0x17aa, 0x38c7, "Thinkbook 13x Gen 4", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38c8, "Thinkbook 13x Gen 4", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
-- 
2.51.0


