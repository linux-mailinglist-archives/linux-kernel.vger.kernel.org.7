Return-Path: <linux-kernel+bounces-827000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E290B8FDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E7518A2138
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D192FB96C;
	Mon, 22 Sep 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PdI4FtyC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF42EE27D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534857; cv=none; b=UqCMXeqGbnlVpQT2fNszKTf4u+p7wMCSXr9LfnBeQO1aSeAfI8y/03hPGOanxG04VVyVuHbUgzmZLC6bICKEizeufiAbk5GDItXFiG/kPkTXRK7zInUYEaJsxqCwnWbVszo26HelgME9vb+AzKbGqzVA5VZJEFIEtL8bnGSCDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534857; c=relaxed/simple;
	bh=aUR3ryu98yvbN2Nls9weWrK7nyd+VGsj3kYhVd11++M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2c734r88ykGN915APialuNGh2UEFSj5+XY+ZKykt3vJAkFY7s2oT+D3Ma4QoOOTceYVWoVqVcNfcgeoASbuLjLO0JXcuAVGFksDThd7/pPYlYo15IgqW/SXAk4zHId48HSKZjbSSsgylQReYOfIPBIKAxlpFtHUg8GxZLW8VaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PdI4FtyC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46c889b310dso10955965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758534853; x=1759139653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ago4AKKlVfbpDEKiW0UPe8e/tjpmgCVJcEoHQkKgzL4=;
        b=PdI4FtyCZ5A9DAeTVhgx+SdOMpaZLwF/kiowZa3PTYR/GVhARd9wGcVEzSI6rr42vN
         PjkSiUE74ejlUtuIHxSRyp4gAt94c2DcrGLYvdS29o/n1ZVUSPywOsS+ekqXRk/Ya3vj
         /CTUTZsx396UNq1NVCWVFUEXasZI+LL+iCmfyAEOqfc8nCMpfr6E+GXaOpvQ2dmRvwvu
         UuQO5fJWoOIWJcsp8OzGVqiUQ4/1mFRfUWrdEXFL3Eiv/MF3TzgVzIMbHy7abiJNRbHx
         tFOUp8tzp8aCA3HZCUsGB+Vbnh9MrrZPOfcEhU7MZNeKgVZ37U5HFtI7x07kTImg2B53
         mnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534853; x=1759139653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ago4AKKlVfbpDEKiW0UPe8e/tjpmgCVJcEoHQkKgzL4=;
        b=dn20txep/AhRs/UQCi0xcd92fd5WIrAnE24UzLoRYjBa4r8BLqIQZxtu+g2l+kSWbh
         DvgzVggZj2lFsuWWaFflSnFAl4/RWfkPw/ohRuPzx5GKwFjoXNOrxPzpnwonR4dm1CdW
         A6StVm388/4BiCLGthrfL8WW90emO7rHG1Y5fRSFb1ku4kp0icit7lcIKafig/KsjbmC
         zF8r4Ljs+9AYdGHVhdhRVvhnOWmAu6RoCFLJdacFbXB9ca0lqgcMDXpkp/tvexi2Re0P
         n1pWJYwV2NR+NY7Iqh0+eZEC/5lp+mhtUoKCJV/rU1G2DkP+80mO6pbVV9hj+U9XWchJ
         F9ig==
X-Forwarded-Encrypted: i=1; AJvYcCU9h9dOntleHce87/twEy1XwpHbk9u7cfKBIJQGbjNNTYHua1YghDB3D5Y48a2t0Di9wmE002o6R0Gi5JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbLQ3QwBSP/d5fqStVShtffzOZBy2YLEAPqebN4W5xrRaG/we
	Y9B81u9YIHwinwH+U0qnyNhIeftQERRrpb9x9tvhaN+8BmX5OmrTtEDcfxWmNYNUfhg=
X-Gm-Gg: ASbGncs0dzJUdwTEkdj699Zpjk9wBIczs96HwaY1ATCPjvdKdcYd2cvRVOxtN4uhEtn
	tnIJHNVNkzBJt9xxmAdnReifAIrghOJW6ONCfW0eu8eVPvXnDteQBEqnv3rXHVri82Qo2I+F6Jb
	ChfTGxyzox5JKONv3Gq3eIiaENKUHX2eJV7nh4cPVF/rOMeKFOH9wAJMGdIOb1bFyu1tCx82ab7
	Jjru26QeM1G7kFUdWEnmnzB1hd+o+rB1RiIjyXkLDsP573dNsr2UGg87ffToeX+wWsCfu8GSPUB
	J27debQp0hpKdc4j6tgaGk/LI3McHbyZjLF/cfeP8zZ8dVInogH9GcWoT/bwh3V6F1FycmgxYBB
	YYADCPIbwmtG3IU+G
X-Google-Smtp-Source: AGHT+IGh3+4GY7BhbXRdxHNtvWi9t58yhCV6fj1ZeJ2EY/lY+Lj/8g1ZLXUfA7F4qSMXbmVDAFnAzA==
X-Received: by 2002:a05:600c:4ec9:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-46e1a60cb3amr6850765e9.2.1758534852930;
        Mon, 22 Sep 2025 02:54:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:824c:ead0:65a5:c51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm156496835e9.0.2025.09.22.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:54:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 11:54:02 +0200
Subject: [PATCH 1/4] gpiolib: remove unnecessary 'out of memory' messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-gpio-debug-macros-v1-1-d99739dff711@linaro.org>
References: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
In-Reply-To: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=470wYlbXCkRiYNRraDrehXz5hNEeC4YDOrpA6VC+LVI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo0RzBFF3Yf8N4TNzjAoMiMcdWI3dxJXCIyMLyl
 ziF/tqwlceJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNEcwQAKCRARpy6gFHHX
 cmOoD/wJF9VkxmGXKrAQrpAGdKrHwUEJvosyOhLKo94EUfTzoBFOJd601fAnI1XOmaPFWoKP12H
 ucXdb2eVM4z32Y4PcLV19lOmrsOZsQD6A9BK0Ol5rlsl96Ox70evEHPBxZ2+nkqvzjTjrxlfSeO
 EyfHJQ4QVvU/LhboIMKsK0TR4qSQNCnp6jlKhmU5uNbmkOatYC9Y+gmrVekGxqJCG9ah38am/pQ
 6LZdSvpeyT36A095VvzGH+L52zSMkhtlRcfqLWrSo96kSFR7ZD2t/Hv/icr4yic2COjidw3wbC7
 us+B3m5l0Ov9IjIQC7fLsJlT97p2luzAH+BE3bhRPPGLgyqynTpiHak6dM/umrWoSRVvtQ7BG2U
 k3PcZoout5Wg8lCJDV5sDixWuBJTxNff3cDVTLpzTraHDUW2iiy9mRvHdRXvoroniY/8LS8mZUT
 lgTS4Fg4EzZEmwOt5fNccDoL0VOzGMTtMr2k9dwfAbyyRCgW+IPzXqZEaPOx2TAd6BjIDMXVyV4
 ingDCUngOfPPixtb0iLgZUvi64jClk4DaFJ8ZZ5g6Q015wp0MQzIyvKY63UP/c/HVVTirnWjrWt
 +j+WzhWmstJ3R0IQUiGPx3p5IOpSymmeGcJ9QHGIZwQlFgzLh2w9lQR2luJGXTPcPxX5nQ0JpU7
 fxa1H9aGFAOYWyA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't need to add additional logs when returning -ENOMEM so remove
unnecessary error messages.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 01bdf8fad7cff6c507e79b8880e9335d7ee53173..0bc2363e71a488a9c21b3da59821e04bc08be69d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2316,10 +2316,8 @@ int gpiochip_add_pingroup_range(struct gpio_chip *gc,
 	int ret;
 
 	pin_range = kzalloc(sizeof(*pin_range), GFP_KERNEL);
-	if (!pin_range) {
-		chip_err(gc, "failed to allocate pin ranges\n");
+	if (!pin_range)
 		return -ENOMEM;
-	}
 
 	/* Use local offset as range ID */
 	pin_range->range.id = gpio_offset;
@@ -2379,10 +2377,8 @@ int gpiochip_add_pin_range_with_pins(struct gpio_chip *gc,
 	int ret;
 
 	pin_range = kzalloc(sizeof(*pin_range), GFP_KERNEL);
-	if (!pin_range) {
-		chip_err(gc, "failed to allocate pin ranges\n");
+	if (!pin_range)
 		return -ENOMEM;
-	}
 
 	/* Use local offset as range ID */
 	pin_range->range.id = gpio_offset;

-- 
2.48.1


