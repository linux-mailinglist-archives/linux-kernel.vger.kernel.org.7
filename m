Return-Path: <linux-kernel+bounces-798015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C128B41866
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F11BA2F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C52E3AEA;
	Wed,  3 Sep 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="MsJC+2rx"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BC16A95B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888039; cv=none; b=tXK4C7UCKymuTK3+EMnMIePkFzIL0ehpPVzOYIyeXpV98W/M/RRPMRG1XL8iZbGADlIHZf7xeZl4e5ygXK8u1jqkKOeA4+BWB5ygNOkX1P2hPrA7u+HtwD7oTuxsgXnPGFnchgU6eqjQUVuz1GAzWdvRrmCYLykeTAllCRa4Mag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888039; c=relaxed/simple;
	bh=I99lu9ewXOKf756pvdytEwBsiC0SQY0hGN4JCjJXvm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SobnSSmX2isw2I62mxrFFAOUG86iKJaX6WZIj5YvrakFx1C042ihgAsuJtVQ8/xUxkJU6AhtEVqx9WnzLzSfi4OQtMLy0nVASU6yNARyc71s+fglX1WliKUMwEZjZwVU8L1O/SMfDKGlhj/QVoMIkbQxcGqnKluHy/bXiJ11rcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=MsJC+2rx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772488c78bcso3583619b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1756888035; x=1757492835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7MyvbuehqyHPFoj0yXmMeImr3j7gjRiUhu3hTPI4Oc=;
        b=MsJC+2rx++j9eK5WT9wY3pl+DRV7Upff4i6H+B5DqRegNuHNgxwmB515FQNGJLiLO/
         WPp63p1msIDOZ0224vLT3mqpTliEjxSMbiEdfrRc+D2i6Qpwmkzk2040FjVfIzvYJLc2
         7UIehmDV9IDbseX3WP22QuHXMt/K0OW+xyslbomOWs3aigvP0HzFDa6LElJw/37K5l0n
         MqF8ZrccLJnyYQA0XF0o+vSicZ5oCIg7x1PsbP4TtuDW7bife5pSYQOaZ/jcFi0ZsaCK
         PkMhIYoUkkNAKwKWyW/TSk5ZxgZuwlTyGtj3UnoR5+jMrmvHHenaFBJ/7IvFzaQ9D+Kv
         FPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888035; x=1757492835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7MyvbuehqyHPFoj0yXmMeImr3j7gjRiUhu3hTPI4Oc=;
        b=grn2tIc0cPgPOa9Vljt5PYObKp9+1ZBO5suRHMJkxrGAikiWa8r9jaZyJPDG2KLLxN
         M/hmBvf2cNXKnh17kMPlxm0pH9ITWjV1sqqZzBecujdt20M2KxBI/fNOEaZDYTv7JB8a
         es8P+/2vdBlIh/+Gm8OvMRNQTYxs4DIsvENnrzU++HItyGVfwcGxJtxnuWQfHHtpUCD2
         DYOQx+awcYpicaYSmWAThC2QLrYT81YIO+DjHXNmwiFiv0O8/f37MhRa/5OYPUBQIFiB
         c91kO4ct9Tk+LFca2F2H9ZNPu7E/F9jyxAKABnwg49M7MOYVD4/vSMXNDIIJ5V0qVory
         E5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUlXWgusKHAfHqFjnr7ydYxKbbDRE4QIYDgopxG9i7zLEsTPRAXZyzxuFGbFGEGv6WVqrggeAHA9wWhS48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmKt3WEPXLjXWRkQ919rkXDzkzsr5ntLpZztI1UklSdFy5dt/
	s0b0GH/fnF8M0cUPGvcaQNO4nZxdwv3OKcOXIrFIeGW1n2o26NxZOKYiaE6smWBtJzUHUNnKirX
	ShrZf
X-Gm-Gg: ASbGncuqXy34ygeNbHbjJdAxymmHn4VcM7OtgzXlvNyR8ritx9MqMma7wjEQLZ2d6jm
	4KZ5hdlFX2+04LcOGIp04eJdnF3jwCbxiVnFfd0XJdtc0BcEfKtzozyR8JLJCvMVyRrv3kpGduQ
	B5X18qAqYCzCI/rqlx1ZrX3qB5Tqz9zOBSlY2thUsw1Y4Z5dywG5TCVYA/NB7Udw0VBgM4oF8Ie
	gE85EpKIigS4dgcGhw9AeolkPv73VLc7SnfF9IPkeAX1H8bIg4YcUHtXlfKM0I7jr3oI9//2bGt
	mKfEFoot9ZTAGCLW04Kq8q1mc/1c+o36jIXoKnboQNSmVEaAQmmpGgMphn865wvtGlvu9eIErHt
	WceQf1BJz0/fEKhX4ldAemPPk+wqZtCF8OxDnBTTIHd0UvLpLACU1vxMqaF6NG6fi92b4jh01yY
	24JB8r7foGELwZjxBCXOzJxE50Dy/L+Q==
X-Google-Smtp-Source: AGHT+IEXDI+4Cxdd9GZkPAFGxSlru8Um1RtkCHB3w0+OjUmK7c2c9iaH92pRYEXqsS+1c1bSrjjkJA==
X-Received: by 2002:a05:6a00:1495:b0:770:56bf:ab5a with SMTP id d2e1a72fcca58-7723e36b526mr15626694b3a.19.1756888035099;
        Wed, 03 Sep 2025 01:27:15 -0700 (PDT)
Received: from ubuntu.. (202.60.225.076.static.cyberec.com. [202.60.225.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b7d10sm16014435b3a.33.2025.09.03.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:27:14 -0700 (PDT)
From: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add edp panels used by mt8189 chromebooks
Date: Wed,  3 Sep 2025 16:26:28 +0800
Message-Id: <20250903082628.2847842-1-wuzhongtian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few generic edp panels used by mt8189 chromebooks. For
BOE-NV140WUM-N44 V8.2 , the enable timing required 80ms. For
CSW-MNE007QB3-1, the hpd_absent timing rquired 80,the enable timing
required 50ms.For CSW-MNE007QS3-6, the enable timing required 50ms. For
CMN-N140JCA-ELK, the enable timing required 80ms and disable timing
required 50ms.

BOE NV140WUM-N44 V8.2
edid-decode (hex):

00 ff ff ff ff ff ff 00 09 e5 6a 0a 00 00 00 00
2e 20 01 04 a5 1e 13 78 03 fb f5 96 5d 5a 91 29
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 61 40 80 04 71 b0 3c 40 30 20
36 00 2d bc 10 00 00 1a 81 33 80 04 71 b0 3c 40
30 20 36 00 2d bc 10 00 00 1a 00 00 00 fd 00 28
3c 4c 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 56 31 34 30 57 55 4d 2d 4e 34 34 0a 01 7c

02 03 0d 00 68 1a 00 00 01 01 28 3c 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06

CSW MNE007QB3-1:
edid-decode (hex):

00 ff ff ff ff ff ff 00 0e 77 6e 14 00 00 00 00
00 23 01 04 a5 1e 13 78 07 ee 95 a3 54 4c 99 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
36 00 2d bc 10 00 00 18 2b 30 80 a0 70 b0 23 40
30 20 36 00 2d bc 10 00 00 18 00 00 00 fd 00 28
3c 4a 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fc
00 4d 4e 45 30 30 37 51 42 33 2d 31 0a 20 01 69

70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
00 3d 8a 54 cd a4 99 66 62 0f 02 45 54 40 5e 40
5e 00 44 12 78 2e 00 06 00 44 40 5e 40 5e 81 00
20 74 1a 00 00 03 01 28 3c 00 00 00 00 00 00 3c
00 00 00 00 8d 00 e3 05 04 00 e6 06 01 00 60 60
ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 68 90

CSW MNE007QS3-6:
edid-decode (hex):

00 ff ff ff ff ff ff 00 0e 77 3f 14 00 00 00 00
00 22 01 04 a5 1e 13 78 03 2c c5 94 5c 59 95 29
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 ea 3d 80 c8 70 b0 2e 40 30 20
36 00 2e bd 10 00 00 1a 88 31 80 c8 70 b0 2e 40
30 20 36 00 2e bd 10 00 00 1a 00 00 00 fd 00 28
3c 4b 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fc
00 4d 4e 45 30 30 37 51 53 33 2d 36 0a 20 01 80

70 20 79 02 00 81 00 14 74 1a 00 00 03 01 28 3c
00 00 00 00 00 00 3c 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 9e 90

CMN N140JCA-ELK:
edid-decode (hex):

00 ff ff ff ff ff ff 00 0d ae 41 14 00 00 00 00
25 21 01 04 a5 1e 13 78 03 28 65 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
a6 00 2d bc 10 00 00 18 35 30 80 a0 70 b0 24 40
30 20 a6 00 2d bc 10 00 00 18 00 00 00 fd 00 28
3c 4b 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 31 34 30 4a 43 41 2d 45 4c 4b 0a 20 01 14

02 03 0d 00 68 1a 00 00 01 01 28 3c 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06

Signed-off-by: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..bd7243bdccbb 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1949,6 +1949,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a6a, &delay_200_500_e80, "NV140WUM-N44 V8.2"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
@@ -1978,6 +1979,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, "N140JCA-ELK"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200, "MNC207QS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_p2e200, "MNE007JA1-2"),
@@ -1987,6 +1989,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50, "MNE007QB3-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1


