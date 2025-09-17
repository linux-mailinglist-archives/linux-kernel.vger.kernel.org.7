Return-Path: <linux-kernel+bounces-821797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B83B824FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C96327CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB53112B4;
	Wed, 17 Sep 2025 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="fnnTFpM9"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12D265630
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758152436; cv=none; b=AyjqAD7gi9SYMuILw6odQYM7h39F6BjDBh+M2DCriq9nKjEbVZ3iriHdnBWWsztag0W/4DqDx/gk+1dxgF3/HcseXrgdSDHuP7zgra2uWWi0ey7ffhnSr9Wa/lUwI6xIuAkYNPQ31Y8O7IWSpyyIeIoKoIRuJ9SKP6ygYPGkqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758152436; c=relaxed/simple;
	bh=WSUDTo2YPrsMhanXvD2WU2viqGWsoO+MKY+Xv+c2P7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jefW2iXQdsijeni39XZesJw2G7pcSLTeJBzknoBozSeaq2wPIVEIfCaVUfb0Dug6HSj+kvUhwZBXdZtkH6BwM52pZcbUCuIcBcb0rHQfI/GBL2r3EFf2vVgUn/IT6ntroI80wAe1ZEGRF7dC/37FUFLR5m9H25ZBNFMhv5FIMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=fnnTFpM9; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88c3944558bso8713439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758152433; x=1758757233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4LnKnBe0mUrdxdcBF4M/llb4IeQlPfA2whttLuEB5Q=;
        b=fnnTFpM9dbLZRTz6baEM0q99r59tQD9IRcrATU5qxeYy4P/VepArnvQsfq0gjt1/4D
         VuhWE4wm00PqAmNIuqzZxOB1w8NejghD3PjIw5pKPbSqNLdInB+0YDnB+fADVgP4vrBt
         8JOCwHBCYp9xiSxlxw+RWGitND6DfcJCOr+W2WsyA8GW0xfe2bA97HIJd5I6uuNfaACN
         VbuVFlYwq32bXQUcFk0WVqpYMMq+bEPdUOBxA4eSxsM3ZbAAvu+vZ4vZ7bwPu/cLprQC
         i7BYhE74YyHMnSqUMsjeDaj1IfYQIJdD5S/gN1oy36v6WOoraplaSZWe/rFWkO6CoPyZ
         V0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758152433; x=1758757233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4LnKnBe0mUrdxdcBF4M/llb4IeQlPfA2whttLuEB5Q=;
        b=b93GS8d9P3SkvGuTGCiuEC39fc3eE4bMXKrkDQZ3FswK2oitJmhHef6eYSRlHgz6ii
         yXItyxkvvmPEHhJTe906XMeCaAbx0mgvrUazTvXcuRCyR37qlQpLqupIZMN4Ahd//n+9
         yR++WwPA+7+qLprGKBWYYLRK1EAxJ7PVJhHUdirHdM3UXA60blTxJ7h/NfelOdecyU1O
         v2dI2tvW5YIkoyxmUc7F7uxgcJ5R3YcIPYLLcuAsuWtULzSVIykXh4sYby8UFfTCuzms
         89RKl75n5jYJ3YL6NuSGtXED7wi38hylMJCzZCzb2SavAlVla/O8An6q1QG7wgIsxVeE
         FHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF4lrh+D5vrMY1VfV7+lXozqUzpVaDe3XN8EQtAQZmoNbUExbleotVboq92al+Ctu6kJMbJpSC0vjVE1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/Ywer7cW7depC39XSucKVFOP7a8cMKSIiIrwpEr3m9RZ3qjZ
	q2OReOGdnoXMkp0LGfUOvvPVBCeFu7tGmVLpL4StgDoFDJgh8G4BqfNu9lz+wj8MwNw=
X-Gm-Gg: ASbGncsNS5EVRyi3F2O2J1X3BiXFU7uZSKIK4ndsApbIabcgK7X9gQEcey03O4fpMnN
	t7p+CRpqBRf8g9ZUxJfXIYAtiLMV+9LGGmKzvZH6b1pm9yUlzgemHUBqk6nk2ZkBAy6ZZKRq/aJ
	3nlzso+8B9+Agdf/vmuQ4n5NoGXML7V8VOBotmfN4AD2p/naK3qG8NOLMCmitXl7lFE8sMLOpuP
	YvhbryRQpS1MEjZrHZ8obcrE0vqF4cA54hnylQvGrD/poll9LrlZKip9sd4tA0XbGzb40HtdYjo
	JOAGLiZSiURjGYjXi5GC0NJ1r4NbKZZqats6etdW5CS1yvov5tOAqbXX/3pFQdGtPfsouGXnA6C
	H3sOBbsze/Ll7NxLw1xmExvLEJMi/jgYDoXfllQlV1+dcIJv7n0E+4A==
X-Google-Smtp-Source: AGHT+IFIMlPua7p/TY9YMSKjXsZOBX/5j6z1IJQ7nS5dT8sO4hABWq+/kl4R3zdjJi/vT1pYQ+i8NA==
X-Received: by 2002:a05:6602:6c10:b0:86d:9ec7:267e with SMTP id ca18e2360f4ac-89d1a7c97eamr718446339f.4.1758152433403;
        Wed, 17 Sep 2025 16:40:33 -0700 (PDT)
Received: from [10.211.55.5] ([131.212.251.230])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46fea3353sm31238739f.12.2025.09.17.16.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 16:40:32 -0700 (PDT)
Message-ID: <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
Date: Wed, 17 Sep 2025 18:40:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250917231520-GYA1269891@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 6:15 PM, Yixun Lan wrote:
> Hi Alex,
> 
> On 17:07 Wed 17 Sep     , Alex Elder wrote:
>> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>> new file mode 100644
>> index 0000000000000..5abd4fe268da9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
>> +
>> +maintainers:
>> +  - Alex Elder <elder@kernel.org>
>> +
>> +description:
>> +  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
>> +  FIFOs, for transmit and receive.  Details are currently available in
>> +  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
>> +  K1 Documentation[1].  The controller transfers words using PIO.  DMA
>> +  transfers are supported as well, if both TX and RX DMA channels are
>> +  specified,
>> +
>> +  [1] https://developer.spacemit.com/documentation
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - spacemit,k1-spi
> one enum is effectively equal to const..

OK.  That's an easy fix.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Core clock
>> +      - description: Bus clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: bus
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    items:
>> +      - description: RX DMA channel
>> +      - description: TX DMA channel
>> +
>> +  dma-names:
>> +    items:
>> +      - const: rx
>> +      - const: tx
>> +
>> +  spacemit,k1-ssp-id:
>> +    description: SPI controller number
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> could you explain a little bit why this vendor specific property should
> be introduced? I took a look at the code, and didn't get the reason
> behind.. or what's the problem of simply using "pdev->id"?

This property was carried over from the vendor code.  It is
optional, and if it isn't specified, the platform device ID (-1)
will be used.  It's just intended to provide a well-defined ID
for a particular SPI controller.

> we should really be careful to introduce vendor specific property..

If there were a standard way of doing this I'd love to use it.

And if it isn't necessary, please just explain to me why.  I
have no problem removing it.

>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +
>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>> +    spi3: spi@d401c000 {
> label not needed for DT example

OK.

>> +        compatible = "spacemit,k1-spi";
>> +        reg = <0xd401c000 0x30>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clocks = <&syscon_apbc CLK_SSP3>,
>> +                 <&syscon_apbc CLK_SSP3_BUS>;
>> +        clock-names = "core",
>> +                      "bus";
>> +        resets = <&syscon_apbc RESET_SSP3>;
>> +        interrupts-extended = <&plic 55>;
>> +        spacemit,k1-ssp-id = <3>;
>> +        dmas = <&pdma 20>,
>> +               <&pdma 19>;
>> +        dma-names = "rx",
>> +                    "tx";
> ..
>> +        status = "disabled";
> ditto, drop it

OK.  Thanks a lot for your quick review.  I'll wait a bit
(probably until Monday) before I send an update.

					-Alex

>> +    };
>> -- 
>> 2.48.1
>>
> 


