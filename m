Return-Path: <linux-kernel+bounces-758305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CBB1CD67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737BE1779E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6221C9EA;
	Wed,  6 Aug 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsT2GfLQ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696C1B983F;
	Wed,  6 Aug 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511746; cv=none; b=sB6xxt17d0dpQ1nlYr51B5Ij5J+6rjZNfgz4GRGyvEAQzU1qFsAB4m+r2wweV3tBA8FCCpVrwEEbRPd9IzZ68y237yWOk+UWN6OhCGxcLNxizU6NUzGeA6WMPFLyRsk5X1Iz7zfq9mc/R6+9hy8NSlFnuRmlMeFfcSF1LJG8uhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511746; c=relaxed/simple;
	bh=tj4N+SIzFcWGTxg1LnTRZ4QeLKzNiZB1BYDm9v0DBio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfV/HPTR/f9BICEajPn/woegsPgD5JT1ZaI14Ep4tlRK2q6/oqgubjjg8bU+QPJiOlnbYgU7DYh5OWkl9Uhd6d1BrzgZYeW8YzXAXdy8ZtE9arZtsi0Nvo3ec6HHG6Npi8roxp5UavAczBL2PJMpoiabBoGh/yi5jDoRIEbbwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsT2GfLQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso259688a12.1;
        Wed, 06 Aug 2025 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754511743; x=1755116543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FbYBHCSmBqygyP2b8AOXo8zYdQ+L+WFnx6erHXSIBhg=;
        b=XsT2GfLQJZJ4KohREkxFQ/Uqm7WUTsKkfItNTt0EjRh0Tq/mzIZwhX6vQlU66WMVLw
         14VnB1yFNHk5FNBdygPtnEx4L0tN3g6QEz85jRKe9eFrR6YxElOcflSt1/BfcC4Nqkm+
         dDgSUySjFnlov6Ql99Do975FTzEckln1AP3lW5Ysr1q28LlK7mKc6Z9uhOL4Swu6+ZV3
         1mPyyWEeHEqZlY+Mv3gdu3Rc7IYR9nVdwSK3lqDHLpYQtwZz1mfpAN5GFKkQDPutLkTo
         5D7gU1xgTLkOJbDdRp8Qe/SFlTFiK+TMLDyWIhB1a6ePYvbiv086OlKWpGT0XS0HgCcm
         cnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511743; x=1755116543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbYBHCSmBqygyP2b8AOXo8zYdQ+L+WFnx6erHXSIBhg=;
        b=XnxM6dh3N4rgJIbGDzRejuumeaBgB3F7qqYdGd2U7whVcHFyNYVU7qbNtJZRq/6upn
         vHH0vxYU1Jo7SgHx6jipvCKoq+UZG8Ooal1pCRYgMAv5MwkG7BN9NR/GPJi3DrYXxUlw
         T0Tz5/nolBdwwN5CytkA9d4AMf+ufVQSqRKscZsZqnUNm4CbnqFq2fIY1yrQ6PBWgI0a
         PVwduNfxB/ldElAJDB0mIIb7ETEbJSEwYEMr0XJ5sA/KBkfUsxsEYa7kUiIhDLXXx+HA
         qEtF9/yAN7pztUKw63GDgXiQs/0JrTmj2cFZACCNmV0VW5s3eqs1uSAQM75Pf9H/Tj84
         y9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUmtmfQo1F9Swh7YWEoGw/gmgwGE9KfKPLVX1l+wIH6jZzSEIkS55WjrX4YN80OLR4bZ7aXchxduZ19@vger.kernel.org, AJvYcCXTRJ9hmX+wzFS64S+BF6gL/CPKrxHe6tIIxISvWAoCH9oLOqK+2bzFlIO3Fp1/oFvRzZ+Mr2YEu34NPcfC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7L/NkfHvQMkiuf0YAuORKlialyvv0jvsRgtE3NfFu6Ynztsh
	iJ20hHyKSp0EZlj8Lvee+muQYjhTd8OaJ7euEVOH2xJ6BfHpGTvC9+XakSj8FQ==
X-Gm-Gg: ASbGncuv6J4TCTS4ddJiMSTRp6LeT0+Dut58J0CkhesWtOyFla9bmrC8v4h/1Z7EGa0
	8QTiUOsBjyl18NlsJIgufKXiR+xX5oFtYM6zHpFwnx0bgjYnDk7rd1y+DE8wAbPijdh6n7vMfW6
	svAFr/9ChwIGDJpQIKV9qGYZEXoI5Rk6xGbyUeoFb3Nfy/Am2bjZwdcsPICdjUZLVdEzdp37yJG
	a6c1n/EzxQepMoEnPlwsUQFZmO7UwmOzHCW76eQzx8kXFF4DW46c0w47IJ3UvrC5BADULAMxBl9
	wOA20eVNTMKqZnwu7BmySlt2DzkeNAE07SFve4dVSJS72hiZ9VJExYfUqxrP1A/QYD0qrgxRjBh
	jStued5Pce0wPp0DjIMabKONHj23GX0kggadqRbTcW2EzfbhTu4J4VW6rn/gugvuB080EOqo=
X-Google-Smtp-Source: AGHT+IECyTm1kCf9ycJ4adeEim9U/W5fxZw5KL87H/mxa+6Z8xBibXhsYdnyGCegMTy9k+wcD4vGgQ==
X-Received: by 2002:a17:902:f552:b0:240:1441:1263 with SMTP id d9443c01a7336-2429f575d69mr59781055ad.50.1754511743288;
        Wed, 06 Aug 2025 13:22:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef595esm165198885ad.13.2025.08.06.13.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:22:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a304fa4f-56f7-4ef4-a712-fefebbae912f@roeck-us.net>
Date: Wed, 6 Aug 2025 13:22:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
 <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>
 <fa1b8f0f-23a3-4baa-a424-9b1506a9699c@roeck-us.net>
 <7f621788-372b-4a0b-a126-4c2d1d9a926c@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <7f621788-372b-4a0b-a126-4c2d1d9a926c@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 20:41, Chris Packham wrote:
> Hi Guenter,
> 
> On 06/08/2025 15:14, Guenter Roeck wrote:
>> On 8/5/25 17:51, Chris Packham wrote:
>>> Add support for the TI INA780 Digital Power Monitor.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>
>> Looking at the registers, the chip seems to be almost identical to
>> INA237/238.
>> Why a new driver ?
> 
> Yes I'd noticed the same thing as I went along. The INA780 has the
> ezshunt thing (not sure if that's the same as the internal shunt on the
> INA260) which means that a lot of the places where things are calculated
> by the shunt resistor value aren't applicable and there's one less
> voltage sensor. I did consider adding it to the ina2xx.c but it seemed
> different enough to those chips to warrant a separate driver.
> 
> I think I can kind of squint and see how I might fold the ina780 support
> into the ina238 driver although that may make things a bit messier. If
> that's the direction you'd like to head I can give it a go.

Compare against INA280. The only difference I can see is that there is no
shunt resistor register, and current/power/energy LSBs are constant instead
of being configurable. That should be quite straightforward to figure out.

Guenter


