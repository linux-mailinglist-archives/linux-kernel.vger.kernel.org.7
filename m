Return-Path: <linux-kernel+bounces-802321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C363B450FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E817FF7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2822FDC24;
	Fri,  5 Sep 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="W7LH4ISd"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1392FD1A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059971; cv=none; b=GbSr2zkOrZCEvj/ui8fzA9ujdIWGdYf49jFZhj5hBD+ZXaEThltQL+55d+tYi7grdJTF+psrEgzB3r3BVFmPOXTeitU31olscD3joe/aoifaD9+0vSb/kzWy3o8ZH2e3qGE+KIYSlegahgLzDwrn3pM7HQu865J+ys0xuVBb9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059971; c=relaxed/simple;
	bh=QNCnBVfzbZNiOOovghiEodPKf1tnotCU2pQKXJrMrWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOe37c9ujFuDrTxfYBir1kXCMtDsKx4P60IFMAGmnNTNNg6tIjVwxmMloUCYOCD9q3zcKEnLdlN8eqLTIeZ+vK1F1HsQlNqTRziDWfoTfInKiKLi3bW3+7WwUJfRvNvYTqzHp1coyUUU1MpzIL8cFuwisA+kBP3ov3aUZUmTwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=W7LH4ISd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8960b48aso1251135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1757059968; x=1757664768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GsSlj88KDJUopgbpsaUO+WZlul/yjMIpN+zX4T0J6tA=;
        b=W7LH4ISdHLq24xQkqO+Pr6Hzv5CsZkgZ/UGODlDwW9DHIH2rUyYxkVliJJv2GvEfHP
         cBeQi7ClqVDKDYZun8G8zvVi36JulwICyboJZhF/80dsBY77tbcJY3RuYR3txWybybl/
         t5UkgMfpNKvJ/P+gEapOS8G2Z5k/Cp/SaQP+jGaMNyowUosXQgy8cJQmVhW8awv8qIH8
         T/3YyURHXTclb9qu1HtZtvbPm4RP6GFQkHtI2CFsZBxKx1Y3fc6JVafLhq1K3GaiMS0o
         Igv/eaYBaozi5P1c9AZ/k6fJegPGIQMNYAh8l+zqT4KXvT1Mohy+pqlh5trNmqNhSvAf
         7wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059968; x=1757664768;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsSlj88KDJUopgbpsaUO+WZlul/yjMIpN+zX4T0J6tA=;
        b=nQzlTweM6lT+jtbm95HMMR2kfBGCa60FZviwav+gC2cwB8RRe2/tNETYIRMUF8wEHM
         QixQFpibBYtAfV7GNXJgKyJyh2IkBj4ewtWxYSwPcQcdFEBRXGyA5iu1GefmEVknq2iw
         LW9Z7nx6xbOTozBVezANxZg3klKQYDBPHjY/vPtPsGrQG/JGnM5vjb0vNxyibw55X9yl
         Epz5tPLEwB/LY2SfXDXfjEdZyuBNw6OUOhs2fofLOR0i90KBl3/EjYB3BY6vsh3+oN97
         yL+bC7z/xDrLkRbdoZtu2pRyQg/nVLIExNqjFndC4m0Y8rmrzAyuYvxq7Yz04D545o1f
         xFFg==
X-Forwarded-Encrypted: i=1; AJvYcCVdEkjxkdYGIRgIyh1oyVACUDlM1Rqf7vP29Yb6FOE3RQIHNwwACrpt64T9eS9dWo0pAXilsZXb8BNjl7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgDcJZI9gBcHFGe6KjIW86H5mQUr4S8wI6WeFQOHDONuOU5DW
	pa4OYhxiAvA05vP7hYpE6T1vbOOyvkn7ZusfqeZ3VHnB5UNNGQm53/FDIjzt+4tNCBw=
X-Gm-Gg: ASbGncso592sh2u+7r9SxWPM/TzVExCZYFQvuGf4tmx7muE7TIoOTRamsSnRvpcsd5A
	uLokbnSzW3l1iETOZtP6ky0/1oBjvjkx4a8db3uU5IStVH8fBv1T8dOkZv1WCaz5g+G9wYrkEXf
	WEBY31UvF5SVQteEKzWQGs6P8KFBuNhgGLfJB2Eu+I4x0+Hf3z2KCqrC78JJq6m4dIoE9c6H5nR
	25zw8KFzcvWdEHQ4JCYnqwtzJWXMicqlYi9KkpLV1NWsfj9PeKSZlkwTuriciImdFfwhQj+bEv/
	p3P+fwpks7wfIPNrnYDic2Af2PwKCKM0fUHb19ASCp/rEOnwBjCWPZQuEUBejy85GuD8Q4HZKbN
	5Vpd7LN2UwLVPRu5WTL6vIUF/0RESF3fq721GVSEmUkn0Kr8Layv13QB9bEyedmGgqawugJ7WiO
	Q1zXbz1PmUEFYFrLtxFUpY
X-Google-Smtp-Source: AGHT+IHWrN9p5XeGjFAEXjrogbk7f2reVbPwgk1/9j0dRF2egSHn1DCR3CU9220t0onAp9N6UA9Ndg==
X-Received: by 2002:a05:600c:34c4:b0:45b:8a1e:3b83 with SMTP id 5b1f17b1804b1-45bd8a2f401mr49361985e9.8.1757059967617;
        Fri, 05 Sep 2025 01:12:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0869b33sm68367345e9.9.2025.09.05.01.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 01:12:46 -0700 (PDT)
Message-ID: <ed08170f-4c9b-44df-9299-6bdec5aa5d38@6wind.com>
Date: Fri, 5 Sep 2025 10:12:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 net-next] ipv6: Add sanity checks on
 ipv6_devconf.seg6_enabled
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903115648.3126719-1-yuehaibing@huawei.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250903115648.3126719-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/09/2025 à 13:56, Yue Haibing a écrit :
> In ipv6_srh_rcv() we use min(net->ipv6.devconf_all->seg6_enabled,
> idev->cnf.seg6_enabled) is intended to return 0 when either value is zero,
> but if one of the values is negative it will in fact return non-zero.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: use proc_dointvec_minmax()
> ---
>  net/ipv6/addrconf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..69ec9cb6031e 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7192,7 +7192,9 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.data		= &ipv6_devconf.seg6_enabled,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
This sysctl has existed for almost a decade; you cannot change it, as it may
break a user setup that was using another value.

Regards,
Nicolas

