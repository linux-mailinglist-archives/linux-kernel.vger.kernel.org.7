Return-Path: <linux-kernel+bounces-881305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41187C27F43
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E12E1897B70
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30082F60C1;
	Sat,  1 Nov 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COgWpTbr"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80D2DE1F0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003648; cv=none; b=J1XTcAbqOyPy4mLmOu8x0GokZa++A/flCE6dgp6Ql+V7RvTWuJ+qqQk03JQfMi1wgCdYhbXVe7uydyBYibkTaK0PNM38WRT7s8JCwG6u9GMkklzUyHiCHNZGtn8Xidcr5TzrwoiY/K4ayU8+yQNsYpImeKmb4S/lgstD+zpSTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003648; c=relaxed/simple;
	bh=2PAOIcseLes8QDrU/0O6eI7V5prSun82KB4s861oRuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AMNX3l1NjoVnfQYCxCZIv0WoL7/+waHs0aK7QLhLx6WByex7l4itlfEIOxNTnxxP5Qc2TIOQrtqkSlfy3GRphjE7IdAapQdvJ5o+YeIZHgMSCFyQgfQa1FP7Ybexj/uzDa8VHG9Ym0IdI3vMQYk2qnBa3eygxLGXAnxqaghJtgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COgWpTbr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so186462f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003645; x=1762608445; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyMxV1dKZKD1oc5wPyS8VTSoTsg2uKzYIVyhunCik3c=;
        b=COgWpTbrcqgzwX2Q+EcM6HVZGj/VVCGfWNXebemnOn93dWbftxvne3uRNQ/BwOHHoJ
         f3pn1eul9/bTok3ptHlFHEWQuQQApYj07pUIFzPCIkyeEYEK//mymz6kDDPcsVllJ8at
         76uhYeUZFQ18JT05jkE/Nt8/UyK8I2+wsQOq3jnRPOf3t7pAb2hGhBWrxtY8/XdNhkVO
         kGj/QJcTweZCsRbgdjOI8A1baBc3hEn0yMzj0x+vi0CuacFUDBkLWQKGPdWE3zAGE4zJ
         dVl28KvrX8g68mCs45AZy5r/tFCrPUcCyvt5HVjOdImVdrZg+o0imLcNzHxHPSphtIny
         EU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003645; x=1762608445;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyMxV1dKZKD1oc5wPyS8VTSoTsg2uKzYIVyhunCik3c=;
        b=VDyFgFBV9VAdHuOEzi3cJlR+ScUKEmbHW5ezDpgs4yWum6IlJ/bt110fr2CiRBAZ7Y
         6AqSlcHLgOLOPxGkoyDDNWxS3mBpmyoRRxNIEU/+BqIZnrr2FaqmQU5NLjHp7SvYZ8rz
         Q9xHVhh1Mr1Vjmv9VXLXscgv3C2PhEKrDtFHfhZl4nfMkBDcboNlN2u0J9GrCEph9LVA
         uocSACq9dW8J4sRVNYrq/MujWSY0J8rnkGIGDYdr3OWLSQNzY2JlwlyMZUypmsy9uAOQ
         uXhleY8skk+9nR9x1QVTIO9ujfYKCMFclw6byQ2BcnK8afv+k9F/zqUdR9y63WZyckXa
         AM2w==
X-Forwarded-Encrypted: i=1; AJvYcCXkeC+dDrX0dtGjZHOcvDGqDk3Bd6E5vTkggqz2NC0/1b0EnnDB+KHtUrp1n86qn5kTMWttzyfTeogEr6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRyZoO6wHHx2BhWRfiNiPeO67mSxZUjlalBcB156lR3qXX3HY
	+XjSEuPywEV9QjKWeKc5rtD6Fo545iDyAUAS0zsNM1xXJG8oFp4PU/i8G8/6eyJRQjo=
X-Gm-Gg: ASbGncvUq05foixZ2ih1o92a/FH6e8HHBzcWP7zJxTzYBENHuZs5DekLTHCWigPVbaT
	FLT2+J1TfgMEtuatdo4UxPV8FYOiMEhc6Rd1kR/IFhE9hcI0kfHHor/SVsclqzlHiUBY0APs9Zo
	J2n/xw2tDYOB8driPbbzTy/skG6k6kuJb3ftx7Nik8Dc0EkJzP7CFI0GZFkYkf8ZEttqtlE0Dyd
	4DQPTazrD7sJCscLbK8d8J1SXwcm+nrQnGUWYc7D4M7tP183l/uk3ycSW4EDEBAeg3GIk/Pcco7
	ElGnE75zocA/00Gv9ysL6GqE9pWmYXhkYAvjgbSrZazbpkj5FSN6yCTnU9WNNCyUDhGJz1wiURG
	JqLMWQQQbbjQtcH/vAaaRIVMXREWAxPfAM0sER+wo8O2XSwkxcNtFjF/b5XW5/tXlP50xQsRONY
	uLMTo8PhkIhfW+/MXp
X-Google-Smtp-Source: AGHT+IEqQsJBFv5uwUWvnqKuKWaeqqvXllSedT2UBK/+ULtHgNwi01zCsS4nKdErZ6SQJVrrjAvBXQ==
X-Received: by 2002:a05:6000:1acd:b0:429:a89d:ecef with SMTP id ffacd0b85a97d-429b4c43672mr8852365f8f.13.1762003644568;
        Sat, 01 Nov 2025 06:27:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c8910c42sm3140228f8f.7.2025.11.01.06.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:27:24 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:27:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: codecs: simplify aw87390_init() argument a bit
Message-ID: <aQYKuQuKekmoUrHP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Just pass "aw87390" instead of the address of it.  It's a bit simpler.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/aw87390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/aw87390.c b/sound/soc/codecs/aw87390.c
index 460b782e96a1..d7fd865c349f 100644
--- a/sound/soc/codecs/aw87390.c
+++ b/sound/soc/codecs/aw87390.c
@@ -360,7 +360,7 @@ static void aw87390_parse_channel_dt(struct aw87390 *aw87390)
 	aw_dev->channel = channel_value;
 }
 
-static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct regmap *regmap)
+static int aw87390_init(struct aw87390 *aw87390, struct i2c_client *i2c, struct regmap *regmap)
 {
 	struct aw_device *aw_dev;
 	unsigned int chip_id;
@@ -384,7 +384,7 @@ static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct
 	if (!aw_dev)
 		return -ENOMEM;
 
-	(*aw87390)->aw_pa = aw_dev;
+	aw87390->aw_pa = aw_dev;
 	aw_dev->i2c = i2c;
 	aw_dev->regmap = regmap;
 	aw_dev->dev = &i2c->dev;
@@ -398,7 +398,7 @@ static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct
 	aw_dev->prof_index = AW87390_INIT_PROFILE;
 	aw_dev->status = AW87390_DEV_PW_OFF;
 
-	aw87390_parse_channel_dt(*aw87390);
+	aw87390_parse_channel_dt(aw87390);
 
 	return 0;
 }
@@ -426,7 +426,7 @@ static int aw87390_i2c_probe(struct i2c_client *i2c)
 					"failed to init regmap\n");
 
 	/* aw pa init */
-	ret = aw87390_init(&aw87390, i2c, aw87390->regmap);
+	ret = aw87390_init(aw87390, i2c, aw87390->regmap);
 	if (ret)
 		return ret;
 
-- 
2.51.0


