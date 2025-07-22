Return-Path: <linux-kernel+bounces-740098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A2B0CFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9F06C5D39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C261E3787;
	Tue, 22 Jul 2025 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="qG4fNj7t"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942A143C69
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152322; cv=none; b=u1ArNBRkjLljCBj1eDHJgjdD1X6qLMH3uuOMJ5uNHrrK4mgAqtXjh/PIanqAUL95G2tiWVntTBCI1M7o+8/1+WeUKWNYT7X+d5CEi17IOch1LMJDWbpHl5ZYnh8isEm0xQ9QtMEM2B8JdMHBUax9Xo7vDE1sZy4KJ2CioMLxUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152322; c=relaxed/simple;
	bh=iAIVr3Uh7hTXBJLB7vEHDIJmDL1hU3t1tXVTWRY9MMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JX7DEsvMhmpjlLwggyztukWNDDr2OLLjIGMomheg5mKeqO+jyomyFfQspd4HrSYcLCrOg8CriDgx1Wm0XeKun3hTJYrcTiC8I63zXj01cKzsY9di4xlWBK0zt6LcYJ65HH5UEgNEj0hnLXmtFecjE10ufaWuLXjnAtX/OvvhdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=qG4fNj7t; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3508961d43so4529618a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1753152320; x=1753757120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgR5lyoK6/GJ41X9p2+Joh61MHj8cPp4obeeP6rb+Do=;
        b=qG4fNj7tjZz/3FCj6/amvB8zWIef6JNhW0GYrydzMfeWpANGo+InpbqzuIZ1FtDD12
         uJw9eyKbDcmS6+/6BjEgzASJmq4mMaioib+BkQuwPLjTyIyo552kKFIijBVmBa+0SMj4
         YOk0NETvEO3l+oUC5wWZLKjuH6HWaW8UcgVXSwZBlHfeO8ZdPsgSw0DpnYsJtUN6klSq
         fHXo9tEAgLLPCVmFyDN4BrRA2dPacWMTxb+qD/iBVOasoXJeF/syGFn2d0Hq5mGVoxKd
         iwHJSLyPxQU3p9Wr2CBQ243nDhASl0UEXHuGMeKYO7gTYTqgDtUHV1VpsCNtEggKodL1
         B9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753152320; x=1753757120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgR5lyoK6/GJ41X9p2+Joh61MHj8cPp4obeeP6rb+Do=;
        b=rRLjOjPz5Jj1LXXxyVln/MDV663XEv2B94eAlSopSF6XAFXdon8P3Vi7D/8hW6dZ+L
         OXWTYrLhxpHzmEQ+VCgoU+Zf+3SlnwatI2Us88KPUeNhfptBu09p8jR8ycyOI2C5GCSZ
         nDv5/FYuZXLPQXkLS2sQrmFZieRDCmFyb6bYTOZ8RBWjT4tskQWIj6VgK3IMcAqEhbuw
         2a3VSWumN+DdiSOGXhRrNc17khMJIo9/C44/43Ox7nkic3sAsRHHKez3EMPneNNWQG3y
         ijQynS1hrVnZlq6LRxBe2rql/4eFvTlgU0g/LHzUfEPuhVcZcS+NfK52M76XcBA0ZDG+
         MR7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRn6uXrdiXr9ejpGcB2rhv/KYLqCmjHIB3HPdcxcdYwjXxavNCuMhSA9sGfSb03jpi+VvgNcUKobmPx7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5gQi9RatTI4HnyQR7GC0ohgtSfpFxLKBJ7IdxXCt0DjHmkE5
	motoqQRs54G68hQSGo3FHPFxT3+Vf5TRgTbLzND50R7AduLVTJjK+5xlox9arC1XMPs=
X-Gm-Gg: ASbGnctMrPQMZBbGVj+eOBs2s8W77Wt+85sk3yKmYqlSSlnBM56AlNxAJNodjhPkMI6
	Xk9IyeUHMDurP/+mnQR3qnaxZAvhzxSVBkYyJK1AYj9mK16mRfLap4W0VTFcgoqTXDOuTBS/B7o
	IqSL0gxoUBB72JHOcTYMcOBa/TJQ9xDnngo1q3e8NboFkTtLjWzmQKa7Z/PH9Ia47dALgwu1W1N
	yVsEIdxvXWS2S8jpxd18qL4+XdhzrEgs7tzDrXqcwLLZV5pdfL1dTb4QK+fsIB2qOJuSiHAv710
	DnA+xDGPFEuabV2Ie+zZEXNGyGSYFDDSf4MXy5mZNnNXOvVPao29xWoP+uE0wRN2Aq+DH/iEbzm
	m2SGzQYto6avjQdIP/NAWF2t4XfAOP+HB0IkMXYUo6WpPl8wTOHYDUxoEhEdF46Yz5vYbrg==
X-Google-Smtp-Source: AGHT+IH/Q+dX34w1vgsvL0us1ncK+GZVoY6ee3ZuaokqA8D2OA9tnAnpdE9lvFFBdQr6D4JmaqIx3g==
X-Received: by 2002:a17:902:ef4e:b0:237:ec18:eab9 with SMTP id d9443c01a7336-23e3b80c3femr189211675ad.32.1753152320172;
        Mon, 21 Jul 2025 19:45:20 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b4adeb8sm66117965ad.0.2025.07.21.19.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 19:45:19 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
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
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add 50ms disable delay for three panels
Date: Tue, 22 Jul 2025 10:45:12 +0800
Message-Id: <20250722024512.983313-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 50ms disable delay for NV116WHM-N49, NV122WUM-N41, and MNC207QS1-1
to satisfy T9+T10 timing.

Fixes: 0547692ac146 ("drm/panel-edp: Add several generic edp panels")
Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 09170470b3ef..742a83fa4da1 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1743,6 +1743,14 @@ static const struct panel_delay delay_200_500_e50_p2e200 = {
 	.prepare_to_enable = 200,
 };
 
+static const struct panel_delay delay_200_500_e50_d50_p2e200 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 50,
+	.disable = 50,
+	.prepare_to_enable = 200,
+};
+
 static const struct panel_delay delay_200_500_e80 = {
 	.hpd_absent = 200,
 	.unprepare = 500,
@@ -1941,13 +1949,13 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a1b, &delay_200_500_e50, "NV133WUM-N63"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unknown"),
-	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116WHM-N49"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80_d50, "NV116WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, "NV140WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, "NV140FHM-NZ"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, "NE140QDM-N6A"),
-	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122WUM-N41"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, "NV122WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
@@ -1986,7 +1994,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
 
-	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200, "MNC207QS1-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e200, "MNC207QS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_p2e200, "MNE007JA1-2"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
-- 
2.34.1


