Return-Path: <linux-kernel+bounces-744707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69EB11005
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBB21CE845D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29792EAD0E;
	Thu, 24 Jul 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBn6w7sw"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E32EAB66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376212; cv=none; b=c2hbIRPusPciyLrzhbyNhciAU2c4A0ri2cLS9KDUYdFjiCJoBaAjQjAEoGSm0UkSuuU/qnOpPw3IxHz6p+9hXaW4DHKjjbCQINeiZd/n6/fjovf5VcX92wHdNyl8r0X0/gpSuwgSeNZv2sioCcJEifqbQFIUkvuEyuxQzG3Da1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376212; c=relaxed/simple;
	bh=uJGbBLnOIx9G9aFmKA88U7Wt6IlhqHCuGklS/cfxJaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j16f0zKKvfihYlJyZYhKRPaEL/X2/hsBbofYoLjo9BBixqxmyFmzGrV/OLF4ha5iuCrVmUCuRI5pyx+gzKq+IXhv0WKBCPm3R7FlV+L2vgtF35+XvwFtCjUHO221OCZxu3N97PgSFQk9MYIf5JlwvTdzLi4uLxud0lmK18zsNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBn6w7sw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75ab31c426dso1101506b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753376210; x=1753981010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYcAbkjc4Tkr2KyQs05DD+oyBfj2e0/3qety5W33Bjk=;
        b=WBn6w7swVL0KyVCWPjnN0jz8ZxmjOHBn3iShgTHl38oHNwd1vV4XLMTk9z+3Arqv3X
         KpPDNITDfPRZYd3ccE5mS8T7W5E9XNy3DoENd6jo7mF4n/0M2ad7Xhprj6o3OuE1QqCH
         QfVKFlSMCDGnPK0OrrxxC3+Scqhc4VunqVgS+OHKgZGLojh8SigbxaD7FfS1kT775eB+
         2u2oBQ05is75F/z7BhM8ZzM6oPVPJWHWSRENg1f7JJLXYhk5TdnA3zCkXW4+NmuMcPWb
         WbNFy7Ma/ucYBh415vyMKdeIhKPiE5kzogujZK5cJ8hFS6YwpRQk/9LhuMvr+a+V18/x
         HV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753376210; x=1753981010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYcAbkjc4Tkr2KyQs05DD+oyBfj2e0/3qety5W33Bjk=;
        b=ZmQMxKe2kKGcoWv2T5yehOqKsEMi2Yx8sayioWw0T5w2lAH/VTKZohrErlPWMP+9Zv
         uGlt2QYY8xeUFkfQ4pegsl5qxzAunjjdzQcwWkM0yeXe0BYcKZ+g/drDtpbayZDaRQOq
         rJzy9CeQ9tYQirlVoxo/lgbDv+D63Fx/CMPS89eZETuov7f8KDg9AVodBopK9FXL62eI
         S+vx7hBOZfy6V6GHXI4JHKvmvMZ/SX2YpPA1Upi4p7gDe6X0c9WU1MB3eTLDLgNATsRX
         kJWEe6BXhUDP6Y3Ky37X06pAE89VnyTnfTXwIKuTobN/zI5Mp5OA9bkDIgVR2+O/seZ7
         2tdw==
X-Forwarded-Encrypted: i=1; AJvYcCWGHjsRFH5fZiyut4XBwMM0jlAkcu6Zkw0F+8L23NlAB0l2B88nw2Jxmw1EmI+f5WbSSnQjFzqlFt1M/fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjeItUzIoGFdY/cgdm8K/17hNiGXPbooTUIe8tk+6ahttpy15
	xSa3xHyZtGS7EibCXWApmEzbqJzbcap+uObP84j4GhMpfvFUCtKNb0+w
X-Gm-Gg: ASbGnctdIEKQzTv0f8QQkgUpNBVdofql2dXPLjDEfG1HGMAcxOrj656N5egMQDRlCJS
	l+gziZDjTgX/G3IN1x1mt2vxHs+6S2WGlbYSj9Q1lll3CSVrReFSXgsFpgEkHXwc5US1OT1rBbs
	7ItHzzUQTH9sGe2wn4A8Gid6BBMePpZLbNeAwrkES5URKszISLAk5G5gM/+zxqiLlVyBUTFlnEo
	ou3lPIz1FNDEJyd34J2flrXkDH8UgeNVfC42inIKaieeTkBiUFB9k5WdfIX1PM11PUgF6QWnX6G
	Hl89E6F20j0uTMKs7NAqEwm6ZK0Zk8z+pB8t046kgsxw/u8w+YLlJYAWSTVV0niGgSOQb7VHYhS
	narzX8+t/VgqHg+s1UuaM/+XYO7dJ/nvrhg==
X-Google-Smtp-Source: AGHT+IEx1SRGfdVyHhlPutv9dzQMR/t+xKkZ8lw/2GL680PVA3DqTsdXoJDkH0z2PXFFMimZ5OowSA==
X-Received: by 2002:a05:6a20:9c8b:b0:23d:4777:49c3 with SMTP id adf61e73a8af0-23d491bf059mr10760796637.32.1753376209985;
        Thu, 24 Jul 2025 09:56:49 -0700 (PDT)
Received: from archlinux ([2401:4900:6318:9e23:f078:c919:e302:8d2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c1261e2sm1786314a12.66.2025.07.24.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 09:56:49 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] arm64: allow NR_CPUS=1 for non-SMP and adjust default accordingly
Date: Thu, 24 Jul 2025 22:26:39 +0530
Message-ID: <20250724165639.13926-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 Kconfig for NR_CPUS previously required a minimum of 2 CPUs.
This patch changes the minimum allowed CPUs to 1, enabling single-core
non-SMP configurations.

Additionally, the default value for NR_CPUS is now conditional:
- Defaults to 1 if SMP is not selected (non-SMP systems)
- Defaults to 512 if SMP is enabled

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 arch/arm64/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 393d71124f5d..9b2970f7c5ec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1528,9 +1528,10 @@ config SCHED_SMT
 	  places. If unsure say N here.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-4096)"
-	range 2 4096
-	default "512"
+	int "Maximum number of CPUs (1-4096)"
+	range 1 4096
+	default "1" if !SMP
+	default "512" if SMP
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.50.1


