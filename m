Return-Path: <linux-kernel+bounces-793946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4443B3DAC4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0A6174369
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417425F7A5;
	Mon,  1 Sep 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5V7s0Hc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0E2571DA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710377; cv=none; b=RPg7NikpbEMM6ioMIAxhnJTGLi+lGF/Z+MxkHkbgscGSKDXr7iurbfo64MDO/xK0LbxN33NRcrM3tiIT3ETRzuHFT55izvsQOqmvzvt6ymnNVUvmy3zyIsFdsREyYu0n9qdfqM9wLI7KDfr7bSrjrwj6wo91nI5wPf0oMLRlJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710377; c=relaxed/simple;
	bh=ghUkVbbL6fSFFM+VnU2xLQumO120VvySAdwvS0T6ve0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5JVG2QuGO+z9n7wFFWPrAAnCCiMuCR5Wh9Mgw4CQKbootCZg6uA0YjyIC7e1swFC9Lq9DP9NIaHrqmR+6qLE37UuTIV5XaIbnLVZwTQchp7jZV6CYi2bQqQeEWnMmkvdRxI385CTZkRnX5nefPAPeKk7GxicZt7J0y+Qu4S8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5V7s0Hc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b873a2092so12359155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756710374; x=1757315174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RiPjeOB66FDKJZfr/ttLTVqavYTkJ/P7VOQby544s4=;
        b=L5V7s0HcpxIN9ySwa+9k8bvQSXh6cl0hgNZll5XItb+IdlZ5Vu2bJDbABBorJxKxF0
         UzscACIGYpDu4Np3yOwYzXlypBbXq7lXYdPo/SNf/vWBrRBfkNm3V5Ow3BgEI+qEntL1
         Tr904zYYYwi/WIO7yQduQExd5GVJ1lhGjnyClNX4+cuYikU274e/6Ek4ZmQRjEZwTPlH
         cajgmtQiOwddI1CWRuSaJzNIAwSKBK6Y/69Q4Zr06iuFf7idqzFEtsm/ap1F3jX0Dc8S
         4gZMLk1w0TGZ0cxhmKra/aIVjvHz6HccPzM4IGvEJM9qVthIB7lOtmUpymMXydjEGtdG
         VqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756710374; x=1757315174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RiPjeOB66FDKJZfr/ttLTVqavYTkJ/P7VOQby544s4=;
        b=PDoqA9shX/5jy3X8zYzoOzNGje1fPhSTOu2p420sLID9hNdlk08kP7W+LLGvMhE3v0
         SKR2kgPR4m9ZfzXO5B7qnGGt9j2hJ/AjLZojLiooHbHjKr2CrzQus6B7wc6xfIaWKavq
         uTO6ST9CBlfq/2gV7tjVyaLVPIJql0eRFNohQiffU1m0izcwZa+XqE906oq7CdwzcxMo
         HwrtPhOaO/fd+fB55YDplLEu8O9dZLcoi3Yso1Xl+iClGPjaDCdG6TSB3LoUzR6KJe0P
         Emg7rIxeyxJd57i+xy+mNIs5zc/o+pzu04rbjgyr5p4wkwnS1KeUOkOeUYtIHfrhBxym
         hFQw==
X-Gm-Message-State: AOJu0YxkkqMVNxwtQxbloQL/c5TGyixP1nc4r/kN0GeXGFpHoZJ6pj7H
	/Y870wauhRvu8TWjZH88D818J+urfERMmsAjG3msY0RaN0mbosn+nHA3T2jYg1InMOY=
X-Gm-Gg: ASbGncuCmSAGOM2hHsMp377KVTHxvjemV8qfRIWHSNyXV0DkAcy+FobyVNzyFwdj4u8
	+rYbROIqCLR9WFodq81hTHnAqANkXeweknBdLOPMnAtszOM9+nmEgn0iEEKnuIyiVL+Li36wwHH
	0y0bKlCClzT+Af1khij+kEI4SXIZAbMa+22yNcJrqgvrjQ1TPKwA4Hv6FntTHYGxb0BkipWnjIm
	Ezhw5j/VycMtOYPtn+WtLkkUaXS4ahCm8RjEVnS2w3OPn3MXBPLLc85cLBlTER4eA+djLl2mrjC
	DdPkKIG2YghiAVfnucZLecsFDqW2SRlOSkaLGjKdEvQI73iZCzenvjR5cFlF8IyBgFGLPFFZ29P
	6foRSZeeZXaBsqviOLdlpzJyN5rMhqmR9GRTvj8dd
X-Google-Smtp-Source: AGHT+IFnBbOE5ba7PQ9iK6x0QBC9gheBMd69i0QeCPDpf2UAKrxEuZOeM6Cz6ka7pF/Dx8JiLhhRIQ==
X-Received: by 2002:a05:600c:a44:b0:45b:7f72:340 with SMTP id 5b1f17b1804b1-45b8557c68cmr60349155e9.25.1756710374198;
        Mon, 01 Sep 2025 00:06:14 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d85f80d8casm541692f8f.54.2025.09.01.00.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 00:06:13 -0700 (PDT)
Message-ID: <73674a4e-2397-4470-8743-763e0fb7435d@linaro.org>
Date: Mon, 1 Sep 2025 08:06:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] exynos-acpm: add DVFS protocol and clock driver
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
References: <20250827-acpm-clk-v2-0-de5c86b49b64@linaro.org>
 <28b5b033-76de-4fed-af6b-6d8342362c47@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <28b5b033-76de-4fed-af6b-6d8342362c47@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/25 11:42 AM, Krzysztof Kozlowski wrote:
> On 27/08/2025 14:42, Tudor Ambarus wrote:
>> The Alive CLock and Power Manager (ACPM) firmware exposes clocks that
>> are variable and index based. These clocks don't provide an entire range
>> of values between the limits but only discrete points within the range.
>> The firmware also manages the voltage scaling appropriately with the
>> clock scaling. Make the ACPM node a clock provider.
>>
>> Add support for the ACPM DVFS protocol. It translates clock frequency
>> requests to messages that can be interpreted by the ACPM firmware.
>> Add an ACPM clock driver to model the clocks exposed by the ACPM firmware.
>>
>> All patches can go through the samsung tree.
> 
> You really should have explained the dependencies instead of me trying
> to decipher how to handle this patch. It's really not trivial.

My apologies, I forgot. If I tested individual patches, I would have
remind about the dependency. Something to automate for the next time ...
> 
> You do understand that clock is completely different subsystem (Stephen
> Boyd)?
> 

Yes, I do, sorry.

Cheers,
ta

