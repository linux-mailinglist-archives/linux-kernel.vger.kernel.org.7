Return-Path: <linux-kernel+bounces-725765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F05B0036B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848281888E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749DA25A351;
	Thu, 10 Jul 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="rIEOUeXs";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="TusmlQ2g"
Received: from e3i282.smtp2go.com (e3i282.smtp2go.com [158.120.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9125A320
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154425; cv=none; b=icq8+nMvfPwazhpQ/RyxqIJPGrLzY+gPAfT648Cg4pKX3HwXDp+dH54JKd2p1z5PMEE+GAX44RjrA8uQ6R1JukgFB02Zan/EPmZGoIcQ/UfM9p5clVuyOTYJMjspAlU/rGmXK2QsQVtKWfDttfJF5ng6vurli5wTFDkGflm+0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154425; c=relaxed/simple;
	bh=M7l6/QLIPUoglGrfdye4yiQdtH9sXmYpR0Yv55tKrto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvVsmX3K4qr5XhFhN7wikeIo1q/bMlZpYO/JRZGA0vV4GXdPt7FFTuHZSTiNX1bY2rK+3E8jvvVokf0p+ihvQdjsXbcZIwGyQCHnWryt4wICoSG+fgKE+4Tk1NixCzfsrR3c7kgDhjy/ctnmVxW3/Bw/Uy0ioilWFniRkeMUeY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=rIEOUeXs; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=TusmlQ2g; arc=none smtp.client-ip=158.120.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752153510; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=vsPjCCPZRDftl844wyMwpzELOqTezWUQYA1LB69ZyMk=;
 b=rIEOUeXsd8UNG/ux3auImqwRZ+RuK9LbzN1PEngsIdXu8LwwKLDnZT417DTV7TJ/mn3fm
 Rt5bkdxlxx08NZ241gg30cNF5FAl8/nfNpcuAKhKVjVDgOZI8XYHn4NHrQbQNMU6HPVeeWO
 4yrYeuBZQSm8R3VO70a6yVIIZyf8uD7a7uC8Ji7CQX/mYy7G2OYnac3RUAlx1qhQxwAeSBH
 rUiIZnkUrXPrz+KJiA4rLo2iI3d6QrhHcl9sNlRRMkj3X0km1CuV0W7fcwPQMORGGymey/s
 cvCccFQXapuZxrqAogiYo7iYm0aOGV+82mz6JdAudbGRXvtI994HHWnJpwcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1752153510; h=from : subject :
 to : message-id : date;
 bh=vsPjCCPZRDftl844wyMwpzELOqTezWUQYA1LB69ZyMk=;
 b=TusmlQ2gjfXqE9TlbIih8sKHnhk2eaf5LjNnVBYqv5MWxlgv0CMse27WKCZ+ckgdVP9OI
 f1BT+IcQQ4yIHuwCTfoJSAz2V6uIeZqFeK1X+fb9OaEO9XnSueKSenrhkbnT1dO3fxOOiwx
 VNSKyMIIfeAT0nI/8sZYXZuBszJoFdzbn67Qwan8eAOncjEXdevl0JsaDvDF7byktt4zSu7
 Yvx44DzCFLWh6dgZu13Y/KjISNfYXzxXoHKzQx+rbcZ7Er8icEohaOyJeXDwSetOUrKZrgY
 yn384jefVLRHsEVer6GSCWV70evGdgBAXPDUTe/zuyAbJ9GUZpoJgKwgBglA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uZrAQ-4o5NDgrsm8D-h6lg;
	Thu, 10 Jul 2025 13:18:26 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r0xxx
Date: Thu, 10 Jul 2025 16:18:12 +0300
Message-ID: <20250710131812.27509-1-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sasdnPZ66u
X-smtpcorp-track: MJPPRSxZKhyL.8D4jXHymOJFq._nKw1w0NJU9

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r0xxx Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 060db37ea..132cef8fa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10814,6 +10814,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


