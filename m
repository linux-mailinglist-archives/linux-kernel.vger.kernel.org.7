Return-Path: <linux-kernel+bounces-886040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E48C34934
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8067A560143
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA9C2E62DA;
	Wed,  5 Nov 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wxsI0aqW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C42E2EE5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332489; cv=none; b=rw69HgUhLZNPPTTFEUAvMXr78Kx7r8BkQTYXgytdqwWJjnST4/28N93hpD2HLjwlPv2rcs88e2rFGBH5iD0hn1tD+IVp/2wY6Lyqk0dg1TjI01JyeXlM1Shxtx+s2wMaEuAM6qqBy0dmi5EKFeOt5SrOE1NsSK7lkLeJEwch70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332489; c=relaxed/simple;
	bh=X8edYpKFxJakc/RTqEB+Pipzfl1zQL02ONMlmJvW7is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQ5Q//JdicVttIyRdvfqOhnQ0Gm1VSB7E+Y7mxn5H4F5H7AAHSMtJiLzPgAoiAwlOGv24fYtLRQU8yq8Dy6243YaUABRZwIy2dk6fTAM7SZWBZ1N45UtFt61chvEgfFrAAW2+QH7pxBodboa+QQSH02auFbcRMUyU0eIX7qFQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wxsI0aqW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c8632fcbso3174322f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332485; x=1762937285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWWTasux6nuDvfpZkvePzyRGdU+qe2S0riWlt2ij+bg=;
        b=wxsI0aqWJHp2fdcFWv+TDXXYlICmmezR4sL4ipmQirG4lHI6IlXY6X9YP45+EFYo2P
         yKoQWVpYHw9VnqlUSknz5fKWTDF+ceDX82xAYd/NQB4OMj23L9BkAh0KzJI9vzToDIHv
         3diqvJ0fhO9c/RzlUsr4r3KjjXyXjdufl0zxUcV6gHd8+RM7oUYx2riyCzVnvMe51URE
         0+suzwwpO4dkNXxuXw06UtJVhonoe4v1LSBQfEcbgjbuIGKHDV+TC7+U6lEapGiMuoqG
         XcyaCiV9AONuyntFXDUcbcHk2j5VeA/OYCSIhAI6fQhnP7pCGD3vv6ok+FgMY+TNZs6O
         ufEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332485; x=1762937285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWWTasux6nuDvfpZkvePzyRGdU+qe2S0riWlt2ij+bg=;
        b=e8Xn+7gcCXY9TZXOQwf9CoJN6jEfotXgEWQVGThUvNgN0VhH6bvds1cmwV2HwQJfU+
         pgeEolE7JNMpAuS/zUcxSd6VXKiplGNmIVRG5aDfr+hi09PW+Y96tuC1F6afvpq/V32A
         ak7CLPPxD/6Zbuk4UpDcTwoX9J2xQvUc+/OudbGJIKIhRPN3hF1bxsIKR0vx4sWpzeCg
         mIosV91ki7zjB/nZYZfU9DBznblluxNNEv9ydC5JRKxTsn/8prkHbDqAyxXeiH1Lj+8f
         uEjr8BlsZatn/5dn2jMGUgkBDv70nkWphauROQLC1CtfY1LOSKhnGFxeFzd+4iNucQUB
         HGlw==
X-Forwarded-Encrypted: i=1; AJvYcCVO/3BIQOc4Mxkc7kmvovNgXGbsZhHnUKLxl2zGLzwfA9Q6OqAIXGunMw2uRIj6wnFjVAeZXGNrstjPF5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVupbVNI1xyook+c4GZqT7eIoXFimJo7AiokrNvvL4gmAhNBa+
	vHKSAtLg0wWuWiPQLc34jQi7rgU4vxz7jAGxovTexQaEAfN1UWnix+jPgn+9PtH3AOQ=
X-Gm-Gg: ASbGncsVp87Ud4FVcJhPf61wxTx8jIm6ptzHJm36PZMrVwBNsA/yJpFEbF8m61R2aYM
	rdp6noBMnLCFgdnxGpYj5Ix6tWx7R5Fv1CMHjgrEEaiKXlWOpTdkNmOmzOdvlBrdMb8/JWQiW88
	kFagnAuJT+dQBojjWyU2RVMDFmNoy4kqeBHjqfvdpyCnUT+TkJ7hvtwcE8wN9LRBHjcwtSXGbUv
	UVnBo9s9EhkR48IzJYV12UfML0ReIN476yunFG84d1GQchOSSxJ8QHqKMgfi0OkzuXnOscXHjwa
	x8fesgRwLszuf3KIV/s/jvipltcqDqEpdZAsq7svppV2nGzonTq/FIHol6YABPILlgCHS9wc+56
	kmzIq+Uv0ghZ0Cjeft0KY5I953KJg2gO4Qu0YfT1qoaD/Gm41SbtXpNJxvsdoaLZMLdA3Ug==
X-Google-Smtp-Source: AGHT+IFKGljAN4NkKVJIQ54D8McX8K1Nf915phMDtJjjRKpgui/5LxN2/d8VKz+lQTYKVEd42J88qA==
X-Received: by 2002:a05:6000:220e:b0:425:7c1b:9344 with SMTP id ffacd0b85a97d-429e32e91b2mr2003985f8f.15.1762332485395;
        Wed, 05 Nov 2025 00:48:05 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:48:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Nov 2025 09:47:36 +0100
Subject: [PATCH v5 5/8] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-reset-gpios-swnodes-v5-5-1f67499a8287@linaro.org>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
In-Reply-To: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
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
 bh=YAQBLalSG4YSjo0vg2GdIJVruVYhGTc+UD/iGlJqB84=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCw8x21Ejb1yFXnz2kosAyWpBJETwb/9mWsPQJ
 itx3PJY7NCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQsPMQAKCRARpy6gFHHX
 cjpCD/4nA48zw7npFITzKnfkqKIPQbwERTmdckcuMxGRycWKQT3YIusQjBVBT6yNHbh6qxOSmBy
 C/C+uO9mPBzlHmcCpdLJwg5MAZVNZzI7U9yzYYNkrt6OFKA8FEHwL71cn4Irjsx1JemJYg4QAGQ
 kdItL1908rDm9waGQ1hf2ak7FQquQwB2E6Y+u3bwsm+OB6I+isPXtp9IIfBr81XIKFE5Zj0O7Zs
 GzRQn6eKn5/JvXDsHKP9tkwOI5mYRTYz5K3rtg7+h0PwKzv/2/dl8PzqGhexkmuH10pG8EWyqD2
 Gl+/gw7s+2gqQa1jjmiFCjBZOBrJCYn3g1R4k3u0yognbCB8FgJdIAhjxL9tfqW+EweFryz8K+F
 /eq+nADel9SQ4Qk0ZlJ8IogXH8kB53U750N/cL5u2Aj1tFaCp88ZddnSehZ8UJdso1T8EzlBAE0
 8yIcWFlwy7i8Gz4eaYrSQdTlqQ60K/2zLB5E8+tCoOkcS5PJgNvHpRuQujagaoXQUC51V5etekn
 04qvF/eSDMmsfUD1NsfNUexn8h1aTJMLL5jqCQMaK5A/QTwk1yQxIkhb/Pa/dJ8GfqveMZBeO+p
 q/Nh/Ifxg7043rVJDbsMVXFqfZ8cQEFni1RpJKjjLPmu+GrRaosIf+lOBKMyRh2NHDvDutKeH/D
 uSP3TrjJFOYNrtA==
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
index 4fbaa67a6f79a4af62855c88f6b74f92c3d97159..a368b14144e7bc29ae23becab2eb7a96a4adbe44 100644
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


