Return-Path: <linux-kernel+bounces-882698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA4C2B248
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7256B3495A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0152FFF90;
	Mon,  3 Nov 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db1WiWvp"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448442FF165
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167058; cv=none; b=Rl0xXNFTxO0fNUP1ETIM/bD08TWLeB63QREMrR6sTfVDj4oen6AiX5waOQWu68H9wW0oUhvhcPCX61fj4y9ikjy1ldA6zYxkqvXj7GhrankNqKlL2hRH+qj4uvRH7bptACEZHjbDOQx4R8TsbSWN+XAa0Z97ULcBAO13hNm4E5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167058; c=relaxed/simple;
	bh=K/DZtMl6bTbXSyX1kAX6cDkUuBNHfLB6DitBcsu4woE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfAnQrCnNRw0ALzfpD2M8xBxHJ4rcXa5p3KFsdLUj1wyudg3VLMTmJUkeEe+Off/pFQKEAEW1eZb/cBHk2QMD2ponIgniW6MnmbqZMNbUoSBqRM7mXq4N1mUkOmyLZQybr0iA7lXv0lDzqwq5Rtv4pv4fzqT5xLX4+BOqu2RXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Db1WiWvp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so1997583a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762167054; x=1762771854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aAPWr6sG6plHcRAb74AERMut+3PIj3xR4C7ijLuCgY=;
        b=Db1WiWvpl+hkZBbwI9ag7Df6MHc9U8E5LwVFjmJ/JhNqOQd7gRgMfQjvZoqDMRUDbV
         NzHLozZgrQKBoHYjxkjELN0DT9U2YrEXGgIEEnydTXFXxdSBO2SIraTh/QTrkfVfuhT9
         kMZKgqtQyrKCG4R8oDFNNq+00wpTJpT3vAP52eldtqBcxCTQqUT3Eez6TK0T4GaD3KN0
         9CviyO2M9SLHS+XqOeqK6HL9Bgm26fLu9nNr4e3TLLbxBM4QOkx1qAqp0eib9J193P8K
         Lb1/RCTjXk+M6My2QctUV9i1PeG/5lUu3+azOW0vxz+RAp8e8zpPoYBVESf/ayoRrYMp
         BMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167054; x=1762771854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aAPWr6sG6plHcRAb74AERMut+3PIj3xR4C7ijLuCgY=;
        b=uhcs5W5qI7dubiMC4T3pSqBc+BG2AtvtJVv1ZqNehF6N5rZ/cZrv/xt/93j4qa2NjP
         MtFEn7BsfpYFKdm58cYvqID6D2VjA0+TOJZ+3OJr5xW02MC23BOEZdbbIDWVIXKOizqV
         j2iG/LU8Go0n1kMq8xx8NVqMdBOzhGb+jKbQjhVuo59yHCSPyJVR6gMsVdltHKxfhzBo
         eZ4da3veEnciqYwn4hl13+10BJD3qknZDYE1KfFyPKK9ZMzw5KcDWr5wviqvwq+SUELw
         X/MXOMGA/2MKsl+G3HYRzUC5Pf0alyTosdZu/PYBU+FgXlXrCiB0T3lAf1G3S1qDRYgx
         iJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlcmscs0r9xABsdFsjS13LrFno+D6milTUClW/RevVQOE9O/6X6tQq1aCbvHTQLt9CwU7fzmpX8f3BqUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYynG8OWcGJuHHsxD8QNyKBd044tDzewZOW6uiSToq3ekMZU6J
	8bAZjaVE6K0b5LncP49kbvjy7bGB+lQJoyhroIIymUuyStOI4rlw47Yim5kiaPaFO60=
X-Gm-Gg: ASbGncvEVUJE6eZZ/mgucjbV0a9KPCm2KYuj6iQRqOKE5WcMk4kH7GOts1xvtWbuha+
	Klz33gacIecMm1vMdDW06QxjvYj07P2E0FUM4JFmHiG8Lm8dNZILFddwnnzCXohKaQmbEMSzASg
	y2zDwfQuB7skLYaHR3vnhv5U9/X7KMV4Thh+VSvifoMWpSiAd/mo99JgaiKER8eWRzAjLQXKmK+
	J66tPiBET4VwEEIdaWIgkbhcdJk6rO6OS5RKWtPc7kB5i/Q4V0h8NmT4APAXN4Ff0OYrqQlittr
	uRJ6apR5bz33omJpI16bEud4EYxj8Yf61jR9B28daY2S/f3xUTEr9LCgUgLcoKagf3tptZ+y7Nu
	z3Ba0M4sMcg2wYIAJrnPWbT5hWCVPRE71FE6u1VGt3Fu7IbnKlAuhJ48qVJgRl567yQXrqJSBZm
	BzlybEMCzZOJBw
X-Google-Smtp-Source: AGHT+IGAsmHIJSxBw8Ivjg8wV5c1LPLNuyYfSnhOFaJTNn0jDUJaTnBR+1poGrO0LFeXhX5G5jmT/Q==
X-Received: by 2002:a17:907:e98b:b0:b6d:8d8d:3010 with SMTP id a640c23a62f3a-b7070840e1bmr1281242166b.56.1762167053554;
        Mon, 03 Nov 2025 02:50:53 -0800 (PST)
Received: from [172.20.10.10] ([213.233.110.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b374067esm411112266b.64.2025.11.03.02.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:50:52 -0800 (PST)
Message-ID: <b82af744-ebbd-4dc8-8ccb-c7e4f2a6b04d@linaro.org>
Date: Mon, 3 Nov 2025 12:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] arm64: dts: exynos: gs101: add the chipid node
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
 <20251031-gs101-chipid-v1-10-d78d1076b210@linaro.org>
 <20251103-pompous-lean-jerboa-c7b8ee@kuoka>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251103-pompous-lean-jerboa-c7b8ee@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 12:18 PM, Krzysztof Kozlowski wrote:
> On Fri, Oct 31, 2025 at 12:56:09PM +0000, Tudor Ambarus wrote:
>> Add the chipid node.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> index d06d1d05f36408137a8acd98e43d48ea7d4f4292..11622da2d46ff257b447a3dfdc98abdf29a45b9a 100644
>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> @@ -467,6 +467,12 @@ opp-2802000000 {
>>  		};
>>  	};
>>  
>> +	chipid {
>> +		compatible = "google,gs101-chipid";
> 
> That's not a real device, sorry.
> 
> I had some doubts when reading the bindings, then more when reading
> driver - like chipid probe() was basically empty, no single device
> access, except calling other kernel subsystem - and now here no single
> actual hardware resource, except reference to other node.
> 
> Are you REALLY REALLY sure you have in your datasheet such device as
> chipid?
> 
> It is damn basic question, which you should start with.

Documentation says that  GS101 "includes a CHIPID block for the software
that sends and receives APB interface signals to and from the bus system.
The first address of the SFR region (0x1000_0000) contains the product ID."

0x1000_0000 is the base address of the OTP controller (OTP_CON_TOP).

"CHIPID block" tells it's a device, no? But now I think it was just an
unfortunate datasheet description. Do you have an advice on how I shall
treat this next please? Maybe register to the soc interface directly from
the OTP controller driver?

Thanks!
ta

