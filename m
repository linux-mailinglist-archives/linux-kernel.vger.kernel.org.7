Return-Path: <linux-kernel+bounces-849029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B152CBCF09E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54C9C34DE0A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DE22332E;
	Sat, 11 Oct 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr4tG4nA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99845221FBF
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164748; cv=none; b=ga4EnRkySV7qvk4B4340DyN5A/wfQkPbMYeVXmNp4N9MHCmcAA7W2wrNrO9wTiMGiJuSGR4jDi9hja+nZHozvU204n3TdsI0LSzSBfyG9DCGY4G+VGxDhLLoTVjIwS4cFxfmihQlZRpTTL2WXNYGmbuIkGtHjLA+rkTrFo9RYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164748; c=relaxed/simple;
	bh=7arbrLemIr4ew2lWcbkmCuP17rRxN8N6CQQQW1PRSjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gqg8tpmAjgZy3AoL6tJQz0ffJN7Y0XwERA5+AaVjRoj+zh7p6KLsOb71gkNRR0AKbjQWuxqtyT9SYh4vPqZXnb37x5x/uTAKT69s12hxFDae0Div+fXwTl+2emnhBoCCZsG04upoqYzNszpyZywcSnqKUB4zNfGXa0WXOMAq//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr4tG4nA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-269639879c3so27048625ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760164745; x=1760769545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RbdqxG92yzrMeciIeTBUuJ1kqttBeIBmVGrFI+VCiw=;
        b=Wr4tG4nA8x+LeW0waMuaUpTRBdMPeAEFGGYqq2ZzBRu9VjqKjuJNwgFcz2GgbHQDgA
         GzfdXP+JBFhcxdCo/0fhQ/HdIDb46szAl84qkOce4BVO9rKB13mxNl6BonQQjD3h16nY
         UAuoJwIUIDrZwFcBmlk32+fi7crCHvCqzwYNERi80wC4AjfHQof2fn7Y0LQGYdaAeMok
         xq1e1uGBqofC80zty71CTggdxgdESFs7dl7XdoGFNsrp5X7oAEkZGz6k2475JFVHwjyB
         JmaUcmcI4EolgdIWYufgFesk0VLeDxkS5L5lPRpEIPgEjkusZH0ZX6+bWBUUOLVPVb/y
         wS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760164745; x=1760769545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RbdqxG92yzrMeciIeTBUuJ1kqttBeIBmVGrFI+VCiw=;
        b=iQ4UWjkfMP3f5DVyQQGpEdX+akEpmsd0HAE9puOlCQ4hrYva76axHzRYaLzPdWOnih
         Y5sw45xRSq3/csrmdh7zOqzQHrbXTtTVWdf+6R3ECKsu4U4ITs1Zebbe9JZISoRDdrRY
         u/f+46rJw+bRLxJ3OzTwjFxKMr9YLDfmcF3XDyA3xq7O+BCZ1ehGFmU4lDyDlIz+thY0
         WwiNDY2gy/LjTux/ZDxrbQ7ropV+srId32bflT6x62q5gZHFALI/pg9hO8BgFZxS7wKq
         jyGX6B92GyjgBhuovV17AgG7SVtzY6LgCjW9DzkZP1fySrl32W8fb2+mvhsV1h94XkWR
         rzCw==
X-Forwarded-Encrypted: i=1; AJvYcCXtk2CvPr5bG0vwrPWz7Q6SrQeO7H2nXJ9oP+aWbHA/jRBxcTt5MgiWCI9Cpl9bbMk2U88OPsN2AxZuos4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQP87EJtk/rb/Swhlgch3fPtcpg7+Oidwv6JgPpGNRHxeNUtpG
	ElvIp51ogN0/d6rilK4xm1EK8hKtPFugEZM5eUIo4vCDtVL80iPVgcjl
X-Gm-Gg: ASbGncuRh5bgyht5imoDiWBlH+SdHqotj0FW8xFj653Lp7My9k74+d2YIVcMtGMXcT2
	XK8qLYh6dNSZo2RCopoDCxh1KVYsCal3Z0grM/0Q3aGCB5jNf4+u3zfea04pU9wHvapahTfPMzd
	vYWj3zIUrh0g0nwnkEE3k9ZzIVJSGk/5vpfHMNFMhsMc6UKtc6ro08pe2bCs7HQg9RPo0TVVJxc
	+5ei4eY7FhzK2k8eML3szOdGmQDpOmXJLMs288QnaPSQwJ1bAmqqC9LPe/CgXfe/z7R1o0c0wwX
	piU9kCt2UnJwH2JEHi38xM3+gXgmT+iG1A+rlF680BulMkGv2cjieYWxqLUQ8sb+AW4H3cJ99wI
	XtRgf0Miw3c2fIhDQRZvtzmlTKtXVqNWk0qQ91qbH97b1GOAsHfNwzeJrCcM5VZjA3goxCPt+73
	Xry2ZYWA==
X-Google-Smtp-Source: AGHT+IHB76D4GU47IgQDKRqpfK4084Sk1yZhLn2sQmzeSgViYiqrqYFWTIaGUTUGieei/ytOtwgbFg==
X-Received: by 2002:a17:902:e94e:b0:279:daa1:6780 with SMTP id d9443c01a7336-2902741cf99mr193290735ad.52.1760164744934;
        Fri, 10 Oct 2025 23:39:04 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362efsm75647005ad.89.2025.10.10.23.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 23:39:04 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] platform/x86/amd: hfi: Remove redundant assignment to .owner
Date: Sat, 11 Oct 2025 14:38:37 +0800
Message-Id: <20251011063837.2318535-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011063837.2318535-1-visitorckw@gmail.com>
References: <20251011063837.2318535-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coccicheck tool reports the following warning for this driver:

./hfi.c:509:3-8: No need to set .owner here. The core will do it.

The manual assignment of .owner = THIS_MODULE; in the platform_driver
struct is redundant. The platform_driver_register() function, which is
called to register the driver, is a macro that automatically sets the
driver's owner to THIS_MODULE.

The driver core handles this assignment internally, making the explicit
initialization in the struct definition unnecessary. Remove the
unnecessary line.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Build test only.

 drivers/platform/x86/amd/hfi/hfi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 5d5d2cf23a75..83863a5e0fbc 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -505,7 +505,6 @@ static int amd_hfi_probe(struct platform_device *pdev)
 static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
-		.owner = THIS_MODULE,
 		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
-- 
2.34.1


