Return-Path: <linux-kernel+bounces-868351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B7C05050
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B44FEF28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F1302CD8;
	Fri, 24 Oct 2025 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V9KvNY0k"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9B2FDC3E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293803; cv=none; b=Lp/I4W3Rtin17gFIO6vLPdwJ+hOQORrR+oTRX0zBq0YZyFa11GjOliDbij5G33n0Afg1z+EVEMFVkMkSQkr2h1mv9YiFLsxGAfEuXlsS5KakbR0yeKYtzyt7A1f6L0oFtbfLfIE3gg4YCTiKm1pGtDyXKYseGjjWQpflltga4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293803; c=relaxed/simple;
	bh=RWdGPNS1iDQpL3AYAMrng6/fsuBkytsPx/WEa5J21x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXKX7WdnFBVbYXs8rrV+0tRqxby+6Hx2DbEOwIHXk0fdAK2GrcRKiHO0UzopKqmQwyOdl3A4NCdh3DQHnoqvgb8/5THfUwK6T62lVXlqujnjWi7zwett+uD2p6DDkHDYoHQWefR8ZcTVzCvOr5zvmwUpSk31hhVz81FwUQHw70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V9KvNY0k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47495477241so14473495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761293800; x=1761898600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5cjUqGbM0RrW05do79zm+nugfOI5OuKl18rgtRfqvY=;
        b=V9KvNY0kI67U/PdaJYXieop8BZiy4MZiedSzwXjemnFqsCbENvl/lA7gCz6OcHQIzL
         eiJWHzZxk7urBdwxlCv2X5tYbJD7YsYQ5zYjkdYOEmi6YSf+hQWxb/rcX2AwZb3LpzR1
         nkQmvDmsq0WaQZ7Ffc1NFdMOQwNW19vXZXIh5yNE1CxGKjBgy3rhCCbKLpfwTvDW4xDO
         6N0M2i/BaAT8lGP58ZNoDGGIinx6LvhTr1kaOKWif3GriTPFo99fcKHMmRJ0pQwsStc6
         cJRUvn3fOj2g+6FujJ6mOHKhfWTmLnTdJ86cisoxKz2rpTdtjHhqQFBvtbRLSiM0+FXr
         kXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293800; x=1761898600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5cjUqGbM0RrW05do79zm+nugfOI5OuKl18rgtRfqvY=;
        b=GkVkk1BC8NJUxBYt0kHP701kD3SMVsO/15FJRSmx7Ic0WN/ldLe8pSEWVukH4X21GC
         SGerq1ylJzw87vUQrcPymXQILaEKSg3Qe1vf6yi5/35ak2aWX3Tkhy3Hi4f/kUgvnGeA
         bhLyNzW77PSYcR9NjQaaTJfNRHQibvrtSZK6tWGRNoM8+JsHzdIpKxTrPU+68KGH4q83
         QsaDF7si24meT+JNOWE/iCbvqHuI5edumKLq35qFGK+ariNtMRyM34hVGb2WAqXvbcku
         bbGtUhzi2Mhj+nH2bcUlvBZbdPm9DIUoNNlIwqvo0+FhlPk5ryJ3MfTUpzLuXWVGpAJs
         DuwA==
X-Forwarded-Encrypted: i=1; AJvYcCXr5vhEFMo8riOmwZFaB+YU8jhnLE2pBdyev9KcbG8QHsg3oJfSuqiG2QBxaYwZKZXVI8cHsvuLYNym0YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jCdx3YF1W0V0+Ru6GIdYB9tEL81vjPGUy0AS1j5aqxitmev+
	J6zBxrXoi9xfp7XmxQr1JwCs5SpSO2lY2rOlgD4SnR3a63a+Sf5jc3j4LevCTTRYrlM=
X-Gm-Gg: ASbGncvVaDnDRAqYyjXY+Joy8ZapIjJEzQA71+qrwKVsfuC8BeUXJTvut/9D2CSKt+0
	9P++6bDaWopiKibDeKiXTfVxP3RS0dqkWrH26W1uE94tMQ9Z/XsSEViDlrSqb3hsKVFoimwFod4
	Cyzdh8uSxaZ5qK2vkxnA9M3kgOjFM4avIj5tZlyuhEbEcSUrjCSiLnph0HiixEABUYlL5JU4VZ5
	bkguS6EqzOVyygvc7lxiS0GhAxt+fyXcwNl9M0ZFlWQ2o6HgrrXKfRqr37lmwF9pJdZs7yoMLfq
	gCdEziT7qb/UjSvUNnwETBH0GkDV+KH0Ad8akEwlMJeUzuGFN7vrNCt4cSoiDD1UonCKJ5/8nmM
	8ciYBvT4K+ngi9kyqq3jypl3dY1CetZzGOfvMb+LytGv4tzxtByFRxunx4jY8mVhDteJChsTvKY
	5XZ8erXLBbysZ699GW7ojad9vltq2uLy/wHAvl3g==
X-Google-Smtp-Source: AGHT+IEjgDbqn3z5tjHECw3913ThgDrQE5n6C5KutSqEORLETt+ny0gQGMO4mUMda0NT2ai8gi8/9Q==
X-Received: by 2002:a05:6000:2203:b0:428:5659:81d6 with SMTP id ffacd0b85a97d-4298a0a9200mr3119153f8f.37.1761293799579;
        Fri, 24 Oct 2025 01:16:39 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298d4a49ffsm4043496f8f.13.2025.10.24.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:16:39 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:16:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <uez74rl75ner76kl3i5ps4huyxmzerrhananjw4vyo74tvev64@nk2lwjivr6ho>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
 <20251023063805.5635e50e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023063805.5635e50e@kernel.org>

Thu, Oct 23, 2025 at 03:38:05PM +0200, kuba@kernel.org wrote:
>On Thu, 23 Oct 2025 14:18:20 +0200 Jiri Pirko wrote:
>> >+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,  
>> 
>> Why this is driver specific? Isn't this something other drivers might
>> eventually implement as well?
>
>Seems highly unlikely, TBH.

Well even unlikely, looks like a generic param, not something
driver-specific. That is my point.

