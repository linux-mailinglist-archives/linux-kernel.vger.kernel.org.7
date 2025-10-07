Return-Path: <linux-kernel+bounces-843844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F44BC064D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAC8189ECE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8622A7E0;
	Tue,  7 Oct 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK50/cll"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A68247DE1
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819923; cv=none; b=PuzKcYPIEjN+uHAISUTX5vYmAdX8GTIKcBtLj52dqDsQi65ob3WguECROsTprh+k6BEHL8cf1kOu88Pj1x/B5gfdlUieSZL8lj2LJWY8lkjg53b30mxLFG2U1zPiKr8RNi6qNAgvNqoK+UrdJkFR9uUxXHvIi2+6yV78Kf38yMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819923; c=relaxed/simple;
	bh=4loRM5gaCb0DmrQhpmPykT92MCQHM1mMk27AIHOqax4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHyuB1Gr3gciPaLps4FoWqjUuYu4GTZkSVdm4VEv0YV8CZ4xCCoFeR9nJi+Z2J42qTi6+SjqtpfYAF/ZsSzVydDPBQ9rAlshL5LztCCBpOWipwSqnEUxC6VvFs7hrTaiEKEMCxtEWw/qv1j3MAbzt/1o0q+jSdh2IeltimhGdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK50/cll; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso7841883a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759819920; x=1760424720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qi4jSexlkWUECSgX2tttLCZoyDCErk3ZozLNSj/B39w=;
        b=NK50/cllulywJQvmFClNR3eoMhJoWhwLHrjoPJAntq0k5TnKhI1hc87JVOgqS5RZFi
         WVmSeGYqh/tRDuBH825GEzcCUTxOcL1xZtYdEI3CU1RdUnOtnjzqc/JEPm6896+SludR
         WL6Zz8g0mr9q27ytEuYthP5C56YkAFvCzk6rFJBWO9K12Eal3Cbl9QqiCMBkrpSEmpUM
         Q6w5dV995K/0W8XdLbIFXWQmhRMD0M3ZlaOK3ZDrwMjjEjKQQsF6yGr3Hmo7SuYU+fqS
         HRfzGA34a+cfgbrWGu1qEGjykmzG5QgDexGAbh4YdFDbCPUd+LWiM0qUQuy0Rpe6INbs
         fiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819920; x=1760424720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi4jSexlkWUECSgX2tttLCZoyDCErk3ZozLNSj/B39w=;
        b=Vs3zNnSL82z8EQeEExnh2BgkiDtc6yMjaGu+qEMzsFw1Yjq+IvSHRvY+nDTzeU/Rbq
         3YSkY+Bd2fZK985axdhX4izSz1sHvg4Pg7shHwwcZNfskGUs7rog5UuJvtV33jYEOvS8
         K4/gv4ZKp7aVL33QIrNaDnarQGbzCiP4zUmWsoVdWUn+QSbl3Nj8DeCvbkA8Lf058py2
         +u4c9o/Zljv+F29Te+4YRrPV5KWN3Rb2zXHQkhVuLHwHUNbN8Zt5v0zf7gwzS6IUF1wl
         7EnrTmq06BuivgRwIU0Ueni5iFC35aRY/OmxrQDX154r2Gk/UtZe3Lj1eqaeZfkR4hwI
         jILA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Kvum2MMDn8m64SlJ44OKW4qhZevOBoTZtJ30pDZoruCexY90ylXsJnMnGEbcFZFwQuE8XLikewYwMAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5e62yvKFEAKCJOCf0GnVZDwrN7VFBIZq7TkcxeEEcajjo1ma+
	UjRsTwJwuf/8+nwPiJ8VI0oLzSIfQAa8QcmIvBI3r4Dhi7AUysC2ka+X
X-Gm-Gg: ASbGnctwXQNNTCZbX7fks506dgA/z0nhB+vFKhxPVxN5dr2Ck9oEELtkPgb1nqkd5jH
	GdelPdnoU6RzbYLeUGEr4uzR4tTEoFInEvg3phoWc5c50FhyrjZiR+aa7LiSkkbuwF0zMubjIuv
	5seL4Q5zVp/phdG2HiDHEdg1RciBsfmxX3KK4rRFwnrJprBdiUFsigslSwmEeQO+sLCkDsXxI3d
	P8YVJcWY2tO/uPHTBSSNaKTIV1wjzDkeZWVQ3FEARryW/XIojlVHDUPfg/nhYmD6v21wpdisY7Z
	oxqT/7Y5UaRLips6UNycP/gTqI3M5b12oedFM/mRpD/bGbvesYLrMmX0vCHLDwFaU9VS9bQGs19
	cQq1OMryOU6lxSoW1QfG8eYZM9kVgvqecIMXD/HXauJemvGlQI4P/mUS/y9vl9t4Aq3N/EydhUL
	ePGV3nF4dhov2GfYkb+w==
X-Google-Smtp-Source: AGHT+IFvQ+6sECDp6X1RNdh4i7W+52rk1hyacY0z/SIBtBQwCNvXpsQ4sXmTPd2Hk7QYTKW33PKEiw==
X-Received: by 2002:a17:907:7ea6:b0:b43:5c22:7e62 with SMTP id a640c23a62f3a-b49c408734dmr2046124866b.50.1759819919751;
        Mon, 06 Oct 2025 23:51:59 -0700 (PDT)
Received: from [192.168.1.10] (83.21.74.153.ipv4.supernova.orange.pl. [83.21.74.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a684sm1299412866b.52.2025.10.06.23.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 23:51:59 -0700 (PDT)
Message-ID: <cd54058e-0208-4357-8a5b-4c6bb9f6cfb9@gmail.com>
Date: Tue, 7 Oct 2025 08:51:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 0/9] clk: bcm: kona: Add bus clock support, bus
 clocks for BCM21664/BCM281xx
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek
 <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Elder <elder@riscstar.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
 <d36c5597-e26e-4ddc-93b3-222d8b40dab7@broadcom.com>
 <175834646902.4354.13114906749225372224@lazor>
 <7eed7848-b3ca-4415-85c6-7267c91560a6@broadcom.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <7eed7848-b3ca-4415-85c6-7267c91560a6@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.09.2025 23:04, Florian Fainelli wrote:
> 
> 
> On 9/19/2025 10:34 PM, Stephen Boyd wrote:
>> Quoting Florian Fainelli (2025-09-04 11:28:34)
>>> On 9/1/25 10:07, Artur Weber wrote:
>>>> This patchset does the following:
>>>>
>>>> - Introduce support for bus clocks. These are fairly similar to
>>>>     peripheral clocks, but only implement policy, gate and hyst.
>>>>
>>>> - Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
>>>>     and update device tree bindings to match.
>>>>
>>>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>>
>>> Stephen, are you OK with taking all of those patches through the clock
>>> tree? Patches #8 and #9 have a dependency on patches #2 and #3.
>>>
>>
>> I don't normally do that but sure. Is that a Reviewed-by?
> 
> Sure, let's make it official:
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> if you prefer that I take those patches through the ARM SoC tree, that 
> works just as well, I would need a suitable acknowledgement from you to 
> do that.
> 
> Thanks

If it helps, I could re-submit the DTS commits as a separate patchset, 
and only keep the clock subsystem changes here. Then the clock patchset
can be merged first, and the DTS patchset can be merged once that lands.

Best regards
Artur

