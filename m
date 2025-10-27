Return-Path: <linux-kernel+bounces-872788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3052C1207D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003E14F2899
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362D32D440;
	Mon, 27 Oct 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="PaUcYDUO"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780432E140
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607420; cv=none; b=povDozJUydBaxzqhtWO0o7omhVuFQbqzbDmHi7/QHZRyJW9ygCIo0k2ExmRMdpW7Lyou4asY37YTG2fIC4M6hQSWcDFQNx3DQir7W21/GOFBNGsRr1QzHgH7Dur5EkDQpVHmQwArb0jGAF9OYDRG2RFRe14kJy8TbHclr6TIseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607420; c=relaxed/simple;
	bh=bMX9jzNeBFXkZ6Y7HMFTaT/xWB1zBcledpc/9DsCuaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsO4mbUQDUAKoKbWcr7EEG6xazzwDHy+sUGfhfJAXeiLknPdORtk12MJuemJ5DUAqLLAoyOtb0qgsJ4+Q/BVVTx3gc9oKB+qlYdACbPkJerUxxSdT3/gPs86dI770WCM8BI2KiSM5Dzr3f+WndjU7WkyEVqZLDNNvp0Q1HLjnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=PaUcYDUO; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so214630139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761607417; x=1762212217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEYdNd7+OFAMq+81QLmV1d41glwOS9opiHm4I2f9DlQ=;
        b=PaUcYDUO8mit871vxTIYy8ao6zrBtGY403mAIvEJwsa0YnS4emB8CGITiYGocpaxJv
         IhmpmEeLjGy9YQ9peNkfiSLOxt3fU7Ez4amI2jh4dNjH1aggKXLB4mx3caSbwoM+MHSX
         jNHvQYtLEyH/vvFJyQZZYHOZjYXOEBmeB2IPivdtsdZwFI9/7wObOgY15cX/Pk987syY
         AX1EhxlExTKocFM3frmJag5892FtmLIbTzbxhDGB7yb+94VM45zhDeIAKU7D8lFa9BAH
         3GIcGAX0n5+ZqfS7SfGJGxes2y7QPNYzrjuQsfK7QcYSLwCw5bX1/8nrz8tn49auNQwi
         Je1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607417; x=1762212217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEYdNd7+OFAMq+81QLmV1d41glwOS9opiHm4I2f9DlQ=;
        b=nrlVLpfvxxIj0q8kMIq7uqlnPJpJY5ldJi9X6uoGw7iCg3vQPlak2wKMj1bmOnBTAd
         V2HQZbf+CqVSXYBVtJCh0XiRUuxMh1ADIafwxeQk09+eG6stHGQu4CrwCThN0Clu5EOR
         v8UqFDYQECjgsVojRkIkDfak35zQzKz3Vp0NTebGgfE5YU/Du2xQWgHE82jQODzOhqO1
         muyUsP00piRdwnsbdD7gqeZarwEOPAIx0MgRGZnux8hXNVv2DggK4UZux+8M21C65MoZ
         fb/qi+glehZjCAn1CFjFoyinCNFvIM6Z+YszXdUc4hHDjm6Fo2H76rXEiAh59raiTPVm
         cCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Jm3qV8fDFSoPleqvmRmehZQCLBzKCH/sgF9m2eoNTQw/lpc6UkwhRWuhEQmgsLYoY80vMYI6rjql7MI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbja2xt8uIrHzBwwPYUt9+1IwviV3yc4dCY79UL/0PfRl0S55G
	+MkyqwS9JVOip+SFeaDiRdi2tpmLXjKTkYtv917xbek8Y1MoIBWyM1UdXATczimMUaM=
X-Gm-Gg: ASbGncsJ5IxsfNafMsFTYk74GQUypExS4+22RWK3fPrNlaQ5mp9kuU5ODzmGTxoALOw
	Xj6DXaJJO5YZP5vd4afJaDrZdwh6BMEXAlu39u1kqhUWbjumt6e4jL0H5WrEXMKZbZokseQKmnC
	BHU5tk6Z/Q63Ml4lTT/kt9Z1PDa1kzuPieNDpS7lTISU40LH5SYuG5tvXgXLeOhs4MulU11EOuC
	rNpVxicLNaRN22/t06xmfE3KVQUCESa+wkmr2HCerAcWJWdSxWZZ0mq3gScDVoXTX2Sh6dDZH94
	dPMf7WAu+9ZIhb0QCLiTxV1TUzV6hMv6KUSmDoxqRzNgjd+GE3Hgf5uta4RXF1oXN4T2JjXwrp3
	mxxMZgOtheebQn7fwWVCdhSpVPpR+Z/oKT+QhBSoMuva88hq7yL+1t05KM4ry9qE0e8Y9DI2yli
	g4D0kfm71ZWLseFjI=
X-Google-Smtp-Source: AGHT+IH0ZPGnVVgtPdbyncjoeDuRW4QsW14xPxt5y+rrOlXlui4rOMIhJm1pDebe0CYZXcs2RVpexg==
X-Received: by 2002:a05:6e02:2586:b0:42e:7273:a370 with SMTP id e9e14a558f8ab-4320f6a770cmr23370685ab.5.1761607416707;
        Mon, 27 Oct 2025 16:23:36 -0700 (PDT)
Received: from [192.168.5.72] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea7ce584bsm3684302173.27.2025.10.27.16.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:23:36 -0700 (PDT)
Message-ID: <007900a3-bd49-4532-87bc-3fb7a83d6a1a@sladewatkins.com>
Date: Mon, 27 Oct 2025 19:23:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/332] 5.10.246-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183524.611456697@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 2:30 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

5.10.246-rc1 built and run on x86_64 test system with no errors or 
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Slade

