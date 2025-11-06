Return-Path: <linux-kernel+bounces-888874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C73C3C2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD1E3B0926
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885B3321CE;
	Thu,  6 Nov 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ABNOmtDl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB4308F1B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443902; cv=none; b=l8JSGMHcqj9CWvybkfIE9AJuPaiLs4ZSwuEfl3P7gGruFk2uyQjQ5/wX/1UB6VUOAL+KbdhdTLIsHClHFe8tE5gxnfVV8eHULYWophIhlrZrD0YkWUUVLLdDY6a2P8SkDIpj2ban6os3+7Ax7hz+9j2ZQkeroIZHv3dzd+nW69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443902; c=relaxed/simple;
	bh=qbhajpU0G4kJl7tgyhXKSP59dX10IT1q+klpIbWREpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkIP7J0c0ZqcZffBGhNvXSdPduQRLAvgqNR2DuZUv76cC7V06cBdSg2WmwMa9dluvDBwimbp25fVbS6AcozZZ/2sERuusm5jtBR1W8EAB3ierJs/tg77+eR5AABRs7Lc771SVei1Esrm5NJ9HBwlWBX9CIrOgejuEFlxEtgFOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ABNOmtDl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae77516so13328375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762443899; x=1763048699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x66guca1eftJPuWCv2VQqhGjAMisaYzjZ4uDuE1tm+w=;
        b=ABNOmtDl35JvgV5qJ97DZbDB9OFa2hGqfdga6fZENEGwfbMbWyHqOpOXyqlFmQUs5u
         FRkQcO/f4SaAStfqzL5LD9KjL7rH3BEC6OpeIsLS1hbEDLP8s4nIrlVoiM2aDCxO072y
         8g2cp89lLP3Xb6MdDLQ+jLVFKKvIjtcqKDdGFtt2uuuVZ2e1EmDEpcAZJeFBP0qnj9eO
         R1hJNlN7ibLfxQUgTcswMb0Jsip32qZZd+TtqQymrBaT3VkwZK/ww0/xImUksQocuC6T
         lsstcXySQXXvyBoAlNlN5Sr5FctH7JaqaZ8mOX2lxF9o/GEZB1XTbxV84GjofIBmjW0A
         4tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443899; x=1763048699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x66guca1eftJPuWCv2VQqhGjAMisaYzjZ4uDuE1tm+w=;
        b=UGJleWEc/JCzMrwmUa1ACR89yXK+9kdd4RxEi+tELtuZsPXTbxwkHDYZbJ4aJKtJKl
         O19GA384BezWd5QyXSDOAS2m77JSU8ifZslaZGt8UbizyJ+uB/2PZXhUgL3BGlAVmK4e
         COA1ulyxT6Acj5mEkznGb/Bj+Mg0CyxojfjT8ow4Lz6DboGfRGGE9ZGQaDfdm0nFAe7V
         u+nwteK8hoHPrAfsS2BgSp70JyrUgbwzC9sr8mILjs7JOHfxR21q3PtOX6ySpxM5YFwS
         S9cZynR7REq/2qwF0X50MOa0zDSKOswjdEEK9zaDkJr2dZH35x7Ud7DMBcL5JPSDqdKT
         NO0A==
X-Forwarded-Encrypted: i=1; AJvYcCUPSMAXvyIdEYGThEP/AvaK6PKgPWSflYUHxJRIIu3kQun5JoB0WnWokrEyUZ19bA3UdPwKAJDWhsJ17CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYj4C0fxfztxSc1PloLZvdBrT+hP1yrawREJlV+Ytda/VIWnJ
	Wi1n3whP7RJDCCPA1doTW9rDFYSwwP6k84jr7eSkKGDaNHknylL+HNsxycjbAtS0L5mxQCq4PlP
	A9KjO4BI=
X-Gm-Gg: ASbGncuew4MYQ0PQJ+PAge5GBxRZaMIB4AMZM62hYki/gkdsP84ph+MjHMEbFdQlO/z
	0vPthukdxwncrM93caBYXKX8vP5iUmqlReBMwF/fLL6nJK6pG3NZxw44m0jrBApRHFV9TEhoBKq
	hgYGUbiVlXvbuC7bDFnBcjFHJ2z+Egpf40VuN27Qdyemip+90rPBIgZwFCc06cLu4Ia6ooLMkSP
	WuEWTWu0HGDlRmUIi3s/xTVcNbR4PGfh93FuCCSlpeeW+uIPCkQoL/JassYzU03jvi+Xk5ArQjZ
	5Tis4KdMLJnfzR+1W42Cv0dn3Qp6UO4LjG1kx/2nDHCfMlI4BFClTufseB/RaCol4HNf6mDZlGW
	g5IZoGl6k8I2/ZIwE0ZFwBmyoK+p15Y5IsvN987sWzqXyTLwyciOtgCSGU1ZCAlS4RsydLQ==
X-Google-Smtp-Source: AGHT+IEGoGND80uf9mOa5zbUVNeRt3iYWwEu+Kyw+xpveCZRRlkiUNTnCbyfpa/6u3X0EIG0bh4BHQ==
X-Received: by 2002:a05:600c:841a:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-4775cdad627mr57791065e9.1.1762443899025;
        Thu, 06 Nov 2025 07:44:59 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e66b1fsm20621705e9.1.2025.11.06.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:44:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 16:44:50 +0100
Subject: [PATCH 1/3] dmaengine: qcom: bam_dma: order includes
 alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-bam-dma-refactor-v1-1-0e2baaf3d81a@linaro.org>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=e7cbrLbtrA2QdYXynWY0z/h9f2KdWIz0hBln6YJk0L0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDMJ3wDD2iDBCwRq63Jsh20+PEuvzfO1VNoM8c
 UWpJEg308SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQzCdwAKCRARpy6gFHHX
 cmvdD/9stMXXL0j4g69U3lcomFVsfQJQpzTmu+YskFtImN0Dwz9haq2L24+GCKQxrkb46zFkS9m
 mhc6DLIiWboRf9MmT4+tnh/Q9uuXGRZj9aLED1R5+4NJTWuuKFQHA6ZZmPVwgS5sCnY0omEVawX
 0wq93BmeG1ChHA+nvqubkhUE8rKWrcZIo+hWkpHZ8ncWjoEIc7nl4JVTgt5o6MpAxnCPY8NlGmu
 WbQIfOOF7ZPkibrQhDEfnKv5AMfiTktll1b+CJXxHv+i63R1oRxNmI+1SyT2HqVlIhQiBE7bECR
 RZEKztqv7bM/Dl4kOfJTW85sUHL+zt3YkTXbsSyA8HWgml0pcAdYmYMGiPp7lhFQwEmvoVy2NRr
 tUvdVSwNCb3bQR/fmxYaKLyIVPaQrVrjSFCGMiKgtlc6P/OgSDhoBHn7P+4jmBnf4YG7OCtCv0F
 bIBlVyuGbMjJLpeLToSmftHcytHwbohtX4sZbehnt9EiLjg2wFxlO6KcYBM0C3ooF+6BlaJnqah
 OwO/DLmp4r+exW8mW1F+P1Rm+dRYKiZznvuybJfy2dCjnG6g1Jxmo4BDu5gg/bjJi1DeBT/1Xnp
 I6Y8dn3C/c7rPp1XTD+ExTOEVWl4akKA1Fr8YZ5YxTl0M+E9aLN7g+nKuYv6VucZM+29WEkFZCV
 aAow4lMyOdoRxcw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For easier maintenance and better readability order all includes
alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2cf060174795fe326abaf053a7a7a10022455586..2f1f295d3e1ff910a5051c20dc09cb1e8077df82 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -23,24 +23,24 @@
  * indication of where the hardware is currently working.
  */
 
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/scatterlist.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_dma.h>
 #include <linux/circ_buf.h>
 #include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"

-- 
2.51.0


