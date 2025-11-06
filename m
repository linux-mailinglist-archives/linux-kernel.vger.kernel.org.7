Return-Path: <linux-kernel+bounces-889406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CFC3D7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CD51883CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F4307AD7;
	Thu,  6 Nov 2025 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBQIWIhH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48685306B30
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464090; cv=none; b=ZpCKWFL5CVbIGkrEEN8vu7yf5cYJzfH32xwDfSqdABzQyJGRk15NlS0CeFkNxPo2AosKSM51ZZnGWEz50I19jrDAP7P+5ZwXj0SZyRQRRdIrsjkbXj/1JowNQttq/7taHYGXCVioi7FJlRqkQ8sLLrIXlYb0CRf3G/k/odhdRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464090; c=relaxed/simple;
	bh=gQDolCcuD5vIgWYrJOYDk+Yjb2OnvDvhndDe6j5Tii0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4scbbikWZQZzV7NpKPQMdd0zvU1W2cKgWf18GK2lb/e1VoMrkeUSAvuAD2DyrBY5nPxtyt0BJkwEcJxGxTVYBmWdsEPGsxnUS0kKUbmCwvff7jMljFmSxRPu8afvcqWXrhHLGJE/fULsDlSxQkyUtfNPva0d1jL618aq1m3itM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBQIWIhH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aea19fd91cso152596b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762464088; x=1763068888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL4It3kAEsZc/+9OA5N/VLO1Ag46m6s63x6+w+Fz15Q=;
        b=fBQIWIhHOZntTRKDfIRCxhUlhUY2OkzdtfDXOLxkT/ImlD28sMMC0M27BP5A1MCQQo
         3QlLzufwdZQd1AKVUaY9GyIq5x8zDvaGa38BHLFGHrB6c11j69fvAnuK3Bv6CfGavb5X
         tex2e3OlFdmdOC9vfvBISATt8j0qkHHgtiwOVhfQfwmHcBZIsn9G70wnWnprRzer0H1o
         D9xhpFNX1oFq99k9G9bkPNgQhykc6yHYCt02O78jOyJ/ZvVHBFb6UIbzvHbWDfiATFxx
         EpMRJAWShLfPw4zGk+R6B2qGU7lfR7mA4rZJfv1OdCsNQXA2wi1NvgsVWnXGtzu3QEb6
         zfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464088; x=1763068888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IL4It3kAEsZc/+9OA5N/VLO1Ag46m6s63x6+w+Fz15Q=;
        b=GNJifb3q+ALhT/ohAEBR4Fz2fw2YeFCn9iYJuD6cM62brOx1EcZYhFIblTQS+4XLdZ
         0P/kfNSJ7/nKw+Y6GCzA7zw297EiH6Pc+IPcn+esQs+Zb8HjrrOPj7Q+0vqeIU1MAc/S
         CCzuV12Nf4Z18SCa4+93HWPxpVIyKGHslJP2zKjxORpF4QlOcFFuA1MPPClXYgrxcS5p
         cFT3uau/gURev52qfUgBWC2gTeVBLuxWcbjAKFyyHmh5g/6sfx8xEqZebU4jhEs8jqzv
         kDF76msOGE78T4bpSQRvVyHqrLXQmifE6NagsSEdgAM5OmtwqNcFBWlEFBwC7T3rQZbt
         tPYA==
X-Forwarded-Encrypted: i=1; AJvYcCVXMtr4s+k2+0lqsnwTCjQIEqzLt+QErl1NQliz2gVqkjujf1PpJyINbCAuoZsubP/PSu/lXc0Xa6I2Y50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZu3qAN/7SD7tVzoI9e1aqjtFp9G22Ti0jmKbCqEIGfa/5a2QU
	+dHwB8286ISX4cqzZiqpYHrd+RnemUBQp+An7bZ0JmSupH9ZWO5E0ZJe
X-Gm-Gg: ASbGnctg4BCThUxixbLYaIBuwb3BBPG5EEhqteqS1YKDTuuFg+iZT9HoAwypt9fE/b8
	jHKILq4NnozxhlktMzQYEbJQtd2Y/hdq2fcM56R2dSFlgHDxIFJ0AMx2N2qKCJILwDWAXY00tiY
	Er5FfNnC0qV57YSZTMbBMKF5sP3Q/EbJn/AIFgW5A7o9UztH7t0fEw+N4UQcLqCBZeqrk7bL1mM
	y2Jvv0NqAsSIHvG8laJpn8yEAFqpB8YmfBX9PCNpNVoQcHU6tQOGIRl20QOnAZm7bevvxwvET7G
	lcvPyAgVo9IyqpoJ3Dxad0yIg6jMT26AEEcn1b6n4+z9Cqdhjy4Cn1EFWnM/KgIxoLv3LSEpIO6
	/U3d43XM8dI5ZRAxojVRhlsm3WSrI94770Agz461pCvm4xLJcXkgkYsqVNk83aj2Ymui4DfNGjb
	eWdjLq+hafDnjoPrIs1XsC+5hZCFi5a8m7grJVIsDHmfSTZZipR3msmdWAajyStnQZ0RQ=
X-Google-Smtp-Source: AGHT+IGnZ3ioVBRnnG8un6BDnXO8Duun1EVSqTxxH6SbHC2rrOCyZqeAC5RipHrEQAaoZitkIkBHEw==
X-Received: by 2002:a05:6a00:17a9:b0:7aa:e5f2:617d with SMTP id d2e1a72fcca58-7b0bdd76f66mr1178498b3a.30.1762464088459;
        Thu, 06 Nov 2025 13:21:28 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm521360b3a.12.2025.11.06.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:21:28 -0800 (PST)
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
Subject: [PATCH v2 3/3] platform/x86: wmi-gamezone: Add Legion Go 2 Quirks
Date: Thu,  6 Nov 2025 13:21:21 -0800
Message-ID: <20251106212121.447030-4-derekjohn.clark@gmail.com>
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

Add Legion Go 2 SKU's to the Extreme Mode quirks table.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-gamezone.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index faabbd4657bd..bea4d2024628 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -266,8 +266,23 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_extreme_bug,
 	},
+	{
+		.ident = "Legion Go 8ASP2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8ASP2"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
+	{
+		.ident = "Legion Go 8AHP2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8AHP2"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
 	{},
-
 };
 
 /**
-- 
2.51.1


