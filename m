Return-Path: <linux-kernel+bounces-851751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BBBD72DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26E34F284C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616D26FD84;
	Tue, 14 Oct 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTqyaH5E"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E07494
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412007; cv=none; b=qGEuvd70Llf6hrx9CkWZQRo0jrDNR1iF7Ou/IM5j0uUiD6HlpHhdJT1F9F2EWAUd+h2iKyJlz9dKawQwN1tXzMaVx72pJwa+dKhrCBhjkigic4+C6pyFBB8m3TUIEDGL3RIXfPGHzDI/UVFt4QZZOcYdlj7djywrH7uUIC0olQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412007; c=relaxed/simple;
	bh=/ty4BVXoSOVX/xO+WWmy054bi2UbiMiYvJERs451HxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lr8cj5e5KNiAUriwhnqK0sid6NGIr+tnD/G6voZMHDYPCugJ+RseZ7Zn2zKzwOtbdMl3D9mawPu1JcYJnT6kOjsbIDRaU9IU0KWBu3zmWwlam1Tqc9STtvnRpifRkX5Hztd2Di21IYGbfq2F+1TwLAsYQetIxdXH1Tjo1lcVazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTqyaH5E; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-789fb76b466so4339742b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760412005; x=1761016805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l6UJfRMC7vI8XJ/lVMtg2P/k+rG1cg8dROQofj14ZQo=;
        b=QTqyaH5EDWmnwVAYN297J/1IVaYV0OY+F7KDwazEd+O1kuGun+SdCnV9jnkpxDpXMX
         kRCaBN0DmzPAGxhZ+tsipSdyuUNbUoijuPAPNDKUvzTOpvhrY12GC8NoemqywRn/g0Fz
         hwCeyPsQnAAN8a27rQgdFZP+U060ci0+Jbmnr7dxQsNBQ5Nt3g6Wl3glky0XViAUrB+b
         2d75Afwkg0vDRdXc/ayKcDrukmT3PfvNnQfXJq2MFbTi7WkYlLeif9gntW7Mp7cdbBTA
         LWgoHhinLNw54IznSOgnCCqUVHoXl6PCygwXwRQ0VJVawx/Rh+X9Dlxa0rZUw/dQ0Buw
         6xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760412005; x=1761016805;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6UJfRMC7vI8XJ/lVMtg2P/k+rG1cg8dROQofj14ZQo=;
        b=IDPvSunuiG1UJ8J4C/q747ea4SrEtBD1BIoI9ffDLRBq67MIZVOm/FXT9kiE5fwiH1
         g4FoTA5u3o1Myy5XkzKo0Z5e4afhaPJH4HXlje/8emYd6HdPmS7hYEC7YACYtfx46hQ2
         DFaHwKZ758VgTUeZ94YkFCi0+AEJvCKlqcJFy4DjTbEfQNL3GnhKVKdQvEY3XrB12526
         IMyZPJR/99yvIX1KFAkZ4KPPM+fQ0+8E1DWTIE0KE6X3/6N78ur3eIbN/OOhKZcDXTqH
         L2aFYTwaZe3ZnfrmQlRG5IMnbWNyI9Vv69I0cZS4/ovoWmBUbN7N8RsS3/1pVEgDlCb4
         a/DA==
X-Forwarded-Encrypted: i=1; AJvYcCV6sgIAJQ1FeIYhJ5WRcC2XdW+bvaMPB0JWvz1vji14GRMdY6gNPr+/KzN4oQRLbSLvGksYsIJcUDXdzpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzliX81uHY1ZiyM3+JCpqXk8GOb4sk7gOQ06sNsbXumED4TJOxA
	ioBuWyGgXS0fsYIpagwq3iJ6c58deV3Pjzt6JCA741LOGRQolDV4elRE
X-Gm-Gg: ASbGnctQ8DUbSNXmRS96C0C7Ehr7K5vDtdeOtYZ5vpPIUzx6uHYXk0g2FhbpfYGFG/L
	3a5xZ8wTdGVoA/43xTribWZ1Jq/y5YdGiSgBoFmzaeRBbaKqa7BV6Jnb2JfF9c7+ssuBAN56bMC
	jE5Nr8uDT0TEesrVY1wW7Tjao657/CnGVJp+rn3p5eG8fDZgl5l/11/+2/OJleWHLJ3E75AMMuN
	cymKnJxIQqGELvFYCW6cbiNSafAV5tdn85xJmOSal6gxwu1W8q7OL4GMGM3BlYclkYRhtNy5UE2
	rlKCR62VN+SAKnYV8yfDJsQvk/V2jyUYpjuU/ghaT5jPcRfIXkkwVE3dA+6kEl71F/0VBRjXas9
	8lMbQUmz49dAp/BGmXr0kzGtbD3lEN5mzCEqOAQMKNjbgff69WWeCHXUtNNtFr2MOGw3IJ9wFtL
	2ybga+SHxR8hMGmML/IKkoSZ2k
X-Google-Smtp-Source: AGHT+IE2bL3FW7iscYvEusgSbZQ3EznMhjFPvP3ZLjEF/s4fklES93VBIW8vBAnhYEqbAtzcszCZqQ==
X-Received: by 2002:a05:6a00:b84:b0:781:1481:897d with SMTP id d2e1a72fcca58-7938763169cmr30189229b3a.17.1760412004876;
        Mon, 13 Oct 2025 20:20:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b73334asm13266281b3a.21.2025.10.13.20.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 20:20:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
Date: Mon, 13 Oct 2025 20:20:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aO2kLyxGlGt12sKD@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 18:15, Tao Ren wrote:
> Hi Guenter,
> 
> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
>>> duplicated code.
>>>
>>> Fuji-data64 and Fuji are identical except the BMC flash layout.
>>>
>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>
>> With this patch in the mainline kernel, the Ethernet interface I use for
>> testing does not come online when loading fuji-bmc in qemu.
>>
>> Reverting this patch fixes the problem.
>>
>> Looking into this patch,
>>
>>> -
>>> -#include <dt-bindings/leds/common.h>
>>> -#include "ast2600-facebook-netbmc-common.dtsi"
>>> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>>>   
>> ...
>>> -&mac3 {
>>> -	status = "okay";
>>> -	phy-mode = "rgmii";
>>> -	phy-handle = <&ethphy3>;
>>> -	pinctrl-names = "default";
>>> -	pinctrl-0 = <&pinctrl_rgmii4_default>;
>>> -};
>>
>> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
>> interface is now disabled. Adding it back in fixes the problem.
>> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
>>
>> Was the interface disabled on purpose ?
>>
>> Thanks,
>> Guenter
> 
> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> feedback, because the rgmii setting is incorrect.
> 
> I was planning to add mac3 back as soon as rgmii support is properly
> handled in aspeed mac driver, but kindly let me know if you have other
> suggestions.
> 

All I can say is that it worked just fine with the qemu emulation,
and that it is broken now. Since it was broken on purpose I guess I'll
have to find a workaround or stop testing network interfaces with
that emulation entirely.

Guenter


