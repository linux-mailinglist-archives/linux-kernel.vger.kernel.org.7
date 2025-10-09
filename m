Return-Path: <linux-kernel+bounces-846376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A2BC7C07
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B549D4F07C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825AB2D0601;
	Thu,  9 Oct 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftfLRdiU"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30925F78F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995889; cv=none; b=SDzD7lPhXLoaCt3VmM6lAtzJXKmbkwQVdjBcMU/M39NMrJCa15m1w/d8h0mw8/nqJLAB/QpMq3b9BHdGiPdybHO1PnjPgcF5kaNlrcjO5pw15OvHyrWN77VOMIZzwxlPT+IkRiYnSXqzDUG1mExx1tfDs2CkBtGzdX8a6i68yyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995889; c=relaxed/simple;
	bh=PFyF/2e1e/+3oQ3K/wXalt52DxrFeCjnhpvxqP9pXw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ahe1V8b1ocYvLyJ9Ef+Avf+Iu1fww4VLL5yqXF53oDZtdV9RAsoA4IKaVM5/V4GdvmcP/dSOw2X3X/YLDe8XUVj0RYoA2+zqihD72+I4g7Hcq9Rk4fyrzbwIqwFkE/oAJlX4Svx5Gz/2cVkLuEja9rde/MVVhjeoQD2jNP9gucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftfLRdiU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso740398e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759995886; x=1760600686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hq4tEYWxUzEgWsz0C9QYX3J9y7beXbVdVC71BzaPfc=;
        b=ftfLRdiUfMhFnZCCHfQ2PiivvNMs5dhrhT8b3YaCVbYFt1qZN/TVaoI0un1i93Dgtd
         vvS5Z1W+a1bc6aiMEXSvIqwlXOHuTT1ZafRpwPbmXyDhdzXBeJESi1crdAlv8mjkUxA/
         9JQxntD2cZYb9YesahqvyjBUcFAeMYm1ZRSk1fihit2ouTlFwqCRvz/d4glw644DWAJo
         tsSvcdXAyuUV4CexI7o8itUNGuhYnGeZPqzm1l3KFfdT3C+nyyStSKt8suqMEH3dKTOd
         26oOBIj6Mhw12gYjoQTfFS47OlFCVze2nvgqb1ex08chxfwMKpAPOHej/yQBUst5+Ylh
         IUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995886; x=1760600686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Hq4tEYWxUzEgWsz0C9QYX3J9y7beXbVdVC71BzaPfc=;
        b=up3I3F8nTYXKRs07hg0JOxCgXPiElKWrykHByEGXr5nx491TQeHt5X2GlRhEEFqbNL
         yjN/81TCDDHGOZ7wBXcSd68GPxTOcQBxKInEuhlcQCjWFlkvwdoS9UWd7szT0LjFvPMv
         hlKKwlKzCpGIjtjXiOtEqW/vpA3IMACWYECRqgb0GXnfBWl38EC8THoTC4MgiM9BqOEm
         VNIdPFUfCGHvBgxX3cQE8cVIkMXSlQezSOMgB1jDlo+mGnU2UOuVavIVsw4eM0sOs2es
         5poFWmKleBpI46P67Vifa7h1xyX99OGchoiGBZNOYKjpsIVg/FedTCfNdZQqMFqwpYv4
         ghRw==
X-Forwarded-Encrypted: i=1; AJvYcCUbum/NBU57Rurl0Y2AEc6GTqFR69OokTPDwKvVUwSMaGR/E09oYcJZoVw2NjZwyCSBL4W6acf2dJoQ2Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fKS/wdC0HQdb5Jf56P+QRbGUjlnhbPzILWUPnciqm/L6zqk0
	tNTjwrizcC6P4pjfmGP+x947ReODDeAVUexIueGpNUSU/eCT++Oja70DPs19pA==
X-Gm-Gg: ASbGncuy0LVd7VP+Osgk0H+pdFOA2doyu+oQuEymu8p9GxiBrpIZUdY0OGeRnEwfRzd
	A9wkmDsvOLCz4IH773WNmEbIeIoyPJHpyLig/9uFl1fxchdH74SLeIkj9hBIA2xXTqAp8qgZLcE
	N5V1mK9DQ2GwhbhQxgHuXoaC+Q2y1RYrF+zye4+P66hJrdhK4bd51AbgWZtCH5dVx3ZdpEO/fwZ
	4VSGod3RycWgTxYGewADrVr7BQre/N1pgWdJ9I3+R0dZsY5UTvsGY8d3O+xXgcNv/N2caRrSt0e
	DoEhsMuGsx3WCgTz4bUTVSHLPzdIJi3W4ymMAhksbh2CL9CWH8F4dNtU9kNKg3KscrXBYSX/PM9
	TU0CBTHfKj2XY4Vcp7ypHF1807rlAp1PkQ2JHbeCZIhsx/hbpOrPhmhrbKw6++EPa
X-Google-Smtp-Source: AGHT+IEOgmWk7Fz4wvqBz+J+hHoNo/nYr91P4S3VAxGN2zP6aFWkQWDO2taB+0ag/Oi+tsqvBTldoQ==
X-Received: by 2002:a05:6512:3ca8:b0:57d:92ec:67de with SMTP id 2adb3069b0e04-5906daeb7b6mr1973935e87.57.1759995885949;
        Thu, 09 Oct 2025 00:44:45 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac00b40sm809797e87.6.2025.10.09.00.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:44:45 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: a.shimko.dev@gmail.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware-platdrv: handle reset control deassert error
Date: Thu,  9 Oct 2025 10:44:43 +0300
Message-ID: <20251009074443.2010699-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the error returned by reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello maintainers and reviewers,

This patch adds proper error handling for reset_control_deassert() in the 
DesignWare I2C platform driver probe function.

Currently, if reset deassertion fails, the driver continues probing which
could lead to operating a device that is still held in reset. This patch
ensures we properly check the return value and fail the probe with a
meaningful error message if reset deassertion fails.

The change is safe because:
1. reset_control_deassert() handles NULL pointers (for optional resets) 
   by returning 0 (success)
2. For non-NULL reset controls, we now properly validate the operation
3. dev_err_probe() provides appropriate error context for diagnostics

Thank you for your consideration.

Best regards,
Artem Shimko

 drivers/i2c/busses/i2c-designware-platdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index a35e4c64a1d4..4c57c79d4ce5 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -240,7 +240,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->rst))
 		return PTR_ERR(dev->rst);
 
-	reset_control_deassert(dev->rst);
+	ret = reset_control_deassert(dev->rst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert reset\n");
 
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-- 
2.43.0


