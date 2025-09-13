Return-Path: <linux-kernel+bounces-814956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83843B55B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BB95626D5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC556BB5B;
	Sat, 13 Sep 2025 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="KhjvS34z"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DA3C33
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724376; cv=none; b=DBDoboA1lp91lycadc/D90EmxG9ve3lFaMG7ZTw6PnM+FDrMMgRRcL/ia0MvUr2/mG8eoi83Xv5gF6cL7lCmVOvnQu2OFdn3XQ+jJFsLKHlOb+bx8dgRjU4mXjjMKwlsE+RAYe954n0giMJy2wuZH4bNxwwTuSCr+zLw5FDYAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724376; c=relaxed/simple;
	bh=akUfeAAylR4EGyDlpaAVA7KbTqLrX6ucdpKbIQvNUvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtWj4m0gtgvXIXoVcLGbSTc1tjikzBgkWwLwCeJSBXBdMKC989/iRqGt4R1xtHHquqeAcsloVN912pFxBsZgRJnHyf99OfPqWSJWJMh/lbka28vfZMBAb5L7GF+Y50h66Sc/Gj7hgPipgnZV+1HKr7YsuhJOcJRtMKJHrWipKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=KhjvS34z; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5241e51764so1783137a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1757724374; x=1758329174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y1rAyo0wYKz4qhM+kpJJzKO3IkA7FwTREfOLXkFqC+k=;
        b=KhjvS34zI+GcCf64gWCiWFseNfwQXvcmSoc0EGu1w6jMug1/YOSgom7Ilmb5XsvCFe
         9UEv2KLhlLpiqdFJXtlx1uaAbfStSdJgsbjmO55F3jJhHf0GZOBXAelmymvZKDaOauVd
         DnicSisYcFeVlx2336UNEsJ1TAqU1FGBQksH9TqJh3W+ShEOLRjHXRmw0NOgJ9Mz8XkA
         psy+yCvrod50D71r5gm4welJtCD5kgenard8rcDNj4a2EMI43IZKv0GD8QFnzO3iA7NQ
         b08RQ8CjkURYGcyci+0If0Ww5xiDj9wTdgiUE0xyDamGJCGp0g9JoNuANnCUBBQdaBJ1
         aLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724374; x=1758329174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1rAyo0wYKz4qhM+kpJJzKO3IkA7FwTREfOLXkFqC+k=;
        b=Mi+csfyNF44vsd7vVM/Tj87HNqP5aBCxYsTI/WwAWvmn+TlzBJypCgGyoPLbnrCwAu
         fYMVl+OCKnCMGlBxwQT92pxbZ5zjt+DKED3X2teR3qjt6F+Q5L1AEkOz7J8OSO26gKz3
         ngPhOJWlJZpdp9u3zFPRN9JwqD11Lh5G42FX5X8PauBtYlTJF5IuiZPXg3+wkegnQPgh
         nYhPxtiWf2bLugR55/xl56Pnue+TYyP8DH+Afpv3DkQnnJs7glPtWKSh18aqDQOC0NfP
         7ffL9BOlPgmDQAI9GiPHLtFur7ZnCAiQjGbyHAMqb/bo3UPxBT1EPiw4aFJzTLyJ870j
         gLjA==
X-Forwarded-Encrypted: i=1; AJvYcCWEx8lNs0EXlFxOlPyKzX1GNfdUWl6Xg8qUSQSTyrvUwaoil2ejgLe0eHBT+PkVUZf5N/u7musw8gExMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXy7W4seCny9krm/9MJAaFWZ239U6gGyyvRv7BMEAtcb4HQtM0
	awme9VMs23gEbmRCTg5xdddwlcdpgp8JW4plK4g/CpU6cp/eKFwJFo6p0Up9jzr3UZ5VjwJ8For
	rNSck
X-Gm-Gg: ASbGncs29YWeA2Hl3BlnMS20f4lHYmBgNELAzAX9gZup2yb5t5d/5DSr3ksSkxqCBNh
	W0azcNflN07GPCgfvk3F97wT9+3iIHzlJbXyP9SMyCtuLbgnY7Mc54AZxDIz6G+BOiRR7FbSeK6
	6jblSTT9ROszVzEZIXqea5cOVfaQJBiB0eTzPeRLyGA54jkWls9CqDqbtOZx+ZJXutZu+qAwGg5
	A10kA8C6fzKeZ53mIMpeLKV2R0MsJziv8dKgIEvgkiKw36IrbjsR6Vve0FkTf11bPgxmBMos2lt
	NKGmdl6nWJRMW98/B1qIICW1PKDmhn4cxTxseAo8k9weuWnE/C9v36zbqgaRJNGv7yRtfSwYeH7
	me8k+xs512EJ9lAxg6fuBHQ++
X-Google-Smtp-Source: AGHT+IHMBcbueSicxR/8Vx8AuBr3VH7T7SswkJLlw1PiFiO49urRgXzVoKF+OSucjZhbIyJT/Kwvwg==
X-Received: by 2002:a05:6a20:1590:b0:246:3a6:3e5e with SMTP id adf61e73a8af0-2602cd19bc3mr6462974637.54.1757724374277;
        Fri, 12 Sep 2025 17:46:14 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793be6csm6786234b3a.14.2025.09.12.17.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 17:46:13 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:46:11 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
Message-ID: <aMS-09x_YTV75r0n@mozart.vkv.me>
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>

On Friday 09/12 at 22:18 +0200, Sébastien Szymanski wrote:
> Since commit 7c010d463372 ("gpiolib: acpi: Make sure we fill struct
> acpi_gpio_info"), uninitialized acpi_gpio_info struct are passed to
> __acpi_find_gpio() and later in the call stack info->quirks is used in
> acpi_populate_gpio_lookup. This breaks the i2c_hid_cpi driver:
> 
> [   58.122916] i2c_hid_acpi i2c-UNIW0001:00: HID over i2c has not been provided an Int IRQ
> [   58.123097] i2c_hid_acpi i2c-UNIW0001:00: probe with driver i2c_hid_acpi failed with error -22
> 
> Fix this by initializing the acpi_gpio_info pass to __acpi_find_gpio()
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220388
> Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Thanks Sébastien. This fixes the touchpad on my XPS 9340.

If you want it:

Tested-By: Calvin Owens <calvin@wbinvd.org>

> ---
>  drivers/gpio/gpiolib-acpi-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 12b24a717e43f17621c054bfc4e9c2e287236d8c..d11bcaf1ae88421e5e5a11a2ba94983f437c413a 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -942,7 +942,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  {
>  	struct acpi_device *adev = to_acpi_device_node(fwnode);
>  	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
> -	struct acpi_gpio_info info;
> +	struct acpi_gpio_info info = {};
>  	struct gpio_desc *desc;
>  
>  	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
> @@ -992,7 +992,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
>  	int ret;
>  
>  	for (i = 0, idx = 0; idx <= index; i++) {
> -		struct acpi_gpio_info info;
> +		struct acpi_gpio_info info = {};
>  		struct gpio_desc *desc;
>  
>  		/* Ignore -EPROBE_DEFER, it only matters if idx matches */
> 
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20250912-gpiolib-acpi-fix-7ee492ebd5e8
> 
> Best regards,
> -- 
> Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> 

