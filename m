Return-Path: <linux-kernel+bounces-768621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE3B26355
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E835B883D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBC3019B2;
	Thu, 14 Aug 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX4kkgce"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDB3019AF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168519; cv=none; b=eQpIbRL8DUGQhtGuUTHZQkz009jIvccs0yxNy33Vu28GjsWIwE5bb2w0llJNal3RLk3r5KVd2Ms+0syFH0GgqEzkSiLXPXBzAD7hDumqqsxUq28n0eZGKiYQtOlGS5m5kCiIWFnAfZvhzK3gH7Ly0foyN3c0BaIxyKlJnyxD4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168519; c=relaxed/simple;
	bh=FQGlBlcT2MyYsRUxs/n2cKPAgiKMg/IMnXf900fPWI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT6pc7dYOdIXyOTWVwb+DwUSFydNfeyjOADK7Lhgt5JE+t2kEH7sNCIfy92bYE5fJ8pB+T4/fQWc8RWdMdmDgIUxqWtIrqTVTRJ78Ah3Dc6aw7hNqCD2i4luspfVE8r3cC4MPlFHTx03BYFaS2MrfQl3vogkYJxtq0WQsI+lPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX4kkgce; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so4012565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168516; x=1755773316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bx3TLXqBYw25yeKL23bBB3cn7ttnh+0Nz11O8E+7Gi4=;
        b=BX4kkgce7q54ooMDBJSh+i1UO7CDEfo4kLIylQQcWO7eF3w7Br8P7Qw4MTOd27bcbB
         1FtO4KdDUvipkMMmm2uhQI2RJrmhrY53N7Ahep0Zs7eZrHJbYCBaM9D8aoo1uGmYxZ+B
         56t2rh2S5QjjaNo1t9tDHDei8SWzeevUz9IEC3vNBlqLO375EFdtmX6wImmE+j5GCMT6
         GEOA8MSTirup0Z3mWaROzRAYwP8jplad6mlpQwz9dzmdB0IoalqA9+hl9wgOi9jOkNKG
         UJxSUfgeKzcf7rYZZ/O1g9s4BLeN8ri+7u3Gb83LEq1go22N8E8RTyBXgNPK3BVwC7+Q
         /Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168516; x=1755773316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx3TLXqBYw25yeKL23bBB3cn7ttnh+0Nz11O8E+7Gi4=;
        b=BqxcrUcIGCD1zXktkfojYNL/SPtGsqExWcZ22G8/rmot3n1FFSGPnuGFTXPFRde867
         OkADIHCIPqlAqj3JdzWSboxdzLCP5EySvqJUYd3p6yUWZje1cCrKPea0mXxcQota3PfM
         KB6lXYbMYUpUEYuuqePbC0/aQuSCEwLYRjSZBVNV16spSnEyComw6XVrEQD+JlWs8fku
         AQuYmo0lwMnYYSrBn6jzSraax9t6kbMpPUDVzqQ2pI5tsAFVdgJrA/4xa8HB/p7E0UJt
         /EID+pLtLvNUJncUAp9KJblh2ZHB5H+xfb9efb9zU7jIRF3d/RM2vN6QR7wF8DeC7Y4G
         /VUg==
X-Forwarded-Encrypted: i=1; AJvYcCUZlihNOpbeKHl2JNzdZZrllmq9dpWLCAd3JVeBg1eNaIxle1WLxG1/1va//v374ZoRPPzA89EWvPFcKeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDsRW64Ey0yk2yAYWHkAVIfQbjHAiWemcE+CpuXhl9luDGib2
	p/xZhhiTWgD9P1718n8i2DO/JWRDJnqH9SizyEp42e+EiopJBwF9wzpF
X-Gm-Gg: ASbGncuSYwLKAgJst4pKPYfjlldoBgBivANaSReAab1LmTzCVvZPPREmBNPkCL9JeIC
	mCWFeGNpq0NBDsvG12QDbJc9qd5rfPl9Quh7HQpv9hqSKJO5gFbWrPBIkM5Hq2vTxX8jCjZo+KU
	wSHbHA7SMRwCyW5DyPfDovaHEnwCt+fjlVAfvDr3yEsbS5K0/JzcxyYj2CNF5h3bm5A7jR3C4h8
	gsNBQVyGIJ2xdMXTh79XBFJOT+E583nzyiKRLqbd4PkNYuLz723AwT0rJU4rSHzW1CLXqKttuRt
	hoEK0B2nGAxf1excaTyX5gnOOKvRMLa/sR9MnPOsoB4s2Ui/Y+zDD8O1pFKCHqZUagfDYDJcHQd
	W/S7weWnTmA+HnpAUQ0A=
X-Google-Smtp-Source: AGHT+IHUSrx9o55tnuafu0iaeaUk7fJBlAIEsurRqxxZfH/C/pGJWTRbXbtYKqzH3DXCEt3LQch0Ag==
X-Received: by 2002:a05:600c:3b1a:b0:459:e440:61c7 with SMTP id 5b1f17b1804b1-45a1b66a643mr23116765e9.31.1755168515763;
        Thu, 14 Aug 2025 03:48:35 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5d7deaasm29741838f8f.65.2025.08.14.03.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:48:35 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:48:33 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, hamohammed.sa@gmail.com,
	simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Assert if vkms_config_create_*() fails
Message-ID: <aJ2_Adfr-ZC9tEpy@fedora>
References: <20250811101529.150716-1-jose.exposito89@gmail.com>
 <91587a35-f884-46ad-9869-126d3efbfc61@bootlin.com>
 <aJr92bN5iQnIzTbP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJr92bN5iQnIzTbP@stanley.mountain>

Hi everyone,

On Tue, Aug 12, 2025 at 11:39:53AM +0300, Dan Carpenter wrote:
> On Mon, Aug 11, 2025 at 07:21:18PM +0200, Louis Chauvet wrote:
> > 
> > 
> > Le 11/08/2025 à 12:15, José Expósito a écrit :
> > > Check that the value returned by the vkms_config_create_*() functions is
> > > valid. Otherwise, assert and finish the KUnit test.
> > > 
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/dri-devel/aJTL6IFEBaI8gqtH@stanley.mountain/
> > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > 
> > I am not sure on how to use smach, I don't have any warning at all for the
> > whole kernel, so I will wait for Dan Carpenter review before applying.
> > 
> 
> Looks good.  Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks to the both of you for your reviews :D

As a side note, I also couldn't make Smatch to report these warnings,
so thanks a lot for verifying that they are fixed.

Jose

> > Side question: should we use __must_check in this case to warn at compile
> > time?
> 
> We wouldn't normally...  It turns out the existing code was already
> checking for errors so this is really just a "silence the checker"
> patch.
> 
> regards,
> dan carpenter
> 

