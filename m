Return-Path: <linux-kernel+bounces-775321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412CB2BDED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2473E5E5B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693431A057;
	Tue, 19 Aug 2025 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSvfBo3W"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A32765D4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596903; cv=none; b=f6y8OPR3q2WLn0dGRsGl/l0OHqEKwC4yGsuhqyU03JowJBzxsr6HqcSpakhwcJe6NgfqQVXVa1HglKtB4oFxdL03Cy4Y60gCvKXS1+RJ09QC//paK/hxFQkk094hurZsYylVOYP+zNc1RG6HNR/ku4RO2x26GxnlTCkjST25Q80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596903; c=relaxed/simple;
	bh=vDQ6sv4CI1XEeY6KKn5PmWXhWFLpuy/IbsCbzwNKGoM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uGS+F9aFAebn4AaFUVkvVfs4Vi+KxCrC26BbyQByvV18HenDGu1HC2nqd9i80rZXBcId1uje9PUBnOk+2nsasc3IzvG51yuxYrmQS3Wya1+ise1N1fQL6/uDull1ntHC6cSfhAgHypUXWzg1WuCEPrpIenjCyWoP0rGsJzH7B88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSvfBo3W; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so677528766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596900; x=1756201700; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYrVte0dUC6jFntJ2Z5yq1u0byPHu3c4Sgjim0w6WbU=;
        b=NSvfBo3WSWoiO6kCvOumMvdIhiUoKTp0AAPvGkoWlwMg/JOp7wBWYwWYFpUNVkKoTc
         I1mTVzhIb5TmS1j5eDerxJngVHRUyTvcSESy/aDre6kP2Ux9fojgWNa9XrHvI+3pMzwK
         wXJJzCYw8ZPiVOsvhPlYiDuGX3r5fb2JTtcF+r55BeRv+U4XfgBroOv/gwLjkGARNUNF
         5LnGkrHppUTEEuT3PsvxaaLwPIeqnVl7oIECiPJEteHeKX/6CkaZfslqD1K2CSgizbpA
         ItuchiHKR9th3v1S6+EGgD9tkg9cN178TIRKwczl1xL65tim2l5jB+funXZULBdi8XTc
         U7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596900; x=1756201700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYrVte0dUC6jFntJ2Z5yq1u0byPHu3c4Sgjim0w6WbU=;
        b=Vm1DNFwAXoHMvXwVBT/5JeKXF06e93w4B/8RQhTBQc/XkSmBaw0u1X+92xlXEfUw12
         s7vH1UhUR3ntbyIXofVlvrDaxXqqIF0zDJKQALgOhMvu3AcLrHZbtM7yfNFgJjsLjqaK
         JzuKdnf2dxkEr/3ZwvJCOYY9n9yFq3mElIb3TmuyG5+4IC8qtX6nczSxDubYXhSU+G8y
         4tKK2X2FZolficd5YftKWUtTFJvlkJVtx5cAHIUwNU1FqU6kLvUOXPQJJRW0c2UkTJiY
         GniSTI9HDMlF+lAfs0u0uhCt7BFnBWeaL+r5z7fpw9mvyunYzUDiKFp7lsVH6niFTQl8
         ipHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqboyOusKbrL0B4oUKbr5oU+SthbKPXmO9j72nfo73a//7yhHYElynT8A2yyu6lnz5GDtpB7rEQDOKpco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1gtqxQTkE6vaSltGwE34lnU0zC5KGl3HKlHbdyS1e8y9MIlk
	022HwYFGZ/qi1QM067GPah5t0rqnINXYbR9wuxH32wjIP/WQujJat37RbiN40B7ANRummleMB9K
	83r55
X-Gm-Gg: ASbGnctPgk7yDtnQos6fYM3JLAnXuIY1ze39I+Qa1yGK9At/iAbY1N5xLpCFH9Or2P1
	avLm0IM1+C3JDWoH02QX8rCySSdQpJtb0CqiVuoocvhV0LgLXaM+rLwyoYJ0rlxTuacu8JPVvWa
	4nPKi8sV5aoz9Jk2BOkjzJv5vYfY3T8C9Dk8hA1L7/XdPLzgCyFKGaaQOQgeOfyZdQwkR+084ZO
	ybgdOf9oEksveWxj2ueSObCnLpiGQlF884OeNFVLujfSXzPQj1LD+C4qGmukqW1epffbdaQzHoG
	ofWMlXQDFekoocvW5bvNWSVPvC4VQh6l3eKyvSgT95YGYjrhY/NbTwpoHnoQKo2qewzLn4tcipY
	Gd0+BTISYxm75AWBUr51XLqT/6ow=
X-Google-Smtp-Source: AGHT+IFeIOC78J3eSW8tZNbbpFmELZjsM5rbvzIym6l834NalJLewkysKiN5BeWd7Q9DHgnPdSL+tg==
X-Received: by 2002:a05:600c:c0d2:20b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-45b442bf27emr8207155e9.29.1755596445141;
        Tue, 19 Aug 2025 02:40:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6c324fsm201653985e9.1.2025.08.19.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:40:44 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:40:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: tps65219: regulator: tps65219: Fix error codes in
 probe()
Message-ID: <aKRGmVdbvT1HBvm8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste error and we accidentally use "PTR_ERR(rdev)"
instead of "error".  The "rdev" pointer is valid at this point.

Also there is no need to print the error code in the error message
because dev_err_probe() already prints that.  So clean up the error
message a bit.

Fixes: 38c9f98db20a ("regulator: tps65219: Add support for TPS65215 Regulator IRQs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is a rebase of a patch I sent earlier:
https://lore.kernel.org/all/aB3hiEM0CB8m_X8m@stanley.mountain/
---
 drivers/regulator/tps65219-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index 5e67fdc88f49..d77ca486879f 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -454,9 +454,9 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 						  irq_type->irq_name,
 						  irq_data);
 		if (error)
-			return dev_err_probe(tps->dev, PTR_ERR(rdev),
-					     "Failed to request %s IRQ %d: %d\n",
-					     irq_type->irq_name, irq, error);
+			return dev_err_probe(tps->dev, error,
+					     "Failed to request %s IRQ %d\n",
+					     irq_type->irq_name, irq);
 	}
 
 	for (i = 0; i < pmic->dev_irq_size; ++i) {
@@ -477,9 +477,9 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 						  irq_type->irq_name,
 						  irq_data);
 		if (error)
-			return dev_err_probe(tps->dev, PTR_ERR(rdev),
-					     "Failed to request %s IRQ %d: %d\n",
-					     irq_type->irq_name, irq, error);
+			return dev_err_probe(tps->dev, error,
+					     "Failed to request %s IRQ %d\n",
+					     irq_type->irq_name, irq);
 	}
 
 	return 0;
-- 
2.47.2


