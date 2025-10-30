Return-Path: <linux-kernel+bounces-877413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA5C1E0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57213B9091
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441122DEA96;
	Thu, 30 Oct 2025 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeJBaKpd"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFD8F6F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789243; cv=none; b=gqgE4or73ydsH10fSbKrvsbaZmsGw+jeN0Mifc7Pe8mmVeFgzfhbQc6848xf7n1IC9Mr9NMwtGJdZWUpfvhEbg5c0uGXpsHTf18gmBcGcIEfvUP8UVnpJiEUnxovt/xbOkwddRRZaWGixmfZU9JhmODoxSVqy6gHEKXyUlU9r+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789243; c=relaxed/simple;
	bh=phF+41jPYGFsWZNLAeFbe1hdIEJHWy1G5CKaXfNjyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYfnkNuPIsjeDEeBNy6t9k/+SlvtO3kYpIYXBgE774Osu3ffDUfF3+McuTMRMJJJrZeWX3ZoC/yn2PLy2RhzTJBSBMwDEBnyl/wH+RDfYKV50a4isdLr7aFkUCU2zji8E2OzFEQb1+6Nd1BKrpaBdPwTyWWAOboh4YR0nh8z/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeJBaKpd; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eba67d4b1bso4289351cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761789241; x=1762394041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cny/pF2/UWb4s3KOzXzTRQuku/xp77wec9CPlPDB6hY=;
        b=ZeJBaKpdd8Iel2mR+bBE0meijEo9XDUB9fJssBwFqrL0mTsyiCzoFmfcrMM57TpFG7
         jFUALzWfreSWXbcm3OJQHJWwsBFleVqDA7whA7JTuWNcQix0syjyeMa/4Hcs/BKTvOdU
         1R04aPYrZ62o8mytpUmRRIyj4R+b4vLUNZeclg5eSCHogLYfWACliOT1I3hCj6ieuKRL
         wz5LnRQ3OHsU09t05NWvktgwhmNzPVBIurfAcClv2jpc+4yECVoT7Evrz2NS/ph9TbQ7
         MDqme3ztOldeW4oHuNHu/jhrcHr5wLfEGTLIyQdqQGAkUWxJtleNEAVsT4IKc/x+Dsl2
         f1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761789241; x=1762394041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cny/pF2/UWb4s3KOzXzTRQuku/xp77wec9CPlPDB6hY=;
        b=L5b3YtZ6iKO9W37pNJ7DOusg0uQD5ZQovQK561PPo4IjgBFW0S4viuBrHERi3BsAHs
         7D8ikGK1IO1bgdSXFwz3PUGQg9dDtU52yCg2oWJBKxFFcyp8dfn8TYXoiEUX/VShdFXn
         Pk66dNk16GfOpuYnk3m+uOuvJ3w7armwoA2d56SKVInlLg+FlRtcMA6+VlaXEJd7hEDs
         5zEtlq0TIhnAdw6kclVCUfY+YePk3+AnQ42CyOLZn9O45Rh6skbVIWhflqGz5vlHORdk
         tVckZXAp4+lNl/bCOIyZyY4q8a26uFGPPphu6A5M88r4x4qESDVv72vMPs72cFB2H6HU
         LUeA==
X-Forwarded-Encrypted: i=1; AJvYcCVwOV7luXrsjwjB8V0HqELjaDtZsZImLLhUxIICbsatth2sfO+iTfUOtuVzMGTbE3r1OSUgJEM3/JjdJIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9++xiYTrNj7sAvxZwWfXfopreQBd6IgJmK3P7Lj3soRPleN1V
	xB8HzQtnPpNHIBtvmS0GdkX+//6Tf05wSfZ1kWyAmmTSo1Sl0qKrp6DH
X-Gm-Gg: ASbGncucc3SrSc/1/Hc2bTwrhTlsnxnu4SCGr8ntdV0LVojhXRErdaLfj8YerYnHrAI
	mhbFQl0+xFT1cApRW2yM+UHlCPeTiXCwz4YiDy0RhE5YZnjmVwddWQM8sYCVrTInlpVALzV8LRS
	Li/ejkWF/P7vfIwrUFbjsgFbl2r04WW2XSn0djvz/bqWmI6VNzB5koErbmL6Fs2uJdgY710DmP/
	4Fr/3kYxpqFYsVU+00DmOk7E5nvljM58U/X6ulhu05b8Z7on6PmeNyTvUJg8v5o6K6e8MCJJkPg
	tI90w0A+mIx9II/T5TjFAmJgpJgqmY/akMsYh6hMA8Hj2Ul69op0wySdQFzAQIDpJpNO+IoImmO
	nxiL7hMBS4JjUmdJbi6W/K7ErFkQdZXO1WBPvb1AWpXuX/7T702CE+ihIgRUekv2usokTqVGCeV
	M=
X-Google-Smtp-Source: AGHT+IE+61G4p2S3GzFHVNxAsZS2OUebLYMCNTGNbtH9VbO1FZnXm51zQySPKvrbNYQTOh7o+SE+Fw==
X-Received: by 2002:ac8:5889:0:b0:4ec:f9a1:17c5 with SMTP id d75a77b69052e-4ed15bb2b3emr57941951cf.10.1761789241028;
        Wed, 29 Oct 2025 18:54:01 -0700 (PDT)
Received: from sam-fedora ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3863cc2sm100445901cf.32.2025.10.29.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 18:54:00 -0700 (PDT)
Date: Wed, 29 Oct 2025 21:53:55 -0400
From: Samuel Kayode <samkay014@gmail.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Samuel Kayode <samkay014@gmail.com>,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Lee Jones <lee@kernel.org>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sean Nyekjaer <sean@geanix.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD
 DRIVER
Message-ID: <aQLFM2-WgRvDHfZT@sam-fedora>
References: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029104228.95498-1-lukas.bulwahn@redhat.com>

On Wed, Oct 29, 2025 at 11:42:28AM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit ebaec90ec0b5 ("mfd: pf1550: Add core driver for the PF1550 PMIC")
> adds the header file pf1550.h in include/linux/mfd/, and commit
> a7d6255a0bf3 ("MAINTAINERS: Add an entry for PF1550 MFD driver") adds a new
> section NXP PF1550 PMIC MFD DRIVER intending to refer to that header file.
> It however adds the entry for pfd1550.h; note the additional letter in the
> filename.
> 
> Adjust the file entry to refer to the intended file.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 70de2f9c4a50..e428ec79dd24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18718,7 +18718,7 @@ F:	drivers/input/misc/pf1550-onkey.c
>  F:	drivers/mfd/pf1550.c
>  F:	drivers/power/supply/pf1550-charger.c
>  F:	drivers/regulator/pf1550-regulator.c
> -F:	include/linux/mfd/pfd1550.h
> +F:	include/linux/mfd/pf1550.h

Thanks for catching that.

Reviewed-by: Samuel Kayode <samkay014@gmail.com>

I will be sending a patch to update my email on this.

Thanks,
Sam

