Return-Path: <linux-kernel+bounces-766820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDF3B24B91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741BC8866FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AB2F3C09;
	Wed, 13 Aug 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bhYjON0L"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E972E7630
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093612; cv=none; b=BHXxCkZCKq735HNM190tMKL8Wa3qrtbz8RUfos3mnmI675XZ+0QUGwgaTi7y3QKmxi+0pjBdCbL5ve3mrK6KluECFgb5KGYwnY3409kvS6lSeiT+j+IgEcwLwUaemrViixuUf5e2K4eY7UgrZHuHcTa4hZrFIDat/4KolTR3Ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093612; c=relaxed/simple;
	bh=kvnCEV4WqFaXfNRysDDum2pAVYP0csyhauHavN2akq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8JM1ERM/Ady1CKbuseKA+ayD2HEgHo+n1MFdsE5lVNev2IFTeVtG+PZa4kVCroIzo8/8livxuBvJYnaIZIcaV4/vvCB3Jdfxj+Qymf6k5r6z675fM+TlHzzaooVmPu4CBTqZYd+ORz3L343sYPQWpfdCs5xgd/QudgAOSKsx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bhYjON0L; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1008221dcso3454341cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755093609; x=1755698409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14mqwiNGUnagTAT/uPS4H5UVASh274vbb++jcSI7i7I=;
        b=bhYjON0LL6pzAYrNm2J+TY275MQDRAA4Xru70eIOlwYic1d/H5jTD66TfpWD9pQwxe
         3WL7GusxIv9FErmD/dmANdx1tvc+I2ti0y62RlZeWFXn24SOmKiMm30txr/p9jXu8gFj
         k1C6R2tUuxwk+Fnhw5KgFGvO2ENzPQEHZ1eB65asw43ZN6oCkrCUZY06FoqFnomIiWVF
         jOqdtTFpufXv6ENomX0LMK3xoN1aTtmJFMOfnXHc19jcBJQGnGCIPgJahQCfQGQVy/Dv
         XU3DVAnm4cj811Aaw/H8X06rKBlBY2MNFsrpa01JJ7sdCk1E5FxraYkA52qPCxY7ndL9
         9ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093609; x=1755698409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14mqwiNGUnagTAT/uPS4H5UVASh274vbb++jcSI7i7I=;
        b=vSbkl53ilEhx5QSsO2pe3lNowqTEShtadMtjNyjsmNKVD9S9lld+h3GLv6VDCGyA7h
         9tGkcrbuyFJvwcCuJP6dGeyUGj6yJLlMfrtt7iaZ+kMr06ZaY12YZhgGkOuMLT3l8nSw
         d3tp+ZmB2B1/N7y9CKcfrqL1kbjwAzJYEQCQ4TP4ENxRKvYk0D9K0rw3P8UmlseEy41i
         Qb6/TGXwePu1tu4Wcmq9tmw2lYt4JIUsxIblqlIILJHvSf8R+gk8JRS6GXFS0I0SByGa
         9rvGzdDoKefovxcdp/mWZ16a6J7tkJR320reXnKFo6a5lkICFCCJf7CD+FW++hrP/Qik
         0piA==
X-Forwarded-Encrypted: i=1; AJvYcCWzJXYQ0S22LVMy9nW7ujlljcZ0yA0MAswsrRtqUj0N7LEE2NagyFfwim5jzaLAL6ahAdVy6PlXE5Fh7mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2v9dD5sYpFLNpJxmzgVQ7iNGNHJi4oTHdpDXLrLX8CAP7jUM
	T5VCjrcc88yEXCdM87yizp+71J+aVlkatoRrFb7VhzoZN9oQSaAE/cyrWM/yUc4cQQ==
X-Gm-Gg: ASbGncuS3APUHlmUgcZYdHQB6K1tvX5Saex7geBqnqbhSf/DnDlv+MlA1X/E6tszLkJ
	jFQzB6RCbxF54CnZvo8CKItdhEdpzLurdtdmfVoDL+k4ft2hOQG9JIo41VhGbDDinEndXulbRqn
	qqDS30wvibI9+0dxSluEMA9BZIO8kBeeNxo/wZDwNpD6ilaKbu4xQ6LFONbpI1U6AK+dnmGQGLx
	/6RKES1EJa+F/LD0zpU53qYqprNdSG3Hc5AaCF1HfeAoU5VbxnSmwZCg4jNSgw7Ex94Uzu7fYhG
	grQvtF38sa2YkjUeenALzo+S58k0TwZ27SvpL18haLOG5aSEDprUBQGPEAj2nUMxfKA7dsDoOnY
	m2G2ctGkiznWvgHXR/q50ju3aWvoJ62Pd1Ye6Bf40QEP2DQ64uKo=
X-Google-Smtp-Source: AGHT+IH6F+o51vIa4VHXqfN5yGQvnR0IghUlwkjQkPziPu74HD7sjxO7q8kjYg+1UjaKvOvweHQdSQ==
X-Received: by 2002:a05:622a:5e16:b0:4b0:769e:42e8 with SMTP id d75a77b69052e-4b0fe2a8b99mr30085081cf.29.1755093609191;
        Wed, 13 Aug 2025 07:00:09 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06ea8cec8sm137121811cf.25.2025.08.13.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:00:08 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:00:06 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: storage: realtek_cr: Simplify residue
 calculation in rts51x_bulk_transport()
Message-ID: <b0c0ed47-b524-48c8-84c9-7da02f7f7d30@rowland.harvard.edu>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
 <20250813101249.158270-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813101249.158270-4-thorsten.blum@linux.dev>

On Wed, Aug 13, 2025 at 12:12:49PM +0200, Thorsten Blum wrote:
> Simplify the calculation of 'residue' in rts51x_bulk_transport() and
> avoid unnecessarily reassigning 'residue' to itself.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index d2c3e3a39693..8a4d7c0f2662 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -261,8 +261,8 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
>  	 * try to compute the actual residue, based on how much data
>  	 * was really transferred and what the device tells us
>  	 */
> -	if (residue)
> -		residue = residue < buf_len ? residue : buf_len;
> +	if (residue > buf_len)
> +		residue = buf_len;
>  
>  	if (act_len)
>  		*act_len = buf_len - residue;

Acked-by: Alan Stern <stern@rowland.harvard.edu>

