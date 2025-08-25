Return-Path: <linux-kernel+bounces-784122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145C1B336FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BB53B445A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71B2877E7;
	Mon, 25 Aug 2025 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmvtsFq1"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1D28642D;
	Mon, 25 Aug 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104962; cv=none; b=NCmVLSz9gA/QuJeFEd0PpGcfpfyRoei7RIVwJiWmrBx8HSs+rqmA/RicSCkqgg9rEoSJNm1mztAwEseX5YnZm4kdeJRnEvpx1JYTJbUR6JjEt1YtZrRboaMLQcvsw6mbpy1p+n0a/Uflne83UE77N0EtDHh4HTNeX3w3v6kcXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104962; c=relaxed/simple;
	bh=8NCFynKKUdVzjEnQnUgNKwonUbri0AXtCEZV3rB+fik=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDru/DKF7clhks2DBQ63pZXCMrF6cjstOA8v0uIxOUtDMX/zQj+HOKeAbBpa2rKi7ZCpMboIjV0WRhGYbtd2FmoPFUlO1E8mznesrPGP2ezqzXTZDIw/MBKZsHWX4l1Q5DK61PK3OopuHT1VJKe8EvpuyHTH/4Fb8Nv6e+g3h4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmvtsFq1; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74381fdb5faso2519195a34.2;
        Sun, 24 Aug 2025 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104960; x=1756709760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ulckDe3eWSmf553AzjVX023UG188U0t36zbr4OOP20=;
        b=TmvtsFq1gEc9/LSVcFh2SUUBwLtd5//9rKHYnARBlTL/klhq8tsE/2TOutx7w2Dba6
         wobT9ZwCmktPQT1X0AULPvb8RjOTjQs+NjRKYAInfT/+I5zAl+hTxddMvPqtwLoitD4Z
         RpHuU2FfE9wKe9QlHEdFOvR2Hl1sXCQ+WZN8fRR8KShV5N+59juIpkTDyOb5oicNspLr
         GrTTaHmVD5hWCIh+EYEHdBLoBhY+xsdXn7yfH35insudyx7gQQjSq69RJ8fv49VbmTr5
         9CPIJUXZG6IiImjD1e8eO0/wFi07tax+6RrXPeNwzoDU/8Uqz/GCAX/sVjGJB6zy9G7Y
         TfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104960; x=1756709760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ulckDe3eWSmf553AzjVX023UG188U0t36zbr4OOP20=;
        b=vnigOjpZH9UR+LsP/pwvqB1OfGbXYftW91G2p6CgQ5NydNdWWiVmx9ab6UJmcW+RNu
         7+1VwySXSRsoY70YRER1XKvI20b9zEHO3FPCYEvss1fwbB8IVxUx5dcu0SZ3hDUGjjZL
         T0xRUfEX0aDq760iBnYvL073yJfuKM1AuizHHuqvtUw4DQZdP6NkVMgDeUkaW5DtrqIh
         o/kbRw5Lxc1jcmtrOEUs0VWdS/Zr+BDycArR1k7NY/0nwDd2NFAMkQhD4NuyZRR529tg
         c0cx5LfeGoI2l5oF1xDg31cbP9UvXo2EQoHU1MD8ZzdsWWTvO41teA/fk47fZDfA+OFo
         gmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCFxyUKud/rQ5jmJ2kBAj+3qfBxjROS1M/xATuPDlu/dPkCroalWYwH5UDV84E31/KobqFGgKS7zBE@vger.kernel.org, AJvYcCV7iJf5dvK+acWQPju5dSPOUMDXnWndT37xG16eyuf4AJSUeX8qyA9txFpRNlcuL7CywP8M463LlWGP+v94@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZkIGE7HynRZPhoK2h7Drn1gW81zTzUu+qop9FwSk4N13T+Gs
	CHSXLlv3n/kU5oyagy3TfvGa5Hn9QCYLdgjE6ib8JvDbmXww1hCX12D4vWJS+YX2
X-Gm-Gg: ASbGncvzAoNzLEQdayhk4cn1HCd6TdNZm1YP6TR0JEX+eMcsC1L8RnHRPb2egTY6fv8
	tYP1MnKMQxuDCmlor34RJWcw5KusCQEUJsGi35fv+1GntgBXPwQ5cwUjn2B/yuKdMLS08glWFA9
	ykqoFlpidRJlc0dX3sH6ES2zmSnNVdg8RiLP8YPlDiVuIdf/8jhF2rOs2KT6sZK/gu8UQCj7BaV
	T8rmvQ7woO7pU/JGk0kFlte6127bHD91ybS9E7gbrnqkUhjDzAWONctF/u9G2FIrhvhdfl5zBGq
	zbF7ZWlf06w5bIuH48JE1+WCSCN67YTQUpnVdqML/Vhrp4UkC/Hf4rBmlMQrVGpp4LKGCEK5wqU
	E23dKSeIId3qU57Or0ybfbq24GMOl54Qo
X-Google-Smtp-Source: AGHT+IGpwYqZSLvuloDemQpps6HazGQohvDaEOzeL74e9j9PrL6xU465ZXDCufj9C4D2mPl9+TYvfw==
X-Received: by 2002:a05:6830:418f:b0:743:2cc:d530 with SMTP id 46e09a7af769-74500a45257mr5265337a34.19.1756104960115;
        Sun, 24 Aug 2025 23:56:00 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61dc790aa7bsm894731eaf.26.2025.08.24.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:55:58 -0700 (PDT)
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
Subject: [PATCH 2/4] irqchip/sg2042-msi: Set irq type according to DT configuration
Date: Mon, 25 Aug 2025 14:55:50 +0800
Message-Id: <cf73d95140b03b586f44d2495376d367e32857ed.1756103516.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756103516.git.unicorn_wang@outlook.com>
References: <cover.1756103516.git.unicorn_wang@outlook.com>
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
index 5249afd93b4a..be47c038386c 100644
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
@@ -290,6 +292,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	}
 
 	data->irq_first = (u32)args.args[0];
+	data->irq_type = (unsigned int)args.args[1];
 	data->num_irqs = (u32)args.args[2];
 
 	mutex_init(&data->msi_map_lock);
-- 
2.34.1


