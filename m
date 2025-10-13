Return-Path: <linux-kernel+bounces-849953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDDBD16E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA51890D47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD419D07E;
	Mon, 13 Oct 2025 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8LqQfUF"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AB34BA34
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760332888; cv=none; b=aye/QTyX2zxFeYVKTkRMkbKU4XYb1wWs7VjlG3ujggwnm5cO7P08EDCzR/OkyuRv97z/uD1QZm7iskHmhW6nL0YnMzloGs5sfafu4kPHHtg2Shtmas6pvKSSTMQTKTzhS9U52YxcPpVsykVPIfLlGLQUiQh5vXRAfY+oygkC8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760332888; c=relaxed/simple;
	bh=qzVo+7LyZQ7Np+BQqMfvtJ7MzKbh4xb4FvvO+YQ7vDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EXm63LdFKD0pLXO4HNXzrJwbtr43j0xIdDJ/Nana5wYvrrA7jVcezMrIkXiBF1wxHMIw4B2qSyqh9TMfbJloHVJZK3NLU/7+cbplJWHcZYnIKi9t7FdyZ2Y2/PBjxCEomEuq/yk5Tq58W0PoO8sxy0lf7Di3P4WXxc+6TqnwXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8LqQfUF; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bc2d1feb2so918839e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760332886; x=1760937686; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gnW+HWmI+v0/T60f2xe+jmnQz86oor0v10hn5S+LMM=;
        b=E8LqQfUFxh80SsgJBGbgb+CUDrnPeV6Udaaehy9OOHKBHKzHDG4tTMydEQky9d1EA6
         JyA8SAl1gvQDYEbUzo/2m3Yat8aCwrrZJrWFMz0qLTusZmNhl20Cb+0uhFgFS6FRoNa6
         V7F5rpu23S8EXsFdUftixCaSNT9P/XMrk0TomCeLchSxOjOiWv9NzOZC/Tslgdiu47S/
         dqe+1D7cwQ1BLKfkeKDgAQpaoMm3YQBI/p1U73BQAfK6jErlVfNnAY4EK2VQjozWBAyt
         hi4aUBB1LZAKOE9ORHRIzApgs3zwSak6vg2HmXeDKl2RqX/hdYBJj82ip6qvMyARefT4
         FXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760332886; x=1760937686;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gnW+HWmI+v0/T60f2xe+jmnQz86oor0v10hn5S+LMM=;
        b=f7A/9Odly3USD8g+1U2+OLPiNhSKGa7RaxRhDOpH331Ae1YsJAUO5+oeYGf0NbHEeI
         1PD+ixN1KfbxwpJmWX9LD/15RI4Hkl1pQaYgSqFND7CE1HDy+YlJkeMT1mW/kme91KXM
         0DzDRTegnplA1nXGnVSzGCtRdSdlh1wrla5ZVrosR8VG3giFnWpluXYoyjNOSeWTLcuB
         e1Nsy8y0MExyEzHDc3v+L9knmTqHgfInTrqX4XWQw6UE94sK/VDR3VKjwslBGn2jELBr
         hqAbFKPcBT9AiBBOdFu4paLz4zJrDCOxWCJfnLYoUPsUHmvbjJZ70b4L1dTFW45YuO2U
         d/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdCrnzEkFcRpP5JyhMcWwTGKoqqlZBPPU/qpdHLJ9shv7xjlR7GETt6C5E4R0qafWOFWq1G9d7rGbU2J4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa25Z39n0UtL3eUZVTaS5HDo9wkGC0qHM1q+yg9NZMDwRx8pxz
	/MtVNFegG3WguCCcsQUSocdfBPR8YnYA5gXy8WIY8kYl1QfIdx99w44S
X-Gm-Gg: ASbGnctDP4RYxZWBbil/4SdP8scVcwp22UJlNJzMzFQJ0Vt9YU/Ict4Jz3NsrYcVzt7
	l5fXm12mGinvOGeEhvzIBjLfJ7u9GrcoquZ6PEatl/9dOczSOAhQVp+/De6F+dzPEBn5hzf5m6j
	LOlP+twgnzqLYS/lT5/j7GyKRwpbTzsHj9mnvzViZL+FnP8tmfg4lOJU6mXv9WojwtA5yJcFXMt
	5b9kdnMJEVSdKGXK2JTBtgwWUGOYYt5HIKMGPEPN3ytn1FScMqjiDuWFLxa9AnKoleL5SAj97Y0
	+EZJTw+BBXgT6J3H/f4l7k8mOGTG/dbIacjlb86mhGvm7G63fAf4AmJ8cycsP1kIkzLtmuslhLD
	T5xItdh2GuFg73uNiKjQ6zPiq7bn0PtPWXQR/D0NR//UcdfI+9xf8ww==
X-Google-Smtp-Source: AGHT+IHWD/iz+M+SeJnAP21+zFM+eC3cketpbCHgFzv1UE8edmmlHFuRnvCAk/L0+ktqCi3aPzvlqg==
X-Received: by 2002:a05:6122:3707:b0:554:b927:dd96 with SMTP id 71dfb90a1353d-554b927deb3mr6755179e0c.0.1760332886190;
        Sun, 12 Oct 2025 22:21:26 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80aab53sm2825311e0c.15.2025.10.12.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:21:25 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 13 Oct 2025 00:21:05 -0500
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Fix null pointer
 derefence in sleep handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-sleep-fix-v1-1-92bc11b6ecae@gmail.com>
X-B4-Tracking: v=1; b=H4sIAECM7GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Mj3eKc1NQC3bTMCl3TFANTS7OUFEujRGMloPqColSgMNis6NjaWgC
 ORK2YWwAAAA==
X-Change-ID: 20251012-sleep-fix-5d0596dd92a3
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gal Hammer <galhammer@gmail.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=qzVo+7LyZQ7Np+BQqMfvtJ7MzKbh4xb4FvvO+YQ7vDU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBlvejwKjTTettctczxw8djBnpWvBPK+bq+ZEbIthiGv5
 /lUdinTjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIVhOG/+43hXapdP97eCqq
 SnDi8/iQ3ad/+/nGTnLP7j3M91jNXY7hn9r+yVkfp88+9EOzpm6WpavzhnsfYs+GXZHacVv6055
 dFvwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Initialize `awcc` with empty quirks to avoid a null pointer dereference
in sleep handlers for devices without the AWCC interface.

This also allows some code simplification in alienware_wmax_wmi_init().

Cc: stable@vger.kernel.org
Reported-by: Gal Hammer <galhammer@gmail.com>
Tested-by: Gal Hammer <galhammer@gmail.com>
Fixes: 07ac275981b1 ("platform/x86: alienware-wmi-wmax: Add support for manual fan control")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 31f9643a6a3b5c2eb74b089dc071964bd6df8b43..2c4b71b03c264edaffcb0341bbd9e6acefced8b8 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -393,7 +393,7 @@ static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PRO
 	[AWCC_PROFILE_LEGACY_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
 };
 
-static struct awcc_quirks *awcc;
+static struct awcc_quirks *awcc = &empty_quirks;
 
 /*
  *	The HDMI mux sysfs node indicates the status of the HDMI input mux.
@@ -1680,26 +1680,16 @@ int __init alienware_wmax_wmi_init(void)
 	if (id)
 		awcc = id->driver_data;
 
-	if (force_hwmon) {
-		if (!awcc)
-			awcc = &empty_quirks;
-
+	if (force_hwmon)
 		awcc->hwmon = true;
-	}
-
-	if (force_platform_profile) {
-		if (!awcc)
-			awcc = &empty_quirks;
 
+	if (force_platform_profile)
 		awcc->pprof = true;
-	}
 
-	if (force_gmode) {
-		if (awcc)
-			awcc->gmode = true;
-		else
-			pr_warn("force_gmode requires platform profile support\n");
-	}
+	if (force_gmode && awcc->pprof)
+		awcc->gmode = true;
+	else
+		pr_warn("force_gmode requires platform profile support\n");
 
 	return wmi_driver_register(&alienware_wmax_wmi_driver);
 }

---
base-commit: 3ed17349f18774c24505b0c21dfbd3cc4f126518
change-id: 20251012-sleep-fix-5d0596dd92a3
-- 
 ~ Kurt


