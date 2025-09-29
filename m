Return-Path: <linux-kernel+bounces-836303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A60BA93F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850C77A6115
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADC30594A;
	Mon, 29 Sep 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Eu1ilJTh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D0304BBC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150526; cv=none; b=RxZbs85w1n6f65Lc3CQDULL7s2keuvP9dnM7r+LIyR+LmAXo58upxuJg1IgpjiS1JX/7R77TFwOej+IhuM0pks6T/wBj3ZCDb8kbHKweKkx8YvgB+EGbQyAHYW0//00aPpJ4dhwInwpUZkyori2/dW2He+v3l/UrJacTr/h6oC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150526; c=relaxed/simple;
	bh=jrwBbbXXDaBjS/wd/tHW0cdSBXmArxaZRUoB6beYLM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aeNApdNwb37oHoeVgiYVtBrpoDAWqb0BxTtuhKn/suf8cUOUA6JeQKIquCTmgLT5n21MMwSBEh3sOcqLEygleaETDPnuzdmjsMkUe2KaBOStRgB9TlMHBPFQ2JSoorpedYTGQUt5kbOOpqeowyssg0Lebxum9FWjtu4wKfZKTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Eu1ilJTh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so13349715e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759150522; x=1759755322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4AJhIRDhtQztFOcWyZbbOIS6wbTlWTjViXERoklQ24=;
        b=Eu1ilJThNuzLjztuSWjmFDwpen6iRw7wG6Be4GmbZHmj/kq2XcTPMTvyqPiAZ2edGq
         5RjvDB6aAps+v/MkIDHGseMgmlFO4wndRP0BxpVheCf5CuXoSSnGrxSzlbPnhtBBC4Q5
         w1pctru5Q5xT7MWW71HI0sdber0zQe2xTpdsGnH867GEfxts+z6RZ7U4eiV/umMS3jxv
         kVBQchw9ocdImE4k/SQ4pmOIWaRwL/8Gc6dXLkX8RslT7nA43vhiRoIl1Pel4uHET6en
         rv1QLZtg40F3Nbu7cHY/my4uik4C5zUWNZy+lBSQgkR10jSygRtwySZiPOu2NlVzXuyn
         O05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150522; x=1759755322;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4AJhIRDhtQztFOcWyZbbOIS6wbTlWTjViXERoklQ24=;
        b=YhhVflkn4uzgeRRI4sk7d2jRjULcbI8jmNpkCmCAjY53JYlmByqsuPuaSnJNMF/S8G
         4D4h9Lg5wMAlDhZIxOZfiyuryc+uwpkMF5M2XyvHuvyllukbaJgxViUTAdAtWjEmKbFr
         0ArphT0M+EvwN+jtjbBhmvrO+1psPnfmWcLC/3Ld2FU3XC444uIFkaKBMSGo9DmfekfR
         lNE7VSfExGCuw0icREPK49iAsXTmFPSafqQOYBk73jqkbfdjtgubQ0wFGgzEkS1E3ZMT
         FVF3aSasVm83t/AyO7kfTW027f8nXi8xh8pukrUpjyACUEm3eFi9W+6uSIeNU2fGxbM2
         SK/g==
X-Forwarded-Encrypted: i=1; AJvYcCWqjqV5OPmVfnSGrxN1k5JdxiDP8eAi7+5JuCMzJz7VhQ5h2BSrQGKI1127y1uUBqRhspSpbREb757aObg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjF0yTrIoXfxbytUEgUK/pqg0Jv+RXhJA93tg4eXS3HGLsV0RD
	UUYf3gyqRnwlPz9sEv+rzf5RFDFco24a0sSfnOtsng9ZYq9LOXlSTsn4+yi+HsnxHU0=
X-Gm-Gg: ASbGncv2fnooLj4mZl4b1wp3Vt3PG/lO59civMh0jdBUz/UTvUB0o2wVazCQlNlZnEO
	MIyqmtidhizFAapGryLI7Ww4NxzEcjrzBfBQp+PRg07tng6NInd3Nk1tjhADtQBTAzF44zxWRp7
	Sj9ARbf9N2cmyBlbLoUcZJ6kVLvi9/v2Xa3L2EMMpUJrC4w6jNA9w4myb4BNOczb869KbtdRg6Q
	Aj9ok7anzEgY1zO+Mp7HkC2BJRZOs6UlqYyP7EWq1kOsy49EuiuSrLE1Tr0w40pgT4cStCO3XRR
	68KxHybPWRRhpYYaYXTMydX8BITRrW7lgRfvXmbKgRnb+lmux9HdNT67gD1EfsAdVa6b5NOzyWZ
	mIQog+w7xFGrodWhJP7GKC/gDFJihEmQ=
X-Google-Smtp-Source: AGHT+IFVFN0XLFy2t2r8lsVdrqYeMn/8TCLqXkS7DTElSFf2//cTI3KRbqZwOsdLupaXoEn5NrWF2w==
X-Received: by 2002:a05:600c:3b23:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-46e32dd1cbemr151873375e9.7.1759150522095;
        Mon, 29 Sep 2025 05:55:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9ad:4617:2761:d4d0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e56f64849sm12304965e9.11.2025.09.29.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:55:21 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,  Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
In-Reply-To: <36cd6282-ae1d-43f3-8738-592f043d0ba6@amlogic.com> (Chuan Liu's
	message of "Mon, 29 Sep 2025 17:31:07 +0800")
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
	<20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
	<CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
	<20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
	<1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
	<e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
	<9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
	<CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
	<1jfrc563wa.fsf@starbuckisacylon.baylibre.com>
	<36cd6282-ae1d-43f3-8738-592f043d0ba6@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 29 Sep 2025 14:55:20 +0200
Message-ID: <1j1pnp5sg7.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon 29 Sep 2025 at 17:31, Chuan Liu <chuan.liu@amlogic.com> wrote:

> On 9/29/2025 4:48 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Sun 28 Sep 2025 at 22:55, Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>
>>> Hello,
>>>
>>> On Sun, Sep 28, 2025 at 8:41=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.co=
m> wrote:
>>>>
>>>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>>>>> Hi Jerome & Martin:
>>>>>
>>>>> Sorry for the imprecise description of the glitch-free mux earlier.
>>>>>
>>>>> Recently, while troubleshooting a CPU hang issue caused by glitches,
>>>>> I realized there was a discrepancy from our previous understanding,
>>>>> so I'd like to clarify it here.
>>> [...]
>>>> An example of the clock waveform is shown below:
>>>>
>>>>
>>                       1                  2
>>                       v                  v
>>>>          __    __    __    __    __    __    __    __
>>>> ori:  =E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=
=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91
>>>>                     ^
>>>>                     1 * cycle original channel.
>>>>          _   _   _   _   _   _   _   _   _   _   _   _
>>>> new:  =E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=
=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=
=91 |_=E2=86=91
>>>>                                         ^
>>>>                                         5 * cycles new channel.
>>>>          __    __                        _   _   _   _
>>>> out:  =E2=86=91  |__=E2=86=91  |______________________=E2=86=91 |_=E2=
=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91
>>>>                ^                        ^
>>>>                start switching mux.     switch to new channel.
>> Ok ... but when is it safe to disable the "ori" clock ?
>> Can you do it at '1' already ? or do you have to wait for '2' ?
>
>
> It should wait for "2", because there is a state machine in the
> glitch-free mux, this state machine is driven by the working clock
> provided by its channel 0.

Then I don't think the 2 flags are enough to make it safe

Nothing guarantees that CCF will wait for those 5 cycles to turn off
the clock noted 'ori' above.

I think you need new specific ops for this mux

Something that would
* protect both parents before changing the mux
* do the actual change
* wait for it to settle
* remove the protection

>
>
>>
>>> Thank you for the detailed report!
>>> This is indeed problematic behavior. I guess the result is somewhat
>>> random: depending on load (power draw), silicon lottery (quality),
>>> temperature, voltage supply, ... - one may or may not see crashes
>>> caused by this.
>>>
>>> Based on the previous discussion on this topic, my suggestion is to
>>> split the original patch:
>>> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
>>> driver already has this where needed) to actually enable the
>>> glitch-free mux behavior
>>> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
>>> also need to be updated) to prevent the glitch-free mux from
>>> temporarily outputting an electrical low signal. Jerome also asked to
>>> document the behavior so we don't forget why we set this flag
>> Yes please split the changes and visit all the controllers shipping this
>> type of muxes.
>>
>>> Both patches should get the proper "Fixes" tags.
>> ... and proper fixes tag maybe different depending on the controller so
>> there might more that just 2 changes.
>>
>>> I think it would also be great if you could include the waveform
>>> example in at least the commit message as it helps understand the
>>> problem.
>>>
>>> Let's also give Jerome some time to comment before you send patches.
>>>
>>>
>>> Best regards,
>>> Martin
>> --
>> Jerome

--=20
Jerome

