Return-Path: <linux-kernel+bounces-744947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF2B112DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AFC3A5931
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC172EE5F7;
	Thu, 24 Jul 2025 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="SIM7G+oL";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="FAfYCBUM"
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1181494C3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391489; cv=none; b=NQ8nCg7iXic9tVBlqfpBGuH1T9an7vvLXUJAnQ4ANWQA9W5ochwyN/CVbWQ3zHeAhDBiJAeNVCOu7jNE/q4TxVRN81LRbxfBQ8D6XYRU2iacDloHcI2qk/d7g8z3mc/7eIrTV7KkdBBl+b/vuauwBKXVx69k+BuUcXjzmKuu+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391489; c=relaxed/simple;
	bh=kPLRNSydlzHC9QbqM2fGWTepgluqgtSVkRAiz/qpfvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjH9OHC9yK51P48eftEMNL5dzb3weHXg2ZY/Ta0g6wnbIwPAbeUiMM3z4yRSARhKJvLBCZmw1xGdQUPXtUeIhUNq3mNtNiEI4+h7q8Ewxn25ueeVLXFGgz3VynOyfE6+2gWh/bDfDzbalh1wG+L6wZcqoPZgox8fsPeua/y0Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=SIM7G+oL; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=FAfYCBUM; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753391478; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=2JsRL/sU7gjCVQskAJOyJPP7Hoszso9kA5c3YVUXfRQ=;
 b=SIM7G+oLZxxuK3CzpN/ibbKOaLJ28qARkOV/gU4FxnpyDEiD11xi0Jj6/dzdaxNlZhGfd
 yxk0Wsel/0XLCMOFMe0Tw1h3wT3pgUvCDKIe5pAGY29zbwHhmwFrw6UbmNt3/BjLuZS5PFf
 0gqX/lrDY+MAZHIY+ukEeIHZ1O8St1wgTzrIJOq6vmtzNJmg2Iqfcix+Rtv0bB+tPiQm0nf
 6wGjdz65qTLc61V6PMS4yf13WLlbMEYedwRD3/fU/7S8rICPg0VlyvT062CMw3YPIdWg+4M
 0QhX/M3RRmVTtWGeKdqTfUiyQynWuCeH2sDFBXRS8p9GmOs7NhtBWAFCNZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753391478; h=from : subject :
 to : message-id : date;
 bh=2JsRL/sU7gjCVQskAJOyJPP7Hoszso9kA5c3YVUXfRQ=;
 b=FAfYCBUMb5wYoFmXHJ6iFtA8CeXP8uutuA/yEZQAIhdxkLu9nVF6nAYbSY4uh6VAkHg8l
 yHN52RGE3M/MoiBGZYxxWkS2RZVRL0xf0y/KNtr3qg9KSkMXCKFqKZURcvIja+8vYuolTTd
 AowYtg74Pf0VruqUbwEGj1KsFWZF2xIwSRS8DY6UZ0JWYYWPKqK19sUMlCVlWf0ifRTeBne
 PBZWwi1UcbvDDKRlSyOPHOD64dZHKk6pcReNUQEj9GqxOjUEtR1KhZP6+DmEJ6QltARkF2t
 c4f0nBW0LcGPf2zhpTlqX407gJjz9B2mr1JCtDCywys0FdRHa1tW9t16kNnA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uf3De-FnQW0hPlgfz-iQGq;
	Thu, 24 Jul 2025 21:11:14 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 00:07:56 +0300
Message-ID: <20250724210756.61453-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s1IhQhYw_2
X-smtpcorp-track: -25oS_XZTpw-.LyeP4m_A91Ez.rsj0swpE_BD

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r1xxx Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2627e2f49..9656e6ebb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10874,6 +10874,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.50.1


