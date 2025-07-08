Return-Path: <linux-kernel+bounces-722368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF6AFD8F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE9C7B170A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63877242D64;
	Tue,  8 Jul 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zTiNDGFk"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858723C519
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008105; cv=none; b=DHqzERvDRBakpyk3DXWnAj6EQTAZjs+an6vSHGxtmYBn8BGoDU9TyKgGobgeHBynhnFJQc/6anxbylANrz3lgTcrov00EtbWUt5W3zyYoMdF52C8D/z11mtnPHskYKoVKUOXOX4xDrBdPVAEaXskGfxt16XNL08NN/qH/699ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008105; c=relaxed/simple;
	bh=kjuzGXug/D4R5GG9GyQa4tvl1oIFOIPy3Hbjs+Knt7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIxFLQi+yq6TEsQQWCSRlx4Ha0ypJ4MGELMYWqmLvcran+sPjQxaQu1YCBY1wAMRiGXQv85Tp0mIw0MojSDKzdq9pCKQH14e/fgfitV3qPbMdlUJdwiv9ATPCffdJbV3HoY6iDdoD97yuGVi7QvcI6nSRQ4FZvZ8mtEdzz+i0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zTiNDGFk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4901559a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752008103; x=1752612903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxJ02DChvr+wqzcbfqYcBr0RaqPB3ADatLZsLUUfYAs=;
        b=zTiNDGFk3NmyURAanRQscpPtOx40uLlEEzpJENOpDqR2cCJQtXzZUYl7VNlVtg47fM
         b1bHFS16IhpCXLI5GiHAfg+UN6hMPbM2CR9m/0KAEmAw/jui5s70a0x2+yEM9Y1iMMCV
         n/JuSyXee8eKqo4ayaOFGbgg2PlbFtsplwDmvc5fBKz9BkaEvFjkC/k/CQ9dcHfgjI2z
         NF3rYmDiHyZkWXBJfk2mohKyKiASR3n2EZXvUpyLLP5ivb9NcoRJUc0KKbF1Pd7dfOW5
         2sJ6koju4tK0GPehyFTWZgNOwBNYNtoP6O1t1c1K1mADN/Ld/V32NxvXiddRNp1ZISQL
         a0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752008103; x=1752612903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxJ02DChvr+wqzcbfqYcBr0RaqPB3ADatLZsLUUfYAs=;
        b=twOo96/DqgXWoajIvAnrgM+uLTrUNzXLn3OWkjxIZgRS0VslhKU4idmBjKEOi7kE5I
         kowSFnimxhWtYNAg77ViH6UyJnmWvy30m3Kl6mM2L+ZsXoBYryotJ0Kyc4SzoAe+1SS6
         V5y3faA1ewVk59bk69171ShQqjzgQxMAof6PId1IRck0zO0An7Euf30U0Gr9kPOPyIHU
         O7HWsqlCKoNkQ84tk2/Xq0a1dAd7uVXAUVseNWbcOTEnkjlhdbUXuw8P7VJsosnMyVOf
         bEgPOT+3Ve4MRPzG/HmO1SkRvw8sESpgh9nO77xW0/l6UaFI4AUqm4Pvw3oRU5OUqSk2
         cyXA==
X-Forwarded-Encrypted: i=1; AJvYcCV+bNYoebvw2+jLCclq4mJCkSGB7B55iClBjOKNYVSWUavXsOE5koum1Vr8ENwo6+jV3UNiyVWFv7rj0qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNjRubN/isc2B79En3MuVy+t/E2X2pe6kw1s4qb6lHHv29SNO
	gOYAFDFh9tzOxu0Ulk4sPfzFb7EDH2wDY7jx5hEqso46dwsHBKvCx1GqpOw4r89/OA==
X-Gm-Gg: ASbGncvxY0j+96Fwbd2VaHNnVEoqDprjAJv1nAfRvUw89JW5NZwaoyBJLJx0ewp3noM
	ioVEbiJ/SmTHD8wToMOtzD8YXs4iLn8rvVPEmuydKLwyraIGdpowYX+Ukb6JkUfMpJ5QvZTJCd7
	pOXAp4amfPvQvD6FhJrWrrJw7k9jjtILu3vzZaXd76cugkLqf33Vj14SkPwe0jOiE4DaRi1fb+Z
	PM37VWSO1Cb1EXTt4uPqlPfAN3/KQPBHYNVEx3bya10D66tfr3Wp0gO9xCFjrtpzrm02ADLT2ra
	TEu5U2//yA0X2OjkqBdUAF4Br+iKUQfZl7Q4AXXfuSqV2WxoZ+X3WSfy5f9wFiY4zA9tsUkMsOr
	gvQjaaGP0wWlVVDng4ujtvS/4GQOOyYcIuvziJw8hCN7eOgHDp9gDwq1sSw==
X-Google-Smtp-Source: AGHT+IENn9KRBXLlUDYf/W80abgdynUrbIykjoaWTtbpQkehSN3ONHZRp3PyECxAzPSapU8TzEg2eA==
X-Received: by 2002:a17:90b:3ec3:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-31c2fce1e72mr66728a91.11.1752008102930;
        Tue, 08 Jul 2025 13:55:02 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:f0a:1e62:5952:b993? ([2a00:79e0:2e14:7:f0a:1e62:5952:b993])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21edab71sm3042106a91.43.2025.07.08.13.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 13:55:02 -0700 (PDT)
Message-ID: <ab6c4132-a0c5-4143-b265-a9979a171646@google.com>
Date: Tue, 8 Jul 2025 13:55:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
 <20250514194249.GA2881453-robh@kernel.org>
 <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
 <z2wrzts6cgunxs5tc764izvrfi4i2d637zpt6tj5f4piry6j66@cke2yxhih6dg>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <z2wrzts6cgunxs5tc764izvrfi4i2d637zpt6tj5f4piry6j66@cke2yxhih6dg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 6/23/25 3:08 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, May 20, 2025 at 01:10:25PM -0700, Amit Sunil Dhamne wrote:
>> Hi Rob,
>>
>> Thanks for your response!
>>
>> On 5/14/25 12:42 PM, Rob Herring wrote:
>>> On Wed, May 07, 2025 at 06:00:22PM -0700, Amit Sunil Dhamne wrote:
>>>> Extend ports property to model power lines going between connector to
>>>> charger or battery/batteries. As an example, connector VBUS can supply
>>>> power in & out of the battery for a DRP.
>>>>
>>>> Additionally, add ports property to maxim,max33359 controller example.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>> ---
>>>>   .../bindings/connector/usb-connector.yaml          | 20 +++++++++++------
>>>>   .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 ++++++++++++++++++++++
>>>>   2 files changed, 38 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece8b0c1e831d04d51eb7 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> @@ -181,16 +181,16 @@ properties:
>>>>   
>>>>     port:
>>>>       $ref: /schemas/graph.yaml#/properties/port
>>>> -    description: OF graph bindings modeling a data bus to the connector, e.g.
>>>> -      there is a single High Speed (HS) port present in this connector. If there
>>>> -      is more than one bus (several port, with 'reg' property), they can be grouped
>>>> -      under 'ports'.
>>>> +    description: OF graph binding to model a logical connection between a device
>>>> +      and connector. This connection may represent a data bus or power line. For
>>>> +      e.g. a High Speed (HS) data port present in this connector or VBUS line.
>>>> +      If there is more than one connection (several port, with 'reg' property),
>>>> +      they can be grouped under 'ports'.
>>> 'port' and 'port@0' are equivalent. So you can't be changing its
>>> definition.
>> Noted!
>>
>>
>>> I'm not sure showing a power connection with the graph is the right
>>> approach.
>> I want to provide some more context and rationale behind using this design.
>>
>>  From a hardware perspective:
>>
>> The max77759/max33359 IC has Type-C port controller, charger, fuel gauge
>> (FG) ICs. The Vbus from the connector goes to/from the TCPC and connects
>> with the charger IP via circuitry & from there on to the battery. The FG
>> is connected to the battery in parallel. As it can be seen that while
>> these IPs are interconnected, there's no direct connection of the fuel
>> gauge & the connector.
>>
>> For this feature, I am interested in getting the reference to the FG. As
>> per graph description: "...These common bindings do not contain any
>> information about the direction or type of the connections, they just
>> map their existence." This works for my case because I just want the
>> connector to be aware of the Fuel gauge device without imposing a
>> specific directionality in terms of power supplier/supplied. This is
>> also the reason why I didn't use
>> "/schemas/power/supply/power-supply.yaml#power-supplies" binding.
>>
>>> We have a binding for that already with the regulator binding.
>> I haven't explored the option of using regulator bindings. But in my
>> case I am interested in fuel gauge and unfortunately, they're modeled as
>> power_supply devices.
>  From hardware point of view there is no direct connection at all
> between the fuel gauge and the connector. The usual hardware
> connection is
>
> connector -> charger -> battery
>
> With the charger potentially supporting reverse operation to provide
> energy from the battery to the connector (with "battery" I assume
> a "smart" battery, so the raw cells and some kind of fuel gauge).
>
> Thus the following example should properly document the hardware
> connections:
>
> ---------------------------------------
> typec-connector {
>      /* ... */
> };
>
> charger {
>      /* ... */
>      power-supplies = <&connector>;
> };
>
> fuel-gauge {
>      /* ... */
>      power-supplies = <&charger>;
> };
> ---------------------------------------

The hardware description is unambiguous for single power role Type-C 
devices such as Sink only & Source only device (demonstrated by 
inverting the relationship given in the above example).

For DRP power role, the above relationship feels semantically incorrect 
because the illustrated relationship would not hold if the Type-C device 
is Source for a given Type-C connection lifecycle.

I'll add a note somewhere mentioning that for DRP, the relationship can 
be demonstrated either like a sink or source to make it less ambiguous.


> It means instead of the direct graph lookup for the fuel gauge,
> you would need a function walking through the graph build by the
> power-supplies phandles. But it also means that the DT properly
> describes the hardware instead of adding random graph connections.

Okay, will follow this approach.

Thanks,

Amit


>
> Greetings,
>
> -- Sebastian
>
>>> Perhaps the connector needs to be a supply. It's already using that
>>> binding in the supplying power to the connector case.
>> Want to clarify, in this case you mean
>> /schemas/regulator/regulator.yaml#*-supply$ right?
>>
>> Adding to my response above, the reason I don't want to impose a
>> directionality in terms of supplier/supplied is that in case of USB Dual
>> Role Port they're dynamic i.e., when USB is source, the power is
>> supplied out of the battery (battery/FG will be supplier) and in case
>> USB is sink, battery is supplied power. Whether the connector port is in
>> source or sink role is determined on a connection to connection basis.
>> Also, the knowledge of the supply direction is of no consequence for
>> this feature.
>>
>>
>> Please let me know what you think.
>>
>> Thanks,
>>
>> Amit
>>
>>
>>> Rob

