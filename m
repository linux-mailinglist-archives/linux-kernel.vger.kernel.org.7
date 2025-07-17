Return-Path: <linux-kernel+bounces-735995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28DB09673
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8B17B2467
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF22367A9;
	Thu, 17 Jul 2025 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ZMloYR0N";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="CgH16fxR"
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23923535E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788562; cv=none; b=onH5dho78hf1kRksTwLYB5kSwjzg1ibItb9oQmMNE/dCz9yk8pp6fcT4LxrtoN8FFD6PmLOCIRP4flfm/rD2JEx7QVQXNlrM4BDZTvirqT6kc0i1OEgnbeM0gadS/PA84JmPeRTYrDTpDZnLsVzn4fn9rCknZRvWg2H5fsHgeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788562; c=relaxed/simple;
	bh=mrddjCmvTYA6t5LbBy2FRPclddGvQ0AOTV6IHAyiYqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGU9rWwNtbO3XizPTBbXXCC9YfBTl2ThMJ9WMP6m3ViirL/fx1ti4FeN+8QAifbZ3B2jSHCfP6n87ndeABijYos30HMF3WBygNBZX7Tv1V9TgCZA1AWGPgeIWXCcNC0XV9qa1/s732vm2N1RiBdsX9a5VPMeo7IjpQkJ67HG/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ZMloYR0N; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=CgH16fxR; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752787647; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Gfv0VoGpjGNOQhpz6loWxFeC3SOK7lyMb9kShZPEDbc=;
 b=ZMloYR0NJgwzRiWzZByVAILH0oyjxCk3q5mlbs9bZY4+b3w1HCUDy2PSMqyeMZtbgphRe
 HjrJRPixVztBUBUHDePu3H+grbpWa12ZlBar13jIlkjqEfjyX8g6QMhi8VbX/nkJdozkcue
 MWaTzWKa0iiGlu65iH5fm9RdjLu3uNhN9uait5IqCO7bxjkuHFDwGODOBQo7b4a0SRQ4cdO
 m514Hv9cz4jr/CHcS5Z6JbAwkrIocRGz0xy0uN2o+niBx3BVHQjI2NqJT7O5xAUyi929Vcl
 rH3r/9yr7+Qq2Q7zRMV/f/KdwxmZpKGMOC1TJZh3FDF/InKp4alw9a39Sgmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1752787647; h=from : subject :
 to : message-id : date;
 bh=Gfv0VoGpjGNOQhpz6loWxFeC3SOK7lyMb9kShZPEDbc=;
 b=CgH16fxRrgOpz0kKHagiy7bYJ6tYMU9GBLS+dEqe5Rku9R8rN8TX4uJGz++GSMa2cqHUj
 ebUqOnI8JjSxRoM5y3lEQ007sW/Aq4t+A1R04Cr0eW2lP4Rm/1Gv6hEp3SeC0GyXLv98jYP
 v2Gdk5KBJ7tohFMuv6JyR4dJ//op1WebGjiINtf0rBzYb0P+gcRgD7HB7Kein8yszjWXt1h
 pSO/mYFoiG6wh1Y0C/QGfYGMVL+K/GNTwutRMa6ZGA+SGLOb7OWbz51yHGuvdVMkGudWA06
 TUOwtmeRoVvPIX2m17utCp5g4fKpcSnd2jUybsr36aY3sv0nRhuukLnlj9lQ==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ucW8O-FnQW0hPoI3G-gXXB;
	Thu, 17 Jul 2025 21:27:20 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa0xxx
Date: Fri, 18 Jul 2025 00:26:26 +0300
Message-ID: <20250717212625.366026-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854supEO3aMoK
X-smtpcorp-track: ed6yWxVlTNe8.1xL5TN1lHHom.Q88ZNw-l6Mi

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on my Victus 15-fa0xxx Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 060db37ea..5cac18cff 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10769,6 +10769,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
-- 
2.50.1


