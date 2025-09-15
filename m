Return-Path: <linux-kernel+bounces-817178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675DCB57EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351491643FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31B326D54;
	Mon, 15 Sep 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="0GppKSxx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF327324B01
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946422; cv=none; b=eZ3WnTT8cp7JCF+HnSK5LDnC+7lTnKKXtrlwj0ZornS0ihDdYhZi4eA5ZvCs1e6SObC5R3F+LgV6ukUlU9J/vdLjU2Z1UkLXjUUudpBaAm8C+CHj2rXo7FVWIjMkX07/oYh8cF5OwpT4VbRfgY+wKD/FUb/9p8rGcA/aAXFGb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946422; c=relaxed/simple;
	bh=B9iBG3o70JLtS2vZWkvI2+9FPF/4l8skzLqAxOuWZ18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mr0WicXxP3yfq+Wtdqk5m0vyLvWhenvt7dh/MQ0Ei++5n4cHnskV2t1LiHf9Lf5O+JLtykUBTpABZINKd0V8o2Yvx8bzrpZzhTxwLcNgt21PQFH9uAIjqSjzLtp50j1G/2FUfrBLWxK3vzalcTZU8CsDct2TR6/abFtcbZm63RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=0GppKSxx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ea7af25f8aso468340f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1757946417; x=1758551217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5icuTPC0s/pPOE2ESDNXoDhKzwTzNxmTUDIIwZXJok=;
        b=0GppKSxxzJYwb8q6mkmnwVu86uXNXxZyx4BKvawAqjt9w08K+RGFIrH0C4Plqc4xeO
         dg3OOj5NLeFRIXqonyyPBW4bFxJiPSsFDn8vYbRB6YdnSq6j2Z/i5A3mxPDBiUb3I5S7
         ohmYvrKahg2fsfx6f20+Lfg6w7f+W0fxcBhuWRSM9wyJjlS+YwhzOoGViUOP+6pjRHHn
         VqMVS/ZUfLBJNvqm3cpcH1O7fHKYPRbKD2XK5IRZR2vIsM7p4H0oRrux0KDf1DlFC+0/
         Sl9hRZ/UzTgMwo7eoqDjkxhm9Rp61nMjPe4cBMHr/BrXINnceOx/n+0suhlZH68dEap9
         tYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946417; x=1758551217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5icuTPC0s/pPOE2ESDNXoDhKzwTzNxmTUDIIwZXJok=;
        b=FJXe+zt9aGcN683VIRAdTL+ju3KeR+Ma57HWUqLJzJ/OJol82KRJT5qPyGb1ezjypV
         C9iMmWjBxRhqV1nCYAJgyxiAWZJj5C1K71Z8C+y1521mj0qptvRrdGfO/Cz5JD6GFFSU
         eEe3rBod2nTAGZ76Zm4tizUKok9dgi0EYcCOeciIk46mH+inowZxjKS9IazHVgBVOlMW
         uiuDSWFtTEAvoehL1zKPItu4Lm4IP4oR2JBTGDP1Y8ScJ9F8X+L/I/zg2P9xEE2aIezr
         mqcyBgOEzm+Ciyt6+Yc8Rmm9fimDgDzXucCppkvdeeJPC2Lqb4wvokvBtgi6bbw2vTc4
         I9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsUHeLCp9d+QPlra90ws3IUS59KMa1NNbqXjGYE77I4kqjQ3USO2s9jIDrrNhzgv5r/u2umtP/48KlAkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3xfGLie6ZELxsvO24Pa1RmzDaVtn6rqqM1++AFHiouhvJe8Z
	f3zsDznIyuvquIgPDQLd04SzflK/UutaSshdSjIFKEANITgE5gUmJMaWnNHH/YTr8Jo=
X-Gm-Gg: ASbGnctR2aUaqMkB59IZY287kcQe2RAkcfuDNgC3Uiv+hq6Kr12yGFTc6bWadszPM9n
	btJK3mC+8wn7cbTNL56W2shfw9e2BqWsdqsgRP0n71GsJ6PObCNefZBF0QolKS1T0kGApZBIo0n
	l2wpop/swK99GfvCk56jlCiqPdD+bHssoX3IDaQVp8988bneNZO2Hq+qoE/6v/JqX9wS63G486j
	M1vz1f9kd2zHus3lWe2S8PDc/MVn/Ml4UAhdGXLIRZ1BzvKnnaqOi576t/fb3t2mSIeT7Z5uMg9
	fgbyuO10VBXv8TBS0Sn5P9Sx2Z8S/ebXBacQREmSsvT9KeVif7YEnAAPQJ9LPvLl1Y3OZ85V+YR
	kUXfXfdZYYGrhfBj2TveSiety2TutsbGQdWPS4fffNXQYTTk9u9cslTGwg5m2xYGQ891qkTJ+MS
	2Y4rB351xs6mKxubr8muZVdiUZ87hOvO8t
X-Google-Smtp-Source: AGHT+IFs0mXefHor0OfcKtJiaLRNa2umUlSV0hyShyz1KhSiw3PD6NcKqHt+Ht1UUfx+184BUZwpHw==
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ea6680924dmr3500151f8f.2.1757946416790;
        Mon, 15 Sep 2025 07:26:56 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:8a33:a6aa:d0e:30e9? ([2a02:1807:2a00:3400:8a33:a6aa:d0e:30e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01baa70dsm187561225e9.15.2025.09.15.07.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:26:56 -0700 (PDT)
Message-ID: <aff80932-861c-4527-93a1-9fc2c1eb8d8c@hammernet.be>
Date: Mon, 15 Sep 2025 16:26:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: dts: spacemit: add UART pinctrl combinations
To: Yixun Lan <dlan@gentoo.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250915112845.58134-1-hendrik.hamerlinck@hammernet.be>
 <20250915120031-GYA1251948@gentoo.org>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250915120031-GYA1251948@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Yixun,

Thank you for the quick review.

On 9/15/25 14:00, Yixun Lan wrote:
> Hi Hendrik,
>
> On 13:28 Mon 15 Sep     , Hendrik Hamerlinck wrote:
>> Add UART pinctrl configurations based on the SoC datasheet and the
>> downstream Bianbu Linux tree. The drive strength values were taken from
>> the downstream implementation, which uses medium drive strength.
>> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
>> hardware flow control conditionally.
>>
>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>> ---
>> Changes in v2:
>> - Split cts/rts into separate pinctrl configs as suggested
>> - Removed options from board DTS files to keep them cleaner
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 389 ++++++++++++++++++-
>>  1 file changed, 386 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> index 381055737422..8f87f8baaf77 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> @@ -11,12 +11,395 @@
>>  #define K1_GPIO(x)	(x / 32) (x % 32)
>>  
>>  &pinctrl {
> Generally I'm good with this version, only have one minor comment
>
> How about adding a "/omit-if-no-ref/" before each pin cfg?
> This will shrink the final blob size if no referece to the node
That sounds like a good idea.
I will send a next version with the change.
>
>> +	uart0_0_cfg: uart0-0-cfg {
>> +		uart0-0-pins {
>> +			pinmux = <K1_PADCONF(104, 3)>,	/* uart0_txd */
>> +				 <K1_PADCONF(105, 3)>;	/* uart0_rxd */
>> +			power-source = <3300>;
>> +			bias-pull-up;
>> +			drive-strength = <19>;
>> +		};
>> +	};
...
>> -- 
>> 2.43.0
>>

Kind regards,
Hendrik

