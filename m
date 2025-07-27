Return-Path: <linux-kernel+bounces-746958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3EB12D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BABF4A2737
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA417A305;
	Sun, 27 Jul 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXUa9Wwk"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DC18E20
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583490; cv=none; b=fENMM2wn7eDHbkJbq2v6+VyYEDApwYkFQGRX8AkmdSY3EotrNNXILesOdbwtcz4C16fE5/BbllyqDrFrIvDDi5JPPh08PLCUiugvxnrAWUMeSroVHD2n5mYgy9hI0GP2o4S4uGUlYmk5P2TXzOtsaZeLe3mMOGSn6dEhpNkGfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583490; c=relaxed/simple;
	bh=Jsy709GoxU3wlTCw7VSAwO3/E0HBYE7ri8vIrPRkABQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F77J2lOwiXFfprFFdo+Euz+blG/9nKlP3KiZD+G5LOA71PX9VGgZyL5RG5SJdPUE6b4WhgXfz0yuZ+X7HjDyuIgOavfAw+fVePoLXQs/p0SLRhevdhC5bGqIgD/EiPb2uYzze9eH2LjfkGLwo20IN8TEMgHPSUASgELc+pi56UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXUa9Wwk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so3709150a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583488; x=1754188288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVzXbCr6ZYLPMUjF1Nvt5pZ4AASbWAEjTVHPcC7iE4E=;
        b=gXUa9WwkjI6KF9JSiZgyhpwMGl3R+sKMhcrDEO/pi1zppMYcyqlLRlBObxKVPKtigG
         9HszJEoDiNGIbbu4G/uDKShKbMyuwKft2Ooy/e1VDNh4mByHr1C++yTB7xGdd8yKOOxW
         j+OCgFMsNh/Nd9nrCsMc+gpG+KC9OOAYyZj2JIP7QaDLkOgi2bkIGYqT7ptcOQEv41Cl
         OTm5Wwl/D+RFP1U57l9ntooeOMsfdLfaTgxvrzjuLK/Ohls6QvhKNNcUhy23Cd7rhJRF
         FYJByQxY0g4re1Ve+g8PAEHAEIttLOAYTut38mt/LnqlS/ipm98r4HWH4pUv6JaDxp/5
         HmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583488; x=1754188288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVzXbCr6ZYLPMUjF1Nvt5pZ4AASbWAEjTVHPcC7iE4E=;
        b=GU0zTzVtEZyNmDoD98HFoxPTBS9tefVutSeA2wqdzRei5HWWkibZcC03dHPofunNzj
         XPo4CzLxakhB2tLwd2Q3mqK0d3a7duKvtN62OcBUtvxBNdd9DRokWJx1q1UbbItoHDQY
         hdT0tE4T7uiaZXIG/YEkCRVYcQbUUQRWrTXfGyhDUZ6yYdCkaYmWlKQ0KLqdY872Dy+M
         On/BxCsnvVgmMK7QWmpJPIcuFCN9Rai9sKPa3WH2RKhzPGq9sPulRSGPw4InRorRjWAp
         8FvgPN/Pfzd0Fta9c2Wr3E8kYEeFSiLVFUv28m+Kgg2pLd6nKUbrPtXO2wqzRsOZ5Jc6
         Jsig==
X-Gm-Message-State: AOJu0YwklgO7xVbP71FUj7T36RuJzI0NZH07pcuMY7Jbu3feH6SXMj1A
	IV0Bm8vgL7rdsZOBCUaE4b0oi69GNZgnPLmdZFzM7yyXhoqZLRBFbFqYwh76Vqhz
X-Gm-Gg: ASbGnct89frA/WQdUZMB3SK1OBZEIELLNMNL3gnrrYoGY9A/Wa7r1oRp0dcRYO0X5zx
	2eophAsUTEWn8TA92oO617QNkUtHv2fFyfYFkan3i+aM8oS3bPMEAbVb46/qClZ7bihfLR0Fmpm
	17Ano4OUiIU7ArYsV3PYIqPUxboHPKVHcLoICjPs0gGgCXi/CfyAKqFc1PuRX9G4u+HQ3G2MKzQ
	RUWGzkF9TwUllQ3jfPTGPTHnuhtnANl8ujTFHDBrgAZ7O6d/CtA6QI89C9nm3Xlz/p443NxabzG
	nTHpJbQthcr1pd1duVmmimuQWaURl7h7ZjI3OjjbVSFyk11O9SrwUFZalIof9+62ajZxXHnvJfs
	Hq7J+Nu32lx2Xn0a5TjM1IZ23aBlrkt9m8bjo7q3aUC23cwhOUCG3NwUiS2Pm11/BXRA=
X-Google-Smtp-Source: AGHT+IHs3PQ10I/jiQsS/9CBy61Wn3/wgxWpnqI0/+yb4WkZMCVEVrveE0JcdZvYL2kzukJjf33XrQ==
X-Received: by 2002:a17:90b:3c49:b0:31c:9dc1:c700 with SMTP id 98e67ed59e1d1-31e77afeb92mr10278311a91.26.1753583487867;
        Sat, 26 Jul 2025 19:31:27 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ebb37634bsm752225a91.29.2025.07.26.19.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:31:27 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/i2c/busses: Fix typo 'peform' -> 'perform'
Date: Sat, 26 Jul 2025 22:31:31 -0400
Message-ID: <20250727023131.82533-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/i2c/busses/i2c-fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index ae016a943..1ee38113b 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -489,7 +489,7 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	if (rc)
 		return rc;
 
-	/* if sda is low, peform full bus reset */
+	/* if sda is low, perform full bus reset */
 	if (!(stat & I2C_STAT_SDA_IN)) {
 		rc = fsi_i2c_reset_bus(i2c, port);
 		if (rc)
-- 
2.50.1


