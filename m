Return-Path: <linux-kernel+bounces-720142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91159AFB78A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F5042179B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0641F0E53;
	Mon,  7 Jul 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W5iExPLV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F071D63F5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902564; cv=none; b=oWM5GiTpKWLVD64BqRsBP2UV4I2YEVQ2KAl9bAbv14hGGzGQs5LkldXcow3UO9z3b+PzxUfvnKx5w6eE2DroA9WsxLGBBIFnW4jmuO3hd5zM4Q+a/ITxplh468czqNFp14msEr3sEY/ocOtDKEj3TpS/8F0apsxWO5WQlu5LzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902564; c=relaxed/simple;
	bh=HcQchtRslDyRXYgw4RtewbOf6/LJsYueNE8Laf4FCKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHWACxWeeBMDmp3L33SmM9mSp535y3M9qTiEifXqJWN73MWAAgyw8J6IlZw9rj+OJq0z6V7BVawXMgc7P3pXvKuSLb22RMvR18HSvH9WPRcythPicRbWZWiRIm5UcgLQbK1in6ijJWXieVe/jOhyQMPO52037DloUTLZlSiZ2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W5iExPLV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cf214200so25037575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751902561; x=1752507361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH9KVtMgBsrkYXH8nnFecmz5YKaJj3+GxgiEXc+y1YA=;
        b=W5iExPLVe4nn2yGzBbaYvlIZdtKzogoInG2GPlw3JOT4i8rfuUSx6P4wrddne+oXb0
         vwrx6FN+Ffe3IoI0Yyq3iRT6FMM7g8II5hy+yB/MnzaRCirKdB16VJXaajSH15Q+Y5IT
         G07xBOdW1uvOL850whxUgiBb92sbentYfSuxVv6JofdNJhAAbb0CbeO4RWd2F65hxlgL
         LY4uxf2oJkyuevVNn8Nh/kUKioBb/p//aICissCn/85tHgzcCeU9zU7dHSY0WRrj0VZT
         QMscqVsz7DRbIlaSrXV586C8cfu6fwFsSsemSJtfOC/Tw+9sWYcEGr992jBo4rXw4/Dq
         BNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902561; x=1752507361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH9KVtMgBsrkYXH8nnFecmz5YKaJj3+GxgiEXc+y1YA=;
        b=P6iYQNhw9u81YsRi7PP4Yty/1IE1xZMe1wBravNQBBlNJHL79LJllm3TRlfXCnNHbh
         H1wnQYWfH9siZ2lMZCGUhq3nKpObKDA0y/NrONj739ac43Vat9hrrxYsAVNV7VegsJcL
         9MH38ipcA+ojMDGpqBiUMlxw+IqyLi87MHoZ0Drd1/STFHmJUoT6WngPKuY2sgLZoyyV
         4DJa7tBGEE89qPAFE3iD7fIVHnF6qMzh+yI22ZZ86HuM46v/Uz8xQ04Fj/6kbM0njTLI
         0PmOxiaEB9Vnxir6AiwSHWSIa0Rvx8LubSs6+tqOgrHQRBp1gdOPXVlOeSBPYn6FgTvU
         OYdQ==
X-Gm-Message-State: AOJu0YzLztwn+G+jF+tjcnuDPevdljNKR5pRc5eJ+OEPzIFXXgbd1wuK
	c43d85O2dFz7cRRAGI06sMu3EFjeQyrrRc3EW6mblkm3jIr/XybhqHmBLgK3Pes0xVo=
X-Gm-Gg: ASbGncuW/Qd0fvXH8eCydNZ3eO+b/18xl6ADTEPBcCv4RPBkyXmUtetb/Zqs2hq+y+I
	ONhXOKe7c7os0+ZsNmC/zOYYC481zI/cpjuz8wjOnWbYIgzoheRXbh0wTZ650yRKWg5rUeGLoT1
	lK5gvv9ioB6/xf+JVzxJ9uws/zfsgAPFWdaiwVShUZhAKv20ohrKxckfsXktoh9Us4dD0yAQpIh
	UGMcweYAel3WwuJH+O0DSeT3wZFNRdWosyVD13XEWcTy1SHxhP5oO/4+719klm/Jm2Yzt3U3Smy
	+MSQhSWsUlzj6fM4XDVwyOyfTW5fkOw7YIxLcVhluAxJcJHjLfE+NC8syCAKI8Bc1jaXku+iQR7
	k
X-Google-Smtp-Source: AGHT+IGes0ufFH5VmLZsiJtyyublkopHtpaYl2Uv7IhC3VQUUkrA40ug/nbGGBQCxtDhT7AejuRV5Q==
X-Received: by 2002:a05:600c:8416:b0:450:d4a6:799d with SMTP id 5b1f17b1804b1-454b306b0c9mr109664975e9.7.1751902560647;
        Mon, 07 Jul 2025 08:36:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:43f7:96cc:da3f:e6bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd4dsm10409968f8f.7.2025.07.07.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:36:00 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Mon, 07 Jul 2025 17:35:58 +0200
Subject: [PATCH 2/2] soc: ti: ti_sci_inta_msi: Enable module compilation
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-timsi-v1-2-80ae43b2c550@baylibre.com>
References: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
In-Reply-To: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Add module support to the TI SCI INTA MSI driver:
- Change Kconfig from bool to tristate to allow module compilation
- Add linux/module.h include for module functionality
- Add MODULE_LICENSE, MODULE_DESCRIPTION, and MODULE_AUTHOR macros

This allows the driver to be compiled as a loadable kernel module
named ti_sci_inta_msi.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/soc/ti/Kconfig           | 5 ++++-
 drivers/soc/ti/ti_sci_inta_msi.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 1a93001c9e36..0a9eb5ac264b 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -85,7 +85,10 @@ config TI_PRUSS
 endif # SOC_TI
 
 config TI_SCI_INTA_MSI_DOMAIN
-	bool
+	tristate "TI SCI INTA MSI Domain driver"
 	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable Interrupt Aggregator specific MSI Domain.
+
+	  Say Y here to compile it into the kernel or M to compile it as a
+	  module. The module will be called ti_sci_inta_msi.
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 193266f5e3f9..d92cab319d57 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -115,3 +116,7 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Texas Instruments K3 Interrupt Aggregator MSI bus");
+MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");

-- 
2.34.1


