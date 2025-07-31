Return-Path: <linux-kernel+bounces-752641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0078B17897
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB635836D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BB270ED7;
	Thu, 31 Jul 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvnq6llF"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47626D4DD;
	Thu, 31 Jul 2025 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999005; cv=none; b=vBCYQRrLy+/CIGzklAEmyWOG2HNTY6iDqeAwroMW09+OsXB8+wSJIRPHo6glJVaejYvQRwUSk1pi+yFarzGvtZsG2X6raoIvlHJT1PBZflnNkE8MjFR3wXb/ohx5gqwAElBZelslSkMSMDXQUaAmDQ75PBiz0STq8n1V4yLtWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999005; c=relaxed/simple;
	bh=Cmz41QVhtMMOlilRXguR9/aenPq9lJbwgmAlJi1b3/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2yrzgYuKYPDlcTcwI0P6RlahIa5/cbWm77DRUG7rJHuKfclnHjKU+8+irvYb0jdCdZiuxc3cYIGidrnFKLF7q+wuFqUyG79Bu0xlYnx3uolxA2jFCMElSr7duIwuMIPVSiRioTH8lLESyZIoYJmZBvl4Pp8eifikeYPIjS9alM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvnq6llF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so165479f8f.1;
        Thu, 31 Jul 2025 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999001; x=1754603801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oikj3gJvT+h9/I8C9wpIBKyLSojiwJyw/hlHslq3TD8=;
        b=Bvnq6llFzpqdftQqkDVu9mu7cBg73CMn9LUtbuE2MM3sYJhgchIDJf1R76wHN2T+nF
         Q/84Ab1lcujnlH7AlyzSD2/WtUAHUI5xv98Z7ET9/U1C3CAJziI/CtnfykZrOPaCM19b
         8QTtP5IzkeK2kuFUor92Tzzir14x3zvUZCgZzYbZp3tSxDuaC6QIo6uaLHhtqgBQXhwu
         ZQeI8iQTiA3k6n7dWhc4V30WCba7F9+l+X64g5eT2lSDxpTnMmq+HpEg/N136bgg6kkw
         XJWJrZYdsyX7moKunVee1bRpdlBnyK+E8fAZHUAvRJcA58kwPeaqx9ygAWHGPpxV+H3o
         jHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999001; x=1754603801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oikj3gJvT+h9/I8C9wpIBKyLSojiwJyw/hlHslq3TD8=;
        b=j4i1VGQ+yrjQ0bFbJJMrp6hcYTgQK1tVgPCxTl7JTOF9rXCqu0irUiRxeuZDksit7P
         KjGqGthPAixE11eMK3kurIqPbAMuQTvJp1AlA+aXznmi4a8nx9uNZ+MPNghGJCzj12HW
         t1MyEeECIxdtCJcZ3/z3l5GgL+4UE76WHmrk3OlcB5zBTQ2sTeQpXVJ96d0B2Sl4tD1Z
         0Ft3re8mNx/2vOssbw94C+c0XpOBkSOcaf9q9YE/1S2f8cVagAjMFE/2pbfGETfyVraT
         QXNn9qeSI9w4pXI2AepLkc0gYbxZs78+sP6VkszhMcu6qKedt7+1ylMBgxdjlCmSzN1g
         hFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP9/uJCOzOP/RVOrlk4kl3pkX1vWHJEZOeBfAaBMF6aCAMPgjAGaf7hEXOvFSCOaVW0X9Q/+6SGNns@vger.kernel.org, AJvYcCWohok6SJ/j8Mbhr/jL6Wfi0/l55JpZL1La065+hRqvfQotXyBdwLYhwJ/t8fqywrLcgWjEUMMdo8LHljly@vger.kernel.org
X-Gm-Message-State: AOJu0YzYoxHsL5R+QDvlxMIcrCpLHKcoQeXCjwmS8TwywhRg+0KoYVT7
	t35m/EUJq4H75/YdqkVRCzDU/r8mxsgONIKcseui3fnH0IL9WAt3lAA=
X-Gm-Gg: ASbGnctKw3e+I+8ofxKCu/ssAenyGynmfzM5LCi39e0JPVb2+W6uHtYaKl3uXLbMHb0
	7NluFRanC+j7ZNr3kxCsT9U2zaM4OXhcLBOrwUfuuRC6zHgYZXEZtcr+p6y1OoFBQkVp7nmyHv0
	pN+o8uPz2WlSOVvAbQIwcePXgUXV3QXcAPdZMrI6pd58TVRkNZkbC7j3sOhNsbnQI5fQtadxCDN
	ykxlb+nAFSnBOrPN05PJH31veR/OgwhSQ9jrLLiyXs6Qk5diN5/71iFXoWOIVLJPUYxfaVPR9T7
	qtiOaVhOYaO79mBZszicHAy20bHAIhdnQh213O7InSFSFH6vpw7MhZA7BIqPdxoTLraAGAw2oii
	uDvBiOzzM0dTI+6E4KsjSO6Q1gQ35QmGuzSfaJrde
X-Google-Smtp-Source: AGHT+IHOO1VhkE3sRaEGlsvQYc6q2XkaRNjDngyVISyPjIL3SY/LTSFSUCwqTeduXcndmXlSlX/sFw==
X-Received: by 2002:a5d:5d12:0:b0:3b7:9ae0:2e5e with SMTP id ffacd0b85a97d-3b79ae02eb2mr4222065f8f.9.1753999000548;
        Thu, 31 Jul 2025 14:56:40 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536abb1sm86622565e9.4.2025.07.31.14.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:56:40 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v2 3/3] drm/panel-edp: Add BOE NV140WUM-N64
Date: Thu, 31 Jul 2025 23:55:10 +0200
Message-ID: <20250731215635.206702-4-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250731215635.206702-1-alex.vinarskis@gmail.com>
References: <20250731215635.206702-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
eg. Asus Zenbook A14 UX3407QA.

The raw edid of the panel is:
00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8

70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..b241d1807002 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1947,6 +1947,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e200, "NV140WUM-N64"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
 
-- 
2.48.1


