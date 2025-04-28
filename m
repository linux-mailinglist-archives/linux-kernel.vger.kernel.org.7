Return-Path: <linux-kernel+bounces-622858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D7A9ED93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 12:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F54F1893953
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760C62641F8;
	Mon, 28 Apr 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M2hGM1zF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418925FA10
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834834; cv=none; b=PNKJp3hBq1LVfId6aWHSzWyaAJ8kZvR0lYC2GOzRNPiTOJGqlL3r4QJrfpHsbt5rZonN7W8QboE4NkKtLHDfw2j+OclglfFjs7pHUni8kAChlnKFqmKJbHDzoHN3SqkDeB3UOk0sD2Cw9j/6W2rWqx+EwmngU0sG5gSz8OvEeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834834; c=relaxed/simple;
	bh=7uZeWPhtvmKt3yd3O8AZQ3pbDjAfEgQirGkkFlgXXu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyZSCV27HR1+aYpMvaCNJS9eLTL+BWuzdHnlDdkCqfSURGPKV49n16evfiDMNztwxew9fCSW+oflvZYTAVef38I/P4iVCgF/oKufYIx9iiWNh7Df1II4uWdODiliSe9CrLVLFqE8TEDOlexAGki/ZGvYw6zyG10a95N5/m051Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M2hGM1zF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so29282405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745834831; x=1746439631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2hK+VsNCueKzRhMql1tQgaE2/N2rrh2mNXHk22OL+U=;
        b=M2hGM1zF5L0d6tfk1pH9YoiiXm7SSaxvEwwrfUEQfoGAppd4Qr0tqC8g57tnuvB7Vk
         M+KyKULXatrQAIXHnY+mjzI4f/7VzhaQiRj+cHfrTnuFM3IgSSjaLidfIDmpK4YzhtFA
         dMX3Wp2VkZOi048Kh4FH6C0PWB9HgupKteVX0Y1Av42OIdqwNLRi6dDJlpqRYFPNJw5x
         pMeJF9IGt4Gakiuv2J3iEsQwPcKcjCx24/Hf2mkDrQli6TMhN/Go/w2YvEqB75518uLc
         01Y1x2Kfcmq6+Ikhd8efErHKm61oyrSwJ9Obl2m37f5gRMJ2Tm6bD+LSl5vXEQoEgoob
         HguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745834831; x=1746439631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2hK+VsNCueKzRhMql1tQgaE2/N2rrh2mNXHk22OL+U=;
        b=nr8EKz50M5zEXiN3xKf5L1isNKtB7BIKwcP5hnBftcteZfMQWgYMqNjHBhIZwtbitI
         kguxi0xBksNU8oN6Dg/EGMzfD8KKhUoBwnC3+kPf524v1EdQ6//Sn7ylcrGmzFVQWxNo
         JEct/U0WX69We1y9WttOW7iq65dcYs22oM7TY1G7aI7PtNTRWxdRcftb6D59gau7E5jc
         4Zn3W/RLHU6HvxeHguu+YvUJVxfKvGPC+7pvTYDdSMR6mm6Oqdazii3Z/C7PxHtTP6qK
         2Qo/8Hmyaz6BjN/kPungpzmIdowojl3u2qe1cuRfCf7kx2VanMOOShctcH5pFcYAyKKW
         f5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMSO6UTKfR/IS8C8qyrhxfzp4XaBAMvXMzT4wgv3cAK8lxz6QQAjRS0odLvZA5RTXCrLKUCDOE1k2Pnrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFv3BUah/SqWynF52VG49VlQYcPdzsJcsl2WDkfFthaPlQc9j
	UyIuUBNkod+67NgoPMGq5LyaX/9RQoO+grnE5Xexdd22JWkqRgKwqWxu1kEv6hw=
X-Gm-Gg: ASbGncsZzSoXcivD0P3agUR8wx8pTQjXhMKVfdJhFI36X9ykDdSzJp/Zc4BYSD1dRHT
	LxBHg97Degxv91qI0RqccFqqt9RsAZ6ZTLouhqZOdh3aRB+J8wkvVS/SABsoc44pa9F6pKpLMeA
	vX/IO7Ed/XVGp+3/dFif2Bfo95PpLUETpuaCy+I51ebQC8hsP3dup2I3E/edbMlcpN/rw6wq7pa
	N8xeSztkzP7uMz2ISe7oCuwpa+5orPvODBxUEQFSamjwvNgvV03o020qTXKWAqnlkrY2NAI651J
	amZVMH5n0EHHIAIvDYhHx4WRTrLNUSpNnMCBD2glbpbWtQ+BVCfIEOV6J/hwHbeR24K5KPuLzAm
	0mtsW
X-Google-Smtp-Source: AGHT+IFRuxRIEVZZj31DvUBWrxkoov2qi7tMN4aU3Qd0yVZ6ftykojF/M4OsxkOlSbx29z0zaBH7Bw==
X-Received: by 2002:adf:f989:0:b0:39c:2678:302b with SMTP id ffacd0b85a97d-3a07ab9be39mr5424818f8f.45.1745834831111;
        Mon, 28 Apr 2025 03:07:11 -0700 (PDT)
Received: from [192.168.5.157] (88-127-185-231.subs.proxad.net. [88.127.185.231])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073e5cb16sm10575403f8f.84.2025.04.28.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:07:10 -0700 (PDT)
From: amergnat@baylibre.com
Date: Mon, 28 Apr 2025 12:06:51 +0200
Subject: [PATCH v4 5/5] rtc: test: Test date conversion for dates starting
 in 1900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-enable-rtc-v4-5-2b2f7e3f9349@baylibre.com>
References: <20250428-enable-rtc-v4-0-2b2f7e3f9349@baylibre.com>
In-Reply-To: <20250428-enable-rtc-v4-0-2b2f7e3f9349@baylibre.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xK50ZlflFxjaQB8WcqAUgAFjtJg9QpcfS53C50dYoe8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBoD1NKryymyzHMppRuPdvg3SRPRoGC0q54b/rX+1Sx
 QRelbuCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCaA9TSgAKCRArRkmdfjHURXHkD/
 9DicZ/dEoU5A72UnzRYONqLjcZMFJvGB7tSqWy8/DR/RvuYt7nXCFxDdrKBrbU+UOgsEw76ozLgmGe
 DPgbN136iHwXYRFEJQ1+Qx9wKg5UKWcl3JG0XWkMvseOavAzaU+temFE3iCLEwSmjFXmCNis2Blm34
 OvnPQ8CDofHRWH3KtO7KxlPqaFrwYDTKE/5PT56EIdO71GHz+/nTnu4FUNVzZZPwERqm+YQgqr1uT+
 nrbBHs1Vq+MSNTbahpBm3HkRufBhsJKKKPAU5KRbg4OPD6cX8jss9ghGuAa/MWU+5N96j5LsFl1Tgu
 QmXPW+bEHNMcCKJ25Ysltr82lX2AhF/W14aonBBGLP71G5WnQZj8RKYTNQN5vgeOfcsrevqI6KGW+V
 GHiWVH2DVfDWGKMod8X+PG3mrFJdEgOpIzQvXeb0xyR0VfJPDL3nLnpWI0pc7om5DFPOi7+CRD6ot5
 klbeHhSW5XNaTaNxpSoN1kHnV0fA8giVtrzQpTwASpI/tTvy7rByzm5Eod2Hr+6C/Yll6w0BCZ+xjc
 p01TXYRdCySZTSCuuStlU77oxnJNYfHaqABtwb9NcnmPkRr9mZEp0bWLSXbwdpQa9TnDW2gNznlB/K
 pUz2PUlMRvDrP4dJ+4o5RvQBTn4Xo7mFW5a63AbxHjAyG/8pu7RqJ9Yrrq8Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

While the RTC framework intends to only handle dates after 1970 for
consumers, time conversion must also work for earlier dates to cover
e.g. storing dates beyond an RTC's range_max. This is most relevant for
the rtc-mt6397 driver that has

	range_min = RTC_TIMESTAMP_BEGIN_1900;
	range_max = mktime64(2027, 12, 31, 23, 59, 59);

and so needs working support for timestamps in 1900 starting in less than
three years.

So shift the tested interval of timestamps to also cover years 1900 to
1970.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/rtc/lib_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
index b1ac0701d42e5562b8eae5b191012c8b56a06902..0eebad1fe2a0983c0009626dac526fa07d27f6b6 100644
--- a/drivers/rtc/lib_test.c
+++ b/drivers/rtc/lib_test.c
@@ -41,15 +41,15 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test, int years)
 	 */
 	time64_t total_secs = ((time64_t)years) / 400 * 146097 * 86400;
 
-	int year	= 1970;
+	int year	= 1900;
 	int month	= 1;
 	int mday	= 1;
 	int yday	= 1;
-	int wday	= 4; /* Jan 1st 1970 was a Thursday */
+	int wday	= 1; /* Jan 1st 1900 was a Monday */
 
 	struct rtc_time result;
 	time64_t secs;
-	const time64_t sec_offset = ((1 * 60) + 2) * 60 + 3;
+	const time64_t sec_offset = RTC_TIMESTAMP_BEGIN_1900 + ((1 * 60) + 2) * 60 + 3;
 
 	for (secs = 0; secs <= total_secs; secs += 86400) {
 
@@ -72,7 +72,7 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test, int years)
 }
 
 /*
- * Checks every day in a 160000 years interval starting on 1970-01-01
+ * Checks every day in a 160000 years interval starting on 1900-01-01
  * against the expected result.
  */
 static void rtc_time64_to_tm_test_date_range_160000(struct kunit *test)
@@ -81,7 +81,7 @@ static void rtc_time64_to_tm_test_date_range_160000(struct kunit *test)
 }
 
 /*
- * Checks every day in a 1000 years interval starting on 1970-01-01
+ * Checks every day in a 1000 years interval starting on 1900-01-01
  * against the expected result.
  */
 static void rtc_time64_to_tm_test_date_range_1000(struct kunit *test)

-- 
2.25.1


