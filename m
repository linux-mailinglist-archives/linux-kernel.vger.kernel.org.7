Return-Path: <linux-kernel+bounces-751121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E790B16577
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A4E7A8001
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C492DFF18;
	Wed, 30 Jul 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXRrcZEF"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13ECBA2D;
	Wed, 30 Jul 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896387; cv=none; b=u8gbYMRptgBux6r4Y6QIBq5d3Mmb7NJVwwveO7cdSrWTxLBCVqvZgM0EIBDJS9EiAhR1K1YSZjinkYtoZtEiG/Ep9PW13+Kn5MRqi68IVfxe0YPs0Mk+ArCduv1FyTVNnGur3B0LX8WIXXQjmSt82eIyASPPJcZe4759PUFmSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896387; c=relaxed/simple;
	bh=SlIdkKe6gfAEdWlgEkQodryuRjTZ3yr1OCuE073ILuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu+8fkxdu8sgXcN/HPwpg7CAACvU1lrb16hNBLWVu5SDWiBmZCEH3Auvs6CHBq+M3Mmhe0odbx8QgoPnpSUR815LdZ7dRwm6VogXq5bBdGa/bv8LiUGHlGTAu/BdloFJfGPqzaqOzdKHkS9Ht+WprwNcf321pATd+T2sfpRRcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXRrcZEF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f255eb191so128586a91.0;
        Wed, 30 Jul 2025 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753896385; x=1754501185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NrcJ1iSCtN5jVbcm5N0Ai/T3sFFFCqnycMZm8fgafCg=;
        b=mXRrcZEFJfo+N3IWknP++/tVOClnCmRihwZczL3QilhIlyEneUWvzA7F9elv9fTPRz
         GkcS6to3U0YrUPDiqXQ/4AvPVhogHaflZ0349cvHhBcUaULAvY6XaXDtYkDFYcQyVuFF
         YIIpARf6va7p5SRScZDZOHvLvF+uF2OwSlQ/5hlFv6ou8BxUtLw2serSHvSqx96a85Uv
         WHRwXzOxMdJtcaL73vG9AfMZBtxFKFb2+lwA2+Hgb8KFcJPaJ4Woqep+ZHaEKtRYoSgw
         OrE6QijqmVZwmV7E1dXJ3+LFDQeIIhC8+BEPsW8Qgbhft0lJ0gFGPNYG7PQ9Jz19+SWG
         VgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896385; x=1754501185;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrcJ1iSCtN5jVbcm5N0Ai/T3sFFFCqnycMZm8fgafCg=;
        b=Xr1l5qZDHzs5lrDnBCc04zN4wu/cSyQsunKxXc9S8yHdvWAhvn90AKbMncNx8hXDNc
         h/Pnv5QljW1XwxPGOwiVt/Zr0rT7JSeyiuVfkrVp/CQPtQ0lYNDLSSfDqjgBCoj5Dx5l
         rXeLziQqlTLrlhE64377NnxYcnMishRkekh1imItZ8/d19MrKCALJHVwoYi2rVTzI7S8
         XBhvHB0f7/MDsv1FkRHRssttX5NeOB0tPZd6d+KdgFtrsICFQhL4DawAy1tNTvEy7WH1
         FUWDxAz9Q9XaewZlfTINjWcJZUOuY1w6j+8LOpt4FHblDX0t8cUbraDlkYWdViLt9SXR
         oa9g==
X-Forwarded-Encrypted: i=1; AJvYcCUdjChYYI72+7QniU5e0+aPFWCRdYiL0RPNc8hQrmTOCr5sS1YmZEPIKL00NzGqG6R7LsczKrBhtqA=@vger.kernel.org, AJvYcCVJFKJWvzvuyFCh5c+QflIgPlIfIDWbeIgnLCXziHYXCVeqfQt0CkNdRARYK3vRPQdRO05qp8ypLIkxiZFE@vger.kernel.org, AJvYcCXQL/euMzYvIQHg1lxo/sF29RRY0IePZ7gq8L1x712oRQc+UzyrjCSRTq5juSW2jmdlgINOVRHcWjOWrfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4/4/WCWyTrB6h+kxnJxfXx6k1hvT8EO8IpTF/53kueI0JwK3
	0rG8T17/xs0aofWSPLLnURc2VuQ7vUC40w3WfujDZX06HGoGh7sBRmi8
X-Gm-Gg: ASbGncvoIF6ICw/KvFVXmVxtRw0WCNjrmADjYyeEsW98xsO02y9LnQ/pc6mKnbOVLWg
	ED+rPWE6Fd151pajkPYjJozTrczfA+IKJHBEdRMz0f2CFFvz6ilUoXDUOsPFKxrLq4xeku1T1Cw
	WR+1T+t0GmNOntBPgweZ85aJkxD95PVZ/Di2D+mUZFkEwQLq0crjxbQolcmNAV8QseEfC7nGeYd
	0Nuot1N26acWYo/bOe+Kyn5cKwCPwnUbZO9YxCTmUDfUkIV3kQDuAdsZdW7NNEWSK41xx1t4k9Q
	HrEfUavtQ9H8geSwFdeDZduH3EqyBzcbdrjaq0SCz1tMDBKAzLnrSYenaSyhIOqdnLsQgvyTtgP
	LYyugEP3+SEW+J3ZHgpT2c/uX3dcU+bNOxjEOKjjCGjGx2eHkdcN03Bai5aKInzPXSWGaRwg=
X-Google-Smtp-Source: AGHT+IEmdrJox+yHP2NWcyP1szaq4jQ/NssfT+LBg27ZIUZGAmZbYTGRkvuIXsiDZnu8PAyJ88K98g==
X-Received: by 2002:a17:90b:28c4:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-31f5de4b9d3mr6551743a91.17.1753896385005;
        Wed, 30 Jul 2025 10:26:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dda997sm2518311a91.20.2025.07.30.10.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 10:26:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d4b6932f-fe95-4502-b7c9-650a61ab565d@roeck-us.net>
Date: Wed, 30 Jul 2025 10:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia <liziyao@uniontech.com>, Antheas Kapenekakis <lkml@antheas.dev>
Cc: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, command_block <mtf@ik.me>
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
 <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
 <B751D49737DD10DC+00a0ff95-476a-4d0a-9bc6-40e77012a554@uniontech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <B751D49737DD10DC+00a0ff95-476a-4d0a-9bc6-40e77012a554@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 02:24, Cryolitia wrote:
> Thank you for raising this valid concern. We've closely monitored GPD's
> development plans and currently see no indication of EC functionality
> expansion beyond thermal sensors in the foreseeable future. Given this
> observation, we believe placing the driver in hwmon remains appropriate
> for now.
> 
> That said, we fully respect your maintainer perspective on
> future-proofing. If you feel strongly that platform/x86 would be a safer
> long-term home despite the current scope, we're happy to move the driver
> there immediately. We're committed to finding the most sustainable
> solution for upstream.
> 

As hwmon maintainer, I feel strongly (since you used the word) that moving
the driver (or any hwmon driver, for that matter) out of hwmon space would
be a bad idea, but I won't prevent you from doing it either. It means less
work for me, after all.

Guenter


