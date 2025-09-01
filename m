Return-Path: <linux-kernel+bounces-795066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3FB3EC72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774502C026E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11630648D;
	Mon,  1 Sep 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYCOqMIp"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763241C5D7D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744952; cv=none; b=CxzlzN7xUTBELC+62J5S3m3W9lagg18fghIfXAvAV0M0oZPQYwtm+Y7svsHLiyNpgfQO9vtd9bTnxJ2rAHLXttMVZpKA8fYFx0Fnq59ZBDosPskycgLelGXZV95wYrod0sPn5vVY0zJM2CifmMmZoz/087PnG3mAvGGrLDT5udc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744952; c=relaxed/simple;
	bh=IKTPaKZuZhGhSwp3tiv68ysBaxtmkSC14zEvO2O0r3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQ2k1iDQv0k98aGYAKIN++AVK6SbOmfZPviHBYfv7lvG9SLCX4D2K4HehDXgm31AYLRD0Z2B9SC8BB1WwVUsp0+xaR+nH/Qa765NRijxSpfufxg52iP/XHkGHI9iFLhlqaXn9K2lz+0JXZxK2KfgWpU1wXjMsLxW1HKkvcPhykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYCOqMIp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d48b45f9deso1044436f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756744949; x=1757349749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2SJ8RSGWgF5HRF8KbGcSTB5S7+ggg3wF5EeaWmlInI=;
        b=HYCOqMIpCOT7VeStkmEjZQPSKsAKcTeSsWZSvyGwUbHZsB6syvyqhlVlEnzYTp3da0
         Jqm1Nv6CXpPWn5q6O6a95hIh/P7PbR/Sr+ZFGC9bjhJm4FRy0bUYJBAjfk8g5m87ALnB
         dgtbTEO4vPIlCWJ4dEm1JCJGNZUEl2Xx7Dt6Pv+HhUY7q0hI5828cpSb86rwf57HkfPa
         SM6OGWZZMNV0Pn2N1C/9tD+F0nI9Xo+RCQQwAXnlDpHdKxUkbHfCnzVXlb8c4FnJQzvM
         6dBUsfrtsweJMPJ1h/RUyqt/UpeUI1nHk2Bdn5+r34aBDw96Y63s7zDtLzF0a8rUCvGi
         bveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756744949; x=1757349749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2SJ8RSGWgF5HRF8KbGcSTB5S7+ggg3wF5EeaWmlInI=;
        b=SVllulo88ECOXWLQVZPGCHKDTyiKgSMNhncj+9e6JP4LpgIqE9DyPdLw9BTiyXIG04
         PQ6TD0AyH3an46wG5Eo/p1nuxZWu2PhKE4JXygIAeV1KdItK2dG9VKvhrYQPK4eYpYlA
         GaNclUm4HXAUEesL1K71wrEKHEcwqIsqvl5fO3kNsb4se9pt20S+02uMtANRKyiooHTE
         E8RCn9GFIpdiCdAB/FooHANIvvrPHP85HNaXtGtbQYI7JQw7qadXZ6v3mJchVex6PMzv
         eFp4ofLQ6RJUSGoBTtnSDqwSJFBvKGRpkXPFJbFlSFaCGSYrHp2AsFnlaD+zm01VA+Zk
         mXvw==
X-Forwarded-Encrypted: i=1; AJvYcCUv0wYlAJNFDK3fg9YsWJejlQ/hlqPGTJCdWRTshpScp+J2RkP7+MNly7LyaPJP3m8EFxRvo7q1aQM/0HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQNznjUBzBsdN9clSWnBVm6kXz6dgKCh6AYLWAxPqWkjT9uHF
	8VxMuS7OyjTu0knQu3Ecii+gmnRjao3OV70lkuXEUn+RiMylitkiKHZO
X-Gm-Gg: ASbGncs+AiNxemumV0q7axIxkejeK7wu+P6USqPfufMDO0G9dYwZ3fV8MWCEYyKgcSn
	1C13CVgmcv2HdDQHy07b6uMyTQk5L6pzRfW8FWoTKxO10VcAzK6SIOG8lKBQBUf3JMrO4BjMW5T
	sMiPH5Y3/Rdq2xX+Tm149kXPQ8w0C6mWfxMukp8Zuz2M7cY5nvBAOydf/c6Gxq3k1PaU6dUU2gp
	Twk9eR3/Q3obiIVhJiVm02elyAt0SC357e3iuQew/ctyXVU3S7H2m/Bu6jUaLlh9JgAyHfviDDD
	uLsdKioGeYFQKriSFhg+zoUWALcMRIULjwgIYLLGL+a6EyZAi4H3URpBG+RDlA+f2KCvzDidHJu
	R497SbtaimlO/MqSz6TIzORL/DiJk0N85OedZcXg+pRdhhf1oD9AZklkHPJ0=
X-Google-Smtp-Source: AGHT+IHTXAHnefNNy9w0+6gvsMWlpSk+Oc4A9sHqoF9uPqjcvvmUzftHA+m30QKEQxkbMsfI90G2HQ==
X-Received: by 2002:a05:6000:124e:b0:3d3:9b18:2262 with SMTP id ffacd0b85a97d-3d39b182471mr4749459f8f.25.1756744948592;
        Mon, 01 Sep 2025 09:42:28 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.80.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7ef7cfsm163388585e9.6.2025.09.01.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:42:27 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	flaviu.nistor@gmail.com
Subject: [PATCH] mtd: spi-nor: issi: Add support for is25wx01g
Date: Mon,  1 Sep 2025 19:42:18 +0300
Message-ID: <20250901164218.11165-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the IS25WX01G 128MB (1Gb) ISSI Serial Flash Memory.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 drivers/mtd/spi-nor/issi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 18d9a00aa22e..e4997f9bd557 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -126,6 +126,9 @@ static const struct flash_info issi_nor_parts[] = {
 		.flags = SPI_NOR_QUAD_PP,
 		.fixups = &is25lp256_fixups,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		/* IS25WX01G */
+		.id = SNOR_ID(0x9d, 0x5b, 0x1b),
 	}
 };
 
-- 
2.43.0


