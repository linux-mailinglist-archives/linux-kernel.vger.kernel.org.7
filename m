Return-Path: <linux-kernel+bounces-764340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CCB221C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7386072087B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393282E7F19;
	Tue, 12 Aug 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jpa2bm/U"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4C2E11B5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988001; cv=none; b=VtUtRCjTH7xa16ab0Up30MFMVopb42jJCMQLXMNUUWawts+As8CseYyQBQQOVlonBmWDuUZ9EEmSqEhAEvngrVyGUx5DGFtFUm+9MY1ZLRGJR9rcgZUuuyrtwCCFtlF6R/odZSFgvF9f7oM/IS7jpTp2R4CmQB0z/qoK7gmZt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988001; c=relaxed/simple;
	bh=jaU8je6Bv57zAzt6U+q32gNcdWOgzD2viD/E+bzKjuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltUIwen1sfJPhQ8Up5iu9oVfY7d8Fy2n11DLHL3puz1R4FXSE6s6TJZr14jLEtMpTARLiCzvOjRrRjeSlmweV89WVDcorNUDs0XMGkuKeBE3v2fCx3M0JUOvG22cSNlxfqRg0rJZjVctku6DTnn/76hRZO06aaPLCHK8UuwDDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jpa2bm/U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459e1338565so48695265e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754987998; x=1755592798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PfCe+Hab0EGiwiSh46Us94InqOs3PEdCxahZrUvq8fY=;
        b=Jpa2bm/UARoF7NtLcCgodGyOL6wGmX0m+P8pfKBKJLMsrDuYoFqFEXaG0gCfbAZHGn
         3ovZfUufilWNeKJql2IAoWgZ1pUp6F/hO/H+BqUlPvvvqZQ277LH2VQ3R1F/90ZZvAz0
         rh+qGSNPtn2Ihz+30CULT4vOy8/Ca9fiv2yz8sN4v4Ue1pzEhy+kxZym5FFFooJJGUIW
         GzrE7HWxB17vauQO0xOmS81O48hcCLv5fD41FLutYzsoEXz792o+cc0wyX545krzeBBL
         UcXr85vEsjCIJNIXvCID8wM59Xd1d8lCGD2ZxEfJbcQn6sDdU8kVdjFQ7NCW7Ns0KHrO
         mu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987998; x=1755592798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfCe+Hab0EGiwiSh46Us94InqOs3PEdCxahZrUvq8fY=;
        b=kLl5qkGU6aBzmwj4qyzrmHgF4VFvifp32cO7a7LVa+4dTMBhVjpRkuGHq4cXiSk0Ra
         eF7QnRBS1SoGlimmj/1WFQPCJjQCQkJVR+aUBvcuUmpBl6U243jkC1VtLY7u5ffcvl4/
         r7VLWGawjV7EEwsQJx5L1UDPPIyktFYlRSC2mFCkB+QKHUFiE+mInvAqo3R42o/RUwXQ
         yh2ZgRvR/YIxGLd84HDmI5QxvpavyROJqnDSq/y3QbJaWzekPN8qwEPFCH5WlyIiLvQt
         naBCCR5ZhgAtqH8e6AAMaewjwlGu63Sj+XlcTyfSxbmS+GqmrfBU7Oc9i7nPceV4/wf7
         gZtg==
X-Forwarded-Encrypted: i=1; AJvYcCW6seI/QNuZEincuepgQYS2xgFZdR4ubyhQayMBfotJ1elgXavFOtpRxxjqh+22HsIN7iRq9YPpmQhBaOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZuiOzlFHA7dSUo2vDuhn458jnfIdlI1Vyc4hXjsjslwFtx9N
	HutLgr5Kuiez88wRwk/EfKHd+4HA9P4SN1ieHBfXA+OTpDf+WedaDTo1QeUSuYMHBaE0YpiLIgr
	kyUB1
X-Gm-Gg: ASbGncu9L/+svH31jlLRQ7E4q7h/qU4GG/QiSsQOly4NDlaRYoQQXpDP3ZM4NCgSKu1
	YgR/klj81+EjEwc8h4bBqYRuGRtGB7V7DXs6RWFFeUuxi9U/pX8lGVuZSTgJm0mcwv5GnWSQOus
	VgjdS5xynaQidbjg3n13KKrd4pBGyYSU+z/mvHWjBzBHsDJDRJwi2nM7WujC1RKMoq6c/TsZaLL
	qHpsVz+zSMOAy7F9XO3GGP8k29aKmUcR4bwN5yjRzovOww6Z4LlRK5dCVeEQmpLh0/7wMUiWJ50
	tJonpKEfMpCHsHKGfs1eLrEzhJ1WPC6Rt38V8KDuzRz45zzKjqeMo4J3VNSHeN6+JdmzIzR+reh
	tlu6Y8YGyIUyGwtfStnYLyUVRz0W8zRxTuG2qBUHnIjYEar+27IAIyQ==
X-Google-Smtp-Source: AGHT+IE8bA/wEEcwiHAKiaf7wSlcuwAOC59hiKgi/SIS6TbVIxNjim6ybFDyEh6Rbupki1OUm1hb0g==
X-Received: by 2002:a05:600c:1caa:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-459f4ec3a43mr156381895e9.14.1754987997836;
        Tue, 12 Aug 2025 01:39:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459d712c386sm370853285e9.23.2025.08.12.01.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:39:57 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:39:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Assert if vkms_config_create_*() fails
Message-ID: <aJr92bN5iQnIzTbP@stanley.mountain>
References: <20250811101529.150716-1-jose.exposito89@gmail.com>
 <91587a35-f884-46ad-9869-126d3efbfc61@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91587a35-f884-46ad-9869-126d3efbfc61@bootlin.com>

On Mon, Aug 11, 2025 at 07:21:18PM +0200, Louis Chauvet wrote:
> 
> 
> Le 11/08/2025 à 12:15, José Expósito a écrit :
> > Check that the value returned by the vkms_config_create_*() functions is
> > valid. Otherwise, assert and finish the KUnit test.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/dri-devel/aJTL6IFEBaI8gqtH@stanley.mountain/
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> I am not sure on how to use smach, I don't have any warning at all for the
> whole kernel, so I will wait for Dan Carpenter review before applying.
> 

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

> Side question: should we use __must_check in this case to warn at compile
> time?

We wouldn't normally...  It turns out the existing code was already
checking for errors so this is really just a "silence the checker"
patch.

regards,
dan carpenter


