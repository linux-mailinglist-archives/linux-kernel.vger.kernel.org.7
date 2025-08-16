Return-Path: <linux-kernel+bounces-772132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5620B28F17
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636E5B61A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0832F83CA;
	Sat, 16 Aug 2025 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b="ZgG1Cx9S"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300812F83AD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357608; cv=none; b=Aa4p387BObc5zP1jmXgaQSuQeOzcRQG3lzqcOrCyeSSCjVEj/Ki2Sis4ygwHP3pFdr/Y7SMXmcYhuRcmWjcEko4QhjOsqodQgK4Mh/V9Gl/LAjMtBAS4m+S0LxArMCZPzdCoYPlthHbJXbZ1LD5uZga5ViRVNLoD0JuReqlQnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357608; c=relaxed/simple;
	bh=STFuy61bAqjLc1A3xYa6BQy8obAHUogEOAeVZfGmvKE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lLGALu34AKy9Ag4FCO785wKm/byPIx+6E0qODUylE5XEK65g4IiUwA6xXhoBE6AlFOTpo0UisTVUtAKdQrzIuM9/gmuIeIMxO42f/iI+TGGtJvwW3qb8l2rPBj0fGzxPw//uRb5F2xMpuZ0GCXLyQyAXQG+EVyJsybzgjgR5MXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b=ZgG1Cx9S; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109c6b9fcso28926401cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter-com.20230601.gappssmtp.com; s=20230601; t=1755357605; x=1755962405; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PljJvM9Mz+exp2gU7l5Y6SyyPwdaLnV8wYec/Xl0OdI=;
        b=ZgG1Cx9S3aDLji3WZUWQrucdlsANNILvC5O7OW16ixbekbmIQlyJSPtZfoKVK5JBy+
         9JWFFtjV3ev1kSN81FuK8R7juWdRxMCloNZSvgPVtKRHhWg05LDgiJHS3DY6ax13VsZ3
         AQUk/mZ0566S0fCTTRP7MEEQd4gmtoeK2AreKUVeMpYxoy3nbeFA+qs7zQa8qqlO/BEx
         hIpiPGcNTR38nrFMF2dUwnQtDSPankRw009rLAacmG1ogWqF4ttJoYD0AHJUJjcoTHwQ
         W0ZI3pCP3UUoMjfrDXZppps4pJ86yx+9Gg9i0wOQYE1uSqsFDBNkAHM/hJC5qfwEwJKC
         oTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357605; x=1755962405;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PljJvM9Mz+exp2gU7l5Y6SyyPwdaLnV8wYec/Xl0OdI=;
        b=SxKaLq/ZOZ+zLfLa722Sbmnk21oSFrP8KlN48Nd4N22ilUXcPE2AVGiVxTexJTGmf3
         HCnkLxhwJ6Hsv8zKdhFdGagdvCZ5FBr6wGHXjjdoqroHPbhs5X1F9aOlElEAl0Wvce93
         vMwHDUmTGo77+Ze3pNhFVuhb15OkT5DjHbbdiX4eL9M1dqz9UNhOSEd6vjC5RoD3VZrr
         bF/jnMqBdGHNIe3l2Vx63tlQRoFZLX3CNWHNqJb6Bq4eIk+mPSFn/lcA8aJcb2h1fbNM
         o9zPc4m9LkrdWbUCEKg69KStumlSlrAhnU3+PdzoXNV2FQIwLwdfPOPcTfy+pO6ZG0am
         EFbg==
X-Forwarded-Encrypted: i=1; AJvYcCWq9ymMFsWRKrnZ5r5ufCr2leUKGWVvcp5GT+6ouV/Q0LC9gaTzbQIYxQ+lgiTc+muP8yIhoCurgT5ePWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmxTB1aFsJNQiVHXIfXX0mYPdt89WoY0f951yLDXrX2obej9t
	I23mg6Xrzet9JaL00mK+RbEZplJGVQ3o1k8d3KwFZpizhB0S2nSVvJxKE/AyWSat+Q==
X-Gm-Gg: ASbGncs2Xrnpg244qsSprFlJPMd4PkxkmbJMK0k1GUEXP3HGtsE76RxWzTR563WWL42
	MwLCFdszI6+HeXQYKg59AZn1LSCEAJpkEOuIjtqIQJsinyrK3CIVPx22Jwo5EUisjfkVKTOG4b4
	XaTo+p860Y4y+sFn587Bhnr4M2c7juXLlPcGs3pmf3rzMNuJZ4PoOaKvRK24IoIYZhOj1/iA2Dj
	SGRsmBa88qqJK+r3Q+xnC4ZW23TFYmOkMCXhusSluSbje67EDrvrRWGL7QtxL4I47qc2npFaanE
	kIubveeMA753QDpr4Ua//TYyAsIJjJt48CS5wuRKphpdCsdZNurxZsz5mA9Fg7dk6O9lnqNpqZa
	lpnvtaCBv4v4hctfBVRNY0P3TNEBUl3IE6IDn/+6hqH+cex3XcDSN
X-Google-Smtp-Source: AGHT+IHObH22YxFxpV+R5+xoTRTV27hK2OKtgfrrQ4IrW4SrDeRUdo/iUZ7Fwpe+k4XepGkTbSEdJQ==
X-Received: by 2002:a05:622a:15cf:b0:4b0:e1bd:a2bb with SMTP id d75a77b69052e-4b11e294f49mr76763941cf.50.1755357604987;
        Sat, 16 Aug 2025 08:20:04 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1977dcsm282449085a.49.2025.08.16.08.20.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 08:20:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <20250816160835.3b44a4cd@jic23-huawei>
Date: Sat, 16 Aug 2025 11:19:53 -0400
Cc: David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <20250816105410.70e47dac@jic23-huawei>
 <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
 <20250816160835.3b44a4cd@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 16, 2025, at 11:08=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>=20
> On Sat, 16 Aug 2025 09:12:37 -0400
> Ben Collins <bcollins@watter.com> wrote:
>=20
>>> On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>>>=20
>>> On Wed, 13 Aug 2025 17:52:04 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>=20
>>>> On 8/13/25 10:15 AM, Ben Collins wrote: =20
>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>>>> to allow get/set of this value.
>>>>>=20
>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>>>> ---
>>>>> drivers/iio/temperature/mcp9600.c | 43 =
+++++++++++++++++++++++++++++++
>>>>> 1 file changed, 43 insertions(+)
>>>>>=20
>>>>> diff --git a/drivers/iio/temperature/mcp9600.c =
b/drivers/iio/temperature/mcp9600.c
>>>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
>>>>> --- a/drivers/iio/temperature/mcp9600.c
>>>>> +++ b/drivers/iio/temperature/mcp9600.c
>>>>> @@ -31,6 +31,7 @@
>>>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
>>>>> #define MCP9600_SENSOR_CFG 0x5
>>>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
>>>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
>>>>> #define MCP9600_ALERT_CFG1 0x8
>>>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
>>>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
>>>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec =
mcp9600_events[] =3D {
>>>>> .address =3D MCP9600_HOT_JUNCTION,        \
>>>>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
>>>>>      BIT(IIO_CHAN_INFO_SCALE) |       \
>>>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>>>>>      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>>>>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
>>>>> .num_event_specs =3D hj_num_ev,        \
>>>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec =
mcp9600_channels[][2] =3D {
>>>>> struct mcp9600_data {
>>>>> struct i2c_client *client;
>>>>> u32 thermocouple_type;
>>>>> + u32 filter_level;
>>>>> };
>>>>>=20
>>>>> static int mcp9600_read(struct mcp9600_data *data,
>>>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev =
*indio_dev,
>>>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>>>>> *val =3D mcp9600_tc_types[data->thermocouple_type];
>>>>> return IIO_VAL_CHAR;
>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>>>> + *val =3D data->filter_level;   =20
>>>>=20
>>>> We can't just pass the raw value through for this. The ABI is =
defined
>>>> in Documentation/ABI/testing/sysfs-bus-iio and states that the =
value
>>>> is the frequency in Hz.
>>>>=20
>>>> So we need to do the math to convert from the register value to
>>>> the required value.
>>>>=20
>>>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
>>>> do the transform of the function from the datasheet to a transfer
>>>> function and use that to find the frequency response.
>>>>=20
>>>> It seemed to match what my textbook was telling me, so hopefully
>>>> it got it right.
>>>>=20
>>>> Then it spit out the following program that can be used to make
>>>> a table of 3dB points for a given sampling frequency. If I read the
>>>> datasheet right, the sampling frequency depends on the number of
>>>> bits being read.
>>>>=20
>>>> For example, for 3 Hz sample rate (18-bit samples), I got:
>>>>=20
>>>> n  f_3dB (Hz)
>>>> 1  0.58774
>>>> 2  0.24939
>>>> 3  0.12063
>>>> 4  0.05984
>>>> 5  0.02986
>>>> 6  0.01492
>>>> 7  0.00746
>>>>=20
>>>> I had to skip n=3D0 though since that is undefined. Not sure how we
>>>> handle that since it means no filter. Maybe Jonathan can advise? =20=

>>>=20
>>> This is always a fun corner case.  Reality is there is always
>>> some filtering going on due to the analog side of things we
>>> just have no idea what it is if the nicely defined filter is
>>> turned off.  I can't remember what we have done in the past,
>>> but one option would be to just have anything bigger than 0.58774
>>> defined as being filter off and return a big number. Not elegant
>>> though.  Or just don't bother supporting it if we think no one
>>> will ever want to run with not filter at all.
>>>=20
>>> Hmm. or given this is a digital filter on a sampled signal, can we =
establish
>>> an effective frequency that could be detected without aliasing and
>>> use that?  Not sure - I'm way to rusty on filter theory (and was
>>> never that good at it!) =20
>>=20
>> I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this =
case. It
>> didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } =
or even
>> { 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt =
odd.
> Ah.  Could we use filter_type? (additional attribute)
>=20
> That already has a 'none' option.  Nothing there yet that works for =
the 'on'
> option here.  These are always tricky to name unless they are a very
> well known class of filter.   The datasheet calls this one an =
Exponential
> Moving Average filter. Not a term I'd encountered before, but google =
did
> find me some references.  so maybe ema as a filter type?

In the docs I have, it says:

	In addition, this device integrates a first order recursive
	Infinite Impulse Response (IIR) filter, also known as
	Exponential Moving Average (EMA).

The EMA formula I=E2=80=99ve used for an adc-attached thermistor was the =
same
formula I=E2=80=99ve seen used in IIR, so I think they are generally the =
same.

>>=20
>> ChatGPT suggests this:
>>=20
>>    =E2=80=A2 Clamp to Nyquist frequency
>>        =E2=80=A2 For a sample rate f_s, the maximum realizable cutoff =
is the Nyquist limit f_s/2.
>>        =E2=80=A2 At f_s =3D 3\ \text{Hz}, Nyquist is 1.5\ \text{Hz}.
>>        =E2=80=A2 You could encode { 1, 500000 } (1.5 Hz) as the =
maximum meaningful cutoff.
>=20
> Hmm. Whilst kind of backwards as that's where you'll see aliasing it =
does make more sense
> I think than just a magic large number.
>=20
> I think I prefer the filter type route though now your comment on =
'off' has lead me to it.
>=20
> Make sure to add ABI docs for the new filter type if you do go that =
way.

I was considering a new =E2=80=9Cfilter_enable=E2=80=9D attribute and =
only list the
other values in the 3db filter available. This seems more robust and
doesn=E2=80=99t require any sort of agreed on magic number.


