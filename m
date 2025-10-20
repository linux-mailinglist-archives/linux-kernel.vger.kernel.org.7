Return-Path: <linux-kernel+bounces-861235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FBBF221C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427AF402685
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4526B77B;
	Mon, 20 Oct 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="uB7XyDpl"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09C224B09;
	Mon, 20 Oct 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974507; cv=none; b=TKaazup4Qc9jFuE7MmL5rUEk7pQgUgI4i/ITNyyDK472q60ctOY3QDKsKt5ceh/TUCcxAnsnSNF6TYnBvVC1LBbJ/4zYnJUeLSatNddmSZ11megJuzwvG8wrWNnQUsAQldUp55ooi8osqVPOwD2Wcyf5oT4HHXhwbMD87PyPfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974507; c=relaxed/simple;
	bh=gDlhSaVSkDj8yzoau+14ole4av+6Pn/w1EHSSWO+UUM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=C2Ptx8Gm1UI4KxD97LTfae1d+4MKaJyEJZVFHLECJd5J9iQZMCDzOuvl6IqG2RGzwLRd7g0U2mtzmhnZJ5GbUuBuskxH/KaBkyrrSPLRr0XMtZtkYUj/oNguqZ5r8nxjJB8fZ+wDvjWoosweamtXaLBS/EeGed77dxOVt0FFszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=uB7XyDpl; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id DA2288289231;
	Mon, 20 Oct 2025 10:35:03 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4-otD47ZzKNL; Mon, 20 Oct 2025 10:35:03 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1CCD0828923B;
	Mon, 20 Oct 2025 10:35:03 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 1CCD0828923B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760974503; bh=C5GrYTcKNHQBG0i3HG36jm3JgGWfmfbhQQHHPm7yVjw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=uB7XyDplSv1lm5LS78PA1XOJhKaM7dyPZFMg1+cVe/Bs90wMWm4I+3Gie8WNf1bvE
	 gkTIC84UDersRy+QruFuvbvXxi5MdCbRli8dDv8olftzJ3pMktULnloevgU1QE9nVs
	 t3Zr+13nWiuINEr/cwPaw0exyscRzcuy5tRK2BI4=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6f5EdfwTuUK3; Mon, 20 Oct 2025 10:35:02 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E09248289231;
	Mon, 20 Oct 2025 10:35:02 -0500 (CDT)
Date: Mon, 20 Oct 2025 10:34:59 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: robh <robh@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <924260297.1801829.1760974499327.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250929141113.GA3987541-robh@kernel.org>
References: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com> <20250929141113.GA3987541-robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: dt-bindings: mfd: Add sony,cronos-cpld
Thread-Index: 7dsbt6pMz36EGRoJ8W27OGXqUYJwWw==



----- Original Message -----
> From: "robh" <robh@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "devicetree" <devicetree@vger.kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Conor Dooley"
> <conor+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Lee Jones" <lee@kernel.org>, "Georgy
> Yakovlev" <Georgy.Yakovlev@sony.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Monday, September 29, 2025 9:11:13 AM
> Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld

> On Thu, Sep 25, 2025 at 01:17:33PM -0500, Timothy Pearson wrote:
>> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
>> controller that provides both a watchdog timer and an LED controller for
>> the Sony Interactive Entertainment Cronos x86 server platform. As both
>> functions are provided by the same CPLD, a multi-function device is
>> exposed as the parent of both functions.
>> 
>> Add a DT binding for this device.
>> 
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
>> ---
>>  .../bindings/mfd/sony,cronos-cpld.yaml        | 121 ++++++++++++++++++
>>  1 file changed, 121 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>> b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>> new file mode 100644
>> index 000000000000..3cebf6c0153d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>> @@ -0,0 +1,121 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2025 Raptor Engineering, LLC
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/sony,cronos-cpld.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sony Cronos Platform Controller CPLD multi-function device
>> +
>> +maintainers:
>> +  - Georgy Yakovlev <Georgy.Yakovlev@sony.com>
>> +
>> +description: |
> 
> Don't need '|' if no formatting or paragraphs to preserve.
> 
>> +  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
>> +  controller that provides both a watchdog timer and an LED controller for the
>> +  Sony Interactive Entertainment Cronos x86 server platform. As both functions
>> +  are provided by the same CPLD, a multi-function device is exposed as the
>> +  parent of both functions.
>> +
>> +properties:
>> +  compatible:
>> +    const: sony,cronos-cpld
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  leds:
>> +    type: object
>> +    additionalProperties: false
>> +    description: |
>> +      The Cronos LED controller is a subfunction of the Cronos platform
>> +      controller, which is a multi-function device.
>> +
>> +      Each led is represented as a child node of sony,cronos-led. Fifteen RGB
>> +      LEDs are supported by the platform.
>> +
>> +    properties:
>> +      compatible:
>> +        const: sony,cronos-led
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^multi-led@[0-15]$":
>> +        type: object
>> +        $ref: leds-class-multicolor.yaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          reg:
>> +            description:
>> +              LED channel number (0..15)
>> +            minimum: 0
>> +            maximum: 15
>> +
>> +        required:
>> +          - reg
>> +
>> +    required:
>> +      - compatible
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +
>> +  watchdog:
>> +    type: object
>> +    description: Cronos Platform Watchdog Timer
>> +
>> +    allOf:
>> +      - $ref: watchdog.yaml#
>> +
>> +    properties:
>> +      compatible:
>> +        const: sony,cronos-watchdog
> 
> There's no need for a child node here. 'timeout-sec' can just go in the
> parent node.

Could you elaborate on this please?  As far as I can tell we ref watchdog.yaml and need some kind of compatible string, so why would I break out timeout-sec directly here?

Thanks!

