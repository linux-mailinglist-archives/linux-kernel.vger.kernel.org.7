Return-Path: <linux-kernel+bounces-775301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF30B2BDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D081884724
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CE319869;
	Tue, 19 Aug 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIoMt6qf"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C18304BC6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596387; cv=none; b=r/QnKwAYkQUnmxYZwdTy7LX+pwnYZVviUzR83jLqXsKKwu4QpwLLLD0QnHCVyBPxeXpKTydriqEHlI2Q6Oz7PKb3QrUb7ftnQ4iGGYWPfNT7xqHE9DwP9hbCFd7rlL6E4ez/0qHx//o2yn3wegthmNBT+P8yxo7W/VIQqc38j60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596387; c=relaxed/simple;
	bh=CfV42cEPw8lWB0t0dITt7ACs1R/IcMKpBkeea2hlqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O7FWrTL6HgG9sX5atj0GFgdLPXJ53I/6p1gBiMUVL2k6ScQDlu3Rswq5O9dmNiVYCjI+YNKrKmUInT3jciJaVKeVqj8etfXPBjscMFlNWkkALqDhRvd7yEYiF2KOmLe2skz3ga9JTK+L23bmRNQmXYRehZxA859MgPl8qYu2LHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIoMt6qf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so25779725e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596384; x=1756201184; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ybn3YmMAxEA0Eee9hCzXqIV+SQtPmXHBsQojxOHa/s=;
        b=bIoMt6qfJ2e6rnhvsGoCBzmHxajT9W/3pCdj3TwYmSKgMIkgWxtJB69lwWODrk++/e
         uSVLBHt+UHTJOACI9pxlLTkGv/WSJVgS5Tn+AFFwAhYiBN3G8M96KUI94dysOowyFkSq
         H0GAoAsNIpXJvyyO3zYdQFiP8z5th2X5zHx4Cno3iJvASMoJaLQrd0h4azA4kQnqNZuj
         /eQzrk/1/zsb3YjkN+XkFblnRrlIr3CV0p8qeYaR6VS9+/mygj2Lk9vbMBo/afSFhy2c
         KCgqqsLZkQKrINfwB3kWt3UYvMLNmgQm7TDUdBvjOVjJM3lRNweH0OaXqDlAetLl2U2e
         QTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596384; x=1756201184;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ybn3YmMAxEA0Eee9hCzXqIV+SQtPmXHBsQojxOHa/s=;
        b=p4urZohu8c0QMHFpXIG3/Ni/rAIZXsl6b7C5gJpFmaQSwfe0htCXd4kIuchiDyDbfH
         MzdEyS6tX9csrGGe2OnPCrjImskxjJgHbuAp5DFhcLV6q57jbyHZM/dsAGmbOpRHaiOh
         b4RCN2ULikkp5j0F5W2myC7Xty2SD3kill6CKVqLboFYWsmKJWex09bN3JWJ+ISYvAAF
         +Pn89P9tdVvLDKZjQ0hRZPSO6t4m0mTUbhVzxOkqD/5BJFaXSKdXFp9XOd22zLCfBRI6
         alCHwpGvBlmEwtGz4EFTUQCOZn9MhFfJYPF3fSoW3Sk3SjQsuxZwFN/IU79ia5G2ehOt
         Zplg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsosaWhdJ3UlfPnxPi5HUt6HDMSB17TO2QC0u3eHIzZfdPhXilEuaVDBsJb1yANcpGn/EitFtlZnqrSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkY+Mm1+72+T+k5LuYjpjmLk/DPgj/vc6dcvJ5oXtJRJwatuX
	hl+1MaxXc807OFpljCmg6Vc1wuktqxvYe1AOLSY76TZHek2N+968TAtewHRDs0dnCEw=
X-Gm-Gg: ASbGnctsJ4fPxviZDDWnOIJ06gDjE5AP67gnLI0KdYS26dbuVa9zA81shyI5ZZG/bgy
	9A84wDFfQ7yFYUJQ4HVLyYnZi6EH+5vsV5vbOOhMc/GPYHPhFByT5qjtijI40gbHJByE+Bx5o7u
	lbJEtzE3oNrV+ioPumB6Y3jSYSel3Jt7lm5wyREUvm7pWuVzJwhVK3XL/zAOA+yrjzXmTGee4/+
	8T/tOjt+wOQ1GwVA6B7sApCuIatVRZ5sU7UYJo35/hyu+ND/Qd+aq1xGKTnoHR/FROlWIxl7COr
	cx1wYBSdhaEDX3GgK9w9ZHgi77P/t8Picsl6VhPrrp4Zh+8wrVNV5KkpXu8U0S1vZjTA/ryXwMA
	cJgnyYAq4Uxzeg36q4nJv6deZbO1hZ72vPpPgsHr9c5g=
X-Google-Smtp-Source: AGHT+IEaFIhVwX9haJqJj9y8XmIJjJBEgfC6H62/4M1ejGfKBt/x5SRVvWKacOOoQ6lNE8CMUtGT0A==
X-Received: by 2002:a05:600c:4fc7:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45b43dc5099mr19675405e9.10.1755596383877;
        Tue, 19 Aug 2025 02:39:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c773e57sm218767735e9.23.2025.08.19.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:39:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:39:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] io: proximity: vl53l0x-i2c: Fix error code in probe()
Message-ID: <aKRGXFJxf2bdQE-Q@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Commit 65e8202f0322 ("iio: Remove error prints for
devm_add_action_or_reset()") accidentally introduce a bug where we
returned "ret" but the error code was stored in "error" if
devm_add_action_or_reset() failed.  Using two variables to store error
codes is unnecessary and confusing.  Delete the "error" variable and use
"ret" everywhere instead.

Fixes: 65e8202f0322 ("iio: Remove error prints for devm_add_action_or_reset()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 696340ec027a..ad3e46d47fa8 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -311,7 +311,6 @@ static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
-	int error;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -344,13 +343,13 @@ static int vl53l0x_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
 				     "Cannot get reset GPIO\n");
 
-	error = vl53l0x_power_on(data);
-	if (error)
-		return dev_err_probe(&client->dev, error,
+	ret = vl53l0x_power_on(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
 				     "Failed to power on the chip\n");
 
-	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
-	if (error)
+	ret = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
+	if (ret)
 		return ret;
 
 	indio_dev->name = "vl53l0x";
-- 
2.47.2


