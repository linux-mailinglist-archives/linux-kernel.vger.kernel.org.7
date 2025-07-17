Return-Path: <linux-kernel+bounces-735790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9389B093EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341AB179BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8992FE394;
	Thu, 17 Jul 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wgponx94"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D8298CA1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776962; cv=none; b=frsb6Cgj/k6ihvwymIwWBtAKwlRc9ZC993TMiDP4k7AkbnfF+9DE7XMZ/xjTIoqno5sjgQ4Y8lcbvjq+JlmZZ7zLxORBGrkIuhh4LlwkhY8N454pqk6kAUkk7gTc4yaoJUdCBPC3DIwoPAxfcICubs/tXbQAWyhqAsNLrab5UEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776962; c=relaxed/simple;
	bh=s9KWXPuVzpechZ9wxE9UyrtfQwW4ldRnELbyV9NeSmk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8nBWjvIlYHHrS2Z8xxaPUZlBLH13xd55MxMYBjmSjQ+dVyc4YmnxDi4EgaKUFQzBLeWQhxIuDyuwC0lpuZr5lr6tEf3111VfeNjYU99K8cvPq1BQ7Nz+iolQyL/Op7OX4Tqx6WudAbBJS23/yNltOUhejASq8hahV39rNPIa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wgponx94; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0dad3a179so204815366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752776958; x=1753381758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnPkrh7Td7OEqLas58nLl+SzPw9IrgLbf6OBLnf7ieU=;
        b=Wgponx94IVcLmImZI3t48Xwh0WEHCV5aOOSH6QD4QBCxDQSHLiDmg+o3upbVHdQaH4
         /WPzuWFxP+n2UBeJOZVFbo2Hb5sQO11yq2n7Em397/NKyyA0bS1MO9SFYtratBkPY+Zg
         z+9oZOqua8WLqEou/+rUTLUiDqQ/tzWwoZ3gUnKaGopNmyhz79vEVFTNyM9h9WdBFg0W
         gdqWg0gLOUoojNFbKCzVnX3pnA9XhsEe0iQYZH2579UoDa6nQ2IQG5OwgBdBoUbTkUWf
         /g2iP4OIIAe2QKAIxQSms/5Xfz6QsVB5UwTMihE11jGKbxNfPnKORI/sAhnRthmKrIDL
         HSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752776958; x=1753381758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnPkrh7Td7OEqLas58nLl+SzPw9IrgLbf6OBLnf7ieU=;
        b=Tr0HV/m00RNb8iP3EOt1Dt8Jx81dIarKKUxeT9j+heY9Q8yKnuuYNAI/6phccK0mqp
         XYndtoM68FZRXJZjb8mkv438WbnfWOq4X9MDjUeYS76vjEWiJ2Dm/fuYMqZl268VPQ3F
         mIXJYq8QzUz8zMQLSFJK2uT7Fsxr3aNgs4lfS4YoET5BidxCRkQcI1HXo1i4rwRb/1xv
         oTTkRgZy7koXdPf7RESZKCeb9sscar9cIJvwaJGKKSYmJRkvB2P8FJaV8DT70gVTjhC3
         ZEso5O9KMbCaI/PLC31IV31Hwl4X990UyukNlgPcmWnt87xa0H2mQ7r+iIRpDu9kJipw
         dptw==
X-Forwarded-Encrypted: i=1; AJvYcCUhAAmcRO91BKg6oF1i9oQ9JPziSr4IU+4vYxpDc/MPZMtDDH4W3bUyYFI0Z2TDfXIArmDAMe2cLIdrNqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroLpspnh9ImBLfufQQnYUYv3wTYa4PJNBGx84dJ6UQBdevdCX
	pbARj3ZUCUkLc9xLZqEIbiV71LmIxeCE98s6cPeh3Su1kUOW7BHS5NqqqLfizso3EVM=
X-Gm-Gg: ASbGncughRS5+0714UVd8t5APAgVJSBarvYAANI1U5kaJZXqrL+eud4dJD8o/PUOryl
	S2tY4x1QctDLdUzauTD2Y0VxD4PmB9gf2yp5IB2kChLTeT7WSJoCy+V6KMoKKULiydVbebavXiR
	lJXUX+qpmgxouI0j77PTbQgGaqSLHftwd5ZpBLhh3Rmqr+QpnLuyfHYNTDVXVUE956XpYnmXlWk
	cL5GfRgaL3jNimPCkz8jg2RCCsYId1QGy+Rv70sl1752aDobYDxrDV5pbxc2dt5eqMicZqN6rBx
	0Mo7u6rYHN4/hO6AkKfrXTSkZsE6Etbk6XniXtUNtWxPbprTiCqOQ37kw+WdzWnd/QsAlSX4u7J
	/9Y9wUk+hxDahkf9VEbGfQ+gJL1/v97VFHVNbU/G3CaASlnXbUUqRC+1MOyUbH2eIX/iP
X-Google-Smtp-Source: AGHT+IGIlkOCc+got8eZilH4YkyOZ7M6w9t9HW09vMz5wIZRJ5qB6YDgMTRbE0xwRMu3XsZ1b/Gu9g==
X-Received: by 2002:a17:907:d582:b0:ae3:f28c:753e with SMTP id a640c23a62f3a-aec4fa45ab9mr359310766b.8.1752776957828;
        Thu, 17 Jul 2025 11:29:17 -0700 (PDT)
Received: from localhost (host-79-47-155-191.retail.telecomitalia.it. [79.47.155.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae98d9361c6sm961490066b.66.2025.07.17.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:29:17 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 17 Jul 2025 20:31:01 +0200
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH] pinctrl: rp1: use new GPIO line value setter
 callbacks
Message-ID: <aHlBZftbEphBYC83@apocalypse>
References: <20250717131349.54074-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717131349.54074-1-brgl@bgdev.pl>

Hi Bartosz,

On 15:13 Thu 17 Jul     , Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Resending with linux-gpio correctly in Cc.
> 
> Another driver we missed, that should be the last one under
> drivers/pinctrl/.
> 
>  drivers/pinctrl/pinctrl-rp1.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
> index d300f28c52cd..6080b57a5d87 100644
> --- a/drivers/pinctrl/pinctrl-rp1.c
> +++ b/drivers/pinctrl/pinctrl-rp1.c
> @@ -779,12 +779,14 @@ static int rp1_gpio_get(struct gpio_chip *chip, unsigned int offset)
>  	return ret;
>  }
>  
> -static void rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +static int rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
>  {
>  	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
>  
>  	if (pin)
>  		rp1_set_value(pin, value);
> +
> +	return 0;
>  }
>  
>  static int rp1_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> @@ -849,7 +851,7 @@ static const struct gpio_chip rp1_gpio_chip = {
>  	.direction_output = rp1_gpio_direction_output,
>  	.get_direction = rp1_gpio_get_direction,
>  	.get = rp1_gpio_get,
> -	.set = rp1_gpio_set,
> +	.set_rv = rp1_gpio_set,
>  	.base = -1,
>  	.set_config = rp1_gpio_set_config,
>  	.ngpio = RP1_NUM_GPIOS,
> -- 
> 2.48.1
>

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>

