Return-Path: <linux-kernel+bounces-888736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CCC3BC46
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 435CA3511D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29626342175;
	Thu,  6 Nov 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BiXVPn4U"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E04341641
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439575; cv=none; b=frDL6wfoCzbU40jmTRsrwA5TLMvSjiQK2sQ7Jy7wPp4tHKM3iJRsgcvE7mQTZxU+nGLMM/iHQpylAm25GQvxy23ttsh19QfMmSrHW/zretYzDIwxLI4rhWEcDRH4bKu9bG//9vcTJGhbeU95Ph1N41GxG22WtVLM14NFs5wN2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439575; c=relaxed/simple;
	bh=prOzLUskI3PtjEuq+S+mvPZ3SDfrHdF8TE64VQAItOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnF2TMIKpBjYNBS4ljmlzekobDODw3kdmPbE2ok/bxvFU5rTxT1vJ64/aGMEMT8i1Wf+R/N0dLg426AiVkViDnE+lkdLfKTcorrGt/9lpwhWOMDC5wXUKZp0eUMiylJsyewELZJlTk+1DDqAqtrnDdIPkxSUlj38OHfSE5nJgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BiXVPn4U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47721743fd0so5104245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439572; x=1763044372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXbANkDDGqW1qZVHqJN18AuedowNrhBaz5PtTHNJFho=;
        b=BiXVPn4UKJHRHydRe+QS/nea5VipPlgKuyK4wS0cujydq+Fx9v3gIUTbtp9aAYIH19
         7TrC+YTwBvEa7/1YfZs6V8lAXkrqy9qi7arrWzxdzV7DcRFDV6EIpCveduKKufBTWtIl
         x1U83YrdD6u6hQuxpuydeWztRh470kIRZmlBLR75ykBsuDsXeqxBXdyxnJ0SDNlxZaZm
         zWDhbHX0J5QRlcMAT2g99a2UsMxRfKEtc+kjhD7w2aPwlZfMqqzJEUpckHReTWgeCJXm
         tlwNXM+W5LdG6Ce5Es1FvvybGJUkvWCIZu9R6w7TD/e7QU6sDfPO+JW4HKiLUuKnXfeq
         /GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439572; x=1763044372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXbANkDDGqW1qZVHqJN18AuedowNrhBaz5PtTHNJFho=;
        b=Kgt+DN+pZUrpKxfZ3vxbTfpV7CRQp39u1TIYJEN6IXkVexf2JCgn7guzO4fSSoKCUg
         j43pan8jImMyr/APc/rbZ5aT08Z+klMhEehGIiKK02KhZLRHA78FiS2+zsZRvnjoXfjs
         AYk8uvOplxWwp8HIWf9VxGXhN9kOxE3U0YngxfdVtvla895HVoO7LmaK+W3insQVDflP
         DdkwEl0+4NiBxT3QjkYsnMbS9jyGFCH+jl74saIB5i1SzBFPuRc3OX/C6uc7OVlCRlkt
         KgNsGTA2H+9aYHBaK1Lyl7DFFTUbSCRIlzwWaWyxSfASN7ore3QLmzpA+L1fzyimidwv
         pwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjgvOp7DLNP1WMo88jFGQAz/P3/OthT2mPEF1sqrsfO9RtnMKBUBor/3k3zkNc9Mwd1v8Vtu71sAMhZBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyPFvsu8t/nqUD4BJz91Thxl1BCy0Nwi0XKfkScPWYeOdSvXD
	jFaP+nw54SEcdTZliOFaY0A9hFg1xOtWerQuZqX2r/pE+iQQ/lC531JQeaVrTnxSaUY=
X-Gm-Gg: ASbGncvrohonfgK6qiZB/6b60LQooCd/s524JHEg/jP3ESEI62m16LndurO3lMdw8dg
	JciFFsGw4M8zb1Yc4C2c993h0OvKQVH6JjEwyU9/dtQspYg/K/a/ECzMeDqD74J5YB+BBtGWxKp
	56zk8XzOo4x5yevn48rsw6Rsl73ssfPrwfDuzy8gP2zEEdCq0LT6pWhLreahENo/XxYz86/nVHD
	d1ZK5ouHWn4yVWvzxcW7CLAinZfnA+jL5jZy8usYcDItwBAHHygUd8+/SdjS5n5tR48lkQr6XtB
	omfRjmBClSZtajPXZEc1Tc1pOxoHMkU9RYJYdvAMVNl3RQNPELgfPv5hhn+qbbftZJsjE4rCfq7
	Bu9+1MjBfyKr98ItJwOcKmG9/JEe8N8H3ETar2LXDJlUFgSHzCBcMh6kSjweDRPC6xiQX
X-Google-Smtp-Source: AGHT+IEKvp+BIJ0daCleG1INxfZXzLgRjtg5y5XO69kXN1oQCc4zvQugkLEg7GhIyNZUXJw76aoYNg==
X-Received: by 2002:a05:600c:1e1d:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4775cdf54e7mr65676825e9.22.1762439571877;
        Thu, 06 Nov 2025 06:32:51 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:34 +0100
Subject: [PATCH v6 5/8] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-5-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8oIX3m45+ImirvUyTg/cHTcxG9CmXJIQMyBw8kaRMMM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGHVAwT2gAgl00/ARCEZyN+s0BLhNENeoGBU
 4FGVo1RBjWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxhwAKCRARpy6gFHHX
 cs95EADibjmdv0jqZaqgoZLQzjAQV4g2A3CwkEUI7/RNyfm5llcRpu8xHNGK3JXHEEdThJK/lzt
 64S9CqcGUXLLmcBeMdI4m3J69tQOwlq+N18gnrrOXviwRWjgTiLx4eE2WWDGRF5fbTbktOFHPzC
 axOoLv8DPlBuuZNj7PQyv+tnb7Go5ICqiicCBEzDF/tntogipQcZSWfDUjFruHAiFCjRCUUIoMz
 UmoijGwLoTJoI+AnQqBbqFmSbj9q5Jb431ugXl+YMr0976dibEOsr2S02SUGUvVyyapIFUEumW6
 ejs88pyzVsogHT5ghoSuG4KtC8rmW0UCrmUySw2M2qdbUbAzggCTcY/ZsbdiWJAomTnEGj4PjsY
 X6M76GFpuWILWJy1j/b7191JNzwCbkAzU+HCGHu/5k33KNEtSL9zFBjmdUktggDuZOBgwpoPxN9
 EsDzwKayyOJPQhnVR5o5U9wVL6Kd/l9Eccfus34k3UAZfFiXYLhFtQdVP9ODqNyEuiZjXsciZ7m
 ofY5jkxcwmPVuTm4mzDxCvY3Z0ZdPD7KOugOATTx/GpOCX6BuU18s+D6THXd/XxPU70lQKeg84p
 Zc3X/vvDokgHt+D5BNONofXtW/dmj04xpQvpmT1EqSG+RhA3gnJNWK/5dcojwoskXPjMDUrCgtp
 x5w+AGJr4RFeVqg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance order the includes
alphabetically.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 8029e547e3db90ddb85c717dfd735bc8a314dd44..b3d3339dd6d30495b498b3f650d18fdd96a6bca7 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,19 +4,20 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>

-- 
2.51.0


