Return-Path: <linux-kernel+bounces-840745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63557BB5222
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF8B34E34FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30346260583;
	Thu,  2 Oct 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VY4r5nAj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6879239E65
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437261; cv=none; b=Sgwkw43yJAFx0kyG9IkqLw1QYKI/Ro4MDoBpfnT9wDjv8zwTxooU1op5DcS7Gzp7UtN/r99CTnGjh+En1WcMGdG3+4d0L72c+5JvMqyxFmyWZ7BY+8Twb8RiFZuG0wXLf/aaVJNFV7D6NoHnJrf9oShKyodDSChDi8gWGP0lt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437261; c=relaxed/simple;
	bh=UFht+P1o0k8Q+RYtLVZ2D9q+Octvm53w5gp3kes5Nq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Hht2LE/wx9kPiwZZaMLwbbdSGKBJgzUNNj71/waiHERuRb+5TA98UueMEtb/VjgqxKCSfj2p0Irxaz5UYdzkxGOs+Q1tTaBEuRcCmntUgoXWJoMm2sUzV+g+c3EprqS6grp2YQzg7921sLbTIXV8DoTW8UtOCiUwI293QWA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VY4r5nAj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so14516715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759437258; x=1760042058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8GRSdYcGt/dB2sri1422IZPPC5ZRlc8SsQOJHCd9NY=;
        b=VY4r5nAjuFUbZhRowr2+5wcQeYZ/FLPkMdE1EHgRYHsHB/yy85xreZdbBHTWt8gzSH
         J5lijajjh0W2TRr0P0vFvP1jCqvKynN/S45xMGHURS4u1c4Uk28yfK8cDNhyYfK0YAJm
         PRMcJW1Lz+Vxpa/ijDWuGreWfOxeI/GxlFMwz/t8FGlDtwHany6Z3xVNPB2xHkGqQf+b
         FjXgKxfad3rbZb57ndoCfwc62KMPMcbXeXg7abA5Gb+MOL3GogWTbp1ALIK+TfrOtQe7
         WcmD1GRet8VOUp0jLQygklxo9AI6e40oiCBxVb8E62z0fyTwo5u+LSyMd2MnGPrRW0KC
         sGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437258; x=1760042058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8GRSdYcGt/dB2sri1422IZPPC5ZRlc8SsQOJHCd9NY=;
        b=dymAFK6u5zp+43Zp3mNqqz8oHg2F9nHSR0fvV3r05/sySgofwJpZxUdV+AaKdaRave
         VuwSxYYMrBpP6dZlL6Epgg6CG5VpxTC8RheveAEu490sLYJYS+rqOqXPXY9PZeY/Pl+r
         7H3+WwkrkfLQ7tuJd3gDZqS98obegIpnGej5Nkx0pKgAxM9de9hg0ofOC4VHyv/H/pYk
         QwbPwvP1TPS/qI8Tde+i0KL2k6whTrnOwtGrubUNB6pADc8YJDiTQKeFSSYesq6tosSJ
         8hyS1KbFFSFK9CfH5lR9TFbxM0b7iBfZSjfQQBPUqF45RMfq3ykq1A4wlFeDhrNo0EuT
         Ra5g==
X-Gm-Message-State: AOJu0YxSkkIRml77HxkNCOWOdkwIapaHo2wM1ESBTJwDXKCOPmrSvEmq
	YmRmPFghbGjT9WSvZLshN/aVWfLURok9Sd9OGj6oqekfryP+McKY1qUekUQCHtYd/7A=
X-Gm-Gg: ASbGncsv2qToFO3m4Q0uvFb6v5iHkkchEIIarfv02U3XrfLOucdw4xongIEv1avzgLA
	Qk9K/VZLoyHffPOgq79NBzJtqklTBZdceQ94gzDKHi7SN8foLOh8v0snDq5/hYZ+xGtV8Gzj4to
	HC0BosY3XnKgEQFPRSv4Qh5nf4FePQTvgG86lcxeqLYjkCbQVDFN3LpoEqWgCo8QIWXG5SzylTK
	a3fw1kNSmI8Z53M1l5OyMn6n5S5F6FPtR/71WRSzk3/jbipzB0UL/LAofp9+pLc12VO1lruqkQe
	GEPLlTfmsUo9x9ltmeo65xEUU7IY7pNwkhzy7OmMs0ND4PlKQOLUx3XJVcxwOh+VX80MS7m9HE/
	FjzcGyuERAnzOHb4k0Ff67d7dM2wQ+laLoPER8hgc99dyOMp6/E3tIMWO
X-Google-Smtp-Source: AGHT+IFN8bz+lbJg47w/J96bwFKw4CLz2HVr4Ej5ANcyT5HseU9KMrJXqiS3iYm/H5ehR4LOqETc+Q==
X-Received: by 2002:a05:600c:c4aa:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46e7110498dmr4309565e9.9.1759437257834;
        Thu, 02 Oct 2025 13:34:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e693c33adsm46836855e9.18.2025.10.02.13.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:34:17 -0700 (PDT)
Date: Thu, 2 Oct 2025 23:34:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: linux-kernel@vger.kernel.org, tzungbi@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/4] gpio: mpsse: add quirk support
Message-ID: <aN7hxUz7TGG38Hv_@stanley.mountain>
References: <20251002181136.3546798-1-mstrodl@csh.rit.edu>
 <20251002181136.3546798-4-mstrodl@csh.rit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002181136.3546798-4-mstrodl@csh.rit.edu>

On Thu, Oct 02, 2025 at 02:11:35PM -0400, Mary Strodl wrote:
> Builds out a facility for specifying compatible lines directions and
> labels for MPSSE-based devices.
> 
> * dir_in/out are bitmask of lines that can go in/out. 0 means
>   compatible, 1 means incompatible. This is convenient, because it means
>   if the struct is zeroed out, it supports all pins.

What?  No, please make 1 be supported and 0 be not supported.  This
really weirded me out when I read the code.  If it were just 1 for
true and 0 for false a lot of comments regarding dir_in/out could be
removed because the code would be straight forward.

You can easily set everything to 1 by assigning -1 or using memset().

> * names is an array of line names which will be exposed to userspace.
> 
> Also changes the chip label format to include some more useful
> information about the device to help identify it from userspace.
> 
> Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>
> ---
>  drivers/gpio/gpio-mpsse.c | 109 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 106 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
> index 6ec940f6b371..c2a344488a23 100644
> --- a/drivers/gpio/gpio-mpsse.c
> +++ b/drivers/gpio/gpio-mpsse.c
> @@ -29,6 +29,9 @@ struct mpsse_priv {
>  	u8 gpio_outputs[2];	     /* Output states for GPIOs [L, H] */
>  	u8 gpio_dir[2];		     /* Directions for GPIOs [L, H] */
>  
> +	unsigned long dir_in;        /* Bitmask of valid input pins  */
> +	unsigned long dir_out;       /* Bitmask of valid output pins */
> +
>  	u8 *bulk_in_buf;	     /* Extra recv buffer to grab status bytes */
>  
>  	struct usb_endpoint_descriptor *bulk_in;
> @@ -54,6 +57,14 @@ struct bulk_desc {
>  	int timeout;
>  };
>  
> +#define MPSSE_NGPIO 16
> +
> +struct mpsse_quirk {
> +	const char   *names[MPSSE_NGPIO]; /* Pin names, if applicable     */
> +	unsigned long dir_in;             /* Bitmask of valid input pins  */
> +	unsigned long dir_out;            /* Bitmask of valid output pins */
> +};
> +
>  static const struct usb_device_id gpio_mpsse_table[] = {
>  	{ USB_DEVICE(0x0c52, 0xa064) },   /* SeaLevel Systems, Inc. */
>  	{ }                               /* Terminating entry */
> @@ -171,6 +182,32 @@ static int gpio_mpsse_get_bank(struct mpsse_priv *priv, u8 bank)
>  	return buf;
>  }
>  
> +static int mpsse_ensure_supported(struct gpio_chip *chip,
> +				  unsigned long *mask, int direction)

Just pass mask not a pointer to mask.  It would be different if
you were going to allow more than 32 bits to be set, then we would
need to pass a pointer and use set_bit() etc...

> +{
> +	unsigned long supported, unsupported;
> +	char *type = "input";
> +	struct mpsse_priv *priv = gpiochip_get_data(chip);
> +
> +	supported = priv->dir_in;
> +	if (direction == GPIO_LINE_DIRECTION_OUT) {
> +		supported = priv->dir_out;
> +		type = "output";
> +	}
> +
> +	/* An invalid bit was in the provided mask */
> +	unsupported = *mask & supported;
> +	if (unsupported) {
> +		dev_err(&priv->udev->dev,
> +			"mpsse: GPIO %d doesn't support %s\n",
> +			(int)find_first_bit(&unsupported, sizeof(unsupported) * 8),

Use %lu instead of %d and get rid of the unnecessary cast.

> +			type);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

regards,
dan carpenter


