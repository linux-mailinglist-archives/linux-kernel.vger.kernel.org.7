Return-Path: <linux-kernel+bounces-761674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202BCB1FD45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC5A175A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374D14B08A;
	Mon, 11 Aug 2025 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrpQgDk/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1032184
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754872048; cv=none; b=TjRtx0Y1eTLRZ7LrRZd7u9qD7yIatu+t9o7QPur6CfT0EW566h6C/d85SdGzt1o8/DxVAFKOwDc/WMA6qhxC1jn7eXtu5XLgrL77eT3RBZURYy2hu5icaLgk4GbkrT6FWUgiysi9tiasjlgmq5dAU/dXssoRksp0Y/7WyWLyXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754872048; c=relaxed/simple;
	bh=hJiLt5MTDUEyDCQh8Cw+hE3CjYz5sE6fPRE6S2XMmx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzWP7YgQk9vc7nXglcT17fVKQMTppeyJYmYNaH4iEmt8RBMKKqtn97rgnOuC+y+yLYAniqMq5klQ5NwAt1D8WFWBv1w2PLQH0cmlWH54oIAuJQmKvrm4gxSgY4HHd9KKaAc/IUgBBy7tmzVBgeVZ9+1EdyXTLAToIgm6NNokFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrpQgDk/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3322fef6d72so31062541fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754872045; x=1755476845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=le03LPNNHn04eLr4/u77ZQYFIPVReUnHNpLLeRwxm3s=;
        b=FrpQgDk/3AdDbpchANOhirsyayFGenm2cfasyy9x+MSUUK3FDsbzxtvS/+DpoKs3pq
         OdNluwIQ7/IfqrbqenH18FG4gLIWx/kjTs16xnSl/ymJakZg66lHVaLHZRcNze/kPOWQ
         stF8nBsbW8WilArV1fsrlQXtd6MLMkFhTaI5lhhdajMiVtQHqRuWXsEMv0mCzDpZYOSz
         L/3KBIGW24+dXozqDHeKffNptxx6VzhoKfFPTRJlo6Q2joVbkFO6O3DtEafTB6A7Y3FI
         WRb2PzojuXu+6BZ3Y0smlrGR+74wpNSDxQYio+7tHUnVorsxGMmsehYUYs2aCu84oBfq
         K3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754872045; x=1755476845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le03LPNNHn04eLr4/u77ZQYFIPVReUnHNpLLeRwxm3s=;
        b=poBuxgU+SyHZOuT6Ykr5Z0Z2xZmxr0StxCHBFzMqTYq2AwUF2Vy9kfp0hGIg+PUObL
         xPrYF0kzHoukRuCrlNs5QHkEvtntcMTfSc3mlvuYC5CV3tCly5IHPw5Wfd6+a760iqja
         CYQ3i4a74OKrTZM/t8lXdCaunS7o9BD+gcSIUu10ONALyY5AMSi53L7g01+5Td5Mpxb+
         hXSvV4nGTdb2qElzu07fXU1GgLPUlZ1RDb23DbXS5uHXPhk6sGrHd2F4P9t8kUXz7bh6
         LD6SnLJvbsuLGU8l6LcaDEeufIDzEMLuwfPmqaKZeLfJcnX8nb57DRdhRR+xu71J9kSN
         0g0A==
X-Forwarded-Encrypted: i=1; AJvYcCUj15mVPIwywzj83lZQOxVONdgvV56oTlMpMW8tEF/B94KRh+m6IMlHNpEVAHpHXkJIs54fnf3L+vAnQIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAimMVlo/L/5wMCk3WVaoYKNATr+lDBOitErmUPGuRQn2uJEh
	AGRfPxwP7uViz5rD1d7KNGlpOPyoESlk1Zxi7vJQZVzlaA4EJFSfYHf8
X-Gm-Gg: ASbGncvJ9gaqYUiHAt89pYG1xLAzAsD4/CKx1t9WV2N0ZOr+dPwBaC5lGAKGMTh+lav
	NxKUtYKkuJktUvhOVwB1DNJAaeOREcdoOCIIM4ItB5zAHiGq8wV4sF/SdFTWpuiunZJDACnYzTP
	KBiTsZ0dhI+FwPR7OtYUZ0j3aBehT6l0YXs3PsDp09SRrAF1Lpm7sf7cu6zIM9WrT/+dPels/4H
	gMy2rrRdssYWB/6iaj8OUL08PRxQdIB2uHAoqS9aRe+uSZ7G63WU6WqarDR4h4TGCKH1shP4KVL
	bZngR0jlinfJtzfTGMbJjpbmC0C96mhKaJz4hMpFIqn78Il+1+9fnjAGZNnXGgjdCg2g6qcodA7
	hj43vMsf6UW0HQG1RvpPfIg==
X-Google-Smtp-Source: AGHT+IEYuqYxc29rjtoFT0RdJhS3Q9V5ytjnZYdUQkNqH7yOCrCWU+IPPq3TvkF9B3Eda73OdjdnLQ==
X-Received: by 2002:a05:6512:b82:b0:553:37da:2bad with SMTP id 2adb3069b0e04-55cc0127ed4mr2807412e87.38.1754872044364;
        Sun, 10 Aug 2025 17:27:24 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55cd02686e3sm472957e87.29.2025.08.10.17.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 17:27:23 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2] irqchip/sifive-plic: Respect mask state when setting affinity
Date: Mon, 11 Aug 2025 08:26:32 +0800
Message-ID: <20250811002633.55275-1-inochiama@gmail.com>
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
Reviewed-by: Nam Cao <namcao@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de> # VisionFive 2
---
Change from v1:
1. apply Nam's tag
2. remove unnecessary off-topic change in plic_irq_disable()
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..866e38612b94 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -179,12 +179,14 @@ static int plic_set_affinity(struct irq_data *d,
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


