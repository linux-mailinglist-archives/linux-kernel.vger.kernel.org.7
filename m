Return-Path: <linux-kernel+bounces-805122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02694B48443
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34EE7AA5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084912367CD;
	Mon,  8 Sep 2025 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="vSfOWXbW"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574321B87F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313468; cv=none; b=BIzWREq6wxmEBwhk/1tLiyLycTsaNgaEtMZ7YrYHXMS41gQDFQXzjHnb6Yt03TCcZLNjBMYCpKNcW2vXk3uu1gW++QuDlTftbJLm7Y/ZRQtVDgfzGszEBK4k2eq02Bl14rEFyok9q2LuL/iebNc90sLwISiG8Tol4E0cDfXtFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313468; c=relaxed/simple;
	bh=t8YvggbMtVjYfu9MMHAlElomxmTDQyOKJN1g8k3ef08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4ZDllophopU2IozriYKTMdVQee/gLehITnpOQ3ENh3Y4C5tKsfMXP+Q9FP1wSL4QEVr1dCVGL1dh44hQUJDckfquC08+uBNZhDBLbeUG6Fuk63YsU2myrf4DgteuC0gb55zKHEjqeRlVvPVcKLRKIhDMwz+e+CxWwT7I3EmKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=vSfOWXbW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5229007f31so791635a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1757313465; x=1757918265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jH4Sjcau6Gi5UxObTvTFnz0/+SFCfd31Xitbpoji5HE=;
        b=vSfOWXbWmEBA326IljDSVuVL4tKslCfqeMh7vwLbYkylFlTZrKDdmt6RF+fgbgsFOJ
         ly5UYWhXiSp2tB8Ue+3AmUD4Gd4T1q/memCUhyJk3HGxZpatJZsdpGGw13ambQQ/WtBc
         zlaM0soXfke9eoGFgj99gegebqNCg6TYguSSBUhZ3pmxCuJQy5Q4mWRsbaAN6m67qMqX
         AJQQrXzjQIMCrW6HHjOqaElDbaW2Pus3K6bI/NmI2AIP8zMJRG+92sYXJphdCbgc4EZN
         7lAIfQip1vHP3VR9ZCIwwjVEfKUOkmDTKWuWv39TWxXLm8pX9HM27rbNFQno9P+AQBrq
         mCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757313465; x=1757918265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jH4Sjcau6Gi5UxObTvTFnz0/+SFCfd31Xitbpoji5HE=;
        b=gUgfub26v8JNSgtBjOnk+1DHsASxFHi0WnPpNjVwpXrKVMpmxEjeUMMCExhamJ5e2a
         laLUDcf013EjDlp6NXTMvav8FRA9saTQ4FRAR4V8Q/bXHgsYegzijB87geuyEW7EfwUx
         z/uDlCKgcX8UuZVT4nw58tp/oIzJdrIVZzET4VZnAnboVXxbpnuxm5X/+BaG3YJ8bvYK
         trpg5y2Bb0IEKTuS5UclI7YonPrp6kFK9YNkCxRlla4v9h/8snz/b0XMD7yYcZyMpy7N
         Gj4X0/WovJ0kVoe6WFIxAsfprxlH+Aj8B6lyZrvilWpgGBuTnyPYok5WoHIjweQUsw8L
         sV9g==
X-Forwarded-Encrypted: i=1; AJvYcCX6DIdl9NfobVFBLFRZzQmX+/u+6bJYLAnNCwH49WM6aopT7rjCo5IRmWTyjj5QpoohCr0kCYiKzENlFZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kFlUdYLly08mRQ8PDJWKFWS7xvISfRySsvdWiLX2o2BH+ut2
	5aUaP/r5/o905BvEhPu9hX4q3PT3/+lqp0cdYvr5ZGY3Aq/02+Qt5ERCgPUatkkILs4=
X-Gm-Gg: ASbGncvqU0lR7JOLsw35AeMzUsSJFfwRjkUUxtj8lhvcFhdkp4OI/zTEs5xsfcx8Xg7
	bQ2qV5/YwkSCPJTKF+igD7EDfD4Uc2yUMVUPqXN3IrEnhrMoqwEaHJbWNhuypj0ZznTNcYZUycz
	bHDyRH1hjVkwpGJwOyj7gWmCuCS4veUUBO58/cGfAAXsdj2V2Csof7vOaXkORtbqOpg8yi7tlO5
	x7mDN8ztZXQfy9gh/1xd085ny2zhLBPHAylVAp8c10yeNI79dvkxNFEIOxR27ePfmsAZGjKv5es
	NJJZiuqk81vDMh/U+SUsVmUJnvaBI7BzqcJL1bQJwKPPSFk1RWoEz3ryzdasXv4F58O8iQ3BYzQ
	pljD1pRmJhPQFEDLFWpnP549NXBl521JuO20St1YOAYNEV3d0jW8hSu+EeuNJrGen3/JpSvp96v
	5DgnR4Gpjf+DYGOex/2prlDlI/4vgxOw==
X-Google-Smtp-Source: AGHT+IGpsO6x4pJoI6pOu49B3RBheMpt1wIY/m392MBVfGJXFMSZA2ZBUu+Pi6i6a+J4DjEW+mn6Dg==
X-Received: by 2002:a17:90b:2b4f:b0:32b:d8bf:c785 with SMTP id 98e67ed59e1d1-32d43f5a670mr9627596a91.20.1757313465446;
        Sun, 07 Sep 2025 23:37:45 -0700 (PDT)
Received: from ubuntu.. (202.60.225.076.static.cyberec.com. [202.60.225.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e23858ecsm18097791a91.14.2025.09.07.23.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:37:45 -0700 (PDT)
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
Subject: [PATCH v3] drm/panel-edp: Add 4 more panels needed by mt8189 Chromebooks
Date: Mon,  8 Sep 2025 14:37:32 +0800
Message-Id: <20250908063732.764289-1-wuzhongtian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few generic edp panels used by mt8189 chromebooks. For
BOE-NV140WUM-N44 , the enable timing required 80ms. For
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Zhongtian Wu <wuzhongtian@huaqin.corp-partner.google.com>
---
Changes since v2:
- Modify the title
- Put the panel configuration in the right place
v2:https://lore.kernel.org/all/CAD=FV=WZAXnTGHhrMHTu3p0GL2ky2W1Xqmw2x2cL6FvvdYgG1g@mail.gmail.com/

Changes since v1:
-Update MNE007QB3-1 disable timing for SPEC
v1:https://lore.kernel.org/all/20250903082628.2847842-1-wuzhongtian@huaqin.corp-partner.google.com/
---
 drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..c7bec8a355b6 100644
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
@@ -1936,6 +1943,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a6a, &delay_200_500_e80, "NV140WUM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, "NV140WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, "NV140FHM-NZ"),
@@ -1972,6 +1980,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N140BGA-EA4"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, "N140JCA-ELK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
@@ -1985,8 +1994,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB601LS1-4"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
-- 
2.34.1


