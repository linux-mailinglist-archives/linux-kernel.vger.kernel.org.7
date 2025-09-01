Return-Path: <linux-kernel+bounces-795135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A671B3ED3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB06189D143
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFD30AACC;
	Mon,  1 Sep 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CATEBL3H"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73B32F76D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747058; cv=none; b=c1FpN/aWQ8onpDLockPuXdkJ+DSIWeafdVjOOYZP2zoxOHgi//EuggsEsuJrlVLKTWzAdJ/ph4YSo6ZPb0bG23d2CUMX+QiPHS1Qd2f3+kf7EiT34Ft9uF7JDSJ7JEVW6IwK5or4iLWa8uMvExrEKF9NjcNMvUVwbqWWTwPj/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747058; c=relaxed/simple;
	bh=Qw35Afa/3L4Tj378/d74Fi9gFRngOS2X1ln8zKvlFfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmyoRstqavDv5pppFAlarVbv6fMHstCzV6YQkAI8OJ6G9gO1UxvQI8aU+2BzZHpql+NmsUU90OuZQ0myVZuM/x9GB9a9RuCOXLHvUsNMjONeEhXPAcF2CFzZWtiFIglUqtfv3xhLd3RumuAYWITmSsAnUPox2Cqrgvrm08z8Yk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CATEBL3H; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so9817023a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756747055; x=1757351855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgkAk9hT8YT5X6HNylUV3SYLjug/Y5ugj72i9pezQpY=;
        b=CATEBL3H4x7tK819eVbpedfREnNgNR/P6UiQECWm6tz35rSKrqwX61SlCua3VI0lR6
         1fM5E/N5WlRXPMxW8hM2Unh06ptN9CgeuHeuZRNZCGmt3XO4UWdGwzicHrRs+SoC1p3C
         M4XWmSgH0znO/ydDsfWpW9ydFO4Mt5Jt8MOi82QH/71Jtw8ssDZ0taJxtQ4ZkKtNFyFP
         uyn9EEZEaK19GaRUWrXzqzF7ZfxdJ7O4Z+qFSOAMYUOqBXRCNr+nrOCWX+7xNQcmXzdc
         U4HuYlTHBVAeshZcvWZuFX2NvD6iQ1wToYC29JWN4UVMS4pPNyxzkiT+pmfXDx0yzsqI
         8mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756747055; x=1757351855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgkAk9hT8YT5X6HNylUV3SYLjug/Y5ugj72i9pezQpY=;
        b=fEwZvHuOVRMoCLlYQSe9cN5DLgc33Mh+jJ/Lr2Zwq34hfkmyokvtPmj2mZeG7TD80b
         dsKebLAFd9PkTMR0dedZjntkCVicj0M7Qor0H6gyRntpwFIVHY8xNhwc7B3oRR+3blIw
         B2cBvcgFlYgiwaVuekO2A/o2tWHx9tWOTkBbyXdujzpcZv6heuug1Kpj0nHt5qz9IMoF
         0P/fUpdSi9G9fdbI4mI9pEQ1hm5L2ia2H3htOQblaOo7Ed6wCR38M0O15QmGZZUuaDQj
         D4x6gyalWa4066B2O8RWaVyRTjifob0ohTtEVHmDySCw1KxpOhFPWeQGewrYEQfXAIgB
         O3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYohAt0fRXCLJKYpnpVtU+hyp7g96zWA9I3q+gELq6loLks7nh6A51vYVjqIn4BJYheiijepF4WL0JH4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMcUTkVQ9TEvrZVUKaopqixQAF4yyFJnVJCLmhJOJyIOHO/Qk
	/8iUgdWAzHN6HFFJt8SiT0iVB316uB46nFp8rG7LUPGzd6I0oSCx9b5NH6bDs024oEs=
X-Gm-Gg: ASbGncsQ5GZ1BN+rXW1QZUFmxo0I8QpzZPxca+Sr5GkkADsIYALGwvByuHqyUz1u0L+
	scvhGgG7EegiPsU9fyWSpeA6qAayNUNNgZF4/f+n3J17yewtryEFjUQMSIxsFZoFm4HT1Gehpd0
	qZCQUe7uU9qVxgRJvQu4VnZ0H15W/Hk6Muu/XltL2eGxJJ7bCD3TzmAKONVq8iEYkrv/SfXM7i2
	Uqk3EdIiPQmjqTiiC+UmEWEtxCaMoUgdG3bMqKDQXA93Nt1ZzzGlL9vHeTN1f3YS3K2Xw3z9agp
	cpryGfJuTCo6hi7nnU0UTafFJttSxPHUneaK2mKO/Vk5gOBRzyiQ0H7diNQKMYf2HS/cN7bKysy
	vemed2bo+44TrN3UWtfQ0MfN5oLzQrksBoph7cmFYkdHLozkvOJOgRz4dM00Ec5K+OdFbgPWL5k
	ewiw==
X-Google-Smtp-Source: AGHT+IE1l2yThanmzIEjy7Pgy7qnCkUNrYgocReOxLunqi9WJanFiNaezY9fFOQNloQP32U0xHFBIQ==
X-Received: by 2002:a05:6402:5107:b0:61c:db49:aec0 with SMTP id 4fb4d7f45d1cf-61d26999ea1mr7880457a12.5.1756747054548;
        Mon, 01 Sep 2025 10:17:34 -0700 (PDT)
Received: from MacBookAir (78-80-81-163.customers.tmcz.cz. [78.80.81.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc575b94sm7237577a12.53.2025.09.01.10.17.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 10:17:34 -0700 (PDT)
From: Aleksandr Shabelnikov <mistermidi@gmail.com>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mistermidi@gmail.com
Subject: [PATCH] firewire: core: bound traversal stack in read_config_rom()
Date: Mon,  1 Sep 2025 19:15:47 +0200
Message-ID: <20250901171547.47065-1-mistermidi@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_config_rom() walks Configuration ROM directories using an explicit
stack but pushes new entries without a bound check:

    stack[sp++] = i + rom[i];

A malicious or malformed Configuration ROM can construct in-range cyclic
directory references so that the traversal keeps enqueueing, growing the
stack past its allocated depth. rom[] and stack[] are allocated adjacent
in a single kmalloc() block, so this leads to a heap out-of-bounds write.

Add a hard bound check before every push. While this does not itself
implement cycle detection, it prevents memory corruption and limits the
impact to a clean failure (-EOVERFLOW).

Reported-by: Aleksandr Shabelnikov <mistermidi@gmail.com>
Suggested-by: Aleksandr Shabelnikov <mistermidi@gmail.com>

Signed-off-by: Aleksandr Shabelnikov <mistermidi@gmail.com>
---
 drivers/firewire/core-device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aeacd4cfd694..f9953a292541 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -581,6 +581,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 	const u32 *old_rom, *new_rom;
 	u32 *rom, *stack;
 	u32 sp, key;
+	u32 tgt; /* target index for referenced block */
 	int i, end, length, ret;
 
 	rom = kmalloc(sizeof(*rom) * MAX_CONFIG_ROM_SIZE +
@@ -702,7 +703,8 @@ static int read_config_rom(struct fw_device *device, int generation)
 			 * fake immediate entry so that later iterators over
 			 * the ROM don't have to check offsets all the time.
 			 */
-			if (i + (rom[i] & 0xffffff) >= MAX_CONFIG_ROM_SIZE) {
+			tgt = i + (rom[i] & 0xffffff);
+			if (tgt >= MAX_CONFIG_ROM_SIZE) {
 				fw_err(card,
 				       "skipped unsupported ROM entry %x at %llx\n",
 				       rom[i],
@@ -710,7 +712,12 @@ static int read_config_rom(struct fw_device *device, int generation)
 				rom[i] = 0;
 				continue;
 			}
-			stack[sp++] = i + rom[i];
+			/* Bound check to prevent traversal stack overflow
+			 * due to malformed cyclic ROM
+			 */
+			if (sp >= MAX_CONFIG_ROM_SIZE) {
+				ret = -EOVERFLOW;
+				goto out;
+			}
+			stack[sp++] = (rom[i] & 0xc0000000) | tgt;
 		}
 		if (length < i)
 			length = i;
-- 
2.50.1 (Apple Git-155)


