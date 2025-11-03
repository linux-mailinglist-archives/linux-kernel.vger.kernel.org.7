Return-Path: <linux-kernel+bounces-883195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA0C2CBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF94189B156
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BCA285C9D;
	Mon,  3 Nov 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoOaIcgF"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAED283FCF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182825; cv=none; b=MjVxrgum5cVyFYTOkhsvPO23VYLsR7G3CRX2wGSU6JdiYHuCHHim0A8MQFKn3wcoDIJROZ/T1RJJYJ7zmAnJdMl7GnEJcitzq5ciXYh2JI4M9aJRTjy1WteqOoZKFw/KIEm9pnHlEKWZhpmeEOIajjY0JOfSghleHWRXI1R5wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182825; c=relaxed/simple;
	bh=9aDL8ck7h9deJ07cUcAbZEP6B4MJ2gHjFl0COyr0PN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYa7WOlNAYPvc9yvPgc1wV9q78y77hGETLDvWHwvsC4D4oe+KzapgHlooO1MAAbvbj6jVvOkq8VUSrOXp6oETa4/pIutFzqb5XmE8Ri+ROwoGU6K5NevWy835PRJPAUyQ/1xzyjrNg6mxQuTZc/fpsYXIztMuaiKM8mhsehLnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoOaIcgF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640e40d4596so564a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182822; x=1762787622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BSbBY3csEbeaESsg48nSrruERwNIZZa9MwOr4m8wMzs=;
        b=BoOaIcgFYZTZqfdig3d5gqdUFrdIrXaWmXqBU1+bb/taga6vArvoPV9rNmyex5tPnR
         GM9ho/Cf49RvRrW+r2SQ97G573CR6XXbETykPZkuuHORlStJQUgMgUCgyQRen23zZQtj
         zOoZ06FAand1z11BBKjl3U2jrQbXnIWQTE0LF7XD2fOZFDwYZqlKrEpZC4/QfYUSQ4yo
         Oc71PM4VNHrX525SGQT9K69LlYiAXFBca9NJZfBdmtSlLHMNrTpcXElf2W+PJXFpF12j
         1V8A/6r0adU2EvsnjS3vnqzaMUIW6sk4qxf6JOy/Ocic5uWm7DQSwao7aLhWWU53JyQj
         KVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182822; x=1762787622;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSbBY3csEbeaESsg48nSrruERwNIZZa9MwOr4m8wMzs=;
        b=j/vhbuEdB+wpDbhZUcBMUE5ZYksza4VJaD/BQk2f3nEBycinm+7ojKm3kX8Gvujkkx
         ssN7eYotLeyYQlXcT2YC+Doq8ou89rAWnv7Cw9Om0mmlXifv8x5Og7w46j6ml37MLH7Q
         0gvXiirBURBODXieuq/Nx2u1bJCH8ziL6VV6WzMKoB0tf+ZX+JC1JtjLsUuYOrxr5Y0g
         wVbvcN+fOt2gr8Qs0siolSIDgxaC6EO3fMKbw2IHVQbUyx9h/BocHPLSwDEdmXqtY8+Y
         pFWttFXlYUFbQdFzA9JfJZLODpc6D9kHcF0qkj0zkxH8BQNfuC/zpUCXxSFKo/SNWcXU
         syHA==
X-Forwarded-Encrypted: i=1; AJvYcCU64Xl3IbXCzsSyS9DswuUfas8kprKoGnIJk3tc+HZDP37OhRyMnFxLUjUMQo3NknbnFVb/Nl9R/m5Rcfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLGuD4ie5kUEXgCjgKitI6PaV6XMPVTYrrqBDLUo/MyHB4qk0
	9W8YLip/gYEqYdV0I7kG39zWLcJDwRqwu4cKqFVF9hE//y4i+wp5Rium856ApaaukOVK6CLNnhX
	Os6s6
X-Gm-Gg: ASbGnctgSyBDD9y2m4N6NpQqcXOsAnUEkfa+yzcEuY/gOc8nAQj89wmU3KU5YR3avIp
	hywkJdid/sAXidoEjyjpgzspvaLewIzbKg3CT8yooWorKmUIlURpfDlXM60s/+dU3QMKEULHvHj
	lj8tcAvIG9azKT3phLqC9nROmggMZccP7PbuS7/VhNNtlQxamPoMif5+OeTm/sRBeSwgX8F6c1x
	DpPS17s2xpsNFhWj+uCrwx2Eufoi0yH0GPqLq+PxJC540KfjY3OqzGiRsu1AGH4PTCpB3AE/STo
	UUET3TA7Mi0JMcEiGKOBN5Lg3gSdSn9r7bz1v5BF+fcFjiJQJDr4Z8UokhJctMXm7f1sE57lccH
	JUaTEjuoYEMrcEt2rHP66W4MfxkaI2JFInskDRgQ1WQQDoiaR+qIYlUJArkvwUHn5njyYpIHoT9
	XfUEzrjnLz52HvXSc9moZorH0w66KSfD4=
X-Google-Smtp-Source: AGHT+IFQc4aoVO6YskV9dwjweWNbLL2iBORa+Firl6QVZZ/oT3IxI3n7Nw8yZC5OECtJGdRv3s0GHw==
X-Received: by 2002:a17:907:3d0c:b0:b3f:331a:a98c with SMTP id a640c23a62f3a-b70701934ffmr726864866b.4.1762182821566;
        Mon, 03 Nov 2025 07:13:41 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70abbb6106sm559502866b.67.2025.11.03.07.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:13:40 -0800 (PST)
Message-ID: <8997b8d6-7d1d-48f3-8103-561612f3867b@linaro.org>
Date: Mon, 3 Nov 2025 16:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] reset: always bail out on missing RESET_GPIO
 driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 linux-renesas-soc@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <20251015205919.12678-5-wsa+renesas@sang-engineering.com>
 <35f619a73a83207b83de095967014b03b7d3e8f0.camel@pengutronix.de>
 <9ba9f4b1-5bdf-4242-aba9-8035571caa1c@linaro.org> <aQjGUnu40hdhSKR9@shikoro>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aQjGUnu40hdhSKR9@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2025 16:12, Wolfram Sang wrote:
> 
>>> [1/2] reset: always bail out on missing RESET_GPIO driver
>>>       https://git.pengutronix.de/cgit/pza/linux/commit/?id=25d4d4604d01
>>
>>
>> Why? This wasn't tested and wasn't reviewed... there were objections to
>> this patchset and long discussion.
> 
> Only to patch 2? AFAIR there was no discussion regarding patch 1.
> 

This patch alone is broken. Breaks all users. The true problem for your
systems is of course your I2C driver commit 690de2902dca...

Best regards,
Krzysztof

