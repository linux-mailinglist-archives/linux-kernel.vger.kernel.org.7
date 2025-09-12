Return-Path: <linux-kernel+bounces-813720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCAB549EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644D23BB535
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47132EA499;
	Fri, 12 Sep 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxpXqKiu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F72D2390
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673249; cv=none; b=X42DDPU9UPektb63hIRBOz7YWjL8wYXPsTkvKr5KU5f+v4YzhvRciTskaZVkzvvQ3v+xNAiE1lZnixGZ7MuAbINhH+rTU+/geDzArkadh8TOCen3c3hETQj/DHMDy/9+ogIAe8hQAyOMRGkppxgCSNt5S4IkAFeOa50hfV3G57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673249; c=relaxed/simple;
	bh=a2gSg3SjUDd8u4zi2AkN6vrD/eZ10e2gbI9I3y3t1go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu7e3oOTFLZPij4eC6MWYZdVkZ54TW2bDU6Tkgzg3NegupL+n9vdc49G7oUFt3fiYqJil6DPBVZ+6km1k4b4x55zam06cRlC6WKWDcVwGcesD623fcKkqo/kiIIOVFT47J+m04aEjJ3dgAcOrY+Cnu0rbiH7XtRgT37g8kfjZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yxpXqKiu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so1743679e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757673245; x=1758278045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdULkCF3wHtDOeV61QyKWlC3GANnIuBmmuXKUPdZUu0=;
        b=yxpXqKiuNPkFsB5tvAPV7dDI+wVafeeNSHSJui5+2eQwZ2ILO7WquuxjrQ243wxkXw
         kWi0vP2SjILkgBN3e/sXTDVjFQ2NSnnv6pkCId3pqHAvV0f/VzMgcjaLmfjjboKKvUgD
         1OwLIujEByYAo53UJcLtatv3iIYlu/Jnc4Ra2CjQOJMFoPqRR3Ul9kuUr/I/hm+DfQ5N
         nGkF/76HleiryhnGKiTsdWOw4ZAGoE0OtanL+IV3hgiMpCN6KT80x7/rfhUUWH/LmjkS
         6YbcQHRbAjxpVyw6WSH5dId590hfGhwbvWwyPiSxtf1tTgez3U+3PJThKJtSrejWzBR9
         Rgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673245; x=1758278045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdULkCF3wHtDOeV61QyKWlC3GANnIuBmmuXKUPdZUu0=;
        b=GIjJNxfm44TdWTn8U3wPlmE1p7nPzP7eDhDKcAucaujDTdQhWYgexNnPx5um1dDIHL
         cW9eEBkLXd5iNndDt+i1ZXsUX+UDJ1U8SNOyTqIjOvd9FLJZe9Csm7R6IyDveAyiBCbr
         hcl5p/uIPjLegcsFVOgKUyvBsyQl+5CXP0kBEm9M2zN1680DZJ6QRbRbp42VOZA6riZH
         mKxJyFv29ECXjHQxXfTpL9TLWPs5L3cS6b+NwhKMv+QGMNe3lfHLWTdjpdFKbkZtJseO
         ZGL/i87vDj9o2MJFeve08Z0wr3cOUM/iDEgnC+j/Dy/WHh/atW/grwUX7tsZRUHR7y5r
         Q+qA==
X-Forwarded-Encrypted: i=1; AJvYcCUT87ywV7JhO6DOSRSzh6rpuygfYSjHnnNLSi9kvgsvG7P07VIWXHWCgrM8W6C/NsCxyp2iLzGbH4dn4gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+SbrcHos8v6MxcdVf3FHZGc9aGDPTGIDt5Yw6XKVmVtkObJW
	pBi+ZTmj92eeoPoB3UTY4TMrCUg2vM3u1Q0viAOUteP9s1eaLv6ZDw8ITnCE4voB0vg=
X-Gm-Gg: ASbGnctMMSjVIBJp2ANpRZ/jN4Rff///+u/OhrUAeTQkTu6oSzQkmU6PK2JsImgrM6N
	db3ItTaSer5aT866s6E5kl1Ljb4tdK/7/2qTK/YVv+3934r+dPkwAbb8zyRg5t9mI1w0UFBUxzk
	xyGVXTej4a42mEpfa0PJEfHoWJOT0oApb8j0q3yZJIbE6Djudsey4yZz3nnlAcAKL6G2fB7Rfhy
	bEtm4/H9YWVIcKYjC24MvBndq07HPz0sBhPE7Pexs6b9LoMO+uzUx7IMEF9r9IA4EcQ79LUdMfh
	Wrmp3S7Vkwn8dD+MD0loieb5tFfRwU2OYzF2UPeaLOTK6GYl/k4Nc1lHHLqiHEQDl+JitRsAN9Z
	ECoXg6Xy9oay3nz0TsDEqg4y0ft9GBFFsc/A2Q5y5D+cuvfvhrqJH4P1pphDgOJhz8g==
X-Google-Smtp-Source: AGHT+IEYLTS967/BEvhOg8jJEl25DNiR+DJTVVF1bWTZ1043oUVFc7I9igh8/IpErBhBmyOySthfkA==
X-Received: by 2002:a05:6512:290e:b0:560:8b86:75d9 with SMTP id 2adb3069b0e04-57049675d20mr688273e87.14.1757673245258;
        Fri, 12 Sep 2025 03:34:05 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a32f66sm1030978e87.138.2025.09.12.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:34:04 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:34:02 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be, angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Subject: Re: [PATCH v2 2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
Message-ID: <aMP3Goa-IVjCmSHa@nuoska>
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
 <20250912084112.2795848-2-mikko.rapeli@linaro.org>
 <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>

Hi,

On Fri, Sep 12, 2025 at 10:48:47AM +0200, Geert Uytterhoeven wrote:
> Hi Mikko,
> 
> On Fri, 12 Sept 2025 at 10:41, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> > According to Heiko Stuebner <heiko@sntech.de> all SoCs
> > since 2012 have power domain support in HW and
> > ROCKCHIP_PM_DOMAINS should always be enabled.
> >
> > Suggested-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -14,6 +14,7 @@ config ARCH_ROCKCHIP
> >         select HAVE_ARM_TWD if SMP
> >         select DW_APB_TIMER_OF
> >         select REGULATOR if PM
> > +       select ROCKCHIP_PM_DOMAINS
> 
> This requires "select PM". Oh, that is done below (out-of-context).
> So the "if PM" above can be dropped.

Yes, it's selected just after the context. I can drop it from
"select REGULATOR" in v3.

I was not sure if the PM dependency should be there or not
also when it's explicitly selected.

Cheers,

-Mikko

