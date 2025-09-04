Return-Path: <linux-kernel+bounces-799782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53616B4302F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3B8202D81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF81FAC34;
	Thu,  4 Sep 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGjNQ+7q"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3BC8FE;
	Thu,  4 Sep 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954894; cv=none; b=SajKfrLgn++k1AR2Szdx1bWBz3dmw2wP3TT93smQVcz/eJn9kAWk3PvOB6G/zWEfzcNtDyn1YS6UgQ2d/qNE49Nfyf0UWVnNZlBQrBQXmEXkl0uJURReCohTuJBkDBwiuY3HlSWsLrIMsCE0JX2yfhpOYOfJ2H1gNw7En0vrPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954894; c=relaxed/simple;
	bh=OM+N0mj6PjGykT2FoWQd4MIbb/hzZ0tAzLpZGoLpbXc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHoTB2kceEQfDc7sG51Abx8e1EyK4qouMc86Q0kJaVWoXi1LXH3D9/l49ziyTsbtnTcGdWN0CM0EfVXMCE+T3DqCOGBjKgvhBXyT8fGtMb34P8PKvpfk0UjG2Ccyxlvqa7omsZFKoLop5jNojNI+DsddVNDJvrGaVgZasJqt7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGjNQ+7q; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-745514a7b1fso222681a34.2;
        Wed, 03 Sep 2025 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756954892; x=1757559692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9CajuAm7VsoRhpeotc4jxkIe8TBDwxy99+zM/DwbrY=;
        b=JGjNQ+7qgbqwV7Y3RdUGunC+3Chz063hfzn/x4hmKRpPVVQ9zkj+Sf5nUsq894WXis
         /OmQgisLlRm9g54rDTQI08++pnOvoqxiW8URQ7Pccf+aiD0evbp3XjdDvAmihV+F1fJm
         wqa38i1Y6z/Ri0dBKP5VtrMkPqP1/riOsO+xFiq1QfqxIOdRWmxuyCQCDP/3qzG8tAh/
         iOqr6BK4U4Ci8CvVv9dmGukQ69npzGWSxrVBcU759t5UWRZ+N1amzwQTeGT2OvzZ5hHo
         EU9+zR/8pnTBGxFpbRqT1sluy+zvVizl6TFBptoaZ4b2UcWnj7Wn/TPRhAVRgUGJzjuS
         ROkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954892; x=1757559692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9CajuAm7VsoRhpeotc4jxkIe8TBDwxy99+zM/DwbrY=;
        b=s2F+OHmH9aqDsBYTtjcCIlhN1rf9jeTPz4HtEBoeJ17rK9i26b41GiVzQEOdkdlrEf
         yQoEZLWmRY0KALzzK019Zl7FpNACrPk7MFj9Gpzs+3gZHGEzFWtv6HAJmehIH7IUObs0
         4Js6K+0xkIwLHku/M/oyGhFJb+gh8OKyj/0s1PP8k0bNmJLjCqlk1PYNwb9Zgyscapdn
         7PEvUEh1MCutYQiUY1PkVcORtyCdygrLtM2BHpUBytJ+o5XNpYbtIZOvoa1H8/HZ716U
         VTPiBvlF8ls2+rDrl7Kf8gLFFWEVI5RVQCbJ4GJ4fhMnl9HtqGJ8LkM8GPp236zJyi+a
         k91Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNga/mjccn1x13XMWn72vLzgd+HAexxdWGY1geSXQT+UGls58GMSWM2n7fcpi/MkB73vpeG2QDKxth@vger.kernel.org, AJvYcCXlA0dW4JzjPdan90iZibPIYsBobVdsP1KHzTklIhtdXT+I0v/TLClZ7wpG5ExPJ3fz8TmqOkWmcHV9yM63@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEiGSeXNzf8jewcNCl3w5tzUb+1/v0NSkj1MApOeIlHu7eWLW
	O+TiPCMTz2X3SB+d4eqJaY3Kbh05jObypxPqmxy2c/YVNZGzoEeMwEkS
X-Gm-Gg: ASbGncsXCrNllWeSrbQt39uvvWMJyu57tF9CzGZC2VWWFiHn8vISSZhWMRYdC0IkmHf
	VzsK+2qu4Q1gPIc/5LaXOHpXcvo+D7vXbKPWVyAplQcGv/pv9DY9xsvLHakuQz2EmwJJeBE0hnw
	Fy4FeTCjK/COD8x1/zK81amxwBVrLxLt+W70aVxOts3UioK6USGB143Yfpj/8m9fuP0G+rpiOPK
	8IqC9OI2m1+g/hyUUgAWHnUEKm+6Xh4lixrSVpS48WWZUWJOxxVtn4dUo5oXO3kObEVGmBWpkWF
	yiH2mbpYy8zxtuxa/5rtKEIX9y1jmxsNd/6qyAujyood4J1WZVmEbF7kYzaODvAV/QtzPq9Y2pi
	mY5KCvZkFLsncOAbWSnSZfMkmMbockeucvpO4jrODmjw=
X-Google-Smtp-Source: AGHT+IELP+mxSGzElVCEVywyn+fMnmBhJCUygHmISkh2tEXspU6mwEADZzjNbwOJ0l2qTQ0URFRXBg==
X-Received: by 2002:a05:6808:152a:b0:438:247a:7d8f with SMTP id 5614622812f47-438247a8372mr2232071b6e.4.1756954891838;
        Wed, 03 Sep 2025 20:01:31 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745a09af8efsm406946a34.29.2025.09.03.20.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 20:01:30 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v3 3/3] irqchip/sg2042-msi: Set irq type according to DT configuration
Date: Thu,  4 Sep 2025 11:01:19 +0800
Message-Id: <b22d2b0a00a96161253435d17b3c66538f3ba1c2.1756953919.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756953919.git.unicorn_wang@outlook.com>
References: <cover.1756953919.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Read the device tree configuration and use it to set the
interrupt type.

Tested-by: Inochi Amaoto <inochiama@gmail.com> # Sophgo SRD3-10
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 3b13dbbfdb51..f7cf0dc72eab 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -30,6 +30,7 @@ struct sg204x_msi_chip_info {
  * @doorbell_addr:	see TRM, 10.1.32, GP_INTR0_SET
  * @irq_first:		First vectors number that MSIs starts
  * @num_irqs:		Number of vectors for MSIs
+ * @irq_type:		IRQ type for MSIs
  * @msi_map:		mapping for allocated MSI vectors.
  * @msi_map_lock:	Lock for msi_map
  * @chip_info:		chip specific infomations
@@ -41,6 +42,7 @@ struct sg204x_msi_chipdata {
 
 	u32					irq_first;
 	u32					num_irqs;
+	unsigned int				irq_type;
 
 	unsigned long				*msi_map;
 	struct mutex				msi_map_lock;
@@ -137,14 +139,14 @@ static int sg204x_msi_parent_domain_alloc(struct irq_domain *domain, unsigned in
 	fwspec.fwnode = domain->parent->fwnode;
 	fwspec.param_count = 2;
 	fwspec.param[0] = data->irq_first + hwirq;
-	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+	fwspec.param[1] = data->irq_type;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (ret)
 		return ret;
 
 	d = irq_domain_get_irq_data(domain->parent, virq);
-	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+	return d->chip->irq_set_type(d, data->irq_type);
 }
 
 static int sg204x_msi_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -298,6 +300,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	}
 
 	data->irq_first = (u32)args.args[0];
+	data->irq_type = (unsigned int)args.args[1];
 	data->num_irqs = (u32)args.args[args.nargs - 1];
 
 	mutex_init(&data->msi_map_lock);
-- 
2.34.1


