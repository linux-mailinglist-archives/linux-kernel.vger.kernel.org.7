Return-Path: <linux-kernel+bounces-821128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B26B80815
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A832146673E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22484337EA3;
	Wed, 17 Sep 2025 15:24:52 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA4333A9D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122691; cv=none; b=XQThnEf1ZXjAUh1ZdyDN9zzEvpVwXgkXd4uy4o97t/NJEGfVomH57aI8jshfE+n+u25K0/VriMuPne5WyS5pUak7eBeoyrkV3a2U8OHtJUHjyHZrqM3XU5tB4lx5Q5+R+/g6sdWuXAw9L1SOXLu6N0wKebVglleBVOBOf6dK4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122691; c=relaxed/simple;
	bh=3ARUkUpoBf83aJNRQ8BiAp+2Sc3izs7X4NYbaBnVQgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TeSwh983oqowjKBN/awggIt8simAqF2AmzZ00OZ3Ix1MptOfPcVAoUxikFyrP3P4cRKfJDzPvzH8ercGYcsgKFe2pnxazAV97ncDAwf5JEi/sA+Afkw49sJifLwHSrNEUwmYvBBG4a6+1nYaBEJdQXLHMDViefkC7QlethVf7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so5525844b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122689; x=1758727489;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bY/asBqVOnDWFE5LcHmnDOT5AoWMNTr7WSHO+9CO+k=;
        b=TqcdWK87tVZm9og9hkxpeZyk7vghMF+et+7JEYmj44byIa87lpR/TDZZQDfJjj7cFz
         txENxZ3lBiVWDP3gn/AajLKAXL36ZOhK0NvVdkFYA5N+OuJKtY/jKS3HSEXPDSMSjkdT
         s39p0DU7uF1oWWv5saYN1O6JB9wMp3kyyIOYoMzhQLqP54JY0UNCvnxM0snbckvt0dxz
         wlzdPi/4+58xfVRdKB4Y1qr/8V6F5cIjQFhXP8TlDn/HTIrO5y4wSIBwNwKxhaqCQeRJ
         7mCAVmjyGv/2CxQYIMDqC/2OJoHBWJ/hwqy8qoN05ZkAcv3i7tkYElQ1dtMBrZfmddTi
         Ay7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOskXoruk8qur/gIk28aJdkMWtQNRIaGg9q2ZTytC88BrWE1LEnKVfBzIehwhyPi4gtbSpw1O1MA2lwk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMi2krdWZh9Vb8Hw8qEfQgFdxrVboEZmzkTySkLa8Q7HRQx7b
	h5ANINkrygmnhOhcRM9CRFyRddgf8289kBcxWsPtNYw7D/CUu1mj3Kh4S9Jauwjry90=
X-Gm-Gg: ASbGnctZxfM6L9bXBN0WjWviFlyI+WZVhuu4m/nsQBEnLms56oRwC5dd5OBaMXa47ix
	yVwb9sSbWzOCtTKkLJaAzoqpWkUE1BwKiyYdxMwrKm9HEgeWT/8F9caomFeeA92uaWz2Kxv+zjo
	VEBLHYzAPjl1x1ZnvLPXDkE4nytUIOclQwByDpYFuu+/AgKaYfhBiKhBEBV1NlXrl+wSqrRylh0
	IkBkMwXFxJtYq4NvAr1pS10B0k+6mtAmN1nGY+zD3xOEnuGzSp/sd6Fco5AMW7U4DF7aQR5Cosk
	ExqDHART1ni6UfB2GHNqpbq7heCptIw4QrPuNhsU1OjjHGsGA5uiriZadFcOnJybMl9SsLNMWM1
	jAMtwbJcZvsAbP6Cy6QMt
X-Google-Smtp-Source: AGHT+IHJBEGVlWAkDnL7p8aPBmpzPuwLI6TVt47t7wf2wpFW3MFRt1QIyIXPCIevSu5aQ3ieTqwwuA==
X-Received: by 2002:a05:6a20:2449:b0:24b:1a6d:298b with SMTP id adf61e73a8af0-27aa3cf5b6fmr3447692637.34.1758122689322;
        Wed, 17 Sep 2025 08:24:49 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b65dsm18800938b3a.9.2025.09.17.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:24:48 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Michael Walle <mwalle@kernel.org>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>
Cc: Andrew Davis <afd@ti.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Michael
 Walle <mwalle@kernel.org>
Subject: Re: [PATCH 2/3] clk: keystone: don't cache clock rate
In-Reply-To: <20250915143440.2362812-3-mwalle@kernel.org>
References: <20250915143440.2362812-1-mwalle@kernel.org>
 <20250915143440.2362812-3-mwalle@kernel.org>
Date: Wed, 17 Sep 2025 08:24:47 -0700
Message-ID: <7hv7lhp0e8.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Walle <mwalle@kernel.org> writes:

> The TISCI firmware will return 0 if the clock or consumer is not
> enabled although there is a stored value in the firmware. IOW a call to
> set rate will work but at get rate will always return 0 if the clock is
> disabled.
> The clk framework will try to cache the clock rate when it's requested
> by a consumer. If the clock or consumer is not enabled at that point,
> the cached value is 0, which is wrong.

Hmm, it also seems wrong to me that the clock framework would cache a
clock rate when it's disabled.  On platforms with clocks that may have
shared management (eg. TISCI or other platforms using SCMI) it's
entirely possible that when Linux has disabled a clock, some other
entity may have changed it.

Could another solution here be to have the clk framework only cache when
clocks are enabled?

> Thus, disable the cache altogether.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I guess to make it work correctly with the caching of the linux
> subsystem a new flag to query the real clock rate is needed. That
> way, one could also query the default value without having to turn
> the clock and consumer on first. That can be retrofitted later and
> the driver could query the firmware capabilities.
>
> Regarding a Fixes: tag. I didn't include one because it might have a
> slight performance impact because the firmware has to be queried
> every time now and it doesn't have been a problem for now. OTOH I've
> enabled tracing during boot and there were just a handful
> clock_{get/set}_rate() calls.

The performance hit is not just about boot time, it's for *every*
[get|set]_rate call.  Since TISCI is relatively slow (involves RPC,
mailbox, etc. to remote core), this may have a performance impact
elsewhere too.  That being said, I'm hoping it's unlikely that
[get|set]_rate calls are in the fast path.

All of that being said, I think the impacts of this patch are pretty
minimal, so I don't have any real objections.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/clk/keystone/sci-clk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index c5894fc9395e..d73858b5ca7a 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -333,6 +333,14 @@ static int _sci_clk_build(struct sci_clk_provider *provider,
>  
>  	init.ops = &sci_clk_ops;
>  	init.num_parents = sci_clk->num_parents;
> +
> +	/*
> +	 * A clock rate query to the SCI firmware will return 0 if either the
> +	 * clock itself is disabled or the attached device/consumer is disabled.
> +	 * This makes it inherently unsuitable for the caching of the clk
> +	 * framework.
> +	 */
> +	init.flags = CLK_GET_RATE_NOCACHE;
>  	sci_clk->hw.init = &init;
>  
>  	ret = devm_clk_hw_register(provider->dev, &sci_clk->hw);
> -- 
> 2.39.5

