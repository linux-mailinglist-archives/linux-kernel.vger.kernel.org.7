Return-Path: <linux-kernel+bounces-881306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9962C27F5E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED97A4EE82F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859972F656D;
	Sat,  1 Nov 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHWd44YO"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF72C0307
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003661; cv=none; b=oa/+Bn/7M8lBYl8/uNGkOMNLiboBmlY88grMUnt6mTuOyXwIoF6QRbQtwKVN7lichOl7Pevnvvlt0Ju8nL+MbD2CbA6H1KuaZx3ws+pKpPZWgMsx5In4oukoTa+HI13ZEqOMTb7LbTeQUsOwLh9KZQ7K7f1OJm5YnW1YsGsArHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003661; c=relaxed/simple;
	bh=O7ACs0ldqUJpLVDp+21SQI0MSqblXSVfkxhdkXYAbio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lmr539MhtIRe/wmHvy0eBa2D4H8pz+/FSzJgvnhSfI28LBcWQqNQojBqGPwJl3m/nWimGATME78fM5+xHcetfwnG+ZKkJCmlsXhql5EHXeDF4rYgQ7ym1zssF1XUROV5dx/UNZmjPmE1pCj40bBqbBdAMkvXZOz005fUEF1uCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHWd44YO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477365fbdf9so6900305e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003659; x=1762608459; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXhWn6yI771aYOLRcSIj3itITp8Yx3KJMWGw7nupRLE=;
        b=LHWd44YOQBGe+Aj0B9QLiXQI+7ubRnClAS2uvvUlbWOw3moe98NjJbjbA+4sbVMAO0
         wjJSQLhtt7ScrWdC7UqyPWEd7vNzUe83ifjbTdZ6cAAh4XhbuCL7pl8wyJNgVaNSCX9A
         WhZkZr9Z4pkDvzm2PpfkZWoq+auHCE9f9hJ0FSGsxHwcMSoI0XMp2w7PwD4jgRdhxuXv
         EMmvf8vC/vZa0kWk9reFIU9sk4YDOFPz8E3ZxuD5I/cZCwDAvQaMZzZaOA8BLa34ZiTK
         spgFB7k1J59jI7J+zkPP/+x9ErHPm2cn1NqDd0rYZEfncjQvbWH7JhNvLDy1n1i3tFkc
         e9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003659; x=1762608459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXhWn6yI771aYOLRcSIj3itITp8Yx3KJMWGw7nupRLE=;
        b=UbYs7cd6br1gMGUbdtPIzsMCIkYEOMakKCOMugDoTDUKQgxYVsNB3S4XadPw02OmtP
         JBWoAJLLnK1t22K3X5KFB+X7MW6tV3vNGG9QoY4a8/FDDE3DvcG4vb90b8huRqc2K+Pl
         TBjHRMVGhNsu6x3vtQmVgv7ij+LXjwmRfd4DKf5ZlTnNvMUlpZI3h9wp4Ip2DMDUTItl
         cshOr9MJhNss+crSByZJgCsGNh+T1/c88BcD4HQQfXT7z4GG1mjoawJaqDy8Zxd2+m6D
         i7Qx4mxHYHGj8pNA5haW9d95KKQEsC+m0Fi25iON0xd475KNwyTmTuv1dAOxjPOMfy+P
         RMBw==
X-Forwarded-Encrypted: i=1; AJvYcCX2+GbMAE4KVrSVJhErVsS3Vz5J97tiX0ybQaEku/sWeuoQsRsYbDQnrduMIG65txyBpTwq+SJ7fafLNQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrI6aaCrNMnS3ChQSVzoShZvMxZ1Im1UFBswGPhXd6eaf69S/Q
	/UtOyVEITxH1HTYLxHce4mZixIIZLKcyUQsTYX1/fiVsZc6c1qaerG4Cu04QoqLj968=
X-Gm-Gg: ASbGncsmYrQf86ZJIcg3XrReCDK7EJA4IkL1OzuoLDHwelsX/Gh2NJ58nBeXaMPcUv+
	MSFUESPPWFgbJhUN4wyYe4lsTw+1uTJEr1MT9soHUu9Osee2WMEJ/FLMW0W8CD3MOjXntdZ28Pq
	hXsf80iJjYimPTGxWL8SI6560wZ9RDw6EgA7gtq/O6tcGS1FMCxmHRLh9DV+Ph/DsrTaAhICLak
	7dKGiR2WWmKHrVSZV8xOWXgZkaKr1F9sBGJZQ0bT+c95Sv6h3yrVxeYPP4njoKcqR47HLvwrZQR
	3tA9b2RW0At0ZAmMgGFQQ/5Oz3+VnxM3yVkHb2qJYV+MnvVSzS+U2b2ppZgrMimyzUXzANz0qJp
	iuKGKOtpZjkcAdAY7QV57KThh3nDnWvvTr35UI4KZy+iD9seGHvcs1DKlNqpm1wssSJt4ctSmu3
	yP+nvnXw==
X-Google-Smtp-Source: AGHT+IHqXes4RC0d/pZNok2qTFXjlWakyDJ5XbPAbjHTCzlugL+3ND+rGETKmKuLd5fEQQ0F3CoHKA==
X-Received: by 2002:a05:600c:4e56:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-477302d3677mr58158665e9.0.1762003658683;
        Sat, 01 Nov 2025 06:27:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c53ec2csm48606565e9.11.2025.11.01.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:27:38 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:27:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: codecs: aw88261: pass pointer directly instead of
 passing the address
Message-ID: <aQYKxl2f-zGVdYFC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

It's a little bit cleaner to just pass "aw88261" instead of the address
of it "&aw88261".

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/aw88261.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 43556f66549e..8600b21ea618 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -1184,7 +1184,7 @@ static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
 	aw_dev->channel = channel_value;
 }
 
-static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct regmap *regmap)
+static int aw88261_init(struct aw88261 *aw88261, struct i2c_client *i2c, struct regmap *regmap)
 {
 	struct aw_device *aw_dev;
 	unsigned int chip_id;
@@ -1207,7 +1207,7 @@ static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct
 	if (!aw_dev)
 		return -ENOMEM;
 
-	(*aw88261)->aw_pa = aw_dev;
+	aw88261->aw_pa = aw_dev;
 	aw_dev->i2c = i2c;
 	aw_dev->regmap = regmap;
 	aw_dev->dev = &i2c->dev;
@@ -1221,7 +1221,7 @@ static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct
 	aw_dev->fade_step = AW88261_VOLUME_STEP_DB;
 	aw_dev->volume_desc.ctl_volume = AW88261_VOL_DEFAULT_VALUE;
 	aw_dev->volume_desc.mute_volume = AW88261_MUTE_VOL;
-	aw88261_parse_channel_dt(*aw88261);
+	aw88261_parse_channel_dt(aw88261);
 
 	return ret;
 }
@@ -1250,7 +1250,7 @@ static int aw88261_i2c_probe(struct i2c_client *i2c)
 	}
 
 	/* aw pa init */
-	ret = aw88261_init(&aw88261, i2c, aw88261->regmap);
+	ret = aw88261_init(aw88261, i2c, aw88261->regmap);
 	if (ret)
 		return ret;
 
-- 
2.51.0


