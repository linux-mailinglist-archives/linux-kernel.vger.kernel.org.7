Return-Path: <linux-kernel+bounces-722886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F40AFE053
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30936583B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEA27E7D9;
	Wed,  9 Jul 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bzykrB34"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C227B4EE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043355; cv=none; b=XpjJBTyBda+3+9zc2OMDr7Dnuto+x6kj1VfLWmYZG3akDoQIeaTkdDiaLtK9mBfchcMeyTjvGXzXMsWCXAmZrkhzjkEaQWf0ew6R0watDh6Tn3LNgKHNSYOFMHcAI66gjlu4CHvtSkl5vWxCF5guD/2bH0i1b9NuV3TwYe5MGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043355; c=relaxed/simple;
	bh=kzFKN4i55dDhwqRLDyNACYNKst0Ab6yEzRy7vcygGJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abMxuwAiyJn/G7oY3IdgTmBq9PaHmM4UV2YcF2WLwPNtty1BtSd6I4UH2W1H4PmkXWVbralF8BHPBFr7d80U9JyDAJcx4fg/m3pVjiruSXXDjHpsQoVbdeTNBNqkW2bQGDzrpSTGJPjs7Vu2eSs0mBQqcymnoxHEBKdNWhV89Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bzykrB34; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a52874d593so4152521f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043351; x=1752648151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUrgUkOHTyOnDe6ndwQPZ7IvM7nkBad/sckqQo8qgw8=;
        b=bzykrB34RD2Y+TRHLLcRElV/FIo9JL5UTYUFYmDL8vgjJcZmFDYn5t06eTxWPO1hrM
         zgVdSqPu5Sxo6Ms+VqOJ3ZBb/MnsIol/PHpNkCYZRTb5lfc8jOy28HnaeNBhfiyUolUS
         3PqveuQve71m/vNs23U3hM6ECYYSeGlCUHNqnS725xukPCr/Fq1aa0QiijhO2KJZJbyK
         Lqq/GZzv6D4rrZ9pHoJMwd4MZuHfYJLPTNT1/VZpOtJxjJcsfN+bRWkXiqIAH+p2U3Rm
         grVqwodViv/hrs9B/kihGdCXwTsb1yh2KmDK+4BnxbSZzbGMQOtGComjHL9BvVyv/k2a
         ++yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043351; x=1752648151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUrgUkOHTyOnDe6ndwQPZ7IvM7nkBad/sckqQo8qgw8=;
        b=NqG8ztkGGdPK9OEMz5eEJV7cxC4Z0MQ1FLcLNk52wXsO4/huS7Z8KtaGLMTFW8QNWx
         LExK4PfD7er8Fz26XsJrkzAFrUsvv0/koCD4KaKictl3v3fwJQ2K/eg5z3pJiLG6PUcQ
         rIRsbuwyV0rJdNivxZJE7ay+vPWxDvD4cUgWb86kjRbY4nsGluSOnPC/ADNlwyRRH9Pw
         quAbok1Xnd2HE9Pmn9KGkWkHN1Jmyp9e3dw9UNM+gBTSmzW0efeiIiuk/hedrN0qFSDL
         6js2UKXbAF6x78L243ONODLCCnFZ8sZVbxohBkeSj6Z3xFEkhPny7sMdlfJNFv2Qeqkz
         d0bw==
X-Forwarded-Encrypted: i=1; AJvYcCUXamR+PwiLZTNATKGgEL8Gt7X9RmoPRWvrZIdtmQ2BtVq196XCFDb8IAESTfBE/x4EDpKvPnpG0HDTeDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1l5GewoCuEjqHveowNgBDsEF4FYCBP+2SbZ2UvnGT0JGabYfI
	xnuwqlVn08mS7u3VUql7IlXz/YuTymIp9IAEchMcL3d9V7fkRKpBeN3ICes18spEiiOPcoDrLmW
	PleLwOh4=
X-Gm-Gg: ASbGnctzcreJittfa7vQFvWJYKmMurC+b9wu/KjfBBmHMWsO6y+1ttLglj//p9ivRar
	kriMPOeqBPYFDxrE59bqV/iCkYdO23kl+z+eFNv4uysQFqN47djeOXRbmz2BRjZikaHVTxEV/oL
	Gz86ZB1urHQFguoywQTPD2wYeoqXLlvI65ciybwlJ7EP2j7ruWGAbU4S9iyE1S8dCzvafKVAd+q
	ABUv2u8Rfb2N+3jqWohOGq69zqcG49lfL3xYgI2y8+AXuwnoLr6yCYP8e7vt3anGHzcoEdOCumv
	lV3ksFaVNB/8dHcwgg/ldZxfTq1GpFUBNshEvpy4meoIbpJmoID2ty9y
X-Google-Smtp-Source: AGHT+IEzSFe7nz0LVy96l6aCeTa6SGcfCDu8HOJfAJ1g24SiaRH5ftoCc2kEuJ1ZSbFiHDMmZGd5bQ==
X-Received: by 2002:a5d:5d09:0:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3b5e4539694mr711424f8f.51.1752043351497;
        Tue, 08 Jul 2025 23:42:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:51 +0200
Subject: [PATCH 14/19] gpio: xtensa: remove unneeded .set() callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-14-b8950f69618d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Qek07sXB/VWHFFd/Pd2GDtyCQUKPAvQ65Za1xgZnGxc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9DZWbVhAOoLSv6rDoZUPM3EtQkiANX6u7uB
 E89Yrm3x7SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQwAKCRARpy6gFHHX
 coEsEACfHdA2HRf+Kt4GEMSKy9oDBI2nKh8kVKwaZg53fNd8Qqr/n83SqIapZgxvWklRUxhPUhA
 PsUUZOmkRw5hAohTpOPhu8iCsAqtqGqnHiuREjgPGhfKwbor7ZkWDIrQliXRSsSx1PX+jDXX7UK
 GNU7Dehfsbi4FY+W7jjbENfrVfqKhGsSDoJe9Rd4UosUeZuK3+yrn9JVpkT5Cwr1fwmFfHOJBGO
 t11yRbMK5Z+3NWrDKToGYbOZRkGpU4pTudLriEtz/1V5vk8R+iMq+nx1GXqNvXsLXuW1FW+Yt9s
 tv/NiL4WnkugYxLNqm9GkopYqDA4QgCgmR6VSSN05xqJsob98NB3Uwyx8cLn39nZL+F75NtL3lH
 jItmvr3KVRRDaNOLF71MDBPICPmZ61dgWmiAjjEd3QwnoVhC0VvzGLSHzCgP9w7qRF7nmuBjFgx
 Tf0oeKHbLgtswWlSyB61XEw1EP2RHxxLRq6ovNQOBvtoNF4fUVMEdpUBQG/vO6TGaswky7IqRbH
 5m+yooGgr87lI+fQNel7WqiyAuy888mRUG92GI6J5+afggISI3jbIXFwiSuKcqFXERR7SF7IPDB
 BT4cCxvFYMTn82AO/ii/MLkZ4fho/ZFKPmPQ+uwd4B4CKYZ6Tx8fj+huaVpwmFB1QHA7gMS8V0U
 nRwWTbTTBThYHFw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO core deals just fine with input-only controllers not implementing
the .set() callback. Remove the unneeded dummy implementation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xtensa.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpio/gpio-xtensa.c b/drivers/gpio/gpio-xtensa.c
index c8af34a6368f4f69f9960fff7f8c27a2c8ddea8b..341b691ac2345b93320a6e8b933444d26dcf50e6 100644
--- a/drivers/gpio/gpio-xtensa.c
+++ b/drivers/gpio/gpio-xtensa.c
@@ -86,12 +86,6 @@ static int xtensa_impwire_get_value(struct gpio_chip *gc, unsigned offset)
 	return !!(impwire & BIT(offset));
 }
 
-static void xtensa_impwire_set_value(struct gpio_chip *gc, unsigned offset,
-				    int value)
-{
-	BUG(); /* output only; should never be called */
-}
-
 static int xtensa_expstate_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	return GPIO_LINE_DIRECTION_OUT; /* output only */
@@ -128,7 +122,6 @@ static struct gpio_chip impwire_chip = {
 	.ngpio		= 32,
 	.get_direction	= xtensa_impwire_get_direction,
 	.get		= xtensa_impwire_get_value,
-	.set		= xtensa_impwire_set_value,
 };
 
 static struct gpio_chip expstate_chip = {

-- 
2.48.1


