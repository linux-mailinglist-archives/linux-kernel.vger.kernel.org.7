Return-Path: <linux-kernel+bounces-827002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D520B8FDC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F87421499
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F972FE581;
	Mon, 22 Sep 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yyrKlc4k"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A82FDC56
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534860; cv=none; b=O3GE+hZ4DOz7rANYV4dVkeQt2YhAtxGJFbxdRoqxzfS7+qklDYf01r7hvgnTxWPgNOscuDnm0F6jCzSFeA44htcYa+eBBDkMyC+7CT7fUVy7eIb0rfM020Erf9xXGu+vLyp77TN3zC96PHiBMJ8TFFmV7JR5C+xDI7IHIPFYU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534860; c=relaxed/simple;
	bh=JSiAbQ6XQ550GNvYxQSyGjmWOwgYL3hoxlRzhMdSIJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkvQp+JQDwI/vWNmgdxrYi17gNBilouYT9GsTLCgpzmbuyq910AR9bL3zIDRaoqq64WXP5Z9DbG/0KVqZrZP2FarraoHi+ujWd0DIGy5MKVrW6G/Q7G/R0olfD8SZc1aHAYhhzfWjzwjNDOhDzwlWnp90TfuqlEh4R18TTwTtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yyrKlc4k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso4494136f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758534857; x=1759139657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWTtZzwfHQn6+lCmpyy7uiwGG/neruMpxQbJXO4Gid8=;
        b=yyrKlc4khGtfTClKvnDUMZOsHrAjuV4V9w8lWOCqWjjyBjWsM/n811H/xE/4VQ2vhO
         /Vjo6C1ximBeMA+qxEJmGVOlo8YqnI/K2EAvdDaLtryXrRlsreiTPp3U7SehvyqdcLZV
         3QaSYzo9uTVP7rsW+uV2mgeI8GxApsr++dF02gqS0mtW5v+42IC6g1NGreqeXe6Eh5eR
         jZ292L1tlJCXPc+ffJ+ye1rPBTwYIaMjka9w8SPkdHbxeXNsadU+21zW2nRRl/weQzuC
         SBGCxSWxkeczwmHHP/oFNkcNyT/pjkvehZF3U0UAdnwoVsbN08A/z29gt3M+TpvS+yFp
         cNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534857; x=1759139657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWTtZzwfHQn6+lCmpyy7uiwGG/neruMpxQbJXO4Gid8=;
        b=Q0JbeChkt3Db/FoWtU8UckBDyC/nb1M4ttsZqs35kzvtRwN8HHoA0rexGn6BkndGWz
         D5QLqFxKBcZg/vunifKpPR3L7jB78vgoweIr/+gZvqmDmRhpbHNboiF/NrTNVzVX6rpM
         gG0OSC1aOJW7Su0LQuYAVB+Ygm3biKcxN3HdaQu0JO3Fyd/H/10U3tvFAgc+gnJWN5su
         zvlPWoP1V212dr4yvVEvnl+0/pDU9T9zprdJdhST/F0Z8LQxmh95dygWV3XTsde9pRk2
         guNAM6GCB9DX7nCCRqRfkK4gsbqeK28IR8C8AO+q9T43jGJbRKNS6GGspN51ylDIyLE8
         vpGg==
X-Forwarded-Encrypted: i=1; AJvYcCXxgxQv0fA/AnvsznTcpr2VMnjAT46thiU9HtWyYNUd4D58FvDqRRKk2pC0JFwkCprO+e5uES9MVVnVT3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRhEbx2+ffkf+Vned0835gHaw5Y9j3IkceHbGpgzlxWESTG5X
	4dd6ZTyG46UIrFmlr9gKZFn5hug1MSWCvrOabD6TIhP+WVwza30VJ6BFwHbd1w1a6/w=
X-Gm-Gg: ASbGncsiErOCQ1WwSxLkl8efsKF/S5V/uZssvXwfVXua/aYVlFuRMveq58W/9Oa70nj
	X0ov1Bf2HPJJqWQAN+pfVJqUG/PqP1JmuPcVclq43kHM8D8Cs0Z6x9r0E5eBqlEERdpQ4uMDgSJ
	yrTCCpFzpGf1n/h9Be0VtOIzO7v+juOQfJrPtUse0IAGvfKrw9SSRK2m2pV1wzYK3FslnYHDyus
	zRdtfVvE86C9VHVrtLWsaZyBgBWduybsU3ArX7DjwvwvmYDahvskmxV9VxgHAzq0FoZQjrjDxf9
	cKyuR1M926+o8N0SaOw0VCsLKV4wiJPzwnS8Xh3IgJRhWpHjcrKS0mUpzhL8JdfpQaRwf+uIo/C
	AZv+Yu+nGCH9E8KWO
X-Google-Smtp-Source: AGHT+IG1+kRPuHwty7//pLz5jaBKbYNCrdG9GqG56Fo5kQfMR/Yof9+/bU8Pda5/DvbhHCSkvIYEAw==
X-Received: by 2002:a05:6000:1a8b:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-3ee7c5536c5mr8433532f8f.6.1758534857329;
        Mon, 22 Sep 2025 02:54:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:824c:ead0:65a5:c51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm156496835e9.0.2025.09.22.02.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:54:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 11:54:04 +0200
Subject: [PATCH 3/4] gpiolib: reuse macro code in GPIO descriptor printk
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-gpio-debug-macros-v1-3-d99739dff711@linaro.org>
References: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
In-Reply-To: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8H+jaFi/4nEUhuueNetvkF3PKqlgLMwgna7grRPnOMc=;
 b=kA0DAAoBEacuoBRx13IByyZiAGjRHMHIvQf0JLdhJjL3TzNRLv9C0Zc8fiRxjaPJGo+dX6Jdu
 4kCMwQAAQoAHRYhBBad62wLw8RgE9LHnxGnLqAUcddyBQJo0RzBAAoJEBGnLqAUcddyAfoQAKf9
 LnBSTMJS7dME3y+a5Hj3GCVM2fkOyCXUzoLWd3Xm8fMJx0Pj9X9D4NrWjuWJX0CGXH0/lpyJtoT
 +kBptgYOttoHK2uyJcrCTgLBl2uwuV3iqjxyKsdVKgm0+zibwfVsY7ESSxMGVWokZMje6XGlWQw
 73X+oGQ1ZstN0vCntzgvvfOKXmSHIeB/of465LBFwOzPY1UN+46lo1+nwGL9PdC1WfAUzBzFKVD
 n6fIV3M6ygcK6GB2vmspToU/dgpljeRCyDEqISo8j0IVFdQ84LEFJZzrQbRXitybsXXs55yMayB
 IKbewXHAAM6TjjVeqYYxSKpEd2jR00QKc2SpHDTOL0RHOy0LI7RbVXrm31yHqcufsBcv7QpczzX
 Mhy6K+yXgWRCVUElo8ymL0cjHtQvwjanSfkgnTPVS1JXzohtDpbS75XOikDW8H/c1LluycyRaDz
 RrGax2R3RVtD4Gbe1k+YU9UjJXvaSjpXMzbLeB72yJUkChKx9KDKyyrind8uHD/6XD5Rap+EHLh
 lT9DpslSwayals9B/QA8ysp55kKGVJuCymvDv3jUXXLI6om7RONJw6ZzfoID8E0wvX6KGb0NcLE
 9CaefEgAc9Nj4yeKEyt1ZZN/heG7HAEOYmTfBm0AHNEiuiU+CkgXL3gK25z47J1N0SG174zcXu6
 1QtoB
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

A lot of code in gpiod_$level() macros is duplicated across all
definitions. Create an intermediate macro which allows us to reuse the
low-level code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.h | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 6ee29d0222393dfff84608c79d21f4022cdd9cc1..dd96b2c2e16ed1cad2a573e0dfec3ab7260da1a8 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -283,29 +283,17 @@ static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
 
 /* With descriptor prefix */
 
-#define gpiod_err(desc, fmt, ...) \
+#define __gpiod_pr(level, desc, fmt, ...) \
 do { \
 	scoped_guard(srcu, &desc->gdev->desc_srcu) { \
-		pr_err("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
-		       gpiod_get_label(desc) ? : "?", ##__VA_ARGS__); \
+		pr_##level("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
+			   gpiod_get_label(desc) ?: "?", ##__VA_ARGS__); \
 	} \
 } while (0)
 
-#define gpiod_warn(desc, fmt, ...) \
-do { \
-	scoped_guard(srcu, &desc->gdev->desc_srcu) { \
-		pr_warn("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
-			gpiod_get_label(desc) ? : "?", ##__VA_ARGS__); \
-	} \
-} while (0)
-
-#define gpiod_dbg(desc, fmt, ...) \
-do { \
-	scoped_guard(srcu, &desc->gdev->desc_srcu) { \
-		pr_debug("gpio-%d (%s): " fmt, desc_to_gpio(desc), \
-			 gpiod_get_label(desc) ? : "?", ##__VA_ARGS__); \
-	} \
-} while (0)
+#define gpiod_err(desc, fmt, ...) __gpiod_pr(err, desc, fmt, ##__VA_ARGS__)
+#define gpiod_warn(desc, fmt, ...) __gpiod_pr(warn, desc, fmt, ##__VA_ARGS__)
+#define gpiod_dbg(desc, fmt, ...) __gpiod_pr(debug, desc, fmt, ##__VA_ARGS__)
 
 /* With chip prefix */
 

-- 
2.48.1


