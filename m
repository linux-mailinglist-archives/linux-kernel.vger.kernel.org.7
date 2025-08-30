Return-Path: <linux-kernel+bounces-793131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FCB3CF07
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6727D560D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB62DE6E8;
	Sat, 30 Aug 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbGC4VJl"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86722A4F8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582109; cv=none; b=JvcYM7AYZ+QSNuqm/r64/ZchY0bFrzpXJYGnD8usuXXtj7pggZ9boTa57v+kIBgMzNMlAw14aYJoxxhO1UJ4811JWIqq72PRax/Krs2p6d037JxwZKekevU6NGiuj/Sb62SVOWj3QPYiard/WSLFhnfBnhM7CMuyBfYjj4Iks98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582109; c=relaxed/simple;
	bh=oJG/TVa5kFYA2BMVb6xJEfSPkTqtEo73EQX6Xp2xRS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YxAw3+BbiQPbHE/+mxzuZhd+ihWGgfW8+bUvbFUNuTS8MLWKkOeU6nE12zdyOIeVriluzTBdzRbWZz8q+bvtrg3x+a2u7bO179WTqXUdRPdQ/88jsUv6mqdWFZ/6vughjjj6A97DOyM4Wr+9mTKC0QjeOSmVA7f9G8Bl8X0L4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbGC4VJl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70ddbb81734so42333286d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756582107; x=1757186907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcyZ5Cw0uBkTku0BAxgJDrjdWKucoWJcYDqBud/89tA=;
        b=TbGC4VJlHs+oEVf87qRMnuja/caligV+DoTVmOp1XtEJWBuAjMrpI6B6PNMB5tv3zA
         HhflhtkZYzLrBuEEoVP7TkNCBrp8eeMxlkEM0SiZEOBNwuzoeO0z+hDX3kWTTkmjpUBq
         QoNqn7tZqNygWlnfmsEgR7of3rJsmeBGBHLS8JWSD78VxSRcqyUJZMnIPD/taWldmJ53
         lLlqpgPrJ/v2xaNB+VQ5GMpAKHV5D9Bl+/Dk9I8R6QYuOtnfu9RSQngrmduS4NK6u+H/
         N25nCjl9qXXhQ0tWT3Yvm2kTrp0V69IDzorNXu/o2w+0CECS38aiJS0/8ulH/ClRHqwz
         dlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582107; x=1757186907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcyZ5Cw0uBkTku0BAxgJDrjdWKucoWJcYDqBud/89tA=;
        b=g7WVnOTvYA+qhjn/XcXO2tzgnu8y5lMqMFr3Isorce918RnXgXLKLf9Hd913W4pBzJ
         /iC3tgkKIucxNewsCQPiMPsApvuBFLEUbTP2ZSQRbD20zLMLKGMNFE4N8QVxysozjDnK
         4L1mrpObyGyJldDpES1+DBTT7H1cd7gvAcnSQq10UebClUaxRNrvJUmMxKv+oY/XAiHT
         JPAcTEaYR9W8r6hOiFAbJNHjUy7oLLPz2D8OUi11i9hy2g8PwBMWPup1wfZQN+bKKhfQ
         aBHO4G/QTswdIO+1TlLqo24L/m/WgKAzY628PbMmMXgkpZdu4ccE3ZCcpc/S6nt922ZQ
         O7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8rD3iKmCN+f7x5LR4+EXDPEC+uXQQQ3nwVU6X7WloOaAmBM/7fxn8YOZXfW4XcF4BaUOiMpUBoHLe3iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5y0GoWWCJPEeM4VIeXqbx4zr3P49Bwq2FAwUKGcel0akwc9e
	OTIBMr9ROJnmmtZnMvMMFFlNZ9MEMyhRuQVzzRgH8FIdfndlwvu/QkE=
X-Gm-Gg: ASbGnct1nW/S/rzcwy2FGM/Jhj7R9V1JanNldkxq64pH47cAO4V6qrOcbVD0Oc2iMMu
	WUAFp7CW6dN7yFcf+DSIQOsPSE7qjtDAQvXtQMwpyfOLzr2sMkv5dSwEZouzdkY2aB4UKzaMzb5
	eTefEA/Q2PcOECaVFUV9/Qigzz4Uk3Ko+XmKyPoNvv2UdNdgXpDoAb1Zodiq1lB/d9Im40Xu1KJ
	nJ6EBI6SSfIVUfklzL8nePW/H+/mRefR/NCrjBnLxEzs4wB8lVNCtlX0UN4rZzDqCRBfrxCZekb
	n3xyhTbWE+ZFTtsAbGS0syEJvGp7KRNzpDsJwyEk7cx+sZAyvtoWXeoZnN1YgS143WSRC11ai75
	bzumoIStRuUyYRY6BLRo224FVse1fDPA8SD2fia6M/pSfuQ==
X-Google-Smtp-Source: AGHT+IET4GpYNiH2XSNfnZvQw6H7+IwVhdbLOphp0vRWo+P6A+YSOpnvah9xcSkQU/IODYTPxAijrg==
X-Received: by 2002:a05:6214:2686:b0:70d:ef96:b38c with SMTP id 6a1803df08f44-70fac964655mr35601036d6.67.1756582107180;
        Sat, 30 Aug 2025 12:28:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:68e:c28d:1818:9595:da56:53b9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb26016cfsm10216166d6.17.2025.08.30.12.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 12:28:26 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux@armlinux.org.uk
Cc: ebiggers@kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: defconfig: pxa: Remove duplicate CONFIG_USB_GPIO_VBUS entry
Date: Sat, 30 Aug 2025 21:27:45 +0200
Message-Id: <20250830192745.206491-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pxa_defconfig file defines CONFIG_USB_GPIO_VBUS twice, first as
built-in ('y') and then as a module ('m'). The kconfig system correctly
uses the last definition, but the duplication is confusing.

Remove the obsolete configuration to resolve the ambiguity and clean
up the configuration.

Fixes: 2002f3968714 ("ARM: refresh defconfig files")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/configs/pxa_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 1a80602c1..70489f355 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -498,7 +498,6 @@ CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
 CONFIG_USB_CYTHERM=m
 CONFIG_USB_IDMOUSE=m
-CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_GPIO_VBUS=m
 CONFIG_USB_ISP1301=m
 CONFIG_USB_GADGET=m
-- 
2.39.5


