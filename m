Return-Path: <linux-kernel+bounces-830802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D4CB9A92F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C9162C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0030F7F8;
	Wed, 24 Sep 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqGAOMwO"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE530AABE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727347; cv=none; b=dWl/1Vt2VzEQPVw4OJZh5rlRJPAWYABdhr4ZP/zXlqdXUwpWX8xK89aQvJMnqtxxzFRNYm4Yg9zPu+glumf24/RMoNcML4hZVHh49FGXpTalqKgCzhXKshHip5LR8sxJsFcyitUGSR2Bu7cj5qOQ6ChwHok0C6vBdUAHVDtTtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727347; c=relaxed/simple;
	bh=FS4csAU4UjODPSrVFMni0m6zQChg9uz5gLxhc+eDh+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqlYHwc2EvIa6h9Wsx+eY5o4vvthESstQqMmN1UcmlOJ8VfQKcmXP8tITG36xlRW1IGy/lSJ5bRKDzvYWx85oZ/D6Rpx0UP2nsj65Tn9f5HtZwV2m2s2NmVc+4IcM5iWO2QYYtRti3JWABpecbYbG79LNkmKmG3bO0GNqxNeoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqGAOMwO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8eeeeb37cc5so730439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727345; x=1759332145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GpJzLeRv3JvJ6Rn4+qItSuKPl8oje1EaG6ybTvv5B8g=;
        b=NqGAOMwOBBW4yUoMAVWeMzIY7jxBGG0nujY8MV3krvqjLQO6f3cEwSN4km8hj+1vvP
         HCL+UL76Iwa2QdEaJqPxdQd+A0vtfHf1nzWvpYcmSguZponlereQrs6h5hDVZOl7Ve2b
         m/8ItzFObPEcKnucCGJn1S9Pw5KRcsrqMzYAUGayRiHhpGBFkFCHCU+8Us0s5E5QdeLO
         6UyuDjEzjwPJVUip0lH20o6/LiVkGziIscUVYUufEJKZdt5nG26BIfmT1o9eWE6DRQLR
         YqekAPROxllE6eIIaxC6F1RN2Q7z99oX814VHraP4GyuHDJBFBvwKqTUFkN0CvRBUxpW
         m+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727345; x=1759332145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpJzLeRv3JvJ6Rn4+qItSuKPl8oje1EaG6ybTvv5B8g=;
        b=isz9s51Jfi74ID/DGyIJPTyntxt9ikcMJJDeDRvyMabtS1cFXup9wC5eWshNtZS7TG
         SEk+41dkzKK2INQLq/Dr2aPA/Z7ML6lIfXN40j3EPAYN9DV8zJrZm8Q4Od2E6xY19Xsn
         QPzqG2qJr9xb9UPpLTEcNqPEAYt+oDqTPjRNavxzhwFJXlHwSiJrydnhNoOmrYWsAw4B
         rWe47erXYyLkjjqCi2OCNUtjL5V+aiu4J3w8HJsaTws3280etTN2RpXaJVw14mA1y4kj
         PEzIBjyyilbRSn2Lnyosxo+D2EK8kj8sf7XPtiFt4NEfYLM4h3WlmHPga9zdoQEbhqy5
         t2mw==
X-Forwarded-Encrypted: i=1; AJvYcCXHaAnM7P21i0lynXIQoxmiXZSyb3rtz/xzmtY4oeeAghof7pq/3oPWiC6hHAm8JRzKOuo70EsMDzGxRT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9LYUlvRg3MlxTvdVOQFLHsHwtTLcDRiRS0WkLfQDp+M9OfXoL
	ChptkiVSRYkzm9yEM4kyfMeKHP0rULGaQr68N1fQOFsz6/Y/SnrfiWdJ
X-Gm-Gg: ASbGncvwV18v+Ig+1Go1hHkTyR2LuU2OAVNVLGEYFT7JO9JyDA1LafQZIT8srSE4RKc
	LvqP/lLA4R67MwH12AORAOJAsfIYRtfZcyAUMcX0fHhYydZUeU4xNCmw27PxGnD11x3opZnSwIR
	qumrk2wkNiaFI4wqgRc0XlC+HgGpOIIk6ya6LJwUAVhGeEsSXt2285wp3VoC5jiK739WDVj1Eo9
	zXi8ei8MzRLUcpu8QAgfNE9j71Gv6E5ClNS61upCPI1wMPqyd94cw1MUy/ghFVBtqGpixuWs4Zz
	HA8l6kee1UpkiKHuw6F1LI+1CFl45bEXrCxjToUvLft2wHCsINz+U+ElPhZvi40a2OaRzJ3gYbB
	ea601fqEQBjKjCmbnqLG+Redu+ys=
X-Google-Smtp-Source: AGHT+IGIwXjPAbpzXy2+r7fwj/06ZO4SrCKju2WlzvWmjdH68NQxMQU95BaeD2UiUHkahmoqPGREIw==
X-Received: by 2002:a05:6e02:228f:b0:3e5:4e4f:65df with SMTP id e9e14a558f8ab-42581e0fb6emr107166725ab.9.1758727344790;
        Wed, 24 Sep 2025 08:22:24 -0700 (PDT)
Received: from orangepi5-plus.lan ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56150787e91sm2786797173.51.2025.09.24.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:22:24 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next] net: stmmac: Convert open-coded register polling to helper macro
Date: Wed, 24 Sep 2025 23:22:17 +0800
Message-ID: <20250924152217.10749-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the open-coded register polling routines.
Use readl_poll_timeout_atomic() in atomic state.

Compile tested only.
No functional change intended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 28 ++++---------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index e2840fa241f2..9e445ad1aa77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -135,7 +135,6 @@ static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 static int config_addend(void __iomem *ioaddr, u32 addend)
 {
 	u32 value;
-	int limit;
 
 	writel(addend, ioaddr + PTP_TAR);
 	/* issue command to update the addend value */
@@ -144,23 +143,15 @@ static int config_addend(void __iomem *ioaddr, u32 addend)
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present addend update to complete */
-	limit = 10;
-	while (limit--) {
-		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSADDREG))
-			break;
-		mdelay(10);
-	}
-	if (limit < 0)
-		return -EBUSY;
-
-	return 0;
+	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
+				!(value & PTP_TCR_TSADDREG),
+				10, 100000);
 }
 
 static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 		int add_sub, int gmac4)
 {
 	u32 value;
-	int limit;
 
 	if (add_sub) {
 		/* If the new sec value needs to be subtracted with
@@ -187,16 +178,9 @@ static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present system time adjust/update to complete */
-	limit = 10;
-	while (limit--) {
-		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSUPDT))
-			break;
-		mdelay(10);
-	}
-	if (limit < 0)
-		return -EBUSY;
-
-	return 0;
+	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
+				!(value & PTP_TCR_TSUPDT),
+				10, 100000);
 }
 
 static void get_systime(void __iomem *ioaddr, u64 *systime)
-- 
2.43.0


