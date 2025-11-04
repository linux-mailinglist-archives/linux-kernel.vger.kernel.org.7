Return-Path: <linux-kernel+bounces-885012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3068C31BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4555A4F7E87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77C337B96;
	Tue,  4 Nov 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYmW0PZi"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B19335547
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268313; cv=none; b=SMYvgoUaNlZ0/BhbyZNz3KfvNfuCknxO+VMxM9Tftj3TB4uevEM/B08F9cF5bbkfQcZrcAEAHqklpx0bDPGVjbItGlqGSVIp1/y9TcvViNLRjk/MUCROqHTrReswpTZgLQ3i3kQ3/6tn6WuEqGyuHa2iGcGxX2Tczx/pCyMJAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268313; c=relaxed/simple;
	bh=W9g+YJ6BtshhuZpzIE3hQJ772deNaUpm9Z9F4iVdSVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+0HpEcJwdYaV4E+QrmKI3xEx7Rw4Bhoxlrx7kFCZNMAFigx2u25kotXHu1c8gp7iKS/EfedRO6GG+uUwTVEU8k4XYDY+mzdO2KsDaJqKYxYuJPcLYvA5hndpGpqqlEUzVv3ab7EpUFY0rd3ehijNcaSBPlxVNmVJhegsoiOsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYmW0PZi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so3448780a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268308; x=1762873108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yDoZvnl9i2PCVqQpO58zWzoD91W2IfT5tAZBQV3TwY=;
        b=RYmW0PZiAx88z+3Xj/OA9RvHi5JsqA6OHbwOkDW/JlNii+V+/M/CfZh7gyOGClZnm0
         pAu7tf3Qy549y4XfixE8BYUb51gOrok4NnXl9jlb1tmtzvDiU8y8aUgPs7nv1HnTE5dN
         edR7LP9Lt4qD2L9O0fvQCx6+729fcTdVVaWtsWvw0INl0o9nSz/qKAm4jWlxd2vIMh4M
         /a8wUguHUpq3Dxiwyi6vkNGq8HL8/OLzZmroIaRK0O6lY93Skn0LamGOd6YlZk3KXFpQ
         DhPnEgFq4vHMxQmse3S8pn2RSaZEI6PFuRr1uFpXa6TnYJnNqlfq71PFHJgVhemOVWT/
         3+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268308; x=1762873108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yDoZvnl9i2PCVqQpO58zWzoD91W2IfT5tAZBQV3TwY=;
        b=jR/ahioFS50P8UtUV/ZNzVV4kZkOl35zglRL3IyKqNzvYMz7VtqpmiBzVqoxQbMPua
         Kb1DmqqEi/rSnzLcd5QsspGboq7kI/bO9NtrHl6h+YL3RYFdUtssmTpYN6Av8DdXQtl3
         QIwLqdoupo8ZAAWYUZTtuuP67SYhSKnTVpsBukTX1xevFy0kp74wLfxcgDU96LlyWsjv
         4Myo5xMmgr1YMoMcU8xXprDA/Mpr9zEUjqAHSZzry7Jrs5Bgf0ofZ0sYJ016lemiExRQ
         9UWWD5mYr2pYCwiTOCtEi67LtuBdAmRoIcizLYOqSedYkDQ4E3RQpc7I052EovotpP9H
         wPiA==
X-Forwarded-Encrypted: i=1; AJvYcCVZhfQEhyL8hpcJnFJ/rMdI8T5gR7NewK/FFGrBxXAlRtMi1yv7YWaojDMXuC7cbercb7lDHYXd14nnozs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcj95nkDa6UlwksYpM9OyGZwiBab52of3+rL+kp6TIsARUpXz
	o55zjg9jz/wd3r/dnytZ0m2adDlwp03qXHeNmISTtK+Or/Ymavc4uT4H
X-Gm-Gg: ASbGncszg4zNVbRPZO/vOno3xL7JrWw1NF+G3GxyJi0Q5ExXP49KK+MBSx/CHaTYu1g
	1thXuqsgS1WAOL9f4ZXTeXIeeZJXmGR9KaLwv5qkITKFKd75UPAq9l3sbuU6A6ZyBLN3GNjO3sd
	okgW34zV55Mgn2DQeantrnY2aLsnnRWCALsf88N1aQVdgRqwwimTC+NfaQwtk5Q0b4IxYcOZ1O7
	jmQOQwCme4p4BDcyIYw4xiSYhVTMxKqNwIilAjPtxC3vJjl8KYxfGtYm+yflJcDPHWixE+rpqGX
	Ojiw8kH/rWuig6PCA5LPZ0PM2Fa1P6RWDNil8iMsKlBgBLDJfv0yPvm1ADeGkEeQnYePiMe4Qtq
	E1ut9HnzeA4uvBMYNymJbJjRg7SPw8bc5vjVFZpi5DyEUXQEWgpO22XAZibkXgo+/SzC/E3EF3o
	Fmk8aIWYM/ljkpr2aGFIGZwRh6zV8AnklQPbH3vI04J/zwQQ0=
X-Google-Smtp-Source: AGHT+IFs9W8O44jy0to+HH8P36ANszj/+KkeaTelvysxmEQV/qsf42k3TLW8rGxbLiSoMryUWBJ0BQ==
X-Received: by 2002:a05:6402:26d1:b0:638:3f72:1266 with SMTP id 4fb4d7f45d1cf-64076fa052amr16212580a12.16.1762268308065;
        Tue, 04 Nov 2025 06:58:28 -0800 (PST)
Received: from tablet.my.domain (83.21.17.47.ipv4.supernova.orange.pl. [83.21.17.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7fcd7sm2288874a12.37.2025.11.04.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:27 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Nov 2025 15:58:20 +0100
Subject: [PATCH RESEND v7 2/7] dt-bindings: clock: brcm,kona-ccu: Drop
 CLOCK_COUNT defines from DT headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kona-bus-clock-v7-2-071002062659@gmail.com>
References: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
In-Reply-To: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=W9g+YJ6BtshhuZpzIE3hQJ772deNaUpm9Z9F4iVdSVk=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBpChSNyhoRHcTk8Z6URFMUuRgH1NYbfHNCN3nuz
 TT5s4TYN/mJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaQoUjQAKCRCzu/ihE6BR
 aBZ8D/9GVrJnnbshf40Fq7EmWfKlSWadlwmZGigXl4snbvnPs6gFtD53934e9ydLgHRjv8u2HF6
 v3RetY0M1wonst8EpeN0+FuNakSthGOt128Yc+TgylDcybfRojzqe5x5QgzXnKnd17rLN4PRzZk
 b0uo3WfdvbegZCL6sTFjVIRc0186+231PoH/YXcwJEM32ltp/EKPAB3j26sIfQ6Fx7NJLkHbFhm
 F0YXJrGbjLkV8KYRV3xHTdDNTqZ7w/HZ2VZh69brnZptYURDhXlRehZR6/iZq5Qjt9dc1sKvh7o
 zTjZNyJy0LOeaxee4dnnGR5EqhiFycYqxrz1mXeb511qqn5qqrY6iq2ZAtSoF0gdcnkpkTpR6F1
 UzEJ3AVHAD8zoRwTv6u/EZ/pVyedM5nW0h2xCEx0tBZsGBjyRdPBrrZs4FHx03p8Glbo/dE+X/Q
 Islzg5UV4NnsdWM1pfAzZNzp1+frZq7Yz1BGpKUos9oGDmN+7qeiLqf7zQfmOsUa+EQLvevVbc/
 epSm5KUSSDLiBoNrTzmlXBjIwLFppBBuKazNuQTwja4J4ic23JMayyaGURMTtslUOr5+V8J0gkE
 DRJCYzq9mp2tk/wJmUWZ7jYqJfO+y3+JvxR7ZGYT5mLfLscGKy1XEiRu7tcjejTqLhGeskURnWB
 dpxZ04FL3Fn47qg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The CLOCK_COUNT defines are not used by device trees, only by the clock
driver. Keeping them in the DT binding header is frowned upon.

Since they're being moved to the clock driver directly, drop these defines
from the dt-bindings header and only keep clock IDs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Add this commit
---
 include/dt-bindings/clock/bcm21664.h | 4 ----
 include/dt-bindings/clock/bcm281xx.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
index 7c7492742f3d..7a380a51848c 100644
--- a/include/dt-bindings/clock/bcm21664.h
+++ b/include/dt-bindings/clock/bcm21664.h
@@ -21,12 +21,10 @@
 /* root CCU clock ids */
 
 #define BCM21664_ROOT_CCU_FRAC_1M		0
-#define BCM21664_ROOT_CCU_CLOCK_COUNT		1
 
 /* aon CCU clock ids */
 
 #define BCM21664_AON_CCU_HUB_TIMER		0
-#define BCM21664_AON_CCU_CLOCK_COUNT		1
 
 /* master CCU clock ids */
 
@@ -38,7 +36,6 @@
 #define BCM21664_MASTER_CCU_SDIO2_SLEEP		5
 #define BCM21664_MASTER_CCU_SDIO3_SLEEP		6
 #define BCM21664_MASTER_CCU_SDIO4_SLEEP		7
-#define BCM21664_MASTER_CCU_CLOCK_COUNT		8
 
 /* slave CCU clock ids */
 
@@ -49,6 +46,5 @@
 #define BCM21664_SLAVE_CCU_BSC2			4
 #define BCM21664_SLAVE_CCU_BSC3			5
 #define BCM21664_SLAVE_CCU_BSC4			6
-#define BCM21664_SLAVE_CCU_CLOCK_COUNT		7
 
 #endif /* _CLOCK_BCM21664_H */
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index d74ca42112e7..0c7a7e10cb42 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -27,19 +27,16 @@
 /* root CCU clock ids */
 
 #define BCM281XX_ROOT_CCU_FRAC_1M		0
-#define BCM281XX_ROOT_CCU_CLOCK_COUNT		1
 
 /* aon CCU clock ids */
 
 #define BCM281XX_AON_CCU_HUB_TIMER		0
 #define BCM281XX_AON_CCU_PMU_BSC		1
 #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
-#define BCM281XX_AON_CCU_CLOCK_COUNT		3
 
 /* hub CCU clock ids */
 
 #define BCM281XX_HUB_CCU_TMON_1M		0
-#define BCM281XX_HUB_CCU_CLOCK_COUNT		1
 
 /* master CCU clock ids */
 
@@ -50,7 +47,6 @@
 #define BCM281XX_MASTER_CCU_USB_IC		4
 #define BCM281XX_MASTER_CCU_HSIC2_48M		5
 #define BCM281XX_MASTER_CCU_HSIC2_12M		6
-#define BCM281XX_MASTER_CCU_CLOCK_COUNT		7
 
 /* slave CCU clock ids */
 
@@ -64,6 +60,5 @@
 #define BCM281XX_SLAVE_CCU_BSC2			7
 #define BCM281XX_SLAVE_CCU_BSC3			8
 #define BCM281XX_SLAVE_CCU_PWM			9
-#define BCM281XX_SLAVE_CCU_CLOCK_COUNT		10
 
 #endif /* _CLOCK_BCM281XX_H */

-- 
2.51.1


