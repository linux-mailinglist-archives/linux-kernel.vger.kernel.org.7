Return-Path: <linux-kernel+bounces-870248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2818C0A485
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3663ADD83
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387A267B00;
	Sun, 26 Oct 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5loQGbD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4144277009
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466371; cv=none; b=NNMfnE3DeLojZa3eO/SC0UlmCgJx6y327DyGlrWCHu7+teJijfZ1RO/ymZXjdHmgsJkK158F2pMxQSGZcNGRqQ2BNUvhiUjtNJU3kiFNeUWJrny+JmUc/8DoMXHHBpY7tHdK9aHuL5yX0zr//DTutdZ1t7Sayh6x2ktvGWhEZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466371; c=relaxed/simple;
	bh=KNQiFIatDFDW/ugWS3KsTuNPGeunfC6QHOJzplAW0hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5dOukO76p6PXR5nrb8qzNlI8Vm/cjY8oLy2MjdmIXt94Cgug4PGIbFNI9PJT48gktey/QwINUY5JUFxaXQoSqcAHDbjLC0cT+Km+K7RUsnmRjGb81FtE7WhgVMKKKoaRdylI4a1XM7KgOmWDuQzPj8plAuqluY/j43B9s04ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5loQGbD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33255011eafso3390024a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761466369; x=1762071169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I04xuq3ZlAMJMmWZbV+GGOpvIwMx+dHIGrDI5rSwvUs=;
        b=X5loQGbDDPfBjYea5QXDpUQFoe52Lst5nPJrhMmhjjEjmvszhCEJa4ThyKczkUG+lF
         R91atu1/0k8znmmAbZRsbrf7Qm2e+U7KDZlG/sT+R/DKy541Y3OJ0I0IB1yQ5udzC1eo
         AsMjnKXMk6LgsaMUxR2FBrXIyEJ23yYYILx8tgNqCDb4vd2Wo2VAVE+fUdXhQ50w++S8
         kHYItCLyx0d8eWVZPZSWt5Hc5WK1Y2BNvepNEhlJtTjgpty0gyjk5AfiG8jQJYjWSSfU
         kQpA4StoDpQfnIuEG97PWherfdgBNsQ9nxWZG+3Ssfl/aje9ynEXqFjH4eub2SYOxZ3l
         5THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761466369; x=1762071169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I04xuq3ZlAMJMmWZbV+GGOpvIwMx+dHIGrDI5rSwvUs=;
        b=Ia6YixvT7wM8q5cAbeV3DmESP98PGcU85oSxtuqoOZYPjxXdofkY/qP8nCU8Py1PYe
         D1ElNOgs5ndGQm72N4q4LwwTgDKRTuIYbeScH0o9SH8hE92W6ESZd61wKdHFPPKPzpKH
         qNybgxty7dU9RFoTd2C/2YxtDCbciVps3G5AtINhcgkOl/hiDXiUUlq60sgAuSpZguiL
         TFWtM0HsOTXa7DRZx1p8np5HEMoZhPd77AgGoj0At2TAIiMWPnGs71XDljKBzvtQ/L2+
         HFvM1vNPnD9i/rqg2aNsIjQhrW9HyLoZx+kNULsrqA0m/9UTNZqyd9c7JTvtyhueS2dK
         dHaw==
X-Forwarded-Encrypted: i=1; AJvYcCVLYQh1VSOE0zwaV1/McxDei1evWXjNpwMz7Or56OHw7yRcU30omLhjGYtzeYAke+YenKnMYD/m6Y5OFHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDq+bc0gPqWRp6Hk368uCB9G9Zkd4oO8EXwnW9A+uyzGZ3VQuZ
	GXJDO2Wowqfsia7sMqougHkrZyVFgbIBrK6AChlBQ0b5XPXmqyfZgvav9e0P0Csx
X-Gm-Gg: ASbGncvDyXOJpiVtnANRoSsG1His7OGM6v9I1X96zanJDLggkaysgTuHnk9UkTScJ9L
	N9MBwmhDz7OwLnIiz8iz04sb/mJ3wAGfEPXo/wq7pri+xAvzQz/pafEp0b7u+bQGtgQV/NADD6f
	dRpAbBPGzIciBpjwDSf0X7CJJMTnYMY2lesPBSuFeOkSqk1F1MsepkcqAbmDLNrMJsyGSXHve/8
	BTBTeSDrDaroQNi04CEeDV8+Y289lX/6RaRxys+XsM5lDIl59C+K+pBzDb1dzQ9dm7rJLkeavSB
	IMLfVYqxpKtGUueXILSNWkl3v5yHrpsHJnAg8CdDsZi3HxZ5AsxggDHoWGd31m+ludyLu5skp6w
	RBTQPSV66yUgGoddTfOTyn77uReiYCyxSjWjl4r7YWbSC8sozfYYJu/MRweMflynO7fbqLQ+fad
	GH1rOnRSvvvSg40ECGXZMxVUFkPBjX66D1RbwpCex/n66qFKQH4FfzSuAmpxuidbw71Z4=
X-Google-Smtp-Source: AGHT+IH3N+rTZmae0YIHzKhUxnKjJn04vmCm4zs9XWx4XwHFbqlNVNo4C6bScayA3iX7peruw5FJSQ==
X-Received: by 2002:a17:90b:1dd2:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-33bcf926c1bmr40699771a91.37.1761466368907;
        Sun, 26 Oct 2025 01:12:48 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2374654a91.0.2025.10.26.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:12:48 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: [PATCH 3/3] platform/x86: lenovo-wmi-gamezone Use explicit allow list
Date: Sun, 26 Oct 2025 01:12:40 -0700
Message-ID: <20251026081240.997038-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026081240.997038-1-derekjohn.clark@gmail.com>
References: <20251026081240.997038-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stubbed extreme mode issue seems to be more prevalent than previously
thought with multiple users having reported BIOS bugs from setting
"performance" when using userspace tools such as PPD. To avoid this ever
being possible, make enabling extreme mode an explicit allow list instead.
These users will still be able to set extreme mode using the Fn+Q keyboard
chord, so no functionality is lost. Currently no models have been
validated with extreme mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 10 +++---
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 33 ++-----------------
 2 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
index 6c908f44a08e..79051dc62022 100644
--- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -31,11 +31,11 @@ The following platform profiles are supported:
 Extreme
 ~~~~~~~~~~~~~~~~~~~~
 Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
-enabled in their BIOS.
-
-For some newer devices the "Extreme Mode" profile is incomplete in the BIOS
-and setting it will cause undefined behavior. A BIOS bug quirk table is
-provided to ensure these devices cannot set "Extreme Mode" from the driver.
+enabled in their BIOS. For some newer devices the "Extreme Mode" profile
+is incomplete in the BIOS and setting it will cause undefined behavior. To
+prevent ever setting this on unsupported hardware, an explicit allow quirk
+table is provided with all validated devices. This ensures only fully
+supported devices can set "Extreme Mode" from the driver.
 
 Custom Profile
 ~~~~~~~~~~~~~~
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index faabbd4657bd..0488162a7194 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -47,10 +47,6 @@ struct quirk_entry {
 	bool extreme_supported;
 };
 
-static struct quirk_entry quirk_no_extreme_bug = {
-	.extreme_supported = false,
-};
-
 /**
  * lwmi_gz_mode_call() - Call method for lenovo-wmi-other driver notifier.
  *
@@ -241,31 +237,8 @@ static int lwmi_gz_profile_set(struct device *dev,
 	return 0;
 }
 
+/* Explicit allow list */
 static const struct dmi_system_id fwbug_list[] = {
-	{
-		.ident = "Legion Go 8APU1",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
-		},
-		.driver_data = &quirk_no_extreme_bug,
-	},
-	{
-		.ident = "Legion Go S 8APU1",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
-		},
-		.driver_data = &quirk_no_extreme_bug,
-	},
-	{
-		.ident = "Legion Go S 8ARP1",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
-		},
-		.driver_data = &quirk_no_extreme_bug,
-	},
 	{},
 
 };
@@ -278,7 +251,7 @@ static const struct dmi_system_id fwbug_list[] = {
  * Anything version 5 or lower does not. For devices with a version 6 or
  * greater do a DMI check, as some devices report a version that supports
  * extreme mode but have an incomplete entry in the BIOS. To ensure this
- * cannot be set, quirk them to prevent assignment.
+ * cannot be set, quirk them to enable assignment.
  *
  * Return: bool.
  */
@@ -292,7 +265,7 @@ static bool lwmi_gz_extreme_supported(int profile_support_ver)
 
 	dmi_id = dmi_first_match(fwbug_list);
 	if (!dmi_id)
-		return true;
+		return false;
 
 	quirks = dmi_id->driver_data;
 
-- 
2.51.1


