Return-Path: <linux-kernel+bounces-878283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D4C202C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B94034E9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98931354AFE;
	Thu, 30 Oct 2025 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaoE6Sqf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9B355027
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829801; cv=none; b=Z3Jpj4JBYUvGz71JbPuK3WW++qmmdV6f/ZXLvAoQBOVep2Hk04T7iEDPpNwWu8+befztHMx6hr1MfBpTHLj6uBsEQyuEN1Ma3s8ArM9Lzm9cpJUeS8vkM9leYKRLyl6pcfxS8RfF0/GEXY8dXkdBrG1KAqytYdqkI67Qs8ZdKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829801; c=relaxed/simple;
	bh=LN195ehH6mkaeBMWFVU2UiSTlFySjfIXc7oLwKEdmC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqJbHyHo6neU3jxXQLOBiTwqA62EXRAN71JbrXgxgkJrL0QeV8XXfhqF3BuVCeswcWiaoufrO/iJchPhlYIzPLg9kY6S9REeV588T7lTp62/EvaSTn09bzSjX7t+UIIzLm2XGzd7WzaIC2sQb2TaxfudvvCBCdklBGYyK2Jmxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DaoE6Sqf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so7744625e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761829797; x=1762434597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeBRI/u8xeKdN9TEDvF4M3sR8Wge/buOtQAIlYrKrEk=;
        b=DaoE6SqfHmgBfYcla046bIyaqD38SAvYl4eKvrQZmtzVnGULTRMC0e4kOQPjX8Gep7
         QvC3wqPThxOu1ZykJLlsRQNo8yinTIQVdXdcm461Irg7hiht3joEb+2DoI3rYz4Nks2z
         dPRIRawxM5q2IB8NcE+3qVF9Ej1s28slopw9jETbKsxsjkNxwlvSHnyFAwFzUH0cdnvx
         tbaBEGGPb0lRl1u85HgknjWq+WMeUXqiqkXMMhlCsj3F9JMecBfnXQLzfHMoWxk36xx1
         8jwZV2hcvDAIWI8dLOwswoHBrSYPzDx18Q0fGnRZTERD7XstC50Bnu+eZS2D4zEMJUhE
         QkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829797; x=1762434597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeBRI/u8xeKdN9TEDvF4M3sR8Wge/buOtQAIlYrKrEk=;
        b=Vkkd0DD/i9FsM25difZKsuICVVeOA4s0xkNgZjO+P4nqgOsI7LWLqhC67yUnb1XO18
         F0GQ1VkzuunVjTi+e/RfTHskh5zbOanpizO88uB9DtpMziCHOVttR0blEDE5DoTIC02N
         UP0/6ApLgdjpoaVHeOV5d2x3E3hqDMHGdmy7hHacbt7oFYrSr/r4ljaJjWXepaprW0G5
         56fBXP4IlqB7vMQzchoXLqnF/iH90vateM2Tuiv3dp5EpyPggCPIJj/eackp7z7K0kdP
         kFHVpKdrK7MT2vuvNynlgu2xPAhZy80QOwye6n1CUvnfbnO7bNd+evu36bw8HCRzb+EO
         extg==
X-Forwarded-Encrypted: i=1; AJvYcCXXKsOEt3ikf6MFvRZCLAlkZ1s8856K+P0FwnXV/g/zMOTvFp6JgrMph4g0gf3gYeB1s5OgIMAKe2x4uDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMFXIPaQmcGl6DGGFE7B2WCdtJXqB63KQ9wEGzmDCl5Yt+BXg
	LAigewiRWCD65ad4kFP03nCuEqbUiXR9RYNiLnaOVJDjzGRHXF/3kL7FyfeveeFmFA4=
X-Gm-Gg: ASbGnctAJ+Tk4j3ZsrS4yRoSom96KtUdyPqvs/xsoTbpBVObxwA6qk+OOTsYUgbghCu
	YouWnykaVrFvvRNlaq3QlSH18EaxZr6Y1IwxceKP1JUeWi+FtaJ5BmHVkTwihtuqgjld8PQmnCr
	D54tadWig5q2q7EBJUtRgMlOAQXFl6xX4uC94qLsAhNoUQcwS3A8RVYDDgAeotYJ0HlyJw7vZCF
	GRK3zSH9H/rFNNFSiWBJS+SfArFWvWGrSxt1gKIlpa9rvAA5/e1JFjEnxKfvykqQuF908A7WOui
	hXKyaIVOuIfxoz1g94Szk/1Cle5JrgTkEbS5p07JgvajAlkdqfjQE70f8jEok4cOQx00WozYxUl
	1ciGPhad07IabrF9WxSQJLV3VGB9nAywTYkid4+2fWOVDTKwy8miX6t3YItkZjCaFdSQ6foQv96
	YanFjUIg==
X-Google-Smtp-Source: AGHT+IEuSEP7qxS4NaQyAdw06cnpw/gsltQisUNaoArx9BRmGnIGEWxBTAwt7g3x9+pa8EwuF/dyJw==
X-Received: by 2002:a05:600c:4e4c:b0:471:5bf:cd02 with SMTP id 5b1f17b1804b1-4771e180b6emr59383185e9.11.1761829797084;
        Thu, 30 Oct 2025 06:09:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952de4a1sm32637772f8f.37.2025.10.30.06.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:09:56 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:09:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Message-ID: <aQNjoM3fgAW6kxUz@stanley.mountain>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com>
 <aQMUu08phVPqfgEB@stanley.mountain>
 <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com>
 <aQNccP-lHqgygmsu@stanley.mountain>
 <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com>

Yeah.  Let me send this tommorrow if no one objects.  Pretty simple
solution in retrospect.

[PATCH] mfd: syscon: Return -EPROBE_DEFER in device_node_get_regmap()

These days we can register syscons with of_syscon_register_regmap() so
if we can't find the syscon that probably means it hasn't been registered
yet.  Return -EPROBE_DEFER so the driver will try probing again.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ae71a2710bed..e5d5def594f6 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -183,7 +183,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 		if (create_regmap)
 			syscon = of_syscon_register(np, check_res);
 		else
-			syscon = ERR_PTR(-EINVAL);
+			syscon = ERR_PTR(-EPROBE_DEFER);
 	}
 	mutex_unlock(&syscon_list_lock);
 
-- 
2.51.0


