Return-Path: <linux-kernel+bounces-757741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3EB1C626
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DC83B5A90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D52882C1;
	Wed,  6 Aug 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvzGNGeH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2112DDA1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484159; cv=none; b=B0eHvhhK33amxB2Aolh9Ywk7IKQpQ18oPEPkkooE8diH6WilXLLZqsmZAgJ55DWXrXh3+WeKLP/fhnXTjMDgtk6o2rXhmUMqzVEZm8kvf+haVUr3YYFufpqu2nmO+3FspCb/VtgdlYEVenQzKqYRKMgYCFY2bMyQSY4/Dp5FbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484159; c=relaxed/simple;
	bh=r0fmGzYcagyINld/TI+rBkkDqvPQe0hlIzd0sfrGAEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQb4D+Te676lrnK8pDs61YoGNybg0PLnieOoTg9OCm4ow51kA9q8Wo4I3NOC1ALdiUWRpSbBQ92oDSWGa443k7on/uL0F7QllrPbFiPIpgSvA9PBqJMR81vreXugB9sm3niau4q81ZHl0/9Wi6zZBdWyJBOMHXCTtCXpJ8F6Wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LvzGNGeH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6155237bc53so969145a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754484156; x=1755088956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4R4sVgGxp0XHjP4HC85qZY5xFFqmMJ51kHLyqljDZ9Q=;
        b=LvzGNGeHqiQv2FnvkhtKHlZEZxIxTxEtDoW2tW68U5Q+1xTTfBa9HT/rhDR+JYQnmJ
         hOZAGhNNdcOAjMAaRT/O2RKpQZ2+bkqvLnTZKdJ72onYV95FJ8a9rU3CSOv84czN9ykT
         zfRDZuXx/vjNYzJDcJG6B1GNeHYrHx0lVpfOxZuEapTZw+yE6mw8mYOrOWSM2AGocn0a
         apG3hh9QoUE2MZftcsCOSCNI8bAz0MehkmlHo5d01TFX/DUKhE4MKN3tzoZdF1/buxk9
         3vhNktFXvA6UpsI08cpqOlj/tGUUsdjpy+j+wNLphEJJuXZDesiCMu4k+ZZTgnKI5A9g
         8vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484156; x=1755088956;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4R4sVgGxp0XHjP4HC85qZY5xFFqmMJ51kHLyqljDZ9Q=;
        b=N/XYM2T8YXL8Tu1nh23mRrYi9QAjyy5Eh+JRG2TLH3RHr2g2OIXI7HwlW2S92iOAQK
         h+jTb7etp3MnYRXXbv10TE1Usl/NUvz/40vBskz8Q27mScwMKLMLcRC0nGiiJHXgVkAP
         69jUcZ2GoAXyP6clX9Ca4InUf9307zIs2S8wLLg+xoj2xcqP8QK/gyVdcyJcGgxWyDsq
         tVBaAnN2qP57FzJMaRsZgehz07ryamkx+UclBgUdqEP6h7sRLnukV0ZEaTuM0Y+YyrQ4
         zDVmrmlRReJG24/+k/bdqa/VplJ75wfN33AXpk7nMp2As7aYQEepxRm12BRhGHb2o3pI
         aqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzXlkqvB4zAPq87NjIrmLj0s+/t7fn3XKmydxj5l+naWrfde1gfiqJOLx4lHzWlVwyby3gaMEjp8jKFHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZc+JUMzIPtIP0sLGkrUzqXAEQIJe9iMg8L62ofT2eFTTolim
	15VcFwenYLWo6xdOCUFHRxKdzSlRigTmbYJu1gZlnnDqsJ4cXS+9kiEL5wwQLsgWq0Y=
X-Gm-Gg: ASbGncuiCXJVQNcRGkB8+Ajlm4jhtkkriIACi/PCDbAfYR22ZW8I+gHmpyxynBwpFCF
	lpV0UGWb6Wi8h/K8ClvLQNPzf0wIFofcDvpDu7wR4qWNkGZZYgk8+vFpdYpsuv0vJBSGqnUCnto
	cuZzwPEHEXKA7cKkHJS465k2MCjm2t5XFtktQ9OE6VDhPd6v9FvJF/zk30TDUmnXQvAMcEpUu2s
	5rPorHkOyM9vzAKPc2gGcIh89lZ0HAnWz7jzLpLX9Of9uil1ggMC6Et5xieN+ULdm+Jx8MeCu6o
	hKY0w3bcqPmHNMlXQXZEoPE/UlvpsFresKMt5uLBpHUzqY8rDCox35kAEU9EoDiRvHkxRSoEAK6
	hIbT3Ljs43DnYxJn/MPfUkk5g2w9KHKF1Of9VttUT2Ls=
X-Google-Smtp-Source: AGHT+IGgUnR826lCkLGf6PcmGh4lmnfnohEsVZEEz76f5xn1VrQtfcGFZd1FkzgLcYBhBEYx9KCkog==
X-Received: by 2002:a17:907:6d0c:b0:af9:3d0a:f383 with SMTP id a640c23a62f3a-af99002e708mr122435666b.6.1754484155766;
        Wed, 06 Aug 2025 05:42:35 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df2e4sm1081963566b.62.2025.08.06.05.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:42:35 -0700 (PDT)
Message-ID: <ffd07f38-670e-45f1-96df-60b2d38ff185@linaro.org>
Date: Wed, 6 Aug 2025 14:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
To: Arnd Bergmann <arnd@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuu?= <linux@weissschuh.net>,
 Qiu-ji Chen <chenqiuji666@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
References: <20250805161059.4006484-1-arnd@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250805161059.4006484-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2025 18:10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> x86 does not use CONFIG_GENERIC_MSI_IRQ, and trying to enable it anyway
> results in a build failure:
> 
> In file included from include/linux/ssb/ssb.h:10,
>                  from drivers/ssb/pcihost_wrapper.c:18:
> include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete type
>    41 |         msi_alloc_info_t        msiinfo;
>       |                                 ^~~~~~~
> In file included from include/linux/kvm_host.h:19,
>                  from arch/x86/events/intel/core.c:17:
> include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type
>   528 |         msi_alloc_info_t        alloc_info;
> 
> Change the driver to actually build without this symbol and remove the
> incorrect 'select' statements.
> 

Maybe also original reported-by credits?
https://lore.kernel.org/all/20250717091053.129175-2-krzysztof.kozlowski@linaro.org/

And cc-stable and fixes.

I started working on this and had similar fix, but then I got impression
the CDX people will fix that:

https://lore.kernel.org/all/BL1PR12MB5333449243C7FE258728C8E39D5EA@BL1PR12MB5333.namprd12.prod.outlook.com/

so I stopped working.

Shall CDX maintainers entry be changed to Odd Fixes?

Best regards,
Krzysztof

