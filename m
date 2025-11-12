Return-Path: <linux-kernel+bounces-897546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0869C53448
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83B1F4FC505
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABCB33F361;
	Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbWAUDIB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD233ADBE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960958; cv=none; b=fziav+uJEtV3lu0ExuGhdq8cE1p7CFpXMdr3+tHjLdqtw8Sw1IKV8JmeLhtiz/UBWx1HdXnv0IRLBTnf3We2YYVZl5x88/xANTo1u2ZmDsN9hH0BYm1udyoukk4oJ92aSc40GWDwvZbi0zInETR0Dmjb09y3CwHttTd2GTfvpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960958; c=relaxed/simple;
	bh=IP0Ixd8dEZ7x1vJ8I4FOfIjKpu5OiZ3TlRpY0wiZBcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmsiHPKG+iq//84HsnWS/CJrcmyavPZmaPFLq2i1unM+7EbItcGbo9Oszlvl6g8w5U21otr3KBZDCTi4WM/uS+gHuOyQ+pDMVu6XowPmHyZdakt+/O950F7AlWs40ZmYP7l9ruwnvBC6i6JzRLoMDYES7R5r6ws9iw0InCx3Sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbWAUDIB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711810948aso6644155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960954; x=1763565754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTx9IrqWxLtZaQBaoNbG+/dbV5fx8CFro3lQ5MrSIGY=;
        b=JbWAUDIBJCrafYXsLOigKStKvlex+vPCsmvNvMOU2XAQ1/fPMR/0vdzg0m/7s9knkj
         hEKEn97xv8zIT2AKLEfx9cblFAtALY0LY5QM9VyFnwB3oobGs0WM9w9+pv2jPFJ8MPi4
         nG3WwcR1FCiT43IdKssFBaXQeuiIC1LOSFwr0u+AHBZFrKIf9j83tyPSt62FmZqac/tK
         43Dw9pt6p9Rfr33BVwY/ASi2FxD15KSOpS/ZTFKPvbo7alk35no0gwvPe2zPovXz2Ui5
         0rsIHDmVOhGm8cPk7ZbEUbM2h1h/uxtewjeAyK3zjqKI6N1GSTaj7O46OUiSpp8IIXJy
         y34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960954; x=1763565754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WTx9IrqWxLtZaQBaoNbG+/dbV5fx8CFro3lQ5MrSIGY=;
        b=STZFLXX7n0K4ZW8D6+JEWJZ5quOl5zn8iw5HJ458E9tzbTemNRsciZQad7rfcN+KpV
         7mQBQX2vuTA5rxbu0trCl+ZmLAF4HjYXe0ddDa7AVNN8iXWb2TMG1b6HXboGGi+dBPbc
         I3yK/bQn4i+32oN6Z4VrRfUgOkAurTN4l+PdF8J3GnFwk8UrRZgDop9Gu87B8foSZYZ4
         bi8+3t5qh3F6YqlLaRJ3nDHngty6sK+Efj8NlVTPHoftCiy+G+QcDA/oRBgjZPntnzR4
         m22YyuqbRVoYobVzOSZhg1KdesDIIXFWDKHGHAj5MC7UXFQKsu6DkWcU5BfhWCi8Qgwu
         tJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV00t8XkQ3dVrli5EegQ9aE5AVi75oH/36IvfrLLvK0kWvVCAwPsxDwR7aWGXZ7VXG8DLGYFtBeY+22yQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EQrDuYFy4tBSRrm7ncntwcqMOaIhvVCSnrY1rVuNSh2aHoEO
	XTuM3CzDUfpArP3qJf+6iuI/xUk9yDhfw9C1o5aOTh58AOho+WXB+eKsfd5DOIBKH/cAKHfrZl6
	5XjLFfIU=
X-Gm-Gg: ASbGnctCzjHjYBK9jskYP6BQx92tmhWmiSGuf+WWM/68u+SgEr3g+4y0PVy/KMXGmJw
	gbi6w9z/8dbYqD4iAMyGnWtX46Q/XK3tS5uXp+cxB7XDnR0n8Mynp/o4SmXr7Wy3j5sg4TD739t
	tTAm7aBYKOLISg5M8+aOGz2srbcseKxPDUmvJjIxvvsAg87wJwaeQmQGwc3f9gwxjfe0Nyc37iq
	d86qEP1uX3Pm/TFJ+Ne05SYqLCJfN7cVeGqwu7wYIO0mdfndfj+K54cilBaBZ4YCZNUxGGE6Zj4
	ICm29rM+7ZB6lnEDtgX9WB83Ckes1ysNBOdNz8UqQ/o2QzX2naLSU0afYdQDqzuk82m0Ed08EfR
	0/+dYcvaZvNOC37iuR/KEukk859T7my8QonlJKafeKHjyEaCK0TTEA4AEGXwww284c6JSiH3jMq
	5WWOvXE219LA==
X-Google-Smtp-Source: AGHT+IFw5cqZamC5mYofHQFAGIs+CpErGeW7hJbNKdZt2prmVHC1gv1dK5HcvPNjN2fBGVGfPd1yoA==
X-Received: by 2002:a05:600c:c4a1:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-477870b2d84mr28776855e9.27.1762960954356;
        Wed, 12 Nov 2025 07:22:34 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:12 +0000
Subject: [PATCH v4 06/13] coresight: Interpret ETMv3 config with
 ATTR_CFG_GET_FLD()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-6-165ba21401dc@linaro.org>
References: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
In-Reply-To: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Currently we're programming attr->config directly into ETMCR after some
validation. This obscures which fields are being used, and also makes it
impossible to move fields around or use other configN fields in the
future.

Improve it by only reading the fields that are valid and then setting
the appropriate ETMCR bits based on each one.

The ETMCR_CTXID_SIZE part can be removed as it was never a valid option
because it's not in ETM3X_SUPPORTED_OPTIONS.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 24 ++++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index a5e809589d3e..4511fc2f8d72 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -28,6 +28,7 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
 #include <asm/sections.h>
 
 #include "coresight-etm.h"
@@ -339,21 +340,22 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
 		return -EINVAL;
 
-	config->ctrl = attr->config;
+	config->ctrl = 0;
 
-	/* Don't trace contextID when runs in non-root PID namespace */
-	if (!task_is_in_init_pid_ns(current))
-		config->ctrl &= ~ETMCR_CTXID_SIZE;
+	if (ATTR_CFG_GET_FLD(attr, cycacc))
+		config->ctrl |= ETMCR_CYC_ACC;
+
+	if (ATTR_CFG_GET_FLD(attr, timestamp))
+		config->ctrl |= ETMCR_TIMESTAMP_EN;
 
 	/*
-	 * Possible to have cores with PTM (supports ret stack) and ETM
-	 * (never has ret stack) on the same SoC. So if we have a request
-	 * for return stack that can't be honoured on this core then
-	 * clear the bit - trace will still continue normally
+	 * Possible to have cores with PTM (supports ret stack) and ETM (never
+	 * has ret stack) on the same SoC. So only enable when it can be honored
+	 * - trace will still continue normally otherwise.
 	 */
-	if ((config->ctrl & ETMCR_RETURN_STACK) &&
-	    !(drvdata->etmccer & ETMCCER_RETSTACK))
-		config->ctrl &= ~ETMCR_RETURN_STACK;
+	if (ATTR_CFG_GET_FLD(attr, retstack) &&
+	    (drvdata->etmccer & ETMCCER_RETSTACK))
+		config->ctrl |= ETMCR_RETURN_STACK;
 
 	return 0;
 }

-- 
2.34.1


