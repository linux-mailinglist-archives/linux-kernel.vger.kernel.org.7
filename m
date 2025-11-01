Return-Path: <linux-kernel+bounces-881300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B97FBC27F28
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635F14E83A0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15832E92B5;
	Sat,  1 Nov 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdtaO3jk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21628CF7C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003534; cv=none; b=Dx9mtx6eZAHsspbxO5AnT4o43fycOgUBVhgLlQFAWN7ui85ujiupVezO8qT+rZ5P7aXexht1DbjwjWtodtMgTGNwKzmcPAscdDoaINjKyYm+meVIqOqTycW3ZPk+TeuMBvBYoTZmwKMkhAvvhgxAAXs0KiEC80bLXR6YfTdon9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003534; c=relaxed/simple;
	bh=Z98SLm/EfpTZZ+75oYqs1vAnViW8qDAEJMAoaxRjcMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sp1hoyijEIxnur5HBhejSF+f0qtNap2yzjzniCBtTsrnBtXMlAPtJ81RENjZOaUhWYzfNjmYF2ekQYDpus/oPIIdnBETX1nntMMduhYVKumwO5j3y10jF6UOoKIJjnBBW5GsBT4RNO12WaQhPK2ltLgTMTZQuQHfLPDZ6g5XU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdtaO3jk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so24810395e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003531; x=1762608331; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9gbS+9LrLe7y4J6JOoi0YS3Bk4wJ8cYhZR5dEyxBSU=;
        b=SdtaO3jksgTLqU+mS3qclYS5VWLHEev1z9DX2gw+YhZLE+lYolFpb210a5XBvsUhOS
         rDc8D46VdPJtVb0QB9oP10HOGB170XfZvhDbqd1ul/hrq7JhGQAIY+GrqRM79XtGSV11
         21RmS0OrKQWNnlX0XL/CVqiHhOG0+KQQotDA2FniWnm89DCi9Np+pJ+NCgsVAGGe7RKK
         lgcrCz91r6nGf7KySwGW5SSHOynTR2jZ4uEQ2MjjhTJoUdjnDwX2wlwx2ugpUPn3/l/v
         pllDQvO9kO075YipdWvZAb/nTR4b66nXsKvyB8wqLj3AGFXrUC0DlWucXQeNBlLiJZ+F
         RymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003531; x=1762608331;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9gbS+9LrLe7y4J6JOoi0YS3Bk4wJ8cYhZR5dEyxBSU=;
        b=jO4y/mp2Qtyu+zmC0X7XAAXVbfal/TKhdNmtKd4sAAVhaXwFEiZE4vUpIv5gMrLYm6
         KN7DMVufwmtImTqWBHmMBMuhOQj+4FJYGQGHe9ApCPPYCnMtyJqxuDY5BClmXNul2dsz
         dyUea5eplhIevIlz5vjwxW1XmuSMM/Pm/zOcXAzp8qWc0dR1ZemQav0nchsZ1oaLn1Hs
         HSEkHw0hqB6Oj//q17VlT1Dovih+qr7HAnQPm0SYilRPKfmn3hCGjGP8kU96tHDu9ERV
         oNFPIAAb2ji0iGMY27k7b98GpuyN63pppqNRkIE2X3ao/Y9PY4CObqUAb2WJWqbHSxoM
         hZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU0241tGEdwJZTbWizYn7QGR3esFSQOQuZ/QGT+IQ7nide8FFNZMMhqhWO5Xh1jHCcq2Fsf1gq/pVPrXno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlPOTRpKvLaVo1lnKoDNs8Jq5MsELFIA7HNaI9cNUBed5zUMw
	DYWD+iORfWPJ+9RRwgdp+xm5QiKsB6J96rQWHNEbhduZ4b1kNOE5OVi0UtoiMNy5OK4=
X-Gm-Gg: ASbGncsWcOMTpC0tfrAnr6toFJSoPBeX5xFJ5iOkH0AR9Ni7AaaIOeHbjdZAU3xltyq
	/z3MSCdAOuUpmjnImDfOJUNz0tyk0q0BKH/SDoET0WD9H76HcENufJQWUiPCb89y0c3WYmdxHUd
	MauQrQIeYyoMox7HQIN8i2gjH4ah6pH4QqnVuM/XhN3AYetldZ+QoPbw0WkrctuNvWLs2cbCIFp
	iB0VNyu2JJt6kbrLlL2vNdc0Mw6tWs02vD20YzB4kjWtgcZiVCpmb49KEP9eeRDpy7RevdCp0vH
	hRovuRM+D0ZNNvNQN8OnE09YtIPUBYUv4eeaR+t+uXo6rMiiqGxjn2u68k0j+o/bCfg8ybn6Bps
	7KaAi5QmyHmncqW05vpeS/zWdIdeMEjUYF+GBD5FKydaulssDBzhQXM6Kg82wB/WY3cNa0eXUtd
	2heIgCEA==
X-Google-Smtp-Source: AGHT+IHfkE8YJK+hEniklXFT4GhX0FQkyrWL8TAH+8xEiRGBmRw2WAmAAnJ/Iz+FCPOhsKJuLyo9JQ==
X-Received: by 2002:a05:600c:1e19:b0:46e:711c:efeb with SMTP id 5b1f17b1804b1-477308aa8acmr60161545e9.25.1762003531066;
        Sat, 01 Nov 2025 06:25:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c48de65sm47854815e9.1.2025.11.01.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:25:30 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:25:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] Input: imx_sc_key - Fix memory corruption on unload
Message-ID: <aQYKR75r2VMFJutT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This is supposed to be "priv" but we accidentally pass "&priv" which is
an address in the stack and so it will lead to memory corruption when
the imx_sc_key_action() function is called.  Remove the &.

Fixes: 768062fd1284 ("Input: imx_sc_key - use devm_add_action_or_reset() to handle all cleanups")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/input/keyboard/imx_sc_key.c | 2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/imx_sc_key.c b/drivers/input/keyboard/imx_sc_key.c
index d18839f1f4f6..b620cd310cdb 100644
--- a/drivers/input/keyboard/imx_sc_key.c
+++ b/drivers/input/keyboard/imx_sc_key.c
@@ -158,7 +158,7 @@ static int imx_sc_key_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = devm_add_action_or_reset(&pdev->dev, imx_sc_key_action, &priv);
+	error = devm_add_action_or_reset(&pdev->dev, imx_sc_key_action, priv);
 	if (error)
 		return error;
 
-- 
2.51.0


