Return-Path: <linux-kernel+bounces-817429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0504FB58217
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AF3A321D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87895288517;
	Mon, 15 Sep 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKSUywkf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FE2877F7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953743; cv=none; b=q8hJLPeqQNRXDWYD6s1dc8GPmaJeEz8YJi91FZd+GviYdaNWjFa+42ByAkL30wdxh1FU/cSU+/KSqQwirg9XFcU6CqrIZCaQulpjfHTeQsZksDBCzhSy0erqp2pxPwIzOTUakOLL9pveFY39o4P0cgqc6au3MisC2kUw9oJS+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953743; c=relaxed/simple;
	bh=SapIqnwTojIEKvm8JJFE1rz8q7ui11cRO+zNNtA+z4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2WZuMfWKZ92Bq8ahlDidVeZTuZgMXTZd/9+IHq4xjUwgcfDSZJinKH+Cl2QQaXaP3fSdUktDqM0L75RlwctTEBaEn1dBz1B4czAW0zggIozIxcvJ6sATS7x/4jf+hSpmFHd5aT01j42PG0E4HdOWAL8zhdCCFBusrBdS5FhF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKSUywkf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757953740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=90J5I7tDJWuTtR4pzepvkTqrxkeGN9PC3IPf6m4g6yQ=;
	b=cKSUywkfgEEQQjwh6LL1H+eMxNJ0An1zmlDOvSeugYKP4jnlqj5y+3yNJ5TtNi7dCMl+69
	/RzY/WXywV0MjHfyiuYhwM/Xjtg6Clp1p9yt2B8KIQk4drIrDgCX+zuDAcVoPybhMKLO2U
	MtEH7qysb7M5aBahFkVjcLVK2O7PqR0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-fS3RZhW-Pp6NdfZIUXHj4w-1; Mon, 15 Sep 2025 12:28:59 -0400
X-MC-Unique: fS3RZhW-Pp6NdfZIUXHj4w-1
X-Mimecast-MFC-AGG-ID: fS3RZhW-Pp6NdfZIUXHj4w_1757953738
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so37242575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953738; x=1758558538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90J5I7tDJWuTtR4pzepvkTqrxkeGN9PC3IPf6m4g6yQ=;
        b=ZyOC+80/B+2MDADE1FDR9AMVfXdkugIFcHhbXYeRiDEMbg9QT1vK5d4gnypleNUNgG
         vpaXhONkohoYShBu7TUr6EwIfXg/jDKV3fh3j9LlBFj2jwF3DjohETAbdF0YNKJlTRy2
         Tqz/rTfMao1628AyM/mVwugyXpItq1T0Gka2F4bpCQxdp8k/PjUj8Jh47DNcNTvpiFeQ
         xoIZwsXzQ/InkUtY2HUlLaEt+lPbbCZa+NHKuwaWmsqts8oWAHuQ/6lb5prMBF38dYTI
         yhKO7J0VUAmOqJwfZlXhXW+EU0JXPeBcQYkybF/jxYVuml6cmjsYvyZUpLkmgFhH1KUA
         BP/Q==
X-Gm-Message-State: AOJu0YyHP4O9gPRhJy9UBS3EEwNVvP2hUF1Ob0HC3fL6LmZ25zjQpOw6
	SmJ2sLLvJXy4c26JtjBGmlzdCbB9uu3agxq+GwBAUjMqWFRbGeXXyzP4QWe7HntJwcjrqgSLesu
	tKWYtv2BDfLYj4+UAB3tx8ajUIUP1yAgjLNCvDzqlO/Ae9biLXlvlZ4COX7EY82XTzv8xOue/N9
	3CmiViOmnhUov3Bfpfi21MPbJQfv3085CqCPcz0LTZtUoFZr1WE8pf
X-Gm-Gg: ASbGncv3WzI47uGvHd3JQafdvJoLkR/VgFaHIXirjNwrFlPvpFKfyDAx1I9a15/ACi0
	YZSyF1wLndaILx9pdPRkqt1n5V3dkCswhO6OW3YQhTwNeKsZW/cz+HhFJld2vmfobEAGk/2U4zh
	AfsUnsiV6FB2dVdQvzh0g4e/UptpeBGaUsmBFQjhXg4OTCWer3mOHVdczfUfoZgD9dr8ngnxk8s
	DFuAtXGVjhADPLQK0mpoeJ6jiB7O6Ct8V0d0act3r+TW8Y4Cmfn07FHCbna0LFxM40MhTM3wjEI
	Gw/klOR23tqZM7fkcTuGVEEvF7f2WFZN4mRdvHSieGYdOrn5/iY5TF4=
X-Received: by 2002:a05:600c:1d22:b0:45f:2bc1:22d0 with SMTP id 5b1f17b1804b1-45f2c422f88mr52741735e9.33.1757953737882;
        Mon, 15 Sep 2025 09:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGcqLg89RzAzIylVbUAdhxQnrbuII6q9BMD4UeHPPpyAnAih60GUdiWlXGIqVqjdTWEN3ljw==
X-Received: by 2002:a05:600c:1d22:b0:45f:2bc1:22d0 with SMTP id 5b1f17b1804b1-45f2c422f88mr52741475e9.33.1757953737422;
        Mon, 15 Sep 2025 09:28:57 -0700 (PDT)
Received: from holism.lzampier.com ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm12840179f8f.42.2025.09.15.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:28:56 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH] irqchip/sifive-plic: avoid interrupt ID 0 handling during suspend/resume
Date: Mon, 15 Sep 2025 17:28:46 +0100
Message-ID: <20250915162847.103445-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To: linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Samuel Holland <samuel.holland@sifive.com>
Cc: stable@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>

According to the PLIC specification[1], global interrupt sources are
assigned small unsigned integer identifiers beginning at the value 1.
An interrupt ID of 0 is reserved to mean "no interrupt".

The current plic_irq_resume() and plic_irq_suspend() functions incorrectly
starts the loop from index 0, which could access the reserved interrupt ID
0 register space.
This fix changes the loop to start from index 1, skipping the reserved
interrupt ID 0 as per the PLIC specification.

This prevents potential undefined behavior when accessing the reserved
register space during suspend/resume cycles.

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Co-developed-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>

[1] https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..1c2b4d2575ac 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,7 +252,7 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	for (i = 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
@@ -283,7 +283,7 @@ static void plic_irq_resume(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	for (i = 1; i < priv->nr_irqs; i++) {
 		index = BIT_WORD(i);
 		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
-- 
2.51.0


