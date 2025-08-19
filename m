Return-Path: <linux-kernel+bounces-776060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84368B2C7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074C7B60E01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5427B32C;
	Tue, 19 Aug 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM46UYUv"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848820D51C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615781; cv=none; b=b2RZQ7Vf7qi48e5Ir1YH+n7+toj6nsDEG9mo31MTA81IJUHJHsiKVManVs9mOhvPvnxbQRQdbN7VR7AFQKRxgWovx6KXRbhoQN1xFmvZ4mL3nqIy8oQPJzquugEfGDF93zF8TAtKFMRGbRF6TAlt0OeC8EHpVQTHkTaEbXEb49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615781; c=relaxed/simple;
	bh=nDsBN31ZPTJxWv5+xI/XKIMoevKJa238JoEMH3TkX7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nePLFm5dGiG9ecg4pvK7o//1ukZZmcRfbxcxfSSIpRAaFnz0fS5CHh+lVqClOQX5YCVQDLsbIV1HsCz9StxlyzS3vWFuJfRQVFg2unyQqTDdxEVSqiI2oHejaBOddExp85X0o0K5XPyCs02iyCUXQmSNQDWZz/lDhMZsV9pHEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lM46UYUv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e414252dso2616741f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755615777; x=1756220577; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7444yQJ0rbL29maRl29fRLR2UuJK6Q0bhtUk89IdD0=;
        b=lM46UYUvzuwBGRf6sqgIXwzjuOMkbQsnmFtz2+R8hLhfxzivfroRVDUEcjweD5prk8
         bRg1SE5HuXpjI9KO2/heIhzQ0cFW4ERxBT+XWl5NnmvXQMf6mXfdQVDHh53JBAInmrsU
         l8+jGse2VJZgbvo3TKpl9Tm+VBwzDf/T6vZgFh8tp/J1nSwEsvU+BmESCJtvoObHa6Ne
         RLXel9FqWM4NdtD55ZPEzxNPnbzvuNZizhIV3oXGcKtrEpP/Twlas1K+63+HVF/4Gtpw
         hCq1nrkIso071vnzo6LU1BuVtwcBZpkUv7sFskQpq/HJeVTUETNYiqcsoxs9d29PVSyf
         9bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615777; x=1756220577;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7444yQJ0rbL29maRl29fRLR2UuJK6Q0bhtUk89IdD0=;
        b=dEB2ZYBJ+XSAsAchkj1hoX1Swvvm++7IG27bIemP1xkdO4jXBpA8pS/F2InUSNkset
         nwpnPK1MMzaqnAncWbYcGpbJqx1AKpEYMmzWTZcHWqX0S2ibj7GG6quB+hOukdqBXJeA
         KOpEZba4rMLMFQzxB4ixCbwCfWmIZ2R8VRNxMzo4e9AnTIPSTAQhkNJJPi4PJJnEPQx3
         sjxkjWHjMO0UekVQEZtDmKTaZKjN2vGWj/KRomTevyf/tyNXNs7US9A5ToRUNzqgmzFS
         Wk7lay5AjblfHiK5GFgSSQgNWxb7lCN1N3sWu0cONx28ioMqy6X2ckXPxm2k7WoGOjle
         MUUw==
X-Forwarded-Encrypted: i=1; AJvYcCWl+jSgqRtb3df+j4udPrp+H1O4rD6HwC0PtnzVpZAHcOVXLvZA8b4UGS2q/ALNJz962P8A2VLv9m0+TT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgz0vq4G3FN1kbuazCmiWbNP1D4z7AA8EO8K8VNzcqHGxKV0q8
	NPcW8HrHY7vZJSexnjKGhCy/zHdcNVpSv5yXwqnGzimXSW6UPnFVO8IqhW9O8Pe+8h8=
X-Gm-Gg: ASbGnctzuAx/WenaE/y6A5/tPurIuWFzvi/VVfLDzIdg206xa8TwuQd/eoB+CuQzIyE
	l/1tnvyiGhCaL1LL5hXcWc8NVn/Tm1hL4VsH8x6A1Gdgn0LCtBkccO7OgLTMcJbWle1f2Bld4S1
	2v3vQTJCqY1iULYb8/uOuEHxul7MYYnBlx+O0KykTGZYZSy/TYTepKfShodkbR3edK4mFGl5EXg
	FPcLxip3swE0Njbb68DLues0QwZUHL8XtR3UjbSmEOv09AhZLeBt2gaA/lLKa/iRp3mIBsGAunH
	bY08Tc9Pi9UNdMHgrSIhk4ric725A08/pLgKa+qjZcDnNzBifDPvbfjUFNjrAo8+7AR1VCWPB0q
	4o51YSgKqVNNYj/3aTxM6SwJIl0GgyQFdiQsANg==
X-Google-Smtp-Source: AGHT+IFWnJ6Oo82ofz39gNSEwN0Z3yDLui3rTcpuA0COSeut86mLsEFA0jwdaleJOlWjIR41+mglKw==
X-Received: by 2002:a05:6000:2404:b0:3b7:9d99:c0cc with SMTP id ffacd0b85a97d-3c0ed6c38ecmr2311284f8f.51.1755615776853;
        Tue, 19 Aug 2025 08:02:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074879864sm4134355f8f.13.2025.08.19.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:02:56 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:02:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] iio: proximity: vl53l0x-i2c: Fix error code in
 probe()
Message-ID: <aKSSHTdJf5QoYiRx@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 65e8202f0322 ("iio: Remove error prints for
devm_add_action_or_reset()") accidentally introduced a bug where we
returned "ret" but the error code was stored in "error" if
devm_add_action_or_reset() failed.  Using two variables to store error
codes is unnecessary and confusing.  Delete the "error" variable and use
"ret" everywhere instead.

Fixes: 65e8202f0322 ("iio: Remove error prints for devm_add_action_or_reset()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
v2: Fix typos.  Add Andy's r-b tag.

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


