Return-Path: <linux-kernel+bounces-847342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2CBCA91E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DB61A6388C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125E24DFF3;
	Thu,  9 Oct 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O14X+IOm"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60082561AA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034407; cv=none; b=hthFYYXCw2F6zh9qsIrbeGT2wELQAxNx62zz5I4bwlNjodAQNnPG2M1MogCTySGlOzKTAvOYFmfsJ1hU8fYRZCdtOKnm64yuVpikuiHxT9XoLFbqQenohH8D7FfOSloThhHpda4uf/oxCAfBU+O1xov/QnuW9SWHnWnBnMRfBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034407; c=relaxed/simple;
	bh=237M16hLaQn2JCG4h/A7XmTUyEvItNKJH55VLSMGMHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPyninaSajAzl2UrY9qGOlJL1VUui9/QzA/08W1EDlNS0a7De7KRxBMi1PuKJ1B9eUgPx39gdDaj9u5LlQVyOHXgzYY6U5QzwdMb+LSfmkPIu57R8DinWoZLNpR4spKkGA3w+GBa2yJ/fSHpVskrgSXdoB8dX6h7NY3iILf3VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O14X+IOm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so1366675a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760034405; x=1760639205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnuN2daj+bpyYUC9QgFJubkekwCMN3rl5K8+XDophh4=;
        b=O14X+IOm+qCsehQh1DXiXhxhQMCictyZB12C0hIThXr1PI5muS2GWdLVXETIZKdhPy
         unjSSJwLB/7SyIRgxMxx2a22x2C8zADPxV8tVK3EC3AERt7msJCiWkvSiqUoetCRBZUZ
         iAwdjaNea6hNy8LAzaZ/PLgH7YcKOnq7spnhzRib+gwOB9PB9XxPAPFbq6f0NuVYnfpA
         hAg1CbMjmoSqBdgnzOhMFmreQhUoyk2CQcRBxuj210WB3dCzKD856WNtXhRXFuPu8Mun
         1GRR6tk0kBTS2gAaOdRl71BPkUW1577xheWlPdue+zXw44M35GxMqrlwLkoWzy8NjvjF
         CCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760034405; x=1760639205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnuN2daj+bpyYUC9QgFJubkekwCMN3rl5K8+XDophh4=;
        b=NeQE54ocmeDC6qaFWSngsw7wLOK9CovqX9JDlkJlMblT5YdrsBokiCsoNFq6xORVEw
         yXNjvSXQbo7dC8aS8/dJBbfcxhov34oaXmpvZszzt4j782Fc4Fnuf+TSg2Rdh4rX77ep
         M3Q5g286y6+JL6t5QPuygPwKgQgS4vXvoYj46KwZsrYJPCLGMvqOgvVMu/OkziIqTQp7
         xNkm3nYEDemqTnH3u6YvXAXcGOrkpzY5VTVqSDb8EamiFPj7//dEC0ZhWwNJIxIeOqDm
         lGhf4dIY8Q+e9X6cYkNy+QQu1R+yiXkuyD3cglwgksKj1XhjLccek9e+HilWLpS3TJuT
         h9HA==
X-Forwarded-Encrypted: i=1; AJvYcCV/yv8Ma36a2bk893AZHkEVrx2cC8Kc+VP+uZS7k/yvVcazeqY1iaLKOC6JHT21uX/4l/9k+L3sYwGBJGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kOFaRGA1UxCcD9AAgzowl0JH8jNuM0U3930Z5na3kheTvJqF
	ntnQpizWIKvJU2nza7kWNF5JxElq9FANcrwMBnoiTZsVkuZ9dtSmZggm/+Axm06e
X-Gm-Gg: ASbGncvESZC1b5pE6yxbWlMvhdZrFz/xlU7qkNPrAilwxdJTCT+nha3ksxDNUkeerN4
	SZzx+o9UKbwx/f8lZzJSdFgNO4G7Qxjyo8szGMBvHos0Q53GQREA1wu+tuE5FnRFkgf8BvEgn1M
	khIcbVFh+bRzajMbYk3rEhI/25J4ELCQo1JiTNmu9e948lsmlhyTCYnXygKSri0xvEOu2MjHcLl
	Xq50PwH/agaF6tWbvcNf49MVpurqFCUHPaBQwQOwoZc8iisWGgXJ71pQkSZYp9cpdcfB5u+iby/
	HvrQXvEI4PJCLlGqpu2KY1oxc85b6+XzaTlORI+sCqvkQltAVBG4D68qsFu4E82N3eUBYDpYKwV
	75JgQWGM2uFsrFdZgZ6FBL2qpOL3tNUWvG6rM4nc4McShi637ACFOgsvWRJ25W4/mklPIuaqf2n
	oBFzgGwz3ZPgT8og==
X-Google-Smtp-Source: AGHT+IGkpwuR19BRN76AnIQiP1T8EgOPydPx2sxZcmkWljIzYZHCtXpBlxd/whDBnWNmct33+wvTOQ==
X-Received: by 2002:a17:90b:4a4e:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-33b50f608d4mr10347238a91.0.1760034404753;
        Thu, 09 Oct 2025 11:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:860f:cf8e:9902:97e:45e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f2409sm2735066a91.6.2025.10.09.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:26:44 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: spear_adc: cleans up and sorts the existing includes
Date: Thu,  9 Oct 2025 15:24:20 -0300
Message-ID: <20251009182636.187026-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused includes and sort the remaining ones.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
At [1] it was suggested to sort and remove some unused includes,
that is the reason for this patch. Removed the following includes
due not being used or because some of them, like device.h/kernel.h
are included indirectly from another .h file. What was removed:

#include <linux/device.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/err.h>
#include <linux/iio/sysfs.h>

Also ordered them alphabetically as other adc/iio drivers.
Tks and regards.

[1] https://lore.kernel.org/linux-iio/e748d82b-43c7-48e6-b441-cef464f189e6@baylibre.com/#t
---
 drivers/iio/adc/spear_adc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 50b0a607baeb..6d974e58637a 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,22 +5,17 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/bitfield.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/completion.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 /* SPEAR registers definitions */
 #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
-- 
2.48.1


