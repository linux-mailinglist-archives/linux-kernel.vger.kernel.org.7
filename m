Return-Path: <linux-kernel+bounces-869504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358CC08068
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E678357990
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36A2F0C45;
	Fri, 24 Oct 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfTTTyJZ"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E932F0686
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337258; cv=none; b=L9658rg9SN6/yt5PdbfZKAn8JyEhRvdL0K/YfrKaCHI5jrgm8J9MrKJr0zW1Ll7qRSZKIRuPhGSmHef2j9QcCh3FIuS9k1KjBZD5ALEn2XxRUK0byOm/n/zb/nPwF9EzaOItIJvemHczL6o1etkOYDPOC0t6qlPMbsLjY20u8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337258; c=relaxed/simple;
	bh=6NPx+X2WywRhQ+1oS5o5Hec/aHLKkdUJXFTe4ZBYQgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkHzYRpMGT5t/B1eHLFO7IhOkiiL4I+d1o6ZAnNFe4UY6BE9jvR5uHqafiUDZPaSydTs5YWMEjM5XZMZnWz51ulcNfJb6BFTUuNJ3TUEn8LOJx2P1YnjkRQNanDGTjRDmIl1abvJOYBkL1ppJH9UNQdslhvwGyJ+50xEx9/A8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfTTTyJZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so2507771a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761337256; x=1761942056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KRiNp1ap25NQp6V+0Xx5744wiQSngYoe9dljgW0lUk=;
        b=EfTTTyJZeDWxBRbIBiWpRIbmAY5mfVwsLTA1XECO4Yj+03tqyf9la4v6J28NgVrHx7
         o72tTJ1JTUc3W/+ZjOc3wB6fFcWzFBtR9VCgsm5zJZsLIlVlPM+7wQyAepnDVUCar73t
         Y8kzftE+IFzmA1qZUP0sUUjAFEVbMDGhjXugxN1S2vvtOaoO1QRvGxLawkH8ITlAyy2q
         j9NMW1iRTrkH8TuIZV0E8x/o81BKh2FpyDRMH00KLKoSNSdU2T2BDtcVvHVLUcQ1q6KG
         h0lNW3FMkQ/ln4fBaNBpLQDtjpFZ5uS2b6Q0rnVwPi21rL7zfJDk6LTS0X8gsg9Z25/k
         XbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337256; x=1761942056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KRiNp1ap25NQp6V+0Xx5744wiQSngYoe9dljgW0lUk=;
        b=I5BqPJdeNKuw1PiIEJiVq6tM+a9QwaZmJNt0YBvLO2zjWKU5KzH/+zdeoK2TDeLVMf
         FAFzA6537ayLLYhbIeB0wYdiPH8Bkdh2ZTB8QjNGcMbkCoVbwIffPvndcINCwBgTsNvD
         psA+SZnlQ//yDBOXZyPS9KwcRi37MtTMjgPHWCdyvASxlauAEnwxuCCH7Q31DQb6si/i
         aQr+jLh3FPWwnojKRnbHOkHBrhe1k++SwOXEVDAMooV5XNPu7H6RRPo4J1jOxO530c8E
         QqI9vg4l+eTvpKXfQ7XUlWlGwZl8pbUoN8miMxG77qqsUJmmhWZE0Eh55VzgkPlUhsI4
         bIKg==
X-Forwarded-Encrypted: i=1; AJvYcCUmX3FcItmiE1RKXDBKNJ4ZHf+p3zgOlv8o8ssOIwhxTzfilG2IY9oxyf3Yr2DHcvuey2n4oRFAb7NfTWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1wSNDJLC/XUCjC+G7NM2NmmsPR/52UKsJ1piSWTPMrL1zODz
	W19D4BPGcEjh3NHUXIRo/Vi93q1L2NaGWJANTS26X+72IriIzWJKDaFJ
X-Gm-Gg: ASbGncvJYfrLDwNQGICtrdjhEpo+PxxlaDVZ448MZ2WOj8SuntSGHbhAxTmec5W+GtZ
	+0DfHdcMrQ+S4EPjkJoaI8ytJMRgskQMUXQQh73GIdl3ZzY4qeIy6XiJEpA5eBBD1w4YRbUQBRd
	30FCOXl8dOdDwu7YQ8THoiwV0HLMyR4EOZ6U5JI53q+BS507gxxA5w3gWNc0FepKSiwdQBVIWy4
	oLXU8Fvj+4WvyzPEDfsWa+djog33VNE2k8AaFtIarrkwFlx7VHRhacOf6NKMsj2w2OF3lRjQL1Q
	OHXzQYwVKa2Ob3qWbVy9swThLpGZALrfsmyY+BZj1C2rnpEu0w0uiJ9Tp3mSRyZP2sxfXWMF0PD
	XnbKUthu1c6KbRtuD7BRBxjSqTjBaWilaz+MxPbbNYnXk4WdIv+GcUqx5U4hTj7TAjrqgoH1pYb
	Hryxu4ISmDK8faO1pQ+z0UTdCEkBxL0g==
X-Google-Smtp-Source: AGHT+IEbhlPACOmKZ3NUiAKCZ74uClfD7T6fHIUOPv7o///eViQUAWbiITUiLoEhOia3JIqDriWEkQ==
X-Received: by 2002:a17:90b:3803:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-33fd65fe245mr3970297a91.15.1761337256432;
        Fri, 24 Oct 2025 13:20:56 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224c9bd0sm10001563a91.21.2025.10.24.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:20:55 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: cryolitia@uniontech.com,
	linux@roeck-us.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] hwmon: (gpd-fan) Fix compilation error in non-ACPI builds
Date: Sat, 25 Oct 2025 01:50:40 +0530
Message-ID: <20251024202042.752160-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building gpd-fan driver without CONFIG_ACPI results in the following
build errors:

drivers/hwmon/gpd-fan.c: In function ‘gpd_ecram_read’:
drivers/hwmon/gpd-fan.c:228:9: error: implicit declaration of function ‘outb’ [-Werror=implicit-function-declaration]
  228 |         outb(0x2E, addr_port);
      |         ^~~~
drivers/hwmon/gpd-fan.c:241:16: error: implicit declaration of function ‘inb’ [-Werror=implicit-function-declaration]
  241 |         *val = inb(data_port);

The definitions for inb() and outb() come from <linux/io.h>
(specifically through <asm/io.h>), which is implicitly included via
<acpi_io.h>. When CONFIG_ACPI is not set, <acpi_io.h> is not included
resulting in <linux/io.h> to be omitted as well.

Since the driver does not depend on ACPI, remove <linux/acpi.h> and add
<linux/io.h> directly to fix the compilation errors.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---

Tested the changes by recompiling the kernel with and without
CONFIG_ACPI for x86_64 architecture verifying that no
compilation errors are generated.

 drivers/hwmon/gpd-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index 138cff0beb4c..4c45c0154a45 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -12,9 +12,9 @@
  * Copyright (c) 2024 Cryolitia PukNgae
  */
 
-#include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/hwmon.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.43.0


