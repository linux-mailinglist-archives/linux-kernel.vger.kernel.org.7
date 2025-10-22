Return-Path: <linux-kernel+bounces-864774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D3BFB857
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FDA3BAA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B7328621;
	Wed, 22 Oct 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0UpFBcm"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E5299A8C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130947; cv=none; b=CKQfmFZuhUYXygfET5s+S5QtAiKJv/TClZHWW7VOkx63dw+p1sj2Lbn4OTI2XxDbkwZNRptCpl0z/r6bLwEe4MkSOX+NW8o1HhnRdyKrBvoWcj2ur3szRvfgny1TwgYZyuTjqTGaw5CHj2/zff4wBh5Y7Xg05iwgGFnh34k+QiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130947; c=relaxed/simple;
	bh=U6QL/+JJidHtZRcPOVlNbuzyRSsR+FDJqN50LjHQQA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ECGU1YpN8t4v1fQtjkZJu0iYznZ4LhAoXFSR4BeJOpq4Xn6dDv5ATdU1yPhvP3c/q1S3kUQakr9qKbk7S1mApDFIW1tG5a+/FDWepbmK+lvx+bjJKGBy2d91TjTqRPAWjVkV/bxcJljpOVdEr1cUB9almDgLbEfQKZJ/Lly/HhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0UpFBcm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so10970875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761130944; x=1761735744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vr6iKNjWerf9nOZB9LbbHl2ovGZqdFL4pZFz4dDFkR4=;
        b=I0UpFBcm6UnH98+cDRl7QpFxdB76mz4rMfoUgTjFVvtPgoXeLYMGzWKw+3VYhZChR0
         DPDvBaaz4LSe0KqX5pfQnfFU+dqxi73jjsU2FwjjPcR3RIrXkxv+El5j2aZgytjK16ti
         rliI4lzjmPy40U2nMid12v47jozRuIspYA8K7iiGMALMKk9mV+Clnf5lcpqLmh67+zF2
         tmQMYcPMsGvw2nfmqwTQULA1tk6/VIG9L8XJ1MjFUHCtab3J4K1KowdQuCXegjmxG8R2
         OtWp1mdFaUAQFRNwXSBONuLhWmWxBRRy7IzIoYUpy1tIFDqsTLwAcnpoyHpLNrW88W4N
         k6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130944; x=1761735744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr6iKNjWerf9nOZB9LbbHl2ovGZqdFL4pZFz4dDFkR4=;
        b=vEKD1LP2t6VIM884tdVrEexJATEA/adkTwdlgY4eW6rfetxOFATld3PXAkG7AjHCJ/
         UEPTHvZqzy7ARJ42bvPSpt7Za+G9ef/W9wYYRcRJNEv1EVExSe6bTBKPaBVDqqcrFfym
         Gqya+MuH6doyjHZSyMDXUxHP3OmktFSW4ddE/MLdI1myrzWW81zBbeCwPnmZu7h4K0wJ
         v8DXPDH/mucFA3mHWvFgOpXKVjnxNDufqI7VFcAWesx5NU6HuC2ZfSGvJz/DO915M8/w
         jgBZA6S0dSQ/KR1eqaNXrvgKbsIVpejCbh4xPVKwaY3t3hx3GPpEa8F+iTLW/Ai6tvw3
         4FGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCRCyVC4WYISmsiaahS5uzPN0LGy0rNIVhhzgi768X9UwL7zvYcketEBiEeN0Jo62oyZq/yKKR/QC1m78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZA18kb+rE1aXY+hvv9YjWmMIYVTOtsCFoZiUj7DKDTva63DtY
	dfAVFY61vszu9YDAe2arEg38Ap7/Po1ew/pF1ArnCEaBLm/HnE4ikkvvnaCVT31+2PU=
X-Gm-Gg: ASbGncug2SLJrmwHWMy3UCYqKHziguh3schfIEdo8GCZrpQfgWo7NpJaBfAB0AcqAp0
	MFdjLvnKJhizMVwV+He/XSKdiEeL4Z8mhFAmmAt3ISGEhf3r4hZyk9kGeMujIuH5xOgc+3Qpp/o
	BSsqnQFP/SmdKTq4jNLadJI6gN62wFnph7OI2FVw1I+ZSQw16xuowDYOoKntUI+6yqAFYbb2h7e
	6ZgCO4RlvZ+gST/RnwwF96Bc0BDWkADEcExAF0ZLJRPLWlvQOycKuB5W6uDHa+B9sX+NctqBSRH
	zeRWCng6TFzWTKiaZsv5A7l65RqoSloz+C0kzYXkX7u/dS4BSFOl0Nu+v1rQ+5kYxw2iQwztJxq
	TtPHGYqUfoVvSzpp0Hghas0rQYCvdzOr0VA/E3rU5I1m9uXiWGBM6h5CLVIt2wVFLknZaLw4qTU
	ESTCNNPg==
X-Google-Smtp-Source: AGHT+IH25nwlFz4tq4G1fC0j/+8ilfgBKiuMxxceSNPKsvkrvfcWUC6/1PbTIDPovElQDzNqkYF4Ag==
X-Received: by 2002:a05:600c:540c:b0:471:12be:743 with SMTP id 5b1f17b1804b1-471178a3f93mr153198455e9.15.1761130943947;
        Wed, 22 Oct 2025 04:02:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c427c3casm38651185e9.4.2025.10.22.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:02:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:02:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: imu: inv_icm45600: Add a missing return statement
 in probe()
Message-ID: <aPi5vEp75jH0imQc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The intention here was clearly to return -ENODEV but the return statement
was missing.  It would result in an off by one read in i3c_chip_info[] on
the next line.  Add the return statement.

Fixes: 1bef24e9007e ("iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
index b5df06b97d44..9247eae9b3e2 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
@@ -57,7 +57,8 @@ static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
 	}
 
 	if (chip == nb_chip)
-		dev_err_probe(&i3cdev->dev, -ENODEV, "Failed to match part id %d\n", whoami);
+		return dev_err_probe(&i3cdev->dev, -ENODEV,
+				     "Failed to match part id %d\n", whoami);
 
 	return inv_icm45600_core_probe(regmap, i3c_chip_info[chip], false, NULL);
 }
-- 
2.51.0


