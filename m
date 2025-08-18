Return-Path: <linux-kernel+bounces-772933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A0FB29982
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FDE1893CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00127057C;
	Mon, 18 Aug 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwIdRPBI"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E024C06A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497746; cv=none; b=XF2uC+dYnce2dwvT2vGFslZLE6JEgyQL0LuPdANNmhK74mtcsXOqIKe0CxDNWxaAZ4OfWjiyMzs3FdH7IhDqX5lzEw/X2m00Ew+JqeAQOXwxiBzKRuOsLBL7CTxVAm3uqCTnqoSfCh2oxhiKQvW4Ndn1bXs9ngGN5Kz335MYH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497746; c=relaxed/simple;
	bh=MYHptY7qVMdCeYExxbFTjOvHEMfmgG75pzPebFLBE6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIr7/l7qz188to2qIeWjsL98fGXdbuh/b85JtI51s35tP15HArxc5tsz/0wtvMXhxS7ljrObzbTWoL2m/QDxPSPY8HK+AOEGLMmSAZfOHoXUVWQBRn1luQ/RDwuknTGL4lGpcu5CSmhk4UivIZdaW1p1dZ8iC5HSQ/r90jewtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwIdRPBI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e4147690so2571801f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755497743; x=1756102543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PSsAQl2WRt5OEtha/zrB/DgNNONu4LNMZgefW2fQN0=;
        b=vwIdRPBIXyJyX4c8i7e5xek5IySSN81+B93ujq9hWLfGQa+1vgtekgEw+DUNC2oW0W
         yugIWwWH1VbFjnqFzywZCMTSJKzqsDIgSqIjZQvRo5Nro0X92RunUIweXEI8Y3sbNUST
         HnKF5vZTwjq35aAwa/NY5mJj4XAdCxXcNmZ/2ogB70zj9qondKjCTL1NJ7eDwuFoOdVb
         aG7MJ227e8VEuRtInXYTq702kp9X8qzpa6oDAzB1oUs8UnY1rZnlos/hZPT3cq05Bbpa
         b4VVnvVi2rvM8EnWibqBRLv0FgSHLf4QXx8SUooInwg7DuhAKOYH6bSNaPCEhOesl1L0
         /5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755497743; x=1756102543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PSsAQl2WRt5OEtha/zrB/DgNNONu4LNMZgefW2fQN0=;
        b=HEYXeHYmS2NzHlx3KBLSzBtjJ9tTTe8aJ6pF3FfgKawMhAGQYlE+Ss8WxfI8GnCfDg
         4yAqZxQtYgxFUg/E5hhOn7Eiw4AE23zJunU2l82hH1stpKZxxJqEtuEJZVB3whvddfez
         52tPT7OxRBCbHEmIJTo77P6sdS9858jHtEJJVf4qUvpAnqdisd8/ElydmxMaqFC+6KXC
         lp5XzvKQgmM3mehh16uvvy0VeybF4rPO1bWpL+xwHPNQ3aQtl43eu2Ms1PupnE86FD6D
         dY9u9lnIbHeyBnoOaaJE3ld/fDx/TiRWPZSqU9D/xM645pAGCk73KCJu3Ro896oAqhf9
         j+LA==
X-Forwarded-Encrypted: i=1; AJvYcCU/vjpaJ0+KzdKDUVbJ+2/mU6GnhAbsjo5pfj/DVX5nlsjlm+w23nsvU6SUfrpBCop+KPprOEajdaR1P9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdrc3xojrumlaSoX3OubtFN49OfIxy1QQ0rv6qN0QEoe4wQr5k
	v/jE/CvovDnHnN0Ao4NlNrpiGAIeJ9br0FzOir3++E8WcX/njskn3hS/MBHO7u8a23k=
X-Gm-Gg: ASbGncukJN/1+kOGcjZnXmh7iszl6IypfAgWFROYiyrZcXHdolRgjLI+0WC2/T9AGem
	vbocyF5U7F1nSpIRbyE5ATsGOaFA0Pe9p8QopSwo2N0zSK0Zye1KTD8jHhP6Zj4ALkGCsPY9qnO
	POZc7PY6fg8DdPHYs3vm2Fcy+GJHJSIeX/fKlUboQ+gmsdhfHowRj3NpRj5V7D1xy8SRQbQh5BQ
	/lGdaUnEYFtGC16XifpNelYMsgH2ViiSLIbQXKLPOnB/7YvyF/X6LJcer4Ek9IS3RDATvJt6Eiv
	tTQMiIjSFuvvMyrO/44Mk7yyVHuHOdxP4MWSkusuE1frFKiSqYdP5T2Wxix2blmH0lFOU/1jR/x
	csAvBd5TNJ3fgNk4BUw3504DpZc1W5EUQ7c3BRCMP3VY=
X-Google-Smtp-Source: AGHT+IG09uXnf83+BxfTTXuZFbE6IWpXIJALIrxVKeBEh/KVAHcmGhBFx2Xg2Z9xfz9OU41mjepSqQ==
X-Received: by 2002:a5d:5f54:0:b0:3b7:9af4:9c93 with SMTP id ffacd0b85a97d-3bc6a55e8cbmr5720130f8f.35.1755497742661;
        Sun, 17 Aug 2025 23:15:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1ce9758asm155462025e9.15.2025.08.17.23.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:15:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:15:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] staging: media: atomisp: Add lock asserts for various
 functions
Message-ID: <aKLFCjIEEbEUqEXK@stanley.mountain>
References: <20250816170603.41051-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816170603.41051-1-abdelrahmanfekry375@gmail.com>

On Sat, Aug 16, 2025 at 08:06:03PM +0300, Abdelrahman Fekry wrote:
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> index be5f37f4a6fd..03067479dd69 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> @@ -1447,9 +1447,11 @@ int atomisp_css_input_set_resolution(struct atomisp_sub_device *asd,
>  				     enum atomisp_input_stream_id stream_id,
>  				     struct v4l2_mbus_framefmt *ffmt)
>  {
> +	struct atomisp_device *isp = asd->isp;
>  	struct ia_css_stream_config *s_config =
> -		    &asd->stream_env[stream_id].stream_config;
> +	&asd->stream_env[stream_id].stream_config;

Don't delete this whitespace.

regards,
dan carpenter


