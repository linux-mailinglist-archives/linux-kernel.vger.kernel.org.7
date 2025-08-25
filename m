Return-Path: <linux-kernel+bounces-784121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB144B336F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A575E3B0CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1752868B3;
	Mon, 25 Aug 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2FUnEn7"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714828689C;
	Mon, 25 Aug 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104916; cv=none; b=UuXX+9pC/UQOAanP01pCTtUZ19XvY+RtJSxpIWnKC2s1Ax4NfIpIg+o9+nYLoFErjWCYu8Q/TFf8F7lhWgCwbijKj3AbSLknURDX6n1ZZU356ByZZJvnkkB+uUPrzO4UL3ZFrunac9qb8p6zHCnPY5Ktor+gKZLbsi0RdsfX1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104916; c=relaxed/simple;
	bh=XfvoWpG7yn1MnMYlFZwdOxlDXsB/OekSjnZ2x/KtlPo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTq7EkueCUnen5P65ArbCcL888OHFAVTzT6ffmlFxv4eQjMz8lCvvELq3QkBcopPGl+2LudjAUfQqPTHr8kP6eCearxqIm3VNfSJixgv55JmkjGCt9x68hVrWvgbNRT6UxdiU5X4M2dN588tOJZhSwzl/0sG2B7NMXpWn2sERXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2FUnEn7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cceb07f45so2635811fac.2;
        Sun, 24 Aug 2025 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104914; x=1756709714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+yGjr2heO21gMCA2kFQQZ2y9Wya4HGwCF6Hx9Cjwbc=;
        b=L2FUnEn748X/gUrfyTZXl+0fLKeDJ4cNu+MvJDfC9qhCMGeQyzceCCkh0Rtrtem842
         vpBP4bxAt8v7WwLfpUVz6eT9zbPBa831/IVdAFK6hMFy1GPLQqBlIZtYSiwygGeli0aM
         TnDZrYfeQE8yVEP7Oq8rW7H/U7itHWJdpQqjdUIQ4c0BWMkuoDnV1DcrvtanBuTPTFj0
         T3T7yA07BAoc2K/0bbmXGi8+yKoKmgzRAEATRKJzKl4PUIv0gc/uD/81NCdroXrZqy98
         hR9hoBym88BhdiUuga8yrxL0RSGDlxR2A/V9MF/CHlRfRqQqX6+9cHbNS2VpcR46T/dS
         CfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104914; x=1756709714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+yGjr2heO21gMCA2kFQQZ2y9Wya4HGwCF6Hx9Cjwbc=;
        b=jw0LQMgQpFMAZomsxB88rH4kwDw2KMXToqI8Th/wd3FpcgRCFWtxqUCAKK85/8MXvG
         nEww9GnsWIAwJOiFDUHnxH9C4lGPkkGrxRn43vXYGGOIoUn77CoL9twyC2PWuhlrwMfz
         xgFK+LoCGrOS6qmw6NaK2Pj6pPzgiqZ4xDumoeokYl8NnU0zKjad5tvFMip9zAakUolD
         4FNTQqUBgUYzCj5m7JbbNpABWJ2GtuiqKpjh3q93skO8h+1lcXbSFyqvXJkzKuFLxerB
         snO2UMDvhPB87WCf3hAhBgsKpUGzCNPknzULg6iiszTIUanmH58CHTDhWSQP4xDiPd73
         ZDFw==
X-Forwarded-Encrypted: i=1; AJvYcCWNAQLxKQ9fI4WtSFrR+UJn1BEi/qzkzizWOxNTmMIMkZHOEwySzpFfGDlwH5+sKtQsQcb+fQ28PMB1hKVt@vger.kernel.org, AJvYcCXgxf1ufv5LCoCbBPNBTX5LhYUXbid7h4NQHcWUv0mVpdvnCiWcCIGgbilcSgXIi2liRqWp1ngTQBhb@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOdrZPkcNS+WlZKexOa0HAOIBRQLbHqvV0WvSAvwkH9QdNeDW
	WGcJjI4A/Y3SZKI54c8EI02fvmiElmt2vL5UBUnChEwLhseVq+2kHsCw
X-Gm-Gg: ASbGncsBA4XBLtGgsProb++ZAco/ecDiQP06WxQOyLI8hcc0QdT7Xse+LgEBzrzkbcf
	iUwHFV63wcGWOc9y7dyA/qgi0/kSko+pYjRvHITlI7/B7c9Rmkgpvv5mZwcm0ryo/mE6NqS4QyE
	TbV4hMfm7NOyDP6Pw4Uzdz9FhUne1lLsOqayTvOeYp3BYV0a7NfHEfDq1yoy6yqULqMRND1rtMn
	q+8JObs6MsUpGnccepFVg7Y1b3P8uBfywSkpiSMib3/aaA6BYTDN0VG8tlw62AtHhvSdKtvFW+s
	ZNUcFMY+Mg1Vu0kqGWyDroHQv7NOwW7FPOPrRGmdzrNF6A0/ADzA5XV7N1Q7jenluX/lsjEm1Pt
	w9TGKeJvUTR9SourZLcWsiwIVh38Gz3a5
X-Google-Smtp-Source: AGHT+IHekG6OTGU3l6qQrokM25geuzr8Jsvhtci+xI2DkA29jrojoxfyJ2/APQwGqhsrHpj23jMdtQ==
X-Received: by 2002:a05:6870:249c:b0:30b:bb5b:8d8b with SMTP id 586e51a60fabf-314dcabd8e4mr5680879fac.4.1756104914059;
        Sun, 24 Aug 2025 23:55:14 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7d98e29sm1618117fac.31.2025.08.24.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:55:12 -0700 (PDT)
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
Subject: [PATCH 1/4] irqchip/sg2042-msi: Improve the logic of obtaining msi-ranges parameters
Date: Mon, 25 Aug 2025 14:55:03 +0800
Message-Id: <adb383f0f4a3cb588448a5a708fb7a907d5e9403.1756103516.git.unicorn_wang@outlook.com>
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

Get the arguments of msi-ranges by specifying nargs directly instead of
using nargs_prop. This only takes one step, unlike the previous two
steps to get the values of all the arguments.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 3b13dbbfdb51..5249afd93b4a 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -276,17 +276,9 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	data->doorbell_addr = res->start;
 
 	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
-						 "#interrupt-cells", 0, 0, &args);
+						 NULL, 3, 0, &args);
 	if (ret) {
-		dev_err(dev, "Unable to parse MSI vec base\n");
-		return ret;
-	}
-	fwnode_handle_put(args.fwnode);
-
-	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges", NULL,
-						 args.nargs + 1, 0, &args);
-	if (ret) {
-		dev_err(dev, "Unable to parse MSI vec number\n");
+		dev_err(dev, "Unable to parse MSI Ranges\n");
 		return ret;
 	}
 
@@ -298,7 +290,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	}
 
 	data->irq_first = (u32)args.args[0];
-	data->num_irqs = (u32)args.args[args.nargs - 1];
+	data->num_irqs = (u32)args.args[2];
 
 	mutex_init(&data->msi_map_lock);
 
-- 
2.34.1


