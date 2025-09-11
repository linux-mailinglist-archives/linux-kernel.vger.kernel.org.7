Return-Path: <linux-kernel+bounces-811260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96264B5269D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5281D583473
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761E21B1AA;
	Thu, 11 Sep 2025 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSwqbJEs"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220ED212572
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558469; cv=none; b=OYoM0gnS/SiTVGrCqdzi0aGSDJB8GLNm2o7m4cFykjbsoxZKobiQ8ki7v/baYu+2evJNUG5Pi67SKH4KB9F8asU7MJ7cwDARxZMBNCue83myOu/9T9LCI6tIXKDyzWy79uApvFCxafE568+0DiCJPlhdQzoZZASZaz/gvW3dTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558469; c=relaxed/simple;
	bh=VsYWhLysJJnmTbPsbRPKH4Te9fqitjPi8iJYc9rGN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKyiB6tz86anIKCtTAklMC6u217hmG25FFP021hulRI55Fa2MJ9eiojeyzlwH5HsKO8ufun8HPM7F/9eoKdoPLPvbPK5Tz9PxM+0BsRP5QfK99XbdU94FRA+fBSN1LkTlBtNaY3T5KIGgqlqMwXVdTdSFJmLP56mMZBiQkdEQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSwqbJEs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772481b2329so285917b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558467; x=1758163267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RotDBc4nduTqvm+cZpyUmQgQq6+4XUNjDl6/pxCSap0=;
        b=PSwqbJEs8IsyVx25IvEs2eQ5yGdI84ayDb6vA8xsHkmFYCC3vr3ce98EQPAj+HlOtx
         zCVyQ9/xTjpIqIAc6R/GTjXmiFctXRLd0OOmu174wvrkFSr1IS5iXJ6nbAA6FPJY/lBD
         owVnRRM9OwCwD90zFKCSkXqdHKVZIOe0LF5r8VR9g+eHK/4dtTzCrMDUvdVRPHF8Snli
         fdWn/dDOLXgLuBGzQDs6NIjD49xXhEDwaVLU/WkBcBrWXbfZY8QhjVO+xT28g2AUCEUw
         WS+iHE9+r5z274UAIMDC1PrXW2aMRlyrELcnt5sqEn5zoCcEVHsWRnoX7fRTHhGXZgpi
         9bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558467; x=1758163267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RotDBc4nduTqvm+cZpyUmQgQq6+4XUNjDl6/pxCSap0=;
        b=kXDuqN7UZf2PUNdRYclp7x7e9kQdlJqW9BOJlYLfGSs9QR7KamlP51o595/RyfcATI
         7KcKy//LQEX53ek6+arQ+/riqKWb5FPgW4B0fSLsvEZ+mNSQ6tlQQZ6BWNvtX+A48p1W
         b3pLpe0dXCjEekV2TtB7QgiNq8jc0yS3UnaKv2pneDswbhR23/lhliQRKuHffIuIxL03
         KXLP5mS/GtoemBqSIVwbYgzmjNwqGcIsDKdkasrWhgpGpZ9iKCfOGH0b1qTZgTdKDmC3
         987eAn4KStI5ZPP1weEJpNnfdcyR95jakFg6XRRczoA7U3peH++4F8+8oEzU1urVdd96
         ByUg==
X-Forwarded-Encrypted: i=1; AJvYcCUjFp232WiDATsYyokyKQ7v3oJfeptV1jySElRMk0LdIFboAhDYpTm9y3BG4Fxu/JcWF3wFMr4VfQ6iGZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5FSbYHz77/MwPubL2RhQVypebusbV9r85kQYVcdMQupre+ut
	DdTqxFWPuv8z1MmmmcvNhqkQTRliFyyvy1nikmXtqQwNt4+L8z52sU/z
X-Gm-Gg: ASbGncsG9vdXnaYjmdPMFzPnL8lcxljRtFhH6DXwVJeKqO/iI2OKe3OAHgqBjBHyz7Z
	xwKhwnZ+aLfK3cdRUeZe6qxF2XZfKhSPr9HRcTs7esO4fF+L3DJPRLzKFgrHCJTadhwr59YqgfZ
	6FhY/g4Y4McBgsayLc1Gd7cBOmRf7Iz/7josUn1C/3rrW9FkCYfVTG/OTRKBDf8nhF4N++UMl1h
	gzlTB9aisRSm60iFNoFXAyBiCRIyyN8Boyyde+RLJcgrVEwxq3hvJGgq3mTEcgpWm+EZVJtVN/W
	WHIfBPSd2a4oVRbGhHYSidmqdg+9upGnyFl5h2Oo7UFcXd5j7v1F7C7vIXA9IuUlnbp3a2fAsYO
	JYnEtJ6bV/Jt4sIV4KxKCFhn6jVyJemX9prvphhEjYPdmXM10RN+OfmVaT8Q/NF0SfDlu8TcWsX
	KHqzREXhu4NnuXHxHVOVNhOtFGOs3z
X-Google-Smtp-Source: AGHT+IF6DEdmkzIwhlwOvXdHfSRwOtFEwFUfp7ZMeoL357UAoG42oyov+M9vvQIIxvaPMU5TR0IIAA==
X-Received: by 2002:a05:6a00:17a7:b0:772:398a:7655 with SMTP id d2e1a72fcca58-7742df033a2mr22466192b3a.23.1757558467212;
        Wed, 10 Sep 2025 19:41:07 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b17e23sm292579b3a.55.2025.09.10.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:41:06 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	SeanHY.Chen@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
Date: Thu, 11 Sep 2025 10:41:01 +0800
Message-ID: <6ac048c1a709e473f885c513b970fe355848484d.1757557996.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
vendor defines its own sdhci_set_clock().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
v3:
 * kepp "host->clock = ios->clock;" to part1.

v2:
 * remove the "if (host->ops->set_clock)" statement
 * add "host->clock = ios->clock;"

v1:
 * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail.com/
---
 drivers/mmc/host/sdhci-uhs2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 18fb6ee5b96a..c459a08d01da 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -295,7 +295,7 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
 
-	sdhci_set_clock(host, ios->clock);
+	host->ops->set_clock(host, ios->clock);
 	host->clock = ios->clock;
 }
 
-- 
2.51.0


