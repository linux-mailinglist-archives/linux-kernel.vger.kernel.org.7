Return-Path: <linux-kernel+bounces-841937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5CBB894B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99FCD4E623C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C521E0BB;
	Sat,  4 Oct 2025 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6HSXS53"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A3169AE6
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759550857; cv=none; b=LWZoEhGJfk1AzGz6D7DD87WeAJoBhiUN1KrP9gGibDhCPpT/17D4V9gDGTB/rDGVA2ha5sW4Jl32p7m/xAMkGsQM/kTtxOqgF4hgqjw9PpoaiLFv4f7/rHqixmFfisLVXRw+osvSdhjk3rjsO2APStvfZL7MGiWROrWNv02Yxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759550857; c=relaxed/simple;
	bh=HYJNFwgeKdoDfqPB7ktfqmxusFy0EZVeLUF1A0YhbNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixfu54bu4xDpZHywjTFiP+/h2zo6zZfrphOQL9UObw19XzEG6gUTs0nQL3E+RDhvq6mhUagvvBxkU1X+gURKweRjAnrxfwX7jSr/3WllND0VlmHz0745ODRM2h2KQImfjUgUQoHBLnCsuWzIX9sW5gXlVYBx9aPTAf0rLL4Cric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6HSXS53; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2004813a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759550855; x=1760155655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ab/aeZgm1Ct/wesU1VWgrWdl3a/KDYSwn/hRS2/Blo=;
        b=H6HSXS53IoPzW8+shNBj13uSKueIpDhB1Kq34u9oTnTGAUb68dKT/dxzfinH7atwKo
         YaKchYTCAUPHJR+I3/ZWj7taPiDW/dz6AIyGEV/nFBzXUXvmiqdTaMh4jCgoFiB+SMUg
         oNfLY+9mPiYlOcVgsVnrRZJ9hQTFALFZQvrurc9Y2y/QpZQylxFwDilRN1B6UMt+54Bh
         r8MSTJro0+9Vp1ME3GrZmYM2vDu+bxOH99/A8VuB8HfbkVH5O/3HTBfRz/1VgmaVtdRT
         uR/c+JmXdbP6KgfvGjB72wmCrRId+u5vvPmBZDiufaw41zHgTQJkG+m4uSWz8sd20Vgx
         Y1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759550855; x=1760155655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ab/aeZgm1Ct/wesU1VWgrWdl3a/KDYSwn/hRS2/Blo=;
        b=fgxAOK3JjYZs3GDaictCHK3npMeZsuRXZ6+Fo86PJFE2KEEhDbVdrmqno/lnuyXVfD
         BwDZp5SZPZ3fd/UAUi+Jaq7gsbB1mvnK4seSLJYZhl80Eww8ybh66jbAIA8hjbq+efV3
         RpWbmtC42hc6iUvvv6PEYXRUkiG9ldrfGi5uvUwEhnJTTPsuHgmdInVMCJ/F0qjBdmS+
         D6xBY2aqmiaUxDuyjMAljbnbx6g3ssnIIw+59NMwzwIZ7l+pTRP9UWWT3WGaU/GwR7wP
         M6VC3Bgh1i8rBqxdSexrMKBfAGNYggqFsOqIUhWvN9r3f0OprA+d5435fW8Ud+Wu3HZm
         ul3w==
X-Forwarded-Encrypted: i=1; AJvYcCXpYegytwesjUkhIuCkCk78vv2cmrbuXDRhJHw8fPCQxnjGr3+C8YEgUjeoUWOQ4j6hYy3VUoYOrvxPs3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZpPvokMzVBJ1RzEVgAoIpeB+Jdvbt4oWIraZN2FEw7PnYDXl
	ydjouxbxlsU6VZzTHuKVWUbLqcQPemkx4uh1q2S7YGuajnth2nRKNLVS
X-Gm-Gg: ASbGncuSsKxK+8Wf0aVyUwa1SqueYyaOohNeI9i5qBOWQimbAPeKhjguPUk28XW1RAw
	h7XcafSfhyLY1TWjUc4XnSTvrKSmFEZ/2Wl0qYdF9zCCSCgRRJ/BqkQnn0UVrjjb+0GL2b2GEoN
	ar38zcFbP9vS+aQDyX3rN74k+Xal6nkwPVoxChpQ3iA5S6VeDf3IeOkckaqX+kH8M8iLSEUyOHr
	cQH4oyZiWhrr8jCHsEkFBf+2uKpK5AMjCVmm+U4rCSyy8OCeojMDduOGdZu8VoiSBeif/qp/zKU
	6rD/hNa0K+MxZEiEu8E9SONnSYqLbE8WwjsUXANpwJjW+d77LuwcLQpMx+2zjTseJuJFg4y043b
	kvqgbx7kx4FO0uToMR4YUqGsbFKFrQ/I5EJPYFhe4PbUnOTJetH6YQ2DECzmH1yhcHey5gy8dFm
	c=
X-Google-Smtp-Source: AGHT+IGTlstly6wpNIIUzXdJcqg26KC4+gE2hmAVdLheWI6xhK/cVtI6EOnrc7NPCTVjju8lAhEuEg==
X-Received: by 2002:a17:903:acd:b0:27b:defc:802d with SMTP id d9443c01a7336-28e9a5f7158mr78158925ad.28.1759550854915;
        Fri, 03 Oct 2025 21:07:34 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.90.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a4f15857sm5876142a91.1.2025.10.03.21.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 21:07:34 -0700 (PDT)
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
Cc: khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
Date: Sat,  4 Oct 2025 09:37:22 +0530
Message-Id: <20251004040722.82882-1-bhanuseshukumar@gmail.com>
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
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note:
 The patch is compiled and tested.
 The patch was suggested by Oleksij Rempel while reviewing a fix to a bug
 found by syzbot earlier.
 The review mail chain where this fix was suggested is given below.
 https://lore.kernel.org/all/aNzojoXK-m1Tn6Lc@pengutronix.de/

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


