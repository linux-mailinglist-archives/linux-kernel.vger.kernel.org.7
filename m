Return-Path: <linux-kernel+bounces-823550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B663CB86D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA212A0457
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2A2C031B;
	Thu, 18 Sep 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="J4XoiAgw"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561B15442C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225744; cv=none; b=YHzDQ5FjnB3BuPPY6/iQcAtc9yVAC/wtZkWzjAajolMRC1QydaLBx+4FXlGz+3asgUyS+4csRKINLwoN+5NamgbUq1OmBQrnG3GVDciLfV5eabDH9xvsV+4XB7lxYRnMqaOiAV/YC4kiUMqXgcHSjcNpMCUi4SkxcJfltUZAccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225744; c=relaxed/simple;
	bh=xTNSF63U6F8F9m5v5OzYH8+/3s+qw3mzFt4E/qP4T/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJbDm1mbCcUhmlCWrmDloNaTMQzaXzEsn7iN234XG4iW9BwncwPweCs2YAIINRO2WVGfpwbiq9AtDa1RwR/vUl0+xsmeC/ZmlvMKraStBhDRCUe562UhWfD9f0Ks8kdVorzKN+EOpldAyAGHN6pjWSp/RiK05A3j+cHqa4mkmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=J4XoiAgw; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88762f20125so126657239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758225741; x=1758830541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6x/DmZz/Njy3XkRZzK24IecqRgfFtgXHR4AlKqnaji4=;
        b=J4XoiAgw1jfDCSWqIYb9cCg0+PnX3v+uR2Pu/qL40T5yk1jPLz2zbY9BIPHr+rm1/H
         PUedG4xSNBh96f0NEFDsjS8cNfinoDlArwvWjxeqANVPR9thEKW3UlSBIFC8gqazkYZy
         v0yVXfzSPF3Hi1CVKbSJsTwTXgshImmNbG1qeomoOIMIwcCHz93ltcaLskG5WcsW4J3Z
         YQJSr9tyD1dzuI8ZKLFAsMsI17VxOHcJEse3izAO/k7NN3Ko6uINPpcurfzWEo622Nna
         Tf62uF1CVwpH0jpX2midGXlBZ9tVSLEg05oA5MyxLVRC6+LVo9LRRUy7bg3d/ddkWkat
         JWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225741; x=1758830541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6x/DmZz/Njy3XkRZzK24IecqRgfFtgXHR4AlKqnaji4=;
        b=KXsZf91ECUHFBng9FnSI1DEKUgT8oAAaGrDxGT2MSd5oo6WefmyJcrI1ifDKKVu5u7
         RpfCbjWoyKpGa3rMGSZQn9QtusTmFCX3puQrhdZDJ8scFlrEzV+hho9B9wzuSjy0RzVs
         lmz4qS5pS3hupt5kh6Hj8S8dReNwJ9J/VqnAx7SFC01SVs7+75WgNBwWwqQPfju9rv3R
         gviJtOvvKK4ZlgmAgLtScbm4Z9Gl2N1LLaUkqDvKLsbfya0TZV8S0G0shjdUeGLCfGj5
         +Hn2YdiQUL5ijs7ED1NHDlfNw8nkWjO2gFbReFpPEOOKJP3KpR3tsANT9jY7hae38AZQ
         QPGw==
X-Forwarded-Encrypted: i=1; AJvYcCXbP/GwHczZ73SF0IKM5030Jw040sJNQlkqdt+aS/OWj19GQX4sZatkmIfnJt8iZvVxnqJ7H8oy49irBDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBH0CulrITjvmm44dDI7BRhXmo++UAhWDzDh9GvxVoF7nr8Td
	sEmApq/CjQIRV1trAZzPpVqfDMWjxIBNTv3q32YVCLnwiahAbkG1XhtRd97rqsQb5MU=
X-Gm-Gg: ASbGnctaWMylQoyGIKqHQvcaHUeDhlVP5Sh0E8YdWh4bazBBcCCXD+05gaaM+cRxkh3
	ZFWsMuin1u/3nljvY7oumhqQg/4bbJ83bS6ptcpMSCOvcWboLMW25WwKSmmrGkDA07/kOvKKtAv
	stHvRdPAUXwQnmyKE3eXVz0VcE0m876hmjAfidQwaqCoaLB9yWOI0Y/Fr31KXDW8oWyQJ5AtuDT
	/SQJp+hn/ZBJWpuAQCLs0e6PnXwLm4ARC5gsGS+/s1Blj3GYlQApVyYlgAlC3vr7WNgObOh4R8C
	+Ja5jiKakgVD0CrTTIgCC7Yu3VaE+xp8KYoMjG8mEmR7wl4NVz7TLawVilCraSeOty5jjSv9KUt
	ht6sbOZgrc1m8Jz1q5iofvG1txQelu2tlYr5klfqFleKq5IJgH89ig9Ngw3amXQrrPPlEFfZhHM
	C+bJ5/
X-Google-Smtp-Source: AGHT+IH5Ia06wxmm99cv33bY0baM2MmODAlEl3RzPF2cL4hY1LNf+MZF/EoTF1/TFOE6KV6P7E2YRw==
X-Received: by 2002:a05:6602:1693:b0:887:2a8c:9226 with SMTP id ca18e2360f4ac-8ade617c22bmr125297339f.16.1758225740767;
        Thu, 18 Sep 2025 13:02:20 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3405sm111352939f.1.2025.09.18.13.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 13:02:19 -0700 (PDT)
Message-ID: <88623738-4279-45f3-bcbc-7a69f5c3d0d0@riscstar.com>
Date: Thu, 18 Sep 2025 15:02:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
To: Rob Herring <robh@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, broonie@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
 <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
 <20250918195716.GA2521514-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918195716.GA2521514-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 2:57 PM, Rob Herring wrote:
> On Wed, Sep 17, 2025 at 06:40:31PM -0500, Alex Elder wrote:
>> On 9/17/25 6:15 PM, Yixun Lan wrote:
>>> Hi Alex,
>>>
>>> On 17:07 Wed 17 Sep     , Alex Elder wrote:
>>>> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
>>>>
>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>> ---
>>>>    .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
>>>>    1 file changed, 94 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>>> new file mode 100644
>>>> index 0000000000000..5abd4fe268da9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>>> @@ -0,0 +1,94 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
>>>> +
>>>> +maintainers:
>>>> +  - Alex Elder <elder@kernel.org>
>>>> +
>>>> +description:
>>>> +  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
>>>> +  FIFOs, for transmit and receive.  Details are currently available in
>>>> +  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
>>>> +  K1 Documentation[1].  The controller transfers words using PIO.  DMA
>>>> +  transfers are supported as well, if both TX and RX DMA channels are
>>>> +  specified,
>>>> +
>>>> +  [1] https://developer.spacemit.com/documentation
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - spacemit,k1-spi
>>> one enum is effectively equal to const..
>>
>> OK.  That's an easy fix.
>>
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: Core clock
>>>> +      - description: Bus clock
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: core
>>>> +      - const: bus
>>>> +
>>>> +  resets:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  dmas:
>>>> +    items:
>>>> +      - description: RX DMA channel
>>>> +      - description: TX DMA channel
>>>> +
>>>> +  dma-names:
>>>> +    items:
>>>> +      - const: rx
>>>> +      - const: tx
>>>> +
>>>> +  spacemit,k1-ssp-id:
>>>> +    description: SPI controller number
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> could you explain a little bit why this vendor specific property should
>>> be introduced? I took a look at the code, and didn't get the reason
>>> behind.. or what's the problem of simply using "pdev->id"?
>>
>> This property was carried over from the vendor code.  It is
>> optional, and if it isn't specified, the platform device ID (-1)
>> will be used.  It's just intended to provide a well-defined ID
>> for a particular SPI controller.
>>
>>> we should really be careful to introduce vendor specific property..
>>
>> If there were a standard way of doing this I'd love to use it.
> 
> The standard way is we don't define made up device indices in DT. Well,
> except /aliases allows you to do that.

Yes, Yixun already pointed out using the aliases node to
accomplish this.

I'm still not clear why or when something like this is needed
though.  I presume it's so we can say "SPI 3 is always the one
that's exposed on the GPIO block" or something.

					-Alex



> 
> Rob


