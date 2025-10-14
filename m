Return-Path: <linux-kernel+bounces-851768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8CABD734D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF6D94F6E90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCB307AC0;
	Tue, 14 Oct 2025 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSTnzDX2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2D2FA0C6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413461; cv=none; b=cKlcPy87Af7bwN0DEG2iPhvOAAB1IYusXFHrJa6z79pcN2eT7xtVxcbIGiDoAPmNTfsti5/AiMyzCy7sG5R8K17WE9i8J2s7PKl8dgqpXmPRmVFcsvCDvzH0mgNNQEJIQa7vWi3F2MzGX4kQ9qYovXzXtWz128DLC5b61wL98jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413461; c=relaxed/simple;
	bh=Fwec6/SHuc96O/nv9ssTcB+DX40oe2mcdRirc2K8BAw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VS/VD4P2lpbzWYmGX/Q7jzCuWHNCBFv+7miwpEO1L6R2CQlR9uWHXb3DSxxRy8s3VHgjDnRWWWrl6xNI39aKJPps9WFYA50zfGtzstBqDGUin4ozC+6ST4Gii9TSSBSgF/asjVRoiYUIvUGVqX9TR2febnKal871lE2GWYlzKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSTnzDX2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d3540a43fso45682085ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760413459; x=1761018259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=h2hE9dVU4dDBKSr5RQ6ulWC8RhSPxx36Nra/5fv0QXM=;
        b=DSTnzDX238foXZHJ7mzHDk4iLSn1giVV4wt4wA2YTHnj4XXnSOhKSQ/kdvg0V4RB1U
         akh07um1ECfXyOR9qTqLM6K68IAC3vs6RKVIOSq+9v6vH9Z0ObUa7/cH2m9QLCjNb7p9
         p3eJES1bcrWd56GGxquTulXGH0jevgh1hYWMqL9rKQ+hOUV7yK4fJ1VR4arhFymb3FwX
         ak/VWohArF2reYt8U8sOE5ftUAHCwWSWrewT7LPktHSZHw1KrZvICzi73+qPHpnlyOTV
         eKssUeepEvuz4o3CyAv5BjSGkjLs4fAIxeya0//FbiFV44S5HMZpzxds9sucqVW4sG0k
         S5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413459; x=1761018259;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2hE9dVU4dDBKSr5RQ6ulWC8RhSPxx36Nra/5fv0QXM=;
        b=sXsGrlm7xEwp4VoQy1u3NX8BU5QECRGZz+86ubJUHNr3cGo883R4Bwf3maBa+gsYKQ
         rq/GibbzQlV6eqOghFeykoh3hFVk3X8BKGvn9izRmQJJpNNPSkImUf9+GB+BFf5h19Bx
         rAEXw0Yo+VYtxKqSiofsUJKOE4bBZsWgqLde9lFf12TK9fwUDSHQvB3hbxDNm8wCo0oc
         pt7IKVtAbAKTaM1qrSofC5eRTD064HBj/hfcMoIT1OydnpoR2UeZSoki2x+B5B6tiaW6
         mjuFmFxyvDhbSbI0IAK5qFkYjulvswuGZdMdHj1p1wGfZGz+ysib6kymisdZP4lYQOvz
         ZJjw==
X-Forwarded-Encrypted: i=1; AJvYcCW4hgE7zzjEpMhjwufcUshlRXidfe8QAu5RSEz/8f/wA+EOd59E9ghl43ouDkc3jy9xwB6iYuioJCqpMs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmAf4eJDaTrhiOLGKFVfO3nfGxGKAONs2zLBOj1X5P/icYyO6
	fff30V3o7mzFKU/W3uhi0WhT6/Ryu3+aYJe/TpKydUfBozYXljYcTVCY
X-Gm-Gg: ASbGncuJLKoEG7Cd4WG/QSNs8w3IUBSAnW7g5Q0DunmEOQLygZSgQMgE0CJQCNZ1FFr
	qNVbTqdsBI4Md5Ia8lKbIaSlW2fITqnBrY0BPqZGQRFTHspp09jWQ3Le8BqQ/rSZFYdh4HgOGsH
	tZHGKCSMuROCgXd0Arky9nys5RYS9NbX/C0a27xlaKsScfLgiyJ0pMguW+bjpfpDVpHM1IwBeSe
	Y/nyr2WLHeTpk3yxS+DXmImz7mc1gUJNUqHignwIB4mB4zRCOxrt0Tbf5BVsaKpOhObc7teJXze
	vU5iUKzvOR9x1BvQJ5QspNHFyh8HhaVAFVgPOcbP/9W1zmraAzsH0X/Z/jdqRJsnWtR+JtklPKv
	ypxGN8NkQjnlZGlQZRKaD715O5+aB9th3JK75+0VQkM9icWlt+YwENhviw1Dq+uTP0Y+7ki2Vvd
	ou8Io9h+Xx9iYqRQ==
X-Google-Smtp-Source: AGHT+IEZhWXWpwus8ChUcDCamrlYbdhxVRgqmS7EMLMZ6ANGP8vAcpE08Mz2FQZlW0+Zvn5ycGBKFg==
X-Received: by 2002:a17:903:19e8:b0:28e:ccd7:dd61 with SMTP id d9443c01a7336-29027305380mr282716995ad.57.1760413458712;
        Mon, 13 Oct 2025 20:44:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f961c5sm148224085ad.129.2025.10.13.20.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 20:44:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>
Date: Mon, 13 Oct 2025 20:44:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
From: Guenter Roeck <linux@roeck-us.net>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Tao Ren <taoren@meta.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net> <aO2kLyxGlGt12sKD@fedora>
 <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 20:20, Guenter Roeck wrote:
> On 10/13/25 18:15, Tao Ren wrote:
>> Hi Guenter,
>>
>> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
>>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>>
>>>> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
>>>> duplicated code.
>>>>
>>>> Fuji-data64 and Fuji are identical except the BMC flash layout.
>>>>
>>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> With this patch in the mainline kernel, the Ethernet interface I use for
>>> testing does not come online when loading fuji-bmc in qemu.
>>>
>>> Reverting this patch fixes the problem.
>>>
>>> Looking into this patch,
>>>
>>>> -
>>>> -#include <dt-bindings/leds/common.h>
>>>> -#include "ast2600-facebook-netbmc-common.dtsi"
>>>> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>>> ...
>>>> -&mac3 {
>>>> -    status = "okay";
>>>> -    phy-mode = "rgmii";
>>>> -    phy-handle = <&ethphy3>;
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&pinctrl_rgmii4_default>;
>>>> -};
>>>
>>> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
>>> interface is now disabled. Adding it back in fixes the problem.
>>> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
>>>
>>> Was the interface disabled on purpose ?
>>>
>>> Thanks,
>>> Guenter
>>
>> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
>> feedback, because the rgmii setting is incorrect.
>>
>> I was planning to add mac3 back as soon as rgmii support is properly
>> handled in aspeed mac driver, but kindly let me know if you have other
>> suggestions.
>>
> 
> All I can say is that it worked just fine with the qemu emulation,
> and that it is broken now. Since it was broken on purpose I guess I'll
> have to find a workaround or stop testing network interfaces with
> that emulation entirely.
> 

Ah, I see that mac3 was the only enabled Ethernet interface on that system,
so you effectively disabled networking on it.

I don't claim to understand the logic (how can anyone continue to use this bmc
without network interface ?) but I guess it is what it is. I'll stop testing it.

Guenter


