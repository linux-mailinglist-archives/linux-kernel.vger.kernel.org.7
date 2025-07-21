Return-Path: <linux-kernel+bounces-739739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D5B0CA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBFB1AA8347
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4B2E2668;
	Mon, 21 Jul 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaJQTg4P"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC82882B9;
	Mon, 21 Jul 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121270; cv=none; b=Y7a1+1o66T41/CvsKXM7/k0eQZpoGykrQyeqHaNHmSMhft05C/jUXBaCuiILzbrZX5P4o9/IutlZ5IPLp4XuP/noCkXGd+eYMCLwWUeMHgr8qoTiJpzeJ2ZsSWPuE15FBY63l3caF1KECmb6A7P17xWNDW0CRcXB2r8DPB/QKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121270; c=relaxed/simple;
	bh=AxR3SLpD7uj8M+SVLIg4R+XGie4XxMhuFzefg7QRlow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO3wlGa4Wl7IAmGxfCBmwFYNExLlYjyPQJSSvSQVKkPhqb//J9uv8nvtU/9Q1rae0vAOl8XlfBrvxR5cBM9SslRLddYVk5Dw88a7VY2LyXW5EoKed54JmEnk5lM+d01gfaBZPO2YKlTH/PGyHckTj8gMo7G/QVo2m+LCGbgZaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaJQTg4P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso2959917f8f.3;
        Mon, 21 Jul 2025 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753121266; x=1753726066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArCMIs8cHMmaU6eRMIXZBua41omBX5hUlQZNBFR+A9w=;
        b=LaJQTg4P6m3qN+IWl3fO1kuny2HanJLCjdabjFptQRMXFbN+ezcAIYSqNUZw7+G3b0
         IRUl6KUVEi9s1EBQWuKqY6QV5eosrnv5G8RL/ceg6rT2lik4GGavx/xVhwdfCbo8cWWG
         NOOUsq0NFzjVlevtU0HiLuFMppYj8oRcqpWQGJEtkVstzeaugXx9kHjbrDv3bK/UalbY
         4sAvQBtoAOh7qUzlQcf++Fw2UThdxk4EclYRzsCCZFDXrvsFqLH5np/ez7kt2yYV9o/4
         KVrZySAr9JwmWsareFQyXta0/ELD/lcnechGhvT+zwz+v/I0Aot9zWyvJWFnm2BOmcXd
         19xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753121266; x=1753726066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArCMIs8cHMmaU6eRMIXZBua41omBX5hUlQZNBFR+A9w=;
        b=PqPZpaF1jW/tjOsY4V6QluRmSoaDfvX3zxSrembqb71bZE26X+BqBG+DrGAgcCITt4
         CefLTkcUwYKdoN3we96dJQFebAc4/R54YbCW+GV/WYqKNLgb4A2nqaWqBl+QsNvFHLdH
         HCRUcmwmNVutRR5Xuk6h89uEkF6AGqZzRZYv9tv/cjW7VIaYt2CXwlo36FYA50WAY2gc
         73NpUxBAeoeApVa4U4iyr8WTu89tXD+RtP5EgW21q0MLUvKgWByYg4WrvygUmWbLPtK2
         UGw48xkGH7j78tFKAVsArBfpQYoHdRrxjwCVOJh1TaWfTnL6X4BtA54RUu1HJIpDMWcM
         r39g==
X-Forwarded-Encrypted: i=1; AJvYcCWHJce8ZzPsYBzEaPL+PXZ4XddH8UrkVlpU2ZDG3AF+FhW2n6VB2rS7928plkp2ngBHqYBhzuWJZ78T0fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSMpr8z0nKjp3Urd4wuw2QtmR8IFCkCoxoCTpvklQxOsUKjav
	ejxHdRDaYzFqUHz020yoM0td0V+m2rNOZDIVBm3jdDcs5A4yneVYo5A=
X-Gm-Gg: ASbGnctFYRqjBgBVYYk2m9QIaS0ogD62ASV33iw9OoQWK1mmNmfpPZ/0v4EPs/1Ijwt
	KqMvtjiiibuSz41JjHY1BFnBBURto+hjmQpE0mJKRawkt/WBlBodyc37zjGSCkQWh3HYheDzMIb
	qR9zLnbPKFnflzn/bi45GG8z1RjT+Bbt6nMpPsk4xZsPJYbkfXZCmLx37hMmhPXioF4VNO5AB86
	XAXho0mDZndasAwRRuwVywxCPIbxObLeEyqZLMiAragWuhheJq9op7prQBtOue2kwJqq/T0Sc0l
	6qHNEsUdZFkcSDnF4j8esQ0U/ERTLRjXTbKQFHN1w203zfdf+UTm0BndJS1TT21t+1ejs9exx6x
	m68eXTN4zZ+6jGbJ1g4C8SsppO6SXPBARE2QKNdJ0txaExD112gnI/rUBTYjs7Y4=
X-Google-Smtp-Source: AGHT+IGcDPzV6KQjobcMBQcBoKbIIcGU6ckQH+xCZ1tWbwJRYmX8A1xwQRCZIhBoNEVRk2XrDOitug==
X-Received: by 2002:a05:6000:481a:b0:3a4:e2d8:75e2 with SMTP id ffacd0b85a97d-3b613eaae20mr11933859f8f.50.1753121266097;
        Mon, 21 Jul 2025 11:07:46 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:e3:9af7:6c0e:f2a1? ([2a02:810b:f13:8500:e3:9af7:6c0e:f2a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm171024705e9.26.2025.07.21.11.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 11:07:45 -0700 (PDT)
Message-ID: <6d93c92d-2bba-4247-960d-5f2e5e12b594@gmail.com>
Date: Mon, 21 Jul 2025 20:07:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: devicetree@vger.kernel.org, heiko@sntech.de, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, ziyao@disroot.org
References: <3c83e8cc-9ef0-4560-b6d7-127abab50541@gmail.com>
 <20250721140016.308800-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250721140016.308800-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 21.07.25 um 16:00 schrieb Chukun Pan:
> Hi,
>
>> I'm not sure where you are getting your information from, but as I told
>> before I actually *own* this board in the non-development version and it
>> has an RK3528 SoC/silkscreen - I just was too lazy to photograph it my own
>> but I did now [0]
> I have the MangoPi M28S, M28K and M28C boards.
> The M28K board does have a silkscreen of RK3528A. [2]
Nope.

Are you really questioning my picture? Ridiculous ... see [0]
> Regardless of whether the silkscreen is RK3528 or RK3528A,
> U-Boot reports that the SoC on these boards is RK3528A. (via OTP [1])
> So one possibility is that Rockchip forgot to update the silkscreen.
>
> Comparison chip block diagram:
> 1. Earlier version: https://docs.armsom.org/img/sige/rk3528.png
> 2. Final   version: https://docs.radxa.com/img/e/e20c/radxa-e20c-chip-diagram.webp
>
> The difference seems to be that RK3528 uses I2S while RK3528A uses SAI.
> But from the updated diagram here [3], RK3528 also uses the SAI interface.
>
> Rockchip BSP does not make any distinction between RK3528 and RK3528A,
> so it is meaningless to continue to worry about non-A versions.
I'm sort of impressed on with which conviction you continue to claim plain
wrong things: [1], [2], [3].
I'm fine if upstream decides not to care. But it is and remains wrong to
claim that the other version does not exist - otherwise I doubt Rockchip
would have gone to the trouble of building the distinction into their SDK
AND publishing different datasheets.

[0] https://wikidevi.wi-cat.ru/MangoPi_M28K

[1] https://github.com/HermanChen/mpp/blob/develop/osal/mpp_soc.c#L957-L982

[2] 
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/soc/rockchip/rockchip-cpuinfo.c#L212-L218

[3] 
https://github.com/rockchip-linux/u-boot/commit/89e1f532de7747d2e962644330666fb1b465926b

> [1] https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-rockchip/rk3528/rk3528.c#L131
> [2] https://x.com/mangopi_sbc/status/1847851624804602316?t=5hwScxgwCAAid0eCJgrP5w&s=19
> [3] https://x.com/mangopi_sbc/status/1785115827437760769?t=H5PXRDwbjOfBYa7QotjIZw&s=19
>
> --
> 2.25.1
>

