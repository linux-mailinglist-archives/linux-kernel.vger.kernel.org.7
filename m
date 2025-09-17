Return-Path: <linux-kernel+bounces-820082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1034B7E674
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B6B3221B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A462737EA;
	Wed, 17 Sep 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BSImQFk3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48983271468
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091801; cv=none; b=uTaqg+R5YJeQcXyeYWf7Ulv0PzshiLtBv4BU3JU13IgLB86N5iK1L19FHsxQbe2CuKwgCeNV5eucqodUSVzsRZuJqvAmD0dDY3rTJrNt92VpC18JpO2hou2i/isF+8oP99aCz7J7ZNop/+yWiB+4pOBpY1FnqPLba6Ph3zrAo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091801; c=relaxed/simple;
	bh=i8tNuAeCQ29SwLEzEbOdCknl5LH6FMHRPqBRsuyT904=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etwFXm1e8U26Vmh8fkoVKGUkbdi8izp7rNoR5Se5AWHYRu3D66fVx1mOgqIW5MleEnX6r5GLuLDTUHQoLXBRGoiLLbX0iC28/rvGX5atoTtlsT7znGoBY3r35798RG2C9fZ8kW2nhK0NbN/v9z5fiZ83b0DBKwtIzpSMYHLqJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BSImQFk3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso4069705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758091797; x=1758696597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVMvvCgA6ljcoCpqlgL1xSnREs4/fST5OPFbRQTwtdA=;
        b=BSImQFk3kWE04UJ4wNGxhZgIgqBFu8H7evpNITOiR+XEr52bK5A3XTajF0BKcnE0/a
         vrnlDgnmTBtG067MZ5524Is6T+wqQA1+F7WbSboe+v6lXEb4fdrMcITV98ED0bTbL8gj
         ibqAXPWjuL/OMe6r7miOwjsmzLOYITjbfBVhljtQCUDx6FhcCFB7KF++1+7bA99NkBLC
         HqwHYLmiSQpKC23w0WfzZtRHaUtq2VSjmtFKLxbH9c3vRv5mKOikfycELPCxOY2x9wBW
         NBozMBU0//nbx8k69bHcnv6YfKMe5rRRajxdj09408x8Xthzyy2YVWQYVQs157zBsNUb
         e/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758091797; x=1758696597;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVMvvCgA6ljcoCpqlgL1xSnREs4/fST5OPFbRQTwtdA=;
        b=fqK3KV5lWTkK/QStsDfGOICfKhdPPXtwrdUvepcVCa4Nn1PpwgbBVIUqyBsq1NkOkJ
         NU4NNESvAt6Uo/XF9KXC+OHOF4xA2JiCv02FpHv0LgYxn/4xVVQj0DhjaN6/gj1MtFZX
         xIxKSt2MOoUNGKgAMZxxwXwcUCDrNh8MTnnrPmbjbWwSTzNmwTfnGfN/BmlQTyyZKckq
         nQhwtqTAcrIzVxLJCCwpadZo9tT6XqF+VozIqpflQGZv1XOiqrlTCOPzS+9z/IXynPZf
         MJq/Ds1oeVx6E+6Co6NVdPbgwxzfJWObhWREJq3d9JjBRHKG05z2ItIQ2FIqjzrMNy8W
         FY1A==
X-Forwarded-Encrypted: i=1; AJvYcCXjurHZqTyIOrfsPhbkmtwdq7WX5pdmnK8ZEA5KRuGR7umHlevr6kH9fQqQkUpu2Ks5Lq58D8eWjUMOR/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJ9pazR4yk8RGzPz8/ld/AUJ0hJmJPIwWynvpTaIPrbCQanrM
	e2MUfW79oEe0EpSpaFuF5wnXrEj7ZbSu00PoJl+0afJPLlRhMTvD9mwfBmVVyTEdkwk=
X-Gm-Gg: ASbGncup79sNBHJ3v0GvCO9PBn1Z07dksAsSabmG7653LvwnnEWJ5lzBDyfMEwaKMkg
	Tdpipf8pIrZyev/OH/y5Mo+eM+UlxIElBenJQ+y2HTwhNCGDRHl81mnLHuLYh8z3l8P1EArEu6P
	1vJQAaECC34tHqiAd3rzbDFyuxAoO3/5A0rrzMzNK3nAQz1Ff4VDHzBg2nOhLLZTtC0d/Rx8C7y
	BGRog4n/V/00efcTVFNKG+sElLIPayBkibbaQQiiAqPN+CUQ6+V5apODx5uU7hVOJW0n59tyHaZ
	eaxhqyLwpcCDRsEzUOSPTApYGmzdUDQOC6W9tkUz4UJ81TLqz3SEzPFpXPwkZi5gX45Gpn3T+lu
	2EBDrW8OWk1xmaLdvx3x7SXaM+O5hD+Y=
X-Google-Smtp-Source: AGHT+IEVFBb8u1kVGqedyodsw2F2aUQecKI0dQqbLqdRcPRySNRrawE71TWdhxxTWe9V1uTknu0h/Q==
X-Received: by 2002:a05:600c:1d25:b0:45d:dc6c:9e30 with SMTP id 5b1f17b1804b1-461f94ae963mr9866535e9.14.1758091797412;
        Tue, 16 Sep 2025 23:49:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-462d525fdb2sm983345e9.13.2025.09.16.23.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 23:49:56 -0700 (PDT)
Message-ID: <d2c1d736-689b-452d-8031-2cf76288dca1@tuxon.dev>
Date: Wed, 17 Sep 2025 09:49:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/32] clk: at91: clk-master: use clk_parent_data
To: Ryan Wanner <ryan.wanner@microchip.com>, mturquette@baylibre.com,
 sboyd@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <4b404eaaab4062464a4142e95aaa76d5cba866f0.1752176711.git.Ryan.Wanner@microchip.com>
 <95e19f49-d0df-4d3f-bd7d-8b58b60f1f7a@tuxon.dev>
 <61cfc570-6632-4e14-9e2b-2bd5d2ce1690@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <61cfc570-6632-4e14-9e2b-2bd5d2ce1690@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 20:35, Ryan Wanner wrote:
>>>       td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
>>> -     md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
>>> +     md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, md_slck_name));
>> Please use:
>>
>> i = of_property_match_string(np, "clock-names", "md_slck");
>> if (i < 0)
>>     return;
>>
>> md_slck_name = of_clk_get_parent_name(np, i);
>>
>> Same sama7d65, sama7g5.
> For these SoCs the clk_hw struct is still needed since it is used later
> in the driver and not changed until a subsquent patch later in this
> series. Would it be better to hold this change untill then?

OK for me!

Thank you,
Claudiu

