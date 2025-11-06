Return-Path: <linux-kernel+bounces-889404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5CC3D79E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 499304E52F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8E306B35;
	Thu,  6 Nov 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkFqUJuf"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCF305E29
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464088; cv=none; b=NkhVQ+4t7uuQvl8RLSlR+Lh2/qmnMUg5ZZ9EidO80Y+gATCmZQuEhBotqZp8x0ZMDu2e5e077d89ZMP7J4k2yPrpKBJVjwyhFRYukTFHo0W2EF2iPf47LjHd3snysslD35QCwXLtFlV0V6mGBKp3GputkdZukPTsyyjSRIe9kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464088; c=relaxed/simple;
	bh=FwLNkRtTJ0ikM5eQQDKNv4zZ9hcnAfdUu1+o6OVb/0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsBFc6IzWrASewxPk3eKM79mm+onF2f5A3kOy2UZUkjyNNJq7SySDJemOL1ip3gSGph4u48JnAWqacJS0Hx6U8FYqgN9rHMynjT5SvgBgKkSA5YAicvYoqkHUjV36b9fl5MAvaYFLCscUdJi0gFwRzZKIKdKwTZoNMMUTxeUbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkFqUJuf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781997d195aso59919b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762464086; x=1763068886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0aw0d1VUDeF7yPt0q4o8kNpDsBTJNsxGr/Ot8TJH68=;
        b=dkFqUJufs/gefI7oojiNkMK37ZiU0I5XYR7HrCY15zbUspsLt6zKkar5R0+nsVJD3M
         6A25t5Rte/UMQRPhrCVLUkRk7kqScub6qKiqf7TCTBgjieU5yiA7VTGvBNJ0GYOvOG87
         Q5bxO6nF9esjh1tVmU7s7tkCSz1E39iMzsCyptmv3sjn0/Z4XubvmHJIpX6/56l+mDzN
         959RW8QC5e3qFfoP9mfX4DXXOHiDsI19eWIVnU24fIODnH/YE0Fe53FhNjo/GHaetFdI
         JQgdJTATE4v94R2V3DI10uJbEWaMeaLLOjFunGNGEhAKFG+l6JfFgBVvjdNRVCx1nuRA
         GJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464086; x=1763068886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n0aw0d1VUDeF7yPt0q4o8kNpDsBTJNsxGr/Ot8TJH68=;
        b=p9YYH4VgXSWSl8yK+hGnYP/g3aUR78ahXlxx12965VzuU0WchDS4i18wEhYxem0M+w
         WiDzUv9aIv/OdAI73XeNIrBwJsw4To8CH+U3tODkZ8sK7bQa1OlQFc6N+qmWV893s7M2
         7UXJO21eubTf0gkyKHaO8asLv+6ICh7AIRutkR5wK88DuUBSDx+1baYZuU8uD1R1XLvd
         MjAuylyHqaPZp/WRHKkduIJjJ+1N0Fp0G7OLllaxAYJiuNeSEJmrGSjNHn6HcbHSyiz7
         9xnwVptrb4qp24PMJXThu8JNM+mFzbNDEhFG1jXrgV1jQT93BkdU7Z+Yj6F3J3eqhIWr
         tGLA==
X-Forwarded-Encrypted: i=1; AJvYcCVEOqxkMZbwhgPOE4/po/e/DqM0vu4oOy721LjW/ubu6DlSzEHqj5Bdv6ozoajqNYaDEIz5rQSi2FB9vHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN804LYI7senfMMBWPSb3YuqV5WKpdVkHgmQmHpL8O9UncwmxA
	tmPD3O3CIarLFLmlWdbj/IQkliFmsI8RIv31X67lfFFH8fHOTOBRqkk1
X-Gm-Gg: ASbGnctEZUBhzioE8e8g/cwlTFGyXYYk53I4C4Z8Yw+5eqrgH2PicvFb/jk82H6bEsD
	H04n1tBEZwLYLk91ZOFPq9VzjxPpjguy8BxkEiL90cIuSFlHWi2cuE7sUt/ib1LLx3FtIO4Rmvl
	ypdqmx5yvTe8qK1ZFGlzXPkshOfCt1SlcdKokv9y2VpxmOykQT00I4fiYN60/Ql4FeaG5sGNl+1
	QjBDDugkxHsdqI5STDnmswQ/6kSxkQRCNLC1ODX3V3HRxwvigMAG/qwKxmwUx6FTaHhsg/hnu5A
	qy9KAyyoa115GwyXSgd3+eTvzDwPhK+YRqEr+fBtESkr839Dq1fODWYcfZ54CsL9weGhGfTqMQe
	HjMI9N7t9P99TUu0ZIw1fW8pK7MFjGLdA3jy2qzPDYVffsp2qF+iamoJW4/t1KSgi8JpU8MRB1T
	c4BFctbpcw/oqYxZBTLoZ1rcP5rQ7VUOI8ineYsJgap1Ep9I2JwIpgNnaFaizHGiov1bQ=
X-Google-Smtp-Source: AGHT+IH826EutkUvFfzktmcjLwXuQGckXss6+pYKmU2ELz6Vx83zq+dwqtEf8PtHFijWmAc6wuQmlw==
X-Received: by 2002:a05:6a00:4b11:b0:7ab:c5b9:615f with SMTP id d2e1a72fcca58-7b0bd98b115mr1101362b3a.22.1762464085919;
        Thu, 06 Nov 2025 13:21:25 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm521360b3a.12.2025.11.06.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:21:25 -0800 (PST)
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
Subject: [PATCH v2 1/3] acpi: platform_profile - Add Extreme profile option
Date: Thu,  6 Nov 2025 13:21:19 -0800
Message-ID: <20251106212121.447030-2-derekjohn.clark@gmail.com>
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

Some devices, namely Lenovo Legion devices, have an "extreme" mode where
power draw is at the maximum limit of the cooling hardware. Add a new
"extreme" platform profile to properly reflect this operating mode.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
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


