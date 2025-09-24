Return-Path: <linux-kernel+bounces-830025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0FB987B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8B01733AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F026B26F445;
	Wed, 24 Sep 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNlUSZ3k"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A31257820
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698273; cv=none; b=cUWyACcyhBSi8WB1cBXMGkoRT8JXM3lCW/uMiPS/+uSDCRqMOymTfBBy+XTSh7yWbkxe1VyxDTg7iOXgwXwos0egmQj8Ne3i6qAB147zLYhxok9FfrsGqWQsuf7E85dz2WOGzbQp0FwumXWtdYrHGxd+DqP/hmdSMm8Ipy6UyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698273; c=relaxed/simple;
	bh=DYwYxtW8j5hnS7SADVusd2umGXr4SbYAynpTO8qJ9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRzPbyndhU6zGpBAhbU/H3rfdmtQ4Pha+HpefY6kl3dAn7ireuDklXMuSH3DcaUC7pTYRHvINdCpmCIuhL1axHcvcnbbJuPruruRRPzPr34WJ4rU5QGNDNga3aJ8rJ96UUZGTuXqDwujbbqs524wTsTYpEKE3x83jASteNI5Wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNlUSZ3k; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3307de086d8so5768088a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758698271; x=1759303071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B+ejEjcbFe35qGbfGp+veZnDMTD7hLq5QdeCS+8VltE=;
        b=FNlUSZ3k0WcKaszNq7naK5BIK3J6lv7cJjMBVqb3qxVPF5GaRvISA7Sws5lt9beEq8
         l9PweLmjLFGuc0Q1Ks5tYkUPTmtTQUIo/oz95KTTf8psRyMOwXfUasPzdtI5tBb0mt5e
         DTjsxvAkbQlzi5u67+dskp2+emrEjt06olPP0VAb5/DVDzAM6pcrxwQLYLasTYDPpNJm
         zMJnZnvyCoQj92xPWp+KfRIVWQAmuol0vWQ8acc5iuNKWsmo+AI7YinqM5pSnHMrBWWL
         Qg1SUlHy5MCkGisUreKEazHqC1yaOdtULqDRR6Oo+jOWXTzxwGz8xbjYOLna2hyB9GVd
         kk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698271; x=1759303071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+ejEjcbFe35qGbfGp+veZnDMTD7hLq5QdeCS+8VltE=;
        b=NGtahNWwPSQByBP7NHTpqF2t51ByXVTWEiDJ6WY4W2s7o64t42sai53N1cRKoCHUP+
         KLqA6IDqSys3yuUKWeyH29e+QCPdQ67GNOvCLOfCl53P7lDzkzH9bCyIFrBQr78zAsqv
         Tqp2Uz+zgLGopByV8QJxs9WhGX72L+9ioIJ5h39eE3VGiIUWc9aixLsHnazSrrlvGzaH
         YOdSn9ad8JlddqkPL7edZelH2OhIoThBX63qprdSHSi6y2mHNEyJ8pOzojF+ugdBBiFg
         JB8DCUetTAproZxRXCb5ZTdB+TN0XLG5ZQm2vnHy2Bc83ClkmmA3G2O5YqMPCEB5dZqD
         eEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT07G4GT9+yQ5010c59+Z0Ir27gup0MVXkLxkQz3B8kj3WMnPNkP/61fd/I3jd1Lluh+3QZXKAqwix4Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQt73HE24NoOU9jF6PayhFppxAWrcTdYjyGZzS10qcAENe2mkA
	lO2dA9T7JF2YOxEFv2uNdgXKauUR357TDESTiuFb0hXu50xSngpzAs+8
X-Gm-Gg: ASbGncunlAM3kg6EDD/iC2O9k2MJwD5VrhgRsn6VjW6jJ02+lfbm7vFovslFZAq4hut
	oSDGBIGNKkJZ1J54bDFkwUz5vwlH0AystTBafcyjozh1E+R8/lEjzXpTabSP+G7XtoFzmJwtNQM
	58e3yQK8MjI25TC5dKZFzcB+lDKqhHBV+vdZdrN9K3AYRHvg7UbqJpxtPdVAIFMHNgSzLkZbGhK
	Xzq9Ub9x6f4Gwx/X88ZLJV+1OhfrQZqk3J+7+8zzh3ebJ6vrJUW6lMQc5RVZxIl0DOS7U6ewp0M
	/Nb0/xPTySf35HHy8Kp1S1QBWR/CV1afVe+goARYtigakP74UbCc/WYISRyoJvlAaBDtpJg5VX5
	iG1b/Lao3ChSIe8mKL8MEhuhEeVy3csHuJ5QPnO3YXACIAU/P6g+ZRSVZ9Mz7MW/eDHZ3Y84=
X-Google-Smtp-Source: AGHT+IFxcqW0NSyd8uIjzX1YbU3spIqk1m1Hoj9o81cMRygM4Rv+qE/24RAN1KbD7bl6jN3Ionxn+w==
X-Received: by 2002:a17:90b:3c06:b0:32f:98da:c397 with SMTP id 98e67ed59e1d1-332a96fcbcdmr6799875a91.24.1758698270468;
        Wed, 24 Sep 2025 00:17:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55149526cfsm14361279a12.36.2025.09.24.00.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:17:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
Date: Wed, 24 Sep 2025 00:17:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
To: Andreas Kemnade <andreas@kemnade.info>, Mark Brown <broonie@kernel.org>
Cc: jdelvare@suse.com, lgirdwood@gmail.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
References: <20250920114311.291450-1-andreas@kemnade.info>
 <20250920114311.291450-2-andreas@kemnade.info>
 <79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
 <20250920233307.0c425863@kemnade.info>
 <473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
 <20250924090023.282ae450@kemnade.info>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250924090023.282ae450@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 00:00, Andreas Kemnade wrote:
> On Sat, 20 Sep 2025 23:18:59 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
>> On Sat, Sep 20, 2025 at 11:33:07PM +0200, Andreas Kemnade wrote:
>>
>>> Just for learning, yes, it is an abuse of the _optional for non-optional
>>> things, so a dirty hack which should not go in, therefore RFC. But what
>>> happens more than having the hwmon device endlessly deferred at worst?
>>
>> There's also the fact that this API is so frequently abused for bad and
>> broken reasons that I regularly audit users and try to fix them, I'd
>> rather not see any new users that don't have a really strong reason to
>> use it.
>>
>>> The wanted regulator is the one defined in sy7636a-regulator.c. So it
>>> is all an issue internal to the sy7636a.
>>
>>> Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
>>> I see several other solutions:
>>> a) call device_is_bound() on every other children of dev->parent, if not
>>> bound defer.
>>> b) do not care about the regulator api at all, just check whether
>>>     the corresponding bit is set before reading temperature, return
>>>     -ENODATA if not, some mutex is probably needed.
>>> c) do not care about the regulator api at all, just set the
>>>     corresponding bit (together with some mutex locking and counting).
>>
>> I assume this is using the regulator API because someone might use an
>> external regulator in a system design for some reason (better quality,
>> power efficiency or a shared reference between multiple devices I
>> guess?), or because the supply might also be used by external devices?
>>
>>> d) copy the of_node pointer from the parent, add a regulator phandle property
>>>     to the node pointing to the regulator in the node itself.
>>>     That sounds like your idea but is against the current dt binding for
>>>     this device and afaik it is uncommon to have mfd-internal things wired
>>>     up this way
>>>
>>> e) something clean, simple I miss
>>
>> The idea is that the relationship between the devices should be
>> registered before the devices, that's how the regulator knows to defer.
>> We used to have an API for doing this for board files which might fit
>> here, but it got removed since nobody wants board files any more.  If
>> you're allocating the devices dynamically that's annoying to implement
>> though...
> 
> looking a bit around:
> max5970-regulator.c has hwmon integrated and no extra device. That would
> simplify things. Although it does not report temperature. Some
> touchscreens have temperature via hwmon, some others have temperature
> via iio, directly in one device without mfd. Maybe that is also
> the better way here?
> 

Touchscreens reporting temperature via iio is in general the wrong thing to do.
Touchscreens report the temperature for monitoring reasons, after all.
But then, sure, if you insist. I am getting tired of arguing.

FWIW, the proper implementation would probably have been to implement
the hwmon device as auxiliary device.

Guenter


