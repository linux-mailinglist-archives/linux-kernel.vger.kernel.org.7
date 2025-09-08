Return-Path: <linux-kernel+bounces-805096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805FB483F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E343AD005
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04E224247;
	Mon,  8 Sep 2025 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNCk/Ta/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD773FF1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311987; cv=none; b=V3JpcPdlCOXED6r4w4098wsJDRNTSQEe0rQzbUiGyBh91QcFxU7bPme7janu4QxGB5uVyPaUFhDxXgc8Ru7Migd0nrAcIKGV2YTJRWKGAMxUVFG/nPTsk08aNe6UhNKUDscrenTgSkfuXAF7VAq3sIMCW+HFJJdk/tSH5CFSWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311987; c=relaxed/simple;
	bh=Qc4bsHVtegZZcT4Q9MAJ2Xhzn/hgV95X7DWU0v6B3Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpKQ+GrCgSRoeDUUphsO0nsnh24Y5BK5ywqvdIIAO0ut3uqqESRejd4+ERuO+UA67L2lrHMfGAWOmT3QdB4QXDgaQZdvqQ3kP289tfKZRsshWpje4QX4rKZEDX2Icd6yYJ3CVC6kDH1Ig2M+iw4bFb5pRY/PtHkX6KCkA9mo/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNCk/Ta/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so6326358a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757311984; x=1757916784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC8L7gwN/P+xK7g9ZrzjI62mr0TB4jFjFMHOdIX7NnE=;
        b=LNCk/Ta/QvNxhG6Ma2iI9qD2e02XlWHr8VTRq2cL+rVpoRcUdIwViMl6bGEaELxCDx
         Qz/m31uEs8MI5tkGxCsTKirr3pEP2S75HZlt/UFdrPiEDPcwNQCVL18BNCdXepvqxxcS
         4KIiS4RRqX0byNAn7oM6nmA2KHgpm53U1dZeEPmsSH27sqxnwsU6sjd8BGvyI4nUOhAO
         3qrm/lThTfsq6yh38lnRihZWsg7tyDffWWAtT2L2+8sm1REbcb/w5VmUNANlaCl6CndN
         3Ic9HvRMIcMTC3EapXiMaUdOlk4cCtZo/S5621xSm00qonPlC+zB07ytm+ykVjKEtGVG
         AkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757311984; x=1757916784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZC8L7gwN/P+xK7g9ZrzjI62mr0TB4jFjFMHOdIX7NnE=;
        b=hrJCeBk1Fn/ioIYL3JYrTSzy48G0FGehOTficHySMBUppWu7ifv90bTh5Rtn/cv6tp
         R3y23EVKYyOgql0nDujMpTyU5sTD+neRkoFctYu263P3IVfC1AGNPFpcyQksjKf6Hn3o
         mv3MCF1EzgLTMcguBs2sGMa+QUF2jo+y8A7C1/MUYZ/ch2C5uh9icdIs8TB5Sbvxgo+2
         r6WaZabU6amczpHI5wBYV32DuT78fENuNkUBJFkjJ9+peJlpq6Gt+Opl8skw8sRlRzFg
         aqrMS5DRdNM3dMkBqg7GS0+RcBKT9/CeLOWYXZ6s65yPXuGP0iLOHytzt3J+hLZs1S7+
         lNJA==
X-Forwarded-Encrypted: i=1; AJvYcCW2fFqurZax7YEIk+rVuEjRVIPZwKABJ3tTsDv9himgWwvth2kEI6nBP4OxjdiDvDzm79L1RNhVhZZIqBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCr7G+cIA8FjzQ7HPtrQJjNxZdrbWUIGqCg4jAPGjUs/UH5Fpw
	v5x8W4DtGE1Y5QROWShjCx1l9R5pIVbW8HhsPlf1c8EH+gnio6Rq6E1V
X-Gm-Gg: ASbGnctY63wtY/lotfZDt9K9OD902icwnzX9WX+sAKf/wojYCsYeEYCFTtnzXAVW2+O
	gv5x7iVcYg6MFIIYyBiWH2m3svEqof/9g4ZdFcjD7kuyNLh5AmbGH3fj/QW9lRwCQZlyWlesvvX
	IyPIdKytCPisgpHSBl/qVj+4K20yY73Dxp/Th/zmEJn/qUIQLJCyP+WpIxg28PQdyRTD8TXA5gA
	G3SIpZTRx+EmPExm6oqIXH5EmSral+9mjyXEuNLFwiF0Z7S0BXH6j1++9bDnoDHxqbBD+gjgak2
	haqmdbeIi2lSrgpuQMJyZNihOWgv4qJI9fRPlfc74kFwCCiri4FBfmPHbGq2vY+Ec0Lf1vXypqh
	L1qq7zwqGY4xbs2XGz5diQY+D3j46leBLZz8mRJuR5eJzW68lYS9KmlI=
X-Google-Smtp-Source: AGHT+IGjyv2g0Hoy+GpwpNntbrskFyIXfjwG34HMBREFvxg8rJ4IkZOlj/srXH4ccqbTT/+w7h/eiA==
X-Received: by 2002:a17:907:c14:b0:b04:3513:5138 with SMTP id a640c23a62f3a-b04b154786bmr714144466b.41.1757311983317;
        Sun, 07 Sep 2025 23:13:03 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-28.web.vodafone.de. [77.25.33.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6234c677dbdsm4870248a12.50.2025.09.07.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:13:02 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove unused tables
Date: Mon,  8 Sep 2025 08:12:43 +0200
Message-ID: <20250908061243.62692-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove some unused tabels to get rid of dead code and thereby reduce the
object file size by more than 1400 bytes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 152 ----------------------------
 drivers/staging/rtl8723bs/hal/odm.h |   6 --
 2 files changed, 158 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index ba85efb30db2..4b36af47f680 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -9,118 +9,6 @@
 
 /*  Global var */
 
-u32 OFDMSwingTable[OFDM_TABLE_SIZE] = {
-	0x7f8001fe, /*  0, +6.0dB */
-	0x788001e2, /*  1, +5.5dB */
-	0x71c001c7, /*  2, +5.0dB */
-	0x6b8001ae, /*  3, +4.5dB */
-	0x65400195, /*  4, +4.0dB */
-	0x5fc0017f, /*  5, +3.5dB */
-	0x5a400169, /*  6, +3.0dB */
-	0x55400155, /*  7, +2.5dB */
-	0x50800142, /*  8, +2.0dB */
-	0x4c000130, /*  9, +1.5dB */
-	0x47c0011f, /*  10, +1.0dB */
-	0x43c0010f, /*  11, +0.5dB */
-	0x40000100, /*  12, +0dB */
-	0x3c8000f2, /*  13, -0.5dB */
-	0x390000e4, /*  14, -1.0dB */
-	0x35c000d7, /*  15, -1.5dB */
-	0x32c000cb, /*  16, -2.0dB */
-	0x300000c0, /*  17, -2.5dB */
-	0x2d4000b5, /*  18, -3.0dB */
-	0x2ac000ab, /*  19, -3.5dB */
-	0x288000a2, /*  20, -4.0dB */
-	0x26000098, /*  21, -4.5dB */
-	0x24000090, /*  22, -5.0dB */
-	0x22000088, /*  23, -5.5dB */
-	0x20000080, /*  24, -6.0dB */
-	0x1e400079, /*  25, -6.5dB */
-	0x1c800072, /*  26, -7.0dB */
-	0x1b00006c, /*  27. -7.5dB */
-	0x19800066, /*  28, -8.0dB */
-	0x18000060, /*  29, -8.5dB */
-	0x16c0005b, /*  30, -9.0dB */
-	0x15800056, /*  31, -9.5dB */
-	0x14400051, /*  32, -10.0dB */
-	0x1300004c, /*  33, -10.5dB */
-	0x12000048, /*  34, -11.0dB */
-	0x11000044, /*  35, -11.5dB */
-	0x10000040, /*  36, -12.0dB */
-};
-
-u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8] = {
-	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04}, /*  0, +0dB */
-	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04}, /*  1, -0.5dB */
-	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03}, /*  2, -1.0dB */
-	{0x2d, 0x2d, 0x27, 0x1f, 0x18, 0x0f, 0x08, 0x03}, /*  3, -1.5dB */
-	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03}, /*  4, -2.0dB */
-	{0x28, 0x28, 0x22, 0x1c, 0x15, 0x0d, 0x07, 0x03}, /*  5, -2.5dB */
-	{0x26, 0x25, 0x21, 0x1b, 0x14, 0x0d, 0x06, 0x03}, /*  6, -3.0dB */
-	{0x24, 0x23, 0x1f, 0x19, 0x13, 0x0c, 0x06, 0x03}, /*  7, -3.5dB */
-	{0x22, 0x21, 0x1d, 0x18, 0x11, 0x0b, 0x06, 0x02}, /*  8, -4.0dB */
-	{0x20, 0x20, 0x1b, 0x16, 0x11, 0x08, 0x05, 0x02}, /*  9, -4.5dB */
-	{0x1f, 0x1e, 0x1a, 0x15, 0x10, 0x0a, 0x05, 0x02}, /*  10, -5.0dB */
-	{0x1d, 0x1c, 0x18, 0x14, 0x0f, 0x0a, 0x05, 0x02}, /*  11, -5.5dB */
-	{0x1b, 0x1a, 0x17, 0x13, 0x0e, 0x09, 0x04, 0x02}, /*  12, -6.0dB <== default */
-	{0x1a, 0x19, 0x16, 0x12, 0x0d, 0x09, 0x04, 0x02}, /*  13, -6.5dB */
-	{0x18, 0x17, 0x15, 0x11, 0x0c, 0x08, 0x04, 0x02}, /*  14, -7.0dB */
-	{0x17, 0x16, 0x13, 0x10, 0x0c, 0x08, 0x04, 0x02}, /*  15, -7.5dB */
-	{0x16, 0x15, 0x12, 0x0f, 0x0b, 0x07, 0x04, 0x01}, /*  16, -8.0dB */
-	{0x14, 0x14, 0x11, 0x0e, 0x0b, 0x07, 0x03, 0x02}, /*  17, -8.5dB */
-	{0x13, 0x13, 0x10, 0x0d, 0x0a, 0x06, 0x03, 0x01}, /*  18, -9.0dB */
-	{0x12, 0x12, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01}, /*  19, -9.5dB */
-	{0x11, 0x11, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01}, /*  20, -10.0dB */
-	{0x10, 0x10, 0x0e, 0x0b, 0x08, 0x05, 0x03, 0x01}, /*  21, -10.5dB */
-	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01}, /*  22, -11.0dB */
-	{0x0e, 0x0e, 0x0c, 0x0a, 0x08, 0x05, 0x02, 0x01}, /*  23, -11.5dB */
-	{0x0d, 0x0d, 0x0c, 0x0a, 0x07, 0x05, 0x02, 0x01}, /*  24, -12.0dB */
-	{0x0d, 0x0c, 0x0b, 0x09, 0x07, 0x04, 0x02, 0x01}, /*  25, -12.5dB */
-	{0x0c, 0x0c, 0x0a, 0x09, 0x06, 0x04, 0x02, 0x01}, /*  26, -13.0dB */
-	{0x0b, 0x0b, 0x0a, 0x08, 0x06, 0x04, 0x02, 0x01}, /*  27, -13.5dB */
-	{0x0b, 0x0a, 0x09, 0x08, 0x06, 0x04, 0x02, 0x01}, /*  28, -14.0dB */
-	{0x0a, 0x0a, 0x09, 0x07, 0x05, 0x03, 0x02, 0x01}, /*  29, -14.5dB */
-	{0x0a, 0x09, 0x08, 0x07, 0x05, 0x03, 0x02, 0x01}, /*  30, -15.0dB */
-	{0x09, 0x09, 0x08, 0x06, 0x05, 0x03, 0x01, 0x01}, /*  31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}	/*  32, -16.0dB */
-};
-
-u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8] = {
-	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00}, /*  0, +0dB */
-	{0x33, 0x32, 0x2b, 0x19, 0x00, 0x00, 0x00, 0x00}, /*  1, -0.5dB */
-	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00}, /*  2, -1.0dB */
-	{0x2d, 0x2d, 0x17, 0x17, 0x00, 0x00, 0x00, 0x00}, /*  3, -1.5dB */
-	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00}, /*  4, -2.0dB */
-	{0x28, 0x28, 0x24, 0x14, 0x00, 0x00, 0x00, 0x00}, /*  5, -2.5dB */
-	{0x26, 0x25, 0x21, 0x13, 0x00, 0x00, 0x00, 0x00}, /*  6, -3.0dB */
-	{0x24, 0x23, 0x1f, 0x12, 0x00, 0x00, 0x00, 0x00}, /*  7, -3.5dB */
-	{0x22, 0x21, 0x1d, 0x11, 0x00, 0x00, 0x00, 0x00}, /*  8, -4.0dB */
-	{0x20, 0x20, 0x1b, 0x10, 0x00, 0x00, 0x00, 0x00}, /*  9, -4.5dB */
-	{0x1f, 0x1e, 0x1a, 0x0f, 0x00, 0x00, 0x00, 0x00}, /*  10, -5.0dB */
-	{0x1d, 0x1c, 0x18, 0x0e, 0x00, 0x00, 0x00, 0x00}, /*  11, -5.5dB */
-	{0x1b, 0x1a, 0x17, 0x0e, 0x00, 0x00, 0x00, 0x00}, /*  12, -6.0dB  <== default */
-	{0x1a, 0x19, 0x16, 0x0d, 0x00, 0x00, 0x00, 0x00}, /*  13, -6.5dB */
-	{0x18, 0x17, 0x15, 0x0c, 0x00, 0x00, 0x00, 0x00}, /*  14, -7.0dB */
-	{0x17, 0x16, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x00}, /*  15, -7.5dB */
-	{0x16, 0x15, 0x12, 0x0b, 0x00, 0x00, 0x00, 0x00}, /*  16, -8.0dB */
-	{0x14, 0x14, 0x11, 0x0a, 0x00, 0x00, 0x00, 0x00}, /*  17, -8.5dB */
-	{0x13, 0x13, 0x10, 0x0a, 0x00, 0x00, 0x00, 0x00}, /*  18, -9.0dB */
-	{0x12, 0x12, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00}, /*  19, -9.5dB */
-	{0x11, 0x11, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00}, /*  20, -10.0dB */
-	{0x10, 0x10, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x00}, /*  21, -10.5dB */
-	{0x0f, 0x0f, 0x0d, 0x08, 0x00, 0x00, 0x00, 0x00}, /*  22, -11.0dB */
-	{0x0e, 0x0e, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00}, /*  23, -11.5dB */
-	{0x0d, 0x0d, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00}, /*  24, -12.0dB */
-	{0x0d, 0x0c, 0x0b, 0x06, 0x00, 0x00, 0x00, 0x00}, /*  25, -12.5dB */
-	{0x0c, 0x0c, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00}, /*  26, -13.0dB */
-	{0x0b, 0x0b, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00}, /*  27, -13.5dB */
-	{0x0b, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  28, -14.0dB */
-	{0x0a, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  29, -14.5dB */
-	{0x0a, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  30, -15.0dB */
-	{0x09, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x04, 0x00, 0x00, 0x00, 0x00}	/*  32, -16.0dB */
-};
-
 u32 OFDMSwingTable_New[OFDM_TABLE_SIZE] = {
 	0x0b40002d, /*  0,  -15.0dB */
 	0x0c000030, /*  1,  -14.5dB */
@@ -239,46 +127,6 @@ u8 CCKSwingTable_Ch14_New[CCK_TABLE_SIZE][8] = {
 	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00}	/*  32, +0dB */
 };
 
-u32 TxScalingTable_Jaguar[TXSCALE_TABLE_SIZE] = {
-	0x081, /*  0,  -12.0dB */
-	0x088, /*  1,  -11.5dB */
-	0x090, /*  2,  -11.0dB */
-	0x099, /*  3,  -10.5dB */
-	0x0A2, /*  4,  -10.0dB */
-	0x0AC, /*  5,  -9.5dB */
-	0x0B6, /*  6,  -9.0dB */
-	0x0C0, /*  7,  -8.5dB */
-	0x0CC, /*  8,  -8.0dB */
-	0x0D8, /*  9,  -7.5dB */
-	0x0E5, /*  10, -7.0dB */
-	0x0F2, /*  11, -6.5dB */
-	0x101, /*  12, -6.0dB */
-	0x110, /*  13, -5.5dB */
-	0x120, /*  14, -5.0dB */
-	0x131, /*  15, -4.5dB */
-	0x143, /*  16, -4.0dB */
-	0x156, /*  17, -3.5dB */
-	0x16A, /*  18, -3.0dB */
-	0x180, /*  19, -2.5dB */
-	0x197, /*  20, -2.0dB */
-	0x1AF, /*  21, -1.5dB */
-	0x1C8, /*  22, -1.0dB */
-	0x1E3, /*  23, -0.5dB */
-	0x200, /*  24, +0  dB */
-	0x21E, /*  25, +0.5dB */
-	0x23E, /*  26, +1.0dB */
-	0x261, /*  27, +1.5dB */
-	0x285, /*  28, +2.0dB */
-	0x2AB, /*  29, +2.5dB */
-	0x2D3, /*  30, +3.0dB */
-	0x2FE, /*  31, +3.5dB */
-	0x32B, /*  32, +4.0dB */
-	0x35C, /*  33, +4.5dB */
-	0x38E, /*  34, +5.0dB */
-	0x3C4, /*  35, +5.5dB */
-	0x3FE  /*  36, +6.0dB */
-};
-
 /* Remove Edca by Yu Chen */
 
 static void odm_CommonInfoSelfInit(struct dm_odm_t *pDM_Odm)
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 010274ba8079..1c929d88e596 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -1080,16 +1080,10 @@ enum { /* tag_RF_Type_Definition */
 /*  */
 /*  Extern Global Variables. */
 /*  */
-extern	u32 OFDMSwingTable[OFDM_TABLE_SIZE];
-extern	u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8];
-extern	u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8];
-
 extern	u32 OFDMSwingTable_New[OFDM_TABLE_SIZE];
 extern	u8 CCKSwingTable_Ch1_Ch13_New[CCK_TABLE_SIZE][8];
 extern	u8 CCKSwingTable_Ch14_New[CCK_TABLE_SIZE][8];
 
-extern  u32 TxScalingTable_Jaguar[TXSCALE_TABLE_SIZE];
-
 /*  */
 /*  check Sta pointer valid or not */
 /*  */
-- 
2.51.0


