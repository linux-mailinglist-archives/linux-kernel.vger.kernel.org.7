Return-Path: <linux-kernel+bounces-895329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F2DC4D86B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22C434E7873
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECF34B18C;
	Tue, 11 Nov 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaAJ8tSh"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE499346E67
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861575; cv=none; b=tMUZJx2dMQ3E73p6IVFcOCYJprw5D7oNVgK9nfcqQ9i3TQ5V7eU4Zoo5ecYnuM1GUAR5/6mRMlaUBi+qrXyMf8d7Cd9VupelF+S2KQ88OhQsWUlQ9LW/6z5K1pz/o8v5cr3c/01VbTCQLuAlzMrRvzk5Y88MJ0x5ERy8CIJ6k0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861575; c=relaxed/simple;
	bh=Upj1jWoWgtb3YLXDrmSF6/3Py3j5ozE5cNqipSmKtgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYq5voi4uD2XDU1NFGAsb330a5d3kIw1ygaFmwh/lhDsEWqVjImrzg/mpBxRi48aWtLorp2TmZpXz6uMrVHTXD89Ll5XPNwP+3a/PQpi8LrQ/gSKZj32TCiUpEBGypmAuzzbncEGqh54An4tHI688FSw/ReV9npZXpg6lSSjxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaAJ8tSh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so6913131a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762861572; x=1763466372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHsaI+8ssP4NAxyErXWlA7Ff3GUFBJnH0j5EJl5VHgM=;
        b=gaAJ8tShl91Cyr9lvfv8MFAVnMAkhRCFYiuti5eSKDf0DpTmL/i7bdIFi8rXH2j9u5
         um/iQ6HxQdlv1+euAowH5u2g2Kw1AddOmMcUT9ZtzqsSujoBy5k+y9he8+NilO+zyxtH
         osc44ice1kYzLVXdp+T0BO9oPBkYB2GzcuXrHXClnqXxTB/i5zH9wJhnp6O3Z2tVi2Ka
         fQzZoueF81HWZGci1q7/IyFEMeIrThEtefqar9jZJDj0xNI95h0OK4uBL+OlB8C2WKt4
         NGgvyQfPOkh3TPjBVlFWDMjFWl3pZ2nN0beAf2MCeuVkUVhj4X6narc1NdslXCF5DwTr
         JkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861572; x=1763466372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHsaI+8ssP4NAxyErXWlA7Ff3GUFBJnH0j5EJl5VHgM=;
        b=Djsrh3b3Lx3LPwldBGWjvOJcudpq5BFGZSYQil5qjP7IRMb8xClbZWDR1B02Ai/K2w
         3RTZi3sFBiMU8gXn+GsOtdu/GrOH7Q9rckR0wwWiN4gBgNzDNRn0QIuPWnjDRGFHA/JB
         EqnprJKyk31ubcG2NR8LwhdB5A4HxY8ebCWb0JRff6EWjF5ogxGZsy/6khEk7NF7HNWJ
         55wsh7Ax1gpShniD3vCSdjTwu7ZMNe/jAXIQMyxYF+QjCfQAecvP+fGaaBrmk8fcqmXg
         j7V/Lcz7nh3t0CyS/4iLVmio13xx39X6a91I1x3L1knDCcNvMkoIt107Yi+0B50lqTQe
         ubow==
X-Forwarded-Encrypted: i=1; AJvYcCUo+0sE1A2c+oUJwx/KTLZ0JSdfFPhYCyLqAF0mv5ECZoYZnFW4DG8CwI1oxeZvbDxHRUzoLjdnaEBLVLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9KL7lKdK0Kn0osqDMPzfTqdHy0fKK34lGCdk6e2CiYbv2RwUk
	NwvWFDNtOA07nAVf5sHFPvuTNtGN3oYhM7OTgKj6mexdr41sOmxU5Okaf7TD3yLWk1Q=
X-Gm-Gg: ASbGnct2pEr5FlZx3G0gx1ZlQHPwM71+PSXdtqwyrzAsemXFKHl+9UBsQle207XrAb5
	hAK6Nty1uwZoBbvEvEF1TNyQfL1jG9mIBjIaCWqj086Y8BGEkCq6c7f8iTzfbcNthwuPgfY14vu
	tSl6ZUrA0u4k2emFoC2SakRGfw7+/hlFJb73lHBBbbxP1s1kIvKSXNrlGHFNZpLXI2XRv/a7fL0
	jeN06eRrMppxCPYLCXf672YhR/wckv129LhxVS/XIKp/1KngLYt19y1xR2rQOAiS+41Ud1ypnHs
	SI9CgvGyJ0XI4fEa9xGpJu5VfowwBWJckzyl+b0kw5G8p72BeV3t768L7g/2DUyCuzs2+z33ScN
	9dEFtZZE8jIZu4H6Zc2EI1L/qMtjyxyrjE9y2WmAu66dN/Kso6nmLdtq+U4aAlF5ZiwD8cxgIEf
	ex6sZB6hoE8QLIM9jmwlzwfCmqVMq4
X-Google-Smtp-Source: AGHT+IEV7fZalGu4772LIAkYKN8AwAJnb1OpT2vlRNHQtmzhU7UOMuLq43dBLQy3Nqdch1TUukA9lA==
X-Received: by 2002:a17:907:86a9:b0:b72:aa52:6034 with SMTP id a640c23a62f3a-b72e033df48mr1243491966b.21.1762861571740;
        Tue, 11 Nov 2025 03:46:11 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72fcde0779sm682374466b.40.2025.11.11.03.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:46:11 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: p.zabel@pengutronix.de
Cc: a.shimko.dev@gmail.com,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: [PATCH v2 2/3] i2c: designware-platdrv: complete reset control devm conversion
Date: Tue, 11 Nov 2025 14:45:58 +0300
Message-ID: <20251111114559.3188740-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114559.3188740-1-a.shimko.dev@gmail.com>
References: <e3c2096459bdd0c1d48c00a837cc7f8c18044631.camel@pengutronix.de>
 <20251111114559.3188740-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver still manually calls reset_control_assert() in error paths and
remove function. This creates inconsistent resource management and misses
the benefits of full device-managed approach.

Register devm_add_action_or_reset() callback after acquiring reset control
to handle automatic assertion on probe errors and driver removal. This
eliminates all manual reset_control_assert() calls while maintaining
identical reset behavior through automatic devm resource management.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 34 ++++++++++++---------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index c77029e520dc..d334af1d7c6f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -206,6 +206,13 @@ static void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
 		i2c_dw_semaphore_cb_table[dev->semaphore_idx].remove(dev);
 }
 
+static void dw_i2c_plat_assert_reset(void *data)
+{
+	struct dw_i2c_dev *dev = data;
+
+	reset_control_assert(dev->rst);
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	u32 flags = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -240,34 +247,34 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->rst))
 		return PTR_ERR(dev->rst);
 
+	ret = devm_add_action_or_reset(device, dw_i2c_plat_assert_reset, dev);
+	if (ret)
+		return ret;
+
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	ret = i2c_dw_probe_lock_support(dev);
 	if (ret) {
 		ret = dev_err_probe(device, ret, "failed to probe lock support\n");
-		goto exit_reset;
+		return ret;
 	}
 
 	i2c_dw_configure(dev);
 
 	/* Optional interface clock */
 	dev->pclk = devm_clk_get_optional(device, "pclk");
-	if (IS_ERR(dev->pclk)) {
-		ret = dev_err_probe(device, PTR_ERR(dev->pclk), "failed to acquire pclk\n");
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->pclk))
+		return dev_err_probe(device, PTR_ERR(dev->pclk), "failed to acquire pclk\n");
 
 	dev->clk = devm_clk_get_optional(device, NULL);
-	if (IS_ERR(dev->clk)) {
-		ret = dev_err_probe(device, PTR_ERR(dev->clk), "failed to acquire clock\n");
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->clk))
+		return dev_err_probe(device, PTR_ERR(dev->clk), "failed to acquire clock\n");
 
 	ret = i2c_dw_prepare_clk(dev, true);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	if (dev->clk) {
 		struct i2c_timings *t = &dev->timings;
@@ -315,8 +322,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 exit_probe:
 	dw_i2c_plat_pm_cleanup(dev);
 	i2c_dw_prepare_clk(dev, false);
-exit_reset:
-	reset_control_assert(dev->rst);
+
 	return ret;
 }
 
@@ -338,8 +344,6 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	i2c_dw_prepare_clk(dev, false);
 
 	i2c_dw_remove_lock_support(dev);
-
-	reset_control_assert(dev->rst);
 }
 
 static const struct of_device_id dw_i2c_of_match[] = {
-- 
2.43.0


