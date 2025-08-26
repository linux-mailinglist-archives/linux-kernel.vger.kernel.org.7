Return-Path: <linux-kernel+bounces-785765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC8B350D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8198B189C847
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B0258ECD;
	Tue, 26 Aug 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjeXGEnN"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C1C27EFEE;
	Tue, 26 Aug 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170587; cv=none; b=E7OtrKxXiyScyvEQkiY3VTpkSy7LUv5dS5kOIDJCbs3MP+apW7mkrp+4HYhzbOZfJPSGtdXwq+YyZrtC5kv9YTrX1gwWDHKXVjbFpfflrPSPNNNy7f/1LHLcfRT6pXGK+PnoZw6vHouKb/SXyz38Fa9iJ1mqeBQEuLULxGBZ190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170587; c=relaxed/simple;
	bh=cG4YLB8fcRCQp9z/a4wbR6zYj3boTDYm2wYTkAWOUY8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzHMYxPMu/+9KHVuLIdhzNy4F+xLsoCvh8oLdGbO+Qsgvd7EuqNpwY7g1/kVgrdjbWSbibgOhpe4F0/quo4U9hIWiD40FAREza4Gql3vRG0hyvVI/OW9kQBYtrr18QfPI0cAPC6h2JM9hmSmv0DuhozBLkEFWVku+p7qxafngZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjeXGEnN; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-743749537caso4813538a34.0;
        Mon, 25 Aug 2025 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756170584; x=1756775384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKcbDX8RSeeRVr6XtjQvaqenalc/kXd0hVTqBKK4oPg=;
        b=kjeXGEnNKVO6kpc7BpG0zkhU6xeYfcYeOAy1uUKbbiQTlKtTkbD7DZuUEZzv+k2RJd
         RpJzzRrnjJ5FZPTugLuBOJteFxKLT2dI3fpdB+9P8DWjB70XPnqrEbQV7hjfEKMKxkm1
         gAdhdVwFq35ipiaA0Z2IX3ECUV/2hk4zCQGztFVhbC3SRcGnoFDyYrdoDmVjlPRUJM0+
         xv4DEn5KJbSKF6L/qMP3VQ5oHmpjKpdW27U1JOo8cCJhffjGlZhlX9RjNHFaCLtOF4E9
         DqRchIm4sk1NJB4xCIlBkFhdU1qd40tAyUa8syeaQUT0poTHucHNOse5qGNcHUhK9rf/
         e7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756170584; x=1756775384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKcbDX8RSeeRVr6XtjQvaqenalc/kXd0hVTqBKK4oPg=;
        b=Lao6nUY6ttWvqhrQ/lVR/n8pZgPTVEHAYK+ws6rCQnq5nI5gIVROuh7OFvn5hyWEp7
         QBaf9YmnupCVj94aPL6kcFE0H8C+CuJlDB9ldF5V8xNfmbRhwi9WhZy0NBYYRmKIAZ3f
         Se0UBYyU1MqukpCbQST1fSaZrDZEfRYmPDRCy35JSw1nWDI6C6qvpAIfzarAeBWG17Je
         deXgqOLW6SxYsLKRLHtZG0yYqU/8RrF01Y0eUmRR/9Hpm4mGWH7z7TORLzc+7dpFEK1X
         d8SM31XlfDVi/w0VmnclFL6qQh2FvFpNBMwcwF3IF3M8e71gMsqxh6m5wO7N6jRJ3f34
         /mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqyOjiPJimz+y9jzlD1V1mKtnSJxg//4jjJFeV0nsipfrZqalLhdHuBdWzo2zLSi+AzTYOKqWb8/XZ@vger.kernel.org, AJvYcCVh44EYEg8teEC217VrP2Qds3AA+EQyrhzbiiRLRANEc6I/zbEvzy14B/GfDQCp/x3zz5XXe+lHWQ9+cloE@vger.kernel.org
X-Gm-Message-State: AOJu0YxtL3mfr/lXmOGvA8U5r9F7wazEI68QtuE4GojD711gtsg3Oq7R
	fTX4Fv7ZeOxCxA8G6avJWf3CD3CEo5VlZCUyO0ThieXax82ZbsfWrZg4P8uz9js0
X-Gm-Gg: ASbGnctburqUp/mGf9nt2y9GPYKaipSvOU8VaqwIC5rkQZhThhaMmL7zPTdw14fiHNn
	U1d+/Yxc49biJPytkoxQkLDFYVKwDw5imcCykIGCyHDBTLRSemtNr5NOdsjmpH21P7nowauEWN8
	etUUJsNkmXM2CTcrANIJzLip1SRL2Uj9rC4ESQ5QqM6IbWD9tkd1LIifogmYnSkXKPrgec9/lwj
	d8BLEL3KhHURxCpBO5jJqctZ9k9TrNza3GrFWi3520JVR1Gy3bN5dnI5Jbm+wJVG4HuhTW2qj4g
	bglPiUoFgrdBSIR0PPXQpePUFFBQG1W2WdOXAMG5bAngCZQRTwmHePUkCuiWSBk1Z13neVDbBBP
	shnNnj5p82fzx6Qd7CJ7T/CzZ8QuZrB2g
X-Google-Smtp-Source: AGHT+IE6F65QfwFabXNAuH7zs863T2wcLpZREnYgSei9bH+TLiPtsmlTeVF5Ku/WEWK907SSi5O82Q==
X-Received: by 2002:a05:6808:1799:b0:437:75ea:6c77 with SMTP id 5614622812f47-437be056166mr849846b6e.20.1756170584317;
        Mon, 25 Aug 2025 18:09:44 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967dc1dasm1327704b6e.14.2025.08.25.18.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:09:43 -0700 (PDT)
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
Subject: [PATCH v2 1/3] irqchip/sg2042-msi: Set irq type according to DT configuration
Date: Tue, 26 Aug 2025 09:09:35 +0800
Message-Id: <49e70989c2f0a8a67e48527e57b4877262996214.1756169460.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756169460.git.unicorn_wang@outlook.com>
References: <cover.1756169460.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The original MSI interrupt type was hard-coded, which was not a good idea.
Now it is changed to read the device tree configuration and then set the
interrupt type.

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


