Return-Path: <linux-kernel+bounces-770152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B5B277B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574F41CC0AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C423C397;
	Fri, 15 Aug 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFF7fRqk"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D7215062;
	Fri, 15 Aug 2025 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231709; cv=none; b=lYZZWRvJX8CKR8KtbtdopadDhrryymn2eAZPJqGIswTfKtwazZKwnBLC+a8p4aJieigNMWf8IMX4IjNWqER5X064e2Xac8Hl3LGSEJCNP2Lrd3D9uAmlfw6LVEXn52yq09U/YPYdalNWyoNmuDru9y0+RKlRdSmfHfhFAKsbpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231709; c=relaxed/simple;
	bh=yYU3BGY8apJ7/bVxueA9JZ+trRFHpqUCjdyPBdS65Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxxj4yEhtm56eP/ai2IPpgwbWeUa3apSt7Q8OhU6AkVFpWBNq9op7nzEOcQ6oSiBU/hJvZsd48yXjfc/EsCqBi4S8CDfeIWD5MAv8SoHQqG5yBxvPtrcufF17Olpp1iuTJlWfZlI/9/Hab8uDU8BIM1ylou2b1F6tKekdaNBZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFF7fRqk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e575ff1b80so5495985ab.3;
        Thu, 14 Aug 2025 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755231707; x=1755836507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQaQCUUCbOrsHCY9Z7BsQ0uU/8o3MVoc/bvLf/aDeTs=;
        b=PFF7fRqkitizFtBCmrYMEo9Lux7VUeAujWNR/Fi/mz+a3puDRol9hwTi9wd2aFXY/E
         lYcFQEhz4XSZVIavBqa3mQS1BNPR84z7+Q5BoFJCLLZ6UaBRMh354Ix57jcGVOGkEKfp
         XohLzWydPTgEjVterDYG6WDaia4wi+wExUVUDAiMEJfOF+Mxo+kQzmIp2If1oKh+l0xM
         ekbU8Ua25MFcT4kD8gQo4GPspzSXZrHEuIVFlA6WSHoENAQzvjaw5fevit2CHuV9L9NI
         Ef73eB8ZaiWdq/InVayZCt7/q+esvbUo7ds/jarGLpaY/pXgrjtT//REiRxTRPBvBnTV
         t+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231707; x=1755836507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQaQCUUCbOrsHCY9Z7BsQ0uU/8o3MVoc/bvLf/aDeTs=;
        b=gVHBYUmqONoyukB2q1y/MoHkNBsXFhfpO73zUpTUFzI0vncp8Lnn+0njviGIIFcNZh
         n6s/N1bEWV4k0G5c2+m3GYQXEYtQIV9YHDaoGtHT9hvZZuTLeCokJvsUGjBn4oY6bVw/
         KrNVQMiZEF3Q3+XHjdaW12aPPpDZ6ewVDaFt5MpsBmlYfu2wm990AnMRFo0Ao6Ujz74y
         X4hoQ74RWM65VJSvWOD93oGS/fJDGknhuyfwzQL7pwJ20P1Ob7tTTeByitGUDEXMANvk
         GR1cfmlB/Kaobs0Pgf+ia1GQREv6vUh7uZC1AdbuUZ1retNwHZizwTMiBMf3uDkhzw/4
         R2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhAX9v+dZ33R60/6nVa7YwlbZp/TA4wiLHQ5gVZ3wYQiAcKiYVNgK1M0Vm4H6BSDOjxJXyocQIdyRoDcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9fdv1lmkIlfWolntsJTC0uQXTNSTGh3AOiOkMscyxzGLUwBJ
	4kEua4wlYX+ewCDK/BiVEFbOSv/+BG657vENKYdH6Fw96rjVXw62i2gU
X-Gm-Gg: ASbGncusb/7lBwwVKT3DhJaIiZOxHEk0PaBFDaYulwVzzfLe1sSd2wASQmxBMhPs9s7
	kaHBEXEWUCfR7PSvmHA/JgW5yw6Lqosqcbql0MlVEhYI2gg74+pQgL9HhEqvpMnLSpnV84HLNCm
	+loGQ51Zt1umjl7rO+2ZsmwSzaXAK5d6jHx7WIrfbwefPOKqiNlJJPBD/Eadfr6YN2Nt3wm1GmU
	/JvvxI5ygPK5L5AyHkUsvnU7ce4gG5IwRI4c8QDNUoE5CTW4vFUfBcNCIZNQ31vYpmMufEpoGzU
	jXUsSPUPJEPht/bROZD0udZKJrw85rvASU7L0hxdqCqe+lt20L4O3sm0ogxYXjcGTvDCg3C3GXK
	RniCsUpsiCtIWwW8KzFAHOwAEwE/mIqOFyvbXHVWPcEzz/lf3oJS+sW5adip6tVXJ1LExw/qI3j
	uOTA==
X-Google-Smtp-Source: AGHT+IF6eJniCFCdaYOLX9voLhd8W5yzM9nF+Is9Q9zOcgxX03gda7Mqvx74f+HDrW5PoHAVO5pobw==
X-Received: by 2002:a92:c24d:0:b0:3e5:4fee:75e8 with SMTP id e9e14a558f8ab-3e57e9dd050mr10205665ab.20.1755231706763;
        Thu, 14 Aug 2025 21:21:46 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e5a585esm1689365ab.16.2025.08.14.21.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 21:21:46 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	shimrrashai@gmail.com
Subject: [PATCH 2/3] ASoC: es8323: add proper left/right mixer controls via DAPM
Date: Thu, 14 Aug 2025 23:20:22 -0500
Message-ID: <20250815042023.115485-3-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250815042023.115485-1-shimrrashai@gmail.com>
References: <20250815042023.115485-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper DAC and mixer controls to DAPM; no initialization in
es8323_probe.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 sound/soc/codecs/es8323.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index 194720e4d..79f1fa967 100644
--- a/sound/soc/codecs/es8323.c
+++ b/sound/soc/codecs/es8323.c
@@ -182,13 +182,13 @@ static const struct snd_kcontrol_new es8323_mono_adc_mux_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8323_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left Playback Switch", SND_SOC_NOPM, 7, 1, 1),
+	SOC_DAPM_SINGLE("Left Playback Switch", ES8323_DACCONTROL17, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8323_DACCONTROL17, 6, 1, 0),
 };
 
 /* Right Mixer */
 static const struct snd_kcontrol_new es8323_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Right Playback Switch", SND_SOC_NOPM, 6, 1, 1),
+	SOC_DAPM_SINGLE("Right Playback Switch", ES8323_DACCONTROL20, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8323_DACCONTROL20, 6, 1, 0),
 };
 
-- 
2.48.1


