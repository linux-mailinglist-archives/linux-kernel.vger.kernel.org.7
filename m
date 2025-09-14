Return-Path: <linux-kernel+bounces-815825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51261B56B85
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C370F189B8B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B552D0292;
	Sun, 14 Sep 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b="W+FTgz4v"
Received: from mail.inboxia.org (mail.inboxia.org [95.217.72.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A71FDA61;
	Sun, 14 Sep 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.72.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877489; cv=none; b=LWbsWzaJvk1s8NGyUtsEVCe5MPqaCKIsymQ5c8ep9AAWuLQDpSBKy41rxbe2Ujm26SC6/AcHnAMJN9wlwltNDVAZQ6FobBQi57tS7vLXRDglq/rZUT0cJBsPtLTAL6Z0bJqn9fBvTYmgmefY2JgAMywS/Nemh/Z+LDRIf/HsIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877489; c=relaxed/simple;
	bh=s8nSI1WAFdrWpuBPW03NjMeKdGQIrwBkbJV2C35WnLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oC8cTzAGLPUwk11tUDTc2u+Z9NtBtHKyYqneo9WrCfbykJb76nLhhQVKW2qnDba9XKWA0+CAD3RRwW9Y0TWg/hlFoZ8CHLUlJ0szD0ScG/8qnI3NCBndK1wIJMT17/y7MLVKQ/29DFHlFylNzYCcXfgH06ECylMmZmPqWLW7m8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org; spf=pass smtp.mailfrom=inboxia.org; dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b=W+FTgz4v; arc=none smtp.client-ip=95.217.72.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inboxia.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9F36166049;
	Sun, 14 Sep 2025 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inboxia.org; s=dkim;
	t=1757877484; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fAU4P7PK+wAO5LkIt29vmuh2mfYl3tqOXgATkDjJ+sw=;
	b=W+FTgz4vzHNsmj9FlPWIkpRUxW31bBLvEb1Skt7CcfATPSAJj1L6eCKVn6WnfmqKYQVOQV
	HhE2b1bTd9SFMDvaGA/ZGxfs2H5r9iYhrJqJQW6C4q5TepAIVadlZdvp7U81C7prjHkb6k
	gNudoIkeSAudRLVydQ/5WC/SWCFI//qwIPa4tYM9D+3Qlp8VT3IY4M9eMKZjIBfGBbvjR1
	Qgf0TbN+m3JamX04QCaHuq7JzLFPdmn8WOilzbgTOQysu88qDLsoriOoLM4MFpw4peq8lb
	PHCFGevpAxcMkim8+Z/xUDyNey3KFPCD7amoyVeFwyZqIajbbP31xefOvkYizQ==
From: Bou-Saan Che <yungmeat@inboxia.org>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bou-Saan Che <yungmeat@inboxia.org>
Subject: [PATCH 3/3] ALSA: hda/realtek: Fix volume control on Lenovo Thinkbook 13x Gen 4
Date: Sun, 14 Sep 2025 22:17:50 +0300
Message-ID: <20250914191750.2690-1-yungmeat@inboxia.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The issue was caused by incorrect configuration in the driver,
which prevented proper volume control on certain systems.

Signed-off-by: Bou-Saan Che <yungmeat@inboxia.org>
---
 sound/hda/codecs/realtek/alc269.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ea73df3657e4..b232c3be6ffb 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7071,8 +7071,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
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


