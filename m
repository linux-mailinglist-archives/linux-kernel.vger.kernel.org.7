Return-Path: <linux-kernel+bounces-794664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5FB3E4F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0B47A6E73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D170338F2F;
	Mon,  1 Sep 2025 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUQmjJWW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D9338F31
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733204; cv=none; b=vCRncD6Cn1Bj51Sifzr942ywBmHgSoLDsXjNDaQPLxODS2DzyT4wzOlh+DPJHoXD4SCu64O4ZUiIeiR0PvcAUjDcg6LFXNvaKZN6ctEvqnbXPzbJIwyyZMA9wqUDZAJZNBoeeuGTVMiXR2vVsX31xGqrtmTLS69sTXPo4cj31TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733204; c=relaxed/simple;
	bh=9zJLdqtOKjBpkNMI06ViEGQW2gjiowt6JmR/C4Vpi6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Uho8LZYbhxGmTZwmjxKakTgg60VCBe0bMKe+MLehPPjzDLwc9APiBxA/Ya/ix16i8pJ4HZFYsNSjw7Xd5m5FoT5rp20RuXcwk7pnd+73D6+YP5SkAvrOwnUqQXsgxb9cw1IGTBFYqQ6Etq/xOnHjUbM1JTGEFMHaXOs1S7p3nLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUQmjJWW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb731ca55so76609066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756733201; x=1757338001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICiwcLIU71Izuhu8fP8tVO8odVf8d1Nj7kJu4RHQNHg=;
        b=DUQmjJWWhlAgiKNReCDRFHM3BetprA9OPQvbYuNF9TtKpOMoCF7DFpJQhOo+RR2aNj
         ErIvAoB5sPzHHJvjMdYdCWMgfrPAKY4ccw5f/y/uiwnuJruxfIOzy3XsAS8/fRzxX0Mq
         2my0fE0uvKgsWMAyr2UIozPa0x5xzvOB/3ZkDd5COAspgM1VvBpKnUlK++0WHRuRsPK0
         z7u/UiBIhBeNhSOVT2Ok2EcpxpFRN9qnNXioEO6rGmOHvGdMP3DG0WtPPXYyD7L93C3C
         IyPeKkxA40Xsf+yJcA2lU4VoWxsree4YBoUJq9U+EatiAvDzW5Tir4KUysgpuAKbMuvN
         RmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733201; x=1757338001;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICiwcLIU71Izuhu8fP8tVO8odVf8d1Nj7kJu4RHQNHg=;
        b=pjzEaIosQT+aTPIsRp0aprGO+3R40vNkIBZ9QiWit6I5P/tuDXB4nT44YBAbQyFMn6
         +exqoxPcrAy2RAXMgXl/SssPpcmayqaEj2cJ0lAdYpRIu43MEgsfeRSls0FQmNBZO21t
         erPqwnFTZAzLX5k+3fdlKKg3qXFsuwGHyciIVWt1jhE2cJb/okPf1iTpmtmUoBXSEAeV
         tfEwXDmvgWwu1fRxwJJ/kAjf74RH6jEc3fL7UYQEmldgTwG4TQE1HzIxXJ0Ko797qXWF
         kK4YT0omT/uxpdJYMW6cgaBYsnAACJpaPVP1fIYM6DtE4OiuKo1gbDNbSRwbnDk9/Eod
         J27A==
X-Forwarded-Encrypted: i=1; AJvYcCXG+sbQM8EB0xTC9ptd7guHGvphn8jZGL76ue0FpJ1jdZfGhp/u2riIlRJPenTS4R0zJ7dVZAZrqqxDpU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyug6iImHENU7Wvqj8kQ02XFAI06B8T47tmMsb95LlL4Qd+DPZn
	Cjth+KD85PwQKXYNzsgItkCuXs+DK6N5taz+jOJ74tFOfXZsOJbfKPj6yfUSuynM4nI=
X-Gm-Gg: ASbGncuXL1wAT8XYaSGMekzI3T0YC3KNcjg9KEMufnQIqGR3gFPaDPI8uz0Hj55L7Py
	D6Dxr76ThmXYP9/suRbD+t+hKmS+MxpDHnqofSUIYTekvuLB/YHyV08U3qAVkZTJp72/y4KWC5E
	Qx7F70PnPrJBBeSzUjZZYMF0Qb7G+paiYnm1uNryY9SRb+OkylhqGy7Zz/2dszTJsT2bXxMtEzH
	M1PhfAT6x0Xu2y6O6I8yjoEt/3S/UX19AZ7HYCzMxmyXSKSyIE+I3ObzzwRhMJyu6lK4Bs7IhIv
	J5Y506p3jNCfAHmiiyKcplT0JMrwB7JNOQoErfO7As8bAnb28reqhqELOd4swu1ThMkPHWObKec
	TQFkL8cQYndWscI10Bum7tBTY0FKaokFrRgrp1A8=
X-Google-Smtp-Source: AGHT+IHQTmAvbsKv0D4j4Hvyh4K0kyRVksjF4qrxn2f9tAR+H9KrYnWzvnDmgth3oDHi6jyc4O8txA==
X-Received: by 2002:a17:906:16da:b0:b04:1fc6:1347 with SMTP id a640c23a62f3a-b041fc67c80mr223542566b.0.1756733201076;
        Mon, 01 Sep 2025 06:26:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04241b2e7esm305997566b.43.2025.09.01.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:26:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
In-Reply-To: <20250830-s3c-cleanup-nand-v1-4-05b99ef990fe@linaro.org>
References: <20250830-s3c-cleanup-nand-v1-0-05b99ef990fe@linaro.org>
 <20250830-s3c-cleanup-nand-v1-4-05b99ef990fe@linaro.org>
Subject: Re: (subset) [PATCH 4/4] ARM: s3c6400_defconfig: Drop
 MTD_NAND_S3C2410
Message-Id: <175673319874.45844.111501190462962489.b4-ty@linaro.org>
Date: Mon, 01 Sep 2025 15:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 30 Aug 2025 19:01:12 +0200, Krzysztof Kozlowski wrote:
> MTD_NAND_S3C2410 driver was removed from the kernel, so cleanup
> defconfig as well.
> 
> 

Applied, thanks!

[4/4] ARM: s3c6400_defconfig: Drop MTD_NAND_S3C2410
      https://git.kernel.org/krzk/linux/c/ae6f637a456c1de75a582afa9cb6169813e89b83

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


