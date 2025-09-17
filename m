Return-Path: <linux-kernel+bounces-820072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD4B7DE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54752A739B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21F2853ED;
	Wed, 17 Sep 2025 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="m+rH69no"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E752137932
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091156; cv=none; b=eJih/RnxVdlPToHQrcXvhZT9wvzyJi/iFAqCZPJcLzOXJkjnS6DE5YCQpiJRljg3fX9tUdIbArDyfQMU0X59UluEau0ROV9kjEiJTVsP2q9PZdpgV997kld0ry5oixAGP8k0EnxZrFEEFIRjQbHjpTjsUvFbrEKWBQUOTUZX6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091156; c=relaxed/simple;
	bh=xX+N/SN6MUaa28wK4TLjv1haNtZLkkAoQ0rN+SnsVF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhgLyx9O3DRKL2ksrX2/DjUM7MktFkoE1TodwNs9hVXLvcqwCYtUlMowp/7M374Cu5L4V0yYG8zDXukHmd7rT6MDx0+AaQwSfUxdZSLzglNZTPfQkEx3BFR1XCzT5kSpDRqYrowo9UGX+NElmGijCu7Lnx5doFgOuoHm9kbhl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=m+rH69no; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ec4d6ba0c7so1435614f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1758091152; x=1758695952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77F0eh5zIcs6VOlyvrc/5uKyRtamVm6y2K0LLyVNiHg=;
        b=m+rH69no7YZRPl+4Xd+0aWlbj++OWjCYyIA5SRPhpvU/l/m4TbsdRC50c5ILRKWuWZ
         ACot07tfWtO4iBTtyGMvFYdkpgGQDmZk3Omm/J38aQLr7hCH09SUiNUHnBq/taCfyH9L
         Rlik1dn0iRayfpd+la/S+RNV8oP991XV6XhysI7Ejeh45x3n6ikm4y6XRPGS3h28IiNj
         Rdz3KJGQJpGmrOphbG6qjuRWYwmYHUfjqc8tecQTEe8QJB4wQWXhFvdaktjHS+VUjkgA
         NOTZlZrFgTRATuqIinCUHpRbu7if4ob3ybn8qGOOWogH41WGDy1pJef/f2vi9AmkdJR1
         f/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758091152; x=1758695952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77F0eh5zIcs6VOlyvrc/5uKyRtamVm6y2K0LLyVNiHg=;
        b=gxaPKoC9yV5mAflVfCtY5nvIGq46HwegZtPzVufNvSkZXkPLg/34Wfwa6h+LB9gpkh
         o2jySENbp6HMxFlFVJZgMjY62sMhl7QWjEYRZwi+iq10sjrSiQBcNhd2kYFxbn8C50Uy
         5DUjIFKQ9wE7ofGvqJRWwEmjpGc6FpKBaNt4EpqpB7gtx8qv2bYozEVddK7Zht9g3tNy
         svsCr0iRrDVbSOoA7Fbugo1Fv7UzYCP6himCVzbom77rFH1q1Uw3UtTEMchk21/I4mKr
         o6Ud4bCwcO+QscbTNwM54mkMMPrx0bfrz1T+59QkoC/OoFcvdb7sEgNG5qT4JvuKaG+k
         TBzg==
X-Forwarded-Encrypted: i=1; AJvYcCXg09bJ8iBgcEq83SNDQdg59aaMX+R/6RBYvH6gl3X2DM2U0FtwkfQ9NdluUx/GLBhysA85iYRrc3og+so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybec49HPYR0P6F4C+vfZxxUYBuozxBKz8d15oE5mekECZCvCdC
	Tog60/I9Cwhhm+CEeNsT7Q3yV/VKDkrEj7YJyPmAioOVNgd32/2I/wsGTa1DuQTOZ94=
X-Gm-Gg: ASbGncsV1zI57qIIOprh7Fx59jcUXWxG51OeLFA/fBBBkgwPkgUJPl36K1fFG4JGfZG
	eBtdOElLdE0Q8g0tDPTTLWu8drr++1N8a8OQeX88Q/yyY36B1kxWNQjT/u96rC2ypO323eJw3tS
	b8sZ3VVwJdRvNTvLHHpz2hzGcgtGNLKmpehkOf0h4AOz4VwvPJ5H2Sb3dnzKDN+Z2vXj0UJDcrO
	u1jNYzWqg850FqwYT5Ib4j4xGf+pSyNIywjmD9/ZhBfo+gyvA74JGDIQ10IgSr+nGoKU0r8YcqS
	UyqfnI7NYeWFC9I2MXlZl+72wOB3MSGiWnjQFbliE+mGDlbFia0Xm0+BLGSiuQBsWozBM8/bOle
	+oyX3+i+7ZPv4c3SvKvlaN2sdvWUmUEqZ91fCuDujFjrr4Oh+QvWkOuA6BgvFYacFOwUcANcz2e
	PY3+BTlJ9gkKP/4w==
X-Google-Smtp-Source: AGHT+IG6Qsc5VU9s+KLN/ObymCbaRcvmgFQYQp7jQl2dFNfoKqhHY6bNfm9aOpDZbu6Xlk5fJjmiww==
X-Received: by 2002:adf:a2d6:0:b0:3e9:d54:19a0 with SMTP id ffacd0b85a97d-3ecdfa4239cmr495573f8f.57.1758091151984;
        Tue, 16 Sep 2025 23:39:11 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:1b1a:e580:5909:925c? ([2a02:1807:2a00:3400:1b1a:e580:5909:925c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdbc7fe1bsm3414155f8f.52.2025.09.16.23.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 23:39:11 -0700 (PDT)
Message-ID: <55237b5d-c9b8-4606-8b5d-c7a97218c085@hammernet.be>
Date: Wed, 17 Sep 2025 08:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: dts: spacemit: add UART pinctrl combinations
To: Yixun Lan <dlan@gentoo.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250916064739.196695-1-hendrik.hamerlinck@hammernet.be>
 <20250917012941-GYA1263349@gentoo.org>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250917012941-GYA1263349@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Yixun,

On 9/17/25 03:29, Yixun Lan wrote:
> Hi Hendrik,
>
> On 08:47 Tue 16 Sep     , Hendrik Hamerlinck wrote:
>> Add UART pinctrl configurations based on the SoC datasheet and the
>> downstream Bianbu Linux tree. The drive strength values were taken from
>> the downstream implementation, which uses medium drive strength.
>> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
>> hardware flow control conditionally.
>>
>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>> ---
>> Changes in v3:
>> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
>>
>> Changes in v2:
>> - Split cts/rts into separate pinctrl configs as suggested
>> - Removed options from board DTS files to keep them cleaner
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 432 ++++++++++++++++++-
>>  1 file changed, 429 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> index 381055737422..7811fb485bd4 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> @@ -11,12 +11,438 @@
>>  #define K1_GPIO(x)	(x / 32) (x % 32)
>>  
>>  &pinctrl {
>> +	/omit-if-no-ref/
>> +	uart0_0_cfg: uart0-0-cfg {
>> +		uart0-0-pins {
>> +			pinmux = <K1_PADCONF(104, 3)>,	/* uart0_txd */
>> +				 <K1_PADCONF(105, 3)>;	/* uart0_rxd */
>> +			power-source = <3300>;
>> +			bias-pull-up;
>> +			drive-strength = <19>;
>> +		};
>> +	};
>> +
>> +	/omit-if-no-ref/
>> +	uart0_1_cfg: uart0-1-cfg {
>> +		uart0-1-pins {
>> +			pinmux = <K1_PADCONF(108, 1)>,	/* uart0_txd */
>> +				 <K1_PADCONF(80, 3)>;	/* uart0_rxd */
>> +			power-source = <3300>;
> ..
>> +			bias-pull-up;
> here, see comment below
>> +			drive-strength = <19>;
>> +		};
>> +	};
>> +
>> +	/omit-if-no-ref/
>>  	uart0_2_cfg: uart0-2-cfg {
>>  		uart0-2-pins {
>> -			pinmux = <K1_PADCONF(68, 2)>,
>> -				 <K1_PADCONF(69, 2)>;
>> +			pinmux = <K1_PADCONF(68, 2)>,	/* uart0_txd */
>> +				 <K1_PADCONF(69, 2)>;	/* uart0_rxd */
>> +			bias-pull-up;
>> +			drive-strength = <32>;
>> +		};
>> +	};
>>  
>> -			bias-pull-up = <0>;
> Sorry, I've overlooked this, the bias-pull-up need to explicitly set to
> a vale of 0, 1 - normal pull up, or strong pull up.. for uart, the normal
> pull up should be ok
>
> please refer Documentation/devicetree/bindings/pinctrl/spacemit,k1-pinctrl.yaml
>
> Since the rc6 is already tagged, I'm about to prepare a PR, so If you able 
> to respin a new version quickly, I'd be happy to take, otherwise let's wait
> for next merge window (which shouldn't be a big problem)
>
> btw, please always do a DT check: 
>   make ARCH=riscv dtbs_check W=1
>
Oh, I wasn’t aware of this. I’ll update it accordingly and run the check
before sending a new version. Thanks for the advice!

Kind regards,
Hendrik


