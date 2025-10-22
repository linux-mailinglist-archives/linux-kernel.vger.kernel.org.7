Return-Path: <linux-kernel+bounces-864883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4CBFBC46
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82675649B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EB33F8C1;
	Wed, 22 Oct 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9VfQHEW"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459830506E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134638; cv=none; b=IPsBVpOCA4OyKSsP79ossAykc7XEbwCu8VoIbADhUlDXm9kjJTS+s+uapqhK4WvK9AFNbQhPi4t1TjvwyXMImnR2LzQRoWqibkCqA3c1V60ocy0pjeA/cqJK5n15sxJ/nNN9GbGcZF7pcDgi2C1ZX3NVXTrOJMDxBaEJCN+SV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134638; c=relaxed/simple;
	bh=8W+Za/KxMR88fWOdm57Y/SPii666pZtp6nVguDm2GTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmvS047uhoqsGYOBOcXVxwfClCVOsErLhcMq6nAdZ2k4s6pc20PAAoxsWF619n5ND7l07lWp2dtq5Fx34RbGJY7/gGs+m1JstR3UyjlehDJNsgtVsYV2k16tJfbMp5hLeI2fkgZCDadldnW1pyT9J1xnSnlCFmqHLm/GJOaepxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9VfQHEW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471131d6121so51628105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761134635; x=1761739435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0gYph7SovwhcGw7EVJ3qVkwV+hfXw0N2ivsENsGig4=;
        b=a9VfQHEWZFJmpSmAfHbDxw9JsFriTyDDzqLmOybF1mXqbidU+j1HAo64mU0cbEhIKX
         eTuhHLNt4WsKDqWsVD9/W5tir6x4jKgO/z+OgGDMCczn14ptatjOt7Pfa/faalqvVBFo
         K98LQHUanH4xQxYYhAQMa441r7ncrBKZLt+oOiaQkL7alojnKeIOjPEUpwA+75SDm+gt
         9wrlC2Ybnd2XLq57ZUuHYbZQXJr6oPsMG+nO9C5SqMC1OYMAr/dR8eBvqGOWC7YNSRZX
         t6C22HXhRveYRaO9y1lYsj4fbiwTeKbUGa9502of+So+Emi9wlLNpt16i05y0VnG1VFT
         FFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134635; x=1761739435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0gYph7SovwhcGw7EVJ3qVkwV+hfXw0N2ivsENsGig4=;
        b=n69WlJy4UVlqDwBI5F5pDkVniQksZpSWVnX/5GYlFzH7S9ROEseHO0odns/Lyrkjwp
         rmoVFtbEgujRiy6YShq8LPOPFfElfITjPbA6XaJ5b2drV8pQPBjQq1cgWrFjlYSiifpY
         N/UhenQbmOefLNSvhTJMKzUyxvWgjJRwd5Poxe6/G+/kki1qY3RYB7/IYiNIsy/7I5uc
         uDsr0KaWRN6/mLIVEEDxUgyw6nJ/Zii1CtH/6P88+geOpLLzRiEbEyHSroactyzcDZ6k
         Ig2FhOahZCHRklC5TdMlVXVsDY1VwNjIgfjHhoAE70241U1vHlnJBbh2nw40EVNcXsuk
         1W6w==
X-Forwarded-Encrypted: i=1; AJvYcCWOQEIqU+EtA7IV1N53NXX1OE3nyisqOH3KSxfepTwyHeJj3lmjaBsiz6jvd5dfnqj6e34due/xNWoZA7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlVIqs/nL0G+fxynEDyf4o5FTsqvYH4AO3HN7n7kJJw1qEigP
	TogG30oW7AKUU7oYWdqQTtZlvkvF7c9VbskQ85d7Y1z0FUARle/xU4MgdCPtr01LPK4iqxkYx82
	XjNDX
X-Gm-Gg: ASbGncv0HWdiYlSgT2mKdGzdL8dcKpqwHFp6EAjmDW15Io3NBR1xQd2XuY+KpviAfAL
	IXtfIGq2/qJ/93fuCaMT0+GWshboggCGLR0PPUbWcQyVcvjAqY1Wfj4rJEUoZ8rg/zQaJkw30IC
	EkCMF+rP5W8tyOy7a56ICqnJ6WERFV7hi6prMmrj0GMNT+Pg4QaxaCr1aFPrKEWGZIlBjHPqkRF
	4SEZnnycWdtgvsBpxXAtF7iQrdr11vZcBEfVHwvyeuFEpGTptxYcxvgkGEcbs7EQk/IFe2/Lhri
	uv/IZVqynERJ3m6CGpdH5PMARYmkDFqYRnv6TflevkmTmr4uy+ROsnEWJ0VZNKoey/S46EcNbOO
	CfRQa1+IocrugJe9vwIu7YqkagmWCZuhFVKV3hJIyqaeTWXdahjJdEg02xz6uQ5ykiSsl+kjBCg
	DcCO6Z+szFO9LkENBD
X-Google-Smtp-Source: AGHT+IEY2TgyTGfGNhNiFczm1vB6rimaMhMz5RZu+zN6ZnmkRbUDl8IcuOYqyXEzu158hZENQ3zc/A==
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id 5b1f17b1804b1-4711787750dmr137799265e9.14.1761134634976;
        Wed, 22 Oct 2025 05:03:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c41ca845sm42531015e9.0.2025.10.22.05.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:03:54 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:03:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Robert Nelson <robertcnelson@beagleboard.org>,
	Dhruva Gole <d-gole@ti.com>, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fw-download: Fix find firmware req
Message-ID: <aPjIJw3ahPxnDE5Q@stanley.mountain>
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>

On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
> diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
> index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
> --- a/drivers/staging/greybus/fw-download.c
> +++ b/drivers/staging/greybus/fw-download.c
> @@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
>  
>  /* This returns path of the firmware blob on the disk */
>  static struct fw_request *find_firmware(struct fw_download *fw_download,
> -					const char *tag)
> +					const char *tag, const char *format)
>  {
>  	struct gb_interface *intf = fw_download->connection->bundle->intf;
>  	struct fw_request *fw_req;
> @@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
>  	}
>  	fw_req->firmware_id = ret;
>  
> -	snprintf(fw_req->name, sizeof(fw_req->name),
> -		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
> -		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> -		 intf->vendor_id, intf->product_id, tag);
> +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {

Change this to:

	if (format[0] == '\0') {

In the caller, the assumption that format is at least
GB_FIRMWARE_FORMAT_MAX_SIZE makes sense but in this function it
doesn't make sense.


> +		snprintf(fw_req->name, sizeof(fw_req->name),
> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> +			 intf->vendor_id, intf->product_id, tag);
> +	} else {
> +		snprintf(fw_req->name, sizeof(fw_req->name),
> +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
> +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> +			 intf->vendor_id, intf->product_id, tag, format);
> +	}
>  
>  	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
>  		 fw_req->name);
> @@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
>  	struct gb_fw_download_find_firmware_request *request;
>  	struct gb_fw_download_find_firmware_response *response;
>  	struct fw_request *fw_req;
> -	const char *tag;
> +	const char *tag, *format;
>  
>  	if (op->request->payload_size != sizeof(*request)) {
>  		dev_err(fw_download->parent,

We have changed the sizeof(*request) but we haven't changed
->payload_size so how can this ever be true?  Did you test this change?

regards,
dan carpenter


