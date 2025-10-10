Return-Path: <linux-kernel+bounces-848611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63FBCE2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5232919A362E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D637231A30;
	Fri, 10 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2X8FmCYb"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE305229B2A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118942; cv=none; b=GJSxbXCTVgaEnWUdycZFDz6+YlRSfJnv0G2mTO+iI5oNSwe9bFPqooZdTNicKGPMxMn83LLXTVsriZAkvIFGMDmBDhQ7oXSK73deqayjd5bMEs8Dl+20VUGBuqTVFJFT7kWbmmAxURrXpaptAAwjMhEZGQCJNmjAQS7cS/LL2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118942; c=relaxed/simple;
	bh=wNIzmMRkLHrQdGJ9CI3n8s5+na28Lf4RqsVWycxkjMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eW5DlOKML1bAKZnxmnt68H2svM9nyieyAj8tLDX7gRAd6nBFmQzKp7yEEMkaVS67Gq8LBRo6ONyw6gr9yiINL4FklElcvfTbtPRrCw2zOe5fzxFGjDf5FiuXrijxw2pQRF7HSuduy37BbfjctO4WpaGH53sTx9iuK3rSylk14UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2X8FmCYb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ae21804971so770740a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760118940; x=1760723740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaMtprRJaiBLmGg4i/xmoof6gnqLK2TnSEKb/a6bsk4=;
        b=2X8FmCYbCmsEgdEvV9AoAjXb9rV9Q658NP8FIpS3wl6JBzf0t45LSRtZ3E+IGBVR1c
         AoQ91MXTGGWJQyE7NrjZtEDdOFBxSUx5aWtuzVovhzo4ziuCT/mxE+G7mBRdn/DKqdUu
         9/InSeCO5zVi1ypsm2d+224lGG8cPEGg+ADeeCwWSi+oF9srAUkDg6snlTip2pYPlHXM
         WrQpCKinX6gLdvakHZWGst17awDi4QChgiW8elZ4TQMnFKGSz2WdR4UI095Rv44o+YzK
         KlCE2i6eJS/q96YbK6N4vu0YIs9CaZmzpBdg9B1DR9Iv7lCsjAhaABcNamq+Z5T2VD9d
         r4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118940; x=1760723740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaMtprRJaiBLmGg4i/xmoof6gnqLK2TnSEKb/a6bsk4=;
        b=Uugj4vMLcEweSv2I59WueYrhMbyMr1+u8U3zei19ddIys4ZoSybwmZLxk9rb/T4nVz
         Pf9yAmRZrXo+Ul2V6p+CZ5kQWE4VPJeDXNguVs/pRCYkoHVHE+ycfPvN34twkVWVL0WS
         +lEkFcJcs9h3Y6qmYu0vi9GlgYUZzIciRlqEX3L8/BWYM9059M1q7sSsD8pDmbQshYne
         oQK+w/sdSlKEt9xJRnAJJWwY5vGsKAojMdM8DTuNRJe8iwCbfS7E8egPImycWPkSmCii
         9UGZ0VnT8MZoTOTxB3cH483fr6avwV6vJtUSGR5+A5pzP4R3q7MAMD45Xzc8HepBnYyt
         AUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR+p0Bz3FklgGh8BzwLPkjE2Yc3DlhKRJFUJ/YGzojs344u/WpgZDTpeSTMPkkA6ju7awnXF/EZ+RnYR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUuA7uf8WIWmZcoBybdqHKnssHd15mAW3Z2+w2EU8WnBwi1jW
	bgd+myiNmYQ21Jnch/Kazk9twqbNHLZBT+nLxcF+YoMiWIDojsBF/f9NGJ8mVFbiIAc=
X-Gm-Gg: ASbGnculLW5ggCTMWUf1ZpJE6qy8A5V+hWpr81GBc+Z4AY86//1T2iDipomNU7dOjzn
	xADqQMJCdeQggxp6jd4IVOv2Llls0ZtrZp3LDdenmhcI0iKnZLUGpaan9+kq0CIK3T6hkRnzXox
	3/nY8ym4WXNBJlFOVMVB5EjVoRcYtLu2MIT9Y6m6F7Pct6zmi8OmdUF8f5xKhHoO9HQD8N8n4H1
	mQcxKcVqCQ2T1rT+psgP9IDGXQdNI9t/59Rloes7xlrrQvfH8jHEJK7f+4YnWbIqfnE4IQC8CGy
	jghHboCbTf3jNmTCG7NcKfe6yqZmFMEyR0w3rlrKnJdePRQDXIjTTe6PIah8Q8u5WZnpSPDuGib
	HYPvdM0TncyjlpnTgtXMUAo4/nupu+7K6yJlLhpQbtbCd0sgxhC/z0KXuZLWhUaJ787UkpXBWgm
	JWX75bJeV07aPehTQE4EgOkNkBrw==
X-Google-Smtp-Source: AGHT+IEK9+fD2C2mpPvsDARXpusuog/ajtfLqTbuc/LGs1+ce/f70c+jW5JTLJ4ttYcpUKSMQljjjg==
X-Received: by 2002:a05:6830:700e:b0:7af:1367:4f85 with SMTP id 46e09a7af769-7c0df82d758mr5830865a34.36.1760118939948;
        Fri, 10 Oct 2025 10:55:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915eed4sm1027277a34.36.2025.10.10.10.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:55:38 -0700 (PDT)
Message-ID: <abc4209b-eebb-40c4-902c-b584028bb611@baylibre.com>
Date: Fri, 10 Oct 2025 12:55:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: health: max30100: Add pulse-width
 configuration via DT
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-3-raskar.shree97@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251008031737.7321-3-raskar.shree97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 10:17 PM, Shrikant Raskar wrote:

...

> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2015, 2018
>   * Author: Matt Ranostay <matt.ranostay@konsulko.com>
>   *
> - * TODO: enable pulse length controls via device tree properties
>   */
>  
>  #include <linux/module.h>
> @@ -54,6 +53,10 @@
>  #define MAX30100_REG_SPO2_CONFIG		0x07
>  #define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
>  #define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
> +#define MAX30100_REG_SPO2_CONFIG_PW_MASK	GENMASK(1, 0)> +#define MAX30100_REG_SPO2_CONFIG_200US		0x0
> +#define MAX30100_REG_SPO2_CONFIG_400US		0x1
> +#define MAX30100_REG_SPO2_CONFIG_800US		0x2
>  #define MAX30100_REG_SPO2_CONFIG_1600US		0x3

Would make more sense to put this new code before BIT(2) to preserve the
order of lowest to highest bits.


