Return-Path: <linux-kernel+bounces-772910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6FB29928
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98397AEB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B35026E715;
	Mon, 18 Aug 2025 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T1IMr5Lt"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DE27056A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496462; cv=none; b=JPXTpD+x4OUHaiVRLYWVZxOT0lSxR0PxpKcUOyOO8P0r/V9fysfeD1yMzPtFoMpDe+gK01kxvHH3Nlf1IFnCDkF9tWi70W4pliQiQJF4kPMyuIXGPNhw//aaPBKBZ4cIZaGblIimzygggcU8bd70He1I5mxU/FfZwQH3Fq07EP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496462; c=relaxed/simple;
	bh=rSwNLEEae3P9QEq2Hme2YrXdZ7yJVM2ZDx26GAa5T6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEMqq0czBKJjzjLIOp8yKK+TSGXXj8ubzUTOQq3nVbpSR621PtgAI6D8tz+tFCbtfWFZ5qmvrr6fozjg8/XI/w6p3TlNsqu6V+FvAEdxaajlprIUbt41wGpElSdtBZyxcuYXjA2fF+L/YySS+sSz8NutWDXJQ3ndHUiMtIoCCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T1IMr5Lt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78c77ebso595990166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755496459; x=1756101259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSwNLEEae3P9QEq2Hme2YrXdZ7yJVM2ZDx26GAa5T6A=;
        b=T1IMr5LtRbt3st3jCDW41Yg8CU6X2qUVL/lH48ElYepRtMAE6v9UFbJKs25YYRLSpV
         1iMJ0iqYKK18zY49CDvyFNfgkT8kPZynccAw0EJwGVo3a8iR82jIDMCFM+5qeKowrk5K
         dEnhUVfFclYginAwaIMlfdRgb4Yod0vHRT1TJ6WH6lfIvUoPIEzMOKmon3RFL0GSoYZe
         00DdRvRPWhAK2tiqYN0d/wKQhuJ/ecZ9K7wWpYfAap4GNo4y824DA8glgOv/+mMufxnk
         kDYSkaH+FOOJZumRYxFLUAPin1YVrMISm+/cjS8phbOYeBJrYaAK38Xecgm5FnD/eSrd
         /c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496459; x=1756101259;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSwNLEEae3P9QEq2Hme2YrXdZ7yJVM2ZDx26GAa5T6A=;
        b=kQIMoGbqPmDI9bbuaPketGZWxhjpFqoDRFxoQ/nmTooh5FbNSio0BWfhcDKJtwA+tp
         xB44O79ZIUrxQeRUA7PBq9Qqgwevo+nNMyslHEBkBazQigWdPYnQo1DtOXIJOQ/ejNtj
         JsMLJMk0ZvV1j6SvV1C87qKH8KoeB8DgCUmVwFKOa4q+wlQ8i+a6OL0vr0pgzSMcVpYu
         LcF50mvDhazrvK7sdko7cBmKcq88x+sUxijM+RfNJFR/ryyrGdDL8NccFZG6Cws3BQgY
         xP9vHMVdPKWFkvfxGt9hVGSLxw5KjrILpkFYbgECotCwTqb5pJBRByuwiwr+EZdSCoNZ
         Y87Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtwDHDUZrLdFPKQJSAHXrJlTRv1y66oSq0n1GI1Er0qdJhzMxYZp7m0oTQ2Eqs/vzQDO0h/rR5jYB7V+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YziETThp4iXYmcNGXMUKz2zI5yU+w8Fym5vuwEkv8ykNSwLtzVx
	s6+h66CnBTzVOZu/snRNsQMePOUJ6PpdJPMKC9ctwYE+W/KOq0r+TaC5RJjXNDeK/Bo=
X-Gm-Gg: ASbGncsim0d0wHVT/W3ohIDeWRmVj1QWLPNlQIqTTKWv0xs9fqbp4VlIJ0FVL/hpk1m
	ptRcgUV4oEwgXctJPIiYaGoFf88xlrPJlj7he4ytdiyVLnpZ79CU8hapzn4vsnaeiohwIaRCyoJ
	wYYVT5Uvd62Fn9x/pP06VvClgjldV+nMyxqUc5ED8+V9BEu/RWdJHt1pQYJblLAW49HVzH5GeZ/
	T39Uz4ITPLSXiW7YGp+qmIdmTOp/Rp50bHt42FQ5f37m7ZGHUcmx42ds7zd4POZrhkX422WY4Ii
	Xn/H3QDjO2P6eZ3McmokhsfszDVUBQDWmMY503zqE+PFe1k7RNbDSDATjrpmzJrAOFseqEsNJkw
	wyZ/2EJMeLs8a1zk+rWeN4jtTcYHkkBGLBMVeT2XN
X-Google-Smtp-Source: AGHT+IEOCX/C/iBLx623bOubuTqA7Kdn4TAgxaXuZzrmlCOVef2rZUF+MeuUI3aZvz9jOtGjq4uPMQ==
X-Received: by 2002:a17:907:96a7:b0:af9:a486:412e with SMTP id a640c23a62f3a-afcdc237cf9mr964877366b.26.1755496459172;
        Sun, 17 Aug 2025 22:54:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01ab55sm732429066b.97.2025.08.17.22.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 22:54:18 -0700 (PDT)
Message-ID: <b064e3cf-466b-49b9-a66d-399441e1913d@tuxon.dev>
Date: Mon, 18 Aug 2025 08:54:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] iio: adc: rzg2l: Cleanup suspend/resume path
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
 <20250810123328.800104-2-claudiu.beznea.uj@bp.renesas.com>
 <20250816145334.7a538a19@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250816145334.7a538a19@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.08.2025 16:53, Jonathan Cameron wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> There is no need to manually track the runtime PM status in the driver.
>> The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
>> already call pm_runtime_status_suspended() to check the runtime PM state.
>>
>> Additionally, avoid calling pm_runtime_put_autosuspend() during the
>> suspend/resume path, as this would decrease the usage counter of a
>> potential user that had the ADC open before the suspend/resume cycle.
>>
>> Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
> That SHA isn't upstream. I think it should be.
> 563cf94f9329

You're right! Thank you for handling it.


