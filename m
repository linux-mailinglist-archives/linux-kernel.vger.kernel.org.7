Return-Path: <linux-kernel+bounces-747747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBAB13795
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39249176CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55B2522A7;
	Mon, 28 Jul 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBDHkC3p"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3F22C35D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695282; cv=none; b=ObUdva6TGhF+247xxpBk1PjoUbrCPcIql3MJZ+Jy7kjDr6lzu4uPSm4VgnJiBbW4tH65+0NfHvJa7oDOHMzsdwWpvf8h1jpCSuwxXwpnwToVo6/364/lFCETz/oJUkCb6kosPDcxHv8oEc0j543BwXpBIyPtzuChnSKiGuRt//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695282; c=relaxed/simple;
	bh=FVjrhbgU51oFrsK8FhKQpqxMkotAxlE+hef9bztLMf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRACm/hOlOIUM+F2MaFl80Y84t1QFbt+Lf3LI0Y4+eHAhLVF72cJqjHTqkDCMbS3tzWE/W7LTHy0xQNLaslzv0swq6DBdyYNOUiIB1FTp1o/b4mYWwHiMXBJOrlNLEzwCXGpwQOXJa3Krj/rUObwg2HQBsLTbOwwnaz1h4i1V5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBDHkC3p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24009eeb2a7so7309185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695280; x=1754300080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoKs7p6HZYNszKO17OO4KdXekmUg9ugS36Em0DKxuqU=;
        b=bBDHkC3pwdb7y2/HKoI6BORHAmtbWB7bG6e8ixtp9wpkiO1hmG8mMa18Ev7aRvTV3j
         W1AsoHJqGPYegF+D9YzMemEqC2NvHBO5AdHFtsdCWZvSXMNgRRyvYemnEYZLHknPn0bc
         l3VHrfLu1EMXNoFJYgdih+BAUm5t1YrKRN6WSj6i4PRPgEyPMa5EfR71ZHxVlKNpNQs+
         bx1uqMS4e2UVqi0F6Dmq+HdVRRLUO0y9U8W6p+xhrGSZ9e0vJ3qiJjsJx1B8bUE/9hEx
         iERmb+GhAt0Url8jHQL2kDEOUX20jJQS49Qqqkffq2i6OKSfJsAMBjV8cYA8En6T21g8
         7Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695280; x=1754300080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoKs7p6HZYNszKO17OO4KdXekmUg9ugS36Em0DKxuqU=;
        b=vq55uHX1N1m1x71pbYe4si6vkSd+6Rk+pAH0yamd1ukNDFOak7ASs74xooOu0OeAoA
         nIqTQoM8BTGp73q3P79pdX1ufZcy7a4MU0IjohWk1E30srqIPOunJI3ZJg5TuoHF95uz
         kgkMyZ+0Chzly7IXLHjq3+9Ezvthn8yCZj1vKHOzB2XkkY9ZpSME/xND39NyzK3gYhwL
         dHRDHrqIFXQkHOnuFQ4FASM8kbt0U9M9EIIBPaB8Oui6GmY//Nl8hWr/b37G1VgJvBfP
         J2F0mmUFFkDgZaj1bQ+KBg5uQcIJ3CBCCKwwAYCaG3ZeCw0wHWOThhovoDnyixPVTFnC
         SUlA==
X-Forwarded-Encrypted: i=1; AJvYcCXMqmGUuvGkGfBSYVkWR5aPJceEx0NEVltYbtKPuL8u2ScYewoa8Xjy20VsAWOlDLdWteuHLS858q7zDUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpYc+3G0Oq6Ey1eOPsq/9SyUV/guL2ZLlvyRDDMfBxDjUWAxl
	08YIFx3es6e+SEEYvcR05UpeG0ae/IE5zW1FA3ZawXr7sXYlQcRYpMCk
X-Gm-Gg: ASbGnctEzY6A8MshFBzvH157mKFHuAsmf/tizWIAO/koV4vvTMhxZaw5kdEEIoCaODi
	1lbNa7K43iWzwJq+PxqT1grnRwzeTAFUTNnsGZJNBET1E7IKbHGEDNHAryogNIUHd8MAQRkkA14
	fvqImMVFSIX+zXxYfxJxYlZtvxrSB2eebYXjupTTCWJ75loCqomorj9wC1JvLW4taD0vwpdX0C0
	uQB3yJg4Aw05sWlaC/WrVH9MpqQ1IJU7sEWKzPv8CBD4HiS2V70OaKD5ySUGf6bHoWoydqQMpoQ
	4XRL0a3vflTi9cboGCPyelPcxAo5pgHF7J2qiHUn8hJg6jiKMWPt6DJmDnK8PiRWPjNgjUJrZKT
	mWIN2GpC5VH6kg67j/jFFSxvzg05j/U1lGj4UNa2Uqk8b8Okvnw==
X-Google-Smtp-Source: AGHT+IGjJPaZL1a0kCFTxQSZwuSbVti44KmI2KrA1FlBXfoREc0LVs07EjrFSf+mheRkE+jWaoW3Qg==
X-Received: by 2002:a17:903:2345:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23fb3040f6cmr137246975ad.18.1753695280353;
        Mon, 28 Jul 2025 02:34:40 -0700 (PDT)
Received: from localhost.localdomain ([49.36.70.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe546bebsm49809855ad.179.2025.07.28.02.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:34:39 -0700 (PDT)
From: Dishank Jogi <jogidishank503@gmail.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	darshanrathod475@gmail.com,
	Dishank Jogi <jogidishank503@gmail.com>
Subject: [PATCH] zorro: fix checkpatch error by avoiding assignment in if-statement.
Date: Mon, 28 Jul 2025 09:34:12 +0000
Message-ID: <20250728093412.48065-1-jogidishank503@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes improve code readability and bring the file
in line with the Linux kernel coding style.

No functional changes.

Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
---
 drivers/zorro/gen-devlist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/zorro/gen-devlist.c b/drivers/zorro/gen-devlist.c
index e325c5ce995b..ff4515e02409 100644
--- a/drivers/zorro/gen-devlist.c
+++ b/drivers/zorro/gen-devlist.c
@@ -44,7 +44,8 @@ main(void)
 
 	while (fgets(line, sizeof(line)-1, stdin)) {
 		lino++;
-		if ((c = strchr(line, '\n')))
+		c = strchr(line, '\n')
+		if (c)
 			*c = 0;
 		if (!line[0] || line[0] == '#')
 			continue;
@@ -68,7 +69,8 @@ main(void)
 					fprintf(devf, "\tPRODUCT(%s,%s,\"", manuf, line+1);
 					pq(devf, c);
 					fputs("\")\n", devf);
-				} else goto err;
+				} else
+					goto err;
 				break;
 			default:
 				goto err;
-- 
2.43.0


