Return-Path: <linux-kernel+bounces-749761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DEBB15294
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CB73BB3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93123BCED;
	Tue, 29 Jul 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="29NqCPrW";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="ZeeVM3gM"
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8735237180
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813186; cv=none; b=s96uyQu9FkUbqdeZ6obGnHpL39zimLHs73KGeus7kQX5vg4PJ8QWco7TQbIUtG7NobgxOWE3zNcLCedUaSkhEv+/kbUISl5v3w3Vx+5W/ozmXt1pCxtEgQuM1FhG+6etDPD88ajrnd4/+/uht9ewPyOegK2C0hVHmiZwUysAsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813186; c=relaxed/simple;
	bh=sA4RPjAxM05RQekn/x6/fjnGX99Zklg8NEEyvJ7D9tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DaJej739FkU227VeDNQvq2ZXeFPBLSd9P3BFwHAc8h08JaRUpPgQkNM0JbpQdWLi6PaS8yLvxo5y7QzlVoQgYXUVHMKneKbLBJVRO5Fd4wnh+OcoskwMV/nodhk3Vw/c1XL5RkiJjjC20FXR6+68jglNP8QJ+4IHmra3p8JKxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=29NqCPrW; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=ZeeVM3gM; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753813175; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Qjq7ANPEafKeVIOcRRoL6S8s3iv7vnOx3qEiXVCnF9A=;
 b=29NqCPrWifYx5HrOtZxAWWEFWGuydF6EaoQWWck61tRBoRsm1LZzomm3gupJdcVtbrqwD
 XFyUFZjC9WwxBKKeykb2hQt0P5keSKFLgkQNkrtguf+H9PkyTVHi/0/Z60nfZmDr8uZ0Xky
 xGU9xJv5/awFkitandRyZX+55o2zub6MfQ8fWb1dT8TC7CU7AcB4u8zCiywr/0XywisLaYm
 08LS2EgI1M2BH5TIC/fumeBgifgVmXLsHCioca6H0KicFNHSYaAW6yCBVCWyAxyKP5PoNtW
 +mNW9LFCQ8hXDjzuGSxI4mkp1UDvFuM/COOb18yytFo5J57oZecV7ZxncuXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753813175; h=from : subject :
 to : message-id : date;
 bh=Qjq7ANPEafKeVIOcRRoL6S8s3iv7vnOx3qEiXVCnF9A=;
 b=ZeeVM3gMWoejp9c8ica5/v3GQdLlbrDo4vm+uCP5bT+9EqEk2yrjaTXrFTKC+1/TVwPUI
 b1P17c3A3b5AFxwW7i1snWmWcQrVD6p+sg5IG5oK6KanBdfPvPShTATZfxB/EVRt1mMXrGK
 U1sQwJ8w5LE92xlsb2weEqpz+4dbC3oT9QTrMbS123aD55PtkBof4mWu3YQwtIifeUEN+l0
 SM77ApzEVeVFl+eKR1N23QNrDzz5bZ5aAGmpDCKKzPsapC56qeOs3G6htfVkmO7hno4yUQx
 Z3+mZzwKPjP/FCDvk3ZIcxRmnMaVmC43gDcooj9He2S/qb2ZDHOb2j2jtifA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ugov1-FnQW0hPr2KU-NS42;
	Tue, 29 Jul 2025 18:19:22 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-s0xxx
Date: Tue, 29 Jul 2025 21:18:48 +0300
Message-ID: <20250729181848.24432-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s11F8cfyv-
X-smtpcorp-track: gU6cqRkuioaa.Klq_Op_lI7dg.S40LQgRqo8q

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-S0063NT Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 05019fa732..77322ff8a6 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6528,6 +6528,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8bd4, "HP Victus 16-s0xxx (MB 8BD4)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bdf, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


