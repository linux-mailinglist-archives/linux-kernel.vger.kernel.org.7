Return-Path: <linux-kernel+bounces-746602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33647B128CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1D4AA5D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6A8202997;
	Sat, 26 Jul 2025 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O23NiokP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47A1F8677;
	Sat, 26 Jul 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753501132; cv=none; b=p4ZcX4dS0SchWc/e/xxJKY+b2NZM2Xdbqe9Dx0Au3Ak1HhENERqMkouZ/RBf583nWWuNpSOUYYRMLX/ddNI2qE/rWgb7vF2jHR4K09iwyUUAoC4B4OtRZV9JRmmKjIBnyZJ0yWrnvPCVtpCUkPf6Cje2I3dspjE6+Q4lwwY+5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753501132; c=relaxed/simple;
	bh=gBtYcIpRgannJPNmx2mAehywLv3BkRKGhJDDbTI0CHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssh93N0Bje1VqNtJhYxwWEpVU06LmDgxFbcuA/9aZOx2AGWB6joGFLuOdnlyiqdpviC4SgLZh8am3lDPwpkjmZaltwj8qNmdXtLQudouNaono1kwRQWOdSx/9dy1Fbww0KcTbub/A7aaFP8Vk2oYqeJr9tpRNILXopB9wY/j4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O23NiokP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748feca4a61so1740971b3a.3;
        Fri, 25 Jul 2025 20:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753501130; x=1754105930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhAfEUFpjFMraUwyhkD2ehWMmDnT/QkqkKRyhC8aN2s=;
        b=O23NiokPh0BXbpbtO+xZKtry82Dde3kcG9xu3QLiMohwGLHt1fccBNXzi3S4uel96Z
         8VWbTj6SEM214BYd+Ct83hB0AsrR6ta+dH88u0Wr/PKYXTCv8EEN0OaAAjwkcYgSbaXP
         eAmuOZWKG264SsQVSxShcebmQZlsvq1K++hbFS4M3KT26qYC7Ke1OWdi8qVJ6jdpRAeL
         j4ci5R571CTUG5L44z8+2Vh9dr2b7m72mMtUCuFTlA1FzLlI8gHRU7eKYxH6/KzFmyZK
         b/uTBLaLhBtp0rqXfekeNWEbuV5LfMNg5/3DNGWIYHzL8Ogw5udWM/ws5lxEZF7lr86Q
         pYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753501130; x=1754105930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhAfEUFpjFMraUwyhkD2ehWMmDnT/QkqkKRyhC8aN2s=;
        b=Axtkgv6Y3NpnFxMb1ezTbNHd4My4+YPZmJAOg2J07r70HoOW5DW1lc/8OnKczwesZg
         6w83z64571obN5FJFwy5cPuS4p4AnWXWwoQvXUmza+azyW052vBfFKsEE4kK4JbFAUYm
         Oho0bxjy2swEQlckuOgMJ6CxrVXt4OYuz/+er7WMZc96ckWyd9YEl1A5hZ24EYCPjwDV
         HjScSa0CmereexgjZhQfzNtBo1ouGVR96PtdQOOSvonGtQLJbmG4G0YY0pyCxMyaa9T3
         cPokluQsn0nrUXfU2PPFKeRLKL2jHnblRJEHJ4egzcQhrhNLWbS2lOoDk5BW4aUD10FM
         r+RA==
X-Forwarded-Encrypted: i=1; AJvYcCUhormHRQnpuz6fDbKNl22g777Htp4Sglrn007RHzzVSFoZM23hokYAxrFKdggRWy7Oh92dFI3S8Fc/MsM=@vger.kernel.org, AJvYcCX5AcKS5KuN7ciZ7Eb9dsri2C59ICYm9IglJAS3fTQdDWef444vOMmQPtok9gL0DWjaMtPmWUG8SVA=@vger.kernel.org, AJvYcCXM3u7oyUvZWR/el/1fvzIFFGlGtZSJHSJWABKVa6/YT4y28dAxM148+HrWAbzeyGWip2vb2PxeszTDcg96xOAbP3IH4Q==@vger.kernel.org, AJvYcCXRoXbh8iXoxRNf3yC3cfikpqV7RB+uWxdcUhdTMwTN0SkEUqsb49c0TWhkXxfkDZWfya5JX8pMMd4iitn3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5hF0mAkdNd9jaaYfVA/5rgag1v09y7GWdMIHxaybOJo3zAxm
	xrWuQ/aZhhzAarRS4oSy6YvXTm9ksfI5bLLB9dZxxivwMxM5TcnAlSlF
X-Gm-Gg: ASbGnctMEkozAdcFMvH2XwWDEnrzzQsC1y2uZREYrjNIn6dYJ+qa9Rg+QkgMFDx2vlT
	EBiUCCf5cOcfLuQye4XJUp1ovHB/AtinC1hb0qsFkgx4aTw7MBxoZXtCpF4nnx+5AfHr62U87vG
	GjZ/9P3uQciUyEAYHRRz7qvHCMjVAJEU6WtvSH+kJdLNJKzjWtLCxR7yemIqsiZoaj6uiDydGuJ
	OA1+/YH/Oq1aiRYMcJJyiZ7B6/HTZZSB12b54MR10Mj0UZYWnPDC94f9G8MCcdi0fDjGBk6SYE2
	Uey4dgnEaUABMnXdlsCIIDCCm4EKuBVq6wLMYGQQ6dyFnm4z1yfxy4z4yXQnj+FfBMDrbnTwbye
	J+a6TOYaLM7ExcjtvHgYqZkzWeZ1qq4fXEFSCW+ekn1bjQw5yw1OGkdj9dNy5zMcpg4c+kgbHKG
	nNEA==
X-Google-Smtp-Source: AGHT+IEOI7ZTSmj8OclQ2OLzg1WH0d8Hd+3i7+/AURRay8pA5DXbxcWgY34GMcmdo6ZKTuBheOpKfg==
X-Received: by 2002:a05:6a21:62c9:b0:23d:781f:1516 with SMTP id adf61e73a8af0-23d781f2791mr4979045637.22.1753501129715;
        Fri, 25 Jul 2025 20:38:49 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832f8942sm779204a91.4.2025.07.25.20.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 20:38:49 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: (ayn-ec) Add Ayn EC Platform Documentation
Date: Fri, 25 Jul 2025 20:38:41 -0700
Message-ID: <20250726033841.7474-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250726033841.7474-1-derekjohn.clark@gmail.com>
References: <20250726033841.7474-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds ABI documentation for the ayn-ec platform driver

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 .../ABI/testing/sysfs-platform-ayn-ec         | 59 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec

diff --git a/Documentation/ABI/testing/sysfs-platform-ayn-ec b/Documentation/ABI/testing/sysfs-platform-ayn-ec
new file mode 100644
index 000000000000..cba68b0870ea
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-ayn-ec
@@ -0,0 +1,59 @@
+What:		/sys/class/hwmon/hwmon[0-9]/pwm1_enable
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
+Description:
+		This sets the PWM fan mode of operation. Valid values are [0-3].
+    Values [0-2] conform with standard hwmon operating modes. Value 3
+    enables user defined fan curve settings.
+
+    Applies to Ayn Loki and Toctoy Zeenix lines of handheld devices.
+
+What:		/sys/class/hwmon/hwmon[0-9]/pwm1_auto_point[1-5]_pwm
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
+Description:
+		This sets the PWM fan duty cycle for the given index of the fan curve.
+    When the temperature reaches the corresponding pwm1_auto_point[1-5]_temp,
+    the EC will automatically increase the fan duty cycle to the given value.
+
+    Values are [0-255]
+
+    Applies to Ayn Loki and Toctoy Zeenix lines of handheld devices.
+
+What:		/sys/class/hwmon/hwmon[0-9]/pwm1_auto_point[1-5]_temp
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
+Description:
+		This sets the activation temperature for the given index of the fan curve.
+    When the temperature reaches the given value, the EC will automatically
+    increase the fan duty cycle to the corresponding pwm1_auto_point[1-5]_pwm
+    value.
+
+    Values are [0-100]
+
+    Applies to Ayn Loki and Toctoy Zeenix lines of handheld devices.
+
+What:		/sys/class/leds/ayn:rgb:joystick_rings/effect
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
+Description:
+		This controls the display effect of the RGB interface.
+
+    Values are monocolor or breathe.
+
+    Applies to Ayn Loki and Toctoy Zeenix lines of handheld devices.
+
+What:		/sys/class/leds/ayn:rgb:joystick_rings/effect_index
+Date:		July 2025
+KernelVersion:	6.17
+Contact:	"Derek J. Clark" <derekjohn.clark@gmail.com>
+Description:
+		This displays the available options for the effect attribute.
+
+    Values are monocolor or breathe.
+
+    Applies to Ayn Loki and Toctoy Zeenix lines of handheld devices.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b816883fe7d..199bebbffa0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4039,6 +4039,7 @@ AYN PLATFORM EC DRIVER
 M:	Derek J. Clark <derekjohn.clark@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-platform-ayn-ec
 F:	drivers/platform/x86/ayn-ec.c
 
 AZ6007 DVB DRIVER
-- 
2.50.1


