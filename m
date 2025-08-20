Return-Path: <linux-kernel+bounces-777744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616CDB2DD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D416E854
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034B31A046;
	Wed, 20 Aug 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YerllQTq"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5529BDBB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695058; cv=none; b=cIJP5vjLvKIoCiEu7WheDCRW29mBsdLRK1O5nHPoAR1jT4rGTIP/bOLToHwwGjpfXMLiZsBS91639FYREvNRqOLyj8qzKdrLtdUMcYuipztYxKhD2b2OtHuJa3NLnihYx5pf/10JnM3Ny4RGnNJlaLNfY9Aqpi+LODBvZh7dZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695058; c=relaxed/simple;
	bh=MTEmr6PLWX1CfiIGNeCXCHdIIUWkodJVfLUhpASrxR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB1LSV2N7B6wGOPyQVxJ+HxGH0MjViSC8F3z3MZeCFFJGYG6jOl2ir1cPRx4MFD1M/cTguBk1v0QL+/MDrhMIZER2c/iETaHx3/JmdcG0erxR1dFYmXxKGSw5agYrIqE1bO7gK+JRjT2BQy4gwMHbLdLKZ2p/p6J2DFEB1Xz8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YerllQTq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so5757875e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755695055; x=1756299855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gY7XVkJ6w+vjaw3X44Oc8ca14AVZViv5sVYFg+uhWoE=;
        b=YerllQTqNAuC/LZx1jCH5DoPfV+euqe4CVefRo/ko5eetzV8hbIdMkbMn/9LCfXAL/
         gJ8Dc108bHuDSFbmO04KrQGTLWezDVkWfuHkKp7vxfc6sr2ViSCI5BhGSI07AJbA3Rub
         WZ5ZlvlqaMg570F+YbvCw11QIvxMwPwoIRT6nFycBj25UbNhLFF5xTG8lFsUBluQUY46
         yIsjNU04QnXRp3mJg/0ATKScMZCO/HA8QAMFfrqraAZwhPi1Vw2IKCBgPzy7wPpx/AXx
         w2KfOVZyORgqSOskZWIa8qUfRWiNbFmntiJI0WKG4oI2SFCNuWghs94+0meo0aU8J3Hx
         I4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695055; x=1756299855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY7XVkJ6w+vjaw3X44Oc8ca14AVZViv5sVYFg+uhWoE=;
        b=XpElVZ0RQ+x7Ilxfa+t0N1JNy//r26ZnOtGBMcDKFAk1LJS7Xl+ZpkEhBtf6QgRhfY
         fV+EAZ+h4pvY/A+Ez8u8MWh1Jjb/TWUeIkmJigXoaDcjb3I6qUSbzGBUOfofQAfQU33d
         54azLea5Fkmc+a4TXTZRA92e1CtEJm2MpREFSuppddusyfa1hYsomfCjMOROVisd5GRO
         21ccnv4iqKBj50GS/AWveCZge6EMD2saZck5tMUY0rsZxVSTgTiM9o6lJ6xOjsCJgZGp
         2buQv7McjUyKOLL6T3411ZoO16aZo29C7YtOdGt8QcYsMkjn4KWxR0YQlrhRaib1HPEJ
         su/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVDePIAli0NVSHCv9F98RqTBv9XgGAk6Su7vSkFB9FFnPa/A6fjhynIZ+rhim6ucrrFVAenjOMfu1ei9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8JRBT38K0O6dw7U2OeNGvFJjiaEhmmpTKifQyudVJMTVn56/
	7WOfOMlUxD8VfDhWuGn12z0INX3YaWzQhX5N9rXsZjj5vGL8NP+cuKvTnsqa+VJa12U=
X-Gm-Gg: ASbGncsBU58qb0C4mUzxD8dHz5+yBdILESO8xjXPIFa3jmJQpKMeILzm13JLmjapvzl
	OyOGZ4rl/S/Qr4PSZ/5BKqmcFgc6+uqw4ipAI17K1FcJqL0mVNI6rsFjkM9f8c4lMjcJDI2DxvM
	sx1hUhJBaH/cWyQ2Bh5IsF0W7P02L/GL5OqL/e3pVAfxGVxxdgGTeMHBl3yO2zQBYZBcnqm1f9F
	OcgYXZq5lr7pZyxMHkpMUgrq609iEdPH0N53kJ1mzEvQmcpdVOLT21rtteNUD/XJ1lxPpd8UtKi
	hVPgG6iz/WRKyGCUIt1sOF5Bv/xergx9rWmb1GIBzhzhOULi5yc3OqgApSpN5Oa/nlpQyYILqVY
	C4tYyfzX2IFzFzAkfYDjn+uD4PFO8LBKa1bie2OR/vJOjd0jWrYGsAw==
X-Google-Smtp-Source: AGHT+IFDXUSqh4DOnr6eHhJBZWOZMSWPHk/5O4ChkMSVZ6URykazM/OIpEHf8YVEdfT818C1CmnNkQ==
X-Received: by 2002:a05:600c:1988:b0:459:dd1d:2ee0 with SMTP id 5b1f17b1804b1-45b43e0339cmr54417895e9.0.1755695055064;
        Wed, 20 Aug 2025 06:04:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b47c30dc1sm31620545e9.6.2025.08.20.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 06:04:14 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:04:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Whitespaces style cleanup in
 gdc.c
Message-ID: <aKXHypUfl00qE0yP@stanley.mountain>
References: <20250820124519.2287171-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820124519.2287171-1-abarnas@google.com>

On Wed, Aug 20, 2025 at 12:45:19PM +0000, Adrian Barnaś wrote:
> NFC: This patch cleans up coding style whitespace issues

What does "NFC" mean in this context?  I only know it as the networking
protocol.

> in drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
> 
> Fixes include:
>  - removal of unnecessary line breaks
>  - correcting spacing around operators
>  - correcting spaces between types and names
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---

[ snip ]

> @@ -85,8 +79,7 @@ void gdc_lut_convert_to_isp_format(const int in_lut[4][HRT_GDC_N],
>  	}
>  }
>  
> -int gdc_get_unity(
> -    const gdc_ID_t		ID)
> +int gdc_get_unity(const gdc_ID_t ID)
>  {
>  	assert(ID < N_GDC_ID);
>  	(void)ID;
> @@ -96,10 +89,8 @@ int gdc_get_unity(
>  /*
>   * Local function implementations
>   */
> -static inline void gdc_reg_store(
> -    const gdc_ID_t		ID,
> -    const unsigned int	reg,
> -    const hrt_data		value)
> +static inline void gdc_reg_store(const gdc_ID_t ID, const unsigned int	reg,
                                                                         ^^^^^^^
Replace this tab with a space.



> +				 const hrt_data value)
>  {
>  	ia_css_device_store_uint32(GDC_BASE[ID] + reg * sizeof(hrt_data), value);
>  	return;

regards,
dan carpenter

