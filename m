Return-Path: <linux-kernel+bounces-818437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD0B591BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591B1165D31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C3286427;
	Tue, 16 Sep 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/jYVygX"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6C275B1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013641; cv=none; b=fA3q5lyj2O8vT6rXUiMkJR+eSV+Bgcjx7n3xHjhMd027EyiLSVacgvOQotYTGb37MImzJARikcNeS0DXP7Hom4KYFlNYLKkQ+kOPvCO2lrrlytjZLnaTRU+iJ4NWJyhNAra2gzmRtfi+Sju3lTFKmQv/BKELKVUzyZVuHfcYpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013641; c=relaxed/simple;
	bh=5ooUVIqnuNrsVLTe5d4hJ5HkrOZupo/iH+rcDvzKvoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DNQI0seD8Fp7SrvgMZ1GC4ce5yyBSVMn2PYnVyynSc4Oc+2ObXJ8BfWq0IMfpapYRVo2kgUbQk6xQTkG96sQ2vr7luNSClqzDV8fo/OwFj/+nq944h6C/YfXf9rxi7AdBeWCWuW0EoM9x1InI0/h1Vu+Ol81JyojK3J94qHaqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/jYVygX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso38152605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013638; x=1758618438; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2sIITgEDWZdcO/sXZ85Mvn3hZAdFIIPOJDbEun6R/M=;
        b=M/jYVygXvs4cSTAJL9j3dSzFQ+btiZA21hzrdTRd/qm7Z/iIF1rhKGs0mTUxghr+RG
         IuJycD/irs9EktXZSiZNUZjVvXw8HboD3oasE+fst4KLkhvXj2I8CatuM9ajUyYkT7OR
         v9l0lDIHXx91GUmqAiFSe6usGF+TBYZunmaxRtkXWsuXFQS7s/Dm15n8ld9jynbVMvoA
         SEdDVeJc53OFQtAu8C2RR1FFk+kbBzQMW4Yd7uGvCx0es/cYREBhYV0uTGsXFhLLQclQ
         pcpueEoIi6xgs3eXunPo69fYsa04HeQbq2EeNa4owlAB95iwT3MjHHwNjt6JrCfKqIkS
         Dp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013638; x=1758618438;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2sIITgEDWZdcO/sXZ85Mvn3hZAdFIIPOJDbEun6R/M=;
        b=hI1nBfkjMUBCju6NvTpU/xLKU8jpE+WwUwFMmC2J4J9arwQxjhPgRX9F5/7cUgVfNo
         HSAODPiGPUN7gTyR7mJliux+DzYX+Mxs5vAsh6kmCVQiP0QglPyrKKd97z/PlzB1G5yD
         yDHAobd2qCi5/Gp9d29Ix2GMRdLwCxZn5XVGQGfDGDXKS63LBdryPkp8iKLCicHRdxgK
         t88EoD4aL7fuZpMB/S/8dyJPxsLNLqciPOd5+7U5YSF5zKN1gE/EjUw59onujjQLKvUl
         EQTEH+mI/IKefT7tsiCUgLd+C4zPpSqsq6hc/2ljea6mFQV0KA0wN1dl7pUuZyl+LymS
         6xJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPhIti49j1K/P3KlIPGzpciuxIyNB0Fx1e/Jy1nXgl1PLSjzLtsND+GfX1B6aHQ0eRLGJMCJeDIMLqv8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoD2+B4JY3l+rHQceJ6zLha5BKgnIhZEjLUim2lja53pzMNBug
	NC2nqbcChLW1in1ns1G1FmCxXB/lKFIR8RzI9YKN45QiFF2cgdEhklUU
X-Gm-Gg: ASbGncst6w+E92X7IxSN93LzDXII+rMD3S6FTMK8ie6utT1J4ELVBN3LVsuWnQVWyCd
	w/yrQbiW9ng0cerj915rmTyk0MSwlKYVl/OBbkqe/pFD8yCBOrW+ALR1adSv5ZkjfNdPAP9ZLKA
	BC6IS1zK6VtQI65cB9YKocYGkFx3RPvzcTAdJ6M6hG7e+E5aLwP9cxRZwHEn5dNIzLZ0zqOZYFD
	+l9xMANbV0zmweE7v9CqefxWvnM/3OAsFy7xQoTQkP1DCeTIWF1hGPITUvVxOM+WSEn9wrZQiYr
	9q+Qk2HAes5Io3vkyefJcJ7+HWOEV984b5U56IdCAxu9GSGUeCC3TsT52rKBML+KWETQI0gOXEn
	s8QkwQ4jls5dwGnzn+PN30+1Lh2sHRjISiNwvqPIs/ymIhUnuSAVDqqlGwn94yaYDnWkZPm9AKO
	RtzNtDfFrXxJ1X+Z1VLqEUlZX55DM=
X-Google-Smtp-Source: AGHT+IEuR5WQEBjj4/xvD5G9A1WwnGivKz0/sMVmdKU1XiTsdSofMByYMjzCbnjKIX3aOCcY/494jg==
X-Received: by 2002:a05:600c:1992:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-45f211c8437mr129293605e9.2.1758013637683;
        Tue, 16 Sep 2025 02:07:17 -0700 (PDT)
Received: from localhost (2a02-8440-7509-4cd6-9055-f88b-940e-15eb.rev.sfr.net. [2a02:8440:7509:4cd6:9055:f88b:940e:15eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32081248sm15568305e9.0.2025.09.16.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:07:17 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 16 Sep 2025 11:07:10 +0200
Subject: [PATCH v7] bus: firewall: move stm32_firewall header file in
 include folder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250916-b4-firewall-upstream-v7-1-6038cf1e61d8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL0oyWgC/x3MSQqAMAxA0atI1ga0WK1eRVxUTTXgROoE4t0tL
 t/i/wc8CZOHKnpA6GTP6xJQxBF0o10GQu6DQSVKJ2WaY5uhY6HLThMem9+F7Iy9I6ONsSp1BkK
 6CTm+/23dvO8HXeR4NGYAAAA=
X-Change-ID: 20250916-b4-firewall-upstream-dfe8588a21f8
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Other driver than rifsc and etzpc can implement firewall ops, such as
rcc.
In order for them to have access to the ops and type of this framework,
we need to get the `stm32_firewall.h` file in the include/ folder.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
This v7 is a subset of the v6 and other prior versions, splited to simplify
the review and merging process.

Changes in v7:
- None
- Link to v6: https://lore.kernel.org/all/20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com/
---
 drivers/bus/stm32_etzpc.c                       | 3 +--
 drivers/bus/stm32_firewall.c                    | 3 +--
 drivers/bus/stm32_rifsc.c                       | 3 +--
 {drivers => include/linux}/bus/stm32_firewall.h | 0
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
index 7fc0f16960be..4918a14e507e 100644
--- a/drivers/bus/stm32_etzpc.c
+++ b/drivers/bus/stm32_etzpc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-#include "stm32_firewall.h"
-
 /*
  * ETZPC registers
  */
diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
index 2fc9761dadec..ef4988054b44 100644
--- a/drivers/bus/stm32_firewall.c
+++ b/drivers/bus/stm32_firewall.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/bus/stm32_firewall_device.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,8 +19,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-#include "stm32_firewall.h"
-
 /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
 #define STM32_FIREWALL_MAX_ARGS		(STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
 
diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 4cf1b60014b7..643ddd0a5f54 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-#include "stm32_firewall.h"
-
 /*
  * RIFSC offset register
  */
diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/stm32_firewall.h
similarity index 100%
rename from drivers/bus/stm32_firewall.h
rename to include/linux/bus/stm32_firewall.h

---
base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
change-id: 20250916-b4-firewall-upstream-dfe8588a21f8

Best regards,
--  
Clément Le Goffic <legoffic.clement@gmail.com>


