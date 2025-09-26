Return-Path: <linux-kernel+bounces-833589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F5BA25BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515AE38581F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3513826FA5E;
	Fri, 26 Sep 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5LVsrD7"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11318DF8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859408; cv=none; b=XLFnZfk9ECL/zPnfiFh8b1CB6SnkJlbXB6QnOvx1YBejtDOx9MyT/lSgQHDgLdQ/Zya4DlIC4GdPF5SB4lJjLR7XVlNo0JL78surn347mnoaISfbzhGZX26N5pQXDJJ9XlqO6EeRkD5c31v6mv6nCoTpnRa1hI4qzDnP6boK6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859408; c=relaxed/simple;
	bh=CMUvU7Q/eBR+laEBfAb7ZGtG2rKSkDFVZ54Tf8pVcwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A39CCU3hhPRyHt6qNHWCvZl7M93SgOBrOhAkIElTHettG/wYohw3dWIr807H7uCGqZRHG8OrWDtcHfHfuDtGp1rGdX1kFtDN2xCsvadE57yFFFnfQaG0iYkxvrxkMBzLMdBjEeuzGxtBCyGYAjPaxXkyaCczVEnpk5eudacDS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C5LVsrD7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso1369286f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758859405; x=1759464205; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6T43NkvaDj01P2kx1drf+v8B79h0nA8PHSG7DCPm8Q=;
        b=C5LVsrD7/UCaewr6N0MlOvCA+xFcx0MbNr/0lR/82Q1SJ4hL3z3xYVxdVgDKRlmlU7
         V5oNniYYrv/Ar5i01vWX/2lTt8/fWEcCcngLuGuYklK35blRSUW9nfutCyJsPBYVkxtA
         CRbDRw90Z5J6NByc/CUB6w53ONR42xZnVfC6NeCia4bxszPRA+K/wdo2206rRXfqh//S
         370GJFljHk9oT6iiY0CuKrQDvSXU5sJM4yLGiyGftJGI7fqvVmFLzoPS/iIodMJzWYeY
         yF4d6fNa4XkpghA/bJzeOXofAISyeLqzIXKSuC4PiB5Y0ZMWURdKIn5JLAmw24ilsn7x
         WDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859405; x=1759464205;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6T43NkvaDj01P2kx1drf+v8B79h0nA8PHSG7DCPm8Q=;
        b=FJMfGcvPm1UmJalRmjDMDLIhIO+80kVy3TA7EU6hovuosx7OWeMwvbAPSUL79xY//e
         t9JzetS6fIvfLi+7nofI1DTNd6HwtBTbIDKv55dQBAZrzcll3asWLbjz0/qWMfAVViWE
         fJfOFRNCKsOQHOqQuFv9WBiI1JuhVG5EX5HHLGfxkqnt+MRYm8Kt9ANrVPFsVmGXTjPJ
         +6J2Zm4A3z/1bRPVkYqTR4dSsoeDw8Q7ZhLjdhgGRDf5CGXcnP6C40dcoQkbY/z+Y/bK
         UTw/BRUt4FYqkACbIa8vGcUIe/w6N16Yq378bp36bUO7hJeioBxeVPIuW56BnNRBm76T
         z8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvTvwyQH59fx991ilNiOHGaOKTwyO8INajvk2A6kfuLJa7NVN9TvAeN0ywqwEhJLV2/WRMveFBQcRC5f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlw68hYuEibzqCEpyBS5vLr6hlaooea8JpzgThxuUU7pIiHQm6
	a8WlxbcbyWd7ntTJw7Jscu1qPIc42bhFyjijc2VONypqwyNzA6VPZ/UeWPMKLxguzmo=
X-Gm-Gg: ASbGncsH7nsOC56pdvoqE3q7vlRED5rkD7k17IXWBxZpWiJNFR9Jrc3SsR+UQ40yIeQ
	ctnwMFNKnNIshUTkw40fJL6fWSdlJv8YugV6T+fSql4ayHrI71mK6bW4OVd/qfCX49U3T/q61au
	fpnGQ7gPEiF4h5tcmigfTqUaTyS39oQEWSYKyZgElY6EniKmSOEuqCLIICz9SvnJ7XVq5Qu7NH1
	qHX9Qx+Ubf10O2gZRDVyXZr0ri+T3uzfEqhjLnW4BpDs81MAU9q4T0L8PeDs007mq6/DKusCgVA
	sKg5xvZFDwGEJ2HmzJICILeDkoaljhm4Qc1IgCkBlfsd0a2j8Wdg3sioOQ+3L2b1IUkDimztDaj
	br4KsbHEhs83hU3jxDbsbxMe2muoe79fJZ9fioWw=
X-Google-Smtp-Source: AGHT+IH8jSZ9cVpDSOMeLWUT/1JDNyhLeRJ9I2gTVKvtZXYra39O++P7RTag+3K6FCsm4O/uhokkGg==
X-Received: by 2002:a05:6000:1a8c:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-40e4ce4baf5mr4739778f8f.47.1758859404873;
        Thu, 25 Sep 2025 21:03:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fe4237f32sm5197655f8f.63.2025.09.25.21.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 21:03:24 -0700 (PDT)
Date: Fri, 26 Sep 2025 07:03:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] clk: mmp: pxa1908: Fix IS_ERR() vs NULL check in probe()
Message-ID: <aNYQiRJDmOO0mEWs@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_auxiliary_device_create() function returns NULL on error, it
never returns error pointers.  Change the IS_ERR() check to a NULL check.

Fixes: a787ab591c38 ("clk: mmp: pxa1908: Instantiate power driver through auxiliary bus")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/clk/mmp/clk-pxa1908-apmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-pxa1908-apmu.c b/drivers/clk/mmp/clk-pxa1908-apmu.c
index 7594a495a009..e374d7733f56 100644
--- a/drivers/clk/mmp/clk-pxa1908-apmu.c
+++ b/drivers/clk/mmp/clk-pxa1908-apmu.c
@@ -97,8 +97,8 @@ static int pxa1908_apmu_probe(struct platform_device *pdev)
 		return PTR_ERR(pxa_unit->base);
 
 	adev = devm_auxiliary_device_create(&pdev->dev, "power", NULL);
-	if (IS_ERR(adev))
-		return dev_err_probe(&pdev->dev, PTR_ERR(adev),
+	if (!adev)
+		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "Failed to register power controller\n");
 
 	mmp_clk_init(pdev->dev.of_node, &pxa_unit->unit, APMU_NR_CLKS);
-- 
2.51.0


