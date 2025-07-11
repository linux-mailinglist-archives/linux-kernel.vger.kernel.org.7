Return-Path: <linux-kernel+bounces-727711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62444B01E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F9F1CC0772
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE92DE717;
	Fri, 11 Jul 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Mg20vGtU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319712D780B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242422; cv=none; b=Z98w8LHukMEXOhkMbp4urBcWZTSyXzaQEEjgDfNWMtJVFlGbIIm+P0CaooI7bXGMKlOKcZ8pV4c+od4HmaB481xhmsYQnoQ2mwkbZuhTCgT2OFF73b2Y2RMsd1ihpt0LtLDK1nN2UlOnmBRktuCmRIpD5XTdSQwFozlGGdiRvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242422; c=relaxed/simple;
	bh=WCYFclCcrsK42IAAK01Ss0/XRWTb3Qmt+dcYv5w0+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2dQ3o5wYMJkvi1VCMDDC8kzGFY5+nvCIYxr+Bz2bZ/OZlKs8n6ntMYKhjcvIxHdl0S582QfqJeJEhk5ZFkPEowVkUxa8JRJRfn0dQK0BIiD8Mp8jcdLDfibd09FX1ZGiwVbEH7waMMFNJ8/IJz39kLfFkGiY/LdhoQyrcZjugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Mg20vGtU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2350fc2591dso21781685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752242420; x=1752847220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmPdsQbDpIgCjumkrL5H7FFgimsuzlN0TDDo32sfzWk=;
        b=Mg20vGtUIngSiGJQQT4DVPHeIwevo1295TTx6h0NSwT1LPQ2MzqQdeGkwwCvO7OTR2
         bu19LtuCRue1RRFh10vOaezVsGiTbxLxUD0WtvQO4BYxoRR31o0UaNO1Tm5L1TIcDHHT
         5hd3/g12VcFs/pJWBSBZaMeMXDo9kA230NIovboKrIOkLER86Yz6BUB9RjBTTxsHEakM
         nD4dNzPwirkfUlN70PotyeAkNPuWu78oyNHiWZwrzXbD05JgVmct/OEclA2nyxNBU9Fx
         MrHjGfhXyalnASfKmgeGuxUc5gvaY0avrcWkbXzFn3XzD+29iw97n1q16c75PpvCFUjT
         itLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242420; x=1752847220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmPdsQbDpIgCjumkrL5H7FFgimsuzlN0TDDo32sfzWk=;
        b=m/z8MLh4GmOHX33IyRceSoWFAmv6lDA8eXJYRX2ZXLoN1CY3qzZECNxhga7qEYgY6X
         4xeL9Uu7DW7o1Ux+0YCohvlFLFcOSEbkPoO6YKN+WRCOO5ja8LtLMqBYk5KL+B304alW
         fc/R/ayNkyf7m6WYTVgQdGa1NbHnkIFV5ncAR7flf4fezz0i+gmNGi9p12k3uhToXTVt
         sJPFbX18XZI//97lVjDO0HCVSCGmCE4Fdxu6GnvBRQRKL0pipqmQXbkL04YUOeqjl12u
         Iumot2D/ruvk5maKSyDAYReYCpq3KOnF2sZAawn571aumD5hJ9JUvuL+BP11BAm8WJeF
         k0mA==
X-Forwarded-Encrypted: i=1; AJvYcCWmp5pm7lY8wavOLmR3Tl4h3VB6zamqGgjsO/C6pBElDU7Dh0GzVnomiJMDSXP24ADjt+d4ysYpgwu5ZPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IUx896GHG9ugvnchDLtSdO898rM/snxVavjKQJ5CS6KcCTDe
	ds3SluB4gz07djeQtO/DTQ3/MsdkBxIoMC2SYz9CGlq0b8keG9ClF5oqb5xZ1wXkOm4=
X-Gm-Gg: ASbGncvNEdtbKw7G+vMNqL3dQ9GGlnmi1FP1uPIJdrdX5i/ekQuedEFjgURf32VinI2
	T/j/0Og0F6dcFBfQVoG7sSYpwh4Oj4EOmpz5HBegthOkma5rUy2vweiTW28Ofxv3NDhGkG3dUrJ
	eLtidZvBNmeEzs5c1/xQMtlgwOwNLbcSf3c6FWAYI7rh6iHk8CXHUFVJkiUP3pdm1Zixc41qtxu
	dbVf0Z0f7zADaI0kRhCxF2DCIcqgZobDlLUeZy1jONz9BM6MX9RujM4x21TUy4/yoVnOZhN0zei
	KG+fv/amJT8EjTyN+qwgTPcq42xb5r1zEm30GQgZ/pv6uxsHKJG/uJ7RrAUTjU9gcjCAgQCwVK8
	lyVjCS5bkZjkwnQcmS0HYQqrCSn6IMri3
X-Google-Smtp-Source: AGHT+IFJ0rcsB4i4vXXPgW5KkKIV4zeIjjpkek1NMqdQXCIN7LpmxVPatDuK+xoO9TrfDZV5gowLpw==
X-Received: by 2002:a17:903:f8b:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-23dede67c19mr48246905ad.25.1752242419961;
        Fri, 11 Jul 2025 07:00:19 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae9dfsm48405845ad.73.2025.07.11.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:00:19 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] ACPI: RISC-V: Remove unnecessary CPPC debug message
Date: Fri, 11 Jul 2025 19:30:13 +0530
Message-ID: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The presence or absence of the CPPC SBI extension is currently logged
on every boot. This message is not particularly useful and can clutter
the boot log. Remove this debug message to reduce noise during boot.

This change has no functional impact.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/cppc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 4cdff387deff..440cf9fb91aa 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -37,10 +37,8 @@ static int __init sbi_cppc_init(void)
 {
 	if (sbi_spec_version >= sbi_mk_version(2, 0) &&
 	    sbi_probe_extension(SBI_EXT_CPPC) > 0) {
-		pr_info("SBI CPPC extension detected\n");
 		cppc_ext_present = true;
 	} else {
-		pr_info("SBI CPPC extension NOT detected!!\n");
 		cppc_ext_present = false;
 	}
 
-- 
2.43.0


