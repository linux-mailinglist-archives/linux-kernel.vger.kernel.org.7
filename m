Return-Path: <linux-kernel+bounces-876810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBA9C1C682
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCC189D498
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7334DCE0;
	Wed, 29 Oct 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg4Y5Fqu"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E32D94B5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758374; cv=none; b=so7Vy7QCDC4TWllnfHrg+eUDi8wbOCLI24AkhsVI+7uyZWkwFc06FjRZ8oel0Aru08dwlFMWp9DF/YPG+E7E32eIinEhU/0ZP5jKLCNelueYFI8ndENdfRX4IhXSimfscdB+KTHsoyTgWwSOuHI404xNzE8tQE8sy9XD71dKIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758374; c=relaxed/simple;
	bh=uC9UtG1Fr3nkcml/pRdAfhXZa8c/EgGRc1KcEkhsiPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYa7v07zJwjS8eleV+LcO3yeuMy1wUUeqyNcFhwFRTKreVT2BC/U0VF4qBAnowF15PO1BmnbbAqvT9xDmUPmq6lxv5wpLyMdUI2SOsL613srfoo5KoJla+9eTOdeOjt91CH9/3xMJvJkI6Qi8vswV2jMxtN7NqMh5Warzx8SIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg4Y5Fqu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so234899b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761758372; x=1762363172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCQGHjv2L44j3MTwWgphNqvwmgFbsURD1Ek139X5tpY=;
        b=Eg4Y5FqupsHMH+sAHutea09YggvUzXDUMSN0TGglaS0+K3nPBRitT1NL4xOdLkdS8E
         fH5jv28Y3wDN8zRWhwkRC14gH7KKCElxrUUvlovnqYJLXlkSZf69yaC1FBSTK3QIAPCd
         xU228LMNk5xuIuO4qMQo041MLdxCfICgh95EjVFjJyPfbXjXslVv+RXDtvS8mV2HI4I5
         HVHnHCyfm9HeZ47pXqXJHD1hkqMsoHzFnkRyFU/R+HpDTRMjNlxPEqqJCH8vYZBZN2jr
         14Nbv23e1XpT4i/9hJEhKPucriMzFiZFJoUpeXIdwCU5TQHmZDAouDlClP1/qULNY/kR
         jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758372; x=1762363172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCQGHjv2L44j3MTwWgphNqvwmgFbsURD1Ek139X5tpY=;
        b=PAV2jbkMX9OjyxadjzefzdcKiLskjanI0RAFO27ZbpwOI7WyZK0r8kf//YllF7hEfQ
         ykjoom5kwSevLdZ0WoTsGBBwrvEC+IdOkhr5PFhJa5nnXfWdTXushJetSdE89SXYMyi1
         DKIY9toCP8jhZOl/1QDRkjnuvQehe38o620ZxTkww2Okb7U5ib9rgCGXcmndAnMSsrXg
         89oRYAJqBQdCEyojS+nGgvgL4Y2aoNWex9gjIo2e06qmgKqKiiCaxFomI4YbI6qbSP19
         crsba5Ra695EU/1RhXDXwcUagJbZXAiiVqIWvI2oVCUW3N1mnz7tFy+AcoivjBWLB0xM
         WzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9wGjNpgDGycKcXUiLHEzEEUBui9ImwEUJsLHJrLRLhDCn5skW02KGnz6ghErGgxl+MPQhjL0eFgUdBSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcfn8AZFaeaHEy5bbPZ3u/rnnO+lixBTuKH3SJn6mHr6qQf8bp
	hRb/1r7DZMPP1NDOEkYDEJPN08FjAfO0LVEW+e2e4RaPFntdL10zhFI5
X-Gm-Gg: ASbGnculHRMdzkRc7bgy/y6Ryg4nLVdkvLV2OnpZWgfP91PJoZHs8YnTiyTdCpQGhLO
	CJTocHYSuTrhONRILCCGOqQndy6pxMr95C7aksmnGN5b76NIi9nnNzotczP0WEZTwfz9LJPBYjL
	LA6z/3Ejw/dNVVbhmWXOAFiwIA7y1KFK/Vt3iWd83+2s6j7oS0jQN7VuK1dgKf6suqknlGqBkUG
	OluVoxrsekDILz8V/+BW7vajmQTaimjKfyFQI05fLeOTk8jrOuNwb4FU/J/wZv709LVn8NlfCm4
	v//sXlvQhfZx9NGg+2b8VJqCFPvR36Bg7tcC0Ie+iLf53jzLO5yK7rk0JMylpWCmUG1NjPWqON3
	zfyvTQUTbwWjlTJ+n70xQ8LyFnEsSRI3Vr3W0G3twgPvfR3ImOBotZAJwTnnsbaVfCMT+ftlX4q
	ADZhERx6ZFwwK47S/MGIQn
X-Google-Smtp-Source: AGHT+IGhZQVt8RAWqegksuHsY2aWHJeEyR48Taz4SwETmTmkW3PRPM7LH76hMjd7YkUyKwNfMhXirw==
X-Received: by 2002:aa7:9902:0:b0:7a5:396d:76c4 with SMTP id d2e1a72fcca58-7a5396d7d74mr2196746b3a.23.1761758372250;
        Wed, 29 Oct 2025 10:19:32 -0700 (PDT)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a414032c71sm16054214b3a.25.2025.10.29.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:19:31 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:20:42 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: mpl3115: add ctrl_reg4 to mpl3115_data
Message-ID: <aQJM6u9pGSdds0X3@debian-BULLSEYE-live-builder-AMD64>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028213351.77368-2-apokusinski01@gmail.com>

Hi Antoni,

The patch itself looks good to me.
I just wonder if it would make more sense to squash it with patch 2 since part
of the code here is changed again in that patch (the mpl3115_set_trigger_state()).

On 10/28, Antoni Pokusinski wrote:
> Cache the value of CTRL_REG4 in the mpl3115_data structure. This is a
> preparation for adding support for the threshold events.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index c212dfdf59ff..4cc103e20a39 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -83,6 +83,7 @@ struct mpl3115_data {
>  	struct iio_trigger *drdy_trig;
>  	struct mutex lock;
>  	u8 ctrl_reg1;
> +	u8 ctrl_reg4;
I think this ...

>  };
>  
>  enum mpl3115_irq_pin {
> @@ -376,6 +377,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
>  		goto reg1_cleanup;
>  
>  	data->ctrl_reg1 = ctrl_reg1;
> +	data->ctrl_reg4 = ctrl_reg4;
>  
>  	return 0;
>  
> @@ -390,12 +392,15 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mpl3115_data *data = iio_priv(indio_dev);
>  	u8 ctrl_reg1 = data->ctrl_reg1;
> -	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
> +	u8 ctrl_reg4 = data->ctrl_reg4;
and also this is changed again in patch 2.

I don't see much advantage in having it separated from patch 2.
Might be simpler to just squash patch 1 and 2.
>  
> -	if (state)
> +	if (state) {
>  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> -	else
> +		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
> +	} else {
>  		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> +		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> +	}
>  
>  	guard(mutex)(&data->lock);
>  
> -- 
> 2.25.1
> 

