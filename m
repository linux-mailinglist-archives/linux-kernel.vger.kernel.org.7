Return-Path: <linux-kernel+bounces-834972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F4BA5F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6134A07BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675542E091C;
	Sat, 27 Sep 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpF9n3jR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8B2D73AD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975972; cv=none; b=b2xeTILWTH4LvPMrk3hW8C6qAyNQHBYbXHTlvNOHlvOY2OLEgskWKpcTdne5SR/lPF09Ub8KyOmjTSrj0p/lQytxBO6muB5yKFiNPqWuqtIsote9qC/gOmb/F3FHYYDhvL5BP1qH4YPcBtQif7bOu77PGJr5KOSvHX+f/4K8dVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975972; c=relaxed/simple;
	bh=66qh/i0NMKkwcPgrGlTEbt+Awt4CEgq/WMEYPhmYS8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCVI5WLGQ0DuVDOiOqHyxXtM7SarGhKbH4zpkVk9KeDajVOqZGMIePZQwCWgspaU8QnMqwHNn1GrW1F+FfGxkeJbpILXXORcxmS4CK5HvSC4siZK0GiOhqpMbhFmeJo09iKp3sHvwHi5ZHhFTIsMzmgR3KQVp/R1SesyXuHSCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpF9n3jR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso16224435e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758975969; x=1759580769; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1CQFEKaI/Sy/SZOKDp8joIn6sS6FqYKFWGC9eEth2o=;
        b=TpF9n3jRkox/8EYXjLy5DiJfrTfKN63C5ibO52SuxO/6yNCXiA8ZByLfHRAG4wvXlx
         goLZZ0VjBkeLFpQUps+1l3n/U1xNUE7dU6vL2pczGC2KV2lL733uaah/yiqW2Kh8HIIU
         W4cP8ix4SsVrdLaKLroxiEj7AQquLn5VlFrpF4MDYMjfEPnr+UcPrBC/nNGc4M9EG7bH
         /UcVZjSlSJbU9w9vwI6hgg0/wCJd0x2zgxiTm3T7EGtXg4EBH9XDuiEsJ+2mmEkAYHVt
         jgZzt14KzHpXj0gpcfVj2Dx0o8MvcGVkMuIBKTsYQ+XizhAQ6J0Gs/qKVpuF1LSYrH8z
         5f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975969; x=1759580769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1CQFEKaI/Sy/SZOKDp8joIn6sS6FqYKFWGC9eEth2o=;
        b=tuivYq1V5BW0QVtJW9KdTOBm7pPRv3JeYcnWEk99n6CFl9Aca3Ffm6ahMcW8VyVNqI
         Mu8nGBAugkM6laoRWVMjrF+4Tf+FnYL8cT6JzjpVnhnMr4NxNAKd0KK85LdNmhhMcmAq
         Q3RAuSFsYYvTJ33Cr2+20JG+s9EDjSBkWRSrWWVXKwImdfq0gp8haJ91aHn8INgFpIB6
         odyETiW7WPx0Q8Ibd6d3uwwvuk2Bzl66JGKEzCLm0o74rLOhVoNLi2adykh53qVl0kAG
         tsP8Kf/yHpItSmJIOQpSRwUGkSsoO8QzCQ43On6UVL2raPzd3NO+y++kJ3W73haQs/sd
         Uk/g==
X-Forwarded-Encrypted: i=1; AJvYcCUOFx+cDATjZnlNcusGyLfdlN6Hq+Z14W0qaHv465ojTGnq02jAAltsMhCqafBf1PuJd8933quyuScml48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDntLC6TYSrvMJflj7evBO3+I5wEhyMMyp0zyASLMVwijnO8x7
	BNOcjzguJHbe0DNuwsLMwtz6TVI5cw2lbRlF62PVKPaMlBTw57mxkvxM25VTQ0Mpd18=
X-Gm-Gg: ASbGncs7KUm00RYDVf/rO4yAEGjKVtBs88jvJX8WaJ/+NOa4s2J8d9wlW8Fq2H93b1R
	Iw5oUzbpmXQ8uHVVsRWc62gK5t8t9dD21H7GuAVwTy6GyV3hkUlshF8/p2nQhDi0fpjjpjCxX07
	LHvKVadpIUjVKTelY84dZg2LmrqJIXjOHOPtW4chyU8bb9rQO9cPWWJ2SU/9NnzKaeQaK4F3su4
	my2JN6it2MtVyGXNkRYd6InqAT+evuizpe+pGuixGUePe6BMisevvqBi8dp+CSfleajkSKPi/O1
	TG/zJPuBF+Ht9DQS5Q7xMbcZ/R6wAv6qRHboXeUMIbtnq5aHRPYpQfQZxxDFZD8mcMicBKrgpd9
	UZhVEsRby2szIYBQpUTrG3xPDdURIdxcR1IiU/EJ1ych6DioFEg==
X-Google-Smtp-Source: AGHT+IHsxb/x4MSuZGgdkKW/ZTkoD1gTaQGZDhqAYNlhS+sWUJEsl7l8ii9uzN93TtclonUe8lxATA==
X-Received: by 2002:a5d:5885:0:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-40e49e728c9mr9989172f8f.60.1758975969377;
        Sat, 27 Sep 2025 05:26:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a996bf1sm154772885e9.1.2025.09.27.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:26:08 -0700 (PDT)
Date: Sat, 27 Sep 2025 15:26:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] irqchip/aspeed-scu-ic: Fix an IS_ERR() vs NULL check
Message-ID: <aNfX3RiyIfr3A0ZG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The of_iomap() function doesn't return error pointers, it returns NULL.
Fix the error checking to check for NULL pointers.

Fixes: 86cd4301c285 ("irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 5584e0f82cce..bee59c8c4c93 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -215,8 +215,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	int irq, rc = 0;
 
 	scu_ic->base = of_iomap(node, 0);
-	if (IS_ERR(scu_ic->base)) {
-		rc = PTR_ERR(scu_ic->base);
+	if (!scu_ic->base) {
+		rc = -ENOMEM;
 		goto err;
 	}
 
-- 
2.51.0


