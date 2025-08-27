Return-Path: <linux-kernel+bounces-788073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC0FB37F75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7297A30F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD23081B6;
	Wed, 27 Aug 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MwIml/o0"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179211E1E1C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289026; cv=none; b=I2HwxZjlKKYs/gtQgBpzhw/Marfrq5xqeXxemNpN3ezHzlIr+Vi8z3muystxCLXK40sZzhFbDNPM1j6NxMZhNJEZr90neKYHcV4tk1aZcC3ECllvkZYGOcVn2+lR4gCmdXHdOKg/15ocF9tH8wlZb53Timoy1jTSDUrxYYBYSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289026; c=relaxed/simple;
	bh=QMtgOXQ+sjQ77DrX84hK791xFAExWRshhPehJSUaUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cspy9385ByukT6VQ8pW+z1UvxO90pbns1lZR/r3I5hPKxgCXACGdEKTjsHWMfEhWkoY8asgqG6MAnv2fbNBw5+Mqilgb/FIyTRB4B7DW84qrcxJtXpOhORTWWbO38HZ00wPUngCTWFOl0uGMfIq9w+cmBW9Ti+wl4Mrg7hQUYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MwIml/o0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb732eee6so1135804166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289022; x=1756893822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K320uJht9nzmWbADPUABWWZrhhyqkR0+L5RNZFLlCDU=;
        b=MwIml/o04HFPh4KveC/Qg4ACyxXuwQqolgRDsA3451tZKZR7T/BPbMtD3zPX26dvpc
         x0ezEG3OTjRHRXGHbY78X77Pgl6yG22E2VwYm2In6LxQXlNVzlxeqFeAO2Hx5Wlug98E
         5CyJ5a+bf5s34uBoV5kmN8uiALo2klCO0V7CcFzg67O3nyT3EBsj5bOQSSIZ0xkxs6KL
         +FFFm+ALr/eQ2DLnjT3d68b5aY2PmrN7PXdHudgVphXMCopRnbtDiH+FLysWpTRNLquk
         qnaqLOsMkh+rzeP3dzeMt7GX0KO3gmdH5AAsrpYRqIDc+qWfGsIFS3ImT3sjUYE4VoCw
         pCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289022; x=1756893822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K320uJht9nzmWbADPUABWWZrhhyqkR0+L5RNZFLlCDU=;
        b=mn/HBZp109lAbxzWZ6ZT8rebSz7q+dfmYOlqWILwLXXyEllhPjXefbd1h8oz+0u2gg
         k8lz5Ork1MzGXEUJz5aM7rcYceKgls7FPOqEE2XHapvEUeTPjzzLOo695hsAz5Sd9d1F
         NRGpUTU3lQL/Wx/O73MwB4QFLta702XLRyoVgTHDpNuxJQ7ndXmanrTdkLaB//uc3rsA
         Pb8ABSQruB0MDj7kBh3TBtci6TUWTJLg8ZHbxRJwptBvjiedSHrMpLRCf8tNbnGsYn8m
         JLPl3FWolMWaKZ3HQqBu0MEH51+6YVvs1o0Hze0OjPcu6b7QZGW+S10QwbqMuyVFNUeR
         g85Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPrJw/5d3liIGqNBf3dOercRiVoUPtiod4nPJTXiPOS8gej6xPB4+DrwzEfaCX2K4651GMWxEP61GIFz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NLkrH3vXCKopMp+d9VrrQXGiqHkQ2dgsF8aynxd+JGMX/0kd
	xW1YqH5fm0cgD/ypSIRgAeAZSBPXcPk4q98A8xa5wboStxBV3NDni0DyeKuMlXzZjUE=
X-Gm-Gg: ASbGncti4Aq+QvmTXaDMlJD1WuscHhSzr2JULNiwWIMgGWwW2nRav1v1RgDB+oOAccu
	yHMId9AJsNwn2z8NKrEJtnN1WReSzPez7YSMfLAaXG4qttF2fn/VIMHmt/MPEf3yryvmC4fiZBa
	l8pXovp5tMECrAPjCaJLoLfzXDbTYy82oLrN8bWFaCck+xrGlt2W7QmYkPSj4NmdlT7DuR8pmtR
	i0ufsdx83Kz9SLjopl/v/MJkVpkQlBo+DrcGEKe2B4Vq7LMomzS6gV0PKWmHtBs9wr50azHu66d
	S2C6xmwKinoKWQWS6JvTLqon8gGnvRtaLkrYPlTUZE85xbbTR+Sn9kZDvQhKQx3GnczJBE4cK0c
	fJ9HkCBJWMQF6dB/5qzQGaFlytYIplHYV/U/4mSVrHNW1p++sp3o97ECB/+Zz6DlK3xIacbSUST
	KfzJ12QwsjFQ47rrLF
X-Google-Smtp-Source: AGHT+IE77P70WnESKUoYvoyb5OjIGLRauCOPZ6kuNmeLVYX+S8D2FdWm67SUxl/xy3R/4g1hmRWpGw==
X-Received: by 2002:a17:907:3f0f:b0:af9:706d:1e3e with SMTP id a640c23a62f3a-afe294417b5mr1701566166b.2.1756289022160;
        Wed, 27 Aug 2025 03:03:42 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe97a4b200sm434212966b.72.2025.08.27.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:03:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: linux@armlinux.org.uk,
	chentao@kylinos.cn,
	claudiu.beznea.uj@bp.renesas.com,
	rmk+kernel@armlinux.org.uk,
	jroedel@suse.de,
	lpieralisi@kernel.org,
	robin.murphy@arm.com,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] amba: bus: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:03:37 +0300
Message-ID: <20250827100337.926020-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/amba/bus.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 74e34a07ef72..952c45ca6e48 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -291,15 +291,14 @@ static int amba_probe(struct device *dev)
 		if (ret < 0)
 			break;
 
-		ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+		ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+						PD_FLAG_DETACH_POWER_OFF);
 		if (ret)
 			break;
 
 		ret = amba_get_enable_pclk(pcdev);
-		if (ret) {
-			dev_pm_domain_detach(dev, true);
+		if (ret)
 			break;
-		}
 
 		pm_runtime_get_noresume(dev);
 		pm_runtime_set_active(dev);
@@ -314,7 +313,6 @@ static int amba_probe(struct device *dev)
 		pm_runtime_put_noidle(dev);
 
 		amba_put_disable_pclk(pcdev);
-		dev_pm_domain_detach(dev, true);
 	} while (0);
 
 	return ret;
@@ -336,7 +334,6 @@ static void amba_remove(struct device *dev)
 	pm_runtime_put_noidle(dev);
 
 	amba_put_disable_pclk(pcdev);
-	dev_pm_domain_detach(dev, true);
 }
 
 static void amba_shutdown(struct device *dev)
-- 
2.43.0


