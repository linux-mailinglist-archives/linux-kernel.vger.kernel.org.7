Return-Path: <linux-kernel+bounces-758972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B3B1D67C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F323618A5B28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F0261586;
	Thu,  7 Aug 2025 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9JoPrvA"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B910957
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565534; cv=none; b=VvAPGt0F0df58yb6g6TJV4qAnVu0U+4jst18G5P++6A8pcMG+hO0pOYVnursvyc5jogvWkbQ9dMIi0te6GiiOthLRHq0a7bxtcJPPdcIgffDLWZM9GHS09lTH5+hhqhlYoZacXHKlCkoJsydxmqUFd1MW3vKwkDLFqtxvYhTuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565534; c=relaxed/simple;
	bh=wl9YGZwSYBxnaDOCM1kXEQ7f+fIDSs+VEcNwmE1lBIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4eXIeHXSExhrQDnA0bNMh3gjus9sy4INzBfOg9t8y8JZ9Xhrp9IKDfZJ55VBBWmucSXFxTqPjfN9ar3HrNLMGIsfDyz2p+s3uxwk6vhRB880ps/53EMDX5kE3TZ01ukWKaYLOAte3vi+y1/ToaXmCGY7j/jD+4xmxRjTt3tu5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9JoPrvA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4239091facso607548a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754565532; x=1755170332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9fqVws7kYAGGue9oqTxhEM0PSSeHuhdnXBXm7y4cLU=;
        b=L9JoPrvAYdH11fDWymXHmnidjyGUkBV5lKHhijKaZJjXst/0R7yqGpqWFUOTpPenLF
         rDl8iEJNd2PgMDSSukOfSCTqG6tRetsyT/rXqr29c2ERdge8JEdXNkqzF8EPDZrbYeJb
         n9eCC8j3tq3jVq/9EShUQe2asFBpM6mpQYOOIUP2OevuaDjRZRq2n3HmLb63UgxJe6w/
         MWT9N7j1pNQ5U5ng48wnT+n/x34CbMan1KX31/Cx7KgrEI/d4pPYPr10lKQ17WpJFnom
         jB6XO+3IncWoZCvYG+Xsuub6btOJKXEyr3T1MBCkqViZNZy2JvcbbotBuhQl3tbSVFd/
         hEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565532; x=1755170332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9fqVws7kYAGGue9oqTxhEM0PSSeHuhdnXBXm7y4cLU=;
        b=XqOHflk47NHe8sf889hfXtRAaJ1hfjA+4tnl3mCAkfBZJhOsMdoqzKLgRmoB5QhR4Y
         PUBtxCk8+lXGH6w8GARe181ARDUBxY1jyLyiS1hQSXK7h5Feeph3xH+tyzMVl9zdUC/Z
         zxz6akzzE1zxKI3Z7ttYkuDcH57IdxIaAV3mGgXbElhwi4PQ88f1duu5CWb4Qcy+6X5N
         rGSqbEtIUtFuW7L48x+vioqOGJ0/HGZojB87kxRpFICnDZ//XAszOF3Hjxe0QDQ5S6lE
         G+OhPGEnHNLvzpnBnuppPOPXcllJ9cBXH8liOb/zZaUPW2JCpejv+/jXSeI7T3qHs1IQ
         Dr1A==
X-Forwarded-Encrypted: i=1; AJvYcCXzW3vA4YFFi5mOPiSVGQv2Xh3ZItkOMoevdP7Zfgb+za08H939keFWN/JoC7+H+e80ZkJ+k4DBA74c83U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzhEAKvLnyQt/7rXxJ1l9I/gXXYWatlTuxBY265UuHhwMpGwJ
	h8+bZDEVWytfHw9NII16utug2c+OcCvSSgGnY7lPf4JIMaQ8uO1x0lni
X-Gm-Gg: ASbGncuc9xe7D4+CgLTuwlryMkyIAhVktwuE80fT2dHfp8sjL3txa94sctdMR03D/jM
	fqlVBAiXWGx44IGFkH9J6MhmYQsJjnGG/5tYOYI8Y+O9+ZLXwz98wv6FNW3qW6Qd/nyUJ1zhsSM
	GETEbtDllzxTu/LP3EOrzQhPFlA/rr8BGsAS2ScKOkh/O5enXWsrOZk5sNjp3xpcE1H1cr6QB7U
	NqQ2OEsqh3RLVPwD5BKVSI6Ec5GsRwoNzijZiyMbfO3MAo+IZLv8+1e0eVhTDKAjuEUyRPZCmhh
	xVwlx1wOm+XJ5ajljBTZSSxeGnupNQ2Id+A/uAsL6Plg0bvtOxtM0Xj4ZTu+3BxLKSMn3603MZl
	x89BFr1UyghwKSJCoBfgbkw==
X-Google-Smtp-Source: AGHT+IErv77YOCqmS6FGmRY3sGQkXE7mtA5sIwlC5bAnNvn7C+qMr+bU53xyTNSftnTRbE0oMel6Xg==
X-Received: by 2002:a17:902:fc8f:b0:240:6d9b:59ff with SMTP id d9443c01a7336-2429f5339b5mr86838225ad.33.1754565531954;
        Thu, 07 Aug 2025 04:18:51 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1f0f576sm181751225ad.47.2025.08.07.04.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:18:51 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] irqchip/sifive-plic: Respect mask state when setting affinity
Date: Thu,  7 Aug 2025 19:18:05 +0800
Message-ID: <20250807111806.741706-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The plic_set_affinity always call plic_irq_enable(), which clears up
the priority setting even the irq is only masked. This make the irq
unmasked unexpectly.

Replace the plic_irq_enable/disable() with plic_irq_toggle() to
avoid changing priority setting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sifive-plic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..5bf5050996da 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -148,6 +148,7 @@ static void plic_irq_enable(struct irq_data *d)
 
 static void plic_irq_disable(struct irq_data *d)
 {
+	plic_irq_mask(d);
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
 
@@ -179,12 +180,14 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_disable(d);
+	/* Invalidate the original routing entry */
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
+	/* Setting the new routing entry if irq is enabled */
 	if (!irqd_irq_disabled(d))
-		plic_irq_enable(d);
+		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
-- 
2.50.1


