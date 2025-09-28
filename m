Return-Path: <linux-kernel+bounces-835613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55183BA798F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9F83B12BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4AC257459;
	Sun, 28 Sep 2025 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5uLhvjE"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B63594C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759103891; cv=none; b=OekBzxXcguZoTN9iHtrR9EqQYFdVeFEJhzM7QAjuQkEUiJwVuoV4zE2H93AUJStK40HImsuMe0L1llDIxyqWtzhiwxg0l0u3EUJcXyjkwwCuo5o7tFnCWE8BIUtyoHbuqm0qvqtkLXsSwdBn2l2q2jFWLWb0aqvqtTeLWxebnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759103891; c=relaxed/simple;
	bh=uZ2q3P/dE88QkgPpghf4wC2u62hbPCArf1EWD9vCj/I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P4huOvaW+UvsLlS0NuG1XZ7lTZJh/OSfxjJczdGpVmU94yD+waECoWUcoG5f1+T3rqgZMMPamIcOcCyDEAv8VkvaE69Jd8TEuPIk96B2DoqJ5pcy1ScYgt6uTtAbA5Gj9SLKhigtVn9sR3QeeyjJWenMVArCru38xHy54Aif3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5uLhvjE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso6718721e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759103888; x=1759708688; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yljnIlU4v2VwJK3/t+Nwxj+G8c/okseAmLmguNulAtk=;
        b=a5uLhvjEtwQ8inUWHnMHRMvn9G4RQ6w/vP7zRyyZWBXm6dUeFCHYfv4I5CgdkN/Ew0
         ERvVCusFZmxTeHMW1Ec7CDmDPRtYh/UfRWHt798yd0Pai9lh1qBvqLXB8QyA7MaPCpPr
         nW3p6SSYm7o/cB/x1ryo7fJKNwRc0eAqIUhUtSwlgCzqs0upQ+qYrz5kmfr3GiSglUOV
         Gq6mSG2rjEHV30z72hbvom1se9o7RSX5QxhRe816UOEEiwD3QC5aiYzeKhig66WyNFI4
         101Wp1DAjC2+DQwqDvKW3ZusCUnjOkmtNJTfEInv/GpH5iysuYdjL1Hz9o53hnS+ASZt
         aORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759103888; x=1759708688;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yljnIlU4v2VwJK3/t+Nwxj+G8c/okseAmLmguNulAtk=;
        b=a6ItILRtfVNCRpk+5wGuDGWR/EOLm+uX9KOsOpZN8RBdXZr+BC760Il1wsvaY5+EBU
         5BdppRS9FldXs3jeRUzR1NX9tFs6hEBgiZUgERv8BR+T4A4O08Efx7w8ZeDbI0z8LCGD
         72nJk+FynFIxduATx0vJJlSPj6160yAmXuRqxUx4f+7nKxlufAEyKfueEc5jLNhfLCt8
         XpfF7UvJbpuzQ4UixYJlvx5SMDpvZpjBd7MXwTnyDpJRQS1pkNIcZl8jYyb7hWBnv81A
         PvIodE00gdUWjz5kNM3YAmt7ixsGp8RecUDA9rnGZIzzOvHOmHHkbhBC4415MW1ts6/M
         51Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVfQKuWIfpD36o+FIxAA+3xteAXahWN58ytZL5DpTmxTwAoYqRa8goNV+okUl6Gxhu+d2bcgonsOPKww0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdx60pgxcGO4H0VdpwQPohf1IKJWLcE+jCAQ6vUhTrdLW1lcOb
	cv2UYBNFUsedfefXbXohwqxTwcEOnOBoIsp/teI0vJpgg6BEXvCNvXhy
X-Gm-Gg: ASbGncuU1S8quYQapaVXvr6i0pykxh3MguPcu2TkTzg/OxRZ1nexhmYP0Bb5wwfIomW
	BmbW8MkPdIlQeSFKkgnRimmrzkZqQx7d8NSpx4rHoJ0TZVp7I2ir4z7+Q36sc7OyEXSz9u11+aR
	D2F5ncD3QDKmqMNzhRhfA8m5coNQLTnN/Bcjp4QIG7IKrp5ae79DPwT0fYCfqqx4vYMWpvow/gq
	tz86JzZyBEQh1x4RPGE+ta5YAUCLgCxnu9aDN/14dlzZgl0BrfRyULmw+w/C5A5ntSDRiYfrNcU
	U8R6DjQX3bMQbhPlY5fvQQbhPYXVwev/lIECJ95Jtla5VxU3FPGAZVO9B4vTwvZDuTsOLVLMQ5V
	tx0F2t0HvTgcjlAJuqia3U9SDRMG2w6bt8oYWC+2LwiHX9rY=
X-Google-Smtp-Source: AGHT+IFatLnH+CWKbIPVnt1XCGsPTWuZfxlrZtyuUOcPTm0iQtnY1bAc/cnSijrrtlSR3Mk4EECIMg==
X-Received: by 2002:a05:6512:3052:b0:57b:968a:6df6 with SMTP id 2adb3069b0e04-583066e7e35mr4445802e87.18.1759103887574;
        Sun, 28 Sep 2025 16:58:07 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316c1d303sm3761723e87.123.2025.09.28.16.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2025 16:58:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] drm/meson: add support for 2560x1440 resolution output
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCCsTqsn06A5oVXGTW6PgmSQH0bHE+8PSftyWNRAbYUTcA@mail.gmail.com>
Date: Mon, 29 Sep 2025 03:57:51 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Dongjin Kim <tobetter@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8A273D4-5F5F-4BD8-911A-67EC9C3FF1F4@gmail.com>
References: <20250927130239.825060-1-christianshewitt@gmail.com>
 <CAFBinCCsTqsn06A5oVXGTW6PgmSQH0bHE+8PSftyWNRAbYUTcA@mail.gmail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3826.700.81)

> On 29 Sep 2025, at 1:24=E2=80=AFam, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Christian,
>=20
> On Sat, Sep 27, 2025 at 3:02=E2=80=AFPM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
> [...]
>> @@ -894,6 +908,10 @@ static void meson_vclk_set(struct meson_drm =
*priv,
>>                        m =3D 0xf7;
>>                        frac =3D vic_alternate_clock ? 0x8148 : =
0x10000;
>>                        break;
>> +               case 4830000:
>> +                       m =3D 0xc9;
>> +                       frac =3D 0xd560;
>> +                       break;
> Initially I thought this was wrong because it's only added for the
> G12A (which is also used on G12B and SM1) code-path, leaving out the
> GX SoCs.
>=20
> Was the 2560x1440 mode tested on a computer monitor or a TV?
> I suspect it's the former, so I think it expected the code to take the
> MESON_VCLK_TARGET_DMT path, which automatically calculates m and frac.
>=20
> I'll give it a try on Friday as I do have a computer monitor with that
> resolution - so any hints for testing are welcome!

The original patch is from Hardkernel sources - I=E2=80=99ve picked it =
several
years ago and then updated values semi-recently after 1000ULL changes.
The user who originally requested that I cherry-pick it (and tested it)
was using an Odroid N2+ board (G12B) with a Dell monitor IIRC. It=E2=80=99=
s not
tested by myself as I only have TV=E2=80=99s not monitors, so it will be =
good
to have your confirmation (either way). If it=E2=80=99s wrong I=E2=80=99ll=
 be happy to
drop it - I=E2=80=99m just trying to upstream and offload some =
longer-running
and allegedly good patches in the LibreELEC kernel patchset.

Christian=

