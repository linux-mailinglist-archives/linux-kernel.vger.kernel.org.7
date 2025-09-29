Return-Path: <linux-kernel+bounces-836289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E7BA936D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4187A8E64
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE93054E4;
	Mon, 29 Sep 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oDgohOEc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413C2EAB99
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149390; cv=none; b=Dk/V3kQqls2SIdAkuK9UoV+BbmEmkMqi2GPCaq4mogr6HgatdWt5++cuczCeoXVh3qHwhaVU28nBRrU5bC+NkmZ5dxjSzgQWNHKANYIg/1VDtZwaCz0oNIotGCEUMr+/asVwBH/pa7/h8zepX/VqmyP2oQ5eccCG51Mh0get3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149390; c=relaxed/simple;
	bh=lbe4TYsEeMKqVuQpR7VHFcFEHlUVlfr2EGTmCNN/Pxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzaqFEoXEwsIjzIrap88Lc9/Xb1e8eyplnJYdsS70JgiHG3cX2Mx3q+MTBBXh+T14kVdFaTxhXjajftLoRWvBBQxtDRJ5koJe+7DpRLOojN9bHF6oDX5GZPfFRPxviQzceh18mA7ZNxL+y0IQpCGzq49here/tom4s2yaeD65WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oDgohOEc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so13166635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759149386; x=1759754186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5TiAseZcVQOtO3WU44wqIk3ETdplagD04sSEDVxBRM=;
        b=oDgohOEcdcOZWjy/do716ZqdIpvJglD6qhwOYXHaBDoYXtq9UeSd0NV7V7td/Z4PGX
         B6NiqvAxXP6U+lyTdpy1Lx6cpOmJ21NVDjwnzjEtE0qAPc+vW+tmSLA2Zr7q6t501Jzm
         nYz09Euc+MNQnA5wU+7rVPMTCqlZbyMr5wS7JjAuQ/m9BZFOxQwdpPGQHUojE931gB/J
         7a61sBc2WtINrWKxlH8EtrhlK4EvQl6dsIb8kheQXYGs2/NhTklVvdOXvGkUBJdrvLue
         HlcuaYJITKkXMuGYDVFD7MzJ5V++z2bJWUd44wGxS9U5eCayUSHo+sULVCNhf+Y7zRZP
         xv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759149386; x=1759754186;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5TiAseZcVQOtO3WU44wqIk3ETdplagD04sSEDVxBRM=;
        b=ahftGPtiBVRDREBT45BXBjc/FSwGhxKXXyxO7xdayoICYebhTsc3hAvwV+XfKD15dy
         Wy4xEJMyJYQ8dfhjR4ovcNCiWNnKSj+lTa/ijqwKP0RVblnStDRnDfCJv3K8GfVYwDgp
         AHSKwQJguwd/DSNdIvvFohLnXXMk0MGNjZAz37pZz1Ng1pgz4fJmPI7GnaTA6TdXfLqb
         +3/s2a43fa0Bl8oXfC+kP5Ib+2MaV8H7ukNjiiIBokXFJZOHwjXUanWIRRMrRVOpeHsC
         /9THQ1afZU3MSPNFNU+RQAW5aMpD/fBWiNnKwyBRLqGdfzGe5MAdNGT0xMYp94xk2plP
         qAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbQboTJSqR1N1gPJ08g8Aq9zSnaIdgMt0XKXbrmoIqYoL4rEzHTRKZFSTW80w9uX1xx8cdzTlYqqSDpMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqA0f7xZRjSFNqCVSPkgnrJQstg7O8Mm/JvMSlV7pWfcstzcjN
	c+B1GihdosYOsmQoaGrIl4pN6V1kp2lHPF57bytxw7PvVifuDFYpzX+zX5//bu3gmKc=
X-Gm-Gg: ASbGncsA0hbzU90ndi6gYdtrg1/Xsi4DidlP4UJ9aRRWPqkY89/B8ivqoP00IuztB9j
	6tdh5a6N1opR4MfPCdQ24m13o5PfImgvSd87yjZcuXV5p/DIM6QsSCQ5YB0AmgtIDZUlb6lfqoc
	I5Y8+sRC/W0O2xycin4RzHy1NkVIcY7ln8FtIaM5zO+GQrcIquF53YZkpNl8ELWu3bpWEpHxH76
	K9tinkRq1ynqwfIa7LMDNb83B3/BAlGPpRsv8Z755tUHiQEsC0VQCN7HTGu1vokZZkHwvWHx0+d
	BwtrHVsUHbMii+uKliEKl5r7VKfVZR6O82SZrAaihqeRubmAG4TSTS/Mykdwy0ukHB8qcLkeR3k
	i4Itrp4c5zN/svQDjHW1LGadKfSEnnOg=
X-Google-Smtp-Source: AGHT+IHo0QKRizwsJhQ5D0tkdyBpVp2YHvhvxBq16FZ5DocejNzdXKBFoyHjJt0irT3wdJx8Oxn2bA==
X-Received: by 2002:a05:600c:4453:b0:46d:cfc9:1d20 with SMTP id 5b1f17b1804b1-46e329fa931mr124081375e9.22.1759149385782;
        Mon, 29 Sep 2025 05:36:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9ad:4617:2761:d4d0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a9af27dsm229660415e9.8.2025.09.29.05.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:36:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,  Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
In-Reply-To: <eee93d9d-2977-449d-8792-b2416f0c09ad@amlogic.com> (Chuan Liu's
	message of "Mon, 29 Sep 2025 11:15:46 +0800")
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
	<20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
	<CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
	<20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
	<1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
	<e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
	<9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
	<CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
	<eee93d9d-2977-449d-8792-b2416f0c09ad@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 29 Sep 2025 14:36:24 +0200
Message-ID: <1ja52d5tbr.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon 29 Sep 2025 at 11:15, Chuan Liu <chuan.liu@amlogic.com> wrote:

> Hi Martin:
>
> Thanks for the detailed explanation.
>
>
> On 9/29/2025 4:55 AM, Martin Blumenstingl wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hello,
>>
>> On Sun, Sep 28, 2025 at 8:41=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com=
> wrote:
>>>
>>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>>>> Hi Jerome & Martin:
>>>>
>>>> Sorry for the imprecise description of the glitch-free mux earlier.
>>>>
>>>> Recently, while troubleshooting a CPU hang issue caused by glitches,
>>>> I realized there was a discrepancy from our previous understanding,
>>>> so I'd like to clarify it here.
>> [...]
>>> An example of the clock waveform is shown below:
>>>
>>>
>>>          __    __    __    __    __    __    __    __
>>> ori:  =E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91=
  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91
>>>                     ^
>>>                     1 * cycle original channel.
>>>          _   _   _   _   _   _   _   _   _   _   _   _
>>> new:  =E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=
=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=
=91 |_=E2=86=91
>>>                                         ^
>>>                                         5 * cycles new channel.
>>>          __    __                        _   _   _   _
>>> out:  =E2=86=91  |__=E2=86=91  |______________________=E2=86=91 |_=E2=
=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91
>>>                ^                        ^
>>>                start switching mux.     switch to new channel.
>> Thank you for the detailed report!
>> This is indeed problematic behavior. I guess the result is somewhat
>> random: depending on load (power draw), silicon lottery (quality),
>> temperature, voltage supply, ... - one may or may not see crashes
>> caused by this.
>
>
> Yes, our glitch-free mux is designed to prevent glitches caused by
> excessively short high or low levels in the clock output.
>
>
>>
>> Based on the previous discussion on this topic, my suggestion is to
>> split the original patch:
>> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
>> driver already has this where needed) to actually enable the
>> glitch-free mux behavior
>> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
>> also need to be updated) to prevent the glitch-free mux from
>> temporarily outputting an electrical low signal. Jerome also asked to
>> document the behavior so we don't forget why we set this flag
>>
>> Both patches should get the proper "Fixes" tags.
>> I think it would also be great if you could include the waveform
>> example in at least the commit message as it helps understand the
>> problem.
>>
>> Let's also give Jerome some time to comment before you send patches.
>
>
> A V2 version was submitted later with changes based on your suggestions.
> Regarding the "Fixes" tag, Jerome had proposed some modifications.
>
> [PATCH v2 0/3] clk: Fix issues related to CLK_IGNORE_UNUSED failures and
> amlogic glitch free mux - Chuan Liu via B4 Relay
> <https://lore.kernel.org/all/20241111-fix_glitch_free-v2-0-0099fd9ad3e5@a=
mlogic.com/>
>

The comments I've provided on this still stands.

>
> Adding CLK_OPS_PARENT_ENABLE causes the CLK_IGNORE_UNUSED configuration
> of it's parent clocks on the chain to become ineffective, so this patch
> depends on fixing that issue before it can proceed.

Unused clocks are NOT a configuration.

They are by-product of the bootloader. You cannot rely on them. If
anything depends on them, you have a(nother) problem to solve.=20

>
>
> Jerome and I have submitted patches to address the issue of
> CLK_IGNORE_UNUSED becoming ineffective. I originally planned to wait
> for progress on this patch and then incorporate Jerome's feedback before
> sending the V3 version.

I've provided a suggestion but this something happening in clock core.
I suggest that you split this out of your series so things that need to
go through Stephen are not mixed with Amlogic stuff.

But again, you cannot rely on the state of clock just because it has
CLK_IGNORE_UNUSED:

* Nothing says it is enabled to begin with
* Nothing says it will stay on if a consumer comes and goes
* ... and yes, it does not survive CCF usage checking down the road.

It is unreliable and it is not meant to be more than that, AFAIK

>
> Hi Jerome, sorry if this caused any misunderstanding on your part; I
> will provide timely feedback moving forward.
>
>
>>
>>
>> Best regards,
>> Martin

--=20
Jerome

