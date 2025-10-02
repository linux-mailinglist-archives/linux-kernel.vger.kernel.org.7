Return-Path: <linux-kernel+bounces-840062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB9BB3717
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD31166EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4541730147D;
	Thu,  2 Oct 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwkNKzPz"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372130216B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396852; cv=none; b=t+flIxZmm4HKFQxw0dLdRsgeyiD2G6GMWqXy/AbTMUBFCHZL+ZM8IAykxbk5JFDKu6oSUCxib0l9FkMi4V7Imuq5q5tsx48gzpxh74Bi+fby1WwFKyE72D51IR9m764f8mdMr9Dm3LoviaDBBVEOUvFm10ed4MRnHrWe19Fc3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396852; c=relaxed/simple;
	bh=NbqCWvQCaMNEPmod2yWs0FfaXN1CcGdfkaocxXgMer8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjoQWyySKozTWfy9JCXJdgyhNoI9jGICkAlfj84d0RqAsYtl8R9VSqEoaF3fHSmbhGX77DZ8c5i64cjOv0bOkLWR5O6alvFRtG0YrXrgLCEAZ8v3c0PUFLSQ+RbKUEoxp++IkP7zqYXDRC748y0hNiGjgR5Vnjg+th6jXj0ZD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwkNKzPz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a604fecb4so958892e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396848; x=1760001648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqXqRp/Z7HtRs3F1hULbBJNB4X8XMTG1LZWCYLOZLtU=;
        b=IwkNKzPzUuEKVxIsarZZ6FzwhDBfcXPts3aCnr+vjfHzcRZ92SxBJZIvqr6+TBQYi0
         dntr1Mf1AV4QKXnAT0c5hiOz6QIJK/YfkkKiG/myVvvErpUKJBJ3AcuG1ZMDmYU1p/HR
         neg0Lk2NOHevy9UbarfG4nRNT6i1k6TPMMDbBgfXGra0naa4EAkuQ6Jh1+nZErkD4kI2
         j1uZ5YNi9Cjt+muys01EBOQDW74Pilz3B0vECgALwETacnioU3A3XlJLTCVrd8xPTrzY
         i0I5iFAR1ZoTd6TZbRLKaEHfxjlIwrAJ4Gk8oN8RSgbvinA6lSARX586+v2sevm7nGUY
         H+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396848; x=1760001648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqXqRp/Z7HtRs3F1hULbBJNB4X8XMTG1LZWCYLOZLtU=;
        b=NhtHOTsec64CMCoxCXxAeZItmq5m2+ctSxfAYKC2IUP7I7ACIXxmcW7iY3RVUeLTYO
         XvBJcvUOLK5rdGQY97mwLHe+9Ef1qi+DJ5E5szc0XnbCfsrcvCzmZq3N7h/7DBQr3DWn
         I/I20xc1eoEBV9KlUPTVTSCDUUxt3aaRQuCsteOkj+9CFmZQYTbcaMqUo6++hgGVu+Zu
         w64ckem/A96s2gnV2MQNJJxfAQ914Kv2JAqAMEGdazZO27Oj9SWxPHaKrFCHuBFDB/gC
         PpIDTMQl2A7XZyeSp6NPDB0rFIj3fUZiWX+QRmUYXwtohoGF4G63Zx0sbUpE3kQaqmJS
         mtdw==
X-Forwarded-Encrypted: i=1; AJvYcCW62zwebcaufF+Ezt07U7OxciKQq7jVsaIQAjWt166WibQeGnFYPvbfO8cLfKRgEvdxLowe8hTDSCSolks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWG8UQxhHmDFu8155E+bTlb/0kHxYORWEC/0Gw8bL/D6c58cTm
	ADT3Z7R3UV8X+Gyr+hbkERD7Nii0fUyltfIUS8RZcruvTqBJveGxDbRHiqs5bOQ579Q=
X-Gm-Gg: ASbGnctSE1vWfHHhgNKi+0ZUhGeCjZKiJFpE/ULfMIqjAVnn3LThLorQKXJdP9bl5DE
	CMHoYbx2wEaYhaP62fdkxrbHjgoTqbO2YijXf3MG9jd2Zi5xzkQfqc6G849lDZflojG6g25tSjJ
	rZT4erKJp9puGbUFSX4oqhLpkywtGal8oN+7XufPCsBUMOO/mosiqO0xVwuyagembThMTOOAlTf
	t5fGIpIYX09lKTu3Mx7rBRWh0sZ2jbIaNvVJyA/omH9NTx/n5krOCDEZmJQw+Rq6xWail/16VUI
	Gs6cjSBqQlwU6/fNJqXZFLMbMrK+rZrrQfiNWHwgXuQ3Ejs1OLAGSNlIhYFa7Wu3At9Mk1ElHtY
	2DeQAkkBKqItzcNbVNT57N/vwtyyPcJ9sAbauMkSEiPrCgWOZ6LQCXBxClExNIR7dBz+l2bMuZ6
	IIbg4myyZYkXJXYkKOHYB9zgX6e9WVVjE8jUqePKRd
X-Google-Smtp-Source: AGHT+IHKYAv005/la9IKuIOXtbTmebUj1K9IXAgrSaTVgoEJ2t1LESi6LPycN1US0v8bL1eB9MgZIg==
X-Received: by 2002:a05:6512:108a:b0:57b:8675:e2e5 with SMTP id 2adb3069b0e04-58af9f16ccamr2095615e87.15.1759396847894;
        Thu, 02 Oct 2025 02:20:47 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119ece7sm642361e87.103.2025.10.02.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:20:47 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] rtc: fix error return in pm80x_rtc_set_time()
Date: Thu,  2 Oct 2025 12:20:43 +0300
Message-ID: <20251002092045.11-1-alsp705@gmail.com>
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
 drivers/rtc/rtc-88pm80x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f40cc06b0979..50266d2e078a 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -119,6 +119,7 @@ static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	int ret;
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
 	unsigned long ticks, base, data;
@@ -126,7 +127,9 @@ static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	ticks = rtc_tm_to_time64(tm);
 
 	/* load 32-bit read-only counter */
-	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
+	ret = regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
+	if (ret)
+		return ret;
 	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
 		(buf[1] << 8) | buf[0];
 	base = ticks - data;
-- 
2.43.0


