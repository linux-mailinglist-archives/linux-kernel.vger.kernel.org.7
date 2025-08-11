Return-Path: <linux-kernel+bounces-763183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8AAB21172
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91542505AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FCB2E1C55;
	Mon, 11 Aug 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVyAg4no"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5159311C13;
	Mon, 11 Aug 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928223; cv=none; b=GpBox8ATgi3QPNWS6LA0Ky58vCYKY4rDr5sDVtsnnhCbXduN84lwNlbpmL9y8u24eC5RHjjXJjR8VSInLq7FOCd1Fj7hTH9sBAvPMMC3rkAiFS6MzYMYizQQXS0jC1R89cXxKCnQe55bzYBmXxwIZWjeERKv5vbCoqKaJkmbhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928223; c=relaxed/simple;
	bh=tCbSHfG0k4x+8ufTF/sqzn89sChwCdY0v4VMVziN/GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh1zvp00j7+0XVIbaCY5+5votc6w2vXgf4Ro9PA2c6hJ/X9gPf8yXy71fAYd1svzLPu1Dvo3ec2wBcffHQV+OudplcqSY3Kh+F/2CCG8Mdt3FYrfPLtDML+pCeNS8mIYWaZvDfqszUfHuHybO65ZMobJ/RwVmk31BsylI1Vzp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVyAg4no; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7682560a2f2so4653290b3a.1;
        Mon, 11 Aug 2025 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754928221; x=1755533021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qDz1RX4muqAvSaOXc+HaSr6jSseHdgs+lZushYe0bk=;
        b=hVyAg4nozeeD+hgRVJfg8sfCTY03HdvNjtBO97WkqIMmXzhhmDw/U7rpp408mfRxqq
         DkvH+WcbfaEvus4LWpR+79txlbFTVN6Ww+Ng95eIDPUjPTMyA4DPsaR5Bi9jrbCnxdPA
         wdhCC89HeRFM0L9VtldImZ7NMCzrHk9ATe/XmB0SZ9lfoUUwyppJIjQYHRKVmtz2Lu7a
         NBMe+DepSbbASmBTYA6z0I76zJwGHVO3hMKR4DX8SMKqP45qRm1iEPn438O34W4zr042
         aJADA+ta7BoUKhPuJFxbcHaE0qg5hkRr/Qqdgae/d04yUVofyMM5Mq2hK8g9zSwAtp7G
         OOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928221; x=1755533021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qDz1RX4muqAvSaOXc+HaSr6jSseHdgs+lZushYe0bk=;
        b=qyNYi1IyIE0/3eIbITLVLIZ0D9stEsXaxHKu/0hzYPCR25EibYHEkiZbOnyC6IuNmM
         IPjjoe4aKm+dqNf36qoEwEiYWz+RQEgJOw6FhUEXnwbZhNZ2/lPWh74MA1lWpxW0j2sN
         dI6k3XCfs0D6kui6hvLYjmWmCdulbAOwuVHJDF4Ef7dgvP5e+S7VBeVaasdgM0aYeAXr
         FZCktjPlJ7CoxYnpN6OTw0S4BYXx+jqkNHYcOu8NBP26FeQ8DSA8x6QChEP5bulPo/TV
         sY+E2UxqAOnMJfwVEdYD+3cl4xb/6Ox9FGK7X1GNftZPrFk6Z29VBUKGe6ni3IQeLBSi
         TcHA==
X-Forwarded-Encrypted: i=1; AJvYcCUlKnTkdH83xOucru31VzFV7NlQOt5NFsIRXT3CkVjVzFR+mmNxoxHBfa6SwCod6ma+NFtd8rd4gyICruGjNKGsYk+cDA==@vger.kernel.org, AJvYcCWoEVJVOisOon5Fj/XLIpT1VrepSietQim4hCfLdPNfHom4O84fT82BV7apI8x6gzKJb2TlN4ReaLifekA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVS4cx8J3UkILaw3ChmjatuOBwLgPJcUNF7Fqd2fTU1n52xAJ
	T4Cr7G9cDbyLB7bac4L9ZgI15fNndIM60J0rb/JZfaHRNRtXqORFIyX1
X-Gm-Gg: ASbGncso62H7EI8lZ5k+71ocgeXVI2B7QaZ6Cptddwk8bRnRp1Yl4Uqy/gXF7lOfZ4n
	K64OVr/ctG7qf5pN2RRJS27OTOT1DO2bRUT1Jzymovct+ko0Mn1s21ysk49SUjOlAdMxIPKO/2f
	Tsm3xozp1ZAHP60iP/w715Gfp70dqrMDJU14ZLBZZ6VbasBaGgTMBNwEDQ8fUhDULZOnwFZWICO
	aSLpiB7zEW3QZpFc1puayv9tdjcuz288FAeKYctb3D+rFWEiVyrVyVvsix+Z8HduPheVV0H5gUx
	yqsVBdOQx3P4I36MoyP+JEDb06ohbpFMXdWIZf0IWWxO9GioaIwwSKWTQVKz9iA46mFwdoi47Fd
	sYKQVvxvZ/a6kBAJOgd2L93EpbOPC3KCB7g==
X-Google-Smtp-Source: AGHT+IHRDrwIqLy1jEbtSqSqvN746zSHJoxzTOEvPir9lWxDgi1ES60E1Y+f5intsZOWBgUL6ZZ0Tw==
X-Received: by 2002:a05:6a00:26e6:b0:76b:3ae7:37a8 with SMTP id d2e1a72fcca58-76e0dfbc448mr114951b3a.7.1754928220402;
        Mon, 11 Aug 2025 09:03:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c46a05464sm8580160b3a.96.2025.08.11.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:03:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:03:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] x86-android-tablets: convert to use GPIO
 references
Message-ID: <4wl35ypnwhklcloiqh6y5ejzhuhg24e5ogzo4flph667ft43pt@3pzl5fbv7lbw>
References: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
 <bd6a10ba-d83b-4bb2-8e69-7d985eeb5162@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6a10ba-d83b-4bb2-8e69-7d985eeb5162@kernel.org>

Hi Hans,

On Mon, Aug 11, 2025 at 11:41:46AM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 11-Aug-25 4:22 AM, Dmitry Torokhov wrote:
> > This series came about because now software nodes can be used to
> > describe GPIOs (via PROPERTY_ENTRY_GPIO() macros) and I would like to
> > eventually get rid of gpio_keys_platform_data structure.
> > 
> > So while I was doing the conversions from GPIO_LOOKUP() tables for
> > gpio_keys devices I decided to convert the rest of them as well. Maybe
> > some time in the future we can drop support for GPIO_LOOKUP() and rely
> > on device properties exclusively.
> > 
> > This is completely untested.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > Changes in v2:
> > - Reworked on top of the current linux-next
> > - Link to v1: https://lore.kernel.org/r/20230512001815.591817-1-dmitry.torokhov@gmail.com
> 
> Thanks this is an interesting series. I don't know why I missed / dropped
> the ball on v1.

It's actually on me: I sent it as you were reworking/adding more devices
to the driver and I was supposed to update the series but did not have
time.

> 
> It will be a while before I can get around to this due to travel, but
> I'll take a look and either provide a Tested-by or fixup any issues
> I encounter and then post a fixed v3 myself.

Thanks!

-- 
Dmitry

