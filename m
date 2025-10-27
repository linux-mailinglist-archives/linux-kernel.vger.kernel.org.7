Return-Path: <linux-kernel+bounces-872429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51738C1110E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DDE19A7F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4E328634;
	Mon, 27 Oct 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMiaqc+O"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE3322539
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593197; cv=none; b=bUdgITUascGQ4F7T9GE1Wx5V4EcNrRbN7silAnEPbmkFCDD1tzUFHAxhT/afjGmq2rXpnUzHb2SHWbT9c27hSMyZNTDsnszUKPUQScrd/n6CtaUZhiUx0a8uyAOWlyAHwWlVcBa2lxJlrmbiRK8hbP32PfsmuP4kP8ijZN+pGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593197; c=relaxed/simple;
	bh=iQOzmEJHlgxLjp1nbGQtHxUZf94hiD6IyzJ7eGBOWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnWGAtYNMrUncOkoRUCVSS+04UDBIiFyK0Celr5M5nL+2VF1sDiK19Tz+15lzVB2p8fD38oCADrpTaOVLLWhod5/lHo+2nWtkkJ0j6mTXBNFLC3tMqyRIo3M0NC2t8A/qL4qzCgV1tqw+GdtyJhgg40UWb+1IFuYYPfI78nJmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMiaqc+O; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1206441066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593194; x=1762197994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AlOW5hBp20/42EbC8lJVEdvKeYhWhq4EPh9ulr7sv0=;
        b=VMiaqc+O37V4hJB977/uEa9gjAUoEABTJNDDuDtnO0juZ+pIE4Cap3BvjBjXtS6iIy
         OVE9CLLetDNsM/9vj29kFNdtjCK/K1309SN3GKCOXH2J6+/T9X/J2OD41KRqLEhc7fGK
         WEav5lRbPfdLr1aclSM1YF/UG1mu91CKhXAhdoDfGwcO+A24f33IOVy7ySRjk5sVr5QX
         WyXX5lKkLXi0foeGuE/6WLBh5pPnQDB6NjnEARudEmS52wQj4LCttZ/Ju+GTHcCHoJW1
         rP2d7UHSfdcVH2g57AEqBebNuZutFblwCK3B8Gbl4g9b2XZeISW8u6hqb6DEA8nVG8oj
         EsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593194; x=1762197994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AlOW5hBp20/42EbC8lJVEdvKeYhWhq4EPh9ulr7sv0=;
        b=oqE8PoHF30m5+MaWI3woyu4gzQ6jEBf3n+BWFjMUa9B6aEbgWMvdsBMEWAGFt5IYqt
         rG3owtZQ021yN1pFy21S189JRlXNr3Oux2ONl+m+yw9Fy475xomOuwB35fjYuQLuy0Xc
         9jILny6RsOXvsAO8vhuLxuRZ9p7e34ssaq39suLe5GlDcfkiodcAfJT3m0EaDKOCotvj
         /vZUo5LRzNyq7UPE2BZz+Yut1esRpF7mxEya0GBqoR0gr8DwqxMl2GTjPlQaTnkzTCaO
         wC8owRwKDjU8dDqB0y91Z4teandpk3GgTMhYCU66LqHnwb5pehyICn5Hd239gj9k28I5
         Cu0A==
X-Forwarded-Encrypted: i=1; AJvYcCXGPkY/S0HO1GYreISR2PS41vw+zmt1wEDFbjibq51dLZLwIzc2Z5PQeUxYX5cKRpHX3A3D8Lc4SVSXImY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlyn/FShleXnKhn9WctklLL3txcnjI4zRT9w949LHHgQT0cMai
	4HeBK1fFRIrp45O+1yCMvhVpldztmEwFpYRaJpg3hFn9zVJVLIBdmXUE
X-Gm-Gg: ASbGncs8EPGuH3EKFRTfHJW04iSweU/xfPuE4sjIhdESEdMjIqb4TP/VEhQlp8Jw7bd
	/XU2GRp0yWlcMDh8anqgzoLUEo/Kr+GFOPmKL1Oh4P5/UBkPom1ZOadkaNzUBe9OVZ5rP0Yk5Xf
	WXxmmUkeVDLfa92DF4wygpJAR2p/HCYEULNZs5j4+3ISOuNC7AZs/cD42hy4MkqT/+fA+5YYeR+
	VwzgCYxuFqcB3/Dwc4UahdAoGm7O4439G8o0UBbpj+ZwoO4+i1ydEKAbtFE1cHTMvx8aem43rrN
	ZgR26WmSrLU/t+WE9cQI9hn6R2DSwo6/KBHQD5Dx3CPims8uzYWdn5phf+m7V8QxA7U3ItBj1/G
	ERnUwKXWE1y8Ns3KxVjzx0Mh3CktPpRIaWWMMXQXbbsRhd53KIR+3F2NIlfTtuu8Z1ESmiGYqRk
	S7H3wbdhA7Vfib1lJ2UG1PYG84ec23Dletwe/SSQcVphXk5a8ZBe4bHCVhL9mA+i8Dfg==
X-Google-Smtp-Source: AGHT+IFPiHMTL3g4M/qClrSKQXF9o1Cf4JfpI61mEzl81YLLDBQ+Ab1xTA/JPrbROMed+uVjA8bs+g==
X-Received: by 2002:a17:907:1c02:b0:b6d:5840:4b43 with SMTP id a640c23a62f3a-b6dba48eddcmr105014966b.22.1761593194001;
        Mon, 27 Oct 2025 12:26:34 -0700 (PDT)
Received: from localhost (dslb-002-205-023-060.002.205.pools.vodafone-ip.de. [2.205.23.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm863403166b.37.2025.10.27.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:26:33 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: ACPI: i2c-muxes: fix I2C device references
Date: Mon, 27 Oct 2025 20:26:28 +0100
Message-ID: <20251027192628.130998-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device references were changed from relative to absolute in
commit e65cb011349e ("Documentation: ACPI: Fix parent device
references"), the MUX0 device was omitted from the paths.

So add it to fix the references.

Fixes: e65cb011349e ("Documentation: ACPI: Fix parent device references")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 Documentation/firmware-guide/acpi/i2c-muxes.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
index f366539acd79..96ef4012d78f 100644
--- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -37,8 +37,8 @@ which corresponds to the following ASL (in the scope of \_SB)::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
-                                    ResourceConsumer,,)
+                                    AddressingMode7Bit, "\\_SB.SMB1.MUX0.CH00",
+                                    0x00, ResourceConsumer,,)
                     }
                 }
             }
@@ -52,8 +52,8 @@ which corresponds to the following ASL (in the scope of \_SB)::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
-                                    ResourceConsumer,,)
+                                    AddressingMode7Bit, "\\_SB.SMB1.MUX0.CH01",
+                                    0x00, ResourceConsumer,,)
                     }
                 }
             }

base-commit: 9e9a765418a5b45238a0f537c38fdd86dba6cf1f
-- 
2.43.0


