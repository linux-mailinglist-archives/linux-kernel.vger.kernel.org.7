Return-Path: <linux-kernel+bounces-759215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D8B1DA6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CC3562A55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168CC25DCE5;
	Thu,  7 Aug 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEvmgt5x"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD41411DE;
	Thu,  7 Aug 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578290; cv=none; b=ChvfMgAJCybLCKUrnvhAVAsPDM1fe7uSlBtq1FzF+vuZkE3a1Ss3+y0jZBDvpR2tNZmxjMX90C/RsGjORyGaXTpyx8gqGnuVzhZCpQmExdpRwprkhQvykXgv28F/zb5ujCbO2jwr9ei081P0w8iNxpiYKyNVcJY8PRkIninq0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578290; c=relaxed/simple;
	bh=Uqx2K8iqj8C9J2fe3pyivDhLY31N5WS3GpKgVecfeqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbBrI/FKSpA+F0ko1WEhRMV4yO8FluICxT/ucQXN0aG8furVabnv8mK/CfYn1YyhFjW+rkq3aHX5bHatxf4S82GroGPHCwYblHCPA7UXrY2bj02KF5fT7zuWhzvBnZX1kcaGw+yXsS4zMFqUOrvgXosBQdblYBo2POkZtrDvMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEvmgt5x; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so1249393b3a.2;
        Thu, 07 Aug 2025 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754578288; x=1755183088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OzOvhq3GmbvaBtGUgAaXSZiV6ZbsCylTW2ygbBRF/o=;
        b=aEvmgt5xVj/YsLqy43drRU2tXYMHik4IUi6wWVjhp7aIR1rdGHdHVpZ6r97JjmZzfF
         gR5KX3B8SDL53zejojx7dpJNRK/om+CqBUixE2At8lkL+XS7ve0PsFnVXUGx8z6WnXQn
         iuRTcqYpHrraosyF2vu6cSQjLZu3uN0T19Fa1PNgVd8pc99CBcG6utWYAARDdRRuBnTX
         nxndxQZFz17SfL/+iksZXDRv2h1/zPYjCtRbO87IJV7sjNO9spuINxCLOZBmG1nNTbnh
         U4pD1t8Dr2BaqW/zjy4pzJ9BQYESnNE+EDe79FL+SjdC7yg+oRaBlf3/K24djyHIsvSG
         eeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754578288; x=1755183088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OzOvhq3GmbvaBtGUgAaXSZiV6ZbsCylTW2ygbBRF/o=;
        b=AnFpB6OJBKvlVL0Fp91oAIdA+rnqwKjZbAnhka7oiAiZXGiq65U/Y4iHfkmg5QWmXi
         eEiS7lnS933TOgLtM/k8mg1OrKMsqxQehU7zUi/J7d+NPzTqHXp57HONMl5W/sqYCDCQ
         VUyBXLqhJKHAODKgy0MeHfBLKb6fUr/jf/niac0hZzIEiJHjijKpXQPz3OOWtezOKPL/
         EVvrlJXdb3liugnvA8aRT8TSOcdbAlECFCyxb1x5tqyCy+GrJBUatlhNdjuXKpz/2KBr
         kKislSgwNHtOMRvbghjai2Z5Y4AU9Ja4jDNTXUi5Ww52X9Ha3VEXbWReCJOOXmbpYvxI
         ap+g==
X-Forwarded-Encrypted: i=1; AJvYcCXVoLNR1wVojNcOMMbd0WfHrCYKQDyscHI8tSFg7x+eMQefQJKxjlvA6U4W7Ndpb9jEUDDWbgw4fs8pEnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76KsMmCIfvTbil7vNqrTCD016t5h9b3jQB9JgJweI5ByJNu/s
	I1Djj45q663UFFVcrfcRPxPJW6OA3rVsAmiReVmefPLHgriQoh0eYUgd
X-Gm-Gg: ASbGncsKrsmtWox+8YpPKdD+e0BquuCtogXnVOYMqj2UQVB0FC/f+z0e5nkTS6jQdDF
	U/mXZRtvWIGxj4d1yr8QUkKgyZqqhFi0m9dZ8juLG79Mt7TU9wtefCU62+853pdxtkcr/6LMetd
	9LXpyHlGQTvhWdBUBshDid/iMCozVTBiPKc4wbZZ2fHAaLhk1GH5xqUpdcU4z14Aj+8lIwFvMt2
	CYv3BG1NsjjWpw4rWKdO7zlDkpkZv1AT1qbnqVhvdqo/xf14by1O/aksslLUX1WugMY1ecF9l6t
	GrAgGhuJZPfXEq/dTUDxLgZXxofzqSGVNRsMyxYhezGCxibnR4oB5uaHmPI7bt5TMeKlmy+U9/s
	dZLciop9MFDQfQ45KYi4iyQtJ6745H2rZVpAeLNVXmZROo8acM2+/Cqe7PM66fPA=
X-Google-Smtp-Source: AGHT+IGtphOkrCppTiHiV45+Qe9W2hQNmX+FpcoXnXXadWOHWcmzG19NrBZWjxt3jESoe+Rbd+mthQ==
X-Received: by 2002:a05:6300:210c:b0:23d:c4c6:f406 with SMTP id adf61e73a8af0-2403159487dmr11371637637.43.1754578288227;
        Thu, 07 Aug 2025 07:51:28 -0700 (PDT)
Received: from ak-workspace.tail730999.ts.net ([49.207.200.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d6csm15569174a12.38.2025.08.07.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:51:27 -0700 (PDT)
From: Akshaykumar Gunari <akshaygunari@gmail.com>
To: corbet@lwn.net,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-doc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Akshaykumar Gunari <akshaygunari@gmail.com>
Subject: [PATCH RESEND] docs: arm: stm32: fix typo "busses" -> "buses"
Date: Thu,  7 Aug 2025 20:21:19 +0530
Message-ID: <20250807145119.2214-1-akshaygunari@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the spelling of "busses" to the preferred form "buses" in STM32 ARM
architecture documentation.

Signed-off-by: Akshaykumar Gunari <akshaygunari@gmail.com>
---
 Documentation/arch/arm/stm32/stm32f746-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32f769-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32h743-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32h750-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32mp13-overview.rst  | 2 +-
 Documentation/arch/arm/stm32/stm32mp151-overview.rst | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/arm/stm32/stm32f746-overview.rst b/Documentation/arch/arm/stm32/stm32f746-overview.rst
index 78befddc7740..335f0855a858 100644
--- a/Documentation/arch/arm/stm32/stm32f746-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32f746-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32f769-overview.rst b/Documentation/arch/arm/stm32/stm32f769-overview.rst
index e482980ddf21..ef31aadee68f 100644
--- a/Documentation/arch/arm/stm32/stm32f769-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32f769-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support*2
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C*4, SPI*6, CAN*3 busses support
+- I2C*4, SPI*6, CAN*3 buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface*2
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32h743-overview.rst b/Documentation/arch/arm/stm32/stm32h743-overview.rst
index 4e15f1a42730..7659df24d362 100644
--- a/Documentation/arch/arm/stm32/stm32h743-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32h743-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32h750-overview.rst b/Documentation/arch/arm/stm32/stm32h750-overview.rst
index 0e51235c9547..be032b77d1f1 100644
--- a/Documentation/arch/arm/stm32/stm32h750-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32h750-overview.rst
@@ -15,7 +15,7 @@ It features:
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32mp13-overview.rst b/Documentation/arch/arm/stm32/stm32mp13-overview.rst
index 3bb9492dad49..b5e9589fb06f 100644
--- a/Documentation/arch/arm/stm32/stm32mp13-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32mp13-overview.rst
@@ -24,7 +24,7 @@ More details:
 - ADC/DAC
 - USB EHCI/OHCI controllers
 - USB OTG
-- I2C, SPI, CAN busses support
+- I2C, SPI, CAN buses support
 - Several general purpose timers
 - Serial Audio interface
 - LCD controller
diff --git a/Documentation/arch/arm/stm32/stm32mp151-overview.rst b/Documentation/arch/arm/stm32/stm32mp151-overview.rst
index f42a2ac309c0..b58c256ede9a 100644
--- a/Documentation/arch/arm/stm32/stm32mp151-overview.rst
+++ b/Documentation/arch/arm/stm32/stm32mp151-overview.rst
@@ -23,7 +23,7 @@ More details:
 - ADC/DAC
 - USB EHCI/OHCI controllers
 - USB OTG
-- I2C, SPI busses support
+- I2C, SPI buses support
 - Several general purpose timers
 - Serial Audio interface
 - LCD-TFT controller
-- 
2.43.0


