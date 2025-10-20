Return-Path: <linux-kernel+bounces-860275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA36DBEFBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EFE3B379A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0192E0415;
	Mon, 20 Oct 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMjVIAXw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99629ACE5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946365; cv=none; b=nUkYgLL3Z93pnmBmrLhFbXBUDreFZzNDKceo/9w0C8ILsO9Gq1v7x5k4Sqi1reXfzR00lvi08OgDMO/MVWesxxUsxgraZgl9W+8Ggug51ZvlkGmOfEi/byMlVV/PXJFbBJTuE3pFp8vU0MG67fgfPB1vqHpd4Viu46DvtDEOpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946365; c=relaxed/simple;
	bh=X7/0YOAqO5V2172ZrybLrIHVzwGVuhBmLKlylhJxm1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEV7g/7fTWsYAty9zAPRZDrRVjS47GvO4oEgHfODMuqlBR6/5TqFLoLMG88qOcodMgUoKZJjDoW1KEKtfQoSzDvyrrUwk0ALT2IZX+qmjvfqLflqX5mAtobPiqfX1rTnY/JN40GuVyiQhQmUHZnHVNflqasXvl1qUpEMb4DO/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMjVIAXw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-427091cd4fdso1672107f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760946362; x=1761551162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NeEefsjDjBTzkWLJQXyP/5aObcnLAGWfiU+nORhhDXo=;
        b=BMjVIAXw/qb0mfPjoMsyfy6xPQmKl4Qu+YGY72C6YEByg7AIqSq5CCpHo5oiYK9GBG
         p7BYn32ak7gyLIWfxzqngx13/XzqxW8phpWGb0AYyyw6NK4/D/jf0J7x04Lz8u8CJdDG
         W4/QpjldgFiw16NfNAgRgzjGhXSLGhDKLjiR+EIzzFrYxcbziuZt+kgvsVoz3P6tBXza
         0Ms5y8Ch+ybQRN1eTTM8hej4h5yGz3Tye5c+iX+XGUuZQGAdUcN5HxtkszUH9wG3VCJq
         ZRKSCC8Xf43dGOdCTPZ/9vNyNx0I/DjQn+oqtW1yJXyyXNoPxLkorp1T1hqMiiDHxx6c
         h5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946362; x=1761551162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeEefsjDjBTzkWLJQXyP/5aObcnLAGWfiU+nORhhDXo=;
        b=Vhf8fFVRvLk98By4O8M/g8F+7pPtwtWStxbnmh3g0hUhSKV2BgzShBMny7Q0loKUql
         vJDSVJ8hWW584I0PsjDNovmgIvJMB54e5Ugx1Of3mZITO+Tns1I39xW8Z4j9E7W3Bz1C
         O7XhY79Nzx1uIRQw23X436rzE2xpEfQ3JzZQTjSium3mesfX7mzVIkFc/qqb6K1bGBXE
         b4q6JTXdfP9B8C6S/5szqewyent9NsJ9zXCs7m3X7cNHjyLP/8iIfVtc/OHNqOYMLA9d
         qG5qI45fr8uU3eZAGx0Y6eFtdizoMCwYiEl14Hz/N4qaBJoQJ+64DXAL+vVRzUFNns5u
         u3bg==
X-Gm-Message-State: AOJu0Yy8dVmgt+OGzxCHyYVJYL9oujfxVZta4hsqdlhNTlu5KJZ+IS8C
	coejybkaH8hubXWlOBJmD1LuxRA9x6j05yTuWVb7jxeRoARyxHt3sgA3cTljM50Dais=
X-Gm-Gg: ASbGncu1+JzLJYHn2QfJG2pKi5y6q9m0nb3sGBm9xr1fo7F54cKnM9lbhvdQC280JjY
	+CWO2iqo3O7ycD1uj5O9uKsauXRVgDqkyE53twh/wKLolohhJz91jNXIIV07CnqcWJjV2LWgExm
	rIGzHQ5wk0590UA03sukPbw3dDuT+rda2J3/P0i1c1LHrzzPU+JbplldALOfl3HAAancHudh9vT
	4hTEAvUdgP/jMmDs3upuzxCBGf9sLUqGFHDHydeMPm2x9EQ7XfLi8GqEMpvWZUSVJf4qePLfLPM
	5VBDyWn5M6J8IQF3LvSH632lSEY679EwV83IElDBzM8E8Ox9oNzn4ywALOIeeZzPt/CLy0i4un9
	KUkuwa3y7nBu6LY5xoi/46UprFQVQE8zKWwMiQQY9uFffHlPgP0oVA56qw5y90yBlSxoeHcB5JB
	QEntX31b/LM11NPKYPcSI=
X-Google-Smtp-Source: AGHT+IElXYjtpSTA367NjPFbuT2cNOkeZqKtyb865DWWHqYMgZ9skD7DsDruCaof11OozJ+7TkNWCA==
X-Received: by 2002:a5d:5888:0:b0:426:d587:850d with SMTP id ffacd0b85a97d-42704d78d2amr6946088f8f.28.1760946361718;
        Mon, 20 Oct 2025 00:46:01 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a102fsm14122755f8f.1.2025.10.20.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 00:46:01 -0700 (PDT)
Message-ID: <17695fcf-f33c-4246-8d5c-b2120e9e03b1@linaro.org>
Date: Mon, 20 Oct 2025 08:45:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] clk: samsung: add Exynos ACPM clock driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <20251010-acpm-clk-v6-4-321ee8826fd4@linaro.org>
 <92f1c027-bacc-4537-a158-2e0890e2e8ee@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <92f1c027-bacc-4537-a158-2e0890e2e8ee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/25 7:54 AM, Krzysztof Kozlowski wrote:
>> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
>> index 76a494e95027af26272e30876a87ac293bd56dfa..70a8b82a0136b4d0213d8ff95e029c52436e5c7f 100644
>> --- a/drivers/clk/samsung/Kconfig
>> +++ b/drivers/clk/samsung/Kconfig
>> @@ -95,6 +95,16 @@ config EXYNOS_CLKOUT
>>  	  status of the certains clocks from SoC, but it could also be tied to
>>  	  other devices as an input clock.
>>  
>> +config EXYNOS_ACPM_CLK
>> +	tristate "Clock driver controlled via ACPM interface"
>> +	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
> 
> I merged the patches but I don't get why we are not enabling it by
> default, just like every other clock driver. What is so special here?

Thanks! Are you referring to the depends on line? I needed it otherwise
on randconfigs where COMPILE_TEST=y and EXYNOS_ACPM_PROTOCOL=n I get:

ERROR: modpost: "devm_acpm_get_by_node" [drivers/clk/samsung/clk-acpm.ko] undefined!

Cheers,
ta

