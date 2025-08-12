Return-Path: <linux-kernel+bounces-764967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62816B22998
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D3A5A10EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57083286890;
	Tue, 12 Aug 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvaOZPvB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2127FD59
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006547; cv=none; b=XcGSYQqwHBtBZok0mBP8MVAZn0+6mvvRVpEwQQ+CFhCLoPgVT3zqADYP5TjC45jNss7fblaO/eiCi12a+s4OeRCw1yUbYlfaxP8Wxbok5UGujkv/ilPbH1zGMIAyesxCkePjFicwtFwPFiVPfxd5sdHcugCMlf4ykBO0YdKqA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006547; c=relaxed/simple;
	bh=zAL+HCudjRPYCWrv9McHC6ZrDPADT6Wmpz7N3ujlOuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE77PjpIMcwr6ZjBLE6EWFDp4J3AoKfAPm0C+wQV64ForVcUSUn6rVd/Qvx/8clWBv7KRJu+Y8+N28+nVUkQg50k+uv+j1054c+WhcpI/m+XFog2rQ/YNA07n/++CpCMIyty4P67O3XHi1vdySFBlKgdiq2fLoLAj7yzbbh5xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TvaOZPvB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78294a233so4649872f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755006544; x=1755611344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08lMMnAuZbexFUDswk//BS4zdf3W0OIMM3C3XcBrhFk=;
        b=TvaOZPvB/38g9iks9HVpWjY8GArzVMGnEf9kwqsf5fV3FUE+qT7j6MDbDtYMGQLyZm
         hyOW3emLjovmsee2f3d6wWRLW4tPHT957uZB/2fBuBtnQ/LHErFwuvPLb8Hh1YAAOk42
         VZgbmqLOLlRg8GzY1LamI5W1NqXiuxtyKTqVYEz5tXyZSzGVhyrRevnA189Cx66t0dOg
         /8yQjIUBTejtji6A+j68MPcCT5FNCqQf8DoPTah6d0iX3Rz56MMZcluhUJfG7TjDP6QD
         jh5t5r5qI8GNSXKjnkNZ1Pn2oG2spqa4eiKs8sTUXSZ5wIN9HzLTE40TNrZ6OPi5wojz
         2L0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006544; x=1755611344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08lMMnAuZbexFUDswk//BS4zdf3W0OIMM3C3XcBrhFk=;
        b=BNYRgFzSKZviTygBOYkQhE5bsZSacxPteftbXRiZKiwiP5lKFcwXT4VJ0XQeV23k+o
         03T1ZQ61th21UUjButWqF9djc1dv6wZvR76RCew91ksjVwEBLUUDdL59Z8yo7QqojXl1
         Eq9SQm976MkHNGopE4CTyPQRWeFJHGL6u1I2ahs1L+1W28MPu9Kl2IAIi9ZD2lEjOxUr
         0B1G9YQiVKWvTvUXQxArcjK/J6L5dvccopPMILyleJJ+JiMqZYiNcxTvn3qFqg7lLEEh
         OvWKtIA2vEXEN+nSmUpZW4HpJzFFd6GXItNoMsax9s0Omi3lph0BVuTw0QPYLSHyJN1x
         4H5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE/1oR9NOaLYcrpj6KQf2Q+xZaGRk0Hs+/hMVArYc1adWcJn82lFb198SRAj9NkKTsqvsoe31pK9B2hBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEECD8yxMhf8ElIG1ObcS2OEjgmSQ/jnfARZLb7604eKTjJ2f1
	w9vuJDyoe3nnTJQweGJpnLNdxvlArdNE4+OQ/ymomduo7iDuux+UJegIieAmwzFixRg=
X-Gm-Gg: ASbGnctLFhUVoexxFwvIcVc8aQ334AWY9+bzrsRHsptBE5OYXMH6ld62ft6TGR6F017
	H8e7S08jFxCJqFsG2e3ZfX5gXIMFcMyMufp1f3bJTWaSEQZ7+3JtxmCHQKLrPxdwS2ZUE1aR5N7
	i+PP4pgfV/uP7/eaL5yUYKrRUA2BYtrgj8HLYrGfXLQrgW8KMI79YJluhz/WXDubHUj0Tdccbt8
	0GSA8G5MlhYctzlAHr6S050puNlCvzlSp79S1h0m2DjI8DNMNaR5wSSQJ06GgxqS4zXKv5mD2Uh
	bsOBTHWDwVWVJekXTudXRqvyX6vatiwh7N/4M8yknb/F8uVoGmsVj2H561YB1/mKP1aD1j9yXTx
	yWfceyib1SqvKUUMgewn+wRGJQisHLZx09CM+4Xv5qVZJ95QQRZLjcA==
X-Google-Smtp-Source: AGHT+IGLBVpM+WvfEq6XCBSQ9vxuqIAnySFsZdyo9omq1H0RmQIZbDBjg8TJ5XIabgMb/NeqyMxdCw==
X-Received: by 2002:a05:6000:2283:b0:3b6:b020:9956 with SMTP id ffacd0b85a97d-3b91100ce9emr2878960f8f.43.1755006543962;
        Tue, 12 Aug 2025 06:49:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e0cd2c90sm351317865e9.17.2025.08.12.06.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:03 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:48:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Message-ID: <aJtGSxkRztAsy92h@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812133226.258318-6-rongqianfeng@vivo.com>

On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 3498743d5ec0..fb4183ff02a9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
>  	 * additional active scan request for hidden SSIDs on passive channels.
>  	 */
>  	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
> -						 adapter->num_in_chan_stats));
> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
> +					    sizeof(*adapter->chan_stats));

n_channels_bg is 14
n_channels_a is either 0 or 31 depending on if we're using BAND_A.
sizeof(*adapter->chan_stats) is 10.

So we're either allocating 280 or 900 bytes, which is quite small.  We
should just use kmalloc_array() instead of vmalloc_array().

regards,
dan carpenter


