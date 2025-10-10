Return-Path: <linux-kernel+bounces-848788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB1BCE91F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748B71898EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC72594BE;
	Fri, 10 Oct 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iFLkQlRf"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6E25784B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129796; cv=none; b=c0cNuIJfd10Vz/xw0Xlg6fPk94ss5z/4xd8zn5NbKeZKI4cyh9eUnB227VY8Z8oxEyLn7ScRACDSmE3bIU8lNhCbhmTpkWbD9TXc96fmJgijiOF52OmyRynp9JfdsgkHkrm/81Jn/KvR1Jf/WOmNHEnT4SP3T5kT4zf3LKKzB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129796; c=relaxed/simple;
	bh=CCuYNuIIVsY7FaNQiEz2s+18rwWUhIG0BCeJOEXr7Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM8jbcwHHfOmVn0AqD/nc0/mjnT6J07mNl/MTd0dKJZdZcRHYiNrPIQhZsdo+CdmWAsiUiJz8Zu7lxgJZpGAotUwNAPxAXadzC8gebf7aaZ9S9mx9IPQ3JDM0aKuXs93e60MO9hZ3Qiv/kawds/9z3b8TYVGtLAyd4SehouyD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iFLkQlRf; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43f8116a163so1162093b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760129794; x=1760734594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpaXFAs8jrvhj5Iwajcw+7el/YiNtrh4pH3E6yC24YI=;
        b=iFLkQlRfKAxRQ6MLGsgDryfgmis9DO4UmlLwTj6IOitWDT2N6udOwDK2I/b8wr4h3z
         6NCYAIBWqfrZL3cFwJRP+F0xb6t0r/HpWQcAvdhMaOK6jo+1+NvLyLkqN3iSv/WjATSl
         qPX3xdlR1sT23/gRer7D0dis1yu1iw02luV8hQSgmAs6N9SmykQpZLEv4PPuXoj3sb8m
         NZ+8x1dvsyafeR0GyvVLlB5AjsQhwfPP21eRS5CZLVywWn3PmNxq2WG4wxaIu+sJdoph
         y/FV8l9+RSWWLv3/rmRArBgB2LBfvhCh2vwTr1YuPPlynT0oVzaE4k/TmVCNMpUMOf2Y
         3lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760129794; x=1760734594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpaXFAs8jrvhj5Iwajcw+7el/YiNtrh4pH3E6yC24YI=;
        b=dWmUmnj7DSHdrYesl4QBO4gBAEpchDKtU8s6vp46WMj+eLIFMJapGYr3kdhzFkRuGD
         n2nNPLoR7vKCV2zIhYnXOfvRJox8jYWzdHaCESEU3rFIukQ6kn5axya+EFmtTexmtpEx
         ow8CqEX85qW26KbbU3m7PE9iEnpunlpfzSJTOi2rxEwHFGf8vGVJ36PE0sH536pbMvIA
         Jt5S5kzTPAYlY6f6/YoDqF4LtyV67OQh1L2Zv/bopI/Cj9NCBD7hrx6RfCJz3DWsaqyn
         xHT7gLPdQ32TcfGK0llJgLI1l27Ci56JkbCxbkkH4iVfp+vDnNHmOB/VNL9XoX4H0IcH
         R72A==
X-Forwarded-Encrypted: i=1; AJvYcCXtTqjGt1eqnhpCBdi0OQZFlulBh+XL4p8YouKk93mx1ooPkCtrUI7Y7PCgveFb6eeZakuPpa+CdFLKL8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMOolNa0FN3+kM79AclMAfSr7mJJU2doqacW/fThAmM+9NdqW
	Gy6pC6OyweDFTF4HjfIeZa80Z7oF0bbVx/Fse2gD8xBcB1dVfzZR9LLzexqMAuGktZE=
X-Gm-Gg: ASbGncuIHt9aNDnR7+JiXcyl7593Uo8gkoXnY+J5HjWz+JhPaKC5guCZmK7oLR5Rgqv
	f55SnbELfOQ01k39DMd/w4WxFsioSzmoUmnK/oa29wRt8rCOveVSr2ToHI708cmwaP86epWytMg
	Dp0RFtmiljy8FTWffmaLmT8HShRVryGAKS8lqiWH72947GDZEwed8sQw/DRgcJTqe45Zl5vvFOM
	CEPYDf1eBMF4LXPiXz8tscE5jqNMli/ULA6cOUm3AHV3ZgTWFQeRVXRQBcKNS2xTsg75GcrIHUe
	NaZpx93oy/jzAH9iSpGtsBcYySSTeA9tP6WkMQuq1vCexX5dm4MpRdkylX5luXEt3yJKIuzjVBQ
	Z3zDaLEtftTg7BvsTrks0i+yhzJTeuZI0IahPur8Hj73BOWiOiPgK5yAn63Zs3Opi6+NK21y83E
	pg859CNh8NkGLaPDbjUSbuXspsOA==
X-Google-Smtp-Source: AGHT+IFDRZYD0tvp0ZMbppnD3D1rHut3LIprbR5X32btFAwVwdld60PTV7/IdSY1ynz2HldpOFeF3Q==
X-Received: by 2002:a05:6808:4f4f:b0:43f:7940:69bf with SMTP id 5614622812f47-4417b3acf95mr6013690b6e.26.1760129793687;
        Fri, 10 Oct 2025 13:56:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f? ([2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65018200761sm952285eaf.19.2025.10.10.13.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:56:33 -0700 (PDT)
Message-ID: <c770c799-4318-4c40-bd62-3cefbbbef731@baylibre.com>
Date: Fri, 10 Oct 2025 15:56:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
To: Luca Weiss <luca.weiss@fairphone.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 6:21 AM, Luca Weiss wrote:
> This is an RFC which implements a potential solution to get battery
> temperature readings working on for example smartphones with Qualcomm
> SoCs.
> 

...

> 3. Add temperature-lookup-table as property to simple-battery
> 
> Since the NTC is a part of the battery pack, adding a
> temperature-lookup-table property to simple-battery would make sense
> instead of having this lookup table be standalone in the
> generic-adc-thermal node. However being able to re-use the existing code
> in generic-adc-thermal lead me to the current proposal.
> 
Did you consider creating a specific compatible string for the battery pack?
Then the battery node could have the io-channels property for the ADC
connected to the temperature sensor. Then a specific battery driver could
handle the conversion as needed rather than filling the devicetree with
conversion tables.

The simple-battery bindings are already far from simple! So I would not
be inclined to add more to it.

