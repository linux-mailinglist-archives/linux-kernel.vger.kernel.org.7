Return-Path: <linux-kernel+bounces-720651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7455AFBEC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A9A7A5CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249F28A704;
	Mon,  7 Jul 2025 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de0F1KQc"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126E267F58;
	Mon,  7 Jul 2025 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932166; cv=none; b=XOks6ejyp7a9CspUMjqzAgcAoYl2CRIZLjD8NMdYDQ5NoaHtWKMeuUa41Po3dKaGIcJoEGAdLUte2Jkrd3H/CQaT1rwHtUh3Tlc59Vniy5JTAyFqLV40q9fUaMkot0+XnKHt+H5MulsKYajvHKmuE9BMHPZ7w1lE9liiknaHwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932166; c=relaxed/simple;
	bh=TCFRprCP4msMIURmCuCelD52LF+zoH7SAbFwNKfZ62I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNwHAUcehDHsuyLowoVKCbB4kGji3RkZkRoEe/q/iGNSaIs/dR0PPmNRZ8iEFVP/dj05axGlAosVDU8W9VFk+wmG8KJJAQlMpEGRdo7ymLOgh7jsXeCxcpp/wi4BOUmmBORuFD9v7ZzWj3EFitJgKy55sDt7pqZZZZcHo3fucLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de0F1KQc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so6187184a12.3;
        Mon, 07 Jul 2025 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932163; x=1752536963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96edAJ78aoq+ligp1pRPgUyMQ47YjBrb5R36hN7T77Y=;
        b=de0F1KQcLGYu4IsFUlbwKWLVm+fhAGe8GybDIuq5gIFdH4+J7IZxXIHWesGhOOZsO4
         C6KDs2LfSsUbLlQdHmcJ0cgzkRcY1HT2k8BJztaYOo+1D6zebjKVXCuKCo/9KBlc7u2A
         WrsDsVgoU+DvsBlVdrbsJ0knOebhiOl9M8UEDwI2qta0yqaIRj235a/4l6ZeL2elV8Lc
         OQMRULNrCiO6ODq6S0Rni8RCf1WRP/ysSDJC/15NcVa0Zc7dYWx5cVwdt2DK1/ryp9t7
         CtBTQTiP+pXfmqRVxuxlscwyDbRsq+AJh+kA29d8xhYpsrryq+Iy6QE/8C8iNSlaUwUU
         f9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932163; x=1752536963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96edAJ78aoq+ligp1pRPgUyMQ47YjBrb5R36hN7T77Y=;
        b=r0/DXTdq/ojmBa7o+1OX+IvhFHceYre+83ie6G8n0SCChLG0253zTMYnTpkuxuGfSs
         4eU2rZ/giHhikWSJKZmGcRb1L6xZPFygcUpiQOy3V7z6+901Q38Rto63JzvNo8sugPFW
         2rK41noh18FP61CJNl7ISu0rr5MrHV1ALjpmHW5K+eNDglid2Efh1ELS2eoiBfL1rKle
         yaW9T8b1s8LQQ6H4MN/dz4PANOz8CsID3za4kUjptMeMj7rz7J5EZ3Ap+jsHHqEQc4Bn
         TAaydmQmYw/tvtg7ujt+KS2wJBzUfIyBEbW/emeNQNMTuwh9Av+zhg1fyFpiRjeAMKvU
         oh5A==
X-Forwarded-Encrypted: i=1; AJvYcCU5uQDDlGelxcSJlvASnF7SsHtFYvwKmx7kaNGEQLM55yyNM5X+3s5fyP7m+CiFxzQbiu8KI7fhpWtL@vger.kernel.org, AJvYcCUoIeqCD7U7dDyaHLJYzMZiPC8znrvoLSiuz4uP5l00Ov/zB3T1rDUIi2cv8ibOQlEYFXQ1OwWs9MK0K3on@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh32QDpzGOnHHY7exVt8ydd30tlJ4zfvm9wZqtEEieFRRREcZ7
	m4+jwMg8101Wa2xUcwLO9G9vE5y4cJqdaUP8s7idOx0h7Q8V6qwRTdOz
X-Gm-Gg: ASbGncuk4rsSQ82AOOAfIMSlZTLGYw6IDqFXs+EA2WpaVq+CD+ZcqoMbFJM9fWEay4T
	gnG22SfU3yeJSrSEN0X9Drb7c973xcJM9XGIwd6hxw0JDmCt5UD3+iZreJLpXxSK6u/VhdO51n9
	usYJAp8OAluRUOtOtFWfrqqqK1L+Jf+BYW3zjy7JVD0H1sOsEwBWvjAFYUjkw5gBWfbDDVI+NHy
	boF20gK1M4jEzVM0a4tCwMRERPiR+dJDYViZoXYBD6R70qWXvhBOiTPpfUbTQSUeGeTvYIu6E6F
	OFO6RnfZuSFdNkUg05yl9251UQgxlmi6y9+uTzBPMvKCURPVASfWUheQkRlWnOZF7xnIiDujv5R
	lJ5mIfNimSpqozQ==
X-Google-Smtp-Source: AGHT+IEFkAXubR8nGNnpMMcgpN1NSWw4WX7eaJmPIaLLZ4fC713GtP5JLryHmUzd1bIBXHOSvqiWdQ==
X-Received: by 2002:a17:906:9f84:b0:ae0:b22a:29b4 with SMTP id a640c23a62f3a-ae6b069d5ebmr97623066b.39.1751932162362;
        Mon, 07 Jul 2025 16:49:22 -0700 (PDT)
Received: from [192.168.1.129] ([82.79.237.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02f68sm790697866b.117.2025.07.07.16.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 16:49:21 -0700 (PDT)
Message-ID: <2939a44f-a70e-41a9-9203-83a87c9a4be1@gmail.com>
Date: Tue, 8 Jul 2025 02:49:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250610160152.1113930-1-laurentiumihalcea111@gmail.com>
 <ac1daf6b-ee06-4076-b86f-b436ca0acd6d@sirena.org.uk>
 <c3deef24-fed7-4405-9953-804bff118c11@gmail.com>
 <5029548.31r3eYUQgx@steina-w>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <5029548.31r3eYUQgx@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/2025 8:11 AM, Alexander Stein wrote:
> Hi,
>
> Am Mittwoch, 2. Juli 2025, 21:54:09 CEST schrieb Laurentiu Mihalcea:
>> On 7/2/2025 9:49 PM, Mark Brown wrote:
>>> On Tue, Jun 10, 2025 at 12:01:50PM -0400, Laurentiu Mihalcea wrote:
>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>
>>>> AIPS5 is actually AIPSTZ5 as it offers some security-related
>>>> configurations. Since these configurations need to be applied before
>>>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
>>>> be their parent instead of keeping AIPS5 and adding a child node for
>>>> AIPSTZ5. Also, because of the security configurations, the address space
>>>> of the bus has to be changed to that of the configuration registers.
>>>>
>>>> Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
>>>> missing 'power-domains' property. The domain needs to be powered on before
>>>> attempting to configure the security-related registers.
>>> I'm seeing failures to probe the audio devices on the i.MX8MP Verdin
>>> system in -next which seem to bisect down to this commit,  I'm seeing
>>> separate boot failures on the EVK so haven't been able to confirm the
>>> status there.  There's no obvious logging, the dt selftest shows:
>>>
>>> # not ok 141 /sound
>>> # not ok 142 /sound-hdmi
>>>
>>> Full log at:
>>>
>>>   https://lava.sirena.org.uk/scheduler/job/1530197#L5119
>> Hi Mark,
>>
>> Thanks for catching this!
>>
>> After browsing through the provided logs it would seem like no device under the
>> AIPSTZ bus gets probed. Right now, my guess is that the AIPSTZ driver is not being
>> compiled since CONFIG_IMX_AIPSTZ might be set to 'n'.
>>
>> Which defconfig is the CI using? Is it arch/arm64/configs/defconfig?
> I'm also seeing audio problems starting with this commit. In my case I get
> the following error:
> fsl-asoc-card sound: failed to find CPU DAI device
> fsl-asoc-card sound: probe with driver fsl-asoc-card failed with error -22
>
> DAI device is sai5 aka /soc@0/bus@30df0000/spba-bus@30c00000/sai@30c50000.
> It turns out that the module snd_soc_fsl_sai is not even autoloaded. Loading
> manually doesn't have any effect. So I assume starting from this commit
> the subnodes (at least sai5) are not even populated.
> Reverting this commit fixes my setup.
> I've set CONFIG_IMX_AIPSTZ to both  'y' or 'm' and doesn't change anything.

ACK. Would you mind giving [1] a try and letting me know if that fixes the issue for you?

[1]: https://lore.kernel.org/lkml/20250707234628.164151-2-laurentiumihalcea111@gmail.com/

Thanks!

