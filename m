Return-Path: <linux-kernel+bounces-824003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06235B87E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B658A7BDA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24A24503B;
	Fri, 19 Sep 2025 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="AlSQjsVR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EF34BA4C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758259046; cv=none; b=csA8PXuTrNd7C+bohdrke9oOKII2Q42QFwE2190hTnAxVsuRaohVRxZMuECva2LOpNs7UMligwaR7fWyme2YvUXjgzSqxsG1ineImSjAOvMhzvIChjLTkxwmnrmF+MKbRqalHGy71gMzjNkbn00tJJ/dMCdb6kDEI+qZE3lPsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758259046; c=relaxed/simple;
	bh=EZeFYhh1s/slE/NhUd0ih1yYs7P7R5PCqpNBEne42DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRiZ1PM4kel4WS+FI+PK5zxXyRGMwt3RL6cAFl/p2MVHVdh0TyANK7QpLo1WSDKoyvYIRcYqeK9lfGlOLJR0RMqkCvUDS+3DPydkQU4QoiUc37k/tN+lyS4Uw+tXdXCWc7Ectz0nGJpkOIFzWg7nJgMjDv+FVxhJKuPBvj9bH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=AlSQjsVR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244582738b5so14626205ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1758259044; x=1758863844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdKrSrX6fK3CR10Z72CzCwGMStRflCNffczK0WHUj64=;
        b=AlSQjsVRcub5wQY7KDOKhwDndu4haeTBT92hMtyP32z3iPwnaziqkXln4+S6mMvA8H
         xYy7TPBXvO3n1FaM3MseWTvK+EpykGHVjkfR3uIYoFhtmhr19Kq04iurbAB6me7HjKz8
         yAjs4yac6sRHCYrKrJva5rWOjwO6QKc8Zqx+ErHOL7npxjObNmCTW9L1Bdeep9pk4EF4
         WCYWJcxV2ur5Dpcflsdr0hTedmw0zM4EEOaBImS9LovPCv7Zq37JKJ9m60vLOahWyWDv
         b1qviI9d9IQreCxrSoYkZEJn2bUdenK/A3p8NlMVsw088GQBT2FEJCCO5rJNRk9UXf+u
         fvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758259044; x=1758863844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdKrSrX6fK3CR10Z72CzCwGMStRflCNffczK0WHUj64=;
        b=woJQlAx3n61HLr+uGmFoep656XSqTU2r9LqT5PFr265SlBGBfF/SQlBtjM4gV/2tYr
         fYDJY8fFoWHogh70rzdE2o/7RN/jZ1bSN/hPp90oyZi3O/0+2yjPLe7WzP/EFiFX3OM6
         C1Hp/UecAhhlIKa+1E93z9Bi5j4Hh8RQ4KFHOnxF0mJ8DsEYWF5gbGBIxviBZsdpIqXt
         Nl7XpnlYWatDfg+pVsKQe5y6tUjB5C98jYPgrUTW6n+6KWtoOLeS5frMC2hCQOhMI6hM
         If9BCVNVn4k6F8z7Bpo5cw1vnzVVATXRDq7TeLaGl4J2Jv36eeSMa19aRGalwGdMOjLi
         kU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnzKZQxqm8BmqRAOPxiWbChCOl79QkeIhm3OkauS6MKDvMTyLh7LdE2szrJrZAC+23k3s3F7huzjaGtzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJaKCAW8v2gpVVRPLeGXYWSfRwaj13W1bvX9y7vsXAbPrfPaCO
	rEff5l+TKpHW0LR6aevJ5uU4jhK3MbfJw4PjKwouHsQEhMKvZy/Qwkq8apcuRUlt1A==
X-Gm-Gg: ASbGncuU/xTgKArgBvVFp81qj8Kg89v3b79rAtGUhQnLq3x8xG4yzDYHR+UG5rBx1ar
	aABolViiEukPbLY/X2WnbtscROJ1HtLZDxKS+VwYvbkQOWygcGJCkXYYB8l1LGBuobGJy2jsVUa
	XlYepvmfBQ2DjhjX6QAwf1MPvexKo85gfLcRXPD99g28HNK9629ws1wpSPdko3GX8jt4TCEZUZP
	dL9N0hzqqZVYiXNnPVUUDJlMmrWf+SeneZfu5zJUzztvS0hatIzmRyxrjUDrRw0VNZbAgKUPceu
	RhWjicEbD1hpYBrOrrTfEutq7XQyqnCHi9P2A1ms3eoKEFtOUn7X//oWgGSeWEiGowbuovyC62d
	VmQH+5LzAdnilDFkwagZu0jB2hhSv7mn6yhTZ5eSG22F1ofHSfPoZXcZiQKFuTipS1bNQD2bmbu
	5H
X-Google-Smtp-Source: AGHT+IGkvxFYHxkGXpeT//5oJuV1y18NezXVSW9KRlZrhxJ0ImH5oALPdyQ6KyrjRMS8peG+GjscWg==
X-Received: by 2002:a17:903:1b6c:b0:261:1521:17a8 with SMTP id d9443c01a7336-269ba43dfffmr32113255ad.16.1758259044049;
        Thu, 18 Sep 2025 22:17:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c80:92ed:c309:825f:d615:98a4? ([2401:4900:1c80:92ed:c309:825f:d615:98a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607eac4esm4196477a91.21.2025.09.18.22.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 22:17:23 -0700 (PDT)
Message-ID: <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
Date: Fri, 19 Sep 2025 10:47:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Device tree representation of (hotplug) connectors: discussion at
 ELCE
To: David Gibson <david@gibson.dropbear.id.au>,
 Herve Codina <herve.codina@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Andrew Davis <afd@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org,
 Jason Kridner <jkridner@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <aL5dNtzwiinq_geg@zatzit> <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit> <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit> <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit> <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit> <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <aMzhgDYOuG4qNcc0@zatzit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 10:22, David Gibson wrote:

> On Thu, Sep 18, 2025 at 09:44:09AM +0200, Herve Codina wrote:
>> Hi David,
>>
>> On Thu, 18 Sep 2025 13:16:32 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>> ...
>>
>>>>> Thoughts above suggest a different direction, but here's what I was
>>>>> thinking before:
>>>>>
>>>>> base board:
>>>>>
>>>>> 	connector {
>>>>> 		/export/ "i2c" &i2c0;
>>>>> 	};
>>>>>
>>>>> addon:
>>>>> 	eeprom@10 {
>>>>> 		compatible = "foo,eeprom";
>>>>> 		bus-reg = <&i2c 0x10>;
>>>>> 	}
>>>>>
>>>>> Or, if the addon had multiple i2c devices, maybe something like:
>>>>>
>>>>> 	board-i2c {
>>>>> 		compatible = "i2c-simple-bridge";
>>>>> 		bus-ranges = <&i2c 0 0x3ff>; /* Whole addr space */
>>>>> 		eeprom@10 {
>>>>> 			compatible = "foo,eeprom";
>>>>> 			reg = <0x10>;
>>>>> 		}
>>>>> 		widget@20 {
>>>>> 			compatible = "vendor,widget";
>>>>> 			reg = <0x20>;
>>>>> 		}
>>>>> 	}
>>>>>
>>>>> Writing that, I realise I2C introduces some complications for this.
>>>>> Because it has #size-cells = <0>, ranges doesn't really work (without
>>>>> listing every single address to be translated).  Likewise, because we
>>>>> always need the parent bus phandle, we can't use the trick of an empty
>>>>> 'ranges' to mean an identity mapping.
>>>>>
>>>>> We could invent encodings to address those, but given the addon with
>>>>> multiple connectors case provides another incentive for a single
>>>>> connector to allow adding nodes in multiple (but strictly enumerated)
>>>>> places in the base device tree provides a better approach.
>>>> and the "place in base device tree" is the goal of the extension bus.
>>>>
>>>> The strict enumeration of nodes enumerated is done by two means:
>>>>   - extension busses at connector level
>>>>     Those extensions are described as connector sub-nodes.
>>>>     The addon DT can only add nodes in those sub-nodes to describe devices
>>>>     connected to the relared extension bus.
>>>>   - export symbols
>>>>     An addon DT can only use symbols exported to reference symbols outside
>>>>     the addon DT itself.
>>>>
>>>> Can I assume that bus extensions we proposed (i2c-bus-extension and
>>>> spi-bus-extension) could be a correct solution ?
>>> Maybe?  I prefer the idea of a universal mechanism, not one that's
>>> defined per-bus-type.
>>>
>>>
>>> Also, IIUC the way bus extension operates is a bit different - nodes
>>> would be "physically" added under the bus extension node, but treated
>>> logically as if they go under the main bus.  What I'm proposing here
>>> is something at the actualy overlay application layer that allows
>>> nodes to be added to different parts of the base device tree - so you
>>> could add your i2c device under the main i2c bus.
>> I think we should avoid this kind of node dispatching here and there in
>> the base DT.
> Until I saw Geert's multi-connector case, I would have agreed.  That
> case makes me thing differently: in order to support that case we
> already have to handle adding information in multiple places (under
> all of the connectors the addon uses).  Given we have to handle that
> anyway, I wonder if it makes more sense to lean into that, and allow
> updates to multiple (strictly enumerated) places.

Well, I don't love this idea. Here are my main qalms about the approach 
of adding devices directly to the actual i2c/spi etc nodes.

1. In boards with multiple connectors, they sometimes share the same 
i2c. Now assume that someone decided to connect the same i2c device to 
both the connectors. If we are using something like bus extension, while 
the node would be added, it will fail in the registration since you 
cannot add the same address device a second time. However, if we are 
adding the device directly to the `main_i2c`, the overlay application 
will just end up modifying the exact same device node. There is no 
error, or even a 2nd device node in this case. It is just lost.

2. How well will overlay adding and removing work when the same tree 
nodes are modified by multiple connectors? I have not looked at the 
internals of overlay resolution so not sure, but I don't want dynamic 
addition and removal of devices in independent connectors to somehow 
become coupled.

>> We work on decoupling busses wired to a connector and dispatching nodes
>> looks like this decoupling is ignored.
> I don't really follow what you're saying here.
>
>> IMHO, keeping devices available on an addon board as nodes under the
>> connector is a real hardware representation.
> It's *a* real hardware representation, but it's not the only real
> hardware representation.  Placing the new nodes under connectors
> prioritises the physical connections.  Placing them under various
> nodes on the base board prioritises the logical-bus connections.  I'd
> argue that the latter is slightly more important, since the primary
> consumer of the device tree is the OS, to which the logical
> connections are usually more important.
>
> But in any case, real hardware isn't necessarily a tree, so we have to
> compromise somewhere.
>
>> Also, at runtime, once an addon board DT is applied, when you look at
>> your current DT either using /proc/device-tree or some links such as
>> /sys/bus/devices/.../of_node, the connector and extension bus appear
>> and clearly identify devices behind the connector.
> That's certainly nice, but we already lose this in the multi-connector
> case, so I don't think it can be a hard requirement.
>
>>> That approach does complicate removal, but its not as bad as overlays
>>> at the moment, because a) it could be limited to adding new nodes, not
>>> modifying existing ones and b) the connector would specify exactly the
>>> places that additions are allowed.
>> I think bus extensions comply with a) and b).
> Bus extensions aren't directly relevant to (a) and (b) - those are
> about the actual overlay/addon application mechanism.  Bus extensions
> are one of several possible approaches to allowing a more restrictive
> (and therefore manageable) way of dynamically updating the dt, while
> still being able to represent multi-bus devices.
>
>> Yes, bus extensions need to be handled per-bus types but they have the
>> advantage of keeping the hardware reality well described and visible at
>> runtime in term of "wiring" topology.
>>
>> Whatever the solution, this will already be handled per-bus types.
>> Only busses that support runtime DT node addition/removal (OF_RECONFIG_*
>> notifications in the kernel implementation) will support adding or
>> removing nodes.
> First, I don't see that the implementation need affect the spec here.
> Second, bus-reg has possible applications even if there isn't dynamic
> reconfiguration.
>> Your approach is more complex, dispatch node here and there and actually
>> is also a per-bus types solution.
> Again, I don't follow you.
>
>> I think, in order to choose between both solutions, the main question is:
>> Do we want to dispatch nodes provided by an addon DT everywhere in the base
>> DT ?
>>
>> IMHO, the answer is no.
> Everywhere, no, absolutely not.  That's one of the things that's awful
> about the current overlay mechanism.
>
> Multiple places - as specified by the base board / connector, maybe.


Best Regards,

Ayush Singh


