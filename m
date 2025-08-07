Return-Path: <linux-kernel+bounces-759327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6ABB1DC1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E976174D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55582271466;
	Thu,  7 Aug 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SY1Smvq4"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA81F4162
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586061; cv=none; b=d5eEqjduKAHyq/c6FnIj32a45Lds1iwzHbFnK+T3KTILUgLJ1W7KN2wzLZYV9qYec/exijO1rUXPqeETkaujOEqQllEuDp2i1YmkN1ZXhh3SB2loM17lzqhXKDoVi8tYQPtmik+0T7d5WT07TyeKys3I46HBtB1gKuBSzrbtanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586061; c=relaxed/simple;
	bh=L5WxlG8R52B3mkxh38XVgLLiqLg/KA0oY51mwkvB8Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2yubsZShcuXyxtHA+0U9dcuDBpUyGku/DS5wMRXDx9mw9IzaH8WnIdXEanAwQ0PrxgnU6MgS/3zjpRK4MzqXhfRZtMCES16C5dKETSX+iLLkCvj7y56Mc+1gGewWUtCfDzvhodN4BNzqluZfPKnQJs2AipCLwFZNrONx9mLbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SY1Smvq4; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43590aaaed2so293051b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754586059; x=1755190859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2XQEZz8DrQTR1mxU/ualC1FnFYm75rDAYl+kFwmjZuU=;
        b=SY1Smvq4pNrDGn75lqABDflNrZlQ+JRT8wGdEKeaQjrXEBoLGVoDmTEwKrim6p6s+m
         aRIFqOIMCpkuGitkDCbhIbfxN9usoZfQwKKjHWTIwNXn6OfNz1Ok88pjugVgc7mwiwNc
         hcWlSJMc96/uujsDXb6ggfup3jmuWd0y9sL2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586059; x=1755190859;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XQEZz8DrQTR1mxU/ualC1FnFYm75rDAYl+kFwmjZuU=;
        b=LxwMuHeGSfuML7TgxsQIWEFx+VIy8WwmdW94Pig0D4baQV8cS1an0Z403oYKKS0bVz
         Tsrmivj4IuX/bepvaA89hVQR9KEPV5wPb5AAe9mRNI7z2IreBTSCfmRGZ55M5bjbv2pP
         MI0fRf6i2aOdBMebawtqmu4K9MkNgHh1DXjxxkNDqxTTaIY0XNkPJHoyI14uze5mmjMC
         Uk1LLNr7LKPv9QUpxzm3oXgyQyjGbOYHm1OdNIqaXcgYrZyi/vGUZU1EdWnnIjIl2kMo
         NDmCQF9tDqHFXtqDq5a6TFModgv2bh69D+T7QdfKGDwv5RbRZlQCqHRiTEeFIo5k6J4T
         i9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9FaQ4vv5bvL7CMd8XekM4/i4VDRF+MbQHJZfKzqV0WRHHPg2gM+qCbuCrSMvG22ReGYE0QviGQvJE7tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp35rfz9I7CnOkq/GSJX1wdZJb/3Z8aMYfE7ZmPjA8YHhXk1Qk
	b6Yi7fjUfKvuAqMEjA3s7MsDvgvxsssT6UxeMvc//skhOHlhe+Cq/oNhHA88bPFZOjGpBX/FUNT
	lH9adHg==
X-Gm-Gg: ASbGncvvGLpD9Lux9xcb/zNWFWs4wAADab4Z/o7c+U6ZZSECdYTqZdzvrvOUiHrNK34
	ykr+s8AjQwl1E7rhNdc2Ma3DiTcmyX1fwskDuCj4WCcEcH7ILf2oV0nKtHetDXLkZDv2uA5FWoq
	xa36HEMDsDvkFfGdSnV0g+14FKPavWz0ACckcnJdZ+0GNExFjGMnVo15Fpl0RQd+05dsJr1H2t0
	T5DA06IyGEvZYyT7ILp9egHJf3WxZ+GEmgwasMqSj3Qd8VOKgc4ELV5TcTL+l7piUF0OptbWErj
	G5ihMm+nGrQFUwG8U0LTbN4E+FW9ksdEFmLTVNm4MtiBUc44kqPaCYlwIDuoX63nZ7sZAkYbJ+3
	wDadVWfQXQFator+erscHh/CngSphQhTX3y1qfma9BBFvi2BfollvOV7r1YJlvA==
X-Google-Smtp-Source: AGHT+IG1bBL2oQySi+K0k5iOJwT9pr8OKXIeKQOlPuvjdUAnInwVIDuPNbh6rF/ytsTKp8wb3JxMMA==
X-Received: by 2002:ad4:5cc5:0:b0:707:2472:dc3b with SMTP id 6a1803df08f44-7097afbe83emr93427616d6.42.1754586047987;
        Thu, 07 Aug 2025 10:00:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca464acsm102096016d6.36.2025.08.07.10.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:00:47 -0700 (PDT)
Message-ID: <8ff6c436-74bc-43f0-b5a6-3085ded52d02@broadcom.com>
Date: Thu, 7 Aug 2025 10:00:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250806185051.GA10150@bhelgaas>
 <0a518bd3-0a20-4b69-a29f-04b5cd3c3ea8@broadcom.com>
 <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 22:26, Manivannan Sadhasivam wrote:
> On Wed, Aug 06, 2025 at 01:41:35PM GMT, Florian Fainelli wrote:
>> On 8/6/25 11:50, Bjorn Helgaas wrote:
>>>> I'm not sure I understand the "racy" comment.  If the PCIe bridge is
>>>> off, we do not read the PCIe error registers.  In this case, PCIe is
>>>> probably not the cause of the panic.   In the rare case the PCIe
>>>> bridge is off  and it was the PCIe that caused the panic, nothing
>>>> gets reported, and this is where we are without this commit.
>>>> Perhaps this is what you mean by "mostly-works".  But this is the
>>>> best that can be done with SW given our HW.
>>>
>>> Right, my fault.  The error report registers don't look like standard
>>> PCIe things, so I suppose they are on the host side, not the PCIe
>>> side, so they're probably guaranteed to be accessible and non-racy
>>> unless the bridge is in reset.
>>
>> To expand upon that part, the situation that I ran in we had the PCIe link
>> down and therefore clock gated the PCIe root complex hardware to conserve
>> power. Eventually I did hit a voluntary panic, and since all panic notifiers
>> registered are invoked in succession, the one registered for the PCIe RC was
>> invoked as well and accessing clock gated registers would not work and
>> trigger another fault which would be confusing and mingle with the panic I
>> was trying to debug initially. Hence this check, and a clock gated PCIe RC
>> would not be logging any errors anyway.
> 
> May I ask how you are recovering from link down? Can the driver detect link down
> using any platform IRQ?

Just to be clear, what I was describing here is not a link down 
recovery. The point I was trying to convey is that we have multiple 
busses in our system (DRAM, on-chip registers, PCIe) and each one of 
them has its own way of reporting errors, so if we get a form of system 
error/kernel panic we like to interrogate each one of them to figure out 
the cause. In the case I was describing, I was actually tracking down a 
bad DRAM access, but the error reporting came from the on-chip register 
arbiter because prior to that we had been trying to read from the clock 
gated PCIe bridge whether the PCIe bridge was responsible for the bad 
access. This leads you to an incorrect source of the bad access, and so 
that's why we guard the panic handler invocation within the PCIe root 
complex with a check whether the bridge is in reset or not.

If this is still not clear, let me know.
-- 
Florian

