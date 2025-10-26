Return-Path: <linux-kernel+bounces-870246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D23C0A469
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1533AD30D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A34254AFF;
	Sun, 26 Oct 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m16Ombbe"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C71D6DA9
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466368; cv=none; b=sYQLgHQajZno+cL3UneaOlHPuHhmm1Nm1kZ8dWZ+LzyccEbMCP/xwIFZVXDTYgLzGozSkS8ROFY/0j228rVF1mSpSELHu2nD2vDBl7oaGA1K9QAtVFD4Dxy1i/Nhq97la09jqNC73vyvnJlEqtmzLK7p1LC1gNjmyvO2W1B9gSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466368; c=relaxed/simple;
	bh=KfKya3ApWAx7jEzc+tOxx/V5zzMsaSdiqYDUBXDK5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL9YgBoztIV8UouB4n3sh3s+1nXkSIsTTg7InvMDFZ6pH1i4Gyxov4lvBtxZ8fjSeSoAD8dxCcreClejzeY6InXpNUZLgDY3y9ZL+3a2XcS3bCIbdo55sP+N8/gEeelUWdrNdlw3m6q0pRuwIb74rKA+Aa6OOjpkAQkH/zWBjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m16Ombbe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33d896debe5so4107514a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761466366; x=1762071166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkzT8rhILn4Qaqc6zAgBKines7TQJhCcdPvDF4nghIs=;
        b=m16OmbbeNBdH7tl0pbdJjpRNXV8H0HXm1gCgoBRdq+n6ayfQK7rksGMNgFAuoDMqME
         5CQIPD06ez00bMznBwkthsCpY4pZBslVg0nTWpNLIp1zxxX2j/uA8jnuWytztXCedT5O
         8fjVjFYKKNKHUH8gbeHsI2GUlwdLcW8TwktZUzZ5zaUoZujAKz8mxKFu3hVEsTZxy2nM
         77e9wnWD6ZBUPdDgYWpoyaibgVmzOF18GW77nlvpevJCUBxqI66VRka0EJs1XRd1zXNH
         o+996Vm+auguJ7BW+ncEib165QwYUJ22Luw8AFUYTUCvJBscn5HaFMy0gKSVC1FQAugQ
         xo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761466366; x=1762071166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkzT8rhILn4Qaqc6zAgBKines7TQJhCcdPvDF4nghIs=;
        b=MmJzHMZHTKaMFU6wZ98qwbuuc7Ohu4dkIQiTapOQB/Qi2FbfyBDIpVMPS0AtYrfFpl
         Q1NdZkCOsNCVofa+LogTc7ifeLSCNqY93XCJAWceTcExLbX8Sz1DVaTH3PPwFeGoXoPy
         JCAtcfAnum2hoCcgjNUU/KDLm/HGUAa2P9Unk8C1+rRKGM0ecfu5E7QvZuKlpDlbJ2fM
         8yhfH+1KzFEeIShFKPxfvVkV0Tr2JIeB0sZ8qDpTMX0MwAzuI/1yIpXSkmnuJjp70rm5
         ia5f9u5RWejGPuP8ibsCq0Arl5xktpwCsY+ymnj/ASfOojHtnxI6nKFbl7HpZuR4eMrf
         usig==
X-Forwarded-Encrypted: i=1; AJvYcCUL9gZm2iJ+gPrvDGYEI6Mzrsp6HuE/6sJv3wLm6xL5/w0wz0p+mWXxfxcfWICE7Pn9rtEzd0gxSdUzrfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwCtP+dwDmULZoWM1SyWcvfzxwnJRQTmEa9ZAXYPgaXba+1x+
	AatauLllGeItwj09VyLOmiZ1DQ4CYsaAwkwmLsE/eVgK4MwnFUpZfpju
X-Gm-Gg: ASbGnctDoBuLHwFHhu3rx/WQKuCWgxqCIHiN3o5uzwrDlBV9kF1g8UuPZjVC3q+DSVV
	K1JjmqyQiSCFIw/UTGPRkqqOe59KZS0Q2+8yoWJ2rWqm39mf5+PkYYBe+7/cYNyPgA5PYSobtCs
	nykV2jpQSrQNxApXU9PL0kIVy6P2IjeZy+VrYBVa2CQ/Ux9Lf07LrCbwzNwgr2ts/gKdxbD2xVG
	eUaFu6yl7N9qY0ixNwrkVu1hwZ+hlEfWI94ECo5Q8lcyiiODLCJjMcs6If7PNPXhX6e2zcnt4Id
	lwDqhuQOeKlTLcmPoq/nVVEaeZ9yMlEBOm0OFKP+3xWYiERk3NiT8udHeYmAqoDOlaGTO5ED/RG
	CRBNea6tCEuzJIV2XIhJBuvkJ9fu63VgVlA5GZDXndYCzwDIlgZo5GARhWTcAiRnZBOO2srAiKr
	SKZY+HQGPvAc33XoJIY4PcH+pis6EhEcH10gk5+Z+zJr6v/YpAHJXnj8YVxm5rqV8I3Fc=
X-Google-Smtp-Source: AGHT+IE5idy8ltBz4yyQv4LyCXJVQoIVOtH4PVAtTVzDIlLpQ2ipbqC0Mv+dwtrFwZLdO15KZ2mv4Q==
X-Received: by 2002:a17:90b:17c3:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-33fd6502cb7mr9996760a91.16.1761466366364;
        Sun, 26 Oct 2025 01:12:46 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2374654a91.0.2025.10.26.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:12:46 -0700 (PDT)
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
Subject: [PATCH 1/3] acpi: platform_profile - Add Extreme profile option
Date: Sun, 26 Oct 2025 01:12:38 -0700
Message-ID: <20251026081240.997038-2-derekjohn.clark@gmail.com>
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

Some devices, namely Lenovo Legion devices, have an "extreme" mode where
power draw is at the maximum limit of the cooling hardware. Add a new
"extreme" platform profile to properly reflect this operating mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
 drivers/acpi/platform_profile.c                        | 1 +
 include/linux/platform_profile.h                       | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
index dc72adfb830a..9bee8deb4dc9 100644
--- a/Documentation/ABI/testing/sysfs-class-platform-profile
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
 					power consumption with a slight bias
 					towards performance
 		performance		High performance operation
+		extreme			Higher performance operation that may exceed
+					internal battery draw limits when on AC power
 		custom			Driver defined custom profile
 		====================	========================================
 
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index b43f4459a4f6..78da17e16d9b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -37,6 +37,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_EXTREME] = "extreme",
 	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a299225ab92e..2bf178bde2b5 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -24,6 +24,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_EXTREME,
 	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
-- 
2.51.1


