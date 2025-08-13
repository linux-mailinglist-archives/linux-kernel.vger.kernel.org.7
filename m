Return-Path: <linux-kernel+bounces-767421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02652B25406
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57105A62B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014DE1494CC;
	Wed, 13 Aug 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JLGhNqv2"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2882F99B1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114032; cv=none; b=dUNpvrlEnr6mM70oz7dVEguZd0+EQ454nVinvFH6gytIvqfZhEkYMf3JXZCAXglbymONwdriy8v0P2Hp9N4x0JEyzCRzQ+avdgptVZ8sPTdbDh4KToAcOy+/6Dnr0CQ3Nqu2bs4Owk8ZHg4AauewdNOQzewjNrOP+zefieql7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114032; c=relaxed/simple;
	bh=9nSdP9e937hC8d3i0s8ozTY0XOgg1Kd2xe4LORw4IzQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/jDUVTEONWLDB2BuAUUxl1kFy4Zs0JJbEuzG2Rwmp13vjAUqPnggFd6XPGTXf/5fdwjQdSyRl0l9gzRUqvzPbuHT/96ql0DW6vpLz5BSiAy4gJg/jIRrP0wUroGO2Pg2hd/uHQoTUMl7S9AnPnIQ5uiRy9xantxjA8I+ct9FOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JLGhNqv2; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so318446a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755114028; x=1755718828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikxKGvNRrHWapXobM1CVpjG5F3QIhCjs1u3Ja46/fsg=;
        b=JLGhNqv253lQnrcLCd50DkJTvCzzQ+GC0ms4IgEBPf6AOw6bKWZfFQ1Uf0naammBS+
         Ax0mPL6hz9AevFzDPN6SJp7lEhtoH6bGb7hyc0rr4D0/Zxf8gQu13kbd46gFee3m6bX/
         hVomb2ev8sGHmvdE3Gohhj9OArEXJUJkeMhX7O+vgw4/xIQhY+sUymq0JFfL6eNdJ5ry
         Lb2Ait9X9+EdbGupXOaXSGSB2jfEMhOK/ZakVDalgjVg5QFNFrZnpBRBhwFtMODnqu+b
         8r16/uUIlPebgljG4afZ6x5EKDK2gy5u0bEYdXWR+J8EMlyPYXv7FBxpNIgiNGGzDWV3
         WdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755114028; x=1755718828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikxKGvNRrHWapXobM1CVpjG5F3QIhCjs1u3Ja46/fsg=;
        b=Te0mJsPp33Ja0vfKHzdyPM4Ed0NZ3qp7nMyfxJpOaB/By66jrZdxVE5vaWaxx7vQG6
         fmjLSrvLcee3O+5Ns2Ak4XhusQw667wDLGTUlmlmzd/Da8hn3PUkF51NQu1/jC0qX0Vg
         o8UmIzJ4jqri8RXTqveh56gtQalIHSnFMPIndGfTbZoiZ7flWUzDYWGlRJciWvfDw9Mz
         K3kmCMRoDeRUN2wJmW1I2Iq/FDDKE6xHla4l/HKkeRu3TahWQb2PxPBLbI4gFvNI89R3
         wWOW2Vyhnx1Ea6zwXx53tiJHjs8NhJuO7U6FUMJHJiHP0i0IH4PoX11YHVuWXFOWyBAE
         NBXQ==
X-Gm-Message-State: AOJu0Yxxt+G3BCOO0hRp8E4zA8POu9aX4cjUsVj3+w6XxzDjt43cj7v9
	LSjGRiKcc38O6P4CVWht6aU2FfgPOs5tjrNS65p33BSuvxn5BTKFqqefEDGiiy0Atqg=
X-Gm-Gg: ASbGncsbfYSy7StXqAJ5Kwi4MkQQSfjr+VXEYQIzxV+ibfonsCNvD0wOs+lby6k6wpl
	dpS77Y5CtgCtFydwVCPN2QVbUyuHXzTmALkOK3wsmiSEvPRwKNKIZ8vKPsYX84bu0lOAo+o/COL
	212qj+imCEe5a9eGNKWzIW8lCaJJT4jhQAG5+BWV9RDmGWAcZpDB2PRewXQ2JJalFLhFSQgVwg+
	RhtzdxeKv/sbiR1AxajToy94P8SzItfvHwkTc1bwlAoKlK7NFQ+5lOB3sIf+0sNMAlvjNmESRVI
	CiSf/BBHKa2yvtZ910uLADftTyxeoq9cSGu5VU8AQZHznY7v0uIK0woFzPjgHRj8Nz1OGYUv+Ef
	qAwsG6CImCoX4L3kCP7vG8T0EKKIeyjzigX0rPpvUWEYYoKFB8kh28NFBKPm8x0xy/w==
X-Google-Smtp-Source: AGHT+IFp2RG0LgRoFaOLonOUx+vXqcvq3x+VAp7KQCkcMtBWU1dgV0oww0grLbiSpynhH5XQMCEZNA==
X-Received: by 2002:a05:6402:46c6:b0:618:20c1:7e5e with SMTP id 4fb4d7f45d1cf-6188c20ff2dmr306875a12.27.1755114028014;
        Wed, 13 Aug 2025 12:40:28 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618465fb431sm4296301a12.33.2025.08.13.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 12:40:27 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 13 Aug 2025 21:42:17 +0200
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 13/21] pinctrl: remove unneeded 'fast_io' parameter in
 regmap_config
Message-ID: <aJzqmX-Nh3bWgjWn@apocalypse>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-14-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813161517.4746-14-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On 18:14 Wed 13 Aug     , Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
>  drivers/pinctrl/pinctrl-rp1.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
> index dadafc935dbb..6699b36349d0 100644
> --- a/drivers/pinctrl/pinctrl-rp1.c
> +++ b/drivers/pinctrl/pinctrl-rp1.c
> @@ -1627,7 +1627,6 @@ static const struct regmap_config rp1_pinctrl_regmap_cfg = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> -	.fast_io = true,
>  	.name = "rp1-pinctrl",
>  };

Looks fine to me, just a little heads up: the following patch
https://lore.kernel.org/all/20250812092618.14270-1-andrea.porta@suse.com/

adds other two regmap_config with fast_io set to true, so we can
get rid of them too. I can do it in my patch in case I have to send a
second revision, or you can amend yours to cope with my changes and set
my patch as a prerequisite. I guess that it's easier for me since
I have only a single patch, while yours is a big patchset so better
to avoid the noise of a second revision.

Many thanks,
Andrea

>  
> -- 
> 2.47.2
> 

