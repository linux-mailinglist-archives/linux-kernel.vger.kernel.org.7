Return-Path: <linux-kernel+bounces-827441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4DB91C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042972A452B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE227F732;
	Mon, 22 Sep 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq45ijOg"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D322D4DD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552187; cv=none; b=dJhAes2YkwKl/A7Q93XfB+ZTjKGPWwpTvXaHmw5aGZEEGxoS5jfslGABsN46jwpkh5ROYN31Z07TL21AdmUiJqdTmT+UtNMdJ4ontZQhmMlWziV5CsJDy26NNkJkRDw9K48Cc8A/FGZutLcRxrrD04BFha/n6PYMgttQg1RWJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552187; c=relaxed/simple;
	bh=GNd0y4cVbWPetSA78wepeAR7zoMfnuBG+rjT2H3cUJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBb5cmeSAUfkLD0LTY0jaZgIYjSHy3JeF8f5b8W0TYnjsS/9rvctOfJiKa+cfPboGnZ4gLOV0mZ675emkDS8D5VmVv6K2iVB/L0WoTokge0+pYfQHq68nJk/LbCPRPjKomFf4XEEKy0U2rh4oG1GBB2Mbz7eJg9bom6o0LvL77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq45ijOg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-363be237227so30404331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552184; x=1759156984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtIdBcXjvQm0npfMBQTkmT+Qi8zM6Vw8hQsMj63CDrk=;
        b=bq45ijOgAmprZnywT9pQa4Os54Gc44xFaAHmLAwbL/7fvG2rR1EFAhdcvhfiVQPF4R
         QZ6/Dmx+6D/eCeKSWEq4oW5ARx7fLihN6aI5PFjr5gQvDM8RugKIfSdNKJSfR4KbAQ4b
         cNozQm6aiPcWRLG23ktDWtfx7DFoZJkGjBLEc78+cdpIZNWFmk2hxHItnJFf5+KXH83K
         WsM7zV6gNNic9JNsfgyPLbY+skaQg40+6Jd2ThqVznDWkd8d3C26lFtwrtGEuZ8d9LK3
         Yi+FnNjAY99alx6nGy/vNqKZgoZBlkTRNDhxtaayMGY9ujGknln517P5cJaExfh9oqP+
         uWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552184; x=1759156984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtIdBcXjvQm0npfMBQTkmT+Qi8zM6Vw8hQsMj63CDrk=;
        b=HvgkRvY3eiM6rd2irl+0rkRg1FiwETX/IoOK8Y9qSORyqrRmCfA3cZs8uHLTQFeiwE
         CKYV5wR4ShtPxRFThrOJ+P6JgKerGjN9QIi7eWlDakuNCJVcM66JPBXYJNYQbM3drU4d
         tAdy/0UMcj6MbvI+N1A3P3lNEtPW4gjJ3zvGlan4advaTbR6x9J51Sh1rFT70fNUAdSZ
         B684r+6SBhcv4u2txckwtPVJic7CNRiVyMU7GDOtpDjqMG4y4m+UsGLdd3R5D8U1iRWw
         210kmDVdBxjqaPa8q+7Q48Z5jmw/tF1ax12vOYea3fiutqmD7Kk06WIa/7TjScLiFhze
         q7/g==
X-Forwarded-Encrypted: i=1; AJvYcCWUrbuok0hZgpyLIh7/6yReiIi4tftWQVAycRAPc0jR6fV3mYpsAPYAIgaLNtEmUP/iLWmuL+CffUDwIIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHdYH3a4JHdUm2gSux/QFhnZ0/bNhR3RMp+4AdlEv8H3Nk8ql
	3eo695jusGYWAt2Hm7hnFDYhDih6FNDaEeWIIlkhgQth8IYeBF/A+FTd
X-Gm-Gg: ASbGncsTBQQO6q/W3XzZBmwX+bVAuRWhhgBcaurs88NpUAQRacoV9SgXWcD64P9ABrg
	QRVpXmvBAZVYLQ2q7MKdVgNFKmg/e/s5FZcAaBllQmAasFxVimRRLqXez8KkuZiCkuj4Rqk8f4m
	QPQmuZ4tI290fUmDfSm4HUBfIc1FW9XrCwiNPCU2xXyEymI2Qy7RByKrLX/j6dwmhKZOMIHd+vl
	g672YLfSmq4ksTWePdZ59RFxFyDFZdbqiQ2kwS8qyuO0m/RbjOne5HX+SY/TjssHl2KVy9Zj51/
	bgl4zEABnhx6dZ73H69Cme6ngLODrObB+jW97lOMXkuQY5Lnl+Bo3Sf82w4Fq8jc7GcstgA1omB
	G/7AkG19dBT6z1TdGd6VEgid71yp6xwbl5LIbbr2ltbYh8Ri1sEh/tZHRFj//Hb1zCnHKHWncCJ
	9uybRz554m33m4AR9s
X-Google-Smtp-Source: AGHT+IEyiePhldEEUbZLhZdpleCuDyBFXuJfswMLKkVPADF+9ubU/JrFMn02YfNheZiFsLVEtydyuw==
X-Received: by 2002:a05:651c:4413:20b0:360:3fc1:28a3 with SMTP id 38308e7fff4ca-36418ed0e80mr31697991fa.38.1758552183370;
        Mon, 22 Sep 2025 07:43:03 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a25d7309sm30492541fa.15.2025.09.22.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:43:03 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] rtc: fix error return in pm80x_rtc_set_alarm()
Date: Mon, 22 Sep 2025 17:42:58 +0300
Message-ID: <20250922144300.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

Return value of function 'regmap_raw_write', called at rtc-88pm80x.c:205, 
is not checked, but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>

---
 drivers/rtc/rtc-88pm80x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f40cc06b0979..82984a58dca7 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -173,7 +173,7 @@ static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time now_tm, alarm_tm;
 	unsigned long ticks, base, data;
 	unsigned char buf[4];
-	int mask;
+	int mask, ret;
 
 	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_ALARM1_EN, 0);
 
@@ -202,7 +202,9 @@ static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	buf[1] = (data >> 8) & 0xff;
 	buf[2] = (data >> 16) & 0xff;
 	buf[3] = (data >> 24) & 0xff;
-	regmap_raw_write(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
+	ret = regmap_raw_write(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
+	if (ret)
+		return ret;
 	if (alrm->enabled) {
 		mask = PM800_ALARM | PM800_ALARM_WAKEUP | PM800_ALARM1_EN;
 		regmap_update_bits(info->map, PM800_RTC_CONTROL, mask, mask);
-- 
2.43.0


