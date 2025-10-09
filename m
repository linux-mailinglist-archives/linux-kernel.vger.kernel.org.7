Return-Path: <linux-kernel+bounces-847347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2993BCA95D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CD624F4DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25AE254864;
	Thu,  9 Oct 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+5Plnch"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA920248F75
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035071; cv=none; b=EOE+3XSLfHkeLVuN+IVBZzvl4KzOW+nOOYUEfZpIRolrVeooFzMcm9d5v35erl8Vxu1Yt+WdYgcgonFowLfrz3m6bKBzXYK4DpFXjsvkhdV3fi+lN/Nz4XXTwS9Z2428TVdRj7qYbW6fvEh7A/67p3PfDTOmJav8SJHULTW9eB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035071; c=relaxed/simple;
	bh=PDh+AfzjhV3uXacrn4srFE3snwuuql5OJ6C9U1sJEIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0jHcykcuRVKrNGu6AOsKDxh9yRfevl3fmo+mfgy5asly1hQvf4R+0GSCVrn5nl7qFAj2+CQ/kp83RsfFXClyrzU4za5JVIqf/mwNtTJRBLdju7ksyztFa3kyHrroZSm3t6V8SWbvFCG2zmq19lnBPooVPm7Xwh0bEgU5dCXlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+5Plnch; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so1176381b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035068; x=1760639868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLBmvaasF2LSEi3ZR2o1HrWy9QPsvaaeIfrmaMHo1Zw=;
        b=P+5Plnch7cVC+pPy69mOpbxpSzHv8M5Rs6v2W6y4vraAELZ7GgTy6e4KSz5vxIKC/5
         xAy5mPJHupbFRXaSpatn2erlcs5sd+xZz/66dDKyMJaFFPvuyBui4qFjlBQwWvGBIpfj
         HHh9EZTKOXJK9jpSaGymNh2aKt2dzRZKLHVGrcNr/K2u6vDBZ+EdBmuZ/tZ3Na1XMAd6
         WCOLgmw5hRedVVg24iVa28YD8nfeuAc8K30VjhOFKSlyH+eu7AsvSgnJCjDuxlLPwHeN
         pkWa0tBhRrUMtziCHloR/qtrv2eo+GQVXLZUMw3TaTg7RXrV+c46M9zx1hyi+w7BKsI+
         UTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035068; x=1760639868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLBmvaasF2LSEi3ZR2o1HrWy9QPsvaaeIfrmaMHo1Zw=;
        b=LehWFSEKSmv4xt0NEYFxxCdNhv1TnKZ/WZpIJPpVXZEEQsvHLUy6Pl3G5fR9y9mAtw
         KslzJg/ZF0+4u8RZOovCjeMeDqxJC+jv9pZQPE+P7q7G4HMw8KQxt+MMM5E7b40YkSbR
         uAJaivtbjkogLe62g1EwodOQdjKkweyNkb1qjdl87DF4GzVrzNedoQERddA44Cf5ZBw7
         8mnfsKmDXpEhDCoIhDa8klR/wHQz05NZqSc2dTCbqKUZKsehWETYi+2aU3uUYGX1mnV5
         2q6/j6uTHju9osmj2dR/VjOYxdoaKUgUR5dr0lk+e1V0YhoO1KlkZC/0fYmj4auWV+Pe
         3RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRP1DhhGsQT3lBlsmLhz2UdYtXJWmHkoIBR5rcFfpWUsQq/4WADPLF1iwOFFFjsK4GNy0FIxB3+4VZLqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjivougolQ7kxVQVlwXg/sK8bpfNmavvg0qp8IFMZFeQEqAmNg
	Oc1ysj5C9Q1lS/ZQxzKqRH2C+V1Fk3BKtE1O5u54OWn3oEkVYTuxvoo=
X-Gm-Gg: ASbGnctgxl0wrUPXssqtbBadgCPFDv1cLE0qoB8TAim/yWH/8/uQWU2OuKurga0SGMh
	fLEZIVdGnd9o0EMBFLQpBV57bJbLAnHN29E4GyL2i0zF2O/lQWyd4m2c5ylS+bcbYSvxCYtshnR
	8N44P2TAAI4a1CCbVgNGd1iyFQ6AzXCMrFcklanjvlgaGv+FLUxALRHxg7nts8aEgpfHjIwbHAY
	WPjxt8KlGI923y+3cW3GhHa0tWsS3dhbZg7AJQQHOnzehQhTSfwXA6f3+Fhy6TJVXubF+cvw9s1
	HrTFtolA4Ve9pAfEwhlY1oSXOJhAYFpcaIukNxA/dNMPVUwyCkX7M30XUn4sC7ku0Q9ylIczHkO
	dg0NTuATqkqnVgf0g0/JbV51RuSQb6sOGmQY4P+28IoObp7zQX3P/wLXJCF8Yc8zSlB/roATA88
	dB04unoix4LQ==
X-Google-Smtp-Source: AGHT+IHufRCD1gspY8glmM8lax7BUG8ynHHaY9o6yM1T8DIIM/vktiuj0NUkBXjxADybbCWs5+RgFg==
X-Received: by 2002:a05:6a00:1894:b0:776:130f:e1a1 with SMTP id d2e1a72fcca58-79385709579mr9273576b3a.5.1760035067817;
        Thu, 09 Oct 2025 11:37:47 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([171.78.199.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0c3a38sm411630b3a.41.2025.10.09.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:37:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: atharvatiwarilinuxdev@gmail.com,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sebastian Reichel <sre@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] macsmc: check for missing SMC to avoid crash
Date: Fri, 10 Oct 2025 00:07:32 +0530
Message-ID: <20251009183735.1288-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users might manually install these drivers
without the core SMC device, causing
a NULL deref. Add a guard and return -ENODEV.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpio/gpio-macsmc.c          | 3 +++
 drivers/power/reset/macsmc-reboot.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-macsmc.c b/drivers/gpio/gpio-macsmc.c
index 30ef258e7655..7048b45953bb 100644
--- a/drivers/gpio/gpio-macsmc.c
+++ b/drivers/gpio/gpio-macsmc.c
@@ -238,6 +238,9 @@ static int macsmc_gpio_probe(struct platform_device *pdev)
 	smc_key key;
 	int ret;
 
+	if (!smc)
+		return -ENODEV;
+
 	smcgp = devm_kzalloc(&pdev->dev, sizeof(*smcgp), GFP_KERNEL);
 	if (!smcgp)
 		return -ENOMEM;
diff --git a/drivers/power/reset/macsmc-reboot.c b/drivers/power/reset/macsmc-reboot.c
index e9702acdd366..739f94e4ed7e 100644
--- a/drivers/power/reset/macsmc-reboot.c
+++ b/drivers/power/reset/macsmc-reboot.c
@@ -205,6 +205,9 @@ static int macsmc_reboot_probe(struct platform_device *pdev)
 	struct macsmc_reboot *reboot;
 	int ret, i;
 
+	if (!smc)
+		return -ENODEV;
+
 	reboot = devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
 	if (!reboot)
 		return -ENOMEM;
-- 
2.43.0


