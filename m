Return-Path: <linux-kernel+bounces-693260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11941ADFCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 07:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686983B9009
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 05:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8E24292E;
	Thu, 19 Jun 2025 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbljeIXg"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56423A9A0
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311356; cv=none; b=l3D7bk/sJeFI5VgIylovtRV113NHIjlXhXjWYX0GA94ybqwW9CNOVuBZvSiDpaPN8PbqEBnFuOjT5MamT5pPHdS3b+uyiL080JPWnbmN5O+GkrISBTiR7QiJFIcYNKrTz2U4vAh1ZEg2tWPCROV0IPu0jkcs8a6TdWhmo3iv41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311356; c=relaxed/simple;
	bh=3T6kJuyoKBc2nft91aab5hLZW+0/3OZRvkSZlEz+xsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpXBnKS9Gh++RrhX+4xAuUNcPDhfVB/cdepqJPD9+B2GUvsEugECb8o1z1xmCum0zQ+VcfD2pZYjgN5w9PRt6f3VpMuHK/w6GDfsJCazaBO71CVqTy1XYnI6QaYpEqt9+U9dCF5nYwiA/USpFJDhBzMcxV6tAH5Z6nWQVxaDkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbljeIXg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2d46760950so489909a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750311353; x=1750916153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbKgKaSzJXcq3MoycGVCSzlp40V4lZ1OfWmFaWrV5lE=;
        b=AbljeIXgWzc5HyaqF0LJ6zpYffGY9+wpulok//kNaTbZc6/TkJKAKfbrmMzw8rS/f+
         haPbdNy/VGgCmafJheFGqvyz7DxHbQxAi/+Ot3I76MYlZv2D48CHQBT+Av6dm7TbY1TE
         w9ZOnR8rxJkOnB3UidGtNObmm31bntqXMkp+2WZF9cqc8VdQrESEHPPM+O+7qegW1oED
         to7A9v6pZ8169cDLSIADe7i0rBCa8cjYXWYZDwMskHPiwYly6NhB4oPimrYJJRmI3rAW
         IJWFhjKFxKzLPibGNhMNTnH2uShn2AlAwSVeDEqQj/po+cpsEeC3VQfJ9R0YAWDegqah
         xD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750311353; x=1750916153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbKgKaSzJXcq3MoycGVCSzlp40V4lZ1OfWmFaWrV5lE=;
        b=AMvP22bIKIz5TsSUwpbnN0oZrQThRj3NLSBLQXBY88IWsg7sY+7TxspUqpgvSJpVNK
         /sn1naghAzSHcruF47GR+kv49B3uj+EpmJ5gEiC18I8jqS8HEmW2O0TEgqkCiN4xCwEV
         ScexQ4JjoE78Y8RXGzayCH44kyRE1jjeBqGFaetbo1GH4CuZ+BA6oxFAfZopqyNXcR0+
         k9f1rDjCLbqbzT7tBEvy61TX18p27Wk7YrZG6D2fksOmKJmTQKi88eXbaZRg+mc9vUWJ
         xyN3yI9oyxfiDL9P2WUy0jqwNZqq0caUOLKEtLqLwF8VFUCTvNdR3SdP0cK7t1GUkWNU
         Fb+A==
X-Forwarded-Encrypted: i=1; AJvYcCWVFAjmThmKQZ/Uo1C4F7p6bC4TDpmUwc4GopDJhkmVe6dQ9bGqzXNxGOS+cJr9k7GWpSrTT7iSQsCqiQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjc7zni08HS8b7qu3D/rPOqPCb4CkmfRqufeBjCMdSVeiPpLt8
	Rhb+woWinkHnxLNE3mhuNfQj0BEZHBgn6ukPecRqJ/A3tTCjwuUo42o/0BjzKst6if4=
X-Gm-Gg: ASbGncsRY/ZjRuUQ9AvVlFVFulvrIamf+fXRhX231qpYxF/xxfemgSPZd76q0+Cn1Dm
	rBSq8XyQwaTB9ao+uvDQdX1OHwnKCl36fi2Gko8M+Fbpy0j1IJuCX3zLN/0kn/Y6IeFp5B4WXse
	9euPYjXz4hGgqfvHUrM/9rlhB4rsIpgDa2+FEIVg1a7/c0spqjQbj+GvPCJchHbYSzHiCLElR8M
	917tXrql5dzBeh68VHATiYQMMwyZLk7UxRBd5ky5I5RLADiHoRkU0fbJ/emiyxc2P8PeMv43oR3
	WSWPBTzxRQkL1zD2wuU4GvNCNxK5WGvzwCQ7eyxBbUF4nFNBKAYx1VxTZxB0cR2VR6xQ96rwFw=
	=
X-Google-Smtp-Source: AGHT+IF1Brl2Ml/RhPp1ZISh/ybbgy1I/Aosv1oeoYbA3EE1IVQw9sjB8PhoTnTOzWYQtjW2ZHuZqQ==
X-Received: by 2002:a17:903:32c9:b0:235:a9b:21e7 with SMTP id d9443c01a7336-2366b3df793mr286985355ad.48.1750311353385;
        Wed, 18 Jun 2025 22:35:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c0c9sm112008655ad.20.2025.06.18.22.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:35:52 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:05:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sven Peter <sven@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Ulf Hansson <ulf.hansson@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-input@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 06/11] cpufreq: apple: drop default ARCH_APPLE in Kconfig
Message-ID: <20250619053550.hogoo7ic5igvex3c@vireshk-i7>
References: <20250612-apple-kconfig-defconfig-v1-0-0e6f9cb512c1@kernel.org>
 <20250612-apple-kconfig-defconfig-v1-6-0e6f9cb512c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-apple-kconfig-defconfig-v1-6-0e6f9cb512c1@kernel.org>

On 12-06-25, 21:11, Sven Peter wrote:
> When the first driver for Apple Silicon was upstreamed we accidentally
> included `default ARCH_APPLE` in its Kconfig which then spread to almost
> every subsequent driver. As soon as ARCH_APPLE is set to y this will
> pull in many drivers as built-ins which is not what we want.
> Thus, drop `default ARCH_APPLE` from Kconfig.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

-- 
viresh

