Return-Path: <linux-kernel+bounces-815387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ACEB5639B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DCD189CA7F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943A2C08AC;
	Sat, 13 Sep 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b="QQ4pj+V6"
Received: from mail.inboxia.org (mail.inboxia.org [95.217.72.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758E238172;
	Sat, 13 Sep 2025 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.72.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757803120; cv=none; b=p6nIY8sz+B7u47kuARPKQ8qTmhRj+7lopwQvfOHqkVoUI928EWECj6y/7y5sIgCzd9nG2J/hVbREr3Z6OgfjwFL8wXS88FEMOUr2imADqWd599vD3g/Bqnkuz0ckHAHtcBklbHnKem2BQzRLNsKsrrJSIfUn+DdOk90RlQB1tP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757803120; c=relaxed/simple;
	bh=Dv6zSAtrCBxyeEhzC3hUq7L5HZfD7vtK/TqCTcWjyn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8yxmt099mDniba8uRg1DiXcWiRI6JVIqYnrjTm0yqiUrG60M4I7hYeykqah9avoPwoXR9kggWQmCmFOPSjlG73tyKBtTMcCA/L5DkbrRTbxkT57PN7yG6uGEycJkiJkDxPl0I1pC1esR82iww4zoJfcB+fZRYGhK/dJR/VIUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org; spf=pass smtp.mailfrom=inboxia.org; dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b=QQ4pj+V6; arc=none smtp.client-ip=95.217.72.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inboxia.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B6A961669AB;
	Sat, 13 Sep 2025 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inboxia.org; s=dkim;
	t=1757803115; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=OKpsQgiTJ2njmnvAgQ8cOrHhf1ic2qR7pqpfcC3YiGg=;
	b=QQ4pj+V6+nSW+ZoiQeJC0EeL1hnhswnclTB6UCrTSSpZ9Txd6SXPxDHRqGlis2c2Ws+gry
	bdfrh3ee4lPOmqBbFUm8pitab4J6UDitwxuL6NYmQKYsilMMBDTPJwER8LsvJiGNSvKR03
	d/36UM5GhRAU29cU85TZfq+E2vwSnklGyWhLETjRS6NvqfKoDWBWNhttb1hTjHm9W1skMG
	cdrv9VzN6fEnouZB6AFguj3H3BaZK95u7Q73pj/orwGdTqn3JbB1Se+Qzo/e0/IV74QKgD
	iqCRkEV1oLRxrRhuA0tZ1CsHEqoKABWWJ+Arcp2nnalIieicyEPxp5ajaaL4dw==
From: Bou-Saan Che <yungmeat@inboxia.org>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Bou-Saan Che <yungmeat@inboxia.org>
Subject: [PATCH 2/2] ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 5
Date: Sun, 14 Sep 2025 01:38:25 +0300
Message-ID: <20250913223825.9264-1-yungmeat@inboxia.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The laptop does not contain valid _DSD for these amps, so requires
entries into the CS35L41 configuration table to function correctly.

Signed-off-by: Bou-Saan Che <yungmeat@inboxia.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2627e2f49316..36dc0389c9bd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11368,6 +11368,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
-- 
2.51.0


