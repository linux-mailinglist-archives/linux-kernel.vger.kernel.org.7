Return-Path: <linux-kernel+bounces-745939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A48B120B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A355A32FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7031218592;
	Fri, 25 Jul 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Q83QU+9g";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="Hqbsy06D"
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5C77111
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456672; cv=none; b=KcBPo1lqIdsKkyRax3XMkQycvYjBks8Qr/S+TUifd98CdCMbQ/tP/KgCGEB6yBwmk/+EoXN7eFFurnYNS58UWe+WwVPzfhp7slYILdHU/G5etgjedNaEcwdm+ta/AbqZJl91APkNHYZF2x8OZYAANwXFOxc0O9pG+RH3UijzWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456672; c=relaxed/simple;
	bh=woIP6dtlEzDY0l3M0VQ4FGnewBR2yOUwHMm735zXzLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgp5Nr06fvi6A3mAjmJh/HVgA9hodJyEt7QiqSdpA/FoQyKv3+MqVSLqqj4SqzPbkDeazfMIdYf2dRpRtjjsAX6BiFjCurSlwRYkWrFxKlMK4ZZAee60G+EtJ1WYSYlPPRMGq6TunOptQBsodTdK9/+/upFcRhLnrxMWcrpw3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Q83QU+9g; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=Hqbsy06D; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753456668; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=Q83QU+9g5tYSRPGA1HUjduGP+1LHLfaTnSIPHx583fjin5H8Qa0Klf+ziqyH3xDNP+Z4p
 TA+ZE+M4FiPBBNkWdDGU/15Y27OpddMBvH9vG7o2G/9FoQFtSfmHG98v67ZUBGsNpn9evXD
 /un39xqSOBi0XK0IB4BKmFA2fNXg6uvCCkcwF4eZNLWBCkFBHgZWtX1LmShobiCg4AYV6l6
 BjPLMjlVJpPnNjKg5XY1V/VlW83DmfTPInRkpXrdiJ5jcKTYgPjHccpmzfO1n7PjOntKwpg
 NH+pe5LkxoHMGBGb+XhFvnu3GU25twFkIbpQ/Hxa0B/uzSpt6aStVrrkBdlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753456668; h=from : subject :
 to : message-id : date;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=Hqbsy06DRgj09fYGBbw2RdEcpLAGE27nME4yHA6ie0W1lnzK9V5rJWuQiyubZbAieoP+E
 MyoTnNQt96Aq6WoK3hD2VmColN+KGePH3eJkqx4AU8G9PnIwApePPu7oVuAO4C5OJh+yc/M
 p4gviJEszHL8Cl8y4VSY5aDNjDIhuIvZ+QheRuWFsD6OmoYbNCdxfSGJEZb9j7nxKSqYoPt
 mo/MQFi78Ez7kE7DE5sTUF0BxnLtRjGeIQ1N64UVeJ97uOKLYmllyS5yRcL2rDy13BlHqUE
 bsPpBFIURFXDajPhw6KzoHEVxo8SYHfBhOn2FqTuPgxIbkWu7067zChGrnhw==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufKB7-FnQW0hPr5lr-h1v1;
	Fri, 25 Jul 2025 15:17:46 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 18:14:37 +0300
Message-ID: <20250725151436.51543-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s7LIr8FS_w
X-smtpcorp-track: so3SsDM1v9rF.C0I6WmN9OhCU.7Wh0cQhXeUA

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


