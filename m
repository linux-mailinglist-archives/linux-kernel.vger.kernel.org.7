Return-Path: <linux-kernel+bounces-772030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883DB28E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429455C4ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5DB2E5B3B;
	Sat, 16 Aug 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b="Uw3xE15b"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870F2E2672
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349974; cv=none; b=WiAxwkTrFUjEDXfiIPojIKSu7j8sRnkE1bbrsb4gnR02qvgn+K1BamT+a/2mwl9PsoSHBAStD24F6z+L5GPFYNNJ6HCovDyRuCyhTTyA8Ul042AQHgUjruohNekLgGKb99jZ8rc3mloKbbAhH6r7o7aaH6yHZIov2ik2G/UjX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349974; c=relaxed/simple;
	bh=xuEN5C/Nbr2ntQwhAtJRjzipYu89UfcJvVo4gE+Sxc4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sGf/MawHeU/Suo1Bg5VNBd9DuhGd5KtLFD9xSX1OSPvQPdPzNiDLjWfr8FSVnwTyx7qCBUHIrPRPB9pgalHUid0BFHolh59rBjXrp5V00HYN2NKlE3CgxNnKpkv5Ri61JV6fqJtGixl+vlwqIZwlVs3l0yWQ602IdC8fwIMQ0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b=Uw3xE15b; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a88ddc000so32109986d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter-com.20230601.gappssmtp.com; s=20230601; t=1755349972; x=1755954772; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e3eahyGTlwrpuN1OkAQyzw7sphWbkwXPu/gpLSqi7E=;
        b=Uw3xE15beuAczPj9Hyh4SVhukz7STY262fJlqzVVJklxIoUNkdNucXVVvXPh0KdvcW
         GaymY0P9cdcNQUa7A81ZWHHDUvw1SoiaQ3pLME02obTXex2zBwa2QR59gsb9N7TIQjVP
         R8w29HNQqRvdAnu0NCymYNSjV5Xm/SP/1YioB9I1mtVPCGgk/wUKMrdaJlnqHCZtOwOw
         izG9nLpCho31bkjiCfDvigLAqX11kC2oOu1SAmRHlLQBfRJZq5do0+HdTQ1yhyotFpey
         8IIlC9KX/wWr4Oc0CwZ1vt54UtO/8gTfn6wKaLhDA1o5AluKiJHbsIbwoQHgc8T5R7xM
         EmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755349972; x=1755954772;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e3eahyGTlwrpuN1OkAQyzw7sphWbkwXPu/gpLSqi7E=;
        b=UOEsEtLfEzJQkbVHHhrg6USTA56/aCjemXILwQYplnS3+G3GIIFgGBdjdzuWe2DDr3
         POXfTzHuNAFaB4IDukRwFmM6Vd6akg41GDoOEkEjfRulpYg753tNmnyFixXLXFXHgWM8
         A2KO0ZTd190OiHmgQ005gcfaYy3gQxWPc5Zxw4GSHeqKiyFsmsDd8fEhmZI2LutPUNC/
         pBYvXf0wMP1/L7P6iWQ/x6aeL+z5kV2bytlzu/3t2czMiMuYPyFSciJNJjlE28tyvB7i
         7w5NI641L6gqJR9L65wO5LXB9vEOv/bb8+bxBVx54mBkI8MG+Hl6FVCJZErh628yIBTH
         1vcA==
X-Forwarded-Encrypted: i=1; AJvYcCVoVOXb8T86DktFw+dKBJZ1JIHb1QxNAcaRKcL/F+bSG/bj+r8klUO3u29BD4V0NnPJEVcO/OL+EfT/Fyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oSrs3YN2qU82FZQABKZ183Z3nj02TETMfLKZbdIEJqCf1+b1
	EuGlmXuy8GxJG1WG7JCGk2F9KtMuRIS/JB/rMce2rheGBMpUojLs6p18VwRHjuR4dA==
X-Gm-Gg: ASbGncvI7pcBlztx33uPpFDxHqOnGdgj2b/2wrybvVl41xyVLxaL7UY/yDH+Akkq2/c
	yVbeiikrHrcQhwO0h7Sz9NR58vvTlWExjFnTz/6u1uii/M6+9TbyDg9Rp2tvoIxvnjw99QlKOrp
	M9nqGZh+k7nzO+o+3D9a0bKq07Rw5PTXOjMeXeEQO/jZ0+xNEvqXAdbY4jbUtKOPYSazGx71RPZ
	qQog6lt/tsNd2IDU7RMRUnttCjTBMpdRl3EKQczGuEnRBf3zQDRmFLMzrBctpWhp07T5nUhNah0
	ad7lGOMU56CGcv+umNoPF692bFVyqrMJiy5ShPUNEjz20BT0ulM6vuZ0F/lmOaEjP8jlS7yan75
	K11llZFP52leyXNAfzZCV6wzAxzgAc8jp3MuIGvuGFw==
X-Google-Smtp-Source: AGHT+IED7ys9c0A/toCeTZHXT2h97zA6/ikubb5ID7vgFskgxGDqiTdoCeRuKjRzsWhaVuatX+jjIw==
X-Received: by 2002:a05:6214:2124:b0:707:70b7:376d with SMTP id 6a1803df08f44-70bb0587ccamr29176266d6.1.1755349969262;
        Sat, 16 Aug 2025 06:12:49 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87dee34f8sm272871385a.0.2025.08.16.06.12.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 06:12:48 -0700 (PDT)
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
In-Reply-To: <20250816105410.70e47dac@jic23-huawei>
Date: Sat, 16 Aug 2025 09:12:37 -0400
Cc: David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <20250816105410.70e47dac@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>=20
> On Wed, 13 Aug 2025 17:52:04 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
>> On 8/13/25 10:15 AM, Ben Collins wrote:
>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>> to allow get/set of this value.
>>>=20
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---
>>> drivers/iio/temperature/mcp9600.c | 43 =
+++++++++++++++++++++++++++++++
>>> 1 file changed, 43 insertions(+)
>>>=20
>>> diff --git a/drivers/iio/temperature/mcp9600.c =
b/drivers/iio/temperature/mcp9600.c
>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
>>> --- a/drivers/iio/temperature/mcp9600.c
>>> +++ b/drivers/iio/temperature/mcp9600.c
>>> @@ -31,6 +31,7 @@
>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
>>> #define MCP9600_SENSOR_CFG 0x5
>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
>>> #define MCP9600_ALERT_CFG1 0x8
>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec =
mcp9600_events[] =3D {
>>> .address =3D MCP9600_HOT_JUNCTION,        \
>>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
>>>       BIT(IIO_CHAN_INFO_SCALE) |       \
>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>>>       BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
>>> .num_event_specs =3D hj_num_ev,        \
>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec =
mcp9600_channels[][2] =3D {
>>> struct mcp9600_data {
>>> struct i2c_client *client;
>>> u32 thermocouple_type;
>>> + u32 filter_level;
>>> };
>>>=20
>>> static int mcp9600_read(struct mcp9600_data *data,
>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev =
*indio_dev,
>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>>> *val =3D mcp9600_tc_types[data->thermocouple_type];
>>> return IIO_VAL_CHAR;
>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>> + *val =3D data->filter_level; =20
>>=20
>> We can't just pass the raw value through for this. The ABI is defined
>> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
>> is the frequency in Hz.
>>=20
>> So we need to do the math to convert from the register value to
>> the required value.
>>=20
>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
>> do the transform of the function from the datasheet to a transfer
>> function and use that to find the frequency response.
>>=20
>> It seemed to match what my textbook was telling me, so hopefully
>> it got it right.
>>=20
>> Then it spit out the following program that can be used to make
>> a table of 3dB points for a given sampling frequency. If I read the
>> datasheet right, the sampling frequency depends on the number of
>> bits being read.
>>=20
>> For example, for 3 Hz sample rate (18-bit samples), I got:
>>=20
>>  n  f_3dB (Hz)
>>  1  0.58774
>>  2  0.24939
>>  3  0.12063
>>  4  0.05984
>>  5  0.02986
>>  6  0.01492
>>  7  0.00746
>>=20
>> I had to skip n=3D0 though since that is undefined. Not sure how we
>> handle that since it means no filter. Maybe Jonathan can advise?
>=20
> This is always a fun corner case.  Reality is there is always
> some filtering going on due to the analog side of things we
> just have no idea what it is if the nicely defined filter is
> turned off.  I can't remember what we have done in the past,
> but one option would be to just have anything bigger than 0.58774
> defined as being filter off and return a big number. Not elegant
> though.  Or just don't bother supporting it if we think no one
> will ever want to run with not filter at all.
>=20
> Hmm. or given this is a digital filter on a sampled signal, can we =
establish
> an effective frequency that could be detected without aliasing and
> use that?  Not sure - I'm way to rusty on filter theory (and was
> never that good at it!)

I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this case. =
It
didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } or =
even
{ 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt odd.

ChatGPT suggests this:

    =E2=80=A2 Clamp to Nyquist frequency
        =E2=80=A2 For a sample rate f_s, the maximum realizable cutoff =
is the Nyquist limit f_s/2.
        =E2=80=A2 At f_s =3D 3\ \text{Hz}, Nyquist is 1.5\ \text{Hz}.
        =E2=80=A2 You could encode { 1, 500000 } (1.5 Hz) as the maximum =
meaningful cutoff.=

