Return-Path: <linux-kernel+bounces-854655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF303BDEFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A74A3551C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79292472B1;
	Wed, 15 Oct 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="b4guQ+FF"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2B1534EC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538105; cv=none; b=ujgPNCgRHyMQMbRXjFDuZNw7EUM4S/dXhnr31Rcyb+DKwQ5Ceu5IotixZk/AEaRDiTJOQgSE+t7JMaUn5VG4uICFZ8Zj6RiKX3ht+z058sN2OUHfOzcYFhlu4j94SBLCBkN4ggWdUbgkRHRxmQJ+0SO0d0AtmTUeZvA1mpfRuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538105; c=relaxed/simple;
	bh=rsCxuIGa07OzPA91/mcN7Lbx5abo0noYtZAvC10T47M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efTy5wJOUHU2gsL+hBoECgw6h2DjbcFNKB8eer73pFK4LzBVAagNMzTMee7eLIZqKEZz7Kxg3p/XK7A5vWtd2LHlj1ksRWSdyEdD2p1zoBZH4vSAiQmhh+f5q/vQ4TxzTPXFb5lEcot+QFOKxHLRIq9m9q5l989XHLg6BZ2W+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=b4guQ+FF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88e68c0a7bfso127641485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760538103; x=1761142903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo2y1Bu1LMnaNfCd71h+uw7Uf0QO/1obDl+YiKgx8yY=;
        b=b4guQ+FF0YzwKkzkjKzTwK10u8GI1l7bBbULvzKH893ArD9KfUKpgkmhQBt4EP1GgQ
         j6V7dh7pk16oO1CQSVAfq3kpCC9za1dm1f0DwlHLzlNUNWwfYS32dkSG65ycwuAhNZaO
         WypdZI1pqeOhlU1U6agqODjBleBzHeBbMQM/nffzy1F1hbJqmWS27LZM9gUDkUoDZyyh
         aCskAxChCIFNIb/H/u5g4QG4/l6yCyROQ/vEDmd7iH21O4tAe3dfpBaN6Q5MQPlNS0fe
         +twLch6dzUNmytBIXGfswe4PWGLdtucAOhiKCtPKZzFiQLH8BcBWI/SlZAo+riCjOSgV
         GSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538103; x=1761142903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo2y1Bu1LMnaNfCd71h+uw7Uf0QO/1obDl+YiKgx8yY=;
        b=AaXfYUwGP9bxk4UDjIXdrNGlx0029lbL6LdsMdjRVo9Ak7BYfu2ownfu5LAH9nhG5x
         sytFAfSDGXA1KzpLn0tS2jnAWIYMpgr8yMFNeCGab8a9Fks85dsZ2QnxvR+UzYOs+mSP
         kK22w2/jsYzwvi3u9pxP06IgV3KMWd0a1eTOtD9aMft23pHkpoedmD8q7Y5NUQkrWjtO
         FtigvoCUQ9jnVqPaXFpq8nFEtq3qz5AaAU/QFwyY99pGYAf76O5nQlG2JPT/yh96cXGl
         JrmC6cpraNnbOJADYwL2weAoWZZqtnkiZ6sejyb6BLpvpigXzNxenYNOCS4QZbN31ncy
         uALA==
X-Forwarded-Encrypted: i=1; AJvYcCWla7NGb4CQw4QODpRZrTpv/RD+6yiY1DmtczR1EPh8aAzhLRpB5q/CitXH5bIfoU1uPp/ZO99Rc5Mu4V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Vh8PnlUToCTliiPew0dyAqTgvGsqo5n9ER9rNdhYzZGJxNxN
	6AbmrxFF9c9mdkFVChZgJmiIAgon5ErhnKEdhrsPE6SLNTFMyQWiqYsECuiz+0CHLA==
X-Gm-Gg: ASbGncuwQRrXqjcSVd5pE79nBRODwfj3CcHaaL6+pt8I/tUMWCfE0kLOTl0+wx65/N9
	MUoU6u96m4bLkkGb20UYihOtp+AZ+LZJm8VwVJKeKXQ353hYc5qR97gfPaDekxBehBFNFAAGRze
	X84Iv/l8gSRl/gxTXAN+kVHO4Xw7vcDiv5LAGK2VlJVrmJyOh6N3JHyFdBAlq7E5j7APDkJGqsQ
	vr0gnOV2Q1JNXDwc7j3tkP5Fz+QBTlBfhl822zXPrawI5YuU2grIi1SYWBMTa/V3B84IaYvL+aV
	tSB3nbzpMoG3LdDG3r2YO5vMFmDVXq3NbpZHJ095qQoyJpYQ1iXmdwkCzTLjd1gL5b396cpbm23
	bj2g7roAAvrmNRb/Qvslkd+h1aX8mSigB+2dcFDoaitebrUzIVK3xcRF6PA80OJ13DKF9Ixj0oF
	80Kg==
X-Google-Smtp-Source: AGHT+IFrJLeVOnPgxh66ucu/t9d4mmQTNB8Y0LxSmbCqtxoIGawoP6sDh9GYHFFnOFjMyeDPg8oqtw==
X-Received: by 2002:a05:622a:1a9d:b0:4b7:a8ce:a3fc with SMTP id d75a77b69052e-4e6ead65069mr381373611cf.66.1760538102557;
        Wed, 15 Oct 2025 07:21:42 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c577e6sm19687141cf.7.2025.10.15.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:21:41 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:21:39 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/core/quirks: Add Huawei ME906S to wakeup quirk.
Message-ID: <8ef4550b-a958-4fa4-88df-89b3d4b1117d@rowland.harvard.edu>
References: <20251014153049.91722-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014153049.91722-1-wse@tuxedocomputers.com>

On Tue, Oct 14, 2025 at 05:30:05PM +0200, Werner Sembach wrote:
> From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
> 
> The list of Huawei LTE modules needing the quirk fixing spurious wakeups
> was missing the IDs of the Huawei ME906S module, therefore suspend did not
> work.
> 
> Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/usb/core/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index f5bc538753301..39fbbc31e9a41 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -469,6 +469,8 @@ static const struct usb_device_id usb_quirk_list[] = {
>  			USB_QUIRK_DISCONNECT_SUSPEND },
>  	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
>  			USB_QUIRK_DISCONNECT_SUSPEND },
> +	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
> +			USB_QUIRK_DISCONNECT_SUSPEND },

Please pay attention to the comment at the start of the array's 
definition.  Entries should be sorted by vendor ID and product ID.

Alan Stern

