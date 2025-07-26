Return-Path: <linux-kernel+bounces-746872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE96B12C51
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F77C1C20D03
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E328AB10;
	Sat, 26 Jul 2025 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRoNUg4r"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79628A1F6;
	Sat, 26 Jul 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562453; cv=none; b=V5kFmR0WeX0J0NaJNva12vD1GLTTvXGb4aMz80PhgJ8tIExSQW8Th5uRerxIX9wypB/FFFUDofrh0/D2oDImjPPZYYdIC9DVhPyVhHj2PssD+L0xOgNDUuu/0WMSItGkX8eyspCOS/Ud5lzR+owJqt0ox9pAuY9t1RmdecniW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562453; c=relaxed/simple;
	bh=Up0KWTi39BtMHH0ZAqQexxhhMWXhXR7CZaMKH9IbFfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY/h6igW4jnt2DeqOwENHfqHbPsOZTNBmGVXRctRIEJuko8lzNQ5FNaREfwj9CTmbDBOZHU9iSdBrHcRlyoWEK2Ezq6orkP2v87nWpuPb9WJ/e8yLJGYi19JlS94E0yMiTK9VP2NLPK0ad+IWF/iTgpWH/AVo8/pY/lulrz5838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRoNUg4r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31d489a76dso3354315a12.1;
        Sat, 26 Jul 2025 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753562451; x=1754167251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxRXHDITuTEc5htofRaO84OQpguHqwXeLPIWvWejt0I=;
        b=lRoNUg4rM2amOk+/kZIjHNA3lBVHsbkWqTwuBvg0Ji4RTqnkN0mI8pvi+7Ec/MCEQy
         A1SgWlvVWnRZ7NEu8hoxkd40/JBXBsdmkB49l9rRJWxSSimt6FBQqdjqn0HhgZM+8yub
         wEnxDB9mP5/hHPlbMHZ4hWfe4mF1Zp6g896fPmyJxfnDtynTfojkH0L7lyWhXjwctYQo
         mbD4Qz/SQXLZxv4AwjKzPOL64xg20x+02lj4XNSFmtWZKwJJRI2uPJfyz1Y8uUwjmYIA
         YM/eJ4HtdthDmXpIfuLpNViZ1RAIl94a+Ug+uL8Lk8dicoKCiBw2qqXwO3zBP9Hp+ygz
         c4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562451; x=1754167251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxRXHDITuTEc5htofRaO84OQpguHqwXeLPIWvWejt0I=;
        b=KlfAYrGfxvdPfXc7bLnaiX63Kg4ScBfccqCjCMzK5n8BCTa7RAi1KLDQJZM2KmY2/J
         SIBx7BzKRJ8fFRPh1PsOyPVNyoDKZz0qNbtxoBFMvgCvnxhe1yokUF6DtkmzX3l5PFv7
         MGXnqvu2AI95Aha8SvxpZxaZUOtNWHqZA/Ya4uaZfWj6SKE6BgQ9DLjH2nK6QF5uU8IK
         ix3RyHCk6km4WTnjzHwLl5/y/QHOqPvGo5tYCS+AGND7YPQG9PTDMKNoIQffKzMkF5WU
         v6NKfhcSetSE6G0m5wZYNBd9xqM0t5fl3EGw6b0nbp3OlaYxGtXbNRkAuYaCJgLZnUgj
         4QEw==
X-Forwarded-Encrypted: i=1; AJvYcCVbftdyL4ic/mf+h+UndArti4pfbtt6heeHaHenb9V6moYpTM2VkrdlvMH8XuNVyfl4xudVwXAqa1lrXIBu@vger.kernel.org, AJvYcCWrvcL68ppUOO5CWFfgMy/MXxCna3htleO3fsZWcjdWsXWv2ul5WOhWRpcmUHyhL1TQLWVQVx14+fjdBUhCeZoLXilUHA==@vger.kernel.org, AJvYcCXQM84FU5oVZsWrAPWHB1s6KGXHt6HW4+1Ce76zWGLkIUdvwZjzOIt3oc0znv9fW7X3cEsnrSlEEk0=@vger.kernel.org, AJvYcCXYqnaEEgxoE8py9Dn1Lk/ok0g7SiSda1E7G3AdB4GwuykbB4TRHCBU54pkyRu0QB4/prwG1VE0/ayqB/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCo5cWY6ZJ83qhWOYez3vyYLj+QabTSDaTFoZ5laUvvaMCpDZ
	M1Y2R3WAbbsCa+QNL/nAPEGHjAHbv/WlXFkdtmS8gPendx+Eo/cWmRob
X-Gm-Gg: ASbGncvCs/0mLW+VbRR9A7MJd/E7QBQXobE+BGJTJZuwiIM6TSHEnQxvZlxv5hrbIi2
	nAenXXuBN0mAHPkbe6GgZegiLlRUR40A2I0pQT2o7OJZGi76vomMJB/tL0/SiICH/FYmTSbawgW
	MfQa+coiu+Eey0+CMVIgrYw1E2lci6CY7ZEa/xJhxo5omBa8xAMVlsyg1TD60hy/wq+hV7WYAIg
	x/RcV0X/sctPSPMEh3EHiqGo+S/dpX86aKQBer9Efou0flSONsBWA6bYLjpTJoz27bXitM3X97T
	FiuKImf31E+m05IhGI8F/uKXvODTeXJPDC+F8x6Mu54rsQ+XZfZWpkKr9oxB6vBw/szrDCDYuFe
	RElfU7SZAxETiXU6RGAaVdgdKcKvYKCjQg54W38IMlVRLyzw0kh3isXcAKnCTNhBRsXPrOOr3cH
	3XmDXqG0vwEhhP
X-Google-Smtp-Source: AGHT+IGNZt6fbjyLeCK8wPdjfn9A479/Rzeyj75hewbRmiLLjMVu7D6q5V077Te4HEmqxqrYakPk4A==
X-Received: by 2002:a05:6a20:2450:b0:220:10e5:825d with SMTP id adf61e73a8af0-23d7005260cmr10666498637.8.1753562451255;
        Sat, 26 Jul 2025 13:40:51 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8ea37b21sm1905640a91.22.2025.07.26.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 13:40:51 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Box <david.e.box@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 4/4] platform/x86: (ayn-ec) Add AYN EC Platform Documentation
Date: Sat, 26 Jul 2025 13:40:41 -0700
Message-ID: <20250726204041.516440-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250726204041.516440-1-derekjohn.clark@gmail.com>
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
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
index 000000000000..32cb6f7ca2fc
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
+    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
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
+    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
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
+    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
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
+    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
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
+    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
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


