Return-Path: <linux-kernel+bounces-749762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6FB15297
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3839547A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823A239E75;
	Tue, 29 Jul 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="YekMx7Iu";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="iK4X9FTP"
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502D23959D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813203; cv=none; b=t3Bc8t7dCvrnh1RmT0Uxj9V4pCDj89WsSsDDMg/H+/T7NBTMfg3EKwlXwEU7C94dOJRJeJqwcutmFYBKpx7Ffit6OdA3/QDmFPl6EjG9pJdMkyjju/onJHMWJLbiMIRzKO12AZdnvXVRPHlLDApflwmprdvZEOcLuhXPpmuF1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813203; c=relaxed/simple;
	bh=8cZ8iZ8qtV7gGNyVIsY/ItajFVHqRLfZExe/pKoKmuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrUolJbk6Vm1yeFH8YSCOLdAwFUR2KgbstRH+l2N6jOV393GErdCIkKXgSf8+CyIvi2H1Jl+1nfnegJaw0aoAg1naMWQ1Ld2lgqqJ1mFcH6aT9ZE/me4QcH+y/Nx7W+FQisHB7iZo7pio9NBkozcWkD8l8XzJwPsXX6LRc4TAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=YekMx7Iu; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=iK4X9FTP; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753813197; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=W62LCwnhZ9/NUInAK1TZuyBIe4Xaetrqj46TOlKwxq0=;
 b=YekMx7IuRBxfJTUHdYdTORqxz04cKgOxuJgT1+omrgN5QFfDuMpIxCC2PoDZ6iSSmVCxe
 KSHbwPBTYtgqY4GXvE1zdXONibBmGsvmA6HoZ6s3ZBTFQPqn2RR0lHY1ttO25nPmyQOxxUy
 jF1O42iRAyaSZaLCkxzRdRbryvtyG/bPHTSghSQSJVSzp0HluV87icsOrv6Y2vCcqDYTLWP
 4abjmPu4GB83GOojThgUoLj+dxy4b/vIajtyqQAnM1X5FdsTLuQL8q3MnK6On/2CWL3iNDM
 Zvn0i41UJSEeIRXzzHMissre/y4IAlaDZOdrBOFMpxzNACVMV3RwxYayPv3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753813198; h=from : subject :
 to : message-id : date;
 bh=W62LCwnhZ9/NUInAK1TZuyBIe4Xaetrqj46TOlKwxq0=;
 b=iK4X9FTPpC0bJ8psnt+zDokLweOd1vPso/v8Sdq/GBPcUgztrIdvv6UVppLux6eLTezYb
 nLGYK5NLHLy3NoARjWhRH8zB1B/hSodsuANa0W9VFwtQLlTxAP/aPDQX5xhtq2FHi4T3Gvi
 Inmmw+AtIrlMPkYiICYXnj0ZxSiF/hETDaObduwi8aZeINoejx03A+Npppbp8Aiqr5R+iqC
 IViMjDXucMdsnUbosDG+igHYYN1zNih5LOfTY4Aq7dI/Qk4nKkgtdr9IEgtt+g42ktogD3x
 KZ9lQfnGz0Z3hJLNTT5RHb/CWB6EqZVlpsP1frnntCxUp/GtL2ainwXGJA0Q==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ugovR-FnQW0hPr2KU-OeZJ;
	Tue, 29 Jul 2025 18:19:47 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-d1xxx (MB 8A26)
Date: Tue, 29 Jul 2025 21:18:50 +0300
Message-ID: <20250729181848.24432-4-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729181848.24432-2-edip@medip.dev>
References: <20250729181848.24432-2-edip@medip.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sDUZirJ3h6
X-smtpcorp-track: kwu7nO0voNhb.vf1w4HJX_Ndw.5ArUsAoWUAj

From: Edip Hazuri <edip@medip.dev>

My friend have Victus 16-d1xxx with board ID 8A26, the existing quirk
for Victus 16-d1xxx wasn't working because of different board ID

Tested on Victus 16-d1015nt Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 77322ff8a6..d0f1d01bfa 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6470,6 +6470,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a26, "HP Victus 16-d1xxx (MB 8A26)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a28, "HP Envy 13", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a29, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


