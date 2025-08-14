Return-Path: <linux-kernel+bounces-768783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7CB2656C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18781BC03F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F742FE054;
	Thu, 14 Aug 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="lCFuXntZ"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FB1E868
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174658; cv=none; b=cHw2JX/Utr8meS9V/r4KaKJt0pgxiXeeHHho/+eiDtSUPcmr7jazmXlISowOp4/I6/25rutTxGf7ljYsgsOeLHF0bWNN4T1FI2FI1kMT8+xGubB4uPmltiuLMEFfkeuIAfDxK1Tgux+vcpdiEhODyMJUSpGORrfuOFuIIOXuYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174658; c=relaxed/simple;
	bh=ehYxh88qbynkJXrnR7yfu3EhZJI6SZZ9KH93azTco3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZKlLsrB/y2yTktLSKmfagY/0Nr+vRzec0Ca6TOfJeAAbECznsrzqkzbHh/BPiNUVT/wyUwrEzpIzYNs2KvCbJYKPhDayvv2moZsxQKHuYR8m5LnUHaJ7QOxPehOIrBsTu5FKuN+qoWGE1+phIizkgNmIjRUrLXmWl7ah4pY3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=lCFuXntZ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381e0a227so640622a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755174655; x=1755779455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ywvq4778+XMT9D9uuqrnqBrIL1jeEJwzcsXhXKprWOg=;
        b=lCFuXntZ24gff8ibR4J05GPO/qhl9PwWRUcg/yQX0PC7Py0mCS7IVpTUyqIL/Kc3Qd
         6EUJmyiIHvUv74m+J9DuhrWDrQOPIypKbX5Gq5iXEuuPueu+QfuYuaYf0cNA3ilYJxHG
         yhx5H00rNzjIg+GGBl/vVOMl/pxqQg177HF3IRXElXuxwvAmc35uhJRmHuU0WdRUlLXH
         qClhev5rX1TOfc4DnODEIXixz7auGrYqKp9HEeoJdgX4pXot8C1X1NTV/SdR9LIEkIar
         p/qhCI7k8odMBj8teZmnbvtNoYBKsds43oB8yKynMwhSbPUVC7Yf3AeMrHmZY6k9j/Dd
         pOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174655; x=1755779455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywvq4778+XMT9D9uuqrnqBrIL1jeEJwzcsXhXKprWOg=;
        b=GKOu0j0iOZOLwbN+Wqh5bBozHX2IQz718xkGHzf6CZ0VWKahdMfnFJ9eSsY7XV5S5N
         CjMwYx62gtRn5UlGvKqyXspTxUkDXQapA2kRR2cYsN4hD0PHjN89DqyyVLdVD0gR87B/
         Y/axzZlJPR6hYLUnFCxA0jFPNg3ONhAVy4KVKvv6b4YOfR4grkHmQojF0W5Vrd/kRfGr
         Uh9WIk7kwA0fss01yHF4qtur06Hdmx2ADCVDXnP6tjdRnbjLb3wweAdhNy7ZuOLdErLJ
         eHNeIXmIT0vko99TmWYlmYlR0LlQWSky2wcK4KUhQGd0SEu9rdpT3x68EC3btvPGNqxP
         Bktg==
X-Forwarded-Encrypted: i=1; AJvYcCUhN06YZ92dyG+6mLTpheEarOtHdTE/+I+u8YrBknZBdRurT9OAXtxQQMFT2fJZ+f0lfJd9QEp0voIZHzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+kzhaWasCDJbgAKTVDaZalVn9c7tFKW1qJgXacfu6LXF+0Bu
	ggJK91IpEJwjpdLxuSOK/KInpEOuW/wfDnZYIheHNQYUdJ2NDAw0NiwqWRR0l8kh6Wg=
X-Gm-Gg: ASbGnctGE1RGGVUnzOKQ9uRkWSF+W3mRvTqunXT+42qtwMKPGAuQE7QFGxv1CUGBnIt
	Y8rAtUfWXydNBTgdN/3lWAx7XbwmL4NsjufDcyZlJZXYsrz2grcQMQ7ryf/IsebKO4Ti1ql5ZFE
	E2bSGc4FcOPX8SPK2Y2Vh3+/HNEtfX73VFNQzMjwdxq7u5CAabpc8Jn2EhL+j8axfImYfp5RvO1
	d1OEIZpYoVRH0XkRjVAX7XZXWYwucCMO6lLrN2YD8kcDEdyFJZ0BG5xyII0Rbdm+GqU0uRAQa4H
	K5ZQ+2fttc1N0LKXIv8GjJB618VwGhPV+J2a/TTeydE4yTaNH0qEWPKvZWXqY5G7P5tuO6s46jo
	sB15YPRoOW6qjeyu5u5GSrgP9m2LFn3uvWl2ipPZOIakzBJ5WUNhwJNXeSg1fdA==
X-Google-Smtp-Source: AGHT+IHBzdCRrljPnkfDW8jmr3rpPTUxAN1tCDdoZAzws2zd3haB25jvZwxqllCVG7gPmDZID86wtg==
X-Received: by 2002:a05:6830:3497:b0:727:3439:5bdf with SMTP id 46e09a7af769-74382bc3f86mr1632907a34.13.1755174655075;
        Thu, 14 Aug 2025 05:30:55 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae997ea9fsm4538196173.17.2025.08.14.05.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:30:54 -0700 (PDT)
Message-ID: <8f7bac84-623b-47dc-bc58-dc0013a85877@riscstar.com>
Date: Thu, 14 Aug 2025 07:30:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo
 PHY
To: Yao Zi <ziyao@disroot.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, bhelgaas@google.com, vkoul@kernel.org, kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 tglx@linutronix.de, johan+linaro@kernel.org, thippeswamy.havalige@amd.com,
 namcao@linutronix.de, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
 inochiama@gmail.com, quic_schintav@quicinc.com, fan.ni@samsung.com,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-2-elder@riscstar.com> <aJ1PJBax-Pj983OZ@pie>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aJ1PJBax-Pj983OZ@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 9:52 PM, Yao Zi wrote:
> On Wed, Aug 13, 2025 at 01:46:55PM -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe/USB 3.0 combo PHY found in
>> the SpacemiT K1 SoC.  This is one of three PCIe PHYs, and is unusual
>> in that only the combo PHY can perform a calibration step needed to
>> determine settings used by the other two PCIe PHYs.
>>
>> Calibration must be done with the combo PHY in PCIe mode, and to allow
>> this to occur independent of the eventual use for the PHY (PCIe or USB)
>> some PCIe-related properties must be supplied: clocks; resets; and a
>> syscon phandle.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/phy/spacemit,k1-combo-phy.yaml   | 110 ++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
>> new file mode 100644
>> index 0000000000000..ed78083a53231
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> 
> ...
> 
>> +  spacemit,syscon-pmu:
>> +    description:
>> +      PHandle that refers to the APMU system controller, whose
>> +      regmap is used in setting the mode
>> +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> Clock controllers and ethernet controllers all use spacemit,apmu to
> refer the APMU system controller. Do you think it's better to keep them
> aligned?

I do think it's better to keep them aligned.

And I appreciate your noticing this.  I don't see anything
that's accepted upstream that defines properties like this,
but I now see this:
  
https://lore.kernel.org/lkml/20250812-net-k1-emac-v5-2-dd17c4905f49@iscas.ac.cn/

I did a quick scan for what others do when a property's
value is a phandle, and other than just "syscon" it seems
that word is omitted.

So unless someone else suggests otherwise, I'll use
"spacemit,apmu" for this property in my next version.

> ...
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>> +    combo_phy: phy@c0b10000 {
> 
> This label is unnecessary.

OK.  I used it when testing USB but we can add the label
back when that driver gets reviewed.

>> +        compatible = "spacemit,k1-combo-phy";
>> +        reg = <0xc0b10000 0x1000>;
>> +        clocks = <&syscon_apmu CLK_PCIE0_DBI>,
>> +                 <&syscon_apmu CLK_PCIE0_MASTER>,
>> +                 <&syscon_apmu CLK_PCIE0_SLAVE>;
>> +        clock-names = "dbi",
>> +                      "mstr",
>> +                      "slv";
>> +        resets = <&syscon_apmu RESET_PCIE0_DBI>,
>> +                 <&syscon_apmu RESET_PCIE0_MASTER>,
>> +                 <&syscon_apmu RESET_PCIE0_SLAVE>,
>> +                 <&syscon_apmu RESET_PCIE0_GLOBAL>;
>> +        reset-names = "dbi",
>> +                      "mstr",
>> +                      "slv",
>> +                      "global";
>> +        spacemit,syscon-pmu = <&syscon_apmu>;
>> +        #phy-cells = <1>;
>> +        status = "disabled";
>> +    };
> 
> Best regards,
> Yao Zi

Thanks a lot.

					-Alex


