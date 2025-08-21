Return-Path: <linux-kernel+bounces-779743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A722B2F810
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7141CC36F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F719E97B;
	Thu, 21 Aug 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSFNqRVz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280431388
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779553; cv=none; b=LrVNY1JABqLe5huWvmYlvGP+7NjLeDiAWYVjMg4qLxA4/0vNAr7EbveVme1kQxvF1ihiCF9LJP62DnRNTlFTtc7HvIWvD/o3UAYB7LWYkwLOaTLnx5UR3gohtxG1cXMIRQtLnR6PLW4Txb9p9tlj4gBox5MvTDu2RtCSV80Vg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779553; c=relaxed/simple;
	bh=i4ivNoJA/XYa4j8URBoVuQOwoj5jbAtHTh2CVRUNL98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S4q0g8+TTvhQOU4kC1oyRhtzESRq9kTsk4YYXKnhR8brC+ujBiXT2iZ2LnoBytjuXD25KKqLb4JeOqRmsKN68yURI+pXQDtW4zhAffj4lX6uc6BdJNJkj1+3Dq1+CdqblTlgWMqaYL3aCzj2LkP4eYl1QbInXhETAY5gwYnU4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSFNqRVz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so7747685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779550; x=1756384350; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YxbukuAzSacGXrM6lqlSlHSwuWfZD3gHN6r3X8UJRE=;
        b=qSFNqRVzxpYKMyE1QC6KxqSoQWvVw0pW04O36qfvu+Fv9AMM6y2I7o+EtEeroIKx5f
         xn06yIk8ngZsSvaBbsEOFW4Ni4gVFrB7W0ev7J9CMdVKuWhNM1idSkFw2Ulpqjlyvvg6
         lh9pAYC/CrukmwOamp4fbJUfPILgHsXPK9xYuVaQtXlN+09nzZcazkaPdt0e63RxHNiv
         n3XmaGswzWoV/Dzp5zLdrjFmOmHvZVRKQdI1wC/RUL2LGpPHNTAb+gYDl8vGBeEFend3
         lDu0UIiWhVOvURAxEtwdN/QgO2UOP7uuW0Ddz0M3kzHuYoFvjNfLn8KPb9+qpLk5lR2p
         jmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779550; x=1756384350;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YxbukuAzSacGXrM6lqlSlHSwuWfZD3gHN6r3X8UJRE=;
        b=VNovAihIcq5PcSUsNs40utQ4fUeT7MhMdfRfYwVAxcc4T5RqpnKa3t0XmJo9/4aZfA
         hQQ68JqPT/+qjQfLDQ2E/szunrNr2PkOZXsq7/mX1LdDg//KAmavLrTmTYUclLf4A05i
         EaH+AFqbcbvUAOhoW9WEIpu45wetTMWLpUzwS+2QXk2Cm2wS0lLpxh1ab1XR0jq+P6LF
         Fnp3QmpnLAOCcxy+DEWo+JtxYp70WTNC72v3jiH/fruCxryv91Qr2XycQ7mcyDNtzvBM
         MnmgY8kdlYLI5wwtWoeXKV3hxlPRxzxNaMNrFZ1fnOD8101g3v1Mbgi6GIJ0PGqnp5xh
         DQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWSjzDZcrQ4Zma0UyTaPLXYbAyznw8aIPWZ1HLG3SaACxqdXPG+0Jd5Hp1k8etp0QMj1BcS5EagNH0olOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4/Y/CNXZoWpZC7YWJ3vAZH0tcvy1L5vWZuwSDfEkkpya0KwV
	t1r8eO0q1SOObhb/SgzVoo09AC5xafPY48sPJER0JZcwUoEYb4tKNHQbn7Nd4rklJR4=
X-Gm-Gg: ASbGncsjsnzvBkA9OefS4mJoCzpGWqHmN6oeApZg+DjKdnjoC3zj7edgNGT6+eENs/l
	FSn6Fm3shfwotmYlwOeLwIW7ZHgm/ugh4rXEugTVC5iwuvJ2/LFrND4NXMLUtA0h1nanmWDDqwg
	1ECI/RXgH9o717WL6gYI91Yn+i4T5voo3cprWIk2G8WM0ppUxEbsW/gXt0iwICRVBJzNEuAIby9
	O9IhssgZGUL3dmVWbvTJxkqozPIkArORvnAj5Hu6dmTMp9CwD8tzeXl7XcWZjBTZrTDvJwEYKIC
	/PYv52pI1aArPJwMh1y4fE/0Xaa6gGa2FzTaA376MVQcKFRTNu3QwG9g+jv8qrNcCCMGumVnvKf
	YJzlGQyl+dg7AsQK9tx5g6cCfEVWJGmKm5wKQXA==
X-Google-Smtp-Source: AGHT+IF4re4JMKqmwW7eC8Vyez+RBY3Ot24DyU7VwP7W6aNkCpKu4qpBngC8551+g/vQCfP2k/8E9w==
X-Received: by 2002:a05:600c:458d:b0:459:e200:67e0 with SMTP id 5b1f17b1804b1-45b4d7dcc58mr19978705e9.10.1755779549700;
        Thu, 21 Aug 2025 05:32:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4dc255f9sm29273285e9.21.2025.08.21.05.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:32:29 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:32:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Rex Chen <rex.chen_1@nxp.com>, Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: mmc_spi: remove unnecessary check in
 mmc_spi_setup_data_message()
Message-ID: <aKcR2ea747xkw_it@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

An earlier commit changed the outer if statement from
"if (multiple || write) {" to "if (write) {" so now we know that "write"
is true and no longer need to check.  Delete the unnecessary check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 95a32ff29ee1..42936e248c55 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -566,7 +566,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
 	if (write) {
 		t = &host->early_status;
 		memset(t, 0, sizeof(*t));
-		t->len = write ? sizeof(scratch->status) : 1;
+		t->len = sizeof(scratch->status);
 		t->tx_buf = host->ones;
 		t->rx_buf = scratch->status;
 		t->cs_change = 1;
-- 
2.47.2


