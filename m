Return-Path: <linux-kernel+bounces-846463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDFBC8118
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61943B1B60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2629992B;
	Thu,  9 Oct 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5wDJZTS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096B288C2B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999057; cv=none; b=gJzgb+Bcf7uySgsCftYKy7T9DkB75IIcKjY+x1UESt5e0xHXl1x59PaNWVvgTNmsMt8yHUg+IHHvj1bHwokZjU+0GFkuHK58wbuTP/ACDlZ/1Oe71FTXwvCyBmC8slfRykDEqKI8zFpHYiPmm6Y5RF5yvREp2nB3EN97zWRUFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999057; c=relaxed/simple;
	bh=64cS0iEb6fG/98KLH6NyIi1RARZBBpfO7zVcMsRtMJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGGIgDWOrfONKK57A1XkSdTPxEL5mY7PBWkZEDjDHrwdNevpVA27ye2KVyuFj13OvtpMjg5ar81AUOCTJcD+75XA7ScWhuD4eNFB5aQ9wNb0FRtAHDff4s4g8oWX8fqtbO6Qmf2oLPYv64VgU+J0aoSSvyxzZ5D3OZKZYP0WfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5wDJZTS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a6a39752bso6208251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999053; x=1760603853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4dMFnnL6gCSV/BGkdGLVDVI82ewLVkorW1rAtn7Qrg=;
        b=E5wDJZTSf7kNq8k2FBbJc0CUMUY+3re+o1wad5lcHV/+k5ht0uj4UHRbEyJ3SSIOQR
         S5j5HUu0LFQUvBxSaOdWMrfHQ5bO5uBy5MV2SlB1c/zT92kjKHlPBHVzAu4Wb8VPsF6h
         7TqMI/b3J6Rq3zKkRcW+1A03xGMjwbTnMS4vwbCB4yBqYOjYymnWSx7JmFCBjpGQwnC/
         iIqJHWJcnW8XD+HEPsEUayO98NAxEjCau4ym4K8Tciaish6D6TCOynr9t7aLQ6QSl2Aq
         8xL6k3NMk0ZwIXkXJsYnO64sokfsDzBUdcVE7q5V8KDAnmDPNI8Kr69Se72S2nmSR+tO
         QIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999053; x=1760603853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4dMFnnL6gCSV/BGkdGLVDVI82ewLVkorW1rAtn7Qrg=;
        b=I0wryar2xauVoHC36N2YuEdEZ6QUP/zUdOxfkRYzFidoPAbglipY84MMgy8rjey8Sw
         QqI2WcgGkfp6MOPZniZ9TK5iirFrEC19Zk6QB/PRLxfjgy2TgtCvMLI5S0bon2dCGisz
         9rYmL1icEi87+WyIpMIsKe4l5WIoSsptnivYZqaGmR4ZT7GthNQ5jQ4qWT9fwLzq2jAp
         BU3dSbqSK/AELhsVTNEBzPVXup3v5H+J0/gQUjYhTJkIKajshxlUQy+qB95WkoxdNDDl
         f6Vi0Tup51+mbmLsWsFlXoG6Jpw29ymBPKp1owb+LFMWuTaG0RG4rn3Ct+hdya2YEhHL
         ORwg==
X-Forwarded-Encrypted: i=1; AJvYcCVrRY4XZK9zDpU5rmdfMegT1rvWysG/jNg943wGtjhPyObVU1Gt2l6AZ+8/ZDgAQ0IEomz9guf8kzDcHIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OOmKsZXoDQKtUkT0q0A5HEM0p+syXp9xCS9Tji1ii7PbX9G3
	mo73xvRDnUftT+i2WyF+n34x2qPKTX6vn84Y3NUjzhD4BHekjFweofRtlzhgbw==
X-Gm-Gg: ASbGncsGSt1N5opCuGvVdaut+pdFwaEtZ3/gePzZYMY5YKy4+FPxrX6VCU0ibcnQwEY
	uQXZwhzPQSfv4gi8CpvjpcOSum0snXvto4JYhfaouqXgfp5U7p834cLSB86ziUV1WkyFaPQzl8O
	VKxD86Dv9rMiXQbKKVJm5408jGEAz7UDRzvm5yXHx5/XhSjvBNWnrdR8ZPSVNmQNyq1sP78RdmL
	5VmQsvI5iGlz9iGDRJW00UCh1CqWKMGFn+pe1ZJrvdbkgV0WApAqnmN6lpkpH3WWs7fGsjLG25h
	AmePBTIm3HNLQ16ioUP/XXWSMNLorPO9j7fIktTyyLQQU2CjVzTdeX+xg7IWAH+0R3+JOU5EIFj
	FLr79IJCKMVY3UuH+Kq1ldF0oLb7/UdsCOE11VvAe8dvHuZ9FQi21RWUiX1JT/VfU
X-Google-Smtp-Source: AGHT+IF+KdeAZswgYlb7SDSnp1ZQxCQL2XQMEHKQQ7rRfzS4AETD16SRvGkKtRNvth3UTFIlZ4EmBw==
X-Received: by 2002:a05:651c:b2a:b0:373:a465:294d with SMTP id 38308e7fff4ca-37609cc36d4mr17547791fa.8.1759999053179;
        Thu, 09 Oct 2025 01:37:33 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b81eb5sm26482701fa.50.2025.10.09.01.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:37:32 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: p.zabel@pengutronix.de
Cc: a.shimko.dev@gmail.com,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jarkko.nikula@linux.intel.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: [PATCH] i2c: designware-platdrv: handle reset control deassert error
Date: Thu,  9 Oct 2025 11:37:03 +0300
Message-ID: <20251009083703.2038187-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <206e36398db6075bfb0bb0b98295ee7328c5f64f.camel@pengutronix.de>
References: <206e36398db6075bfb0bb0b98295ee7328c5f64f.camel@pengutronix.de>
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
Hi Philipp,

Oh, sorry, sure.

Could you please have a look at the v2.

Thank you

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009074443.2010699-1-a.shimko.dev@gmail.com/
  v2:
    * change pdev->dev to local device dev

 drivers/i2c/busses/i2c-designware-platdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index a35e4c64a1d4..c89af7cbdfac 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -240,7 +240,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->rst))
 		return PTR_ERR(dev->rst);
 
-	reset_control_deassert(dev->rst);
+	ret = reset_control_deassert(dev->rst);
+	if (ret)
+		return dev_err_probe(device, ret, "Failed to deassert reset\n");
 
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-- 
2.43.0


