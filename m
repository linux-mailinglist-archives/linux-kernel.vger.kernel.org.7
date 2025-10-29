Return-Path: <linux-kernel+bounces-876909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0439C1CB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC828188F3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C93559DD;
	Wed, 29 Oct 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFqVNPXI"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B046355035
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761540; cv=none; b=jFdufL37rvzHyIgOk7EXabFZu0ZTXge9Tx7KCacuQBBiGW33bAUnpN7WHIcN1REXxyBe+ep/rmuPeK+onBXNxj6+JQOP4nSbZ+SuFNVij/tZQ+X13t2C5R/dympjRJPF0fUW1OmQzaui9Cr8G8PKMZRDPOUOpJB72m9o5rJt7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761540; c=relaxed/simple;
	bh=0cHmfPpwQRUncw6ailNncA/HG4OJbBt0bXiKo1tivTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z41B4/EFADRhjeL/RiasOWCkL6mpUJEbMb+w93c+X0uo/XYR/71sNowf6NgnggIb8j50t1qsz7lVKX/VoyWNKfkFKe1+bi3b+XEX6j6atIYY8ua0eWYtM8z3rozPzcr/t5QJoNG3kAWWpIbLHJtYHOZilttWnipN6jOiyfCvQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFqVNPXI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso219333b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761536; x=1762366336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fM675FWHZG0xlF23ngbvLV+PkmWX/yNsjPmEemg5TU=;
        b=KFqVNPXIAnnjUaN5gsI+9Mlz8e0Hg+iMH2J0QQpCTyMREcI2in3rYtJJVD5aC1VQHQ
         Ot4jr/buP8bxDWbkBFgAShrYIcukAALXZMyYnX0aDmhWBbvDShU4g+A8NjxnM1GkhLuR
         8NxZdpVuPZnKcfM/2uX7rBQc/BJPz18A4cLJvyODhTcBBMNBOh06kCfqUiOqiYda+Tma
         itYCs56FAnuSIiauPhtFO8ExZ9SNEwkTwiVyQH1FwHgInteXU6w0cqSyqzkUDQSx3d0I
         dibvKx8iwsjItzU714bwW4bvXl5CF4mvg/vGe6Kj+Z4XaJEvJQEQWi0e/zgYym0IPASB
         T78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761536; x=1762366336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fM675FWHZG0xlF23ngbvLV+PkmWX/yNsjPmEemg5TU=;
        b=mQbl1NR8HERa0cZCsIvhLfOJXMSREcHnVjWkC0gT8XMvLuBa5DHTNqHx0YbblF0cEt
         716Cj/b/hMI4C1U4L9MbOonkKS1JkZAYx0kbWSpVYsJ45+T+1ZOkuZaxHLE1mJHG2b9u
         /DujbFBNh6ewdnDJTFRWpPhBghi8/iPNn/mkZpmgBi1C3GjwOCw533iryQFv5phJNu0Q
         sTCR7x+T6DIbYrMkEAaA0YFiqUDg8g1wknoweK7Hr9okif67GOIqjy+bZ2J9ObkQOEA9
         ExmulPXxE8Xu/PUyiF0PzvbjU5gJZLaIVoThiT9khUr16s2MmQaxEe3AuKuWToRNFDdV
         Q40A==
X-Forwarded-Encrypted: i=1; AJvYcCV7ImrxMn0F1LbR9qu8Fa1OF6xHJ2+kZW6B30laQRwQ+FXPJJBatxpI5Uvq8yWQFBVi60LK4MVfJEDL0ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIwWQtgc6IUIjefX8lacEGtjoz+mgs/EAomFeqvPONH4ryBzb
	dfNOGjntth8LIr1fffzV2VLmPaVMecXP4Mw8p3LUWvBDslseoZTiGPq8
X-Gm-Gg: ASbGncvf6Qj34YVRayUmy1OjBd1cKCZE9OmaC2QccrK8cmed2xtrP3cjG2Vfy50mHaH
	qBnNY5k6QOiKxgmBZc5XIDa22FtIcB4DggQETukOSo8elD2lz2E/FNbA2x/Wp89LuWfisC66gcX
	6NvY+n07Cu/ZvrRbQy6mKURsLXm6WOcXQvoD9tqdEpFjIyTNTT00TBmAIDkphW0UGi20nZjnLLp
	6MGwGfNL0VuZSKyUOhNhTowXKizdcebtYIh+MROjsD0Iek4iPVXkW1QHPKfk2sLdnOogPyysOXF
	E/TRjPc7QK3BfuC6O6BeocuJ6NytNhKm4k5KSuxxTmC3NRplokQDDsAUNoGiMw6uS4Rx9Fmeqwu
	5li0Wez+ZqM/hVF9CAUAwYIVBsKXA8Xql9oShq74xi1JProcRxcEoVYeubrWpyB68WUyOXZdx8/
	GbbOeR2zTLKdfH+C5h8w==
X-Google-Smtp-Source: AGHT+IF1iztqeEvlPkCmhJVVsUDNgxlyocxHM5e+Cao8IG24USp/FUjlf8iFINN3ikKQR8qFpw9rhg==
X-Received: by 2002:a05:6a20:3d86:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-34654af9f15mr4348450637.34.1761761535578;
        Wed, 29 Oct 2025 11:12:15 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f0c1859sm14082250a12.35.2025.10.29.11.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:12:15 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	edip@medip.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Enable mic on Vaio RPL
Date: Wed, 29 Oct 2025 15:11:52 -0300
Message-ID: <20251029181152.389302-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vaio RPL is equipped with ACL256, and needs a
fix to make the internal mic and headphone mic to work.
Also must to limits the internal microphone boost.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8ad5febd822a..cab4603c425b 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3736,6 +3736,7 @@ enum {
 	ALC285_FIXUP_ASUS_GA605K_I2C_SPEAKER2_TO_DAC1,
 	ALC269_FIXUP_POSITIVO_P15X_HEADSET_MIC,
 	ALC289_FIXUP_ASUS_ZEPHYRUS_DUAL_SPK,
+	ALC256_FIXUP_VAIO_RPL_MIC_NO_PRESENCE,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6172,6 +6173,16 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x1e, 0x90170150 }, /* Internal Speaker */
 			{ }
 		},
+	},
+	[ALC256_FIXUP_VAIO_RPL_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a1113c }, /* use as headset mic, without its own jack detect */
+			{ 0x1a, 0x22a190a0 }, /* dock mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	}
 };
 
@@ -6959,6 +6970,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL5[03]RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa554, "VAIO VJFH52", ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa559, "VAIO RPL", ALC256_FIXUP_VAIO_RPL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.47.3


