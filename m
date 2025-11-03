Return-Path: <linux-kernel+bounces-883574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA767C2DCA3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BC9421A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7512266581;
	Mon,  3 Nov 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myUVxzk7"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAF23183F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196537; cv=none; b=gzwwbM9pu1NmrLRscrSE3qQ1PcNO0PbsJIAX/MVrZAJFmTM/oCoh0kt11fT1WnAN3kGaBz4l/c/6wagTaFduMHIbxnIHLTomXm+H/i66sFJHQBevJBFyogbITOy8WugfS2vCjPTHvuSKyBPOHMq/wpBeDuJnmv+5SPbv5dv5PIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196537; c=relaxed/simple;
	bh=mR8JFYjApVJz24/D1D8ubd0ClEAycyirQaTeFhns7r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eo9YT2HV2h1hI7jQWd5XV+L0nRNdk2NFRRUI+3fLLwY6xlasDQQKA0yQFiZRSX0PKkB3v8o3YwLTdA1SRRVHkm2LvVezyPDZnj+iz5siAQKpyl1EvjrH0bRV/R3VJDpH6Sd8nJfVox8bi6jf4CkNL5TwNN/UhavttRzVntOt7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myUVxzk7; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-559748bcf99so384098e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196533; x=1762801333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7torge8NqyhRXZbGycebgpy3GTUJqARV2d7cyPFikQ=;
        b=myUVxzk7jMO2iOwaAyW0O1/UrXRXPHd7qnxR1VKCZFK7rj22TcurroChyYzZkLhMw8
         ZaxIpVYE1DgRyQkGkoorDW1NCoCA1x0klqLHr6FIcXtk1kxNIyPUEnLYaoemlj5KvcZ1
         BkpO0RmhDLBf3VaqsC0s48SZwwBhL7SgDSauHLiNZ3jNPXY5VRZrgzvSwSXoyqwYjBrZ
         NyhWdXkEMFo2ckQx3nDrkIkTMyt3jHO7Dwe14YhAJDg19ssVnduDHysvRuyMwnX58x62
         uQ/bOG5/WigKSnVB2IhwQv+f/RfSzb376HtrXpvOGNu2hM8YQe5lgPvmgvSHt30z7pZN
         3b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196533; x=1762801333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7torge8NqyhRXZbGycebgpy3GTUJqARV2d7cyPFikQ=;
        b=K8NsEe03W8OBC6KV2uZc49zlXvxaCJsSGttTTdoXP2G3czn292oqcpfmhHKHALKONI
         hf26349HrqI/Hj1AuUdMv+Ot85z0FfcMsMbfzGlT5ey5+LGZN5oc83wyu41CUXcKk4Pt
         cWYrDOEeOcdCCRolQoKzI+6zktTiPDsmUX0FmBRoqi7ttX9LvgrY3dAmsBTk/yeqs9Sj
         ES8uTh0FmJymWT/i5Ptr04JEQlbNtNiYRzK0p8EJxBPbMseIvd4/pRgYLWtOlBjcvK8n
         VlXueR8YseqBK8XhB/d79FN9+72Zmtujf5u06I0e0qrPDaEddrfoaseLRI0cQCzeuDcI
         YOJg==
X-Forwarded-Encrypted: i=1; AJvYcCWRKjJpL/ro9J3uoXQiJClnhYJ7qNoPOVgRUwD2hSrMCcmE4f0l5kp8TUmpIilN0EtBECJewaWvO/gnCkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0af/pQLow/BYEqjo3Dcvd6M/K9RVNcg5lnhuAWXT89Nd5y6d
	RUWdxNX1jX9lz5rOsTYmWjyJbWuu0q6M1aWXUsZSZL9cjZR40nozbWm7cAaS+w==
X-Gm-Gg: ASbGncsAKRVfrcLqLvmYE1nNwHiQfyX6icae22CkNFfp/w+lhrsL9Fy5CBuqJAqAs2S
	CzSYlCLF4ehHwLEdumJ5UABI/5Ngx55fUNbV7c3qnrSTvjff7v6NHpvcjdXeo01dUKXO407k/oq
	OWavDXMVoL+hiq3VaF2rjXo1v8cJEglUBGyQNsKBifK2ZKTuSMLP+TUkLDsL8v3yREvUDDYVy3/
	/SW5Wu1D8jsv6PRHBKSC+2xDxJIbPXlBms1iQ9FRW5EBoUxDGWf1uQ+ykAGGeavnwTODlevsdjT
	x9bXnDZji8Pm0iwHkmuAvg9iirh7HzXxIvyLn3CxODM2rApu/YI3UkZgR2drdUi7Fr68/L3SGWb
	chsbtdeYI4BB8D7sf5D6kLeQeNf+ePzcpVtkcxmnplbwkisRi/atmKUz9I2hUCBSVHwV2TLiRvK
	2P5Q==
X-Google-Smtp-Source: AGHT+IH4IhiEmFjywTMC1UXYIsQrZjiLBGhqIFHxaY/hE5Qv29XEePHd3I3nsvXC3iHruN+PtJ6gnw==
X-Received: by 2002:a05:6122:3d0f:b0:559:3d59:1fdc with SMTP id 71dfb90a1353d-5593e42365bmr5038157e0c.14.1762196530761;
        Mon, 03 Nov 2025 11:02:10 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:10 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:48 -0500
Subject: [PATCH 5/5] platform/x86: alienware-wmi-wmax: Add support for the
 whole "G" family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-5-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=mR8JFYjApVJz24/D1D8ubd0ClEAycyirQaTeFhns7r8=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5RYNsjsnPx+YW1R8+1Pm323v165JG5NwTtH6wdvI
 m9Pd33A3VHKwiDGxSArpsjSnrDo26OovLd+B0Lvw8xhZQIZwsDFKQATiXjO8Fd+vXd3P9v5T44t
 z+MedDd2Ll3//eIU6cVerQd/Cbf/krVkZJiiJRIUtZfPXOnrkw6vrsVMeec030x5MiGhrcO0+W9
 MFC8A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support for the whole "Dell G" laptop family.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 56 ++++----------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index c545eca9192f..1c92db1ac087 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -162,74 +162,34 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Dell Inc. G15 5510",
+		.ident = "Dell Inc. G15",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5510"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15"),
 		},
 		.driver_data = &g_series_quirks,
 	},
 	{
-		.ident = "Dell Inc. G15 5511",
+		.ident = "Dell Inc. G16",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5511"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G16"),
 		},
 		.driver_data = &g_series_quirks,
 	},
 	{
-		.ident = "Dell Inc. G15 5515",
+		.ident = "Dell Inc. G3",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G3"),
 		},
 		.driver_data = &g_series_quirks,
 	},
 	{
-		.ident = "Dell Inc. G15 5530",
+		.ident = "Dell Inc. G5",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5530"),
-		},
-		.driver_data = &g_series_quirks,
-	},
-	{
-		.ident = "Dell Inc. G16 7630",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G16 7630"),
-		},
-		.driver_data = &g_series_quirks,
-	},
-	{
-		.ident = "Dell Inc. G3 3500",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "G3 3500"),
-		},
-		.driver_data = &g_series_quirks,
-	},
-	{
-		.ident = "Dell Inc. G3 3590",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "G3 3590"),
-		},
-		.driver_data = &g_series_quirks,
-	},
-	{
-		.ident = "Dell Inc. G5 5500",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5500"),
-		},
-		.driver_data = &g_series_quirks,
-	},
-	{
-		.ident = "Dell Inc. G5 5505",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G5"),
 		},
 		.driver_data = &g_series_quirks,
 	},

-- 
2.51.2


