Return-Path: <linux-kernel+bounces-750279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC5B15973
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601EE7AE12A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19C226CE6;
	Wed, 30 Jul 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="jGJUK/Qn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A011CA0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859802; cv=none; b=jGzZMUiAu6GZYHHblx1qklMCSh+idbnhlhW4/4sgS0LyUh1w/cbskCpVcXcKR4xQtGV5dfy0Dt9Dj+EXhRIskw3s3eOAw3j2FqaPN3D4las4cc0BH71pAN4J9N0PL/IGIlxfS7Z+xPu9hBuYe17SWbbL4sC9bVDQe+L4F21nwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859802; c=relaxed/simple;
	bh=S9xNcXxzlvPf2mLiw1MYlo7lCkJhDKpH877AbLEYEhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kH00S2C03cqh5QsE+cPUurOrpP5TpIuc4qXmVgyKUUvW1Vc2Uz94qRQ7ccqjPZ7bAHRgtTN9QV4EMN6ebFxfbB6ZjZ+/q6/gbNa6rb0qEe+XlBaApKOvMH3V3NvYt8u46nTpON0m8Ib9w7n+qGBafgQHJzTSBoBqrA4I9Z8lgVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=jGJUK/Qn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1069010b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1753859800; x=1754464600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/xW139xXV+Dslq7ni50YTdI0qCF7BjPpZKwdp+PaqY=;
        b=jGJUK/Qn+r1ANO49epSiy9LfL+oNH2QuCDNmMcUOhmcXuaSVtsG8xEzZDgG5fwChMN
         UM7PIoxRF/8Pj4sO9M3k4yuVHIrBOdbzL955cPmvoYjCebQo9REEM4N6lToBPKtjgrZe
         XQqrybOjLVEE0v341nNxOK5KYcu7N6JJLPs7DHyzIwAjSuOtyBxqsDnN/uPuNA4eTSUk
         5JlaRrsiqXG32lhbK2b0lLrVngFCwUPm+5qfR7clD89FcwE83MJ3ArZXdT8UVeZl/Fmc
         fp1Uek8oDM66gAsSAPc43fCBBJR8pJ2lPmQUrohw5PEB1WvaccZIVk8VS2uLoFNZy+9D
         44/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753859800; x=1754464600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/xW139xXV+Dslq7ni50YTdI0qCF7BjPpZKwdp+PaqY=;
        b=iHLMq5LIWrUxmjvOsmjRJqN2p2ecN1aQ/a83v+JONZXvorLCwqzwhipHsZPWcLvSxO
         kzpglzQLst5rIUcy2xpJKaeP4NSLbUNPT3pxa/pYmJ4+zewMHpDVIfw+V+/5u7k9Kz38
         ZycX/XqsVdn0MmWBgM49jYc5ZOcy138yFgGqxpScV+bdmowgNEapoltepDnNDCpBfwNf
         EvEZXGub/8KFW2qZYHqld67GIl9QUZhpQJgodg4Lj7BLZSgI/OiTiZXfUQR9yk/NAlkk
         vOUP4t1RgTECkReEPkoaxluNy65NFTdvwWXODy5YQL/aJc67pELqOcx06Gdx8p7+zQuZ
         T0XA==
X-Forwarded-Encrypted: i=1; AJvYcCUVEHCEplAFLZf73A0BaQ1DVhmRqIh6InSve8VGF4+q1elxHuf4jE27QAiY3ZFRSVxJKyQyTcDUig+ueMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9y5rqfWU8Wdi+yIproRCRyx+Y9Z9om68FrAik8xNLSPt1aJC
	WZtXg6vbxsc+OkITlDY5sv05cZ8xz5We9OMeGO4Oe2eLzxGMm11xyJXz3uVGYHIZkto=
X-Gm-Gg: ASbGncujxd7AWvUdoM494EvMUjDgXrS21kWofYNqYThCwcH9ACPr1oj6/cCHATu0R1E
	hbOiqDCt24pyinqBtARIdzzWGLtWjGJYtk8xcLoNNHHISPHdKfClvY6MMhTyDg1lMuPgC8CxA4V
	1bOHxl3FoLtfZeag9mE6spCEl9I2IiGqPeUBMrSrAgZLMSHC3fDNSQOQRDizfeYayc7K9BtXJ8G
	eiJDgatD0r31QDf5nqNrBWMoBejVD1htv35ixVsVxfj5QVEl4GDIdCfQ2rDb8YoOfTcG+AAHR6d
	Mwpzk0WKEfRD0xfZwRcVVocJWa+H3lr6XP3zbblixFNMoAiVI2/w2J4N4dDtiVyxj8yUKYDLskv
	uc6Q1PcIxkmRPNUw/D+pjnb/KunIivN5Qfemla7mHhnXdw7ZGzDmtAxb59o0K7z4=
X-Google-Smtp-Source: AGHT+IGnVIY1635A1RWlmZABzr9jpP8GTjiA0Dy5g3GrL7EjdlDZzB/3QYONtWoQhLpPIbA+EZJU8w==
X-Received: by 2002:a05:6a21:33a7:b0:220:ace9:193c with SMTP id adf61e73a8af0-23dc0eb9e63mr3859624637.38.1753859800069;
        Wed, 30 Jul 2025 00:16:40 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4215a79146sm1735599a12.47.2025.07.30.00.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 00:16:39 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	treapking@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add several generic edp panels
Date: Wed, 30 Jul 2025 15:16:29 +0800
Message-Id: <20250730071629.495840-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few generic edp panels used by mt8189 chromebooks, most of them use
the same general timing. For CMN-N116BCA-EAK, the enable timing should be
200ms. For TMA-TL140VDMS03-01, the enable timing should be 80ms and the
disable timing should be 100ms.

1. AUO B122UAN01.0
2. AUO B116XAK02.0
3. AUO B140UAN08.5
4. AUO B140UAX01.2
5. BOE NV116WHM-N4B
6. BOE NV116WHM-T01
7. CMN N122JCA-ENK
8. CMN N140JCA-ELP
9. CMN N116BCA-EAK
10. CSW MNE007QS5-2
11. SCW MNE007QB2-2
12. TMA TM140VDXP01-04
13. TMA TL140VDMS03-01

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d0aa602ecc9d..41ea9f65892e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1757,6 +1757,14 @@ static const struct panel_delay delay_200_500_e80_d50 = {
 	.disable = 50,
 };
 
+
+static const struct panel_delay delay_200_500_e80_d100 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 80,
+	.disable = 100,
+};
+
 static const struct panel_delay delay_80_500_e50 = {
 	.hpd_absent = 80,
 	.unprepare = 500,
@@ -1796,6 +1804,13 @@ static const struct panel_delay delay_200_500_e200_d10 = {
 	.disable = 10,
 };
 
+static const struct panel_delay delay_200_500_e200_d50 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 200,
+	.disable = 50,
+};
+
 static const struct panel_delay delay_200_150_e200 = {
 	.hpd_absent = 200,
 	.unprepare = 150,
@@ -1865,6 +1880,7 @@ static const struct panel_delay delay_200_500_e50_d100 = {
  * Sort first by vendor, then by product ID.
  */
 static const struct edp_panel_entry edp_panels[] = {
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116XTN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unknown"),
@@ -1883,6 +1899,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
 			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x52b0, &delay_200_500_e80_d50, "B116XAK02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
@@ -1890,10 +1907,12 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8bba, &delay_200_500_e80_d50, "B140UAN08.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa199, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa7b3, &delay_200_500_e50, "B140UAN04.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc9a8, &delay_200_500_e50, "B140QAN08.H"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0xcdba, &delay_200_500_e80_d50, "B140UAX01.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
@@ -1956,7 +1975,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80_d50, "NV116WHM-N4B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80_d50, "NV116WHM-T01"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
@@ -1978,14 +1999,17 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1163, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x124c, &delay_200_500_e80_d50, "N122JCA-ENK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140HGA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14a8, &delay_200_500_e80_d50, "N140JCA-ELP"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x7402, &delay_200_500_e200_d50, "N116BCA-EAK"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e200, "MNC207QS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_d50_p2e200, "MNE007JA1-2"),
@@ -1995,6 +2019,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1462, &delay_200_500_e80_d50, "MNE007QS5-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e80_d50, "MNE007QB2-2"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
 
@@ -2041,6 +2067,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0009, &delay_200_500_e250, "116QHD024002"),
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
 
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e80_d100, "TL140VDMS03-01"),
+
 	{ /* sentinal */ }
 };
 
-- 
2.25.1


