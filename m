Return-Path: <linux-kernel+bounces-842089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D10BB8ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB40019C07EE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C8521FF41;
	Sat,  4 Oct 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIDYkr7L"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BA215767
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588150; cv=none; b=SWBha5D+xerr3SmqmadMc/ZqdjWYEgp2L+iz5YkfxpjY1u4jZhDQNQHfAFhYx+4r6P62ul03XvOSVp2nSJ+sastaECJ4rPfGtN+0k5fQ48ejQ1Ite0PY1+eWUuAX6LVOALHX/3lObstbH3nU9qS1Xw0GFaqkts22NAWIGJ/imCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588150; c=relaxed/simple;
	bh=DMeykmPN5Hn52oroDMprGiqhW3PY40d3FDFFHM4U6So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZgFp8xa9tOeCugqFFNJlymW2J9TL2f8AYKUaibtoy30qLmIXdPu6s9yOpPcEJEXcdQzTZGX9jZcxqG1FEi2DBcH3AY7Barpax3jfjUjlTYT3bPJ/RVdzClt3YONO98pL4Gz5yE/MW1y/cfbFxIEufvVsyxpQ7HNqKYvMSufnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIDYkr7L; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781997d195aso2286365b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759588148; x=1760192948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dJLJddt6znxw/vx9IIBy8Llpdg1rWPPK3LlhQpupMwY=;
        b=jIDYkr7LG+/ENVFlYvvsjumnqBZ//djnoW29SFjg/DbatgT0KnkyIJOpY0hVHuZCw/
         CRCuXwmcpLEjJaC4jR3pydZAjnfp69c8VOqWBXvVXW4+puQnYgIwU5WSVJlgJbSLZcFz
         ei2/xMmGN4xt25DKm144YFLxDMEdMX1QjvyDjgkIinkOHBVzJ1lwSdDLIvFaUySfURj5
         6AlKLcPPQnWiF5R8MrxQjuOrcArHperrWAJnnJszjMqv1qmsF1xQ7j0cH1cmam5A9TPK
         UmCpuRPCSJNyhhntLCFEOhMK1OAqiAUnGWEFWF2kcz6uXlHMFuqo6ddR/7F7NgqWD0pI
         OVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588148; x=1760192948;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJLJddt6znxw/vx9IIBy8Llpdg1rWPPK3LlhQpupMwY=;
        b=Jy4EqQnkxk2XND8qeb3Q3ARJiPQpaNPowjEnqabUjh4UWqgq1TG/W649TIRmkKT7H2
         4xDqslGXQLKQg0+0jVNTo2pcY3DiH3FEqUAq+Ga/xdL9++A2bAyIbSDbwieEsa60R7y6
         iDqMUhu34OUJVuXW3Z1+u1U1nfLWUUFR9EQHfgNnGyWQWDspHvebjU/VhbfE1Z7JbDxD
         YUbYndYJ0HolakL3GC2Ea5u3gqhrCQD/iTdIGpl7JF8p81ooiGMFbVRIs/n1FiwbpxKg
         nxh/sVIM44k2qXJUZGoQsp2Gpiy8YGpqBk0Y5M8n8QBh6I/pIEMFjM30aTfKn5n8aUEv
         v6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHRjNsqHPyk2piacD/ARhpTX6U6yz1sgJNYGHo7jhBl/mF6ZBNLL2nCrcnoni2HKmdex6Xiy9GeppEI2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8iZaDmjAi+73UPs23Ne0A2INY94DcAGSu1JIT4jGmSHUHJIA
	B8ytCLtFMv4O120lMyaCJmKtoYJ1f1Ds/2eR8Mv/Q6ahaSh/AOOZOF/v
X-Gm-Gg: ASbGncsGQwSeILSn9TZgbXDXiDH+OwltfOGRiWupttbhlvuvt319MIB0f4LUaPTF+eG
	++a3kcrpG4BAvVsx5GLQpiniQ7D06w6yaYUdF4qmWSORz462ZbZADd0YVyVfSoUymihMYBQlblf
	2DMIQLDmzx5vkzuBSPvbWpDC5TWC4cyvK7ghb0ftF+8e3FXQxnvrIGYNSqo1yOf9wJW+dyCduVS
	SPvuM3xzB2EEzFL+VyrsKEwuG+yuRmE7oitTK+AQs5B37HJgP2/IH08zhK9yk4ccDhcQLT9bXC4
	olo5VTEXNcvGR+COoifYfQbgwG7bjCMhNmXbTDXYlKoeyJxeCyG3KFpPGlDlmcqbVEhb0LyU8jZ
	MSs8+bLj5F4niE8hT77Y7VPBopYvP9cawTFzduvfUkBWkclqNUQmyNkiHAyy5/uZbDY6ypqyrX6
	tBekz1d9ss1PzRNqIiyiM=
X-Google-Smtp-Source: AGHT+IGrnta0K2AVOdKuQUrDuH3DDW9htsxyGfKGvsM7d3Z1hpoBhD1zMahhNW3M63rAxzw3T6obEQ==
X-Received: by 2002:a05:6a20:a128:b0:262:1611:6528 with SMTP id adf61e73a8af0-32b6209c4b6mr9839268637.29.1759588148024;
        Sat, 04 Oct 2025 07:29:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm7410427a12.37.2025.10.04.07.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 07:29:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <44a1a1c4-813d-4540-a73e-b136032e79a2@roeck-us.net>
Date: Sat, 4 Oct 2025 07:29:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] add support for MCP998X
To: Jonathan Cameron <jic23@kernel.org>, victor.duicu@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marius.cristea@microchip.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>
References: <20250930133131.13797-1-victor.duicu@microchip.com>
 <20251004151138.77886486@jic23-huawei>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251004151138.77886486@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/25 07:11, Jonathan Cameron wrote:
> On Tue, 30 Sep 2025 16:31:29 +0300
> <victor.duicu@microchip.com> wrote:
> 
>> From: Victor Duicu <victor.duicu@microchip.com>
>>
>> Add support for Microchip MCP998X/33 and MCP998XD/33D Multichannel
>> Automotive Temperature Monitor Family.
>>
>> The chips in the family have different numbers of external channels,
>> ranging from 1 (MCP9982) to 4 channels (MCP9985). Reading diodes in
>> anti-parallel connection is supported by MCP9984/85/33 and
>> MCP9984D/85D/33D. Dedicated hardware shutdown circuitry is present
>> only in MCP998XD and MCP9933D.
>>
>> This driver was submitted in the IIO subsystem because the chips could use
>> interrupts to handle threshold events.
> 
> This reasoning isn't particularly strong as hwmon has support for events etc.
> This device is also 'slow' so I'm not immediately seeing a strong reason why
> IIO is the right choice.
> 

Correct. hwmon supports both events and udev events.

> After some recent feedback from Guenter I'm keen to get a clearer set
> of reasoning when I take a temperature monitoring chip into IIO.
> 
> Also asking that we +CC Guenter for his input on devices where the decision
> isn't clear cut.

IMO this _is_ (or should be) clear cut: This is a hardware monitoring device.
It should be a hardware monitoring driver. FWIW, writing one should be
straightforward (including interrupt/event support).

Guenter


