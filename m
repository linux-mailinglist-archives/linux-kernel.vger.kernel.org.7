Return-Path: <linux-kernel+bounces-840051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC1CBB36C8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDA73A933A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F82F9D9E;
	Thu,  2 Oct 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSuBz+7k"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96102EFD89
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396618; cv=none; b=puIZ3XuYlqTeScK6mCsdeP6K4eHLIJslmATg7tXLpcjLkAu7B699VOfVzE+K5qur5sUb1VUjhsWBl8URiwScalcEKGsThwh8IrWZY278SF0O/yK47KNX9KodWr51yrpoEOFvhnqa+hbVJx1D7NJY5M61jCHms8QM2K+t7EDPkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396618; c=relaxed/simple;
	bh=3ONPV3iuwid4tuzGNY1hJ25itYLRoKeEE5z0jRpe1s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQQxzrz1Vw+calbRf2tD2vlZY01IT++Xb202Q6IhGQ4uEAcfE9Cc/mAmuV6XlUPAJ5KotqQfy1XqU0Z9vcAxFfIl8wvvZcSlxtoC7GwwFifK8/r7qEVzfg2J7Wak1PxvquywJGcvmuMKWGx095khDV6n1xNAzAclIr+MGlkaUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSuBz+7k; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso2674482e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396615; x=1760001415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApE4Y9HHVTXtvFDXr6NgsDg4wKfmns1sAEMuzKFX5eQ=;
        b=NSuBz+7kxTNA6cTwHprDO6InEQpF3dNPwmgq1UbWojdvF3YusVotctn3ulevUeFMJA
         UgcUUod6WfFajGEbNjGHI1HIsS8pTE38QLN2OY+g8mdFXmbwI3RtJhhp9NEK35pCYe55
         2Qp2CPqHfaPnRHqczAsDX4bKT1R7jn7pBVW3kvB7sm2MdRya04ErFk5v+o87q3JsHUY4
         jsSnrPKlUZeWZ5Taw7Jk9+HnIGs63at3XA4e7XjSACmUxSgJ6vz7ETMx34DtoxsmFTn0
         3uZH+3RzszKfE6A0Zbhr1n4lff/rzGaD5TPrGJU2Cm9mLDrbNNYBj6AuPfrpMiGO053q
         WY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396615; x=1760001415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApE4Y9HHVTXtvFDXr6NgsDg4wKfmns1sAEMuzKFX5eQ=;
        b=WMKC/vciUgu8pZRbE1HLyEFOu2K07WzB9NUYa8G8AkTdrvJC2w5G1gHsr4siE65pGD
         vZt2KEHWdyTAYli4vZjh/8nU3gGUApQ8y8PvvVzuYPduqRPVoG8xQqv+kUMvUJRljLP9
         vMk1DkOU/cW97VkupEVBJTlbzH7RVEW2pN3XNol0oNo3n0qzW3P7DbjZUFHepc0h4IdC
         +Xbk2STH5YKYBtovGc77a6SjXq7F+x5W7S6NfjNJARc78G306sN5eXNfrPimH7fTPaut
         aug1XP4pEhz1/6eFhDgkOk5MrSo3M6DeKKqOe80yMfYPNzHnLJv9qUkzMAIarP9vsYWk
         yoqw==
X-Forwarded-Encrypted: i=1; AJvYcCVb1iEYelOn05kR23SF1zIkMZBnC+qdubtrcJurSMwiSsOOZXCpJrMt3EqWmU4a+/ODMiI6l9zbjiH9id8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKlRnY8zenFlA1kXMAv2QiD1jXnkU4I0DgeK24f2KqLZultGI
	aySr+8H1SfZdGWZBu1H8olGFibgUeoszNV1Xjr65hdLYgOwWSUVKnPdv2b1qM67A8EM=
X-Gm-Gg: ASbGncuUsL7KWoPUMLlnzg52ti7dAc+1Z/WY6nX5A+IeeFWjw/e2Qteku9ubKFaKovo
	P+GUgqz5nUp6gqjpu142jmDtzeRdk/f8Nf2tmejQdzh6ot6mILtHBVnMw1eUIXpYOtXMyxv0YdS
	jPYdqFRfEnUVneuaRok3/3tQdXHLsqkjcKiwSYx5Ux1Z9hO3dfIMDvUgDhniWmEXIm5yZkNugql
	6G2C9FzTvexrSUo01v7cehBQWz8r+9VxnJdI+mpZOjgKMFmVtaLi1T0QUzN4nZ/DecsY7REU95f
	MOP8kvdy4p97Ol0MClum9heQn+cdbsyy97MJ0MnzSx/W2PzZVeDHqbxhl1GiP6GqVMRBJmQOlv9
	9TFVHBYu4id4TN+T8SXdr7dC7vqxfIREnzSB6ldQe6k9RAieMKpTQJpIO08FNNpbhYRlu/fE+ra
	+hTUdBIKbLDoNR9w3aTHtfRRGLNqEzQkbbsuEIK0vS
X-Google-Smtp-Source: AGHT+IEgvHumXKmVR0wOfKwUqlKjQ3ss2VADqHWOC1c5n35kevdUmjMy4wkE5Pu8uNHrZooblrPdLg==
X-Received: by 2002:a05:6512:401a:b0:58a:ff9b:2234 with SMTP id 2adb3069b0e04-58b00b3d66amr944937e87.2.1759396614697;
        Thu, 02 Oct 2025 02:16:54 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113ed8dsm666665e87.44.2025.10.02.02.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:16:54 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] rtc: fix error return in pm80x_rtc_set_alarm()
Date: Thu,  2 Oct 2025 12:16:49 +0300
Message-ID: <20251002091651.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The regmap_raw_read() function may return an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/rtc/rtc-88pm80x.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f40cc06b0979..f26d8a1e827b 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -173,17 +173,21 @@ static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time now_tm, alarm_tm;
 	unsigned long ticks, base, data;
 	unsigned char buf[4];
-	int mask;
+	int mask, ret;
 
 	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_ALARM1_EN, 0);
 
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
+	ret = regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
+	if (ret)
+		return ret;
 	base = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
 		(buf[1] << 8) | buf[0];
 	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
 
 	/* load 32-bit read-only counter */
-	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
+	ret = regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
+	if (ret)
+		return ret;
 	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
 		(buf[1] << 8) | buf[0];
 	ticks = base + data;
-- 
2.43.0


