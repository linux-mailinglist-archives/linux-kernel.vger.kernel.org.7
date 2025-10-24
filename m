Return-Path: <linux-kernel+bounces-868539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DCC056BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F131E1B86E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A789F30CDB5;
	Fri, 24 Oct 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSV9Mx0S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3CE30BB8C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299253; cv=none; b=uzY1SdAtV1wUfEDs7O0hcgarQNqjXPwOsKIhluyRBYrICNCQQspF3f00aTzvs1NPD+UEfip2C+cD9YEMIReJxU/P3lvaus3ivW7lS7td39jWGSeOQ9HfKhBqy9RbOS5mw1Sou68QyyqhJtEsrCZFxNNaQPNQva6CY0FjB0uhr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299253; c=relaxed/simple;
	bh=OVet1b2OltvYAT+J+4amsp/J07NrS8O/OQvynNik4js=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ScQKLh6Wger0X3x4piIO5So88m8YZnLKwRJqRJFN7DMbZQ4lw1CusX6JWN7oX9cZeR/ood/UwUdoXRnNiIqjetyO61sDSYF922BCQ3jtOOl9oRFPebgL3PYsjYMvDhnPwuEM4iUEacJ6itVtA7bizWfr7wfEZHtBqIPaOsk57xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSV9Mx0S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArSephldfLwUPIZOEFTFAJsyT1UDLuvR2xDhoRsVk7I=;
	b=KSV9Mx0SrKbbrcOgf1QxMsH/XXJ+igykpd5DdGA1S7qoAxwI2CWAgh7yO2BV21Mxeb8iLg
	G1Peb0XTEIVua+4yu19KxfCZrzqs2COW3suZqEOyEtcC7dHQI+82ouQRYD6l2f8l2PQ4vJ
	1K1D3IruDXMwND3gJR7Tgku+ziXaRpQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-Ax0VNNvTMDWMzffK7cStgQ-1; Fri, 24 Oct 2025 05:47:27 -0400
X-MC-Unique: Ax0VNNvTMDWMzffK7cStgQ-1
X-Mimecast-MFC-AGG-ID: Ax0VNNvTMDWMzffK7cStgQ_1761299246
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471144baa7eso11202835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299246; x=1761904046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArSephldfLwUPIZOEFTFAJsyT1UDLuvR2xDhoRsVk7I=;
        b=oElk+QiszIi+q7yCK3yVMCUQBNsDA3UjRB+y2bPRgx+v/WwVLpwtUty2pEDiEazKei
         hLgc8WkjDpHHL1ktdXYU7FkgUKwEOFkDyibTOJqyzYEu8Q1dr73+kcjU0/sG2/Md/9ub
         dIjxy9P9fXo2FsWbsWkZz8w5WZLrgWyZM346vjqcdbWzviEt0HXEa6N8sgh4nXvWC3oc
         lg6Q6g9FDtvVw5tcM1cL93aiA7uX23PT9rMHMp1Hif7l7OCsguZ48KHkUD9HrUFufvPs
         3MvpWNKpNFzora3oQ9LYFcXh78jcvElD6//ag8H6CgUi+2Tov7ys5uOktOpeCyvKbmEG
         HrNg==
X-Forwarded-Encrypted: i=1; AJvYcCVKSpJ87VPmnsYKDmWlZZnFHrI+FkZbUFWBywSAHTYq4w/DbdSP3aXBUmMDrn87FL5VVlaoHruHqytfP3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NYmTD7ELu9uMbzsiQPSDfBoS1Tev7eX6F7NtuJZmjqT9nVBH
	ozjgFIXTZilK3qNrfQv/hgzcySG/ws53bru8+YqmzoguXkE5oa2qDZf3qTLpJ3+2OZMLK8XYg5x
	Wpe5F1CziyB1HBhUNwNyKkVn+dFINPNBwH+qfBFYqkOVJ0khQNagXG8PP/EkeVSHksw==
X-Gm-Gg: ASbGnctrP/EwmBtCAe8hX8vBeaF+0wOBqlvR/UotZ/Q8IsmLxxIT9OZIXp11M+bEBYE
	DDsj+wV07kN6+V9ghhUR1eWKryQSK20NNZ561Ix7JZpxAaMO5AotpfKsvdOomy+NxIQBdEnWpaN
	Iq37r8JQwEfrkPR6h3THkmnJJVY2dPSrua3lRrV/0Br4Pv8oKMtFShyv7GPCC+L5kR782HOsTbJ
	arlgZSBwoMtpKC5PDE6jnNLg4rmXUP538W/vn6vrJkS2rBr3rOmQLrJN+/Pz4cEHWKCBheyojG1
	YQULZckB6Av/oN7HsxgSyd4wjw7Xd5Mdw6/ZdOaLq6Jcva65dF0KK8m0qcW2Mj6m53MlTADaf3p
	l1f5XgwormqUR/szyzd+gr83TOl0dPm7KU/vulqeiIYgscVcCs5jnrYK+eA==
X-Received: by 2002:a05:600c:628f:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-475d2e78ebcmr17248055e9.8.1761299246207;
        Fri, 24 Oct 2025 02:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvkiM5n2goHpw250gyY/q1kAO+69ianJVaDlPPHq7N60XvGZtLDRIfaJsJf8t7LldVbkuQMA==
X-Received: by 2002:a05:600c:628f:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-475d2e78ebcmr17247715e9.8.1761299245713;
        Fri, 24 Oct 2025 02:47:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898cce3bsm8302856f8f.38.2025.10.24.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:47:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/5] efi/libstub: gop: Find GOP handle instead of GOP data
In-Reply-To: <20251015160816.525825-3-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-3-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:47:24 +0200
Message-ID: <87wm4k8wcz.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The device handle of the GOP device is required to retrieve the
> correct EDID data. Find the handle instead of the GOP data. Still
> return the GOP data in the function arguments, as we already looked
> it up.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/libstub/gop.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index 3785fb4986b4..fd32be8dd146 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -402,12 +402,13 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
>  	}
>  }
>  
> -static efi_graphics_output_protocol_t *find_gop(unsigned long num,
> -						const efi_handle_t handles[])
> +static efi_handle_t find_handle_with_primary_gop(unsigned long num, const efi_handle_t handles[],
> +						 efi_graphics_output_protocol_t **found_gop)
>  {
>  	efi_graphics_output_protocol_t *first_gop;
> -	efi_handle_t h;
> +	efi_handle_t h, first_gop_handle;
>  
> +	first_gop_handle = NULL;
>  	first_gop = NULL;
>

I think the logic of this function could be simplified if you remove some
of the variables. For example, I don't think you need a fist_gop variable
anymore now that you are passing a found_gop variable as a function param.

>  	for_each_efi_handle(h, handles, num) {
> @@ -442,19 +443,25 @@ static efi_graphics_output_protocol_t *find_gop(unsigned long num,
>  		 */
>  		status = efi_bs_call(handle_protocol, h,
>  				     &EFI_CONSOLE_OUT_DEVICE_GUID, &dummy);
> -		if (status == EFI_SUCCESS)
> -			return gop;
> -
> -		if (!first_gop)
> +		if (status == EFI_SUCCESS) {
> +			if (found_gop)
> +				*found_gop = gop;
> +			return h;
> +		} else if (!first_gop_handle) {
> +			first_gop_handle = h;
>  			first_gop = gop;

You can just assign *found_gop = gop here...

> +		}
>  	}
>  
> -	return first_gop;
> +	if (found_gop)
> +		*found_gop = first_gop;

...and then this assignment won't be needed anynmore.

> +	return first_gop_handle;

Also, given that you are calling first_gop_handle to the variable to
store the first gop handle, I would for consistency name the parameter
fist_gop and just drop the local variable with the same name.

But I agree with the general logic of the patch, so regardless of what
you prefer to do:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


