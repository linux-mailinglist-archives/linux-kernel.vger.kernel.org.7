Return-Path: <linux-kernel+bounces-889405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E126FC3D7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FEF18889E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F83074A0;
	Thu,  6 Nov 2025 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZz7JGLg"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617030649F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464089; cv=none; b=XvFdWlL1w/l9ZL1l+xOCMAmH3SjEPcFDCgADfkeQypliEgCJVd/ecCWptwFibz3NbTV0u/eubut0d+exghfAMGr4kw2Q4N33q+XeGqEJkkVJntN26ZGwlG4s4y7Zvu+RO75588jet2b2jfvX7CTgQ0isotnFbSRaCBxXWQEI6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464089; c=relaxed/simple;
	bh=o1D+74u0jESsgRq+dEc78taFi1WVB7FieTFi9hP+7qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vwf005KOwXZEmuiJsEjIvHyuLC5EjxFOLrK+z27800M9V4IvGDRZTQ2vyKTN54zNz87MLwCljyinYB40rYJjMcXcP0FoYh2n7MhWIvU5dAKUF8yqAsUKzGPgG3dfhASAVMDcXDoDYnTxDmRzdp3vcICJdkOfJzyUGOjDd5HWf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZz7JGLg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so102137b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762464087; x=1763068887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X+nWVGtuau23CQKffdOvJt/AKrk9R0PxqKgoXH9rgI=;
        b=CZz7JGLgrwvFBipA8YIXNsJw6H5Dh8NlqHK66836nnD4BCUTI9zWYdaSJVJkvI4MuB
         sefHj3tglvb+RNHyEwIMVIBQuJ2RYlsHeUtG8N254NN1okMMIMqD+bEeBJoShnAbV+E3
         ikK7/cuKtyFR2KH/XchCjDiE4jg8mb0frN7LGNFD1pPatKqGZTgocG+JIH6oU8CAP6Nn
         R0CFAp1d45NbUvsRVohKmw/ezH+jFjmX2WBeijgrPkbOtPUoUGjSvO8YVCkaTefbi7Fy
         sYlrXZdF9q8s/1DEvKEcXpOFP2uYjiwTLWio2ppi9Djnbsi7hbfvSMqQXkUR5janDTFV
         /65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464087; x=1763068887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X+nWVGtuau23CQKffdOvJt/AKrk9R0PxqKgoXH9rgI=;
        b=I3PxdBndfKmre4d4oDvG36f9lo6MBBwx1Z07KB6Pqg5REjf+E1wQa/u53SGvysBM6x
         l7tQW70rN8+6x4B14wXZWbPKJSDiZZrDUj62ttQ6xAOmRf/Q9kLWu4dDo1ufjuOIv1X1
         SaRBt/iXm1yQtgErFYyVUV1Wnn3xc7nlUmMA/JXyvKnF5KPwKZ0XRM//MWkXZgyDJVWj
         PbacCm84MWwIVs+ebiMGAJsTZxxLrSCfjGKtRP2cm3ruHu3zKArpodHvWgbQ6Xc/cd8W
         ur2n7QwJiYxacV5GV+61+UFnCWRU9ClS5hpfPUpzCH5PWIC/dUyuQcgOcc8HUVxgK77J
         8V4A==
X-Forwarded-Encrypted: i=1; AJvYcCV9hiVXm8ImKBbKQZMANpWyYMtzmFG00PpXX3eVKvkPnoASUJiaaGezprO/wpidxMsrfsWSej0UPd4ERjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/GStaB57HDSJiSywvZKH4UH3pPGrGYn5YC4azK5oIasEfLn8
	lc03ldI6wPnrKlKH5sEp2VAwZPDptJFeZLK8mgz3iWf/7R2t3luKbIH8
X-Gm-Gg: ASbGncsWDPuotvUhhesmwdVztaKmFJHsPVoiGLvrkEBy8EiliaLix7E3bVsmJpAooVL
	PjSiHouXOheH6hlhrzRb3rco6Ox9q4vVU2qgMY8phV+CHrgQFiWJJWb96TiNWgyRLqQrUkWXnAt
	p4pRW5rDZRVAbWV0TUbRq4VaM71ng5356t3c3k1HbUyxpOHmZUzttDg4HhWR2IeGc/Kfgn+iN7n
	Gf5kI1O3lmgeVtPp9huxM1/lnCa63XPCKoGl5JoH/khT0w+NqpNtQlJbZTJ+xCIkn4G2kvRCHoT
	5vuAG4LHN9IJZArgojqOixffvBU3b0Lq5Yz1rjUmj22rn3X09rkVBZAUw0uKlE6eIHvdZg0DXGo
	jmeBu7woZe6U5Qq2L5Sz6ljnd/gNwFi76ytf3CG2puRo4jiopWSCxih5Xj7AL0PjCl4hA0dw2vT
	I1CTZo93SQ4OrYg0e/ni5TmU6spRZrAXRHUZDxiXUAIww05OQjG6ZOLzeI
X-Google-Smtp-Source: AGHT+IHR8+vSxHEsoYKLoeyXM3WkEK6OcznT73MUUHSpR0cEymgpx8rJkPnHuN4Dr5upn1/aJ1SsfA==
X-Received: by 2002:a05:6a20:9389:b0:342:faff:7a7b with SMTP id adf61e73a8af0-3522b496eaemr1358803637.59.1762464087151;
        Thu, 06 Nov 2025 13:21:27 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm521360b3a.12.2025.11.06.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:21:26 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: lenovo-wmi-gamezone Use extreme rather than balanced-performance
Date: Thu,  6 Nov 2025 13:21:20 -0800
Message-ID: <20251106212121.447030-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106212121.447030-1-derekjohn.clark@gmail.com>
References: <20251106212121.447030-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When upstreaming the gamezone WMI drivers the "extreme" mode was matched
to performance and performance was matched to balanced-performance, but
only when extreme mode was fully enabled. Otherwise performance was
matched to performance. This has led to quite a bit of confusion with
users not understanding why the LED color indicating the platform
profile doesn't match their expectations.

To solve this, replace the confusing convention with the new "extreme"
profile. While add it, update the documentation to reflect the expected
LED colors in each mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 29 +++++++++----------
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 18 ++++--------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
index 997263e51a7d..8fa0a27fc05d 100644
--- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -19,27 +19,24 @@ WMI GUID ``887B54E3-DDDC-4B2C-8B88-68A26A8835D0``
 The Gamezone Data WMI interface provides platform-profile and fan curve
 settings for devices that fall under the "Gaming Series" of Lenovo devices.
 It uses a notifier chain to inform other Lenovo WMI interface drivers of the
-current platform profile when it changes.
+current platform profile when it changes. The currently set profile can be
+determined by the user on the hardware by looking at the color of the power
+or profile LED, depending on the model.
 
 The following platform profiles are supported:
- - low-power
- - balanced
- - balanced-performance
- - performance
- - custom
+ - low-power, blue LED
+ - balanced, white LED
+ - performance, red LED
+ - extreme, purple LED
+ - custom, purple LED
 
-Balanced-Performance
+Extreme
 ~~~~~~~~~~~~~~~~~~~~
 Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
-enabled in their BIOS. For these devices, the performance platform profile
-corresponds to the BIOS Extreme Mode, while the balanced-performance
-platform profile corresponds to the BIOS Performance mode. For legacy
-devices, the performance platform profile will correspond with the BIOS
-Performance mode.
-
-For some newer devices the "Extreme Mode" profile is incomplete in the BIOS
-and setting it will cause undefined behavior. A BIOS bug quirk table is
-provided to ensure these devices cannot set "Extreme Mode" from the driver.
+enabled in their BIOS. For a subset of these devices the "Extreme Mode"
+profile is incomplete in the BIOS and setting it will cause undefined
+behavior. A BIOS bug quirk table is provided to ensure these devices cannot
+set "Extreme Mode" from the driver.
 
 Custom Profile
 ~~~~~~~~~~~~~~
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index 0eb7fe8222f4..faabbd4657bd 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -171,14 +171,10 @@ static int lwmi_gz_profile_get(struct device *dev,
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
 	case LWMI_GZ_THERMAL_MODE_PERFORMANCE:
-		if (priv->extreme_supported) {
-			*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
-			break;
-		}
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		break;
 	case LWMI_GZ_THERMAL_MODE_EXTREME:
-		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		*profile = PLATFORM_PROFILE_EXTREME;
 		break;
 	case LWMI_GZ_THERMAL_MODE_CUSTOM:
 		*profile = PLATFORM_PROFILE_CUSTOM;
@@ -218,16 +214,12 @@ static int lwmi_gz_profile_set(struct device *dev,
 	case PLATFORM_PROFILE_BALANCED:
 		mode = LWMI_GZ_THERMAL_MODE_BALANCED;
 		break;
-	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
-		mode = LWMI_GZ_THERMAL_MODE_PERFORMANCE;
-		break;
 	case PLATFORM_PROFILE_PERFORMANCE:
-		if (priv->extreme_supported) {
-			mode = LWMI_GZ_THERMAL_MODE_EXTREME;
-			break;
-		}
 		mode = LWMI_GZ_THERMAL_MODE_PERFORMANCE;
 		break;
+	case PLATFORM_PROFILE_EXTREME:
+		mode = LWMI_GZ_THERMAL_MODE_EXTREME;
+		break;
 	case PLATFORM_PROFILE_CUSTOM:
 		mode = LWMI_GZ_THERMAL_MODE_CUSTOM;
 		break;
@@ -338,7 +330,7 @@ static int lwmi_gz_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 	priv->extreme_supported = lwmi_gz_extreme_supported(profile_support_ver);
 	if (priv->extreme_supported)
-		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+		set_bit(PLATFORM_PROFILE_EXTREME, choices);
 
 	return 0;
 }
-- 
2.51.1


