Return-Path: <linux-kernel+bounces-895576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434DC4E525
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5E43B4933
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C173246E2;
	Tue, 11 Nov 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiVVR6Ni"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B133ADA0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870208; cv=none; b=RHcrpMtEK79cXvU+QYfgYRhI8wNGmt6s3w+cP+AtdaYitq4+T3qiuvwW0bq0/Jv2V5KACbwrxoY6Hdelcybb29u/D+mVEVXkoWW6gmnEOPx728ZLZA5flCaSnCTRFY9BBhzB7UP2pVk5EAzR3q6MDdPPtlYoJ4+jRgRxfD7NPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870208; c=relaxed/simple;
	bh=ouh72W58KiwNlpesfMOQFSgweAyrI6k/34yunDXjpII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFNly+1hVUq2NVC770Fz/NHIwO6eBMX6Qw/Mk4qlNWJQkkNDXPdqdihQ4DfG6LE08/CVHJSmhWBBJDIClX+x/TL4ZB5KCw2s57yV3woph72g9YLxYY0OegvsHp8SL24LzCfvFk10jSItJgZ+0GlihKud+L9NIv3Ng7RdfZfWdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiVVR6Ni; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b727f452fffso145483566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870205; x=1763475005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USYXM+dOLZTaPjQiHxQ3ZivF8pu2dJ5XZL+Nnq41VfE=;
        b=GiVVR6Ni8U3JZwpxwTUiPONjjZej2dYxJj10foNWqvca8EzY+UNR/q012CyYPQb6/+
         JjkLLRAlKgm3NrC8vO4EJ1k3IuVetv547pbXE0y5ZaYsX3Lwap8B9fInsRiVAednZfx9
         dDRe0T3LuiqiXAyibqk6InsRf79P6qM7XDx7QEET8qxXXfVm9sVpdB81UhqFIxuj5aan
         AXfxhcy4UwrBUTOSEFzd4yE1UOsHjHz6kUucWj2scOl64TWvTnqLaM3+vOHxk7lPBiui
         NeGPb0AWS+Y67G+YfFFACsvO4fHVw+utwXjWl9KjU64yxVgOZezPwMvD5B4EEz8qMJqX
         9s9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870205; x=1763475005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USYXM+dOLZTaPjQiHxQ3ZivF8pu2dJ5XZL+Nnq41VfE=;
        b=XvH3+BM2pR0S5ejgV2ppilGh7arB5QA8zRCpFetRcNI5CxFJ7IjZs9LpsTgGP99NBq
         t0FV0YGH69wlPltniA4BFzBQgx78I1SuthNux/AP7U1tDwSaM8dWJ8tZaR3twzrsbO9U
         ++aFDyOsxq9crJGRKFf5DTqxRa5hvqpOu0Hu6X1o+iXXVsy63SbDpMMlwuZ9Q+amviox
         ShmSl+acLPnglOX68ZE5RgPmkqEHQKgkiBxRd0gD9/LaR+a169nVocHwTPDYvQlsQYbo
         yTuKUuwyekVy2N/E8anUbMJCOtQdiGS6oonAXKrYLITuUIU8WelEZyvT3fMh1mPmVaci
         1wCw==
X-Forwarded-Encrypted: i=1; AJvYcCUkIY/4yWWMp7KF8hPyctuG9J29w0ucdxXeRs3OE1/01nkD3IpOMYb/JopXhY5imx6fe1NPOXBYiGHM0f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysgU9o0K+lXcW2oyVXm5MQjGsx8D1PQb1ix7SC2HAOZGHzxWVx
	kmz/johNug4aZx6FR3aok1lx8kcb9eq1vjivnaRWKGTqTZzXpQCqEedq
X-Gm-Gg: ASbGnctB+TKU/D0krvm2PFFzpDmvQT48X09aNOaTFD0cYOJbmKetMD0NZbcVHIpdXpZ
	Ybf7IM3YrW5QjIDe8Elto/9WALofkCteQwUJo/vDvlK/1rxfZRvvd1XXDnrP9NkBAI1zinXJNQG
	wFvZNXEKp3ckig9kQbKDABnMvQ9BEiz5a0LbFtjxqRVqDJ3+oHLbUnUaMHCqqLBc34qVCupbvzz
	W0Dsb7+F++e10ASyMh3q8UYrzL6okxctqvBuUbo56kwmmEFJcHLC8aQxvJWyY2T5bcqNC+BieAX
	s6qRjXiiMLu9/Imc2tBcTzGn6K22TWXl4tRrUVYesdIjpiA2Q6DdM45D/06gqcnwY8mcV6KXT2s
	n4OPCa3fDsadvrg6JlYV9/v+QbflgVtbJEVRZ/UZzzWff0PElbVtKRoC3dBttiF5YVTsNsT+VQP
	0H2K/g1U0J0/uyzXvqwnQP2CHFgVvp
X-Google-Smtp-Source: AGHT+IE4Ll5LBW5RyM+1WOlvKK8/cmC1dWwMG6ilEAqO+kILXAiC0NhdUUmMqUqe5WbFAmaU33RbYQ==
X-Received: by 2002:a17:907:944b:b0:b71:d742:5148 with SMTP id a640c23a62f3a-b731d5925f7mr409972766b.31.1762870204419;
        Tue, 11 Nov 2025 06:10:04 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea51sm1343928266b.4.2025.11.11.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:10:03 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: p.zabel@pengutronix.de
Cc: a.shimko.dev@gmail.com,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: [PATCH v3] i2c: designware-platdrv: simplify reset control and error handling
Date: Tue, 11 Nov 2025 17:09:35 +0300
Message-ID: <20251111140935.3220840-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3c3ece1a00c6e39d865c231e27508bdde0783070.camel@pengutronix.de>
References: <3c3ece1a00c6e39d865c231e27508bdde0783070.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current reset control management uses manual deassertion and assertion
calls with goto-based error handling, which complicates the code and misses
the benefits of full device-managed resource handling.

Convert to devm_reset_control_get_optional_exclusive_deasserted() combined
with devm_add_action_or_reset() to automate reset control lifecycle. This
eliminates all manual reset_control_deassert() and reset_control_assert()
calls while maintaining the same reset behavior.

As part of this cleanup, streamline the error handling by removing goto
exit_reset and goto exit_probe labels, using direct returns with
dev_err_probe() for cleaner and more linear code flow.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Thank you.

Done

--
Regards
Artem

v3:
  * Squash all reset control and error handling changes into single patch

 drivers/i2c/busses/i2c-designware-platdrv.c | 52 ++++++++++-----------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 34d881572351..ab15a924dad5 100644
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
@@ -236,40 +243,36 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->rst = devm_reset_control_get_optional_exclusive(device, NULL);
+	dev->rst = devm_reset_control_get_optional_exclusive_deasserted(device, NULL);
 	if (IS_ERR(dev->rst))
-		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to acquire reset\n");
+		return PTR_ERR(dev->rst);
 
-	reset_control_deassert(dev->rst);
+	ret = devm_add_action_or_reset(device, dw_i2c_plat_assert_reset, dev);
+	if (ret)
+		return ret;
 
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	ret = i2c_dw_probe_lock_support(dev);
-	if (ret) {
-		ret = dev_err_probe(device, ret, "failed to probe lock support\n");
-		goto exit_reset;
-	}
+	if (ret)
+		return dev_err_probe(device, ret, "failed to probe lock support\n");
 
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
@@ -309,16 +312,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	pm_runtime_enable(device);
 
 	ret = i2c_dw_probe(dev);
-	if (ret)
-		goto exit_probe;
-
-	return ret;
+	if (ret) {
+		dw_i2c_plat_pm_cleanup(dev);
+		i2c_dw_prepare_clk(dev, false);
+	}
 
-exit_probe:
-	dw_i2c_plat_pm_cleanup(dev);
-	i2c_dw_prepare_clk(dev, false);
-exit_reset:
-	reset_control_assert(dev->rst);
 	return ret;
 }
 
@@ -340,8 +338,6 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	i2c_dw_prepare_clk(dev, false);
 
 	i2c_dw_remove_lock_support(dev);
-
-	reset_control_assert(dev->rst);
 }
 
 static const struct of_device_id dw_i2c_of_match[] = {
-- 
2.43.0


