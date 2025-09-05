Return-Path: <linux-kernel+bounces-802280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6284B45041
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465ADA0662B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C96270ED9;
	Fri,  5 Sep 2025 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="nIrVOALu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2F244668
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058686; cv=none; b=U1KgouGUVnppu6s2T3lduqVzd+/JofMaPu1T3Jb1MMuJLozaqNY7F1Zixe2sYP9j93Yhb0Ljm23892my0WncGMYk4NE4jBCX5+hvJfLSCuVDT5zB6iLpLDDXg0CTEZ/HH67xLB0xjYdapcBpJ42AxOixZockvL0boBCQpkICFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058686; c=relaxed/simple;
	bh=tbNW+ZcFHXZIgM6RdhMY3OAr4Jg5GjYz4rgfMkHPDkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0Odh43sKyvuWhbO77Iiw5KS7sq4c8n35V/CAMSgdm/cPQd5CUjHI6B6fv6nADlf0SbQ7Ly22gVVTJyb9QsPh72fOUgo6qQh4nd3l3BadR9TeaOW1XLVNuGoGIyprZpNin7pp/UkGKWeb7KAHqrHJjgrzQKM7spEvkuB3GKVPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=nIrVOALu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b21006804so18968565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1757058684; x=1757663484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EmbtEG9uQFz4Rx7fC2dkFqmrRnvHSDqPi/yrxENahzQ=;
        b=nIrVOALut3cl56a0sOs8t7NMdV0H3enEqcbsPW3VKj89J7/vcNJDVVwD31rUo0oDhs
         kRfeS50joYwsAA8VPatZNZ2G4mDo+b1L9PwFrg7ISFhSdMi2chx8ZHFJq4iW8TDet5Cb
         /g+8WycQDsW8CsbjT/t9s2XaqswwN3hRYAhZVJ0qwFsOwaIm7sYe7X6MTV0vC1FjGAOZ
         fhm6itk3rympMJkuIgcaN3FUY+OfJC3U/v00AkX+xGc4O0kGS5NHXK7qb/5iWtP0rp1F
         drNXjrWvJrIDNb2LeNS5QznBoK2Vs7NRBJ/YFTgnSZExYgXqGbshfmFOR4yI8Oy0+NJU
         nlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757058684; x=1757663484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmbtEG9uQFz4Rx7fC2dkFqmrRnvHSDqPi/yrxENahzQ=;
        b=gJprW7wRDtx+jyZcomCab9JvQaqosZXqRt9ZBkA0WQS4BMgFuopG12SUzZRbOBr12Q
         KH+FKCI0cMWltY8G7wYoc2HmDfzDbXfxi5/M7/s5MqxYcPsHfoDbUccaMlA25CQx2Qpx
         B1mh43R32nDCgivcBupF1xlXrmia/9shSR5x1Mmus/ibDluTPHUGy6M1EoKLGGa5++Xd
         heWRGUUaV/KGfNrrxvoNAuT9J5LFrUy32FTb8hmzQfIsxeAgeLm+E8KezXySSuuCKer8
         kwJdQVS1bqAwHzFewcDWRZ1UVID7kJEmQzTx/xXb/IqvsjT6FXsbhQTHW5lMIQNqylfE
         r/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW2dYeytGuJo7IjlGODIYJGr3SBPiaNAapvtEKTT8cSSTgqZdibZbQ+ZG6AZrFEhxvuYxpL+hpMJits7pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBhAI1VUpd7mklC8Bz5WqZ9G6NyKQA3GcndkjayPyXphTCsmR
	kCMZpaM2ot/JWmdjlGPhL5By/JLK4zeyd0s/0Bp++vbMSW13BU2spp8BKKcfcP0zwRY=
X-Gm-Gg: ASbGnct2R3esOFTCFaibtgq+HkMvWic6PKBLVVDxjGJyY3JlYCiuUFfbnEkFJS0TMmU
	EtbnJY4wbTltWeXXznK1YNxSTmykgRYFcd2PPzofdcPjntkXQPBfpH7MJjNbBJhstQ2x4SI13Sk
	LzkoTE1UZFQq4NrrJEDpMCMJ6EaK/bTETgi7dEwPXoNcXZ1CjSALbR+p3PA1meNFBGyLnbADJ61
	GD4Kv3AjIMBu8evSGqLcVCw9hljCAe+gGW5tvay90sv+3Nbfg//BH9MBtGaDYMdijBT0eTXSPhM
	oLw3E0O3AirctRB9hSeKd4sDHB5jfk3zgFpEA2uRdcgpB2IvZ37xgZCZ26eHr8XhvmU/Gqm+yQI
	8y7Nhm4qmZyUJ5MNfbAiOQIOW6yJ05DwODUBcCJ5ltlj/Ohud0ENqY5Z4yj96dHxg5XpKwThzuo
	D8ZojFe+MG8zU9YGVZU1qXitrPzuRYJ5F+vNpGUM/L0YEheY10XyPf
X-Google-Smtp-Source: AGHT+IF0p4cn6WRBxaoe5Z8jzNmgbLxmxgFiMAZ4T0EJmL3ifwXRqn7/4bFP3GWMvTGOqD2sRt28zQ==
X-Received: by 2002:a17:902:f790:b0:24c:ba67:95 with SMTP id d9443c01a7336-24cba67045fmr63934665ad.9.1757058684132;
        Fri, 05 Sep 2025 00:51:24 -0700 (PDT)
Received: from ubuntu.huaqin.com (202.60.225.076.static.cyberec.com. [202.60.225.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24df9e881casm6943695ad.62.2025.09.05.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 00:51:23 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel-edp: Add edp panels used by mt8189 chromebooks
Date: Fri,  5 Sep 2025 15:51:14 +0800
Message-Id: <20250905075114.1351267-1-wuzhongtian@huaqin.corp-partner.google.com>
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
CSW-MNE007QB3-1, the hpd_absent timing rquired 80ms, the enable timing
required 50ms, the disable timing required 50ms. For CSW-MNE007QS3-6,
the enable timing required 50ms. For CMN-N140JCA-ELK, the enable timing
required 80ms and disable timing required 50ms.

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
 drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..6a27c0214dbe 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1828,6 +1828,13 @@ static const struct panel_delay delay_50_500_e200_d200_po2e335 = {
 	.powered_on_to_enable = 335,
 };
 
+static const struct panel_delay delay_80_500_e50_d50 = {
+	.hpd_absent = 80,
+	.unprepare = 500,
+	.enable = 50,
+	.disable = 50,
+};
+
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
 	.ident = { \
@@ -1949,6 +1956,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a6a, &delay_200_500_e80, "NV140WUM-N44 V8.2"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
@@ -1978,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, "N140JCA-ELK"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200, "MNC207QS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_p2e200, "MNE007JA1-2"),
@@ -1987,6 +1996,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1


