Return-Path: <linux-kernel+bounces-804541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF0B4793B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498AD17F8DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4D1EE7B9;
	Sun,  7 Sep 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="knBMPIJx"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF987483
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757227439; cv=none; b=ktO+iL0uXnH8Q/UlY6EjizbMl8tv0nWtu/idr0uAQeeeZMq9FCBl8Pwr6VnvN/bSim/JJ/cHjqdUnGR/rN351iLn3QLpaaslQmdGv2fneuLSb9fwPqS1dSdtlYgqyra4q+F4wpMotlz7NNYmmcTTm8/KuRulimA5esahAUg85Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757227439; c=relaxed/simple;
	bh=9NhhGR0/6Y/pCwiJcX1MJ7z/ESU7rNop+X3V4zo/jpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huQLReKuXOHFdI1pfq5chWkBZ1zrg8J0PaggOjXtpvKhgxFjoYBVIYxVnehsao0zr1wCAC74Jz5Cc7X0ba/MxTJZp4gXdHH3LfluXM1U3rgG1U0hkr0OUVfqve6EUUGz79+89nWMPDDq9Hs+a6CC6v1SZyRxMti/nXH+AUg5cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=knBMPIJx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77250e45d36so2832864b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1757227436; x=1757832236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OpiguXQuP9x2il0xGwUlgilkQSoa0hn0nGj0TEev2ag=;
        b=knBMPIJxxJaN55XGErCTcQTIdmqCGBfs/CYkVXoHbcVOwaSBetLvTJHCsbksp8Hwfx
         ocMZXXU+pC6n/S1/ZxdaTCmHUL3sOlyoqDfYk12+JEuF3UD8CZ4V+2XGxiLOa4YuuEQG
         9mnFul0x8TIz7ago7CNAWfCnVnqYIRWER3JWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757227436; x=1757832236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpiguXQuP9x2il0xGwUlgilkQSoa0hn0nGj0TEev2ag=;
        b=AIAFpHA/RykMnMgBINaeIz8W8H8mssSNsKlLmB3y7DqLhXsFFsZBc4EvQy8rbB95Q8
         32o1B+tZycPvEW4rcRe/YpI7mhoINPlB8cl+udPWh8yV3jV816AZ3Yid8baAubdseZEW
         M2YDIey3FPv2jS9W8WJlqqBhvI14kDmQBxt5Lg8iQWelIirZzcnAr79eB+bENmELdjjA
         hkqEXNcNAzNBL3Igju8YGneVlTClEugbv24w0D2xOtaxNZYzbgJd+NHppl8sPSk5di8z
         hmoqmbXsmwc1mXsAxZCopzJGHvkvDi61jTUXtN+i0C0ajwqWOV65Nb9Vi2AhYSFM54bl
         DZ/Q==
X-Gm-Message-State: AOJu0Yzaq/0OyI6KgPUARiw3Ueq0z+5hEqvuBFOc8PhWxDMRl+7+6NMJ
	cwQ/udckeddHvEx1pHRyPegIWDIHg1/0ACrEtQchto7mhzfgFha2/4YR1ZSVCEkmdr84rQLuWX9
	8NjhCCgM=
X-Gm-Gg: ASbGncuAyeKsNZ+tQgw8sylywpuwdQMYERhFvQnvp/+PvBWj2/MUNiXaxXt8wIi26ef
	5eNpJKLa1tVqVY5t9kJpCV/19Snk6ioAk8K7hQ98huJSLoEIWuHPRPoWXVQKUqpI8S1kupPPy0z
	2r2iyXp//Zx7Dk6Zn1jldDbLBVKcpNCDOFaYkpWzLmGAoojEDNqP3DDxel85STmoHrQiIua4jNk
	PZeHDslpBnXcvLkhB8irNrH/fJ9yw8t0DrmjUSh1sys7sdfUL2APpYA7QWAFm10Z1Y8nFoQu8cK
	nqZUxWa9efJqTTrtE46uWL9rqfmQi7PFhOXZ8j7wGpg93F8ZL/Ry6H2Q+dpo4S+2AvBYeCF2Acp
	RB0nYuoU6iBi679TwSWnBF7PuRcd+tKaVNX2C+MAh5DhGDyN23lEpEWLtoIrQQuV/BABOEURkCx
	7mlmk5zLfitgBI
X-Google-Smtp-Source: AGHT+IHP5ScV4aY1LkVwEH2zOVhZNoxO1acZqniabJZLZvIYuHyObbl8YIm7jWrIDyiql/dg/ISb+g==
X-Received: by 2002:a05:6a00:2345:b0:772:4319:e803 with SMTP id d2e1a72fcca58-7742de5c53cmr4568348b3a.30.1757227435978;
        Sat, 06 Sep 2025 23:43:55 -0700 (PDT)
Received: from kinako.work.home.arpa (p1553119-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [153.226.101.119])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a4bd1ccsm25840740b3a.47.2025.09.06.23.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 23:43:55 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
Date: Sun,  7 Sep 2025 15:43:49 +0900
Message-ID: <20250907064349.3427600-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 8139too is probing and 8139TOO_PIO=y it will call pci_iomap_range()
and from there __pci_ioport_map() for the PCI IO space.
If HAS_IOPORT_MAP=n and NO_GENERIC_PCI_IOPORT_MAP=n, like it is on my
m68k config, __pci_ioport_map() becomes NULL, pci_iomap_range() will
always fail and the driver will complain it couldn't map the PIO space
and return an error.

NO_IOPORT_MAP seems to cover the case where what 8139too is trying
to do cannot ever work so make 8139TOO_PIO depend on being it false
and avoid creating an unusable driver.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/net/ethernet/realtek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index fe136f61586f..272c83bfdc6c 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -58,7 +58,7 @@ config 8139TOO
 config 8139TOO_PIO
 	bool "Use PIO instead of MMIO"
 	default y
-	depends on 8139TOO
+	depends on 8139TOO && !NO_IOPORT_MAP
 	help
 	  This instructs the driver to use programmed I/O ports (PIO) instead
 	  of PCI shared memory (MMIO).  This can possibly solve some problems
-- 
2.50.1


