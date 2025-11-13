Return-Path: <linux-kernel+bounces-898904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD296C564CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 648BE4E8A37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95459331200;
	Thu, 13 Nov 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op6k3Daf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2E330B30
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022455; cv=none; b=SBlncwEOOrTeVbTQFdo90NAFgoZIgzb5Vki6imb4RXMbP8ybxiMNmygh3xsPZUA9BgqMMfYlpsNJ2aevvu7I2l1GeLP8ZgmLeaDgnmsC+tQ+qYc1Ve8UNQJbC+dyyqIlJFNZlrgG059+/PTeYNmxjNWcyGcY8SiRwegIBC2T+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022455; c=relaxed/simple;
	bh=JI2Nw2U1io7LxFEzI62xeKFVhPvOgTls3v43JWhtl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX99RwTmq1tA5BB+Ei2eZ9rm11GZl5Oy0jMfcBydrZ7WbK14CSCkU3ntT37pVZJaOwPlUFNrcj8vLIdCIqPwoW4boR0X2ramWCNVIlFnuRGqXkqgG5hZc/XY/YZmfkZnVg0nuHFRfmIb1WLYDjBForSe19kDAcl4n0JiJKdJCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op6k3Daf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so354912a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022454; x=1763627254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIHZKyxwa/urElRg62y72qxHZQlPQI5xwm0/ajzgPLM=;
        b=Op6k3DafH9tN5j9eQZYIPJRGi+zRU3OO4rRfhcrU9AiqNPvp9u7dnBcHwU/ymDbFS5
         ZqrFNlaBzXdPv6q/nMjFq+bqy8Epv97TBxim6lTT8HtnfmUJjpc0cJ5osQi3yrQozjYL
         0InCiVZGpoacithbg6d5G8sCHchcHoNVAA7t6tsorYPIrhBDfvm71h/kAq4D7/V/uMB5
         CLX1kqssR52PaspreCwJg6X7zzd9a1ipQ/1NzpOKOUnwiay6Qn2FzsjVQiUi0D8JKhCQ
         JqqNq+CO/cxe6gtkYC1zekznzD5T8On5tNBas8uo0FWrfEdIErE2zq5VSlZ0PLjrQjOh
         0i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022454; x=1763627254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIHZKyxwa/urElRg62y72qxHZQlPQI5xwm0/ajzgPLM=;
        b=NBmFU/3Mo57Me5ahJmRkQM/ipD7iQZTYil4HWdeG3OnpJIR/uST7PwGQrQEywWmAEc
         7ugEwNWGPxSfmyJVcY7YNdKYw9r8CYx5ab/3udPlSgYDANYU5P02LfUCJQ0zARq0/hcF
         Mz71j0NP+NUlU4bemjJ6agwlyoRcgxSZFQuebnFH9pYHq18k5iUiYPQi3anI8WoM/cOb
         DGLgcwuEz6tQM+G0xQNTgYBDZLQ9vMRj2w25gcOPix+dsFwSOnwpcxUFgaKY+eyxaZJ4
         iI8223wOqkLBbvwEb4ZK54sdt0OUmIgj/ahReD+ityhG72Eb725CaQo7ByklJ8h/pvTU
         2Dtg==
X-Forwarded-Encrypted: i=1; AJvYcCUu8f17vfCLjsbwqt5Uyr+Eou4N2ijjVT3rfRryJucqZoI2BEpxiRyskP/D4fQZOGRjaCt2mUxZ27ZiFk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2I6Cr5T2Mf61Q1L1/bn2/vxVavGt9ChKYN5MdmwfaOjXCMXQ9
	ZZCFOdjqrt64VHoPezM6jYBFetcmzn+eeq3pwxiBy+PKIZbUSWGMr+bG
X-Gm-Gg: ASbGnctNeKoZWnqmIu02yfWecq1+MTOkPcbs55XebhZwZgPzsgw4416jG0sZ6fxqUe5
	4BqK9PThxFyqeBMP3wq97DfC+JS8GlKXP+UQf9Rq3f1xdhvDtKcItieoHMlFMQGD7Io99aAJiXy
	8PiNuKYQs7uD5A1aWYjpgAb667GScZHt8wO8oE2AKQc2ArgPhZsRgRP42QsROUtScExNa0Dk3FJ
	4F0hUCNYhZAbDUSv4cGtCggGAfFV2up84zYnQciODZjjnfg+53s6mSzUPRVQqXAGRAq2CWTBFSB
	Ig+LG2nur+AKEjpUjuuofm1LAqdt2XxvZKVXlBgLEs1wXSKs27rdL8wZ1H3RTIoW/5X75A7DtP0
	44Svz27Yl1d4ZZ7jDgpBi77sXe6GgNQyNCxvtyGdbe3qRPQ/HcpQ+e7eUA+46ERIo02vuHxeWol
	CdRUFKHFoN
X-Google-Smtp-Source: AGHT+IFXpQQ0+bUU3A9uboO7BvmpbLL9RfF+fgrtY9XoLFZB4M1S1oJKkKAQS3HKnnEUYtSzSImYUw==
X-Received: by 2002:a17:90b:5644:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-343ddeebfd6mr7407155a91.33.1763022453747;
        Thu, 13 Nov 2025 00:27:33 -0800 (PST)
Received: from fedora ([122.173.26.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eace9074sm1004793a91.5.2025.11.13.00.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:27:33 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: pavan.chebbi@broadcom.com
Cc: mchan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>
Subject: [PATCH] net: ethernet: broadcom: replace strcpy with strscpy
Date: Thu, 13 Nov 2025 13:55:17 +0530
Message-ID: <20251113082517.49007-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy function calls with strscpy to ensure bounds checking
in the destination buffer, preventing buffer overflows and improving
security. This change aligns with current kernel coding guidelines
and best practices.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d78cafdb2094..1a1673842a35 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -15765,53 +15765,53 @@ static void tg3_read_vpd(struct tg3 *tp)
 	if (tg3_asic_rev(tp) == ASIC_REV_5717) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_5717 ||
 		    tp->pdev->device == TG3PCI_DEVICE_TIGON3_5717_C)
-			strcpy(tp->board_part_number, "BCM5717");
+			strscpy(tp->board_part_number, "BCM5717", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_5718)
-			strcpy(tp->board_part_number, "BCM5718");
+			strscpy(tp->board_part_number, "BCM5718", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_57780) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57780)
-			strcpy(tp->board_part_number, "BCM57780");
+			strscpy(tp->board_part_number, "BCM57780", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57760)
-			strcpy(tp->board_part_number, "BCM57760");
+			strscpy(tp->board_part_number, "BCM57760", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57790)
-			strcpy(tp->board_part_number, "BCM57790");
+			strscpy(tp->board_part_number, "BCM57790", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57788)
-			strcpy(tp->board_part_number, "BCM57788");
+			strscpy(tp->board_part_number, "BCM57788", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_57765) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57761)
-			strcpy(tp->board_part_number, "BCM57761");
+			strscpy(tp->board_part_number, "BCM57761", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57765)
-			strcpy(tp->board_part_number, "BCM57765");
+			strscpy(tp->board_part_number, "BCM57765", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57781)
-			strcpy(tp->board_part_number, "BCM57781");
+			strscpy(tp->board_part_number, "BCM57781", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57785)
-			strcpy(tp->board_part_number, "BCM57785");
+			strscpy(tp->board_part_number, "BCM57785", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57791)
-			strcpy(tp->board_part_number, "BCM57791");
+			strscpy(tp->board_part_number, "BCM57791", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57795)
-			strcpy(tp->board_part_number, "BCM57795");
+			strscpy(tp->board_part_number, "BCM57795", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_57766) {
 		if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57762)
-			strcpy(tp->board_part_number, "BCM57762");
+			strscpy(tp->board_part_number, "BCM57762", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57766)
-			strcpy(tp->board_part_number, "BCM57766");
+			strscpy(tp->board_part_number, "BCM57766", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57782)
-			strcpy(tp->board_part_number, "BCM57782");
+			strscpy(tp->board_part_number, "BCM57782", TG3_BPN_SIZE);
 		else if (tp->pdev->device == TG3PCI_DEVICE_TIGON3_57786)
-			strcpy(tp->board_part_number, "BCM57786");
+			strscpy(tp->board_part_number, "BCM57786", TG3_BPN_SIZE);
 		else
 			goto nomatch;
 	} else if (tg3_asic_rev(tp) == ASIC_REV_5906) {
-		strcpy(tp->board_part_number, "BCM95906");
+		strscpy(tp->board_part_number, "BCM95906", TG3_BPN_SIZE);
 	} else {
 nomatch:
-		strcpy(tp->board_part_number, "none");
+		strscpy(tp->board_part_number, "none", TG3_BPN_SIZE);
 	}
 }

--
2.51.0


