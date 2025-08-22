Return-Path: <linux-kernel+bounces-781678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47273B3156D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E370AA13A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389472EE261;
	Fri, 22 Aug 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/IIx3pr"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6A2E92DF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858435; cv=none; b=N6gkQk/P8VQldkIcoONBqpmPFlF9TnMQcpdyRkDJsXqkPIMCZjReH7sO72hP11xpcMY+DHwWxqW5i5ry3vZOiarSerflSEY8PJz0xjo9Lo28gVaxrbP0CaHU6iH9GXgTOL+DtKUm1SGRKaU3AmnAq0dfGjmo1A7KgRdtHvE6wOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858435; c=relaxed/simple;
	bh=DKiNN1RMdn2Gn2M4I96hlwsVSaQvym/NqklBxGqQSGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dby4Oi5Earuhx2cdA1BaoBxqnNNoqKQiz9ZekNGhMQd0waDCXXGfilSZicLLgDBvKrYzJhoCO3BvsUa5Ev+FsmUofJb1bFFRWxbA465LI0I4yvvrBnbRaomoPFhIBwEj3s6/GNjjQMmWnUlr3wbN1MKOA8C9OKpmdAi4E5DhKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/IIx3pr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7acfde3so296264366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755858432; x=1756463232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cd5s72x9mZV/+O9tEQqldJerG6gz6k4UPw65u8py8ZY=;
        b=I/IIx3prkNnuzMy6JBsKrt51brhDi4/t+bHBD5i5Sv9heUwQXkMIpVqe3qNVKj81g5
         OJs5QZS6wIJqcgSwdno2W/6regDlqUkqIX/krg4e9tfYfqt5xSMgvT2QWlCLN1iA32hC
         DdtBzxsBg+rDyTCuxu5uBZY8LDz+XH0We8qAo0tOtjrificJ2GM6C+etqH3MQaq779Dq
         RKc63E0Zwu7qImRpFb13gPYqtf5xktrNQGR0UABmZf0Cf0O012eyskgrZ2/BSlQ2jSTZ
         sR9Xkhme6UILSuXSTwRHoC07Wr6tDRVvoeyOs/AW7mA4RADcDv3F861lVtzsjmYQyFQQ
         B1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858432; x=1756463232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cd5s72x9mZV/+O9tEQqldJerG6gz6k4UPw65u8py8ZY=;
        b=MR8kiAIDP4+ApxVkevlw6pSZxl8ejPkZgMAtDeCiuwQGYq3RAVCsBCytc+1SJWjfyn
         zYxQlfd7P4nLql3Bg6PO5EMyuslErLpwBoANxc4+c67D71aYwOdUjno8JD/DMLFgQib2
         LirvJis5OP5AUPA7a4+ALDQ7DqaxXnKeyqTZboh4xJiJDji3bBCv1K8B8LK0p9ziLHqt
         Hgxz3hi4CTaSxAizhiGOwAb+59xGOqfyvNR9EW07qB2C7bMiSr03UW1PB7cPi6SVMlgP
         gpxMP2mG8gj1i4+tmRZpY0aNa6TzecqFQsOXGVE9o7sYGBBDRpSO/IEbw7fxLNaRoTOc
         CLLw==
X-Forwarded-Encrypted: i=1; AJvYcCWgmQ5Q+SsDIXqoh90XHYIm49pPWBfzmmN0J2P5xTU4mDC4FTnB7/vmfTnjjk5gaIX3moocmyIQnTbvt2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTbmcK0QL/Ptdun9ts/CmW9l0zx/SDE6mTyQqa8ZNOOHMPTo8
	EaIEFqCGtkO40SkKxXVjFFIT1Iztop/h4d3JSC0ACJoGhKijgtnrR/XVSlOauukPyBc=
X-Gm-Gg: ASbGnctxTBzR8gJAxzH+SbyWVKqGkp1UiVIW4i44I+P/L38k9zuoFQ2dyBBs/YDNImb
	lWa6LR80QtP4HQ4GK1ZaFHUJeCgu/3d5YlpZIKEmIOhvQLyKyEBcuO24h6uzL9bEQ6tfkY67N6D
	OBV6GkTu4zFCUyGKYrT9alFwlEKBrusW1T2tpNR9kbZJZSA3xvoRqEWA+m5FIfS+0dhTApaSILS
	knaAsTxYROWvL6SIk0HkzxPRofa3m1mVbzs3DXqgxSt0WnDyMexC/6zIClSq/RhN8/G1llH8AwE
	9PtTOUEP1nCcsCKjQ4u7espsp0PA2xRZgbS9eupvl66JSxtqlwvur5JZBV3wirTIL6YugHirnUz
	T7gWUptoiGT3vX1GvAzsDqivayCSn8HeF
X-Google-Smtp-Source: AGHT+IEjRd6Tx5sKZi6OWN0Ddp+BLYTOG0lrQ3ub++Nybf0iOaCMKeFsTfA36+kF67hMQ9sg6CmMMA==
X-Received: by 2002:a17:907:3f11:b0:aec:76c6:6ef6 with SMTP id a640c23a62f3a-afe29605d34mr191833466b.50.1755858431819;
        Fri, 22 Aug 2025 03:27:11 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.104.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca67fsm585912066b.92.2025.08.22.03.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:27:11 -0700 (PDT)
Message-ID: <493a072e-352c-4e96-b58b-04b56fa56dc0@linaro.org>
Date: Fri, 22 Aug 2025 11:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] clk: samsung: add Exynos ACPM clock driver
To: Brian Masney <bmasney@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20250819-acpm-clk-v1-0-6bbd97474671@linaro.org>
 <20250819-acpm-clk-v1-3-6bbd97474671@linaro.org> <aKdmurrT1pFtLSI8@x1>
 <720799b1-04ce-46da-b643-1adbdfc661e6@linaro.org> <aKhFOHFGKPYXgIri@x1>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <aKhFOHFGKPYXgIri@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 11:23 AM, Brian Masney wrote:
> Hi Tudor,
> 
> On Fri, Aug 22, 2025 at 09:14:03AM +0100, Tudor Ambarus wrote:
>> On 8/21/25 7:34 PM, Brian Masney wrote:
>>> On Tue, Aug 19, 2025 at 11:45:38AM +0000, Tudor Ambarus wrote:
>>>> +static long acpm_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>>>> +				unsigned long *parent_rate)
>>>> +{
>>>> +	/*
>>>> +	 * We can't figure out what rate it will be, so just return the
>>>> +	 * rate back to the caller. acpm_clk_recalc_rate() will be called
>>>> +	 * after the rate is set and we'll know what rate the clock is
>>>> +	 * running at then.
>>>> +	 */
>>>> +	return rate;
>>>> +}
>>>
>>> ...
>>>
>>>> +
>>>> +static const struct clk_ops acpm_clk_ops = {
>>>> +	.recalc_rate = acpm_clk_recalc_rate,
>>>> +	.round_rate = acpm_clk_round_rate,
>>>> +	.set_rate = acpm_clk_set_rate,
>>>> +};
>>>
>>> The round_rate clk op is deprecated. Please convert this over to use
>>> determine_rate.
>>
>> I can do that, sure. Shall I also update the kdoc for round_rate(), mark it
>> as deprecated and add your Suggested-by tag? It would help other newcomers.
> 
> I am working to remove round_rate from the clk core and the various

ah, great. Thanks for the pointer!

> drivers. Your driver just needs to be updated similar to this:
> 
> https://lore.kernel.org/all/20250710-clk-imx-round-rate-v1-10-5726f98e6d8d@redhat.com/
> 
> Brian
> 


