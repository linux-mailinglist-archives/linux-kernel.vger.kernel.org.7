Return-Path: <linux-kernel+bounces-722877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CADAFE02D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6037B4657
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29042727E2;
	Wed,  9 Jul 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fka7CJ5y"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43D26F45A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043343; cv=none; b=nySvhHQQTgjoaUvy1I2xXdz6EWQqWgpakxn61KMm9LB1dLVkm8r1Blh8TqEvJPPzMMuEkXa1p06/+nECJOGht5JYvug+DcMuTvzM8GOkztj0JBLIAKpzQoWiKqpePLzWoavS5n2IufWt6L7pF9NHiGoAjBp53n+vSSPODIzhAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043343; c=relaxed/simple;
	bh=zsnOtolDjELR8+PUi5S5JqrWSbc4e87I0rmY7IEB4wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYP+c/zJVBxl+9oPuegPeng5XDhrwKgXsLGDnWCQ6hePro8wrJUrEeuQVLOAKuHwatoT5nDCl4H5Y8taQe2YEUnAD6JkR9fKHQj5ApsMMa3LNZ2l+gtOiBvWw6Az+d+c8n5Xjfpk+M/F7dVHDsF3YwfV5BzbiVUcjiAZZfSArAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fka7CJ5y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453749af004so25746065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043339; x=1752648139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7D6yL0IVw5djYiHGV3XKwe94mzmNLmXANv1uukKgjo=;
        b=fka7CJ5yQOD06c6U4pTQUPuHWiYHr0vosthq8HxbHHPctsz5mTXvJjxjoELemcLjZF
         6uIhQBa3z+6Soz82gzYRn9guWGfoiU1HJpOHIkPACqmYPqQ3FAhMp4nUmSbt47STwSL9
         bGKXVZhRWVdqqe6H94CMK7CvKWEkmL+kjHABFz3vbfCpkY3ehQ0iHc3YJ3Usd1j7/Rjr
         QJbpVYA8HKKzjnOrwl1Ga+1VNWogYcU3B+uVImGNWvAueWt4arVce9xWix2Zlf//saJU
         EWd7c1dHQLtD/FodXYagijfSzfXK+no1LU7bp2osgew3o4G0VDS2YkcgYo4ksdo8EkDe
         2yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043339; x=1752648139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7D6yL0IVw5djYiHGV3XKwe94mzmNLmXANv1uukKgjo=;
        b=og1XAht8bDxF9Di7ZbNwm7nSvJQBucOP49UnGqbzqrVHLv09k9Q+4lYpkhoWBZzwT6
         /lltXz4qYLNpaHqTXwx/S5HzlEhHQVUSiapcKaka89wDppmGcXILEbLcC813U1WVWcmG
         XWkm85w0cz/0VMz7vjk9P6PD8pGMwuec4j6yuUACVnRG8RYT8B0PCqugR8LN9hLsMAGz
         WIDSl3VwIcNwGDv2QOgXpiQH1GZ1Yfyt5J1lVIoXdLUDD59GCI9+zLixpRdruVWsSgNi
         9a6vI01KoeG52OQEQpNJKpCoteSulFz+O7CN10Zg+H1o7BntaV8Jlvh1CnbsDwTMc+oa
         rfww==
X-Forwarded-Encrypted: i=1; AJvYcCVYzy5sEcIZf1QE+TP8iUk0fXiM2y7G8n3sbaEGeEHXQ4oFTqktyqSoM8YyR+dd2teQ1lLOcoPrKzAiEyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUgx3V7YSaIGcVu3tA0hXfiwtok8joAbC13otmO/XSB7MN1vm
	GOgSQgkuAfVqO7yVB6JusugNJLwNE6uwuI/02v0SLBHqx3Csz3TxEKhz3DTOxhVSL2r6spOEMCA
	dLwzz3qQ=
X-Gm-Gg: ASbGncuLUe7MutxQJANjO7Q0rE/p+AADYp2ebL+X10xvWaRrAaMQeLGliknIB82M8l8
	fTYKi5SvDvxkDsx30uko6/W5yg2Df0qv1H3VwWj1vaMyD7kihXU4aY7p5i3fMfiDZ2L0jcfr1K9
	5qDK+sLaDUbaR7LpXJ3Sj5C2+22y7qRQk955+Q6XaIzX6nrZOENc38n0/2FddC8tjUpwmhQGkq2
	W6Wjdvhqds+aDOecHl7trnX7BGfVZPww6EyLYvcbD8EyjG8bjoUCW72UZZiCaCRfPiWFI1GqtlF
	incWOR+i3ecKO+qqdrxCIaAzpQx2+zI7PO2eauY3b4GDR1gDVmlx7hiO
X-Google-Smtp-Source: AGHT+IFsc2XhCJHpv2AICjm9ErTIxzmuwd76UKpGdabiRQsHWUF8TpEV+bZDxTqZBHhyjPjnEzFqAw==
X-Received: by 2002:a05:6000:1acb:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3b5e4466ed4mr792333f8f.0.1752043339475;
        Tue, 08 Jul 2025 23:42:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:42 +0200
Subject: [PATCH 05/19] gpio: winbond: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-5-b8950f69618d@linaro.org>
References: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
In-Reply-To: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Nandor Han <nandor.han@ge.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/MP8OTWpXnD0QcqCaGyWn4wC+X1zvxCk0GefxRrJBw0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9BDmffu27SvUy84btlxo+IQ9HC+2aVXNke2
 Bv0Q8Q53CeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQQAKCRARpy6gFHHX
 cpb+EADH1tfoH45scdvApBrkHQcCzNjHIV06LRTwcA7OGIbtjlAOi0k2WQ8aL0h2iVLiwIDY0HO
 QdZ8G8IwF2ZegPXZsjxpHz/I4kS+n51GSwHV+3VLCUtPJogFrHVi9iG9ByZ0IpiX5YYARZKPduf
 8TaJMkoBw0JOKGtVzwCmiSkTMnPApyHL/yKbmAbXr/I816eDW0RrTTtMhT+iWNtx36Z9l4v36Ew
 Bx4nO+PEgHROaELVaDSBlSjvTjCB5hthu8NlUww2nx5UwkSTrkq6iV3I5CNn8dJogpW8bqloy0H
 A4PgQ+Fkx/shCTF1W+hFo24tLVAZbZOUBtq6uWB4ts7Wk7lFg0VtQG0GE45CPu2RgmaoMymFkgw
 3TiTKWylAJG10Gfnq4mzw7MHp/IneZLVxGx7Wz1xvpLWAmBEb/+r7iQHfjS033NRPXYUwF/ChR2
 Sbs+fQV+tMqBL07k1V6LOuNeACAvrld8NdhzxyebpJ+uHCrtq4M8OQF4PGlSQH8RW1dfbFGeXGe
 Tk/T8J9wEofRqGbWfkaE1qQ3l7rTz/aR48mdB0wOO92SdWGtYXksSGkhnu70idZI6b7vcyoYggj
 Emiot1MC6x6EIHP/4Cv60yxexv2IriX6UxriKf+o8Q07yT8ZXE7maHFtDuteBaOjumYis11FhuM
 fD/nK64y69QoOAQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-winbond.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-winbond.c b/drivers/gpio/gpio-winbond.c
index 4b61d975cc0ec27a3b0fc342a976b09bb14e0d28..421655b5d4c24d9ceda6d258f0a17f49c5215bc8 100644
--- a/drivers/gpio/gpio-winbond.c
+++ b/drivers/gpio/gpio-winbond.c
@@ -458,17 +458,19 @@ static int winbond_gpio_direction_out(struct gpio_chip *gc,
 	return 0;
 }
 
-static void winbond_gpio_set(struct gpio_chip *gc, unsigned int offset,
-			     int val)
+static int winbond_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			    int val)
 {
 	unsigned long *base = gpiochip_get_data(gc);
 	const struct winbond_gpio_info *info;
+	int ret;
 
 	if (!winbond_gpio_get_info(&offset, &info))
-		return;
+		return -EACCES;
 
-	if (winbond_sio_enter(*base) != 0)
-		return;
+	ret = winbond_sio_enter(*base);
+	if (ret)
+		return ret;
 
 	winbond_sio_select_logical(*base, info->dev);
 
@@ -481,6 +483,8 @@ static void winbond_gpio_set(struct gpio_chip *gc, unsigned int offset,
 		winbond_sio_reg_bclear(*base, info->datareg, offset);
 
 	winbond_sio_leave(*base);
+
+	return 0;
 }
 
 static struct gpio_chip winbond_gpio_chip = {
@@ -490,7 +494,7 @@ static struct gpio_chip winbond_gpio_chip = {
 	.can_sleep		= true,
 	.get			= winbond_gpio_get,
 	.direction_input	= winbond_gpio_direction_in,
-	.set			= winbond_gpio_set,
+	.set_rv			= winbond_gpio_set,
 	.direction_output	= winbond_gpio_direction_out,
 };
 

-- 
2.48.1


