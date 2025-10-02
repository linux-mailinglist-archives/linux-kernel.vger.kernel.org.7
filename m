Return-Path: <linux-kernel+bounces-840057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D57BB36F2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42DE19C0539
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA930147D;
	Thu,  2 Oct 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QADZ54w+"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E741301004
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396807; cv=none; b=DjvH8+gJPKxSdFlQxJ3fMquLy1rGn3AV5YZptJegoR4+i/FAEVr16MVxq4xcxA9n/yUK4TD8NFZ75ciuTLSwOZrLtqSYJAUtA3ICQFV/3RFy5js5T/y0eIz+B4uUMV1fCV7BSbEBHirvgcURjfJADu9jWVBOTAtECTMBPv7oHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396807; c=relaxed/simple;
	bh=vRt0dtCsdz8vwlJe3xmSExt4YZA46Y5SdTypQbnPYRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSxCkWnR+Ku9xUcDbQz6+DEMeGR3uNNZmoF7R5B96jK4h1dHAVRHmisPmzAoXTTCPHd9Q+HOI3DGiUtXJOlO6jYhtXCLwq3FSD6pGIrucF56/NPBzsQWaDpQp10i/ZoOQgiX/3sfBL0ajPfTfY7RLOLlO4JfIKmzZdq6FHeTvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QADZ54w+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-579d7104c37so1066644e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396804; x=1760001604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNpNdQn+Mvusm2MT0LBZ46u1KJvuulNytepH41XAksw=;
        b=QADZ54w+r1e5wGmE2Gt5uFJV0UgWLb/7FxX4NkNUDteSEpwyI06gRhwClpCaX8Ry26
         v8l2dl8NSjMnjLn+Wse4BAdrOBPSKgZJY94coTJ0YvKtarWm5YF3Kbdp9QHgm8wCBUpz
         j3dpKYkkc9GTD64rBh8qliKMhGFiaelSzQBipvmW69kwp/L5x29JaYqeoVzj8HfZ49OC
         CABT3bAOfSkyrZrnsDS5DHaDvmGsA8v029I5pQuEW4bzKs8K25kxzq8zwKJjHkF7Zxku
         NotUP7Qq69eIdRfKchOPfKBVM/vFtX4ptp9tw5ZI8IzjY6SPxyuuctF4rISnrxQ0Z5hz
         vYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396804; x=1760001604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNpNdQn+Mvusm2MT0LBZ46u1KJvuulNytepH41XAksw=;
        b=d3YJlG/UikKS2uV5lc/m8qDpbNh7XOxoASMCE1Oqg4IUHQDTpwSQjcKgLlFZuicftJ
         t1gmtrQmYPNwm81pJU7EKXDatoP9RbLMB4sE9dmUsHHoGWqBLJ0URuHkqVOcJwKTjMNb
         TA8Bawf9ke+hdNBfDvK9TEONmw+93KeqpsTA1LN24o4ZhpU6LZiwPvUDnlv1cx+hLCPx
         hZGSgXaH/zFK/i7Zka14BCQVppQMEM4LwdIKWMnf+APsFk0JbJHfbLI2bsG9YX2XLWlR
         luf2KulZCnOUt64NCSgp1rmMF5g0+LETOdtjak1NnH72/etSFC8bqAzehYc1FK9imgO6
         3mDA==
X-Forwarded-Encrypted: i=1; AJvYcCV8PXmTvbHHa5NxV5XzCI68cHmle8Fee/zzoPEP0YAfS0reHrMZfRr4AkuSKAxau9pB8wL/W73Xt2Qd+uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnsg9FMPPzn2/2IDS8zxIEXrdhAj1xWxFKjpbd99Qc496pv1a
	mKcwSQFCGJi1K6fX/dADWmu5qCTSV4wbGVhWv7YJQSj/49eVJ2huGvDMAwIkfL2WYSA=
X-Gm-Gg: ASbGnctX1MbIHvBEtObLwoX/tH5m4KKc3Jwug0XCJhCxpTGREpgesIdXV+SmHb6RFwM
	Bx2cf4bm/12AMxIKcZX9MPC2A6kGHaDtFCp3nNNDGPP2j6DwBJe6THOOBFTSolWZePEw65z/6CP
	TU6qmQssw3bua3qZjk7vSXVQR5OBi4rgu16vZud6Aq9U6Ayv0WLTJ5Dmi/BJP5dqsZ0u9gA+AtB
	fIhUqWwARr72sPCr+SLUjY0GLcHK6pV6niHsO3d0XNuGUCq2pauxp/l1JmLs7kyYUYky+NUI5es
	uTpWx8yFGyBF+eLJkVnMoTt1aVxRFlbq1olhAa5cYKHTfmxjN+B2fx0qlZKN9hzNcV/RuTWoxx1
	RnDI8xhkD+s71t3QEF9jiWQiH8YBM//YdD0HbXkWK2hcaK5SLPpR1GfX+RVz6TuUjDndmrIKMlF
	RyNxYAWScJKWO0chIJroBTYYC9akTkIp6OXDPZ8lOI
X-Google-Smtp-Source: AGHT+IFUIDciA5xZKbT9troHSKjJ/3ia1HG2h024hlGxFpBUK6g1cjjH2CDCxiHjTRESwliPBFXExw==
X-Received: by 2002:a05:6512:691:b0:57f:492:3263 with SMTP id 2adb3069b0e04-58af9efda86mr1777775e87.1.1759396804139;
        Thu, 02 Oct 2025 02:20:04 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01136e83sm668382e87.41.2025.10.02.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:20:03 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] rtc: fix error return in pm80x_rtc_set_time()
Date: Thu,  2 Oct 2025 12:19:59 +0300
Message-ID: <20251002092001.20-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The regmap_raw_write() function may return an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/rtc/rtc-88pm80x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f40cc06b0979..71d4cc7e595c 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -136,9 +136,7 @@ static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[1] = (base >> 8) & 0xFF;
 	buf[2] = (base >> 16) & 0xFF;
 	buf[3] = (base >> 24) & 0xFF;
-	regmap_raw_write(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
-
-	return 0;
+	return regmap_raw_write(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
 }
 
 static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.43.0


