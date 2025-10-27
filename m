Return-Path: <linux-kernel+bounces-871796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225AC0E66C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410064273C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA70430ACF7;
	Mon, 27 Oct 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcQXI3Tf"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E93054C4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574325; cv=none; b=KOfesbCIYrUq9BrUURGDKXniYFKA6g5R2CVPQj9nwMGthkWATgNY6fcQ5o88j9mudYBOczciEBmMUlIg8kQtTJ75pocSd8JJH1ago6jkENsgJPjYtoKzFwegCgw5vD2r23iT5oPRSwaSygUlghLXT92/75tIFQBG1Bz4EJrfGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574325; c=relaxed/simple;
	bh=s5fi0aix74dhXeUfiX707igJJq83gWDg5mUZws693ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyEiTCLmWaEUOrh+dasNHYVNP1cU9wbe8XE6vX2fwfI+Sfo4QfeALObxYUykuXCGVTaQzV2/H7HcmkV8q+lXT/6bP1lr+J8Vka3uZRm77E62Jhq5CeaeBlUU8Vm2H+CwSC3xHyZXEJDvJtlCq6cpHVBXuFC6l6MbczN8K9L2m9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcQXI3Tf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so4691651a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574323; x=1762179123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bIMvual/DCfbHFKLhMc6KNvRa8c9RJirQTWe6ek/vw=;
        b=CcQXI3Tfgt7ipYZ+0nPYI9mFjQl1CH1rbS7bGXPmFt5GFvQLR+oj7SSHdSJoDIo+we
         cTccAfFNZpEOvRJYloD4+2WHfssBJawdXio/5IdWpaRGmodqn12bOjfOoKiPoIjcno/J
         Rx2sl/Je5YVZoSySe1ZwAlDm3UiCV3r9lqbAYv6Dit5E8Gf8CZcch/GiMYf6pFv7ihsH
         XJZWbtXHSOXtE4XBmtIG+ZSOGziEVFQg7pfcImntTQPd2fH2FSrKYyGuZ10oJcxtWOtJ
         F4glpfx5ps155vyZ9VV3c3uHcl+MMGn9JfM12JQCQM2CctcMuUwj5LmV3rX4rgLAFMPW
         qcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574323; x=1762179123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bIMvual/DCfbHFKLhMc6KNvRa8c9RJirQTWe6ek/vw=;
        b=D2kfpG38uE4Oe7yQwrZ14MqSqNSRdfgs0JG1VAy0mF6l/pYCJsLQEBAIRONvkPgLQX
         RujU4QrZZu+vQLZGtZ+U2NQat4h9ypzmqfT69R2y8mkN6s6e+nn2xVV2WP8ES3yMqEwm
         u4BbUFNj7uxkwxqjFCB2XiJQxQfPfDvMASb8Dn9kM30qi9i8a715JHCQ7lpMeIVZ+Kn4
         qFgIttvMOI3sdqtFf2sMMEYS6S/T8rtadaBLHIeXfDbNTu6DLchNBh76t7EYfK3O/PA+
         7bxNdKCKcKc0Gu3P8pvvW66FetCbRYtEhZ6hGd9SYvxUWQxJU6XsUYpoDzmdF1D7USTV
         5PgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVsA26m29662R1W20NePbNqMCBph6TyXtooOy6wK/MYxq96lobMKyx8wuCodLLECoyv2BSWBW6VOjHWuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dtUG/OcHgdHSrVvVuWhZA8kYC2OIJRjTqiKIetx110HPwO5m
	0tWI/OEjHoJhstWKGC+ENyOUH2FQrM+nv+usw8K4fPexY3vTW2nV7KYf
X-Gm-Gg: ASbGnctMfvbjq8EzMAP8Kxbu5CuINe7X2Q0h9bDVRfzEzpQgZKIMVtbhtUuwQTsU1Y7
	pBr0HVkn8HVLcQVbMnHu00OvyK8YuU/uCcgMrty5u3u0azEa/qIrI13+pbYFZz/vy8PiCpAH1yu
	j4xQ+an1/hNbo6XnTjs4YvX0cqQLNp05ww+I6KjCyaFp7FjsgXKQIBT0EZYgM0KYTNhH8ErvxNy
	OXgFjVzyaiCd0N/kx+9CropeOOGKuxnt1y1MTXxOVYUrfAGqX2hXoxuOPXERcG1WAcsfAYX57zU
	sRbQO85O4sW9DAo1+LqBn+Aicjot0VPBQZ8ulhBhdVxHhhSMk31Zv186d89wnz4bFfg5aFGYdPX
	Z5VAlc21y2s/NyMfkrErq0Kh+m55+bMlVG/rlJjhgqx0fbSYwvtkD3KW3d5nTjHEdF0Xqku/76C
	0Vg4yisypKCVIJNnT/KhYar7ISMcwVUr0k
X-Google-Smtp-Source: AGHT+IH5yXGx+LupzIOPczjiiLlR5YgFAp1+QvWwv8ZLoofxPfnSc2zQ+LY35y3vpNkMMUH1Hauifg==
X-Received: by 2002:a17:90b:1dc3:b0:338:2c90:1540 with SMTP id 98e67ed59e1d1-33fd66b4230mr14770603a91.20.1761574321988;
        Mon, 27 Oct 2025 07:12:01 -0700 (PDT)
Received: from [192.168.1.5] ([27.7.191.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f604dsm8788404a91.15.2025.10.27.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:12:01 -0700 (PDT)
Message-ID: <b6486799-9e46-4b6b-bf95-001e11e958e4@gmail.com>
Date: Mon, 27 Oct 2025 19:41:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com>
 <20251027135752.GA316916-robh@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20251027135752.GA316916-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27-10-2025 19:27, Rob Herring wrote:
> On Thu, Oct 23, 2025 at 05:37:36PM +0000, Charan Pedumuru wrote:
>> Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
>> Add a new property "voltage-ranges" to resolve dt_check errors.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 ---------
>>  .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 78 ++++++++++++++++++++++
>>  2 files changed, 78 insertions(+), 30 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>> deleted file mode 100644
>> index 627ee89c125b..000000000000
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -* SOCIONEXT Milbeaut SDHCI controller
>> -
>> -This file documents differences between the core properties in mmc.txt
>> -and the properties used by the sdhci_milbeaut driver.
>> -
>> -Required properties:
>> -- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
>> -- clocks: Must contain an entry for each entry in clock-names. It is a
>> -  list of phandles and clock-specifier pairs.
>> -  See ../clocks/clock-bindings.txt for details.
>> -- clock-names: Should contain the following two entries:
>> -	"iface" - clock used for sdhci interface
>> -	"core"  - core clock for sdhci controller
>> -
>> -Optional properties:
>> -- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
>> -  requires the CMD_DAT_DELAY control to be enabled.
>> -
>> -Example:
>> -	sdhci3: mmc@1b010000 {
>> -		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
>> -		reg = <0x1b010000 0x10000>;
>> -		interrupts = <0 265 0x4>;
>> -		voltage-ranges = <3300 3300>;
>> -		bus-width = <4>;
>> -		clocks = <&clk 7>, <&ahb_clk>;
>> -		clock-names = "core", "iface";
>> -		cap-sdio-irq;
>> -		fujitsu,cmd-dat-delay-select;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
>> new file mode 100644
>> index 000000000000..6b67bef30347
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SOCIONEXT Milbeaut SDHCI controller
>> +
>> +maintainers:
>> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
>> +  - Takao Orito <orito.takao@socionext.com>
>> +
>> +description:
>> +  The SOCIONEXT Milbeaut SDHCI controller is a specialized SD Host
>> +  Controller found in some of Socionext's Milbeaut image processing SoCs.
>> +  It features a dedicated "bridge controller." This bridge controller
>> +  implements special functions like reset control, clock management for
>> +  various SDR modes (SDR12, SDR25, SDR50) and physical pin property settings.
>> +
>> +allOf:
>> +  - $ref: sdhci-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: socionext,milbeaut-m10v-sdhci-3.0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: iface
>> +
>> +  fujitsu,cmd-dat-delay-select:
>> +    description:
>> +      Its presence indicates that the controller requires a specific command
>> +      and data line delay selection mechanism for proper operation, particularly
>> +      when dealing with high-speed SD/eMMC modes.
>> +    type: boolean
>> +
>> +  voltage-ranges:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> 
> Sounds more like a uint32-array.

Okay, I will change that.

> 
>> +    description:
>> +      Two cells are required, first cell specifies minimum slot voltage (mV),
>> +      second cell specifies maximum slot voltage (mV).
>> +    maxItems: 1
> 
> You can better describe it like this:
> 
> items:
>   - description: minimum slot voltage (mV)
>   - description: maximum slot voltage (mV)

Sure.

-- 
Best Regards,
Charan.


