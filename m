Return-Path: <linux-kernel+bounces-868149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4EAC047AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC83B9578
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46C26ED59;
	Fri, 24 Oct 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atL7cSc5"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059E2580F0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286769; cv=none; b=LPzNRYt/yDY1IMPHriD0jDFoGBZcRdst+9tXZrHBfR3+xmABHXgZXf8yPlZEYx1XmzJeBjxnM5dycTrz4KlZQqoIdTbyoYwSNdsfVwKqlpEhyy2f1YTawrSwZKnQ4C0aCyHIyHjKgpi8uZ5EjbhSnwuU6vSG48PMcxsque+wDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286769; c=relaxed/simple;
	bh=MjiIMaVHnxv85Sm0BB/UlJ62CEBZJOgW3U0C8rO6buI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bU7rOELgrJJBH/kLaCywKBhOzTslkFMD0J9W5nndZyAZjai+xWJ9vnY/pCeyqepCO9T+ZIT50xXg4J39eW5cpg9UZwvDQb32+vWWbSAAyZ78i9M7YzgkR63OmUifP54nk3QRT7LuxwvmxzCeseL9xngH99gpxLJSJPfi56i6wSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=atL7cSc5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1138352f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761286766; x=1761891566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuW7JMitWdY//EYRZ6hUg7/sC/5FBOcO0+pu8iYSN+U=;
        b=atL7cSc5/Ej7zPQ7n2QKen4qg1yhVqDWtKpvlEK43J03d791ymvxss64cDsU2+C9+P
         FklFpCf/E0YNZmocWnGM/vjbp/eoyp4LwMvnvGiRW9751fI9HMh/GVxTuC+P+sD7dNrZ
         Xi6nD/kMIS+tK5VbrCrfoupVlqwHVZNTzk2baUBQNGBmOpr3gcUCUFQOXFday8GDNTpU
         hmvgTkqhcokaic4v2eoUh1AqfzUGUZT5iQVqkfB58EpgMYB6L2H900gf5GyfVcCeC4ne
         0fe4tuRtrkndVfYQhpMjvgVLCjtfofyEXVaTU2OmCL0UXX+2BL3olqZbtZ5CvIBThutg
         8UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761286766; x=1761891566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuW7JMitWdY//EYRZ6hUg7/sC/5FBOcO0+pu8iYSN+U=;
        b=oijnb4jxuJ83RpnYdW+XnAUkJ4XvyeC8BuhCLPTiveJtNURAIuvdIXkLtnXHsgwh3R
         D61wjBtpHY6PBnd8s00IZfW9xYmQ0YR3zsKfJKpzHgEsZp/nfgv+S7v9uq3VP8xEjINB
         ayGtpZgilniNqQ6Gvei1ITT7R+t5ee2EpSPy9ewI9YvN2EpX7VLF5Ye4gb/8sW5SCjoW
         sePzf/mmSppyrbpTsQutRVCqxUbjqvIEF3TXqPlUFg8Ya4Xkccrp3xsZf53Ozbr/6+60
         Qc98xa+IrsQvtaJCYzmGlk1uczher6tZrYlO4nx/t6l7P64fZc9a5cqIBvQPY5/WMlKQ
         +4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9cJqZz+fjXSnzOy+YQmaPvCG1C2Mc9MAFCNfqAsaWQUBtCh8IyYkrWbCXvb2lM1Q7DjcngEkC5zAaguE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpV0S4LpUltHG4HHd4vj+oMTRez6qpLrGCfVMfqFwpiaH1icQd
	wGbwYWY5iv+Zk4O+PnSDOgbuAiskJPO+/I58jCNJrKF0KwfbA9w73xsk7yZ0lV2nrKI=
X-Gm-Gg: ASbGncvGIpkTKz6ipV7GqMKA5IYV5c65zLfUs5cCiwHvoHQ6VCnhGnJFrtsUmMkkL7e
	3gVcPDJvVPXZ52fyonVDjdUz1eiD1lpzCZBk9QpGZ/QZe7vC+WlmtvnpwADVIkqjEAhYwqSBBiM
	8D9I8la3aj97zTmNaZk9kfygTd5T2yjQ9YrB7ngrYxNhj5FVvglVbPH8+7/paQGtDze2MgTJYI0
	yxy+HCy9lkPCtJVydckpvm4qshS4aXJHpekdqp1Bem2lC5+nxkXHjo41piT5u0iGm3dB/R4zloq
	hEjZvGM/Qqmy9HJtSbT0YxRKJYy6uD7vT0QTISg14eNjTUsQ6Aq3gUnDUGoYWFPn5nVxHLJsf0m
	xuc025NeG7GbfBIjpBuTK0V/VBVcqam1aogM6Pf4zlJyCW37GM5yEwNDRtAR3gcB+KT+EUDomRk
	7zJdbq5AqDJ4BKHDD0
X-Google-Smtp-Source: AGHT+IGuaT91f6JlqW4V0ICbs5URxpfktlg0GOQ7b4e28m0jHXiomSrIXCP/t5AqtpgGIxAmYlkf2Q==
X-Received: by 2002:a05:6000:200c:b0:428:3ef4:9a10 with SMTP id ffacd0b85a97d-4283ef49ddamr15607904f8f.54.1761286766184;
        Thu, 23 Oct 2025 23:19:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898adf78sm8054566f8f.32.2025.10.23.23.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:19:25 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:19:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] gpio: qixis-fpga: Fix a NULL vs IS_ERR() bug in probe()
Message-ID: <aPsaaf0h343Ba7c1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_platform_ioremap_resource() function doesn't return NULL, it
returns error pointers.  Fix the checking to match.

Fixes: e88500247dc3 ("gpio: add QIXIS FPGA GPIO controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpio/gpio-qixis-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-qixis-fpga.c b/drivers/gpio/gpio-qixis-fpga.c
index 54c2c76822d5..6e67f43ac0bd 100644
--- a/drivers/gpio/gpio-qixis-fpga.c
+++ b/drivers/gpio/gpio-qixis-fpga.c
@@ -56,8 +56,8 @@ static int qixis_cpld_gpio_probe(struct platform_device *pdev)
 		 * create our own from the MMIO space.
 		 */
 		reg = devm_platform_ioremap_resource(pdev, 0);
-		if (!reg)
-			return -ENODEV;
+		if (IS_ERR(reg))
+			return PTR_ERR(reg);
 
 		regmap = devm_regmap_init_mmio(&pdev->dev, reg, &regmap_config_8r_8v);
 		if (!regmap)
-- 
2.51.0


