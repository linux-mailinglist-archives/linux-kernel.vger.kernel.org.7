Return-Path: <linux-kernel+bounces-824834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3CB8A3DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DBC3B64A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5331691D;
	Fri, 19 Sep 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RjSGabaD"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72843314B89
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295235; cv=none; b=J8qpdltquXhTzZYXcmzUPe3DuJ+8WvH/vBj9cfIJyoSIC7RRZtQbZHtUITxUHPcM5esroAMmikyLk7wWmdtq+r5emhWpBBjMuNyrhHwhXy/d8TOD2Dv6RdfuyNkWPwOHWEczU/gJwqiJbk8MTof7uCly0fhMprHeo+HywRDhGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295235; c=relaxed/simple;
	bh=6MasVt/aSu1l1BXxhKpjh1yxZ8Y8jhzf28ZPi2XqySw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMYi6hdyK2rhMyqybyWtCvrZNfynl//Cb4w/NCetE8Mgrkq9ZdH9Tx3CLutebPRqP/hdIE8YQwMJeccQb67XfAoH21alfjJpZ3bubV+826DGyEbVVfp3VZuSF6OSNOS/PpVmb894K2X8qCyxAugK3mH2RKK6j9iVTTfj2XAJsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RjSGabaD; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381e2079fso2180003a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758295232; x=1758900032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58QddYy9doQYGj9OGULI81m9rz5X5nvBb+nMrO6L4+k=;
        b=RjSGabaD+6QxdK2upMChFfx4/Rw85dSxclzrvanLtp1MHkdURVfYlv+6MyYBA3JVHK
         Do8IuS9SONMXfjn/Wh25IqpQ1opTwiI80qo1Vafzos8g3FCGCRi/S4RX/xyM6lfiS/1k
         L02k7XGg1fjH9CBc45P4Z/0tiySauTrcUc8YECBwYJoExoRpDkCKpLmkVRm2Dsmmkqle
         ibHNJ0nsftwUj8ZCZuTFlLjzL78fH0v474S+S4q1pXVgS6weibPF4cil3+O2UyzdI2rs
         J7K/0gqPd3ipWN6D1UEiBupXN7L/J6wM181jdVo7S+LFgPDGT+BU41+yTM6FCkmkfVBl
         D4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295232; x=1758900032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58QddYy9doQYGj9OGULI81m9rz5X5nvBb+nMrO6L4+k=;
        b=RRkC/5rPXFRVDHc2WKn6JEW2GoJ89j4z8dydKzGy+nOICZmSO7dwr9xQTZG6Y9PwCP
         pydNs+JdjZElOu+qpheOo7X+488b1U2y3b+m/ufP7jScnF7UZpM4JBAQYlP3YEsOzS2h
         2RM27JOr0aKbul7QjtyOgi+2kKemLdH9N7uH2gBxvj6uDDHfNidvNqmsvgclyeDowNk1
         WDqzEaVY6FLHaro2ttdCXggQ1SFjuuMTkTW1KpTiMEDOaP+b3bMTs0RCYSoDlXSS7Bqi
         o3fOMTApSTHK8MXMqu19sGDXFwD9Kt+5glryivfsWhAPD6kXApR44TjDJgl8oU7F5rTi
         Fdaw==
X-Forwarded-Encrypted: i=1; AJvYcCXDDYHLA/IlPfYSaSVeROqYs1vemBJXKkustINvLRSG/EK9r5Kadn/E4wg01+G9lWoFe3iMigcCvxGoyLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2800JhdAlSXqak8NAx6PxdGDxsS/pXjH6zD+b1WmR5Izv631/
	0cs5PYddoJiWPUvkI/62LrwPMHH5qKFilbg/+AYUt/TEtL6z5AlsC/00Xi0phu/uJvo=
X-Gm-Gg: ASbGnctzxpije8mRUfneTw+S0UoLHJi3ok+/NpfHfwtlS4lbwK50lOVRLeNNGpYaNyw
	ojlLR0m/kgb58TOfd2C3YubaSNnQaMxUB4A2ouoZKQghssjWavZZiAGVmOzn6cWqidlvOM/sY8u
	fQyAsfeDqb+lB03fSGhF//sSwKpjlgWMd8syERPuBNh3X4Jttcoc6jHN8LUyMRI1ECdUlbS83Kj
	L0VwvSs9KS68mfCjd8iCegMzbSFO+VF3fM4eLjP7Gc+97JvFZYDXf6J+daEfYjXjaVxGnOpDAYQ
	udApWQbA8IkA8+X1ZGR4WQ1O5UjCuCBbWmi5mSHMNgBEBa4Sc1apglUs+Sj5qH8faCp25NcG5bS
	ctFnnajRQXNR/b0B3ndIvs+OTN1CNfhROBXPCkhHCE8vQHJKrT+6HipFgkx521PeoAACq2Trzb4
	I=
X-Google-Smtp-Source: AGHT+IEJT0izziTZ06yN6CmHd6vD3fLc3H/jpNESoHp4Nt7QllNscgV8/EofsSLRMMmL3uPtY7Wo0w==
X-Received: by 2002:a05:6808:5094:b0:439:b674:d9a3 with SMTP id 5614622812f47-43d6c26736fmr1642625b6e.35.1758295232364;
        Fri, 19 Sep 2025 08:20:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f? ([2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6bf8adsm2068096b6e.9.2025.09.19.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:20:30 -0700 (PDT)
Message-ID: <8702fd35-945a-4d20-bc37-410c74c70da6@baylibre.com>
Date: Fri, 19 Sep 2025 10:20:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, srini@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 sre@kernel.org, krzysztof.kozlowski@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
 casey.connolly@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
 <2025091925-thirsting-underuse-14ab@gregkh>
 <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>
 <2025091918-glancing-uptown-7d63@gregkh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025091918-glancing-uptown-7d63@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 10:13 AM, Greg KH wrote:
> On Fri, Sep 19, 2025 at 10:05:28AM -0500, David Lechner wrote:
>> On 9/19/25 8:59 AM, Greg KH wrote:
>>> On Thu, Sep 18, 2025 at 10:00:29PM +0300, Andy Shevchenko wrote:
>>>> I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the header
>>>> file.
>>>
>>> Yes, please never do that, it defeats the purpose of module namespaces
>>> completly.  If you don't want to have module namespaces, don't use them
>>> for your subsytem.  Don't use them and then make them moot by putting
>>> MODULE_IMPORT_NS() in the .h file for the symbols as that's pointless.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> Could someone suggest some additional explanation to add to
>> Documentation/core-api/symbol-namespaces.rst to explain the
>> reasoning behind this?
>>
>> Right now, the only part of that document that say _why_ we have
>> module namespces says:
>>
>> 	That is useful for documentation purposes (think of the
>> 	SUBSYSTEM_DEBUG namespace) as well as for limiting the
>> 	availability of a set of symbols for use in other parts
>> 	of the kernel.
>>
>> So I don't see the connection between this explanation and and:
>>
>> 	[Putting MODULE_IMPORT_NS() into the header] defeats
>> 	the purpose of module namespaces completely.
>>
>> I am guilty of putting it in a header, so if I need to fix that
>> I would like to actually understand why first. Andy has mentioned
>> something about potential abuses, but without any example, I haven't
>> been able to understand what this would actually actually look like.
>> Or maybe there is some other reason that Greg is thinking of that
>> hasn't been mentioned yet?
> 
> Let me turn it around, _why_ would you want your exports in a namespace
> at all if you just are putting a MODULE_IMPORT_NS() in the .h file at
> the same time?  What is this giving you at all compared to just a normal
> MODULE_EXPORT() marking for your exports?
> 
> I know what it gives me when I don't put it in a .h file, but I think
> that might be different from what you are thinking here :)
> 
> thanks,
> 
> greg k-h

Up to now, my (naive) understanding was that the point module namespaces
is to reduce the number of symbols in the global namespace because having
too many symbols there was starting to cause problems. So moving symbols
to another namespace was a "good thing".



