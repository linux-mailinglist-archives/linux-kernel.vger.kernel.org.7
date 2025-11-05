Return-Path: <linux-kernel+bounces-886331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFC3C3541F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3C684FCE0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DB30E0E3;
	Wed,  5 Nov 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcUxhazb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833A2EB87C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340012; cv=none; b=qQ+wXUA8oLn4nDQsFtPj2O+5kNLgKh4uRKEO7QBhOF3FX9bWc9PrTCUQ2VzytmKLc/ko3vj6H5rixSssXkuwwX2Cj1PYc1+w0JYucjZQ4ZdMCi1wBF8PlJJyTjwIQ30IXwJktI0rg+8yPAKbER8gXlqsmNPiY7ag/zuDtyE1W6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340012; c=relaxed/simple;
	bh=pCfrLcsz8t3wMBF3ucd8fQ0q25ppFlOvrgMTbR34P9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1x4OG1AOA7qKkVsVNsdaWwcUxca5CfLIrVh3nEIsL1Vs3ciEsyTL10RF8Dj/fOSnqHXAWwV4u2BmB69Yo3HkWSsGU/rEEA17sWajhkXAITioj+IHDlwJWKwGcfwroFMaLAK3Y/1B/EKueKYbweZa0N/JEpwVP2qsReRFkeKlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcUxhazb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so35536305e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762340009; x=1762944809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTDLgP3DABV4u5DAGZmkJHSeQLSJsvns9tvea9ggc54=;
        b=gcUxhazb4+NKzi7MiwQ+pIUUBC6vGngVGbFCoAKfdA3B2V5C4W0Q9RZzKBkOqGAe0t
         4RiQJJGZ43HrQ4iXRoCJtJ+oqkY9hqQL0br2pYJ++GnIcv/k655ifPyP1sUghVR6vMCt
         E6HaS52sc/dlfdW3wE8j2AWphUtRJa9KuTSPsJf9wokLoYFW0btwqwJdPXxb3Lxj35hv
         Xy6l8WiPbS+RzXNG9ir04GfYiIJ9F38mac1wWNp+MT2CCTMlT5SevBwtfhq2+jvS0/VV
         xF/g8g0sG8Sv4J5lANd5JFf1Zig+LzOHm/mXTrc+/0gQThBsSmnuhw8ywbYoNI3vJuGs
         /UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340009; x=1762944809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTDLgP3DABV4u5DAGZmkJHSeQLSJsvns9tvea9ggc54=;
        b=KgperJxJcO/sPU67GwSxhbcDtWVh+OECwnuiHifttDo9dGLh3piPl/rEwsKAImk1R8
         knm33GHPlof+xsk/1i4XySyH9dVT19ZdpsJznkoJIWWla5qytv1ztsHsSvRP8am1ug0Q
         t1f/Dt+PcE9J101Y1Ps2X3gO0uR2SqNyjvsmOMA10suG1fqTW+SVCTrlkVBYOLn7y8r0
         Pnb0MdrDMorrnx0mwR8UbqZJwN8/ZsIMrYm0NM0dBDkqrNEYxOvBsGR1q6mBOU+vw/7S
         Upf3xvtHu9llgY6NCIEbnEoewv5rzdC+MaEmPgqtadY/ISh6t3TdiAnM6koq4x97F3vJ
         QW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/yYT9ebxpQIKtVGx/soZOTl3GEddHhfiak0FXPgKKGX0WT5xE2JGV7QqxSDtvyhX4FQloOdISOPI/tOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzzDs1lrZkEv4TCU8AgXgEltO19wuyumGQOMDBliOh4tTSHmD9
	LBS94VLWcx4DZMKFJfMe4WFJMW74amEEkmVjo7JO6nnLnZPpRMWaFXIM
X-Gm-Gg: ASbGncv50KjtVRpKt4wUo/XZM206fLgXTVafugksZ1FL1diS5iHNM2BFpsS1fggxqVJ
	442rhEi2etYbJZS1a17X/eddJj9kbAk2CezA8zZ+YOz9Z07WaQKGfHDxFHp/u4lkdVw5fubtHRP
	qMpYgxuTFYPh0x4/rWWKnaX5SLHAgx3TlU/2oT5rY9mNwNy7zZ/UdgG2TOPTL9zZPfRjywT6UYT
	uHwnInOwDBkbZwNWLr28TOjEKFjdXVTXFTZXecVy99aYzUUTlBtqnjAKHMUpmW75TKZLRr5Ndse
	vGxJIA3AvliHZYq7v5FyLigemLO+wUgXodq6Z4LgAIwhqKqxaVpWbVOTjvFKpAPUweMHO5REh86
	FawM5UqTj46OmqdHaNkNeucUYprn06R1uM8wBp+HTajuW1iRVNLjU1c3RbToBEs7n/DmzlufNpH
	57h6Y=
X-Google-Smtp-Source: AGHT+IH2YiAiQPeSvIZ6vlvughXEURO+RpbCjAPdtyKrRX2M/2lmyFu5+eM3XsBvCr4GOqHtGIAcYQ==
X-Received: by 2002:a05:600c:4e0f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-4775cdf26d7mr22907745e9.31.1762340008390;
        Wed, 05 Nov 2025 02:53:28 -0800 (PST)
Received: from gmail.com ([147.161.143.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5ccasm9562064f8f.25.2025.11.05.02.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:53:28 -0800 (PST)
From: hariconscious@gmail.com
To: perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ALSA: ac97: Fix kernel-doc warning for snd_ac97_reset
Date: Wed,  5 Nov 2025 16:22:30 +0530
Message-ID: <20251105105229.112172-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

kernel-doc populated the below warning for the non
static function "snd_ac97_reset".
"Warning: ./sound/ac97_bus.c:56 No description found
for return value of 'snd_ac97_reset'".
Added the return values as per the kernel-doc format.

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
 sound/ac97_bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index 1484fc178fa4..8a44297964f5 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -46,11 +46,14 @@ static bool snd_ac97_check_id(struct snd_ac97 *ac97, unsigned int id,
  * @id_mask: Mask that is applied to the device ID before comparing to @id
  *
  * This function resets the AC'97 device. If @try_warm is true the function
- * first performs a warm reset. If the warm reset is successful the function
- * returns 1. Otherwise or if @try_warm is false the function issues cold reset
- * followed by a warm reset. If this is successful the function returns 0,
- * otherwise a negative error code. If @id is 0 any valid device ID will be
- * accepted, otherwise only the ID that matches @id and @id_mask is accepted.
+ * first performs a warm reset. If @try_warm is false the function issues
+ * cold reset followed by a warm reset. If @id is 0 any valid device ID
+ * will be accepted, otherwise only the ID that matches @id and @id_mask
+ * is accepted.
+ * Returns:
+ * * %1 - if warm reset is successful
+ * * %0 - if cold reset and warm reset is successful
+ * * %-ENODEV - if @id and @id_mask not matching
  */
 int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
 	unsigned int id_mask)

base-commit: 284922f4c563aa3a8558a00f2a05722133237fe8
-- 
2.43.0


