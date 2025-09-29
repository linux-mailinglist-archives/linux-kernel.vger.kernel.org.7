Return-Path: <linux-kernel+bounces-835958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D6BA8721
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC47189B033
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726F278779;
	Mon, 29 Sep 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CWBqfZO0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0E625
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135690; cv=none; b=N2JK8raZ7N4qQfOPNhCieACQ1gScY7CUmSkVUJ1nP5VoVc2Rsd+q8GkuJk9MvHHuQ2IFpfXul1PQ7sr3+WW1sRGs7E72w29BQUdYDOQ7i/SuvWeAXuZhaEZNJKoE8C80cuCVordDO7b+GnT39r5fkFgcVF91ZzRzH2ElBeY2mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135690; c=relaxed/simple;
	bh=ipcd2RHyYDEBjL29RjOErCJnGZ4m2L37yFw6N1BWRao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVxM0Q5ZHna/awmwosnobopRxD7xc/hrTSlLAd1yBePfYkwZ2evLhBPgyYSBPzWICn+LEzjJutEGZSxs8q7k4nZGrflukAkXgxDp6tBmHir9JOk1PhKp/jJUlDiY5zk3IxAuQTaEIOhlCvU6WBkspkZrUdmdCS+wu7eMDBpVnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CWBqfZO0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2772539f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759135687; x=1759740487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9mWuuUO2oTiIhZB/31OQZAO1jKBhIUPfx0Zm8nC4/A=;
        b=CWBqfZO09hD7C+A5RYxdq+wwvlLx/8umLO3F2S39jkZJztsjqhC9/xYOonURCjA/7p
         a5JuQGUjLFcV/VHBPZkBNKmYE0M0zynfNiy/mu2c/9jQ1OxmzVW/RU1u8xEXQdqowHx5
         T19RVvNyccwA86wpOhabO4xnk+3Gz1vDhfIbCifNzRXJHZ6qL/0S946WiXocLaCQ3HPX
         iDSCr4llp1QcMHddQmd9VtijRVfUsH7fCpofIhwytgsb54vnvZEIKVrICdw+hnQvTULH
         cGfdpMR2q/o3GjZJsXYRluRGVV76yj69O+B+GlhwrW10CxpLf58ESvwzqYicFGGzryHq
         VDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135687; x=1759740487;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9mWuuUO2oTiIhZB/31OQZAO1jKBhIUPfx0Zm8nC4/A=;
        b=nj0BZPpDdeoYck2osXPnn7bKAKUqwZE+ScCfKiuXKzzmFYVYLNqopwkcagKoBZWpHY
         g+JulVSjhlChR3+KryBr+NwOX4hTqg+LTrJqcUw3zN9BGgfL096fHHp05kLzpNWhfmFS
         czMSZyK7jA3MLbSTFo+doTLRXts33hgqEmgjGbwNvInY9bAe/LxIu1rAys35hLrrs5NN
         Ymb0XL9VeBvMc5ZEl4gjkMVA5/R8p2qnrr2ULz5q/oS3lDJwuBPkY23uM78MsCx12zjl
         gOl8IcMbKGItGCg4gIqr+ZF76/XwxoOtlAcEL8EVrdGhIWWFq+DCoZYqr4+PYnf3PSjD
         fgeg==
X-Forwarded-Encrypted: i=1; AJvYcCU2VLtXHuC+UaBYXfmCp21AJF3WTEPi4oZubbtQLmuPoLTAzFQoz2SIMKOwdQ6i2jujZiZZlI1GMXGGCHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSyvqr8B6wsBQWmmux0P1e/25vh28TYeQERSG2a3MJeUcCR3V
	DRvSczik1GqGKUX5mPVhF2AUmlJoAlrM15icY1bB4qp2JsZ6kkg2SWU8slmH6rM39VQ=
X-Gm-Gg: ASbGncvVlR+hvSeFsAYsRWT+AYwIofPf8mKnOTCiKaQSO/3bq6xTbLUznh205R5giOL
	7K38gv0kLhezEGuUv8VVx4W32bCOXoG3OsFfiRrGUoZnnITPzObRCIsyct/4iiFqtfrWxJHq89U
	ndC+6pzqxBQ1mc7/3BFXnhFQg3cArwxOHZn3Z43Rimank4ttLN+vJ8hhY1DQgDujjhvpcTJ7qCW
	RblS6YxDbTsWM5OqI0tVHcyQSWnreCz7TZ1JtpcUINWzsugH9F+fTaXMs1qDfCTLjL5Czyl7hl3
	fzDie//aVEg3wi+Owm+xxlHKzXSM3DELs+M/BESv4qKr7RbJQGV/9iU8Ngd7ePGc+k9hZ4myqiZ
	FWySEF+/oxsr57wLIQ8sGrLFY1vSiasrj
X-Google-Smtp-Source: AGHT+IEuJjQ2ywEf1FmcgUiPlzRMP7EQ4wv/Yzx58fshvg0ascmwTL+/3T4ksUZ0TgAGJ3QGBI0S5Q==
X-Received: by 2002:a05:6000:2586:b0:3ec:ea73:a91e with SMTP id ffacd0b85a97d-40e498b77bfmr13575306f8f.12.1759135686798;
        Mon, 29 Sep 2025 01:48:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9891:6c55:82b6:bfe9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb7203b8asm17522265f8f.9.2025.09.29.01.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:48:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Chuan Liu <chuan.liu@amlogic.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
In-Reply-To: <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
	(Martin Blumenstingl's message of "Sun, 28 Sep 2025 22:55:50 +0200")
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
	<20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
	<CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
	<20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
	<1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
	<e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
	<9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
	<CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 29 Sep 2025 10:48:05 +0200
Message-ID: <1jfrc563wa.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun 28 Sep 2025 at 22:55, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> Hello,
>
> On Sun, Sep 28, 2025 at 8:41=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com>=
 wrote:
>>
>>
>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>> > Hi Jerome & Martin:
>> >
>> > Sorry for the imprecise description of the glitch-free mux earlier.
>> >
>> > Recently, while troubleshooting a CPU hang issue caused by glitches,
>> > I realized there was a discrepancy from our previous understanding,
>> > so I'd like to clarify it here.
> [...]
>> An example of the clock waveform is shown below:
>>
>>
                     1                  2
                     v                  v
>>         __    __    __    __    __    __    __    __
>> ori:  =E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91 =
 |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91
>>                    ^
>>                    1 * cycle original channel.
>>         _   _   _   _   _   _   _   _   _   _   _   _
>> new:  =E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=
=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91=
 |_=E2=86=91
>>                                        ^
>>                                        5 * cycles new channel.
>>         __    __                        _   _   _   _
>> out:  =E2=86=91  |__=E2=86=91  |______________________=E2=86=91 |_=E2=86=
=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91
>>               ^                        ^
>>               start switching mux.     switch to new channel.

Ok ... but when is it safe to disable the "ori" clock ?
Can you do it at '1' already ? or do you have to wait for '2' ?


> Thank you for the detailed report!
> This is indeed problematic behavior. I guess the result is somewhat
> random: depending on load (power draw), silicon lottery (quality),
> temperature, voltage supply, ... - one may or may not see crashes
> caused by this.
>
> Based on the previous discussion on this topic, my suggestion is to
> split the original patch:
> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
> driver already has this where needed) to actually enable the
> glitch-free mux behavior
> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
> also need to be updated) to prevent the glitch-free mux from
> temporarily outputting an electrical low signal. Jerome also asked to
> document the behavior so we don't forget why we set this flag

Yes please split the changes and visit all the controllers shipping this
type of muxes.

>
> Both patches should get the proper "Fixes" tags.

... and proper fixes tag maybe different depending on the controller so
there might more that just 2 changes.

> I think it would also be great if you could include the waveform
> example in at least the commit message as it helps understand the
> problem.
>
> Let's also give Jerome some time to comment before you send patches.
>
>
> Best regards,
> Martin

--=20
Jerome

