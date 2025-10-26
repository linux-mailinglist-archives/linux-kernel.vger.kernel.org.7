Return-Path: <linux-kernel+bounces-870247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8985C0A484
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827223AD4A7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FEF27E074;
	Sun, 26 Oct 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQsPYlsf"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE273D84
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466371; cv=none; b=rzTbDUmohqKh5Szrgk3uOeDS0/9SmdOignr+PatNFhscjWvARyaXjWHmowZws4kz943OVJYW8AanqvmJ/r1IpR4Ss68k0PsWqeDnHgOz+LzsxTV71Pr4OKT8KHuISV6duC16cXXrIZuocQwwqpzRPp22Gg86XAx4ZSoUxqaB6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466371; c=relaxed/simple;
	bh=fAqPolmBlQfa84L7cxrTr6EjJbpJ+y92oFkNq0XgIKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0dDr6J/MnZ/b1pgAHxlMXHI/KCWdKQ47NyGWjScsFV2LVRwk39p4dee27fPLhpqRyAplvcW7In8TSeHTLHZ4e40XO5PTpzj6sT/wAH9jXW2aHz6yuznjtw0bM4//doQg4jRGtJmWBHkLFJv4QB3NB6Hv+8uvGsq7NeIzANsy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQsPYlsf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so3322077a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761466368; x=1762071168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rezh3wt9kRUzheVUy54KuCCd/gyLGw88/DiSALE/HFY=;
        b=LQsPYlsf/dMFfba13xz9l6OEYh6Zv0ysFkKuETFGJ97YBA83O4Q/NxFdnH7LOkdcLR
         AxdKOn2Y2TUMnC+c9Bid5GPQSu/yliiIExeZ4c/mah9qz6D8CvRpbi0RnWzShHYcUYGP
         vOknn36f0pZ6wcSBH2NuHWOaD8+4Os0ti/DA9MVpx+dJAgLt93IJHiE40H2LmX0HRQgX
         /lxPg03nzGzyj7Q/hL1lrtDWPfYLxzvJ2lhtogVNka20RUzNtT7NbY0WnI6PUXBAgXYH
         cHZMphwQu2UXHJFr74vWmvYsKxjdMMatWC3em0ZaPZy9fx7TSwdikmkVbJs7cSEbyg/w
         Stgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761466368; x=1762071168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rezh3wt9kRUzheVUy54KuCCd/gyLGw88/DiSALE/HFY=;
        b=ai202jwR4Xj6UtiGisGEfzpi3khYQo96iHHEo2rOq/0Xhcc89mjrJqEOf6+ACcYEFj
         mMEDQxIVtW7A8eHlubpPbBa+jMzUpRXF47glgq2QtklBiCBgY92R7igpdjkWq6jfFhY8
         j7NpC+clBgJZhqzTAhQOndo1RYCXgypdruBrnL6/RfQseomCwfK6nCphpRzXVKKTf27+
         Cr9wRKrGIdPgWfyjgMnytb0u/b8uDtrWAy4plukiAbfVhFR2OEOrUxdTFTKQHWSZZM+a
         427Qez3z6Kv5a3vznEn7kCA2enF5f7gN0PG5zPpon2w0wUtb4b4Uim5MZA6pL+rHON+9
         wyrA==
X-Forwarded-Encrypted: i=1; AJvYcCXBH+6fSR8ag77w+a2ut7bvqwAXPF2Hxi7AwwhMvSwMFy92NBnm25dAUE1QP1CMjuxOAiBzWtAcL+u0+PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzxt8TDSEPW1QOfRM9c+yjMJCmIilVTz3p3ioTkQL0mu4+eBp
	jjCmcX/g8PxyV5859gLD5yFMlTFh3iY1vTjujmr+82SnwEBfsJCLpn/b
X-Gm-Gg: ASbGncscjJwcem2bqvMJ3w4nUcrYbGFSCgbrgXhBzorcofm40t/gsyYsKJbexsl2xXq
	5Exg9Q4LaX6EIhUnAqkefyUFe0ZLpKXuS2u2xz3gcQMWzLbnOK5kohJQ+Q3z4IglI22eqrwoMXD
	c+WJEYTIf5XoLy60eFoznGYZYgGhqwwfXa5GVgezryRN3NVMAerbRV7uwXG9wjjROcdUmObsRqT
	+WHrVB7FqW18/B/TTWZB4oZxbWdqcTgAMKSZN7qbmGDxXlKFQWqrEPfkKqV+BHPCb/ZbvivX7Fd
	xd97uZ4/qmSfzKlkq/+Np/jmWj0rdjFsv92SPiJmv6Gq1930F+irebVBvMI6gU/WM7e4UXjB2O5
	cmoWdau40M8P9tBsSUTTfrUExlB0Zf9NpXqzOUAlabLJ+xdY4nWn0liQCVPpRuaW7BfpIzA4cwp
	IYSYcu1sualHErhpLUOPCHAv/LW+eht///aT3OB/gmGlacgQwWHpdkXmFjkOfS6dMYBEo=
X-Google-Smtp-Source: AGHT+IE2rbuAHnWMjBa8fygy7jKHSZwSXH4NsVuzqBqrp8tI2m5FHIVSbg3wwDG2m3oqgr2BZK8c0g==
X-Received: by 2002:a17:90b:3c0e:b0:33b:c5de:6a4e with SMTP id 98e67ed59e1d1-33bcf853711mr40477980a91.5.1761466367650;
        Sun, 26 Oct 2025 01:12:47 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2374654a91.0.2025.10.26.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:12:47 -0700 (PDT)
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
Subject: [PATCH 2/3] platform/x86: lenovo-wmi-gamezone Use Extreme vice balanced-performance
Date: Sun, 26 Oct 2025 01:12:39 -0700
Message-ID: <20251026081240.997038-3-derekjohn.clark@gmail.com>
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

When upstreaming the gamezone WMI drivers the "extreme" mode was matched
to performance and performance was matched to balanced-performance, but
only when extreme mode was fully enabled. Otherwise performance was
matched to performance. This has led to quite a bit of confusion with
users not understanding why the LED color indicating the platform
profile doesn't match their expectations. To solve this, replace the
confusing convention with the new "extreme" profile.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 .../wmi/devices/lenovo-wmi-gamezone.rst        | 10 +++-------
 drivers/platform/x86/lenovo/wmi-gamezone.c     | 18 +++++-------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
index 997263e51a7d..6c908f44a08e 100644
--- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -24,18 +24,14 @@ current platform profile when it changes.
 The following platform profiles are supported:
  - low-power
  - balanced
- - balanced-performance
  - performance
+ - extreme
  - custom
 
-Balanced-Performance
+Extreme
 ~~~~~~~~~~~~~~~~~~~~
 Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
-enabled in their BIOS. For these devices, the performance platform profile
-corresponds to the BIOS Extreme Mode, while the balanced-performance
-platform profile corresponds to the BIOS Performance mode. For legacy
-devices, the performance platform profile will correspond with the BIOS
-Performance mode.
+enabled in their BIOS.
 
 For some newer devices the "Extreme Mode" profile is incomplete in the BIOS
 and setting it will cause undefined behavior. A BIOS bug quirk table is
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


