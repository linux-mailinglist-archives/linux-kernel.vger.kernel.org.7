Return-Path: <linux-kernel+bounces-841516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39255BB791D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92EA1B212DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C62C2347;
	Fri,  3 Oct 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oASl89za"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E972C1594
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509329; cv=none; b=IIToiC6MuzJ/5/URwpBNMlFm+hxZ+LacdXsIFLNo5XT4v4KNuKjptahhEFsym9OwlKvbYtfMjRix3usyd/z0HGMriC9GMXXF43aKYVTsVkbBGiRPXT8IF4odC4TUwKSlL/mb64gy6xZRSXnTFfVPtJAZoTMnQ6S3jEH01jWR2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509329; c=relaxed/simple;
	bh=I30MtonLfzJyjjR9OhU6FDyMeifYKqRo+OhnYiEYRZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EVm4edt6qibljv6qPP6fgzp9OBtvwGyxoxH2+O5TD8kR4CNl+dy5t/kk+cov/Gf2e8bhbky1CR9WTkwc7AUo0NmHXwo9dtqbd5hyeXqbGZC76AXHp5BqgBJ31v4G0Ubv4O0L6UNepcOQdwleplVxeBi+EMXUzbyz2GkAIHqLFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oASl89za; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so1289876f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759509326; x=1760114126; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I30MtonLfzJyjjR9OhU6FDyMeifYKqRo+OhnYiEYRZ4=;
        b=oASl89zaf6nfzo4MOxEA/4NYS10rkmVLEwWDMFJrZG/0AAdj8FKAhEKc7US2M6m3Q4
         jEaSXyhdt6ZQsGX1Jn4Jry3M7SMf8ZPXhF+nintMvOkQ3f3qh5AqDyzKHk/E32n/eh2z
         cqOVwZgXKXEXYGFYBXr6dcjl7jnqSUT866uAokUAa2e91iH3U0ODACAowd5O5hAzlfaR
         0Tx21eWWRD8VHFYUpWISzMnyitE5QZ2GBJ/TbbhOIiIQipC4TyhHfPXFIANreYEu6EiP
         tipA81kUjtsEQ+gClwlxoRDoXMf4wFgt+iS77p+PCPFdmi2ukefutqUewJZQE5CfFKY5
         JhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509326; x=1760114126;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I30MtonLfzJyjjR9OhU6FDyMeifYKqRo+OhnYiEYRZ4=;
        b=YVz1j1ba5407sSYlqbLfhOZlK7tgMUxUespUxIPsHtfAvQ6jxDB3vpbQvJ2NBrHcqJ
         /BD7Pq3IhQSg8wqjdIKFXSEwM8YVbbwcSOYdy8r7JJ/0uOWtAP88Lt4C1YV2Vpi/bGMR
         +JHRsE1HaT6Ku449TwtpeKWTEAfmgGslrrRcKyMmuarkdkKmPiU2Mjoq1n3AnPkripKx
         7gAGtWhHhSXmFkrkIEqGkIGsIFCmCVABcQOwLi/MPY7i5q94K0mJa7GJJaSOY9Uz/oR3
         uYajQsedic23DFZSYMMrYABm3Qz62OdupHskgyW0c5CR4naPjZbn6raFshziqOEgYinH
         8AiA==
X-Forwarded-Encrypted: i=1; AJvYcCXsZMsnN18xMVIeceJMCwCe/xlhEtXcsljwOeD0khabj4tg2Lu4rP55d/7cfUH2U/k0Tu0rhrtlFRwkSyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/xgIh3B6ks9pAxQS+zqXiFBcFaaB/0TSP9tTaffGGfvTChu3
	fzMIha8SOqYHlCWD+eABqDHLbqjlDY42Hlm2jQ0FWoog0OG28SBOJjwMboAsE/UneRzzSNXOKf+
	GQLEO
X-Gm-Gg: ASbGncu6fxRaHyYAMLkvoLPgx7YB7C/KnVznSZf0AW6pZzVhotCYJ4y/Ovj0FIHqa+E
	fD0rD3lkkqQYVZyOESz1955X0V+YgoHwoqdNMfuH31iQAYqSGxumf0mpQhar9XwNYgFfF7+ddGQ
	hr858zbEwd0D34Z8VT6T0jvLk5RpV9VwNxjKxdppd5hOTnxMfqNS7A3Pw9bIENb3wPpBdZL4T7c
	JdSIEfPfYlh1eYmtoUNN8c3wKP01prhDRA5i3qQQkwpceLWTTDGlTyIfRASanz9ujWWEWBYCF1E
	lAYsHkIJZ9boDdNB4e9nNCHHrsuVxOi+sysu4P9O/QaXR1ZkACh082CkXMaWNZCeYs4rxob+fPz
	CzwZsNKnSlPmlC51pa6Jesp+gOLXrl6UxeZr/Oij2/y4qPsvKDKYm3NNXhtV759e8Mg==
X-Google-Smtp-Source: AGHT+IEUablzE36cMk8CVwI0yiUUTr0R9KkSb7pzSBhrHE4oBgjDJpd0ISn4QhweGmHb1W4PbPa0uw==
X-Received: by 2002:a5d:5f93:0:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-4256714d39bmr2395773f8f.20.1759509326121;
        Fri, 03 Oct 2025 09:35:26 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:e0d5:382b:d116:cf67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c3esm8580556f8f.1.2025.10.03.09.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 17:35:24 +0100
Message-Id: <DD8U00VMC4P1.1P4RGHGOLO92J@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aiqun.yu@oss.qualcomm.com>,
 <tingwei.zhang@oss.qualcomm.com>, <trilok.soni@oss.qualcomm.com>,
 <yijie.yang@oss.qualcomm.com>, "Tengfei Fan"
 <tengfei.fan@oss.qualcomm.com>, "Qiang Yu" <qiang.yu@oss.qualcomm.com>,
 "Manish Pandey" <manish.pandey@oss.qualcomm.com>, "Ronak Raheja"
 <ronak.raheja@oss.qualcomm.com>, "Jishnu Prakash"
 <jishnu.prakash@oss.qualcomm.com>, "Kamal Wadhwa"
 <kamal.wadhwa@oss.qualcomm.com>, "Jyothi Kumar Seerapu"
 <jyothi.seerapu@oss.qualcomm.com>, "Hangxiang Ma"
 <hangxiang.ma@oss.qualcomm.com>, "Vikash Garodia"
 <vikash.garodia@oss.qualcomm.com>
Subject: Re: [PATCH 00/20] arm64: dts: qcom: Introduce Kaanapali platform
 device tree
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Prasad Kumpatla" <prasad.kumpatla@oss.qualcomm.com>, "Jingyi Wang"
 <jingyi.wang@oss.qualcomm.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <DD6BOLBXKBYP.2NVXRXGJ9W3IG@linaro.org>
 <58a69bdd-f26e-4cc2-bbe2-6e9d5bb69aa0@oss.qualcomm.com>
In-Reply-To: <58a69bdd-f26e-4cc2-bbe2-6e9d5bb69aa0@oss.qualcomm.com>

On Fri Oct 3, 2025 at 10:09 AM BST, Prasad Kumpatla wrote:
>
> On 9/30/2025 11:18 PM, Alexey Klimov wrote:
>> On Thu Sep 25, 2025 at 1:17 AM BST, Jingyi Wang wrote:
>>> Introduce the Device Tree for the recently announced Snapdragon SoC fro=
m Qualcomm:
>>> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdra=
gon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
>>>
>>> Bindings and base Device Tree for the Kaanapali SoC, MTP (Mobile Test P=
latform)
>>> and QRD (Qualcommm Reference Device) are splited in three:
>>>
>>> - 1-3: MTP board boot-to-shell with basic function.
>>> - 4-16: More feature including PCIE, sdcard, usb, DSPs, PMIC related, t=
sense, bus, crypto etc. Add QRD board support.
>>> - 17-20: Multimedia features including audio, video and camss.
>>>
>>> Features added and enabled:
>>> - CPUs with PSCI idle states and cpufreq
>>> - Interrupt-controller with PDC wakeup support
>>> - Timers, TCSR Clock Controllers
>>> - Reserved Shared memory
>>> - GCC and RPMHCC
>>> - TLMM
>>> - Interconnect with CPU BWMONs
>>> - QuP with uart
>>> - SMMU
>>> - RPMHPD and regulator
>>> - UFS with inline crypto engine (ICE)
>>> - LLCC
>>> - Watchdog
>>> - cDSP, aDSP with SMP2P and fastrpc
>>> - BUS with I2C and SPI
>>> - USB2/USB3
>>> - Modem(see crash after bring up)
>>> - SoCCP
>>> - SDHCI
>>> - random number generator (RNG) and Qcrypto
>>> - tsens
>>> - PCIE
>>> - coresight
>>> - Bluetooth
>>> - WLAN
>>> - Audio
>> Were everything described as audio enabled and tested? As far as I was a=
ware
>> some devices required some soundwire rework to support soundwire microph=
ones.
>> Is it finished? I don't see this linked here, but you state that audio
>> features "added and enabled".
>>
>> Do we understand this correctly that, I presume, everthing that is more-=
or-less compatible
>> with previous platforms were added and enabled (with renames) but not _a=
ll_ ?
>>
>> Probably some rewording is required.
>
> No, As outlined in the commit message, validation was performed on the=20
> Kaanapali-MTP platform having
> WSA8845 and On board Microphones(Mic Bias supply from WCD939x) , and=20
> there is no SoundWire
> microphones support on this MTP platform.

No, the email here clearly says both MTP and QRD and then that audio
is enabled. That's why is should be clarified otherwise it misleads
that audio is enabled on all platforms/devices including missing
features.

Best regards,
Alexey

