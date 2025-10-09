Return-Path: <linux-kernel+bounces-846265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB6BC76E5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91A33ACD60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEB3261B8D;
	Thu,  9 Oct 2025 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfZhyTVh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5C1DF75D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987835; cv=none; b=ErpvpxhYX4mRoUi0A5p/JCykOjC2gBGWW6KdefaTM7+ZwaBz92M3wQ2K7karnGVuMSu6WYG5jBvy5XS+UhG8AvneHfZuvivnw8zAAj62BUD51hQpZAjYCEE40yDKHHjvAj4L4CepMjWb2bZw6UrzMClKaP6LeH1aGQeem/iDthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987835; c=relaxed/simple;
	bh=MWPOM5X1rJDtoAagIpIGV2JeSDedkvNxa+Z2Lzxv2gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MJu7qBb25bTEUEcNTHGJDqxoJ6fsLotyybUc0l++UBoW6jdkNFUSX7nO7Hz8056ENff67FlVgpto5g4TeOuOxUP26nwIRQz8CJ1hNjDhUInZ8DYtmX2ahmZQk+JA1rL1hpAau9zU3RDOm/Bthz82oKvjamlKnj/x77GQEZqBQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfZhyTVh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2680cf68265so4176085ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759987832; x=1760592632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66mxYYm1lwUDKT8s1UNwAUuURZhUpzHNJdGMWk83R+M=;
        b=KfZhyTVhhQ1Pl2vg8WinLxFIQrcN+uwKXFaa1eTGIapTnqLOqWSE/DtxOpZsx7W3tT
         smtKg/BY1arhhWEL0P5tCE+/f3xRv4PYs4p1ZC4eBR+h93nVsGlICRCMqnfCE4xecVdS
         9K1AqgGb8BvXH09ncpy8fDXTg9X1s9kQh9Q+Fysh5Q+N7JU0ckgKExNiv6FDmUJ1bLTg
         9NcN2Rjl0z2oeEY2HOdxuDoV9YZjC+GH8uBKDjoVjGRX6kMhSmi92FpnmLOkrzkksHUl
         /Bmmt7UBITWUzhMrpl4jBQyxnvuMPzVtl2qLP48/bxuqqIhhi56G5R1r+NvZGcHiD4m9
         i9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759987832; x=1760592632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66mxYYm1lwUDKT8s1UNwAUuURZhUpzHNJdGMWk83R+M=;
        b=c872EGyE3C5SYg9Xj0f10j4iNh+EWOGNuD9zqamxOprctiH8OMg6oiGLuTSycYMrEa
         KxAmhSFJGEjW+hXfWq8Iiros24TKlC5gLY5H1b5kc+wv9ueHVPOkegftuqjnAVFf1D+7
         QgY4/WwuDnTtATP0ak+/OaUR/WS0LtF1gGkGCZGjk8xC6BINAyzD+nVhAcBA2Md1UIcO
         TzBAtPxTVfpUhY2nYwBeaShMFiAKLNzqk0aV9wjJA1cGycdtll4RjdMu3NOkMZ2KNruc
         CQ57ewcYAEeskv1NbIqNN5AwbiKJn6TjeEZb/9oD4SRU+xlhv3AIqBTj9dQaE2qDNRtr
         kzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1TSXRaXd6RumH0whbHum/UrapKEf7ssax+5br9ZZKWY0jWOwab7Cvp6xl5G45E2mWJxMOilnxcPcO3kM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9PZND/9nWjMlMkblR5dRlEALQOob5wwFuSzdsOBJJoCTq0hu
	GHc9WZZzq0S8QpKkLoQLuwW6NpGvwtg+oVjxCjsR+WUDrlV6Wzbw453A
X-Gm-Gg: ASbGncvEgFra0rjYc3YYtyTSc+gtRqxbNvIyJ5W0TyiH6q9hnalIvqXt79tnfeoPfi6
	oMc2SHUGC9oNFL0YNsvCK4PQTN/eEDnYkND+LaU/YN7GXI9ujKYoRNGYFCZcLRZuNqVp/jKr2CX
	pzobzbdXUxi2OwpRJhBlOcs1NPWWt/y+XCOMX1ukGRagDA8YC1sNcUP+CJKxZUG1LEiLQ1g+nLo
	4WSul673JA4SnscYaJb4R1+NoONlP9sJf2kg/y/bmovjkxERK9g6LkzWSMjMQl5qXPQUKdSDIfv
	9zOIkYiWa7K2uJQD76IkPuF8n2Pn0peeTRA+pQ4YfW6engRSPLstYRGV+tCQBAL6Fmz/fw9yip3
	8Ftk4fvcTsFK49rbEuhHM6SwofR9yyC/H1xIJPE4cFEo3OQGvgNbeleu1nYQm7HV2+a4CordS1l
	DYCVzDXw==
X-Google-Smtp-Source: AGHT+IE96/521TZFyW+4rJmoBB3kl0SaMviXP79e4HfzlRSMb+fmXr9G8IIVQlVxI8d73u5bPmUKyQ==
X-Received: by 2002:a17:903:2408:b0:28e:7fce:667e with SMTP id d9443c01a7336-2902723f51emr92430835ad.17.1759987832087;
        Wed, 08 Oct 2025 22:30:32 -0700 (PDT)
Received: from ti-am64x-sdk.. ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de54c7sm15651395ad.10.2025.10.08.22.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 22:30:31 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
Date: Thu,  9 Oct 2025 11:00:09 +0530
Message-Id: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function lan78xx_write_raw_eeprom failed to properly propagate EEPROM
write timeout errors (-ETIMEDOUT). In the timeout  fallthrough path, it first
attempted to restore the pin configuration for LED outputs and then
returned only the status of that restore operation, discarding the
original timeout error saved in ret.

As a result, callers could mistakenly treat EEPROM write operation as
successful even though the EEPROM write had actually timed out with no
or partial data write.

To fix this, handle errors in restoring the LED pin configuration separately.
If the restore succeeds, return any prior EEPROM write timeout error saved
in ret to the caller.

Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
cc: stable@vger.kernel.org
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note:
 The patch is compiled and tested using EVB-LAN7800LC.
 The patch was suggested by Oleksij Rempel while reviewing a fix to a bug
 found by syzbot earlier.
 The review mail chain where this fix was suggested is given below.
 https://lore.kernel.org/all/aNzojoXK-m1Tn6Lc@pengutronix.de/

 ChangeLog:
 v1->v2:
  Added cc:stable tag as asked during v1 review.
  V1 Link : https://lore.kernel.org/all/20251004040722.82882-1-bhanuseshukumar@gmail.com/

 drivers/net/usb/lan78xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d75502ebbc0d..5ccbe6ae2ebe 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1174,10 +1174,13 @@ static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 	}
 
 write_raw_eeprom_done:
-	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		return lan78xx_write_reg(dev, HW_CFG, saved);
-
-	return 0;
+	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
+		/* If USB fails, there is nothing to do */
+		if (rc < 0)
+			return rc;
+	}
+	return ret;
 }
 
 static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
-- 
2.34.1


