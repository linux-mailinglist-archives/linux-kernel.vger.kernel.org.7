Return-Path: <linux-kernel+bounces-745495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E09CB11AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A3B7B00EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC12D0C72;
	Fri, 25 Jul 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0nDAWDb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29B6253932
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435164; cv=none; b=lIjvuYklORo8UHfAJvPOrnfkVGLLij/RXP0n4zc6FT+OPTWOPAzUCLPFUeyHACIivWgBhNevQs8my/e0Cfj6rjziUoXwlrLbSnm/C/4Z1SdQpr+rnQVsAMIyZPCfNEgd4VRAIWoSg2P27oApfRU5stBI3EZZBb2seU0il8LbnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435164; c=relaxed/simple;
	bh=/vql1YMvGbsTytwZt+yqVUId8Ha6tDPKUxVBWT0WDm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nt0uX1sE0oxWGF8KfpfXezuUb9j7U5tQmHfCVqWXc9LRNGAC58eT3vjq/OEQV37PeHzmDop1iwndSSE4yVJEXrVOIYv7wduVOTRJ8gzY7/nwCZN7QqvpTdH8nn0pcyQn7RONAaF1j7zy0w88rdvRjU3rGlin9YfmkZDHztzGlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0nDAWDb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23f8bcce78dso21988085ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753435162; x=1754039962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eEpniKk6bwNpegBFAtBP/sJldjdZjYBWcx4NScAsS2s=;
        b=W0nDAWDbmqG2zpsG26Vj4I6A4AIirzZPxTMQRua4jZ2ppgIDmgxcXa6+bUbRhEGVax
         6hdNVLBonse9ihCfD01IolVp8LtG5tV9cHJXBwEcqwWv1DwYIL9WBbiQVTuKtx/2lDh4
         eI6FfnlsIsLhSD+kuiceogu7BSOKgjpMDjvlGeFQlo1i3TFjuc+Ah1GL9UNJ3zw8jwZr
         LfP/3pOETpir/NZnk3tUdPs2iwFdC5IzILmUVJCoAfF36Da36XZB61ZDuR4a/vZXocwK
         wBWWgRpIZR81ijm7F5gF4cA4NDtIkJ4IGRRFqrbsPtF5aodWaphX3XWu8B6ywV/uRsJJ
         KAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435162; x=1754039962;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEpniKk6bwNpegBFAtBP/sJldjdZjYBWcx4NScAsS2s=;
        b=HqAjdRoXx0kZI1HnDLAiEIUxy6J3juiWQsv8gOsrtHW0HeyGvh9MHjWOBEx1oMbDuo
         txKoliq6J5MRi/LV95xh5/ygf0GlbSrde3R0MWnYgFJUBFISlEftlW0RaB4HjbIRE082
         PhBRn3lLp8nqKsIAG7fi7Dtr1WSqgMvfjUBtFsAqFUuiRfLLmAWJmWbvCKCae3XdxFMq
         gNPEVQvrbn7EXLj9gFpGVceGgNcSdohPGc2yGQ9VSBGuipYUcEwjD0WTxSG5duouSeZ2
         v6ybA5hf0lB4dRbK5gQX3ThR9VEX6MMsGNLCnfT8GOi5sVt4SIUTq09qjCy/CxQixuK7
         nVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCTi+g1sftsYAPb3xRR7zU+d0aYuFlzaLHvv1uzlg0KcI7D+gfCVTN2gIDCVNlqLKl3q26UtI+Hcyf1wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBhI8Cl6h9Shxyjmg/i76e0aPoDvRCXJtETtDX4NZu22vY/Wd
	H9QmcV7M1QKLlzhlSjPOvvx12zJQdZsP0JvHJTVeg5/GLuoMB1fB2W26
X-Gm-Gg: ASbGnctkGCiVGVZ4A2e3mGaTBtfy46N+WHVRA7MDBppq7QlbxN4BdzK1tbJ/e6aSWI/
	BSPEdlMX/LxcB9V8efq7Q7ZSQIZRDCse4kdIOlR8v4u9WMJlWapIi517AxxglOADbwkcWfTmKYb
	ZjRkssKzOyPrp+qIuj/Ff80vxwLeIA7wFfsfCtyKp4QCPbbGPme0dPskEuWOp4R0Zw4jfv0UmaA
	HwYQn35G4UoCuxt8MUMmORWhqIockEyURIasIZR3qN4H0Ym4gToyNCsyw9gGy6pqed9tZReIozO
	7N2Zd2FMYyuzYDBr79UUo0TUUg7hufVc4QfJoI/p0mKMcYEPU6+uBSd3qHwzyLbJSi8MysIZRtF
	aNVPOvd5eIroJ1VbxY3B7gvo3VIIyDvt+8ywB/fpFSFGn/l06/PXIoE7FitKExMTwmIh+BUc=
X-Google-Smtp-Source: AGHT+IEKq9+eEVVyjxgPcBMRnLz9mjbzHqV86DqOgNty+0gikfAgM6ne05GzgqeKhk3hSUsJvOF/QA==
X-Received: by 2002:a17:903:2345:b0:23c:7c59:c74e with SMTP id d9443c01a7336-23fb2f04695mr17927495ad.0.1753435161713;
        Fri, 25 Jul 2025 02:19:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dc0b2sm33240835ad.132.2025.07.25.02.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:19:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8cf89734-0663-4453-a079-8bdf40625746@roeck-us.net>
Date: Fri, 25 Jul 2025 02:19:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c: fix module_i3c_i2c_driver() with I3C=n
To: Arnd Bergmann <arnd@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250725090609.2456262-1-arnd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250725090609.2456262-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 02:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_I3C is disabled and the i3c_i2c_driver_register() happens
> to not be inlined, any driver calling it still references the i3c_driver
> instance, which then causes a link failure:
> 
> x86_64-linux-ld: drivers/hwmon/lm75.o: in function `lm75_i3c_reg_read':
> lm75.c:(.text+0xc61): undefined reference to `i3cdev_to_dev'
> x86_64-linux-ld: lm75.c:(.text+0xd25): undefined reference to `i3c_device_do_priv_xfers'
> x86_64-linux-ld: lm75.c:(.text+0xdd8): undefined reference to `i3c_device_do_priv_xfers'
> 
> This issue was part of the original i3c code, but only now caused problems
> when i3c support got added to lm75.
> 
> Change the 'inline' annotations in the header to '__always_inline' to
> ensure that the dead-code-elimination pass in the compiler can optimize
> it out as intended.
> 
> Fixes: 6071d10413ff ("hwmon: (lm75) add I3C support for P3T1755")
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/linux/i3c/device.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index b674f64d0822..7f136de4b73e 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -245,7 +245,7 @@ void i3c_driver_unregister(struct i3c_driver *drv);
>    *
>    * Return: 0 if both registrations succeeds, a negative error code otherwise.
>    */
> -static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
> +static __always_inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
>   					  struct i2c_driver *i2cdrv)
>   {
>   	int ret;
> @@ -270,7 +270,7 @@ static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
>    * Note that when CONFIG_I3C is not enabled, this function only unregisters the
>    * @i2cdrv.
>    */
> -static inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
> +static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
>   					     struct i2c_driver *i2cdrv)
>   {
>   	if (IS_ENABLED(CONFIG_I3C))


