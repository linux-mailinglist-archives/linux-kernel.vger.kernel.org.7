Return-Path: <linux-kernel+bounces-767804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC4B25949
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CCF189CCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7125B2367D3;
	Thu, 14 Aug 2025 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojc74v01"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DC207669;
	Thu, 14 Aug 2025 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136179; cv=none; b=H0Huo3m7KviNFb8NzwbLrPEH3hpLC0XL+sjwtLnbtCQg9NIqpbovRDYXz0EKd5siB4rvol4Iz0qDYRrlK+l4U3zhexYYR/1bG2SVCs9S2QOeB63m6GeMgiF4zV7hd0ZzCr7AzbxE1nhz0WDwQlK1l1noUXlrZj4iY4j6/1yDYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136179; c=relaxed/simple;
	bh=B0xdzeULKUZRjF9E8YqY/7sH1mFLSYGOIl8Wv9YmDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuWagF1nQFvtIRnWIskYR5xiGj6OX4IW4HQrM586wCZWMv8vYfqojmpqVrrPwCr33yk85G5vvueDvF9yO89zBcyJ+eMdfLGqigGO2Q6GB4dfJb9f2vrEv+Hat4Lc9zqu1UGGCXjZUbuwP25CKuKTEYEDbQ/SZGppHcTWO6viVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojc74v01; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e56fe580b4so2401535ab.0;
        Wed, 13 Aug 2025 18:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755136177; x=1755740977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4pLXU0n7BAcBKqiGQRP8uQb2cv5qGo+5UXTxa6jgAo=;
        b=Ojc74v01e2ym/bucyISRiU1uQYSepVaDg0msP7wlrosBMBRAVO1jyERSV9mBkHR+Ob
         siINPyk2tKVqjHOYr2pm8QzxgxlbkgayjVKHivT+1AtIbcjQKbNdHTS+D2oKXR/MFArm
         kEwSuomU9xlZLky5WNu33qzcq7v2Vf4P5o/1ZJ/HevG2lU3SFb6n88JgdLWjgWkTvBWe
         KEzoy7frsPEjyvMPCsgmNOh8e/U3iELuA9mF+i1HFcLrxJP66TLhVLj+rGIOc6NFm8Fq
         fTdBmRVgvuixYT0ADDNQNvcCVcHmC0FZsKW6ExMgRaqMjfKiTvmIzcPvYSo+OqSfCPmZ
         QR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755136177; x=1755740977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4pLXU0n7BAcBKqiGQRP8uQb2cv5qGo+5UXTxa6jgAo=;
        b=YMmx+yFUPiaWVrqy6z3gMuiqQGWAClzjgLqJORGR/WBYro9+kcQznLbb1HYMO7AlLJ
         g5dOpZ5YT9JE7E353rgSI4s7kNcf5Ztg6Le5oZ8URe81mkMGboLt4nJFhB4laEjRbc2L
         pHFvjGSX6oh/ftLXhQt+jhI/FnolfFdSAwL8CugqouSvZafF9vKgoJ4EQN7TXkRADXnu
         B1rzXDFOfo7MReBc4osps0IydzjWke3/owZdcWe5ia2RKjTnQKTSFqd0M/wE3UAYeoV3
         3BpyEbA2W+CKTNBVgi2Cn+l0j3ePc+n96AQnM3Lfp8KwmUXewDk+yuabLOjdRoUJYTIf
         nMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzZBRTYL/GxgJYP9XZ+q+9k4mEcfYktMZiBO/sCWK5cKbtDxDBasXbDDqbBJSCqF9Ld/+3qZvJbdpt7pU=@vger.kernel.org, AJvYcCXZdfdkzhGcHuUlL4EzR1XfmAZkoouyZRNVmn7LYev1RrRhZYCoD7CkSDVF4mWXhq62WoG7RzY27lP/WzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RXYqhTDdeTnB6/jb0E6cUP1U5oAYMLL8YbsybeMIqAFDZv2i
	cCV649SS/x01Lg4B+ngpOlyCiTd0xQRsHOMDPk7IzmnYf06pqWpw8f67
X-Gm-Gg: ASbGnct5bK6g8yB5dAjwwrtR9y75knr4DDpfoxdMfv+Uj0cyEvaZd1YI2+y6rZofrvM
	JwI204MgHgfM5JVHQEg+1KjNUrADnc/e71iIGl0IJKfytWDqZ3EXkWEXrIemh31+c3eSQKhgiMZ
	LXnD1XX2ZnhBdo53l+IRKSwT6PxObl1trg6p/O++7Atjh/ig6XmK4EjMYkLXDB7vDpmF7LTiEYd
	kW3hzcEeBYq4WZo8RNTvcBhrEbrnwXf2eBWGf2LZlOjUGeDwvVRdy2pUgdQXtF2UisuZqc3UdIL
	CAmwNylpIMIzWT42Bo8k1+kGH4JfW1Reo6fp/pvoSVPo1OBXlXKOrYnF0ibkZak0XccVVKw7+5E
	MTE6voODxG1b8mVdSIFWyo7MK+bbzxOeE/heYqHt3+im6yCdI7cwoNw6xX7HlbctwZ30=
X-Google-Smtp-Source: AGHT+IHngP17AdLmxbCHMs/VidAlVpTonAs4P8vmMx9bkF61S2ltC5HXD+0ZuFqVzvZXJQtsIJG9/g==
X-Received: by 2002:a05:6e02:148b:b0:3e5:52a3:daf8 with SMTP id e9e14a558f8ab-3e570740f02mr28296575ab.5.1755136177461;
        Wed, 13 Aug 2025 18:49:37 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e55e2aa855sm20977405ab.47.2025.08.13.18.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:49:37 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH 2/2] ASoC: es8323: enable DAPM power widgets for playback DAC and output
Date: Wed, 13 Aug 2025 20:49:19 -0500
Message-ID: <20250814014919.87170-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250814012652.81424-1-shimrrashai@gmail.com>
References: <20250814012652.81424-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable DAPM widgets for power and volume control of playback.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 sound/soc/codecs/es8323.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index 3a91713bd..8d360cb79 100644
--- a/sound/soc/codecs/es8323.c
+++ b/sound/soc/codecs/es8323.c
@@ -211,8 +211,8 @@ static const struct snd_soc_dapm_widget es8323_dapm_widgets[] = {
 
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", SND_SOC_NOPM, 4, 1),
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", SND_SOC_NOPM, 5, 1),
-	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", SND_SOC_NOPM, 6, 1),
-	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", SND_SOC_NOPM, 7, 1),
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", ES8323_DACPOWER, 6, 1),
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", ES8323_DACPOWER, 7, 1),
 
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
 			   &es8323_left_mixer_controls[0],
@@ -223,10 +223,10 @@ static const struct snd_soc_dapm_widget es8323_dapm_widgets[] = {
 
 	SND_SOC_DAPM_PGA("Right ADC Power", SND_SOC_NOPM, 6, 1, NULL, 0),
 	SND_SOC_DAPM_PGA("Left ADC Power", SND_SOC_NOPM, 7, 1, NULL, 0),
-	SND_SOC_DAPM_PGA("Right Out 2", SND_SOC_NOPM, 2, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Left Out 2", SND_SOC_NOPM, 3, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Right Out 1", SND_SOC_NOPM, 4, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Left Out 1", SND_SOC_NOPM, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Out 2", ES8323_DACPOWER, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 2", ES8323_DACPOWER, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Out 1", ES8323_DACPOWER, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 1", ES8323_DACPOWER, 5, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("LAMP", ES8323_ADCCONTROL1, 4, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("RAMP", ES8323_ADCCONTROL1, 0, 0, NULL, 0),
 
-- 
2.48.1


