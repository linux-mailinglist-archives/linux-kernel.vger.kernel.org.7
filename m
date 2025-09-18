Return-Path: <linux-kernel+bounces-822999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FDB85396
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F0144E14E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AE220F2A;
	Thu, 18 Sep 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MfKQ5g72"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9B214812
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205683; cv=none; b=Vqeq+pj+MUsHdXrb0RR5xbx6J3g7zC7s9sxsImur7kOuQeHi5oCuHy1x5G6uVaOpEkAwWFhfVA0KLtyyGWAw5O78Pkw4xNwZsJU6D0w3ACisl4PqsBba3bUg2DL/enCNegs2CK7qVlsw0uRtvZ2XfXW/ZAi1RYFLTr0TFJF+zCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205683; c=relaxed/simple;
	bh=iaDzhMt30kkO2psD8Qizcph3nBLEmFFYpS976P2x6UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Im2aabw3JQ/E2JydLAoS560m+5buYwy98n/cP/sispjwtDMbgQzz4voHQzQ4w8jQfr70g3H67Aoessz0ho7QasvRpdA2hR+f27dw3+iXOwuzh3SAd4S9U8dO1g4D6UogI+nhMT5bqkn/fXWHNtqan3bPHMK3IqzBXpcuBdG8Syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MfKQ5g72; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7761b392d50so1376268b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758205681; x=1758810481; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRxrR61lHi8YfDjlJ2Swbohv7CSI8Q1KLjlvrovFA64=;
        b=MfKQ5g72BYrLfoQFp5X6Dkyenue6fpAVQNzhL/xS1qEv5jvoL4HH6G1ig8/lOj+eNN
         LPsid6wkXL/+BBPkmS7Q/L12dThh5J0n2XNRUakZTIsxSFVhxWmnYz+s8oEJGYofmClf
         rLtBpAQBMEWE3SpHZUjl7wxU43+XoYd8G4QZaWMFpoidlw/IAJEQ6S+nuuEZnvu8QNtK
         H3xl27bMN+KQQNf9Y89yVWADNEe8JuxTuClIyGvejwfrAoMzwp9le4Qzd1GktlHWWQlF
         BjuNRwnl3xOSQu5HYe5f18gA0Dj3h8TzuoCJg/C2QDlkUBQf2yS83o7gcf8OE6+9QvJZ
         A6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205681; x=1758810481;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRxrR61lHi8YfDjlJ2Swbohv7CSI8Q1KLjlvrovFA64=;
        b=QR/bTL/jRD0OIYjTKgCXe4b3v6YLCCXbkjNB0WlRNdqU1PG8CT4NyJbFa7r2eUfXcD
         Qi4DIrS5cl7kAnBCat+QFueKttuRSgO0g7/14X9EPBQOFqJI8s75ScoF05oznny2tFi7
         /qGWd4oFO49Gox+66GXWcZDXGcdP41AkaF+M2i7WWPRYSlZmYTvh+oQ9Phbu0scZi3tl
         DuFY99ryLu6EKOIbRTS+ZrzSRQ86ghGbLHVslwNMgXUTPoZLQ+ASFmYiCo/HeFEZ+Wwi
         8TZUMARDqwOgyFQgZZ8uydiAEamD6DjHU+sp60HMVCiRvC9QHzlcfpx6mqo927izDcHD
         3snA==
X-Forwarded-Encrypted: i=1; AJvYcCXQJi4Co5CxPM2M8VkfdAnusHvX8RIDWAdGwlrwz/ZHnTnxtDIVbupotEm1PUeMcKb71RImkxLQHFW6ZeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFDjgkmFnAfmyLWMne3s8MnFjyJj5iirGH+qOWR+pNgIeXmwse
	ZRRdRSMNUZ4w7iKt/qzeuZoBRHiaZy+4Fsb+XSS4lK5iareJydDDMlVzgHRqnIZ07HQ=
X-Gm-Gg: ASbGncvzT+huTXyZCUY6kL1sKWSqQWu7IdtiDMQeqq+R01c2T7bab7kIyw3Fvh+RBBg
	m0FPQ1dyqbHRqguYTTPSZztMO1ISHpwybY/5/dnFJhoeNBphYyFNDznHjcibhA2nVDBgwKPVMJ+
	Bzn3POmxEeWe533dywTVhkAqW6lq54YFQOVGFthRf9uZ+XGz+0wTkyoeTmk2npFTzy13swzsnr5
	qfWhI+pzNIN2o49Qc9JdXwff5bLiJHmLdCai85Vcjv3ull/GKhjJ8c1x3eXo6aGPWXG9n/gqWBF
	l9yjoYO1hJYl0rXbmXKoejFyONQxaSeIFrD8xCHTrsKTsOnwxZvAO7B7hCIlH2+zWvydYiamEDz
	fTWP4sy0Kqew/QGXH8Bc5WdeVDSTXlwtl65JxU2DGX4egTQwnvdCcNGRmB00uWem88gg5mtHo
X-Google-Smtp-Source: AGHT+IGX3ygannk3UQBorLwV5GVyyCXVYSV22MwTihX9JUHF1ySlKjIfi3SugfECASUEvkieA77bUg==
X-Received: by 2002:a05:6a20:7347:b0:262:23dd:2e93 with SMTP id adf61e73a8af0-27a798c703bmr9010621637.0.1758205678719;
        Thu, 18 Sep 2025 07:27:58 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff447060sm2460614a12.53.2025.09.18.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:27:58 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 18 Sep 2025 22:27:27 +0800
Subject: [PATCH] dmaengine: mmp_pdma: fix DMA mask handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAM4WzGgC/yXNyw7CIBCF4VdpZi0JCqWXVzFdwDDUSaStUI2m6
 buLdvmdxfk3yJSYMvTVBolenHmeCs6nCvBmp5EE+2K4yEstO6lFjItYfLQic1zuHD7iB+t9opx
 5GkUwloJUJBtUUG6WRIHf/8R1OJzo8Syl9RjB2UwC5xh57StE6SxaNJ6axigrVVvXEoNW6Dptl
 Patow49DPv+BbKbtO++AAAA
X-Change-ID: 20250904-mmp-pdma-simplify-dma-addressing-f6aef03e07c3
To: Vinod Koul <vkoul@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, elder@riscstar.com, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
of declaring the hardware's fixed addressing capability. A cleaner and
more correct approach is to define the mask directly based on the hardware
limitations.

The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
all of which are 32-bit systems.

This patch simplifies the driver's logic by replacing the 'u64 dma_mask'
field with a simpler 'u32 dma_width' to store the addressing capability
in bits. The complex if/else block in probe() is then replaced with a
single, clear call to dma_set_mask_and_coherent(). This sets a fixed
32-bit DMA mask for "marvell,pdma-1.0" and a 64-bit mask for
"spacemit,k1-pdma," matching each device's hardware capabilities.

Finally, this change also works around a specific build error encountered
with clang-20 on x86_64 allyesconfig. The shift-count-overflow error is
caused by a known clang compiler issue where the DMA_BIT_MASK(n) macro's
ternary operator is not correctly evaluated in static initializers. By
moving the macro's evaluation into the probe() function, the driver avoids
this compiler bug.

Fixes: 5cfe585d8624 ("dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Hi Vinod, Arnd, and all,

This patch fixes a build failure in the mmp_pdma driver when using
clang-20, as reported by Naresh Kamboju [1]. The error,
a -Wshift-count-overflow warning, is caused by a known issue in the clang
compiler. When the DMA_BIT_MASK(64) macro is used in a static initializer,
it triggers a long-standing bug in how clang evaluates compile-time
constants [2, 3]. Thanks to Nathan Chancellor for providing these links.

While investigating this, Arnd Bergmann pointed out that the driver's
logic for setting the DMA mask was unnecessarily complex. This logic,
which was inherited from the original Marvel PDMA driver when adding
support for SpacemiT K1 DMA, could be simplified. A better solution is to
set each device's DMA mask directly based on its hardware capability.

This patch implements Arnd's suggestion. It refactors the driver to store
the controller's DMA width (either 32 or 64 bits) and generates the mask
at runtime within the probe() function.

This approach also avoids the clang false error reporting.

This patch is based on dmaengine.git next [4].

Thanks,
Guodong Xu

[1] https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com/
[2] https://github.com/ClangBuiltLinux/linux/issues/92
[3] https://github.com/llvm/llvm-project/issues/38137
[4] https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
---
 drivers/dma/mmp_pdma.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d07229a748868b8115892c63c54c16130d88e326..86661eb3cde1ff6d6d8f02b6f0d4142878b5a890 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -152,8 +152,8 @@ struct mmp_pdma_phy {
  *
  * Controller Configuration:
  * @run_bits:   Control bits in DCSR register for channel start/stop
- * @dma_mask:   DMA addressing capability of controller. 0 to use OF/platform
- *              settings, or explicit mask like DMA_BIT_MASK(32/64)
+ * @dma_width:  DMA addressing width in bits (32 or 64). Determines the
+ *              DMA mask capability of the controller hardware.
  */
 struct mmp_pdma_ops {
 	/* Hardware Register Operations */
@@ -173,7 +173,7 @@ struct mmp_pdma_ops {
 
 	/* Controller Configuration */
 	u32 run_bits;
-	u64 dma_mask;
+	u32 dma_width;
 };
 
 struct mmp_pdma_device {
@@ -1172,7 +1172,7 @@ static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
 	.get_desc_src_addr = get_desc_src_addr_32,
 	.get_desc_dst_addr = get_desc_dst_addr_32,
 	.run_bits = (DCSR_RUN),
-	.dma_mask = 0,			/* let OF/platform set DMA mask */
+	.dma_width = 32,
 };
 
 static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
@@ -1185,7 +1185,7 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
 	.get_desc_src_addr = get_desc_src_addr_64,
 	.get_desc_dst_addr = get_desc_dst_addr_64,
 	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
-	.dma_mask = DMA_BIT_MASK(64),	/* force 64-bit DMA addr capability */
+	.dma_width = 64,
 };
 
 static const struct of_device_id mmp_pdma_dt_ids[] = {
@@ -1314,13 +1314,9 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->device.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	pdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
-	/* Set DMA mask based on ops->dma_mask, or OF/platform */
-	if (pdev->ops->dma_mask)
-		dma_set_mask(pdev->dev, pdev->ops->dma_mask);
-	else if (pdev->dev->coherent_dma_mask)
-		dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
-	else
-		dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
+	/* Set DMA mask based on controller hardware capabilities */
+	dma_set_mask_and_coherent(pdev->dev,
+				  DMA_BIT_MASK(pdev->ops->dma_width));
 
 	ret = dma_async_device_register(&pdev->device);
 	if (ret) {

---
base-commit: cc0bacac6de7763a038550cf43cb94634d8be9cd
change-id: 20250904-mmp-pdma-simplify-dma-addressing-f6aef03e07c3

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>


