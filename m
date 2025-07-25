Return-Path: <linux-kernel+bounces-745131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FFB1156B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15024AC72D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228519D8A3;
	Fri, 25 Jul 2025 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkzKyP8C"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4E17A2F6;
	Fri, 25 Jul 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404342; cv=none; b=HbIS/TuhQ9Cdhc53ZGTisrIMvJgx5xLFg0M5OFzsoD2L1A7LuLP0bVwuPYNZUvC4F6J5tBJS73g0YcYpg+nl1Et86CbyHCle0+DciUIDlHsi7J1k5IktdEphnTM6r6l9I6TpIpX7JPA7h9Y1ngwkYDMimVTAUcisFls/3OvSJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404342; c=relaxed/simple;
	bh=9t82C+g9ckuHx0BUESPF21TVWLLrrBTGWM8vovu3Wo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCYWr7x5BNtzTMumO2I5HpCajqaisfPgxpKdRwKlOmeU7bMPGEI3cgnAsMc/oRbuuCAmPlOf6H62mXf6nnhFWE0Mb/Jz9x0/NjZkxf1FALm3+87OSZYAkL9moHH6C7cGhHWTZLBJCESCdEr462AfC0UQJzkUx60svVTo2jUufLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkzKyP8C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235f9ea8d08so13966955ad.1;
        Thu, 24 Jul 2025 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753404340; x=1754009140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeTEcyYrbMRbVBbvqGHkYmi6U6vTKnqCNi4nFubmY0k=;
        b=JkzKyP8Ckz3AuAlqGy1etfWJ4qAQrNdnfy9UxFMxoBBciDa1/zPjV7sjIxDr2zK0e0
         H6UoFQ+RqhkOderpiPF9LWQEnMfUe6NeteJ+vGKpK/AeH3N3C3fM7OwRuO+NRoxWJpYu
         t1UiNCUIByiV/X0XPpC+hWjnaWVHGHXYVRDtH5PYDT+/S7RoU6LqAB4VKKSRdhVgXdxN
         fLho7ILUGlUvF6cK/u3/JmXAa8WHwEBqgpPxKaX3FWoX/pqsa3mUf/mH9U+dnFV8W68d
         Vg/14xt1uJ7/kXhSiz5kRZt7gvODf0arG4AMR/kjiRAuMEMcf9nSAch2auJJygUT/nVO
         pI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753404340; x=1754009140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeTEcyYrbMRbVBbvqGHkYmi6U6vTKnqCNi4nFubmY0k=;
        b=ZVgPyENK8d9+s5w31inECbhfTEcZlnEM8LsXMtj3xC/x0zR0ziirrjdaOUSSSE6Vy8
         7eP1m+TIMrAcNtBSdSWSxK2nIqyD8MVttrm/jjU0Qz+ZwMHQSlYr1fD4JjFtKlLzQNW7
         GNVIXOgstQkfZXod/Q0iKWl47luaTbd74T3MQbYnXk4p6mNKkUh+XEiOA4NJokQY1KEn
         62cMvCNVhgDc+OS6kiUQ9as1WBj/jNyrlnah9st50TDh8wXmdxRyJBhnJfHfXTToxl7G
         aJ5jQ9h78L5VOfaYaNT7cMeFNbUHer4Pzv27ur2oHqlbWK42Mh92dXrZUVsEtd4e0RYf
         8DBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVex0YihI5o7G2bs5vTjnv53GuhRLNubpJLYRirDkRwiLemHYFwWXcc2t+uQL/rxiyUsKrVGWrdeT4LNVOLL3rX3KmHCA==@vger.kernel.org, AJvYcCWl/nbnuvqef7sLlEJw7HXXou9Hsrm9c7f6G8V3svtK9oTVOgBadjxUhr/x6Z753nCQpiTjI9LPHdcRWQ==@vger.kernel.org, AJvYcCX2rmAyqcNbblqiXVYLi+Mqh+EWoDaQucJFg0i/xAj2ho7RIeA9lVhjJJM9/h4NVCDUZUmhlxzpSaNihCto@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Vgpb/kkBWH6zmWfwflvHCKwm6ueqJbU731Q21JjDsi7+U/md
	Px/k25u4+DGRhe8A5xBD1vupaK2NTSaZfFo1/SpxzpKxdndUDtXh4IG2
X-Gm-Gg: ASbGnctdVrK8Uk0Odvv+zwRXS0GRhmL6vE31o0s9oMIgfKBUABq8cIEVpkJkkOfPh79
	lhHtfyYUitrUnjmWn99bNqg+P71hQ3Nim8LiMsZQn5EW6Vmw8OjkUsTJnkrt6CtHVUtgaCV2d9L
	QGvercyMlJSIyJBiHPe2l71bJ200ISMClHbb6fh3LU8Vy+CetmTYCMgndsbHofmQZq5Y64StSOj
	dG/wqPSQOWrAVIHb/lELPYjykOC9OCFj8ScAf9QpH/rG1glIXbyQYeSCTD3ZL+LuCEwoRPFEgVU
	9PEt+DknNXZz4bDZVlDKXarbV3SRVlQJENOyKG448ZzqVKm7s6z3VQvxGkbSxXV6WXHzamLYJsy
	Bd6siSajprePf6kPrNSD5FQJyEFMs46TedP1ZxBSFl5SKmyF2GkUC5aiic1fbKrrJgXDabWDdSr
	KIdVvRVwkoi0M7
X-Google-Smtp-Source: AGHT+IHnCxV9A4cfexv15PGFZQGKWLuJCo3q3dpbC+4GpQ1zd4Uv3E/DM8U2rJl7dmIbs6UyrWcKEA==
X-Received: by 2002:a17:903:1590:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23f981ba646mr119037515ad.33.1753404340201;
        Thu, 24 Jul 2025 17:45:40 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4901b99sm24157905ad.188.2025.07.24.17.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 17:45:39 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: (ayn-ec) Add Ayn EC Platform Documentation
Date: Thu, 24 Jul 2025 17:45:33 -0700
Message-ID: <20250725004533.63537-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
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
2.50.0


