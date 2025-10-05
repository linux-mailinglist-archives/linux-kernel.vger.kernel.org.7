Return-Path: <linux-kernel+bounces-842275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BFBBB964C
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 14:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BFFD4E29FD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85723264A92;
	Sun,  5 Oct 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ3vK3GT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E501EF39F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759667794; cv=none; b=LhJfhpj/r/sUprMIElj7nbwfDRJ69Wd8uB1jj0CSSJrzUjFWdyyzdtrL+r8ck/2za4bv4BW4BZUTRXi7t2P8mpNuiXuJNo1SpFlDF1alp1V+5M3CTa3Hzb8/UMNsRuJaDDQQMtFsU4U6LqpfUfe25Xj0JBV+UGlYqZNwedKFz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759667794; c=relaxed/simple;
	bh=KUTt2Y1gxv/VlnJgmR/oyTq87dHZyGm0B73t88UnPQo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DU4E8WUuWHfSJCcTMFbMxKDYqHu7W+aaI/6UUvyBdC4O1Xksvu0yO/7cneqnGd8gA+ELUmi2SmN4HYHd2lhyLu8IjVyXjjSFCJXMg/7nUYu5XY5XDMvCmwMsooi3MxEF/+s+DUPwq08+hKPXXlw5yOF3By9TmIQLKDomxwn7TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ3vK3GT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so48097691fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759667791; x=1760272591; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTBVd/nClqrF+np3hp6dXMEbrmomobOJty4TYQ6vLHM=;
        b=XQ3vK3GTuwVSXROfGTr7qRumKr/TL5G8GF14bAa24KB3swARDCMXYeAg9Om3ZVG8Uo
         LAenUMWRSUo5Hbfoheusp7ToHSxrKS+wVCvlPl1lqMpvKLovb77IYAblbSUGX1Qm3Vz2
         VU5OyU+MtFIfp7WdYtqM9qmrKnp7GG3s6y6KbdlGvivXk6Z1h2SvWW0ZuRKhTsFOnxgV
         X5/z28Q3KoIXlgPLaLwEutegAw+PcJ6fpyFU2kEw/rc6CaiCudy+54wlmQSxp2LFzi9X
         Cox5ODUOpy8oP5XzI7Xzjw00DungjhQb7Put2uLB4jfzeUe1eXHXXH2RUUESRypw5HXw
         SPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759667791; x=1760272591;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTBVd/nClqrF+np3hp6dXMEbrmomobOJty4TYQ6vLHM=;
        b=VMvuNVK+QzLdZMYKZqVloKlFOE/a4ssNxlb2jhWn2MH1rS686GwkywFi6Z4Pywe96k
         FJtZqUX15/n/rk7VSYePfiQAqt6nWj4MTr5AtROLZUWgYejBjoOMnelHnHhkruAdwvlr
         3UMW3o54qm8ISDZXJvR/ZaxjcKUCV1KGC27WMstNFhv/dhS8i51QlLK4wEzesjT0bUaa
         cTqMkJLhxxQwMAa2n54KVvgkVuLucHAJnYgCSggm972H8WfM3lfdIu/67qtZqrrFeIhD
         d0bklkSJyljJILkqSoWTMm3jFrtcQzgJGs2hlcOlNJTeuUQblSwSVxjHESaLgrVULmLo
         doIg==
X-Forwarded-Encrypted: i=1; AJvYcCV2PlPP/Pxx8ExjlF2Yi4FQvUoWmaYwypBazxEmXW30Up4rLwqBguFqZOM2fxhVOkVmQfe6cA4Xg2ES+9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MSOnHD6mC2CuQqZPmmgPkmEPI31mtUfINzx22b9CHxxtTkbv
	8okb1qLN27z670cBcc3OcSXnd1yv/5pZQ24djGKGNtBJV09KYph5FM8O
X-Gm-Gg: ASbGncsJzJTNMQ7bA5fiyNnprxcGSGuhmHykLIU1YdtiXi4VJHcCMz0OQPotE9pu1U0
	C+5f7Jp+UcYHxJbor815OXxcQjo9k39U8PigB3JYcU/RbINnm66C8KCA5Yz0Z0OTZ0+4BsrNnPa
	JfLdyrHM/g6dBTdLkVETn+rQboewBuPH5t+nF8UYTXic1N5YSJQuK7he5v+dZlXd7qg3UH02PJY
	UbebydJzue2WUpRsLnZ+Ex5aCcZjwOKk0T6s2MBcA7ZyESePyT8ETFEpJ7nRkYEH1v2McG1ZC8c
	iAtbX9Bi5gTIzHdvRkEtPW27qE/h9x9VNzGNBURbuZNNRFI1WEJvsc6Pw+lU8YefpzKz6aoFfsV
	5KxIG0be22P8yL5tOlcZZk2I00foSro8hWttDJXAOm24pNR4sszcHLxD92O2eOjjSY/Nmhi9ERs
	gDEmuIEYuaeylQoy2c
X-Google-Smtp-Source: AGHT+IGEqErpl4/yZCkCUF1+3SE3UIJICO6kK51WxwIZOJed0A6X31dHGb4CXR4L8Vz9X90HOvSsMw==
X-Received: by 2002:a05:651c:1b05:b0:356:839:56a with SMTP id 38308e7fff4ca-374c37ef44emr27261701fa.25.1759667790693;
        Sun, 05 Oct 2025 05:36:30 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2736c4sm33396251fa.7.2025.10.05.05.36.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Oct 2025 05:36:29 -0700 (PDT)
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
In-Reply-To: <CAFBinCB9hxgJt_rqdy_1bM0FjnnCt1K=Au77yxeuWox1wSvdDw@mail.gmail.com>
Date: Sun, 5 Oct 2025 16:36:15 +0400
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
Message-Id: <ABDCFF3D-D3EF-4EF0-B51A-AD6B25D78895@gmail.com>
References: <20250927130239.825060-1-christianshewitt@gmail.com>
 <CAFBinCCsTqsn06A5oVXGTW6PgmSQH0bHE+8PSftyWNRAbYUTcA@mail.gmail.com>
 <C8A273D4-5F5F-4BD8-911A-67EC9C3FF1F4@gmail.com>
 <CAFBinCB9hxgJt_rqdy_1bM0FjnnCt1K=Au77yxeuWox1wSvdDw@mail.gmail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3826.700.81)

> On 5 Oct 2025, at 12:22=E2=80=AFam, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Christian,
>=20
> On Mon, Sep 29, 2025 at 1:58=E2=80=AFAM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
>>=20
>>> On 29 Sep 2025, at 1:24=E2=80=AFam, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>>>=20
>>> Hi Christian,
>>>=20
>>> On Sat, Sep 27, 2025 at 3:02=E2=80=AFPM Christian Hewitt
>>> <christianshewitt@gmail.com> wrote:
>>> [...]
>>>> @@ -894,6 +908,10 @@ static void meson_vclk_set(struct meson_drm =
*priv,
>>>>                       m =3D 0xf7;
>>>>                       frac =3D vic_alternate_clock ? 0x8148 : =
0x10000;
>>>>                       break;
>>>> +               case 4830000:
>>>> +                       m =3D 0xc9;
>>>> +                       frac =3D 0xd560;
>>>> +                       break;
>>> Initially I thought this was wrong because it's only added for the
>>> G12A (which is also used on G12B and SM1) code-path, leaving out the
>>> GX SoCs.
>>>=20
>>> Was the 2560x1440 mode tested on a computer monitor or a TV?
>>> I suspect it's the former, so I think it expected the code to take =
the
>>> MESON_VCLK_TARGET_DMT path, which automatically calculates m and =
frac.
>>>=20
>>> I'll give it a try on Friday as I do have a computer monitor with =
that
>>> resolution - so any hints for testing are welcome!
>>=20
>> The original patch is from Hardkernel sources - I=E2=80=99ve picked =
it several
>> years ago and then updated values semi-recently after 1000ULL =
changes.
>> The user who originally requested that I cherry-pick it (and tested =
it)
>> was using an Odroid N2+ board (G12B) with a Dell monitor IIRC. It=E2=80=
=99s not
>> tested by myself as I only have TV=E2=80=99s not monitors, so it will =
be good
>> to have your confirmation (either way). If it=E2=80=99s wrong I=E2=80=99=
ll be happy to
>> drop it - I=E2=80=99m just trying to upstream and offload some =
longer-running
>> and allegedly good patches in the LibreELEC kernel patchset.
> So I've tried it on a Le Potato (S905X SoC) board. This patch doesn't
> do anything here (as expected, since it only targets the G12A and
> later code-path).

Thanks for testing. Let=E2=80=99s ignore this patch then :)

> Doing some more analysis, it seems that
> meson_venc_hdmi_supported_mode() simply prevents using any mode with
> more than 1920 pixels.
> I attached a simple patch to overcome this (discarding any
> meson_vclk.c changes):
> $ cat /sys/class/drm/card1-HDMI-A-1/modes
> 2560x1440
> 2048x1152
> 1920x1200
> 1920x1080
> ...
>=20
> My monitor's OSD tells me that I'm running at 2560x1440@60Hz.

I=E2=80=99ll pick that for wider testing, but it looks sensible. Thanks.

CH.

> @Neil, should we bump the limits in meson_venc.c to "4Kx2K@60" (that's
> a quote from both, S905/GXBB and S905D3/SM1 datasheets), most likely
> meaning: 4096x2160?
>=20
>=20
> Best regards,
> Martin
> <meson_venc-hdmi-support-1440p-screen.diff>


