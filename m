Return-Path: <linux-kernel+bounces-729765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68EAB03B44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239941885CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72223F41D;
	Mon, 14 Jul 2025 09:47:19 +0000 (UTC)
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434F8F49;
	Mon, 14 Jul 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486438; cv=none; b=gU+C08znZScEn9W18GOB4BazWwhpS7vwnQyB5+2B+QEeW72tO9WxClNx+rA0+KHh5jrZUTmnVEnD9inir67tRRDo/dp8jVVbXLDNzmg3hE7MVbr17sTD1kLTtRwPytMF4+5udzQ5VhieePYje1txT3kkhHy12VbpGu7FTF++sgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486438; c=relaxed/simple;
	bh=F9JEX/aBi3O0gmnNqiaV4HYvfx3mkPeW+y9VvMpLRH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnO/MzuTUTqEXVbvc64HHSwYLZyHYZ9VWB6FDUJErJOxNxnRk5hbqOSK8RrfxZJ22/yxDDjR80WMoC+o68V9BaeVsbooqWCE/oaRYEGOKAl5MZHOCQk6xPKXUd2qxDUeOyt7/Ywc15G4nYYngoaGpzcOg1u2o6ZQ0VXb/CLkbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from yoga-Lenovo-Slim-Pro-7-14APH8.lenovo.com (unknown[106.38.209.7])
	by rmsmtp-lg-appmail-13-12002 (RichMail) with SMTP id 2ee26874d20ee6f-3018a;
	Mon, 14 Jul 2025 17:47:05 +0800 (CST)
X-RM-TRANSID:2ee26874d20ee6f-3018a
From: Jackie Dong <xy-jackie@139.com>
To: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dongeg1@lenovo.com,
	Jackie Dong <xy-jackie@139.com>
Subject: [PATCH] patch_realtek: Support mute LED for Yoga with ALC287
Date: Mon, 14 Jul 2025 17:46:55 +0800
Message-ID: <20250714094655.4657-1-xy-jackie@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support mute LED on keyboard for Lenovo Yoga series products with 
Realtek ALC287 chipset.

Tested on Lenovo Slim Pro 7 14APH8.

Signed-off-by: Jackie Dong <xy-jackie@139.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5d6d01ecfee2..6689f8b4c38a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7497,6 +7497,12 @@ static void alc287_fixup_yoga9_14iap7_bass_spk_pin(struct hda_codec *codec,
 	};
 	struct alc_spec *spec = codec->spec;
 
+	/*
+	 * Support Audio mute LED and Mic mute LED on keyboard
+	 */
+
+	hda_fixup_ideapad_acpi(codec, fix, action);
+
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		snd_hda_apply_pincfgs(codec, pincfgs);
-- 
2.43.0



