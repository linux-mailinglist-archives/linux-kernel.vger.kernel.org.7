Return-Path: <linux-kernel+bounces-788099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721BB37FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2888D1B60B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1E434AB04;
	Wed, 27 Aug 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NpFgNjXE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049230FC1E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289780; cv=none; b=Jpu0NJulUvm6akXdAjMw2d/zzy05Sm3qITG6S/WBXCcM0XKeVT6tx5eOOG6FclJSJFhaF3NSqz2aMOtAgqgGl6hHDcGCHtw9vKixL55zyheS1i8EYADqEAfzef1MyaNSREK0QojJiOkBy+9R+lxkvIthecGYHFHi1g0PH83aJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289780; c=relaxed/simple;
	bh=rpyw9b+34OBAP5yd/g0+qQSLnf1nAfix4iyWf9uhBq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQwnXVquZHITqL5BXHTN7oAjaVYXbCuRK1dWbNE99t0+5Rp7IFwWrXxaLtMofQW7rs04uEN0b64N7YrJXyZBzWuv2dqIY6CDpYuH3ROWwjlEWmsBKAc4zFQy63pEDF2JEWZB8eaW8Vq3U32adbo47RsYtA7wG5lFhk91CvuACCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NpFgNjXE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so60558f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289777; x=1756894577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0pXmP8YLVTTuZVB19qTDKpWwsJ6nLU7EBvOCqYMS5Y=;
        b=NpFgNjXEZSDEP1oxYMptqmp/UWVuqWKgxKtZ5/TVnQMvruhh5Jx4qhCElHnImeBCiT
         7rPV+/yD1j5C4bJUtityC8SC2hWOJVSE6yG/iIv5Su5eC9eT/uxuJJaNpQcYrl4R70OB
         KXd7ibiL2ipCguyazBbMCDjHNPoUFCSohNDczHE59O54Vm7RYpwFRkAT5xtpV1+W9XBK
         7DWkE6c3y/wrSoURfA9j8IU6emnC+sN3iRT8SEnZ5PZZcxfphRfZ1E9pGNehkVtA+Sy9
         eMUuO3RmLn24MI5U5VfKTTZ7nUHqxI0uhy8d954SwwPTQKN0GBgE6zNGdSeNHJt+t42N
         JuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289777; x=1756894577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0pXmP8YLVTTuZVB19qTDKpWwsJ6nLU7EBvOCqYMS5Y=;
        b=wD3VfVbCCfj5D89mVpiKvm7jrVrSbR51yrXMxeNcVQnlS4N+XrttPlngbkJJt//SYF
         qlVcwcpFmmz30jhzunTvJ74MdsHoUMg/k4BvZjpXLkQzicGyzQH19jPnxU6w+2tOJkFM
         jGg7RQFenA7dB2jMnhF4qNbVEDY1Oxj7byqUOW95dX5RiouczRQ1BPRq63pG6igdvnZd
         RKHVnhF2CKoyKO/jzJ1ElW0srsuzAbQSUWYsmtfAWaslsOIRnsd8l7kxbhn4TA0f+0/N
         +RUEf+X3SPv9E4oXisnixgiuW1U8IbUkKuFBZ8NRpiMT8WFmW+4wMFUBVvnlUwrdIyfL
         78Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdERhPzcIZGIvEzkULxZm5cWs34pfOrQQrro6y8ZsnSBONlmIZsQvN3TkSPeQEa9ohVJ9Hs6+AsuBGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63vN0vWJTj7HD0fMgdlmghEfB2guMcdraiTpgD4SWVlL3mRAN
	NDEtmMyht6hSBt791UbEhHKZvLHGwBKOLWTODCTLKZWVMK74Mhc1veLlusivWgbhK5E=
X-Gm-Gg: ASbGnctSOOJAoNe4yt/j7OVZM/QMDKxgAyUCPjkH1da0EV5AC0tD9yPmKOA01FcGXzA
	Bt/yGG32Y/odBrbpgnTvOQBvpbngDyvUuIzmjoCYIJkuTDtBLBa5bVNlISCGuM6ZbibX/XZegJz
	CIpN1KMx3KtMhFpvMleU0N0060bb6uv8voFbvq5AqTb4EGPUfN9QibFt6gfVC1Pd4VlkDsTHaoi
	oEc+PfBAyqqA6PqT7zXwE0AWOpJY3ScEljsTOU9Oh7sqW+1+VjDXBGvPaH4HYqnXJRSt0ajOcGt
	SjB28oXNQ3wC+nghlXRK5ZheExCIq9FyvQv8eYxNg4U47/ZgeVq52luYkqhuyFkPAoph8HGeIrd
	Jso83fNfNOV6n1pNpc8JovOgDgwLSTdjYBKZrgi6pUVA534DVTpOl4zYXyd/DRgpV0bk5Py7Qgh
	P3vZzFxw==
X-Google-Smtp-Source: AGHT+IGRiuzfeTyfR1IcpE8UX0OV0iAdfKjM8ryKEaQV5VkJf38zB7WTj3zM74hTpVp7/4Fjf0guDA==
X-Received: by 2002:a5d:584d:0:b0:3ca:734a:a337 with SMTP id ffacd0b85a97d-3ca734aa8famr6040248f8f.32.1756289776881;
        Wed, 27 Aug 2025 03:16:16 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70b634943sm19801199f8f.0.2025.08.27.03.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:16:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: broonie@kernel.org,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] spi: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:16:12 +0300
Message-ID: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/spi/spi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a388f372b27a..f95c4304df8e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -427,15 +427,13 @@ static int spi_probe(struct device *dev)
 	if (spi->irq < 0)
 		spi->irq = 0;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
-	if (sdrv->probe) {
+	if (sdrv->probe)
 		ret = sdrv->probe(spi);
-		if (ret)
-			dev_pm_domain_detach(dev, true);
-	}
 
 	return ret;
 }
@@ -446,8 +444,6 @@ static void spi_remove(struct device *dev)
 
 	if (sdrv->remove)
 		sdrv->remove(to_spi_device(dev));
-
-	dev_pm_domain_detach(dev, true);
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.43.0


