Return-Path: <linux-kernel+bounces-736362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8ECB09BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C777B0FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC72163B2;
	Fri, 18 Jul 2025 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfcoGcEb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3B15A85A;
	Fri, 18 Jul 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822203; cv=none; b=QHF1qLJnshn35fAz4LcAQbF8GCJUn7Fn0q6UwC+8oZgDawOrYnZLxUaLZhyyApid1a684SjKBWBLW8OO++9DstGMesTQ2YDPm2q7kSWIYfbRmN7UiHdhqU8TF2+YxAoImAF8kbNB+xcLQHRG00m2NLMGX2VTi1eQYZf3TvfK444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822203; c=relaxed/simple;
	bh=puaKflAZVbVMFD5nBiOHFXZGaU8XlaT+PCBxdLXAzy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/jQ4YQGY+HO9lMU9s4cogMqgEVGnIh1oFT41sI3Hh6mmjOUREYMVj/F8Qisw5BLsHJUzwISbwn3vn1Cp2WB8Pnap/WM654Ynlfo3jYrVlSFa3H130h6tDNZaPkgmdO8kswPJu/JBjDaTxaEvtSNBlZjfKe4eDjLNyaZ4Rwn0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfcoGcEb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d54214adso12469835e9.3;
        Fri, 18 Jul 2025 00:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752822200; x=1753427000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+AUdL6y+oK1soNQokvN825KQ8l33o9S+dTgZWuTu/I=;
        b=bfcoGcEbgYj7s35b+fHmblm06FJiB8lhSqdANLpfvPJVZau6avGHVvXa2lTTUwyf/u
         5ksIRys+xN6iYAVAYJYqm9I+RZByKRSVd6tpD1cAF9AgJz1q44eH0eXHBT0s7PmGkDuy
         l2jL+9f1Krm4F8k1thMaiAWERjvASmJDycBus31LHUiqQGqnhwlunLVkBDGI8xP1A126
         7KP+At/gGWk6Gl7Vz+xQoZzAW3fmOOPni1kWj9obITQJWf+BFL3p++ZcoI+JmyDNSpcV
         UbLev0arEPlD/UdkZNJZ1ust4hhS+FmhaLDMjzvNIaYWNTQv5NzBmiu+CAeXmnXmIaOB
         ezQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752822200; x=1753427000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+AUdL6y+oK1soNQokvN825KQ8l33o9S+dTgZWuTu/I=;
        b=h7nl8XskKCzd1jcyMu2+56jwllkjoYZ+CSD/WrstNKNDZc1wiFC6ZmrjDZUpIH86Wz
         bRKE1SbFk02tTfLxyYsXUu/As/sFH8Us4wv70bjI17m8kbTnE6Kz6EypLhnNxyPJ0wR5
         sB8xcOp6WoXf62mzo0d+PTAWd61EplUCm1CpnT4iNjs2O1iBSHatastCOmVZwdVAU0Ok
         z8D7wDBK5nzVA8OAlT4vFtTRD3RtDJ+dqIXTzGAEuYzE+L7+Wau3LCA3Qp3nzXvLj4mT
         10ZX9zkqhY2wPQl8Q3WoBUlyQ57xmCunWGXSzbySyISVzwtJQMw206nq7IXlLp9wFDm7
         0w1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzr0SITjvxvMCys+H+rzHS34Drz+iGde9KdTP94Yj619d41ILz1NBRbmAWQfll5T9yD+hASJLHtEo1rq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoQq3h3SqwuofUGQM9ZTQVDMWZyw3agp+JVSjNzpFnoY17DgE
	G2A+Evv49+8lwJEWGMdYufec8aPAmSecEC2XLPTYDNCK2RwSXyctBGBk4ELuFw==
X-Gm-Gg: ASbGncvXT3BgZ1bKh223HiN0AHtvv+xPpEjHab3jKbVYTSNK4KRDJ+Ju0bjnHcr8wMQ
	/z2kjAxKqtCHihd2BbxIlMmIdhsw7Qwb/tKB7u0/TKgnHzpLstzaM0wITX+FSEk7GwV3uqPicLf
	uTVDtMFR8dsfs74eAFcBtV2HovFrKM1JL/+YiobGjmVDC1SWwraFRkyIspOPg6nYCc+FJGTTD/8
	7KWv+VdqWIID3rswdc9eYzD1eiTsAvZ+sWuNWc5yFQ4lqzo99Qhg/s2S7cj/Qq04sE9pXGxXhRM
	y6cufjM1VNLaeNWp+ftb6PHdx95tHTAdDDx1XNthjgvJsKUbSiYxHAI6w2hR4eVHn+gmbnDfBub
	RWGppHMM77ksG7QyAvhs=
X-Google-Smtp-Source: AGHT+IEK6IijGOqIAA8ZMcPq5fnNjR9guJvf40cs2kjl5V20dmhJxKF5UttQQH9/cJwfNk9EHtKe7Q==
X-Received: by 2002:a05:600c:3b11:b0:456:11db:2f0f with SMTP id 5b1f17b1804b1-4563532c395mr52415055e9.16.1752822200153;
        Fri, 18 Jul 2025 00:03:20 -0700 (PDT)
Received: from pc.. ([102.208.164.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d786sm979063f8f.72.2025.07.18.00.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:03:19 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH v3] ALSA: usb: qcom: Adjust mutex unlock order
Date: Fri, 18 Jul 2025 10:03:08 +0300
Message-ID: <20250718070309.441282-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mutexes qdev_mutex and chip->mutex are acquired in that order
throughout the driver. To preserve proper lock hierarchy and avoid
potential deadlocks, they must be released in the reverse
order of acquisition.

This change reorders the unlock sequence to first release chip->mutex
followed by qdev_mutex, ensuring consistency with the locking pattern.

Fixes: e2710ea98124 ("staging: sound: Adjust mutex unlock order")

changes since v2:
 - Use a proper subject prefix and add the fixes tag.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 sound/usb/qcom/qc_audio_offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 3543b5a53592..711f5612a83a 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -825,8 +825,8 @@ static int uaudio_sideband_notifier(struct usb_interface *intf,
 		}
 	}
 
-	mutex_unlock(&qdev_mutex);
 	mutex_unlock(&chip->mutex);
+	mutex_unlock(&qdev_mutex);
 
 	return 0;
 }
@@ -1865,8 +1865,8 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
 
 	/* Device has already been cleaned up, or never populated */
 	if (!dev->chip) {
-		mutex_unlock(&qdev_mutex);
 		mutex_unlock(&chip->mutex);
+		mutex_unlock(&qdev_mutex);
 		return;
 	}
 
@@ -1921,8 +1921,8 @@ static void qc_usb_audio_offload_suspend(struct usb_interface *intf,
 
 	uaudio_send_disconnect_ind(chip);
 
+        mutex_unlock(&chip->mutex);
 	mutex_unlock(&qdev_mutex);
-	mutex_unlock(&chip->mutex);
 }
 
 static struct snd_usb_platform_ops offload_ops = {
-- 
2.43.0


