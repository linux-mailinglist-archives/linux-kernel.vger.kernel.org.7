Return-Path: <linux-kernel+bounces-772192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF7B28FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072665C47FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A11A254E;
	Sat, 16 Aug 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OxE9E2du"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF41C84B9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364609; cv=none; b=nv/IRoYEscqpcbopvNHsMowhlV47YdWuwI3zwEOaAGQPSzEhmcpluWyER2B/X7OsA6EQko62mDzENcXm2ecj9o4zZFQMjViczy52Dtswl05JlqnBxfK6DKJD8JWQl752DfO2AYF/gulc7J/ofmKfkfXndE3rRXbhZPd0921lhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364609; c=relaxed/simple;
	bh=pqJvivEBGZMEeBTDTBeEExbD0QlSLOI8C7nA1Oy3s1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JseXIHfpQfQ9HOwoW5QIGATZwA+QDGeVtJ8Q+sKB98DlrPkKwWqEtlQR5hCkOObMuZvjhluRp7lYuCRVrC76aV6rsj5H7PkHF0mPVH8c38sbq3+ziMKdDP8mXn04OF9OuFqk9vJd81Fic0M/fuELfe0oQXFoc6XHh9206ojqnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OxE9E2du; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381fdbdbeso1580726a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755364605; x=1755969405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBe1xo+4v3oElVFW7fcuATaVzg+DgTFn3nHmuEPeFsQ=;
        b=OxE9E2duTCWoTL3BPrR1DJhTS//xVr7PCCbFNO1QlptaH4TTGkXbrZ7pxQrRKD93Td
         ejwu72lLNzg34Eo/VE9zmuSV62eL4jrhGtBHYkNGC6+FSzHiblCBI6Rs942iTQaBrStZ
         vYuneqLf2LCFwnr6BAfuc+gxADgR37mYt8cK/BNaT/g9d//c5WDUg3SY86XEzuapFeNy
         RSw6Zz8sVquGmzov5V6zhrhnit84FqeT1HxtCRFhYCpZ4Bwmw+JtUyMY27CiCirUHstz
         ATNXU6gjVVJvSlg7y+GGrzbtZlVsUrVrkpOKb3SgGMB2z7ykb92nOxJzZPF4VNxdZ5Ct
         mogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364605; x=1755969405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBe1xo+4v3oElVFW7fcuATaVzg+DgTFn3nHmuEPeFsQ=;
        b=VVYoe7IATX7r/O6R98ngEi8WgJUQGKYN+Pl+qMCoZQD6/1cHBvpmEAN+vbhEJq/oZb
         vIRUSUFWZU4V2vaLuTDipNyhfX6uGPU5PjySxF3WhIsJJ/JqVLU/1zlNCVIpKDPhQ+XQ
         vw5NEAmHyCNgxunxhlcVOAF2kLbhaXERAoAHMx1tJN34Bc5QSKD6XHJ/SXYw8nDs18FF
         z/FM1luNxTaqZ/fhItvdKjQRFsjapDLzz6YmjM0QA5WTroLy4lbBvbwilLrvc7pOu/gy
         zOUTuvGP8YUoenn/C8sjYpses8/NBSWMk8L5OySMR9byxjgzlFqgsli42yQPEBsVigwv
         R4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrBoS5pgy47ILTg9nCJuLCrKqtopdChki/WXkLr4lFt4ztw3/pmiZUpTPe90h8bQG+2BqTunEErvU8CAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FE3bn6kR1whV1g7XVf4GuQHMlrCR1G0CIv7TMfN98JRnuEfZ
	mrn1jmurcdmrkQVRtSvRj6yf9rpySCkVd8wbfRcptEo5xUAalIXRy5zdUMjEI/jemRM3ksrh8jb
	sdej/
X-Gm-Gg: ASbGncu2R5+zJJs83f7cKwVDBGIh+ROI4+W9TZpkdQGqVbO8vGJHoCyX0qqeEWSzdgD
	SyBniewjgmI3vdGpCaAuZSNJzfTnJx9YFfLKBHUkv0TSxGIv5/S18Z4GHRu7L49BMKT4o+LEAAO
	ViRI7Qe9SaoF7DEXykrpefLoDicUzlkIuoeMZXChMGhOuULj5Q3LwCBhV8YW9rrInPD059vYP/e
	4VW8zS75jZQZ7TjRa/Q8IHADCimemUq8yIQELw4uhrHzG6SxS3k05dZ/8wYtguPeT6H4MAQb/a2
	cLPY58M1BapWCGs5avH4Hj0TtzNR8+gMvCeqsn4NWPUJnwU5X2O7lf1l4Hg4GxVQqTokDmADHzx
	Cevo+ex8DanrXkMVCSE924RBWP/p5vRQrUxAdHTAKXwTJzBC+8uPHIlMyRPLKJ5s/nlJjvZ9t
X-Google-Smtp-Source: AGHT+IGEvb5AhaiT6Zhq/oB29D3w1PwplAUO7hvX9zTUUE1MIRVwNQYM88GdZh4HcrXsSBIzgXsS0Q==
X-Received: by 2002:a05:6830:6b06:b0:742:fb8a:d2d8 with SMTP id 46e09a7af769-7439bad09e4mr2262744a34.21.1755364605125;
        Sat, 16 Aug 2025 10:16:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203b4fesm934109a34.30.2025.08.16.10.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:16:44 -0700 (PDT)
Message-ID: <82f53f02-15d3-43fa-9734-8091b360f4e0@baylibre.com>
Date: Sat, 16 Aug 2025 12:16:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <20250816105410.70e47dac@jic23-huawei>
 <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
 <20250816160835.3b44a4cd@jic23-huawei>
 <59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
 <93E1A889-81AE-4DAB-9297-2A74C87E38B3@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <93E1A889-81AE-4DAB-9297-2A74C87E38B3@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/16/25 10:33 AM, Ben Collins wrote:
> 
>> On Aug 16, 2025, at 11:19 AM, Ben Collins <bcollins@watter.com> wrote:
>>
>>>
>>> On Aug 16, 2025, at 11:08 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>
>>> On Sat, 16 Aug 2025 09:12:37 -0400
>>> Ben Collins <bcollins@watter.com> wrote:
>>>
>>>>> On Aug 16, 2025, at 5:54 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>>
>>>>> On Wed, 13 Aug 2025 17:52:04 -0500
>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>
>>>>>> On 8/13/25 10:15 AM, Ben Collins wrote:  
>>>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>>>>>> to allow get/set of this value.
>>>>>>>
>>>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>>>>>> ---
>>>>>>> drivers/iio/temperature/mcp9600.c | 43 +++++++++++++++++++++++++++++++
>>>>>>> 1 file changed, 43 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
>>>>>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
>>>>>>> --- a/drivers/iio/temperature/mcp9600.c
>>>>>>> +++ b/drivers/iio/temperature/mcp9600.c
>>>>>>> @@ -31,6 +31,7 @@
>>>>>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
>>>>>>> #define MCP9600_SENSOR_CFG 0x5
>>>>>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
>>>>>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
>>>>>>> #define MCP9600_ALERT_CFG1 0x8
>>>>>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
>>>>>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
>>>>>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_events[] = {
>>>>>>> .address = MCP9600_HOT_JUNCTION,        \
>>>>>>> .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |        \
>>>>>>>     BIT(IIO_CHAN_INFO_SCALE) |       \
>>>>>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>>>>>>>     BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>>>>>>> .event_spec = &mcp9600_events[hj_ev_spec_off],        \
>>>>>>> .num_event_specs = hj_num_ev,        \
>>>>>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
>>>>>>> struct mcp9600_data {
>>>>>>> struct i2c_client *client;
>>>>>>> u32 thermocouple_type;
>>>>>>> + u32 filter_level;
>>>>>>> };
>>>>>>>
>>>>>>> static int mcp9600_read(struct mcp9600_data *data,
>>>>>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>>>>>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>>>>>>> *val = mcp9600_tc_types[data->thermocouple_type];
>>>>>>> return IIO_VAL_CHAR;
>>>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>>>>>> + *val = data->filter_level;    
>>>>>>
>>>>>> We can't just pass the raw value through for this. The ABI is defined
>>>>>> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
>>>>>> is the frequency in Hz.
>>>>>>
>>>>>> So we need to do the math to convert from the register value to
>>>>>> the required value.
>>>>>>
>>>>>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
>>>>>> do the transform of the function from the datasheet to a transfer
>>>>>> function and use that to find the frequency response.
>>>>>>
>>>>>> It seemed to match what my textbook was telling me, so hopefully
>>>>>> it got it right.
>>>>>>
>>>>>> Then it spit out the following program that can be used to make
>>>>>> a table of 3dB points for a given sampling frequency. If I read the
>>>>>> datasheet right, the sampling frequency depends on the number of
>>>>>> bits being read.
>>>>>>
>>>>>> For example, for 3 Hz sample rate (18-bit samples), I got:
>>>>>>
>>>>>> n  f_3dB (Hz)
>>>>>> 1  0.58774
>>>>>> 2  0.24939
>>>>>> 3  0.12063
>>>>>> 4  0.05984
>>>>>> 5  0.02986
>>>>>> 6  0.01492
>>>>>> 7  0.00746
>>>>>>
>>>>>> I had to skip n=0 though since that is undefined. Not sure how we
>>>>>> handle that since it means no filter. Maybe Jonathan can advise?  
>>>>>
>>>>> This is always a fun corner case.  Reality is there is always
>>>>> some filtering going on due to the analog side of things we
>>>>> just have no idea what it is if the nicely defined filter is
>>>>> turned off.  I can't remember what we have done in the past,
>>>>> but one option would be to just have anything bigger than 0.58774
>>>>> defined as being filter off and return a big number. Not elegant
>>>>> though.  Or just don't bother supporting it if we think no one
>>>>> will ever want to run with not filter at all.
>>>>>
>>>>> Hmm. or given this is a digital filter on a sampled signal, can we establish
>>>>> an effective frequency that could be detected without aliasing and
>>>>> use that?  Not sure - I'm way to rusty on filter theory (and was
>>>>> never that good at it!)  
>>>>
>>>> I’ve seen another driver use { U64_MAX, U64_MAX } for this case. It
>>>> didn’t seem very clean. I thought to use { 999999, 999999 } or even
>>>> { 1, 0 }, but anything other than “off” just felt odd.
>>> Ah.  Could we use filter_type? (additional attribute)
>>>
>>> That already has a 'none' option.  Nothing there yet that works for the 'on'
>>> option here.  These are always tricky to name unless they are a very
>>> well known class of filter.   The datasheet calls this one an Exponential
>>> Moving Average filter. Not a term I'd encountered before, but google did
>>> find me some references.  so maybe ema as a filter type?
>>
>> In the docs I have, it says:
>>
>> In addition, this device integrates a first order recursive
>> Infinite Impulse Response (IIR) filter, also known as
>> Exponential Moving Average (EMA).
>>
>> The EMA formula I’ve used for an adc-attached thermistor was the same
>> formula I’ve seen used in IIR, so I think they are generally the same.
> 
> Clarification: An EMA is a 1-pole IIR filter, while IIR filters can be
> many other types besides 1-pole.
> 

We already have a "sinc5+avg" filter, so I would call this one "avg".

I don't think we need to get too specific. The main point of the names
is that for chips with more than one filter, it is obvious which one
is which. For a chip with only "none" and "avg" is will be obvious
that "avg" turns the filter on.


