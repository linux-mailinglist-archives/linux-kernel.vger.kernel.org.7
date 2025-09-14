Return-Path: <linux-kernel+bounces-815824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3348B56B84
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E667A7D49
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6E288C35;
	Sun, 14 Sep 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b="V2FA4a5e"
Received: from mail.inboxia.org (mail.inboxia.org [95.217.72.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F219F130;
	Sun, 14 Sep 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.72.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877470; cv=none; b=t4XWeZ+htLIAPvQu9lxRHMDGjxf2wjOrLL4H79eFUVpPJBxlO7zaR3XOnF8K1B3BrtC0dSgUCXMNWUqZysiugV2i8sdXg2oH4j9FbHi11s0seMRDI8t/WRGQPKYeFr1ygjmWsDsR/vwmoO8YD5u0tRrpCwW9+kthyg6TLYCoI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877470; c=relaxed/simple;
	bh=dHKJDBWc8oZggRJ0c1t4z6ZV26/jcw4IPvwF0Vyb31s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtJJZ/oTf9IIi8Hf3vm9SIYn7zO8H82arX8mTAKh9KAw2ov6MVrEeg7YYnhudLMLejBh43UeE2QcpS/a8JgtKR4W7AlN0sGqFJmWLM/s5e18Eg3CcwjzZPtHRGRGAMrA83VMXN/vzXJZ+lfq28/li5yvJO0eAqg3GuqIXOQan3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org; spf=pass smtp.mailfrom=inboxia.org; dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b=V2FA4a5e; arc=none smtp.client-ip=95.217.72.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inboxia.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FD7C6166118;
	Sun, 14 Sep 2025 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inboxia.org; s=dkim;
	t=1757877466; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Ne7RCjrgn8CcqGxyW5L5ga4ogUhipgSzuJHitE66vYA=;
	b=V2FA4a5evsUeHFzQR0AOweeUNZ0TiBWyfnKm61/6qPTMVfBL+TtqcnrCh2Qmk3/PdcyWst
	PQp3hQUxZ8QvBt9n0Y0Gx7P4buPXF2peOq5DgbrVe4C/7bIrjsTyq3dRZsub3U7PB2KsgZ
	JrHwhvmAQimCowbF/DVIx4XuYXJYhrz90r2y9TGu6e2/pG/d8HAjwVLl/93jnxlHmCUvHc
	fdjVHr6Ey61AD95iDs3dKEwDuDOUT90rscx1jSVs+d0z+dE9bCesmQDWwywPW6DT26O3bW
	o7uz6hitOgzAnWEcLbScr/UdcMMMc+TV0D30XANechamTSDOSt/zY8wjB0NZZA==
From: Bou-Saan Che <yungmeat@inboxia.org>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bou-Saan Che <yungmeat@inboxia.org>
Subject: [PATCH 2/3] ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 5
Date: Sun, 14 Sep 2025 22:17:38 +0300
Message-ID: <20250914191738.2676-1-yungmeat@inboxia.org>
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
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 85bb8c4d3b17..ea73df3657e4 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7093,6 +7093,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
-- 
2.51.0


