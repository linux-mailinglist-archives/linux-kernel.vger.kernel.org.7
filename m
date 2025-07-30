Return-Path: <linux-kernel+bounces-750649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D240B15F37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A133AB388
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118F2951CD;
	Wed, 30 Jul 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="SVMEXXGo"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4C25761;
	Wed, 30 Jul 2025 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874482; cv=pass; b=N0XjJpekwUuX61FJbeXGrFkX6b7LiKTMZ1Q0unDDVLAJIg0c4OwbVcev3LGpa7sBNalOgGRyvd9VSPX1xNBPj3GZr3Rk/blazxLsdEYbdenPfWbxzIgacAjyrDv+uDe161FtEazsJltXGj29QzXck/woKi+RAKQYcRttncYmVkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874482; c=relaxed/simple;
	bh=tbCibIy2cmD+3opvuXp1KpJuZJv+jtvN1A9fuYyZZxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjMsX/dahACmEJe+O6tij2h4I7alkllfObzcs6ahbHv3R7FoRt4lUzz8DLgNxj3AYFlVHG1yMpWbk9URYvcSIymToHFjQPjD0N+irn3LNOSSCweiPubwpysLVCQ/FuQgDDl26/flaVvT2P5jjqWqx60hWuKuqotxVMFCXRfAR7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=SVMEXXGo; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1753874463; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E8r8UTppfiLYDUKk0iKnk8G8/FN1FpODiWadA9FBObOHIUyt4+/SAyHoGwfo46HIndDDoFteDSt1WMnutOaImJhOmy+rQexDY3RzHypvTD6CR4BlGxZNGMEIgYrgO2F6rarDQveFgOiDgzhHzMXaWl2D8yADnrykjQeU7q9sx38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753874463; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8Oz8gEKqQKUEqMecwoAV5BMdQ44ozr0nc/GN/7ECVkk=; 
	b=oLz/jflwJpTuDqk1ujOH9BxpbpSMpgfmSH7gOuadElCB9kWs8VIybTG09k0yq+6VJs52fLk0fsVrBU+KEkH5e/2n6higSulN2zYW6lzyGSTrelZtiNiW4994efaEu/9KlrFKMjKaIguaCHe8iuXE7G93+PP0XDDYYb6rvGJRcG4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753874463;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=8Oz8gEKqQKUEqMecwoAV5BMdQ44ozr0nc/GN/7ECVkk=;
	b=SVMEXXGoydW4JlJFuYIzvP8ubzv4KonrfST271YiBRYjVfVmTtVUBq/+vew0kFIs
	whQiqqJAHtHrWijhCPSgNfM4ccbpugxt1vpMG9IXkf8BiNIb2LgN0PxkQ7judxfFcf3
	qfIXHt/kQufJpoDDlvE4Hxt/2/QlizuLHJ/63xi4=
Received: by mx.zohomail.com with SMTPS id 175387445597336.57491374987171;
	Wed, 30 Jul 2025 04:20:55 -0700 (PDT)
Message-ID: <122a51eb-21e1-4cb4-b42b-fcb7e01cf64e@zohomail.com>
Date: Wed, 30 Jul 2025 19:20:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250730-b4-k230-clk-v7-0-c57d3bb593d3@zohomail.com>
 <20250730-b4-k230-clk-v7-1-c57d3bb593d3@zohomail.com>
 <20250730-cobalt-salmon-of-charisma-aea028@kuoka>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <20250730-cobalt-salmon-of-charisma-aea028@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122705379e726ccbd43f37e10cb6000094e63ed90cacde45cdbc9d713d3e27ea8ff19fee53717ce07d:zu080112272a964b8e78150ea41f6bca3600003d8e0fa10c7b72419c2cccc5a40a808f82a51dfb38244fb1a8:rf0801122c10cdd9d1176d37f07bf07f420000feac9293e220c0d9b6cd3327d2d7bf3d02e2af548a215b4f7b53805f1cdd:ZohoMail
X-ZohoMailClient: External


On 2025/7/30 15:05, Krzysztof Kozlowski wrote:
> On Wed, Jul 30, 2025 at 02:43:51AM +0800, Xukai Wang wrote:
>> This patch adds the Device Tree binding for the clock controller
>> on Canaan k230. The binding defines the clocks and the required
>> properties to configure them correctly.
>>
>> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>> ---
>>  .../devicetree/bindings/clock/canaan,k230-clk.yaml |  61 ++++++
>>  include/dt-bindings/clock/canaan,k230-clk.h        | 223 +++++++++++++++++++++
>>  2 files changed, 284 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..f2aa509b12bce1a69679f6d7e2853273233266d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Canaan Kendryte K230 Clock
>> +
>> +maintainers:
>> +  - Xukai Wang <kingxukai@zohomail.com>
>> +
>> +description:
>> +  The Canaan K230 clock controller generates various clocks for SoC
>> +  peripherals. See include/dt-bindings/clock/canaan,k230-clk.h for
>> +  valid clock IDs.
>> +
>> +properties:
>> +  compatible:
>> +    const: canaan,k230-clk
>> +
>> +  reg:
>> +    items:
>> +      - description: PLL control registers
>> +      - description: Sysclk control registers
>> +
>> +  clocks:
>> +    minItems: 1
> No, drop. Hardware is not flexible.
OK.
>
>> +    items:
>> +      - description: Main external reference clock
>> +      - description:
>> +          External clock which used as the pulse input
>> +          for the timer to provide timing signals.
> So what is the difference that you removed my Rb? Only this? I do not
> see any differences (and don't tell me, you claim some random indice
> numbers as change DT maintainer would need to re-review...)
Sorry about that. Since canaan/k230-clk.yaml was updated with new
clocks, I thought it might require a re-review. I didn't mean to cause
unnecessary noise.
>
>> +
>> +  clock-names:
>> +    minItems: 1
> No, drop. Hardware is not flexible.
OK.
>
>> +    items:
>> +      - const: osc24m
>> +      - const: timer-pulse-in
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@91102000 {
>> +        compatible = "canaan,k230-clk";
>> +        reg = <0x91102000 0x40>,
>> +              <0x91100000 0x108>;
>> +        clocks = <&osc24m>;
>> +        clock-names = "osc24m";
> Incomplete. Post complete hardware.
OK.
>
>> +        #clock-cells = <1>;
>> +    };
>> diff --git a/include/dt-bindings/clock/canaan,k230-clk.h b/include/dt-bindings/clock/canaan,k230-clk.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9eee9440a4f14583eac845b649e5685d623132e1
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/canaan,k230-clk.h
>> @@ -0,0 +1,223 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Kendryte Canaan K230 Clock Drivers
>> + *
>> + * Author: Xukai Wang <kingxukai@zohomail.com>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CANAAN_K230_CLOCK_H__
>> +#define __DT_BINDINGS_CANAAN_K230_CLOCK_H__
>> +
>> +/* Kendryte K230 SoC clock identifiers (arbitrary values) */
> Drop comment, redundant and obvious.
OK, I'll drop it.
>
> Best regards,
> Krzysztof
>

