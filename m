Return-Path: <linux-kernel+bounces-741532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF5B0E561
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C43D547A15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15A28640F;
	Tue, 22 Jul 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SF5vwxsw"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D2285C91
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219449; cv=none; b=VboXY6VWQzzTC6TTosdmRL6gBd0O3Zu7HwZJCFJzLq2/LaQQDaea10J7RCC6ad1g6aUGflyh6Jf69/16AmjH3KI/ijE7z8TvgQZMFirOzjpTofOh6V4idc4xs9FH89cIxG4fTq+gPODaQ0IqYcWKrX9iaE+1Lvhp7aIRJDA7qsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219449; c=relaxed/simple;
	bh=eYL1o47Kleefpqy0F6S/ozw8zz+oDdKbrjvaR7zhri4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlYNdpnIKffpT00tx1RZgtflTdZg4z3FQCYJXDDZ0F2YdNSfkv0LHh6TtG67KwbXY8PnXNobJy/lIKGUGA8lHgNxkAoxLpp1DVvbvph/wV8DL3F9c4YoHo3QeBurg0LKyJF3LwXrmqcIDB+oMHJpKvy/cFjlyjNr6LrBF9o7pBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SF5vwxsw; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e290cbe6d0so21599125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219446; x=1753824246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHBg2rMZuWIVzQC6BiR69k3jKDmsa5yJmHZY1CaYlic=;
        b=SF5vwxswTUPiHsjwFsMpZnNu+k4BncEKgOYRGvuwI18vupPnYreG8dpB1fj97fEwSX
         9gv7xUP5tYoAP1ViNl7zowgh2yK38+QLVyS29lcHZxqBpaf/KiV/7BzYr5uXUKm6JdOm
         GYLZeQILhGGPqCQIHegIKTUpDOKrcXDfDFAQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219446; x=1753824246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHBg2rMZuWIVzQC6BiR69k3jKDmsa5yJmHZY1CaYlic=;
        b=qlnrFXbbv2d05XMoVZZFm8lHurUzZ1QDCBjEnkE7yp/NlUHZDqLialqjVAhZY8BcfU
         Z5tn6IkXO3oL7qLe6QvHQ/yIW4RnA2XbMPY3gdEk2dFwgtOZXFKMoK2MewXvKnZPP+ZP
         H5YwmAeU+q528QF+vapkMcEZmRekTiamOvrxSxLzOr+dJeL/WlGo2l+sYwZvMnMyHJiE
         4rjHHWEDZSxDZq+ONYt//DCImsKlA0FyxEzmHlr50zS/CnfhxkKFaZKaaZeWXGPZBibF
         NEFrVUNBITDUV33oqqvhWdZjjNnCYRyomIGZYuSxoBFDQIQUYvJYCwuK9vyQQ6U3cG3q
         NW7g==
X-Forwarded-Encrypted: i=1; AJvYcCVQYC2LIUmRuS4zr7WNbeLCe/NrWpTFbOFRMxrrIHsX3xpTWYX95KMU705dLNUmdsAsKWeElnpP/rjOIbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Bfh8N9KcR/i/es1UEu8mWz7xJGi1lwAEyTSjkLhXpdeFphy9
	UMItltM7DP9wJgD3nvLlW5g1FEWJPYY2OAcQ9Wv1jaJPg74muFEScu6KLYuVI5xmpQg=
X-Gm-Gg: ASbGnctnAgpcBaLWFTEeZdJwRNJp06Pe0Ba3eWUCTpCFJF04FAheAlw/hNFSV7UFUMk
	9USw/9agy5Sc/DM+Gd40NRFgnwcsrcCXQ128MSqZEMM/4MbdDVhH5sUXuVAA5GN1tbFYi+U8Jvc
	4ebRMvwbZ1TaacCq0GZmUeslyPh/CITGYe26XsXuePtnoHqaLngE09Wiw7BdxrTOE+Fht6elt3d
	gGcmWWswpfjYKArtRWt8dMsATfJgOHfxZpI1sJ7+cOXI+3BpBJxh5kc79zTo97HsnatC6HJT6PL
	b3WD9Swt7HnwlKlgf5SSQLlFdliMkmSRKfQIOF/j0lfW9aRJv1KQ9OnZhbzOiKcvLtn8O9611r6
	EjGawhcEBEVZmccoSYmHzNcO0UnzeSgAshQ==
X-Google-Smtp-Source: AGHT+IGf2Vg6LS2KrJKv9TjiWcHOJsVguQEuNaQuu7hVEhq6SSyxnQbG7sJ1OKFBgaprLgEFn+Tfnw==
X-Received: by 2002:a05:6e02:4404:10b0:3e3:843c:9d16 with SMTP id e9e14a558f8ab-3e3843ca037mr2668115ab.12.1753219446313;
        Tue, 22 Jul 2025 14:24:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca03da6sm2781182173.100.2025.07.22.14.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:24:05 -0700 (PDT)
Message-ID: <c1c09085-afdb-4b1b-971d-8428993a6364@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:24:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

