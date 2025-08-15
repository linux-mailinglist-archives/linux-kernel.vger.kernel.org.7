Return-Path: <linux-kernel+bounces-770153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701BB277BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB708727F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA988231856;
	Fri, 15 Aug 2025 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSPFr74g"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A391CD215;
	Fri, 15 Aug 2025 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231719; cv=none; b=Xh4K3It+Mw1JpQ2zfRJ57J7d9grCTHJ7xYovxSeVDppB4WHUQq9sGMUzVWF+LBzFnXfkD990Sf8nyESoOUfWSlt6vAxj90oRfJY8kzFYO/nyWCBoyB8LaPxaVD90Qcgn/x0hVUmhy5o6Jlz5mKZH14XiLsOn42pnANmfOhhm7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231719; c=relaxed/simple;
	bh=RmAkGq6W4WlUqzQXHGqGnRGBMlL425ZqNLgZsMOdfio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGXP7FW5dTPHxKzwarO0lI/zcAUWFvmtgohhUZlfphVmDuj78iDZ7b2FyEgIdO286NhnhIT5qRycpPTAQ5yQmBDbHYIAcowshcYypJ/A//rzJJqVURbs0Xx1PsX54N+14yI0qN0Ph8NTlWtJkh7wyXCVMQOYiMQCsomVA7LJwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSPFr74g; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e57376f638so3895535ab.1;
        Thu, 14 Aug 2025 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755231716; x=1755836516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MY9UWLRYUehtd8TTSjgdbfjrvmnJ4bqiAl1A8JyFtM=;
        b=FSPFr74gSmztslSiBp+cV/baUU1/hnC6GpYBSTCpwNhI/89yL7QNhQ4BoxPLdixHVW
         TLxnCasTmWQgG7jXSqyCUhPxq+NIl09TD0hrlrqKHW7D+HXGhvhWV/HFGovTbm8xf0MS
         ttwgQr79Ep97S2uE1+pAL/Xx+sKx0OObOgML2TeWOYXFzCpevixyuWWk4cxX1OnMPvbW
         +FWyK9Z2FSQYu7Ic9AhgUg2ZskSq8UuwIaNrsMY1CQHIRiJ39OcVHBsLdS/GZoMfRQOL
         mOGCDftwZ+q/grIjRrsj/j6WEasA6tPNNdK7zHMwAYxiu+HU93UKPLgWJ98dOeaDCfkP
         ecbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231716; x=1755836516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MY9UWLRYUehtd8TTSjgdbfjrvmnJ4bqiAl1A8JyFtM=;
        b=Zh6S0felJ9fNN5PG5x+snjCPmWW8FbI/CoR5o34Ha2SsXl9SgpuI0cUYVDUY2WxFKg
         ZbpkjhzuPU+f9IfJx4urDsiFV0B7uK/lyhhx+ztqAYp03OEgUIzyPZxv/We0tFC+ycTk
         uJQv8k2c7aHfKvsBwQAkuY1VtkvCFQsfb5VClflXDtiBjW0PdJF8k37U8c5pfz4nR/Tj
         XBFMQ8Y58QLFsTxTSb9YJFfEA+t7f6Bj1akyhpZ2nR7O+bbaos5XRPfnk5nFIgG5CE6F
         48SYK87BTiYMmi8aVfk5dqKvc75lNxYSYgaURtx+Rk6kJXivWshQcBlX6XiWgiTzkgUW
         sL9A==
X-Forwarded-Encrypted: i=1; AJvYcCXgAWE15zDXPurQMeRaKx0sFkMxc42Dzoc4Mb2hDfTAs54vE7V0myfMbcHd/CIFo5JjPt65eitXLsWqIj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqogCQXVhpjsW1Vq4FfXfdZjusBdjytLd0/QsP7BHyjjplLvth
	uJFbG1oDIQBjXsjAsZzsZknC0f5fJGgAGwYl08YdRyDzZmU8Ctq5sjmN
X-Gm-Gg: ASbGncvzWYi5+z+r5STIKyrfA5zjfG/uCEwPREXlVFVkpfIIHPF6E7bYJloosDT36ZU
	Fd1E5m8mg04TIh9c9GllANH/VtI/SQenqpv8OC3K6HrwsciJNgm5iKK5CjKHOXdNXq/WdQvCoTN
	8xAe3Yatzdns/T/ddni6o1cP2HK8jGo61OS+a6q+etFGks6jkK103WrSgkyOPlvl6ewoPuMzqEw
	nCfcldB/yS+Ruq0/uyRUvJe1+G423DdVQKDdIcgi0C1xbAPr0atpAzbOPovbyqF2wno2RliGjav
	fAb1/BMXCR4B72d0JurIZbkPzUNh3jUsShzabI4wHgODum10oFxhv/BKHqbiXS7GxFqI8GyHOwQ
	kSTc1GhGuXL9QtGHdLzIZ+QftcfVRx6t/5txjdJDJZz0QV6A3ImB+zROUsjXZ3JesfO4=
X-Google-Smtp-Source: AGHT+IEvdihc3ix/SVgsBXg4IlLTvFH75x9CWs/xiTB3HkO78Mc2w/YasOw5+CLfwS3E/L11rkqn/g==
X-Received: by 2002:a05:6e02:1808:b0:3e4:2ea:bbf5 with SMTP id e9e14a558f8ab-3e57e9c1bddmr13105085ab.21.1755231715678;
        Thu, 14 Aug 2025 21:21:55 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e5a585esm1689365ab.16.2025.08.14.21.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 21:21:55 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	shimrrashai@gmail.com
Subject: [PATCH 3/3] ASoC: es8323: enable DAPM power widgets for playback DAC
Date: Thu, 14 Aug 2025 23:20:23 -0500
Message-ID: <20250815042023.115485-4-shimrrashai@gmail.com>
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

This part might not be needed for resubmission as it was already
accepted on the previous submission of this patch, but since the whole
series was not accepted due to that I had retained and expanded the
initialization in the probe routine I'm not sure if I should submit
it again.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 sound/soc/codecs/es8323.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index 79f1fa967..eb85b71e8 100644
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


