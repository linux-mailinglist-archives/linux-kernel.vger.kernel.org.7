Return-Path: <linux-kernel+bounces-818505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E5B5929F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9D16FAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC15295DBD;
	Tue, 16 Sep 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ihOrmO5c"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316C27E070
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015993; cv=none; b=bLMFt+roXS+wk2kT7c2GWHN/l54ONAVa+AGGyqUgEs6JSBrIlf4gLwYAcuqDDZf9CL9Wdh2c9GD1btnAORvCRrKxQ84vg+fRVqa5VO/gR8HwLaE7JKtUMmikimVO9iOCRbec/H1wSY29TcpHrrWzqCfoUBbN3vzvWZExLjQZNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015993; c=relaxed/simple;
	bh=aZvFpwNaJVyxr1Z6SYFYKIzIYpMe9/vZAJbigLhrk3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s50Muka+ESEuie9z1bKxoL/0da/qovkUsBi7cCbvAq5tb+30zmMWCj+DEPuyFLehEObnorPn8Qv9t0NDdexo5yKb8guoTcoO1knlY0dMUo6xNVQhVpzufQntuHMi6XhRtMJzlCFeX7eL9TMmUVbNwg6YlbIG6VjmIyQz8STG4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ihOrmO5c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso31339605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758015989; x=1758620789; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKriTgmYlGn91P6qgtECUepZvJEA2Di6BahJZ7SaZyQ=;
        b=ihOrmO5cqm2NdGypR+6unc2baqGA4+BUETCtil9DupZVRrWNTF+ZtjXs3VyZZsKvyC
         nWlu6i97Jy+iceag3LAWRpbUKddQHrGkCSofskx4fH83E1g/X8YFluCgMYLCeMRSqpoX
         OCIl/nqdHn0B3N44zShbGv9Uc/mbG5Ks+JQ2DMbCqnmsZ8e20axmn53s0FbsOvLLiPLK
         3RypZFPaAvAAYrokQJoiCPq0xe6EvWyxuC2p9w6xoS7sUQQj39V3MkkZsR4Q8fVilnef
         bUm7pCruTx0txc1o6yPnyFrOfgICuw5o4SbJR++i9nNeKRF08naAmacCVoqODqI1xGwn
         hV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015989; x=1758620789;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKriTgmYlGn91P6qgtECUepZvJEA2Di6BahJZ7SaZyQ=;
        b=J2rojQ6Isss9qDfvdiT34nJT4G+uYqt6S6KbXylOeQBK/8YR6NMkyPNP5vrHsP+6IL
         FAnXg399yA4rw0nTaPHGELr5EGkuFPJ5WBVvM3hoAyT1FyngH0BzrwOi+JVWL+PyRY78
         Ym+gU2Moc5oUPXU8bvTUuU0F3P2mUTdtxED+v+geQhKk+caNEa2JTUQIaQILlIzXxbil
         nT5CjKKYbdcYk69fDsMyN6DdLlsMec7QrQXSZ4PTcUdcEha24jlfpdS4zYjrU21NWlam
         nu1Ef9KqHcJvB5jfnor9Dg4RVMgP1tsnA/MvqwgWR102D+G/b0DoPBclq4qhGzVo6UeN
         iDog==
X-Forwarded-Encrypted: i=1; AJvYcCXpx738KD/+vOiD8S5ZXWlEEyRcVDboyNxqBA98GNTMSJNA2auacwjtbsEtWzMQdYM9ARvIcI+ZnOwVszs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFpl2n6xIWXrhsB6xQ9v9O69DpuvzWh/SwMp+tGYnb1KyE6wQH
	+zXKgbwxEkA7jLRw2y4VXHTZWik6cbAzYeWySyjId2uzdkFIHXaVLUaaQffIimFQMNM=
X-Gm-Gg: ASbGncsPU62BKdM7mvqiC8yF7/NOsm6BlzDdXYDF2msuD0iPgn6aY1nUQa2QamQjlle
	66uEF4vd6j6arms8QHn6aNPyA2A2uQOh/pUUpq/uwYBQBMEUOkLEMNqKMmssWmTmF0ztIxRjBOT
	sWL1vkpEfMJxmOygfF/USPhRuHQp5H/hQPK8enmgHcQC79/rWIPDWkl6gZCBYtgSMWEI+fc26m/
	RmlZnqSZ5irP8dKgyjs61ipkoTmk6z8uVDwuENk7OGdbHDXAYEbuQlj7bFv4+kJewGvImze5tKA
	/2knTVhCfqUgc8FITtsVfr1cRXDKFJu2Qed1oS8qzot9Ygzmwfak/0QQWA7cm+IM6DrephkavI3
	jciebutYQxSpPin8GODUv
X-Google-Smtp-Source: AGHT+IE8PXskyGCers87Y7NP0MSYZZPH7pEpN8IMr6HhZYRCkIe+WiPVCA8noQ//F0XdONjDZfZtNw==
X-Received: by 2002:a05:600c:1c0e:b0:45f:2870:222e with SMTP id 5b1f17b1804b1-45f2a023010mr72082385e9.26.1758015989240;
        Tue, 16 Sep 2025 02:46:29 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a6cd:21af:56e0:521])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e8b7b6ff8fsm13195432f8f.61.2025.09.16.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:46:28 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
  Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/2] clk: amlogic: add video-related clocks for S4 SoC
In-Reply-To: <66f130b4-88d7-46d2-9f66-9055896d445a@amlogic.com> (Chuan Liu's
	message of "Tue, 16 Sep 2025 17:30:29 +0800")
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
	<1j348mj0sw.fsf@starbuckisacylon.baylibre.com>
	<66f130b4-88d7-46d2-9f66-9055896d445a@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 16 Sep 2025 11:46:28 +0200
Message-ID: <1jwm5yhgqz.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 16 Sep 2025 at 17:30, Chuan Liu <chuan.liu@amlogic.com> wrote:

> Hi Jerome:
>
>
> On 9/16/2025 3:47 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Tue 16 Sep 2025 at 10:06, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>
>>> This patch introduces new clock support for video processing components
>>> including the encoder, demodulator and CVBS interface modules.
>>>
>>> The related clocks have passed clk-measure verification.
>>>
>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>> ---
>>> Changes in v5:
>>> - Add Acked-by tags from Conor.
>>> - Remove unnecessary flags as suggested by Jerome.
>> The request was "in an another change" ? Why was this ignored ?
>
>
> Sorry to bother you. I'll drop the flags for 's4_cts_encl_sel' in this
> series and submit a separate patch later to remove CLK_SET_RATE_PARENT
> from enci/encp/cdac/hdmitx clk_muxes. Is that ok?

Why can't make it part of this series, as requested ?
It does not seems that hard to do.

This is another unnecessary revision and the community will have to
review, because you ignored some feedback.

As noted by Krzysztof, you really need to pay more attention to the time
and effort other are spending reviewing your work.

>
>
>>
>>> - Link to v4: https://lore.kernel.org/r/20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com
>>>
>>> Changes in v4:
>>> - Add Acked-by tags from Rob and Krzysztof.
>>> - Fix compilation errors.
>>> - Link to v3: https://lore.kernel.org/r/20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com
>>>
>>> Changes in v3:
>>> - Rebase with Jerome's latest code base.
>>> - Link to v2: https://lore.kernel.org/r/20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com
>>>
>>> Changes in v2:
>>> - Removed lcd_an clock tree (previously used in meson series but obsolete in
>>> newer chips).
>>> - Removed Rob's 'Acked-by' tag due to dt-binding changes (Is it necessary?).
>>> - Link to v1: https://lore.kernel.org/r/20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com
>>>
>>> ---
>>> Chuan Liu (2):
>>>        dt-bindings: clock: add video clock indices for Amlogic S4 SoC
>>>        clk: amlogic: add video-related clocks for S4 SoC
>>>
>>>   drivers/clk/meson/s4-peripherals.c                 | 206 ++++++++++++++++++++-
>>>   .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
>>>   2 files changed, 213 insertions(+), 4 deletions(-)
>>> ---
>>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>>> change-id: 20250715-add_video_clk-dc38b5459018
>>>
>>> Best regards,
>> --
>> Jerome

-- 
Jerome

