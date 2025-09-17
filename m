Return-Path: <linux-kernel+bounces-820321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F5DB7E939
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991FC1C07254
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E26331AE3;
	Wed, 17 Sep 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y3LMGCoy"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A1248F40
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100250; cv=none; b=fJt6421ZzEjBbiUZo89SUQ65CLmZuYRjierR/yNZPRnFulY2eSlkzU5x830jAPXA01A4P++07A2OpuxvQ4iDeM87/7v+Cz4ta7PVSRH01nk+YiN13eT0wbN96ba6oxeO0RwgowZ6obzXaL6uFsjZI4R6CRlAJWbfi39smyWtdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100250; c=relaxed/simple;
	bh=tp3yfkg0GbRWDYfv+9qGd2iSh8ZB1FOcDNuHn8ewKpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Op5AV0ICQxvnRd/6h294r9ICYNDVlahHnmz60+rYNYGOOyYipA4L6aaK7WProJWA9FNqHJV7p4bN9CrAYWjAZhc/TUOoU+Pbgyw5mXY1AFwntOa+IpuVOrakJ2523gXOkNN56mWW6dm61WdM+bXMQw3xk5p5xviVw2CNqA6NfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y3LMGCoy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so43760925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758100246; x=1758705046; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlK2stUccurl04mbWawfAf/ha/VEIfyoutD9WxWnA1M=;
        b=y3LMGCoy5EzRxef+IzIfpv6wwqryKRAsVx5bVrSfcgdSAjvjQZw2LE8wVBHR3wIw8J
         Bfd4tz3fjEgm0mVgTpQ/H5xDSj8rogrKOCZU3QnVTps2oGvBPyhP48F9/YtCNfpzemVV
         t3AetX6g5jiBuF5c2A+0GAsch/gtPjnrsSj2p9+JZ4ESxMpZqkTQ34lcABBYVlVIcA9U
         VeCL6NOlOO2kTRbDNJejrU469TcNMOZ/L6mU9u6RvRuQAUlV8CI58iqs9vEWoZTq6/nj
         EiTBKQwPu4NzsSr6ls8lQM4T8RCMiXIGVuwicCT2QV21DtYXcdpbMrEr31JLuv79y2X8
         deOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100246; x=1758705046;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlK2stUccurl04mbWawfAf/ha/VEIfyoutD9WxWnA1M=;
        b=Nmdk/0PVu56mTv0CkeQQBeEd2ac6uoOudjZkCX94Wx9JJ3XWHvW0VwT7rhQxazzQf+
         h2sqvvFRp7m2I8X2VM7JY7Us/PWGKkwT4Uwh5tdP5+IQD7m6f0POrFi6KjFM5DNC7InD
         CVoYF/iwb1icuT0SnPEw/0rHJWZ2e/3otB54WKSNTlpFpyas0iWAHJYmokLTe937xAqQ
         1Psus+XdEIm8Ps3ZMNEtxcmnMv6JaSLjS3ybmcKAtSK2hh4fbBhnntnYlIxrR+AInm/X
         FPVHXutMgujlA7BObRcknEofFcX7asf9IAcGONr8HLUFUmn7aRjWOGCB0WutXKUmYCT2
         MI5g==
X-Forwarded-Encrypted: i=1; AJvYcCVvsZxbAehEKJd1cN7wLNNgSfbmf7a7nWetGN7cP2At3se70k/3iqyamOwkdDl6HS2QnmL5bx8sMTSvvQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvo3e+vwzYWXQknnbEF5gpIDqeVaro3G39a1SijiLEr7S4p10T
	G7QeHT4LDKUjywGSnieBepw59gbEqF82D/wxzXJAJjx+9iBpnHO094xfmPMLCDjvcnA=
X-Gm-Gg: ASbGncuqn7Nr3zPHasbpW8LbGzelt/+y2Ol/NIbztOAvk8GLISyGMmMOo8z1MTVbvE0
	2tIX3Vb4O61/5MdFtci0WPQbGS/wYFDWZwbVCwH5UQYkQT/aWRcuYj04ifq2RbS9BAE2QsQS/H2
	aAnn0lYQuSRVRJ4U0LsmDUr7sjZVHGH60GhI7pcbvzb6BvGWQCC8C3aWEbk7QiPxdiR8uX+kEsR
	0f0O8sV3dtOWOHMkgDXjSG03W9Ls5SUmTwqb9evOPLepb6ft1E+mp9qANikqGVYA5KpmnxRGQjm
	qDL+rVfvxAxUPdYa7TaN6/50xV6G3r2dpjOV4GBdgbYimBwuegptLbYRL2vje3e2Q5W0wqXCP2w
	fgvJP3/nMZnSa0VbbSjShKQ==
X-Google-Smtp-Source: AGHT+IFPGc7ic+PrwXQdYuhF8XZWH7tHR3Wzubn/3T39N6UzWqLydVcD4Osfm3AnC6uPAm7ruqpt8A==
X-Received: by 2002:a05:600c:1c87:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-46201f8aa4bmr12363615e9.2.1758100246219;
        Wed, 17 Sep 2025 02:10:46 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d458:6239:fdc1:d868])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f32181a47sm37857465e9.1.2025.09.17.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:10:45 -0700 (PDT)
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
In-Reply-To: <91935087-0f0c-42ed-8ad6-f6312240413c@amlogic.com> (Chuan Liu's
	message of "Wed, 17 Sep 2025 10:02:19 +0800")
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
	<1j348mj0sw.fsf@starbuckisacylon.baylibre.com>
	<66f130b4-88d7-46d2-9f66-9055896d445a@amlogic.com>
	<1jwm5yhgqz.fsf@starbuckisacylon.baylibre.com>
	<91935087-0f0c-42ed-8ad6-f6312240413c@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 17 Sep 2025 11:10:44 +0200
Message-ID: <1jqzw5h2az.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 17 Sep 2025 at 10:02, Chuan Liu <chuan.liu@amlogic.com> wrote:

> On 9/16/2025 5:46 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Tue 16 Sep 2025 at 17:30, Chuan Liu <chuan.liu@amlogic.com> wrote:
>>
>>> Hi Jerome:
>>>
>>>
>>> On 9/16/2025 3:47 PM, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On Tue 16 Sep 2025 at 10:06, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>>
>>>>> This patch introduces new clock support for video processing components
>>>>> including the encoder, demodulator and CVBS interface modules.
>>>>>
>>>>> The related clocks have passed clk-measure verification.
>>>>>
>>>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>>>> ---
>>>>> Changes in v5:
>>>>> - Add Acked-by tags from Conor.
>>>>> - Remove unnecessary flags as suggested by Jerome.
>>>> The request was "in an another change" ? Why was this ignored ?
>>>
>>> Sorry to bother you. I'll drop the flags for 's4_cts_encl_sel' in this
>>> series and submit a separate patch later to remove CLK_SET_RATE_PARENT
>>> from enci/encp/cdac/hdmitx clk_muxes. Is that ok?
>> Why can't make it part of this series, as requested ?
>> It does not seems that hard to do.
>
>
> The topic of this patch series is "add video-related clocks," so I'm
> concerned that patches adding or removing flags for other clocks might
> be considered off-topic.

If that's the case, you could simply reply, stating your concerns
instead of ignoring a comment which does not suit you.

And yes, you should adapt the cover letter to explain what you are doing

>
> In the next revision of this series, I will include a separate patch
> to remove these flags and provide the appropriate commit message.
>

Please start with that.

>
>>
>> This is another unnecessary revision and the community will have to
>> review, because you ignored some feedback.
>>
>> As noted by Krzysztof, you really need to pay more attention to the time
>> and effort other are spending reviewing your work.
>
>
> I'm still a newcomer when it comes to upstreaming, and I'm not yet very
> familiar with the rules and processes.

That's just not true.

You have been doing that long enough and have been reminded time and time
again not to ignore feedback. Continue doing so and you'll be ignored too.

If you still feel "unfamiliar" with the rules and process, then you
should read them again:

https://docs.kernel.org/process/submitting-patches.html#respond-to-review-comments

> I apologize for any inconvenience
> this may have caused during this period, and I sincerely appreciate your
> pointing out any issues with my patches.
>
>
>>
>>>
>>>>> - Link to v4: https://lore.kernel.org/r/20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com
>>>>>
>>>>> Changes in v4:
>>>>> - Add Acked-by tags from Rob and Krzysztof.
>>>>> - Fix compilation errors.
>>>>> - Link to v3: https://lore.kernel.org/r/20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com
>>>>>
>>>>> Changes in v3:
>>>>> - Rebase with Jerome's latest code base.
>>>>> - Link to v2: https://lore.kernel.org/r/20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com
>>>>>
>>>>> Changes in v2:
>>>>> - Removed lcd_an clock tree (previously used in meson series but obsolete in
>>>>> newer chips).
>>>>> - Removed Rob's 'Acked-by' tag due to dt-binding changes (Is it necessary?).
>>>>> - Link to v1: https://lore.kernel.org/r/20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com
>>>>>
>>>>> ---
>>>>> Chuan Liu (2):
>>>>>         dt-bindings: clock: add video clock indices for Amlogic S4 SoC
>>>>>         clk: amlogic: add video-related clocks for S4 SoC
>>>>>
>>>>>    drivers/clk/meson/s4-peripherals.c                 | 206 ++++++++++++++++++++-
>>>>>    .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
>>>>>    2 files changed, 213 insertions(+), 4 deletions(-)
>>>>> ---
>>>>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>>>>> change-id: 20250715-add_video_clk-dc38b5459018
>>>>>
>>>>> Best regards,
>>>> --
>>>> Jerome
>> --
>> Jerome

-- 
Jerome

