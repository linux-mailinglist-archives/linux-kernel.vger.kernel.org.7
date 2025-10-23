Return-Path: <linux-kernel+bounces-866973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EADC013C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1754B1A0221B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2403054EE;
	Thu, 23 Oct 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTauvhe9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9B307AF5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224122; cv=none; b=GCTFWxSw6CfjAX/7xfIlUh1NDRwn/4AmOTQFOCoytH5rmmSAkhngteAWQPzU3oYh4nOnZQSY9iOwnaHwUBAAG4boAkbWM3XMjjxOvJK3NXUm1D3yGbW1Kr3U+xI2HRtpmDSz3VfnzgdLOxqPdLP6AJh3LkOtA93G68SjlTAGcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224122; c=relaxed/simple;
	bh=EVTagyqNhFiyLAemMH3mmpGfmO5zCC1M2qik2CwJLjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlybD5HDd9gDZDx5Bz3UoLMmigjr/1a+IXxjYebt3kXIDbGWKMAduOgcCLvdP5G0MCXHfpVWvReACJrc4xVmefAxzjFtZp0Ovf7gSe5m/O7lLZIMDGLHKW/0XPopWd/d1q/0PoWNIgcpGIzRGZnUMTX27B8boIypJ87AZAnz8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTauvhe9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso573538a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761224121; x=1761828921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASWAVqY9k9riShYHA9c4yv4PgU9rmPYL0SfM1V+LeDk=;
        b=FTauvhe9smUzHYpq4Nwe61mw8U6tzuKkXTfvrlU3WZETxGZju3Z5MFtStM033edCdR
         69vOSdI7BQl4mUYSrJ0r/O7SxM5NPgmpv+N1h/7N1D3FyhOmBnMqiAS1mDNG38mxUcl8
         5hg6GTrLJir19Hez7XQsQqr0n0Ir2J5R7XPK9IpPf7I70F9cdKIDAXdAXGRpWWoT9MSm
         4zihRsq61gJlMhebJccTGdZxRp2LIctSyuv4d7HtFyOJs6gOyMOJfzCJY+lsKET5qV+I
         s/FfuQdK4drkjIvzKuE8tA3XAJ/8RSm68zSrkf5KSk3tPVuWHGKjxUh2TJmzYMAdLqR5
         3n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224121; x=1761828921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASWAVqY9k9riShYHA9c4yv4PgU9rmPYL0SfM1V+LeDk=;
        b=cRBr82/EEZa4vpBDLpliQZFSrYLO8N0lvnbUcAkIoCBYWKM1x383ua/LECNy2CVevw
         ytXpRgXLIqDro4+5MhUggBesUvgS/gDnQVF1urEaZMRhwT2m3C7tQtiTFIUAMbwlVWGc
         fH7KHG8ZskbO69fsz9zNREIVHCm4K+hEwy5k3dSUM76hu+jRG3y4M6hbeXxM0ix2j+Qi
         WDRcCLRMO8lOusbx4t1oPOnMJowyCOd/lVonrb9c+TEYG1ITxu1jxEnYdfa0sTD2H/Wx
         oBhZ2xGyLxre7NoidNTQ8h9Srh+slP85KXOy6ynhsqMa+a7KSkG+K5/1owJHMHHpP93z
         isPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSGDhUuy5vkF2Jzd5jZleNmqYb7NwjWZyAFui1A3WYuhFlqXmm/xoqcd6/Uo1FT4PBgVwm1apYPeZZwO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLywSQO32Kc89eXaZLPeLKKuQH4C79pb1YIJyVf4gsQG+68Dy
	slFzp7Dni/xxv3LvlFmtv7imJ/gecPEzsYnz+wUiNUkIDb6TXAyDgzsA
X-Gm-Gg: ASbGncte2uN5cbZvmYMzK0VYp4v7Gx6zMhj7guQBULOBK5bvtFBY32/cSKhdBjjM5sK
	MZ06WtxC1mUc9NGHvarfVWcrji4A912aw7j0oRvNrMNypTJvM23IC/1zkUmNuuA0360QbXm+qhz
	x5w/5pZuDHP2bFdGbQpdMw1orA0d3U2clpQuFgYu57oNGX6lORtbZe5sssRZ/aoOJoZYkeH+FRg
	ITu0IZlP3NC9kQiHX9ESYl98uyt3QtPD+79ByxfX0cACwoupLEuqVdXBsBg7K3xGmKyTop1PnC1
	sdnzmxxHJ2DgLQ9wTVWtV3W8wqG930uMamT+HoR/Ze9au9hZYqFbT0eVjRbcGDanYRR9kPsmHEy
	728/8C9G4ykuTMczDowbtIgG1FBiyxsoABS0JVKbKCUH/y82lu7k6AN8OC4+0amryhnK6hu/SEd
	6eQ9GSMpZzRRAvlccM0XnvxK0f3h3r4um2Bw==
X-Google-Smtp-Source: AGHT+IFlM93HSaK/NP7A35B/3WN3MTp6LhxIIWar04bWFUVpNF5QQd4VVvlw7hDSQJ2i5iOtzexD4A==
X-Received: by 2002:a17:902:db11:b0:240:48f4:40f7 with SMTP id d9443c01a7336-290cba4efc9mr373999375ad.39.1761224120623;
        Thu, 23 Oct 2025 05:55:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c053absm2044988a12.14.2025.10.23.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:55:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 Oct 2025 05:55:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/5] drivers/hwmon: Add TSC1641 I2C power monitor driver
Message-ID: <cea96330-5d7a-4fdc-8fc6-0067769a0b2c@roeck-us.net>
References: <be691214-bac6-43d4-be62-daa57c833fe7@roeck-us.net>
 <20251023075050.254998-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023075050.254998-1-igor@reznichenko.net>

On Thu, Oct 23, 2025 at 12:50:50AM -0700, Igor Reznichenko wrote:
> Guenter,
> Thanks for the detailed feedback. I will address it.
> 
> > Please send a register dump.
> 
> Here's register dump after init during run: 
> 
> tsc1641 1-0040: 0x00: 0x003f
> tsc1641 1-0040: 0x01: 0x0253
> tsc1641 1-0040: 0x02: 0x0dc0
> tsc1641 1-0040: 0x03: 0x0053
> tsc1641 1-0040: 0x04: 0x0250
> tsc1641 1-0040: 0x05: 0x0033
> tsc1641 1-0040: 0x06: 0x0000
> tsc1641 1-0040: 0x07: 0x0000
> tsc1641 1-0040: 0x08: 0x01f4
> tsc1641 1-0040: 0x09: 0x0000
> tsc1641 1-0040: 0x0a: 0x0000
> tsc1641 1-0040: 0x0b: 0x0000
> tsc1641 1-0040: 0x0c: 0x0000
> tsc1641 1-0040: 0x0d: 0x0000
> tsc1641 1-0040: 0x0e: 0x0000
> tsc1641 1-0040: 0xfe: 0x0006
> tsc1641 1-0040: 0xff: 0x1000
> 
Great, thanks a lot!

> > > +
> > > +	/*
> > > +	 * Disable alert mask first, then write the value and enable alert mask
> > Why ? 
> 
> The idea was to prevent potential previous alert from propagating when changing 
> the value, plus to only enable alert when crit/lcrit value is non-zero. 
> But given your response below this is not the right thing to do.
> 
> > Disabling alerts if the limit is 0 is wrong: The limit can be set
> > to 0 on purpose. Only unmasking the limit if a limit is set is just as wrong.
> > Either limits are enabled and reported, or they are disabled and the attributes
> > must not be generated. Mis-using the ABI to declare "If the limit value is
> > 0, mask the limit. Otherwise set the limit and unmask it" is unacceptable.
> 
> Thanks for clarification. So would you recommend then that all alerts should 
> be always on/unmasked for this chip or to add custom sysfs attributes to control 
> them, since it has this capability?
> 

Almost every chip has that capability. That does not warrant a custom sysfs
attribute. I'd suggest to just enable them all.

Guenter

